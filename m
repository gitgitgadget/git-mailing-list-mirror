Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9EA233707
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959440; cv=none; b=qIYpXUdxgQO9aPPuLIQKC8uKp5mwb9QPoFZFE7wPyPhxwpcYU1VkQfwBsj6eA+6rTJoAC4cSNw3ENwATbBabpRi1icSiIeX0Pnjz+a1B5CnA0RYV8js85f7cwDBRBQMHXqtrvOS2glObtBbq8XjPsIEJZ5haMICsa6Nztm+GyTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959440; c=relaxed/simple;
	bh=M0xmJ86zAvZkMtiSDQFyuJ8oqwOFd5d22joBqQvr9kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2llxwC4Rfrw+JwOVDDPhCA4Bs01QYIxNV3gNl6DCAujqihKyYulVBo5ZAmWou2HLuznTaK05LC8lpWjb9Ndt+bUF3fzC9DZminr8yuLHPu6jR4/USpxjBsC56s3pOQ8ldlptLqgloXUSw8LB+moGBPd7gy8MnHmFMbpq4rn00Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2buNAL8; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2buNAL8"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7d925ff60bso4085879276.2
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748959438; x=1749564238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3iAUcq8pMVb1lExICy+lUBMunl+GGioADtcjbt7eWmo=;
        b=U2buNAL8aKmLsKUQuThB2VOV9NLCr3Tg9QkPgUTEpYG2KIoc8MRXvq28OqS18giROu
         iXbllAc3vkZE8MFoKJ2sew64oinEUSnjhiRBqeK0bH5KlsV7gWtnqPgrlnCyfqdnqUgc
         Q8Nmv9o9GsWOub3GJfVje86W0LqAR+GANtJsm8sASFIZq/ov++mUixXj2hzbyTjR8BXd
         5oApqOyBwzRyVwX9Gc3dyNSeMJ2XGU/P8exQV2DArJLkOV0RvXXNdjIRif3hR1tuCXN2
         D9LB2rYrcQhVC68NVlVTgWNNTrExQLxrzKImKNLzN38x6mCPuOhDv46AlXJp9h5Vy7Sv
         zaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748959438; x=1749564238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3iAUcq8pMVb1lExICy+lUBMunl+GGioADtcjbt7eWmo=;
        b=s/4qp32FT78ne+AV+9J4Nz3lwBlQh7QCfXqsEg89ws5SrRS4ZCZP9jjQ7DAhBcV6DO
         hQudCU00LKIflpUWobyTJHj0nH/DwO+X84B2dLLWp67BK20V7IRbKc+E0a8qm+tjs6Lh
         FuhjRzCTsOJVvN4RHeVnc99XtH3IBpiD1g1FNSXg5gCkiy0CKSTmKrA5tX9Gu2DiPozq
         zQE67apOSmpiwO56oKuM4mZmjX8bSUHDaOty4DkJazVeHUd/ikgAAoHFOE2iZdt1sLKl
         CXq99lqLvfsXeVBvC0rS/nF7KMEV7xEkrh2GDSvoqlfUCYWwYia5UkOaFgR4FZ5PtVjo
         1OCw==
X-Gm-Message-State: AOJu0Yxyky79Z+W0ipAcbcBQ0syWhrg6DxaKOWLX3sJI/d80LNqPlTID
	J3DVJVpTrG+NBOGbr6cq4eUXTdgLEFIKv16keZFwwlyIem+m3g3oBXz/Iwb9y1qO/VXOSakxes6
	8T4hqYFlagnoJitftDWH77gWoa8N/BKDSrzMnIODZCg==
X-Gm-Gg: ASbGncuNghqChMDUgHPLrvr2wlv48b/ZF5fwPAeLJY85Z0DLwreDGO+M/vih8k8tpI0
	0kLIftEuDIfG7AB0LL4k5MXgnF+zhH00rekCEnR7Yr814mE3FwpH0psmxMue0PnPMdAR/nlv61I
	mBfZSr0Gy0w6Q4bUfqvTWfGf9pJXeHNr5qqA==
X-Google-Smtp-Source: AGHT+IH8aLiAlEOn8AZmfFN1tTrVkFuob3js0bUM9EnjOiU+ey0YtvydmoVGCG8MBic611OnT6dGOHKMcGHBFb2ESfw=
X-Received: by 2002:a05:6902:2b0d:b0:e7d:c56f:a871 with SMTP id
 3f1490d57ef6-e7ff5579b84mr20729754276.31.1748959437611; Tue, 03 Jun 2025
 07:03:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602122559.208780-1-kuforiji98@gmail.com> <20250602122559.208780-3-kuforiji98@gmail.com>
 <aD794N8AjBqw0N43@pks.im>
In-Reply-To: <aD794N8AjBqw0N43@pks.im>
From: Seyi Kuforiji <kuforiji98@gmail.com>
Date: Tue, 3 Jun 2025 15:03:45 +0100
X-Gm-Features: AX0GCFvw1JtJTQ00KLKaIWaUgtH0dDfUG3RbEZ0hhhP5FvluSZ4D4k76c9F83VA
Message-ID: <CAGedMtcaV5r-hVn_aPP=AVCV-Wx0uX-yPqcOijxJh+qTSDJXrA@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] t/unit-tests: convert reftable basics test to
 use clar test framework
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Jun 2025 at 14:51, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Mon, Jun 02, 2025 at 01:25:50PM +0100, Seyi Kuforiji wrote:
> > Adapt reftable basics test file to clar by using clar assertions
> > where necessary.Break up test edge case to improve modularity and
>
> Nit: missing space.
>
> > clarity.
> >
> > Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> > ---
> >  Makefile                         |   2 +-
> >  t/meson.build                    |   2 +-
> >  t/unit-tests/t-reftable-basics.c | 219 -----------------------------
> >  t/unit-tests/u-reftable-basics.c | 227 +++++++++++++++++++++++++++++++
> >  4 files changed, 229 insertions(+), 221 deletions(-)
> >  delete mode 100644 t/unit-tests/t-reftable-basics.c
> >  create mode 100644 t/unit-tests/u-reftable-basics.c
>
> Hm, these still show as deletion and addition :/ Did you try playing
> around with the creation factor? What is the exact command that you have
> used to generate these mails?
>
> Patrick

This was the only file that came out as a deletion and creation. Below
is the command I used:

`git format-patch -v3 --cover-letter --find-renames=20%
--range-diff=upstream/master..convert-reftable-clar-v2
upstream/master`

Thanks,
Seyi
