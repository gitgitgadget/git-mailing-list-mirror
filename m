Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A748A20D4F3
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738674492; cv=none; b=UwK+dL/YqHiuG1qJ1kHGPcd0U2wx9aW5zF5Qx/osuZ82fOx+n8kP2W2pH0jW8G1cJryHtOloKR/rl/1IWp7z3iD3ClFDcYm++vMm3htTRJCAHF1sNdEXM6B0T3WIP21BMkfVaYUpHa+TyG3cx5pBmAcu3/UVgaNGj03YbEIrRqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738674492; c=relaxed/simple;
	bh=GfMinSSfa37QWHXMiBjPmj1ztasbe1nBBgmF6EeTpNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gr9lbg4mwuWSlocj0G35z3UXZM9gGhKE2gkKozQOU99wma2t18TRZz0OUAkIXS6xGIk1NEha0w1eN4YOReBeeuWDDdLxxotNXgBtOYn+hRzkXLg8/84SKoULOY1xD7xiF8//9Wrqas8v8Y9kIKDe2DDOoA5TKMUk+A5nkiN4Jm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R7x91q0U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f/rA4NRR; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R7x91q0U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f/rA4NRR"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9F7C62540082;
	Tue,  4 Feb 2025 08:08:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 04 Feb 2025 08:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738674489; x=1738760889; bh=c1dO6NRFY9
	geFcl/101bT4NDn3+43Rv8dldmalEJYgw=; b=R7x91q0UthvhcKjFxT+NO8HKrX
	5HK4CZqXMZQV4P1Sb2SPTcf069tGsadF5rjlmUogxuPmm5hSMEKvPgVF+Bfxce/5
	5v0cUfS8InByjI2PFfInmVfTs31nRA1wuCNo8Ar9zyDf6LxDpvkCo6eqSzQ1qYTn
	jfiti0hC1blTd8+npGFSlmJUnSWIUBxayVW+BxFXv4htKQYZrqb5GMwtLDiAPVqm
	ZbrMcdbikfRrH9t+ExajDf0q3UrqiTtlyQ4wZb/RVE+4+07Uz5QVeplo2dxGH0eH
	2M+KTuTuR5AK/XANBdrtewGy8M3Mms4X0mHfPLN4fAyRuuvwYtUEvj27PtTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738674489; x=1738760889; bh=c1dO6NRFY9geFcl/101bT4NDn3+43Rv8dld
	malEJYgw=; b=f/rA4NRRh0Kkica2uAux/ShUPMSnvj5sM/lMGEsruVKek5wHwLg
	iTMPMiHHNbW2+jBOh3K+fJWoOUlLXTfg+3KzMqBXN65P5xg1ePedwgevytx51VD/
	QXorkkhpxluTfApn2oZnArjxtTug77mH+zY/PGXrJzhHuJXc8UxKT3K2I/pGmTKd
	nQqtndA+tiO57g8ITqY9BGwVA8gYKyqAv5zhHTf1jUfsr/Y+SeLFK12psr0KX1DA
	hWB3+E4BmNwVnaKaFj4MalcfmCmCSt1fpvu6XhjOUvsPnkKJudXTaWUrEMP5B3u4
	nHmeAdCCnudEWZ+zEaPmvGPlY376qYdyqrQ==
X-ME-Sender: <xms:ORGiZ6HudKKs-xaa5LPcYyfRvFrX4PlRME_7fmkUcCSQaNPGHZN3jA>
    <xme:ORGiZ7VckBw4q1nVqcUXdwkquGYXGtW9A03ci5ji4_s-9pCDQROSJiLCpbWsQ9J6p
    5NIoezOmOWkJJ1OWA>
X-ME-Received: <xmr:ORGiZ0Jv_kARgqavjQ78LgKZPC1iXCfXEtoudZnO7SzTXggaz-NZN0wSWzBt73XQvclr9RLdr3rLYPu-4q4bWT4rhcTS7aUs4q00>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpefgteehueekjeekffehudfhgfelgfdvvefh
    leeludduudffjeejgfetledtieeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrhihurdgthhgrnh
    guvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ORGiZ0EXBlZSVznzd-5NY4uvlUU7g_3XYV_ajo3672k0XC1CfY3p5w>
    <xmx:ORGiZwURrCMtB-rgF3GnK6bZuRvufVIEie2BZZ6psO5-gedEX3d75A>
    <xmx:ORGiZ3NZEE8ewTR19b_z0xUp2FK7os7YmJ55mFGpWRlpwSo38FzNlg>
    <xmx:ORGiZ3359PwhsemyHH0EYB8O6u4dqW_Rp92-BrwoGD_6GP9PCA0G9Q>
    <xmx:ORGiZ-xai8kTSNbsUHVDnKMgZ8oQ3AKyy69LDVA2was3FFJVOjpMYjTv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 08:08:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com
Subject: Re: [PATCH] t6423: fix suppression of =?utf-8?Q?Git=E2=80=99s?=
 exit code in tests
In-Reply-To: <20250204003815.61391-1-ayu.chandekar@gmail.com> (Ayush
	Chandekar's message of "Tue, 4 Feb 2025 06:08:05 +0530")
References: <xmqq34gv3nch.fsf@gitster.g>
	<20250204003815.61391-1-ayu.chandekar@gmail.com>
Date: Tue, 04 Feb 2025 05:08:07 -0800
Message-ID: <xmqqjza5x3go.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> Do you see any other changes needed in this patch? Let me know if there's
> anything you want me to adjust, especially in my commit message. Since my 
> previous attempt wasn't very suitable.

If I were to change something, there are two minor things, but they
are so minor that I'd be OK without these changes.

If this is supposed to be a part of microproject exchange (sorry, I
lost track), then I am also OK to do the second (and hopefully
final) iteration to give us a chance to practice.

If I were you and I chose to iterate one more time, I'd rephrase this

    This commit ensures that Git's exit status is correctly propogated by:
    - Avoiding pipes that suppress exit codes.

to more like

    Instead of placing a git command on the upstream side of a pipe,
    redirect its output to a file and process the file contents in
    two separate steps to avoid losing the exit status.

Also I'd not redirect into "uniq", i.e. instead of

	uniq <actual >tracked &&

I'd write

	uniq actual >tracked &&

but as discussed with Eric, this "better style" is not followed by
existing code.

