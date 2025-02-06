Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A02253F6
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738836878; cv=none; b=aE2H1oqSNvoidV4d/GzSN3LdtKD445GyPETGIGP4/msMycfVc2BnmH4oWiC+mWXocSf6f4Pe9q07wdyy60AoAX3rF3XBywHELZgoOehJqgQqhrkAjlE9sNt1KIWO8shGZSdlu017lbKBaKFOj8mlaHCL2BOsocInRgCNVwejJWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738836878; c=relaxed/simple;
	bh=r0O64bwvcVAUgRPGPW6Fzkao9zYMJab3NnliUERAjQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKBOs9Lz56dtfgB5sA0TmpRmUFIu8rtCGnKy5kUGQipuQn+IfcxWEbneMcRho3pDlDkc0paQobX3BLG4+pw1WxkadawvADK0ZXu47R9ZtJlhsyiyXYhVtpkyFgTrFGIz5JIGajaXKDz32Y0dB+j6fFo0roeeEOAksCt/fZX5IFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBU/cEl5; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBU/cEl5"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-306007227d3so6878981fa.0
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 02:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738836875; x=1739441675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0O64bwvcVAUgRPGPW6Fzkao9zYMJab3NnliUERAjQE=;
        b=lBU/cEl5wRZR6pZ/KAwVA0+K7PeyLWveuYKbfBGW4pP3L39cw8KXrtGgVLmYkLtc+M
         h4luvxGoGHupig2vpgz7S9DlpaVVK158ct4dvd3CEWcSdBevwT3STYxREK6O7fHYBuvq
         EqM+yQAhzHrPE5RuushZMPxbFXeT1LcbCXVd1T5Gaxj7/YqRs1Pe5OvUxm7xYorS06uW
         bCyLhg/9NYBaPM+OiJdTAoalvvexQjIuneLRfMW4Ec0fj7gnfqisfsWH4dcG5qulJ9Ip
         8xbwrwgkxP5tk0hX3QJbjq7qdveSu6i9iorBWy7leBkYc+8aPCMMi9TwKG6tYpspylA6
         LDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738836875; x=1739441675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0O64bwvcVAUgRPGPW6Fzkao9zYMJab3NnliUERAjQE=;
        b=nWxAg/c/5Rhs4wenkyvb9yyYCQzUI50lGw5k3gX/zKb5zElIRBN91parqp2Cvm2QPO
         ngifb11u0TpnQtiLtjP3eXrnK4Nr56gEI+FGR4rcWgWK3S2KF3Z3btc9hC5Nm4fBGeM7
         EYA7NICOEYqGNrb2iUr2A9ahzIPlicQZNQitHmBt8HXKxv2udaSi+TEhn631uk9SNxEH
         9/W9f8QhDnc1ogG7oZR+hOnwK7B/iVCOFfVQCOe9Nf4clbaWHiKZM/TLkOc6bYz0fdIp
         wSKzhgyF4QGIJ19jjx5lXddy/0lOpvlE9l4cvGwwT8KHGp5xMbrK04DwL1q12BZ9h4XA
         fiww==
X-Gm-Message-State: AOJu0YzB25GvzjPuUPoU1Mv0RR2XAMJpQKVwr8tUhSuge/9gKchnBeYH
	7kMCI2Cm56jOBZTxR0F/p/GYsoRmBbMbj/Vr1cnoAad+Px1h6Vlg3YHlvBmi9wtcOJ7bfphzUWY
	19YEtUSSdSESC6b9/Tw+QIZeL/QXs520C
X-Gm-Gg: ASbGnctaOtkWHd9mEpKKsTaERmgVKCX2kl2TraBP26H8NgerYhR9i2bepcbNmWH7wMU
	yj/+RdiLjMlmhAxkOBT1rfWWvawR47Y4mzEDH0Uid6NxFm4YmM5chAFh2LeT3EmJ1I/A1Fo8HLS
	k=
X-Google-Smtp-Source: AGHT+IGF1wN0H/ALG4EULRAaikvcp0vo075GkeAz5qYvKRJodWeZjHaS3TkBvluoT4zBgIHbPnsg/QA9sWN+7nWHJT0=
X-Received: by 2002:a2e:b8ce:0:b0:306:10d6:28b3 with SMTP id
 38308e7fff4ca-307cf2f0ab0mr22043051fa.1.1738836874987; Thu, 06 Feb 2025
 02:14:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204041430.36035-1-meetsoni3017@gmail.com>
 <Z6HH8mWDpJUSHDd7@pks.im> <CAPhwyn094ySxG8=p3_jF+Z+0g6h4hL5ELBYhOLv+Th8zX04Urg@mail.gmail.com>
 <Z6IoZ1_1wGiOo4Bi@pks.im>
In-Reply-To: <Z6IoZ1_1wGiOo4Bi@pks.im>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Thu, 6 Feb 2025 15:44:23 +0530
X-Gm-Features: AWEUYZkbr_ANEqOjs5QNBgbYMI9afh_7mCVoSZ8igqH-pagPrIEELNBSl4DMh1A
Message-ID: <CAPhwyn1_tMtZzMeNY3LhHxaVyLaD=nhWk8d-YNPHFq5ouJU7Hw@mail.gmail.com>
Subject: Re: [GSoC][PATCH] remote: relocate valid_remote_name
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Feb 2025 at 20:17, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Feb 04, 2025 at 07:36:24PM +0530, Meet Soni wrote:
> > On Tue, 4 Feb 2025 at 13:25, Patrick Steinhardt <ps@pks.im> wrote:
> > > The change itself looks straight-forward to me. Did you happen to che=
ck
> > > whether this allows you to drop any includes for "refspec.h"?
> >
> > I think you mean refspec.c, as refspec.h doesn=E2=80=99t have includes.
> > Yeah, I did check -- no include drop found in refspec.c.
>
> Not quite -- I meant whether any other file that previously included
> "refspec.h" now doesn't have to anymore because the function declaration
> was moved.
Oh, I misunderstood. I checked again, but I didn't find any includes that
could be dropped.

Meet
