Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCAE37E313
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426752; cv=none; b=rx4GylkMTsSz3o9mJeIA8yvJ8tumuHKruDZrex+PoYDcJQkOqiHgy/pdAeXNFRTO0DZUODDiauPg+GwGicT5KaYJF49fjkpm+/KdKeKPOM/Eq3LF23g7CXLBSAzUVDIkiSOzfUNgQD4mSRVSaqATCGD6OxZCeBkc/AwtfdDNDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426752; c=relaxed/simple;
	bh=oiYRYdvGOIijSJpdcSlvZBoymMdq9Gt/jl7+RF4w8pQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=tBzqLzXr2h5/HZDftrFzKll4PCMhYfxkvca2NSV3SN5Zez7Oe0O+H6KgMe9DTUd2kXpZrJPvDWQMRqa8F+7HlQdP6Os34DBQHeFCA30LHVywaA68xH814Vgdyhd7DYvXWZymoAYhlpy1UuhSKjg8ImMjzC96Em8nEyWNSwB6Q68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD9cobeM; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD9cobeM"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-790884840baso2549197b3.0
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 13:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426725; x=1769031525; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDzJH0EFXJUila46Tmib76CgcYQVNSmz19/+uqg2C1E=;
        b=YD9cobeMyVz8Kl9igYIvN6sgPNK1wPgMwEMF70D0LBU09cykIgXOHNSPJIdZz2l6Do
         +FGJf0kyk7kI8Y05FrPqhNbcHyhNBIP7U6Pijr9rs2Vv3yHhm78kb6m3LjSmczqAeAiG
         p78FkRoh4u1s8Q+GLz4XkpHYb5kPHLIFOoNxbHSzJSZmavsUCCSq4oZl0JmuCuOOyIgr
         nTlxuvt+pMdN5RQjrpvfKm4z32dgUUijKNcm/z7D5qRsgthibwndD+EumRCNjeoKfozT
         uyJJiyQO5urRwv4PsEtZ/LLnPoPxpOsHCuoSz9pyWLbBMEZiKWIqZ6WGTdIogLXbDbFx
         X1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426725; x=1769031525;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HDzJH0EFXJUila46Tmib76CgcYQVNSmz19/+uqg2C1E=;
        b=J21H6ir06Ad9OQIydamcaVskiF8ckctKOsKy91zDbMC3Masmz+a4AYgmMoBt0hQu1q
         NQ/hAGifFNkpZBKuZ7mvl1bzU1UTLsHifXuHM6E9FBZ4jF5iJm744AWvA4DpiXtY8/Qx
         xkoDcu091WoVoE/9u91cXd+NznmH53LQ963zcmIsX3nnMldq58whNfjqI3eP67ZNYxYn
         pYXslmgeQ3dbAbwU9SvbqxDlE1O5uYXI+bAKdu+1bdy25ybtdaQkKMsm3ly3hb7b4J0t
         skUKFPgP066QdInogFtLbc4cbgVS7w6GrOVAF4ig79bPcKI4SLvar7zkLiYuVVQx3l+n
         GL/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhTwLWM+esfjXYfgOa6nTb/z0I9Cerf+H9jKxqwJbIzhBk/mctinv9Hb3AYbyVq3w4HZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhvb9vhWwoA+/Q2DPRpqSwZihPVCB8WEXcZIaXJjNlpqr/qpt
	hcScH3oBqm18V7QCB+o36fHNycjnnsqGE7/4mLnLI3O1NX/4CzEyeQCbaTrexA==
X-Gm-Gg: AY/fxX4lRFzpyJM7WrNLc2oh/fIShCz7gxHRT374GA+HfGbsQapaQnzVBdqjWZB6VGl
	ynmQtkXvBNECeI2TTVok5D+1Rox0Kq/WosYPafpdg/ZD7TU3V99pm+wqeSlkXUUpzXsh8/W01TJ
	yxd8jikAfSx/bvz9nve216bkhDSthSG2m9MEwEC3+7kZ8hahC9snL9Xjyo6slS3sbWVKH6exu2g
	OqdcAG2jZqYhgzZ3wKNo8lD+LjvMV8GUYPg95uHhcb5IwXyDeFFzhRSSBiCaY3SgG8yLAHsjSbY
	yq0b0V6H2PZvsS9F0yeYJxYNnIR7b4mHnwxEKGMFbxsQO7y2sj/QkCJr/O2/dQqLoeIs83AmlwX
	SoqIR+lqINbIyVyE1myDILjCTHxh32L5WMoYtBjrEkU4XLvnwZ2hDB3UhdRQbh8bBSwWYhRMrji
	wRex0jw2C2m/8KinT6Hrnze6G4wdOa1ql3bf1j2NLD/Sks2ybg896pvrBVPub+Xz4Ktjkj5ZZeD
	NUO/ORsN1wczSCxZe1M/bLaTry0
X-Received: by 2002:a05:690c:4681:b0:788:c22:1f0 with SMTP id 00721157ae682-793a3a82f01mr33200497b3.54.1768426724689;
        Wed, 14 Jan 2026 13:38:44 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:18f6:dd0a:cf21:e611])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa576e55sm94543347b3.18.2026.01.14.13.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 13:38:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Triangular workflow
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <20260114162427.GA885771@coredump.intra.peff.net>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org,
 gitgitgadget@gmail.com
Date: Wed, 14 Jan 2026 16:38:33 -0500
Message-Id: <4F632782-4B1C-452A-A64B-CA223D2C16B0@gmail.com>
References: <20260114162427.GA885771@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: iPhone Mail (21F90)


> Le 14 janv. 2026 =C3=A0 11:31, Jeff King <peff@peff.net> a =C3=A9crit :
>=20
>>> Yeah, though @{push} is usually not explicitly configured in the same
>>> way @{upstream} is, but rather a consequence of how push.default and
>>> remote.pushdefault interact. But it was added for exactly this kind of
>>> triangular workflow. I sometimes will do stuff like:
>>> git range-diff origin @{push} HEAD
>> I imagine the same thing could be achieved with
>>  origin/$(git rev-parse --abbrev-ref HEAD)
>=20
> Sure, but:
>=20
> 1. It is a lot shorter to type @{push}. ;)
>=20
> 2. Using @{push} works everywhere, even on my non-triangular repos,

Just so I=E2=80=99m clear, this is only with push.default=3Dcurrent, right? I=
 could never make @{push} work otherwise.=
