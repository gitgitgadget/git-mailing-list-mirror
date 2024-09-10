Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663341ABEDC
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985995; cv=none; b=MPWzLLrnu8RB5ThbIZmegiRYrFeEuydgcY6I41S2Z+ZtJbT/GSNsxDj21ihrSjH+8QKdXscQjuTUxdH9g+8qtz+9kHBzUQORzjCo+Aq4jkpyQvRWS6JQlQF+ks6WGSiK/b8MbTBFy9SJ1l0NR1RgV004+//8Z/L/TuIZi4BFW9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985995; c=relaxed/simple;
	bh=phd55bqKN5DVXxXfF2Umxb20D3HQRMXxIrhs/46UK/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFvCo/I1+pixIBwC9hXMPW6dFJt9wSIWvkQe2VjtXGAHbI2md41/fKa5wGnvQRDIEzAFfYfST5whm1yOrhOZRiGz5df4yJq8lBLo+av6pyEVHFuuaudpF5nCfulsmAV80GiW7kKywBBqgG05EPiscQT5CMV4UJQxwd9Miiw4jFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDwUUHlW; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDwUUHlW"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c3c3b63135so6208992a12.3
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 09:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725985992; x=1726590792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVo99Q3pV3aeVOhi0VxFq3P4tTkOFGvM2Dm+fipW+9c=;
        b=LDwUUHlW/qis6rr319+yUJepfkXpin5Enb0Tla4lkFJ2V72U/N1jM/jgh9fn9mZzLR
         ijhvDIdRepG36RDMBzCCO/uL2GHpxT8M1Y4nOp7Bg7WgxYuNG1tgKEA0C/BMdsYT9tBg
         ZRIYb9R9EZIEjVzqzLEZ34UsbO0/yXMzmzE6rWlKWvGHDgllwS8NBpg6KHIDKE1hpWrZ
         /pxwEeSbX4/DBJesLYd/4Z+1kP/ewS8+Qu09cLS717zE9pJ2DFHUrDgqlVQc+oOP9HIk
         tHVSyiPAnN2TDJ22yS72FSfHlYTCgSdliqK2JG/p24/CWJLimJgVMWfNJqIRqB/PA+yo
         zxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985992; x=1726590792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVo99Q3pV3aeVOhi0VxFq3P4tTkOFGvM2Dm+fipW+9c=;
        b=GJIkadtnbAQKvBQ/+6xZwG6u4gp19ZSR1GXnvaw6+pEAQthr3W1uxtiiepKFmK1f1e
         rLcEE0rUYQNYRtAL92xVJeDHPZI43rYxx0NJE6zXeC4KibDLOAciaTrBfWP9iDq1U0Zy
         0A9xxnnUj5KEPifw0Udk2D9Bs/AM2sagWBs/70Wi1jlLeNVKCkr2HPAOZFgOWa55nVWH
         d4o9qyVLGlnBZuoSgRwnpQMQLtSscnvvLoFX0A9aoFvrfjH/gkK5kpJ51eamB0F/RMJq
         DR6lBSJcqgPFMjK+MVxBC8Rkv43/K9rhVmPQASdQyX6MMmroi7NXLcAziPYaoyVybBfP
         zQdg==
X-Gm-Message-State: AOJu0YxpD5P5tZbpGPnebo7BzQ3shLcYVYr1tew1/2577Bj2kp2hN6P+
	b3EsUN10x17zxoqtj8dZgvjv+9Yb1RRsFlk4IcLSyuYVKFkZKig9eVYdRMmKkFSZOloAMWRh0CD
	mrIlTBNhnvSdLymzyFsQ2wnTfr9A=
X-Google-Smtp-Source: AGHT+IGmexJ/p+a9T8w5FVo51qHPfYv32eVKJVqzR3z8tDAifPZld4tFA3ZDI2unMAygkSFabkWSUlFwVdZTVgVI+e0=
X-Received: by 2002:a05:6402:2546:b0:5c0:aad3:c8fc with SMTP id
 4fb4d7f45d1cf-5c3dc7c6994mr10521754a12.30.1725985991565; Tue, 10 Sep 2024
 09:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240731134014.2299361-5-christian.couder@gmail.com> <xmqqbk2d2yw8.fsf@gitster.g>
In-Reply-To: <xmqqbk2d2yw8.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 10 Sep 2024 18:32:59 +0200
Message-ID: <CAP8UFD3sNTfUnzMAJ3xeqBhZbWStYn13ybKMMSdKWy=d4uCdgg@mail.gmail.com>
Subject: Re: [PATCH 4/4] promisor-remote: check advertised name or URL
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 8:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > A previous commit introduced a "promisor.acceptFromServer" configuratio=
n
> > variable with only "None" or "All" as valid values.
> >
> > Let's introduce "KnownName" and "KnownUrl" as valid values for this
> > configuration option to give more choice to a client about which
> > promisor remotes it might accept among those that the server advertised=
.
>
> A malicous server can swich name and url correspondence.  The URLs
> this repository uses to lazily fetch missing objects from are the
> only thing that matters, and it does not matter what name the server
> calls these URLs as, I am not sure what value, if any, KnownName has,
> other than adding a potential security hole.

In a corporate setup where clients and servers trust each other to not
switch names and URLs, it could be valuable to still have a bit of
control in a simple way, for example:
  - if servers use many promisor remotes, but clients should only use
a subset of them, or:
  - if the URLs used by clients should not be the same as the URLs
used by servers

In version 2, I have updated the "promisor.acceptFromServer"
documentation and the commit message of this patch to better explain
cases where the new "KnownName" and "KnownUrl" could be useful.

> > In case of "KnownUrl", the client will accept promisor remotes which
> > have both the same name and the same URL configured on the client as th=
e
> > name and URL advertised by the server.
>
> This makes sense, especially if we had updates to documents I
> suggested in my review of [3/4].  If the side effect of "accepting"
> a suggested promisor remote were to only use it as a promisor remote
> on this side, there is no reason to "accept" the same thing again,
> but because the main effect at the protocol level of "accepting" is
> to affect the behaviour of the server in such a way that it is now
> allowed to omit objects that are requested but would be available
> lazily from the promisor remotes in the response, we _do_ need to
> be able to respond with the promisor remotes we are willing to and
> have been using.

Yeah, it is better to let the server know.

> This iteration does not seem to have the true server side support to
> slim its response by omitting objects that are available elsewhere,

Yeah, in version 2, the commit message of patch 3/4 has been improved
to say that implementation of this case, which would require S to omit
in its response the objects available on X, is left for future
improvement.

> but I agree that it is a good approach to get the protocol support
> right.

Thanks.
