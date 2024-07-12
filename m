Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A209B1BC3C
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720825492; cv=none; b=Kxeb/kyBMy+a9ccSRrv93X/D+SFUgXylHqTNHEPk2DK8BPHa+O808VrTDjteh3K9Qp0bLLq0hbsKZSU694M36vYhPvUq1mmh7EJ4dnVK7UOk97ZAUU+H+WUxWdhwTUVHOLsuqvrTGvRZgZyCQbKpcogyAHadPbPslJm3ZCoK0MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720825492; c=relaxed/simple;
	bh=s8lxR8Wi3WENU56SIB//U4A3B1vDFgt7hCUixyml1/Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=S3odKGzae80H3hCH70aYS/zvcu23h1u6jYAKrNHE16r2BsKCmM4BIz/0S4bEFL2ZqAismbkB++wQgqQBnusxB3omGAuUNeSqxPJzBxP/mJD+1WW+x7BELerRMkMFLIJYYCoWLi616cWhrl3lRwJXflRSaTZeZK0/4OHsyclBIJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ05XDds; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ05XDds"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70af0684c2bso1993004b3a.0
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 16:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720825491; x=1721430291; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGfJkHX12bDBWzEANwbqMC6vYYRz83LY7VC+eIEcKl8=;
        b=RJ05XDdsdZ3OFWWYssPovBLXqo4E2Cpx62m0SEEwcsUX3DjyBPU2fBgv9dro9zGCjh
         dOTropM28DHeK3twqfEbYRhfsLSGK/OtubJe9efy4Q6jKcueOUZ1Dh/6WRp4O5Tq2ybc
         yeINWKPrRLYgCommO7tVurkGdO8z4Of5zqySFTMT/x38eSOmlCsxZAindlgS/0GjMWHA
         aZ4JRPm8K9lUJC6UbCCDZp1J7PvlKoXEofRQqt1SuXNw+l1ciDqrC9hmMhUYwFjouPD9
         bS0fKL395AU0fn5s8pdKkmnq79M2lsQvdM9+xcIlJ3lvl/ZuIXj9vSTwvtdzUWCtxzzL
         In8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720825491; x=1721430291;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bGfJkHX12bDBWzEANwbqMC6vYYRz83LY7VC+eIEcKl8=;
        b=FJperE3G8+drdv+Z7WcPf3WD0UZh+mv/Fasma3nIK9JM1hYa2wBo9QxJUUiFyer0WD
         uBnJDmssKivqpL05i6IVMSCYVX3Kz2ZQVpilAeoCiEIFjnKE88xogH0avtnAUktS6Az1
         bvNa1mwtPoncu6UsUz17elrZ9ql1syQBXAyW/1mtlV38iZM3u8GJWuo1hOL37iLEdyoY
         rDSVS3zY9jADTIabtJB3NOCGi7U5vEG9c/ejI6x6HQxIkebHoPpQ+UvAFBVmw/NiFqFp
         alZLRsVs5L2wihdt3w0g0O+QKuttQokqMUqbkC7ahO0VBz7GRUNNCy4KBKnEo81f3SYP
         Vimw==
X-Gm-Message-State: AOJu0Yykm/EhpcP23F+gOtLOi2K9XTY7wVU2B0P9HL9Qz7tBDdIU98UW
	FnTph3CWNmkd4AC55QGCbui1PdZOzFUsjPNZmjhwA6x7GVSfs9OM
X-Google-Smtp-Source: AGHT+IHWFn6HT8POpZ2pTrm097vVVRjdumYhd3+DBFYvuCSsqsCb4JhbyVeXW6kRZ2uAZbYC/h9ndA==
X-Received: by 2002:a05:6a20:3945:b0:1c0:f2d9:a44a with SMTP id adf61e73a8af0-1c29821fb37mr14432848637.22.1720825490739;
        Fri, 12 Jul 2024 16:04:50 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd6da78fsm2068734a91.45.2024.07.12.16.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 16:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Jul 2024 04:34:46 +0530
Message-Id: <D2NXQ2WZFF24.1GVN7WUJ5PCHZ@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Johannes Schindelin via
 GitGitGadget" <gitgitgadget@gmail.com>
Cc: <git@vger.kernel.org>, "Johannes Schindelin"
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] cmake: fix build of `t-oidtree`
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
References: <pull.1761.git.1720816450344.gitgitgadget@gmail.com>
 <xmqqa5iml28j.fsf@gitster.g>
In-Reply-To: <xmqqa5iml28j.fsf@gitster.g>

Junio C Hamano <gitster@pobox.com> wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When the `oidtree` test helper was turned into a unit test, a new
> > `lib-oid` source file was added as dependency. This was only done in th=
e
> > Makefile so far, but also needs to be done in the CMake definition.
> >
> > This is a companion of ed548408723d (t/: migrate helper/test-oidtree.c
> > to unit-tests/t-oidtree.c, 2024-06-08).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     cmake: fix build of t-oidtree
> >    =20
> >     This is based on the gt/unit-test-oidtree branch.
> >    =20
> >     /cc "Ghanshyam Thakkar" shyamthakkar001@gmail.com
>
> The base topic has been merged last month during this cycle, so the
> fix must be merged down to the 'master' before the release. Will
> queue.

Changes look correct to me. I was not aware of the existance of
CMakeLists in the tree cause there was no mention of CMake support
in the docs about building git from source, but it was my mistake
for grepping for 'test-lib' in just the Makefile instead of project
wide. Apologies for the negligance and thanks for the patch.

