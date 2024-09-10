Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583CD19412D
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995585; cv=none; b=KkckXwxj5JvOUAXIU2rNddnLFnS9gt1Elcyx5qGwwi6Mz5mbBIvb+SV8WBs7nl1NTxivhv7VimnIhFgOw79jEc9Fc5rrOR+fGr1dBRWGQQ4+AlyVXfoHu9zOxMMhjUiz2vQhL9F3flDZjuRNxn5I/FCeZZ3lFghIHMRWjQNHD+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995585; c=relaxed/simple;
	bh=cvtxGx2eY9Eht7xLxehufcLFdLIupLD3DnFD7JQDC9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qm1g+q+JMiT44ZOTfiD5uOadfJ11GHdAatHji1Yz94lnfHABLGsgu0rbcEgHTxIvqnzs6nvEAop482/XVvAsdz7EeHODk6XX4ZdhZqyT3EwrYE2brMADFsUiSyf0ajLs+Ac0Mp+P/0OSCb7wUGwS+9BqMSot+0rKsXgJg0amIh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lDK/BpBy; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lDK/BpBy"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53661d95508so33383e87.1
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 12:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725995581; x=1726600381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AF+mzCmT0VSkr0+YOBeSyvGU2Ghuq3zHfQHWIxMiKSc=;
        b=lDK/BpBy5UCj/+BopL/KCtg52E0weaP1QKxQl5P73zUVk9fZoj0WLdajpM1w4th0X3
         n2coIONDtHs8he6wijL6yNyESOBsE7iRa1/kLpz7Mxr7NslOBXD0mksBIXCjz2NmrEXC
         wv9yAh9uqnjNfGtmpOYFjqs3JoVwhWYgxFhMy65RuqgW7S+PdoDY8UKtotPkXufgWRdU
         4XyJwREl0PFSDDlieGwjCQozbtzQ6QYyZfyY0agYoDmG/sOe/J3dgVbA9leMJ3f4ZoAk
         LwOqBlcxkeJ2TIjFbbFWz/M8n+hseLA6KOfWjcjrqk59ZWv0CTbbFrVINOwXEaUJSHhR
         rWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725995581; x=1726600381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AF+mzCmT0VSkr0+YOBeSyvGU2Ghuq3zHfQHWIxMiKSc=;
        b=q1/H9CRjaP+kTZHxRplDwIriVo5mleGGEPxo76RXl13siL9w8XhV6zmtYov/DYakL2
         PXZQwChMacqqCBnYXexshJTFnhkYpKGNgbBVhwK5O0tgBdSLXYSs232/QzQwIANWMW2T
         xO5KoNrNnw7sZ91Hj6tL97xuD0pq4ijCe1hf7kxvd3xxyS1+2XOXygTB2hT6EFWUO0SU
         xf/qxg8o5XkYXeR0J7bSB3uMOg8ZWFz0bun9zlNgC1JJgHM0lZAi3WKXGhlmmdavvk9/
         mZ62wH/uxDcEUX8QWUuali8qb73RT82jRVwadQeWsFIY0DjOI1z9BiWN98X1fRfZNW1k
         j38Q==
X-Gm-Message-State: AOJu0YzUVeXWzgt+N54lNiQQMd31IgnACOmePGoc8oE/uAqneHNF3k0W
	s53b5A6cG3kRNOyC2M5Md42COi7RxO0bavqawZ+k0TwPm4SFhTGcXN5Bq0QeQ9isyuXuH6IK0uq
	iYFaBc+HCwIFFuNbHN7ZZwZZzGKBszs0zHf4U
X-Google-Smtp-Source: AGHT+IED4hRYgpewBJLYwa09LGP8SO6RxE1vQL4fGbknoXz8M4hnLLjAkCCiVZQHOJq2rogMTa/97WCnd9V/EJrGhZU=
X-Received: by 2002:a05:6512:b85:b0:535:68b2:9589 with SMTP id
 2adb3069b0e04-5367431fdeemr74935e87.2.1725995581052; Tue, 10 Sep 2024
 12:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906221853.257984-1-calvinwan@google.com> <20240906222116.270196-6-calvinwan@google.com>
 <m0seubo5q7.fsf@epic96565.epic.com>
In-Reply-To: <m0seubo5q7.fsf@epic96565.epic.com>
From: Calvin Wan <calvinwan@google.com>
Date: Tue, 10 Sep 2024 12:12:48 -0700
Message-ID: <CAFySSZBr8wEP=Ge-p1rpfP+4NEdyguvAnw9aGo1YBxY2k-ZUpg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] Makefile: add option to build and test libgit-rs
 and libgit-rs-sys
To: Sean Allred <allred.sean@gmail.com>
Cc: git@vger.kernel.org, steadmon@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, 
	gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 8:15=E2=80=AFAM Sean Allred <allred.sean@gmail.com> =
wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
> > Add libgitrs, libgitrs-sys, libgitrs-test, and libgitrs-sys-test target=
s
> > to their respective Makefiles so they can be built and tested without
> > having to run cargo build/test.
>
> I feel like clippy should be run as part of these somehow, but I'm not
> sure where.
>
> > +libgitrs-sys:
> > +     $(QUIET)(\
> > +             cd contrib/libgit-rs/libgit-sys && \
> > +             cargo build \
> > +     )
> > +.PHONY: libgitrs
> > +libgitrs:
> > +     $(QUIET)(\
> > +             cd contrib/libgit-rs && \
> > +             cargo build \
> > +     )
>
> We should definitely be setting `RUSTFLAGS=3D-Dwarnings` as an analog to
> `-Wall` in the C world, no? These crates should build without warnings.
>
> Very excited to see this work; thank you for putting the time into it
> :-)
>
> --
> Sean Allred

Thanks for the suggestions! Will look into both for the next reroll.
