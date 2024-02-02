Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62A171C2
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873379; cv=none; b=G/oHcxCPopD1bdV1e5akmKyOqyK+UTD5mZUL1aMRgmm0mX/VvBM/ccDyZoe+ewdH6d79my0d7c6zZK8UrQOUO57ylALR/ixYwqjpdIIZwrPfHdLiAT293KdijhG2X6ftP+Is+O8m1qTZ5B8DXHo5swzqAfgKr6tMFD0To76ekmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873379; c=relaxed/simple;
	bh=hwzOJ8z2HA39A1H4rL0Gu59hvi4SD2iR6blk9aMrfNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzg6tFxGCoK1Q1AKwK2u+yyBgglbCwnAnSVkYo4xUZ9XJ6kvUwqdDBP34obduSMpzSmEkS4qxbQNzbggJ9Ck9gA1sMli4HoRJN1iu4apPCVIjuiq6WFHDACHZSaqwRFBP6exvPPNH1BNTRHJzQM1jybnF6MQ5egBOMPlYX42RHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WD06zt7x; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD06zt7x"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so2685207a12.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 03:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706873375; x=1707478175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rxki8dq+2yLHR9DXEa/i6Jo75xTu2fTc2C4mqa51xc=;
        b=WD06zt7xDNz9ulm3FJ7/uxZb3b4GiOZ3XtA5YU3c1ykcoMWdnUZ50eFGsC9HP4YRFM
         YbDWqdV6o8Xmzr+SKloS6T0WrnxToa6TNOiPR31IXDKR5M+BbVj1Ow/Pw8WeiyZXi8M8
         RQf1+tyWUGUvSMlHlbT2rwpo8+/87794Z1QEX/HKRJYD6QjnQXGQvfYTfvaxKBLorDAd
         LNnn0rGDN/csmEvRfqk+OjrNaHsTHnRW3Q+ajyXP5rPuIv43t353YM/tWj7t6W9ncynU
         FsLpuJtYazLsrrLy/OrzTJX5C19Ys1T/ZI8/p6RP96vyPR1erwS4DHeCJCiXv11I7iq8
         UCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706873375; x=1707478175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rxki8dq+2yLHR9DXEa/i6Jo75xTu2fTc2C4mqa51xc=;
        b=NkjlFbyPihJ18XgdTxFMNa2i+7YfzZIoNo+Lq38nkHuL/+li2a9BooiVuPx1Eu00tg
         bAeaHDp0X9SHxO8/rMvkg+OlNgA78ouWI4Qr6pPkzHjOm7G5RxS3KWlKpJFG39XF7nFf
         q0kPJsnO+Repotd0sn5hcvGWpSOalw1pAxCr0nfAi8kWwT6L979KpumzTTSK1VMCEp94
         WY4JH8iabe7q5icp2k1QPJSXPBg2kdsZwW8ACKJfPsQCyOHQGzyHpE6QsAvnMKGcUpRv
         lVF9uZMBzy/foKfeu17sMTrmRboHT2U+FmGSSboiAfw8wPNy1aKrS24ImXaWGSB5KN6e
         iGSg==
X-Gm-Message-State: AOJu0YwR9DEZV95i/WjGFkCn6jovWDtpNn8Ls3L4zw2wi2atkcIZ0PCk
	LabL6lhXw1XpmwUF0kOmy2TvN5jyLFEMdHRVBQzKQ+WB8yHz0OrfOg4ziosbYZ5kpCiuRnfUfC2
	4u8FEWbFFaVOJ4n+KymsSbkH6Hbo=
X-Google-Smtp-Source: AGHT+IHzimUU+mrwCoPDa4WvcvQ7a/Mcj10S63ZMoXM9s9RgUXOwDYrtYfzhlB77JUJQ0wy20H7IjUFbBkKGW1a+tpk=
X-Received: by 2002:aa7:d615:0:b0:55f:cec9:3a7e with SMTP id
 c21-20020aa7d615000000b0055fcec93a7emr1033896edr.0.1706873375408; Fri, 02 Feb
 2024 03:29:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201115809.1177064-1-christian.couder@gmail.com>
 <20240201115809.1177064-4-christian.couder@gmail.com> <xmqqil37yix1.fsf@gitster.g>
In-Reply-To: <xmqqil37yix1.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 2 Feb 2024 12:29:22 +0100
Message-ID: <CAP8UFD3Hfgud19y_K1bZOudkBE-ss1_SgWTRVkJ7gUbYJ400yQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rev-list: add --allow-missing-tips to be used with --missing=...
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>, Elijah Newren <newren@gmail.com>, 
	Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 10:27=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > When such a command is used to find the dependencies of some objects,
> > for example the dependencies of quarantined objects, it would be
> > better if the command would instead consider such missing objects,
> > especially commits, in the same way as other missing objects.
> >
> > If, for example `--missing=3Dprint` is used, it would be nice for some
> > use cases if the missing tips passed as arguments were reported in
> > the same way as other missing objects instead of the command just
> > failing.
> >
> > Let's introduce a new `--allow-missing-tips` option to make it work
> > like this.
>
> An obvious question is if this even needs to be a new option.  What
> are expected use cases where --missing=3Dprint without this option is
> beneficial?

I am not sure if such a case is really beneficial but some
people/script/forges might rely on an error from `git rev-list
--missing=3Dprint` to propagate back an error to some user interface.

> If there is no plausible use case, perhaps we can treat
> it as a mere bugfix to the existing --missing mechanism, especially
> given that support of commits in "--missing" itself is relatively
> a new thing.

`--missing=3D...` detecting missing commits is new, but it might have
been used to find missing blobs or trees for some time as it exists
since:

caf3827e2f (rev-list: add list-objects filtering support, 2017-11-21)

> If we can do this as a bugfix that is always on when --missing is
> used, then we do not have to worry about adding another tasteless
> loop outside the main command line parser, which is a huge upside
> ;-).

Even if I very much dislike the tasteless loops, I'd rather not risk
user regressions by changing how `git rev-list --missing=3D...` handles
errors in the commits it is passed as arguments. See my other message
responding to your previous comments about how I'd prefer we handle
this.
