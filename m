Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0297F191F72
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 01:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025184; cv=none; b=lBjT84YuRLek11h8zeIvWnkyyC3uM9NkO9/6brtnm0qponii1Eq63l0zBxo2bZesV/NVSRIyqR80M7qYWsJXSAnRumWFGGAL25ji8remoEp3xtoWEB+lJCaZNCQXx/cgSVVPZuJq6Qf+N2Kk7eW/pr5duCno3NS7keTscIdKI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025184; c=relaxed/simple;
	bh=oNc6m+4t5h9oZpV1DU642cCWjVwlVKzhkHB66wZr9PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAnS8rF8SO5uRzLoVolcN1W/CUPEdJ/+8f0ZWGTkEEeH+ft/OIGqy4bE9YM46i4Mx3agKlZmNSSUJkJo/cVMKBqpWyMbaqRF7DgKQgjZuiqZYhXBfi3hyiJl21zt3MNyDmQE4ixYFGz8neHGIB0db6DZfnZwccRhyaD1O36p/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNmBQLww; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNmBQLww"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23636167b30so51059155ad.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 18:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752025181; x=1752629981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo2NxYWhpYuYhh+cmVyxvXloEpAnwmvlVT0XTGMWxfw=;
        b=CNmBQLww6ulA9+WIY5OQNRYyPROD1Bs6kDrcOhvLizspsKEZJypdQ0IBhZos3PwYkO
         ssp1wJmSURoBxherOxbn60UhcW4s10MUVoEx0mCavFJsdNfHP4X+QkxqkdbXYv+wCcc2
         LpcsQETDXpoWKYC1OPWjUyfynBdd7xsmfR1EKE18ZL5FjypDZWAi2lAOe+rTUsdRApoE
         CCy57f6KgrC8MGqEsHzcOtCurZ4jLvFbx6/z7gMo/KCZz3LdnOrAuOXXO2DKbPtBlJVG
         IepRUaawXcSk+O98xEHGlRxIsZAFMHAG679aoHhzS79qIj5BV1bGDyM6I6M/6O+y/G0l
         rvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752025181; x=1752629981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zo2NxYWhpYuYhh+cmVyxvXloEpAnwmvlVT0XTGMWxfw=;
        b=A+DXWgVNqttpgAbsGND9H187T2BtRKyXrlD3iKXPXK5aOa82Vc/SUb2AT8VIrpcVaY
         X4PVn03KC21iASXqy8V5BIK18zIG2nOAXz81JzzEMUvwebpWXKaJ/ftfZjfl4suamuOC
         vKwJU8oCcqAp2A4TiaIEk+aLIHTrFdRdtDkNt+xibasSQbPwcUvoknufFAtD+p22Q6aP
         lsml1TIq2aPLsLFkbpgEMftblTadtHm0bRt6EelKeWKO0CcAzc+IjDVyZYBgfile5+vT
         BCb6qYHqw7++L8pGwQlVeyNfCX4JOEWBbZbrG5+CcoRGbG0+e8I+yZOYS030s6oygdG+
         QMDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU04nVvA93Z8Qu9ZVjEYIEmzf609EFgx7kEGlIuC6fDzGzCKRSruOSUZ8HgIz+itEtsKN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZT7wBcSc2PMLP30gK/puCwDE88qedaMcI2v2wEIG8C4uHrSkp
	a4NkwX7LeXgSraEbSLRs/TXKgoPe+HRuhEC/5X/pHKNzKbq4fURYAHQiy9SXl5suZxHe3sBdgns
	Du2R8t1fJry3URlfqWluX1GSbKyiyrX/tTEEKMOfGKw==
X-Gm-Gg: ASbGnct7U73SDFrCsxCZ+eqfGJthqSf0yPlDgjjt5aPKahz9GU6t56SH3MxgVS7j9gj
	KYzR0+rmzOAkt3qnjqZ9abbIzp5ETWirwJq+Gm2F3DuJJqvWyMp6FDnhm09rRDgyk2GSRQk9RGD
	sFXZNu1CSKohzCgQQhP4PNn0m8ck8rOzHUi2KwyOn/4dmbEA7D0vVoiKtMtFCJMWhtCGGml0g0r
	dpUXQ==
X-Google-Smtp-Source: AGHT+IGikaq/0E6CG3Kc8nantyjEz9s9f7klHfao/JNBzyqV8GWrVkTruKV+WfVAQzqKR3G4PWrjKfNTWBdeXkwMSHw=
X-Received: by 2002:a17:902:f709:b0:234:d292:be72 with SMTP id
 d9443c01a7336-23ddb2f2b93mr10861775ad.26.1752025181141; Tue, 08 Jul 2025
 18:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
 <cover.1751309770.git.ayu.chandekar@gmail.com> <xmqqbjpuqkrj.fsf@gitster.g>
In-Reply-To: <xmqqbjpuqkrj.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Wed, 9 Jul 2025 07:09:29 +0530
X-Gm-Features: Ac12FXzZgeo82Wrc6zdoBn2Sh46OZnlG-E2qrcICHHBgBzlpoieUSayrd5JyoA8
Message-ID: <CAE7as+aTBTx8rZ467uv9QV5Wiqnyed5ndY-+smJ1ayYVx6qmRw@mail.gmail.com>
Subject: Re: [GSOC PATCH v5 0/3] environment: remove sparse-checkout related
 global variables
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, shyamthakkar001@gmail.com, 
	ps@pks.im, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, Jul 9, 2025 at 5:48=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Ayush Chandekar <ayu.chandekar@gmail.com> writes:
>
> > This patch series aims to remove global variables related to
> > sparse-checkout from the global scope and to remove the definition
> > '#define USE_THE_REPOSITORY_VARIABLE' from a few files.
>
> For this topic, it seems that the ball is in the author's court
> after a few review comments.  What's the status of it?
>
> If it is back-burnered for now, then we may eject the topic out of
> 'seen' to make room for a new topic that touches the same area with
> overlapping changes.
>
> Thanks.
>

Apologies for not keeping you updated. I had actually drafted a
response explaining that in 1/3, I only added two new calls to
`prepare_repo_settings()`. Some other calls were made in cmd_foo()
functions, and a few others were rearranged and removed as well. (I
should've made it clearer in the commit message). In fact, the commit
message mistaknely suggests that one extra call was added which wasn't
the case. For 2/3, only one new call was added. As for 3/3, I can move
the setting into the repo_settings struct, since
`prepare_repo_settings()` is already being called before the variable
is accessed.

At the time, I felt my draft wasn't convincinv enough, and then got
caught up with responses on other patch series and also was working on
another one.

You can eject this topic if you think another one is more important or
if this one still needs work.

Again, Sorry for not updating earlied, will do better next time.

Thanks,
Ayush
