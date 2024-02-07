Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B6525571
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299852; cv=none; b=oLdKBmp6605Ow6DdFdK9NFKnoGJqMeICvx0GEijlcDyFlMrUIffCegdjE4xTuAGALOyKHp2tiXLKHE95fK/NzHeI75Qbjr0j2D2c80b+67HpgYRbcXKAlt+5E2RuO+jKxgnO/Dqg7wvgzRLQHNbf7eEfDF3kDolBpvtudfdNaUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299852; c=relaxed/simple;
	bh=2htNHmtFcSAO4b/rwljkrlEX631p3pLilMmDGUmFkIM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RpgMtwbnQSmOTj5jXWqyDyBfQ5nbJ+j/0XpXclanHiy/jVsH2gJW9rUz6yRDTSDYDN8i0VWhFey/RxpsCLsH+TpbqJrR9E+X6QXtoYgq3ktZj3Fn+9W/8dIkUz44Mth7wmU4BCjwWavRFW1069cNTiNOPPdSkGYnLZf9TD89sGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nJLeAm4h; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nJLeAm4h"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so842492276.2
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 01:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707299850; x=1707904650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZBqnl12uQ+yStdFnCj0TFrNvjRPw52uo0xrJE1cvFo=;
        b=nJLeAm4h+bkgZAlmJrDCgCQkuzF9B5ysXogkvEoNzwJH15XTZDkHsQjelMJyWs0/5w
         nojmKXJfKDPfNVj6w3fVhdcWqquCd1q7QbvcT95mkpuPAax6BSRkYyvme8mfdb7r0oh6
         Kgouarp8bc0t7EiCl7P1QR3Ml0oeQfBdvK7c8P2yn35rQAJL8bxq7p8JzTeVw6ME5gAi
         Qgq04l/d+6Stc4qgDmD+a9eW8mqJLdYkhbJB63KZolPMSxk827HvQEjs7JlGteW6ZSCZ
         tjFkZFPwxD1CYgc9C28Dyzz/za0g+lJYu2vXb2crKblIWNol1ehZHWQgmYsUtEMGDKT6
         xt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707299850; x=1707904650;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AZBqnl12uQ+yStdFnCj0TFrNvjRPw52uo0xrJE1cvFo=;
        b=wFcQ5j+pogsM0sSF8Cy9qYLDLgds0IF6YwJzM8oa+QKdAJTlyxyaIUVMIqK4XFLxPc
         JAB9xRVb4sNbOydqbLX6F9kgMbDTt6JyetKo4u5fibZ7AxplEYfKjGoh5UnJbcji05x5
         F/EAA0K89kh6Lw1Hqzuc/t/1pqEIowH9YbWbEO6CsK5XkWX0ESVjI6zoqEupZy4qpZT6
         wZereTnYRoirTjhDYl0+VjJl9p03m6eifqviv9GocHdA9vSnyeYR5f6aNyo0AGq5XHot
         PgToHc5jdcaWZ5K4BPkD1WdwYMLbtdBY/2WaWZWsEYOWkcX1Uq2pnsz13EVD9spyym/O
         W00A==
X-Gm-Message-State: AOJu0YwTBz0HKxZ6Bei5vRoyq6MwcvuG5xy4Fycihw/WX++vfZHzqXB2
	H47D6k2V1QcGj2nT5RpuyjWQJXk2WekK4QuIQWolseesObHYMGqjEsSSjLUpIlwVd4Q5AN8gCam
	NBA==
X-Google-Smtp-Source: AGHT+IFPJ6X7W2pg4/yD3MULZOjOKk3yA68l3pPpcb3qT4W/fI0qmdFxbw0NXXg4tCEXbTO8WPh+ZinEm+w=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:15c4:b0:dc6:de8c:f4fb with SMTP id
 l4-20020a05690215c400b00dc6de8cf4fbmr1090559ybu.9.1707299850036; Wed, 07 Feb
 2024 01:57:30 -0800 (PST)
Date: Wed, 07 Feb 2024 01:57:28 -0800
In-Reply-To: <CAP8UFD3Hfgud19y_K1bZOudkBE-ss1_SgWTRVkJ7gUbYJ400yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201115809.1177064-1-christian.couder@gmail.com>
 <20240201115809.1177064-4-christian.couder@gmail.com> <xmqqil37yix1.fsf@gitster.g>
 <CAP8UFD3Hfgud19y_K1bZOudkBE-ss1_SgWTRVkJ7gUbYJ400yQ@mail.gmail.com>
Message-ID: <owlyttmkmwaf.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 3/3] rev-list: add --allow-missing-tips to be used with --missing=...
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>, Elijah Newren <newren@gmail.com>, 
	Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, Feb 1, 2024 at 10:27=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>> > When such a command is used to find the dependencies of some objects,
>> > for example the dependencies of quarantined objects, it would be
>> > better if the command would instead consider such missing objects,
>> > especially commits, in the same way as other missing objects.
>> >
>> > If, for example `--missing=3Dprint` is used, it would be nice for some
>> > use cases if the missing tips passed as arguments were reported in
>> > the same way as other missing objects instead of the command just
>> > failing.
>> >
>> > Let's introduce a new `--allow-missing-tips` option to make it work
>> > like this.
>>
>> An obvious question is if this even needs to be a new option.  What
>> are expected use cases where --missing=3Dprint without this option is
>> beneficial?
>
> I am not sure if such a case is really beneficial but some
> people/script/forges might rely on an error from `git rev-list
> --missing=3Dprint` to propagate back an error to some user interface.

I currently learn toward just making the new flag's behavior be absorved
into the existing "--missing=3D..." flag. Nevertheless, you raise an
interesting concern.

Perhaps a compromise would be to make "--missing=3D..." learn the new
behavior of this patch as Junio suggested, but to introduce a new flag,
something like "--fail-on-missing-tips" to fail early if any of the tip
commits' objects are missing? That way we could keep the current
"strict" behavior of complaining if we feed rev-list any tips whose
objects are missing. And for the vast majority of cases the
"--missing=3D..." flag could (intuitively) gracefully handle tips with
missing objects and you wouldn't have to pass in the additional flag.

IOW, make the minority (certainly not majority, I think?) of users who
really need the error propagation use the (new) extra flag, while the
rest of us (including the version of you who was surprised by the
limited behavior of "--missing=3D...", enough to write this series) don't
have to.

Thanks.
