Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9460A1DE4FB
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 00:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882901; cv=none; b=r6NMjJQxb/pAianGF//qc4u9dU7N2f04WiV18q8uD0uNZfq/Lm+hjaSSqhG/wi6+KuCazpwGLwjFToEpwXzKCdjqvC8pf1Pr2GvNeVlsAnjbTqbskyTT2aSzLjpq8zn/W2prX0uVNPHoyczobvMKssKfCnpbr3hBlFXFTkNptsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882901; c=relaxed/simple;
	bh=E5fQdNnUJZY/qdRTU9F31c6hcmJNexqVuVKAp10qFuw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ncLfyN8Rka/k5LHCCnC2sik7Gz8/E2zBlQdh7rmJNLiu3C10FVvNQtbF3fMudYLbIE0rQ9kST3S2pMtsB9Rnq9qCn1zlDdrIvyOoNakTX0yi5pOD9qRMBRjStbrPz+GyXrlFLezzWsv+kdpPHHdw3Q/MJJAA6aEH91AYRWKo5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HmpFAle2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hbg2aGXw; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HmpFAle2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hbg2aGXw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C04CF1D003DB;
	Tue,  7 Oct 2025 20:21:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 07 Oct 2025 20:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759882896; x=1759969296; bh=pdIwTkLnEZ
	x5K90Ql2nTpxCKQQAOw9cyD8nPSTAipQw=; b=HmpFAle2YHgEwzRW7kPxgcPa05
	R68ERtT2bkcB7hURE4gRlsmlEE6LqTfkPUWh4nxuQ3e1WUsTkJCJKMGxcTfXbO3Q
	nb7I8PWm/DyOn74+EW1SL0j5Eu+7j4jORNJmByjDtisJvY86ucbKhMulwO2iH8+I
	AOvReaAHKN1vlo+UfiaxOA4ZR+XK7aKyeII+p8JB1c8zrIB8Ui5zuKOcn1eLzhRv
	ABu9hKaEJvZG7Dm9tl+3Cslm7oBgTIDsmuNuOqvbCOBaawF2dDXAtBR80fEdUBrS
	dAKH766CI0dXUaA0C6CdxyYIWFR93iH8RUWgIgWfh3GFlfeTMry/jObnjCxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759882896; x=1759969296; bh=pdIwTkLnEZx5K90Ql2nTpxCKQQAOw9cyD8n
	PSTAipQw=; b=hbg2aGXwFcJoXxZNv3UAUEW7ESDo84N37ueqq7RPP2pet74nZbD
	f1R3YxgBxO34tmgHpitt1aET3eombKNZYYyZSfcXPddxfeAzofRFUYEllXeXgzKK
	IpEJr95IDC6PtD2vHb7+4y52LEY5YVaWWeQJYy/twN+rJh3dkBdxkOCVJNzdt3qv
	hZPl9QFY/7pFsxkyWV0LevI8XieNLODCnIkjvfYlaHmaV/hYgKb4yUittKTMiV2X
	3SmgZgBlmQ1/iilTW+U418vjHzBqyibYyA5aRaCjNp4tTD3/qI0lakjHLYuKZvj6
	jB9AaczR19y8vOic0XjGnhWBFN6Pwx7mkHg==
X-ME-Sender: <xms:kK7laEXRYr6feYf0ZiyTByTf3IqKkaU1iQTrZa398au9pOtCP18E0A>
    <xme:kK7laPnY4fz26q5_eyZvGVpu_Ob1I1qPr_cDuFIYoORj_Wx_zqA-vg6Plx0XJ68a8
    wVRPUW2bKKXN4xmkk18xp1mi-9KMdiVOXu4kSqr1FKBBvHph1BDd7g>
X-ME-Received: <xmr:kK7laNYlj_aXVhaI7A51SShMbt0I6ebMjQWlvvkLI8xC5gRCt6VcfHtAvYnAqaczIw5mxUky93Kv0b4wtwRS0GpZiRXtafVyY5uz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddukeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kK7laCNuWeWVGupiC4KIbdXMj-fFnJpJQe4SxbTulgEgOsZ9vUDFYg>
    <xmx:kK7laKaMjI-wJltgpw_wzwoSHDfKZ7NA8lvdGBwKFKknGuPsKzAYwg>
    <xmx:kK7laI1U01BcFav5gWchS4cCiSBt3HE5xn_uB-dTOz53Oh1Jv2iB6w>
    <xmx:kK7laIfB2AdIzNBQ7CvGIQHoCbuoO4BjUkBD0kneoUNpqKCHNyBC7w>
    <xmx:kK7laIygKAT7Zyfi1Jgi-Nj_tNiCdeZ_pEjOHGH-Ox-Alr96y0uVQIIe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 20:21:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/2] SubmittingPatches: guidance for topic names and
 multi-series efforts
In-Reply-To: <cover.1759873165.git.me@ttaylorr.com> (Taylor Blau's message of
	"Tue, 7 Oct 2025 17:39:34 -0400")
References: <cover.1759873165.git.me@ttaylorr.com>
Date: Tue, 07 Oct 2025 17:21:34 -0700
Message-ID: <xmqqv7kqgs4x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> (As an aside, we should consider whether or not the experiment started
> in d255105c99 (SubmittingPatches: release-notes entry experiment,
> 2024-03-25) can yet be declared a success, and if so, graduate it.)

Thanks.  I haven't seen this used very often, though.  Perhaps it
was a failed experiment that needs to be retracted?
