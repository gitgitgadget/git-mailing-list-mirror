Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE942877FE
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770161619; cv=none; b=tYRX8eSfeK2vmilF8KRXXIH9mzii06cQdi38l3IY6SMB2bIVreP9bYFkT1fa1Ogm3N9DwjulfBDHPoFlWS6edKxSYms1RM87rNl848/X3mqmFPKEVTJ1i8RSEgeZ0HI2SpDNqUoH+SVPLRVOY34Yh9rc3G7Rp5tCVWcrrLpl0qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770161619; c=relaxed/simple;
	bh=TNi6EQhdL2xkEgG3A1zt6DOCrWOxl7pMbXGo6/qQ6Fc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pjsE00HRXfRx0yxfK+eM++fE68W1PSPY73AmpkdJvS5tuGRD9emq3aCbGnoFZknuGIXsE6E/c7WCcrD66PtIU05HZ93W4OL2XbxcQwP2nvx+8DJKZ6Gx313MGS0JfRPy8lXx8j2R1gWaD4BzhsK5pEPeECpk32m/Aqv8X0SWE2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n0R8OSpR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C12ycC+M; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n0R8OSpR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C12ycC+M"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C0121D00130;
	Tue,  3 Feb 2026 18:33:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 03 Feb 2026 18:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770161616; x=1770248016; bh=tJRHpByXXx
	0mkVSW0+p+BOSdqF9fMp8p3SwadR3MizY=; b=n0R8OSpR0yVRFWlh9SrWyxuvP5
	twaIYo5FMfkiYvLY7EkHVY+ynhexHu6T+JdKW5ZZgdJJtMhPrtB8dXkzC8QCq5Bp
	SYa16AQYazL29sdVFIty/XWyN2zdLaWXrwyD6rcdagBuMTFdekkIhWm8NWBGiFxS
	MJIhX744hZ+QyG1CKCiIaMt7f/506mvlqojD9PXf6vr8gZ7m19zTscjNIJ1KtLKx
	V8zpbIIBkgPAU14DbW82RFZfPah4scqLg5vxIRyyf3p8tPLixSaYR6eNpBa6BIxI
	BkGM5txX65IDS+Bx+8RhC87PdRjOrz/+UTz3oRUI8x/9Wg+Uk4RmTp50qy8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770161616; x=1770248016; bh=tJRHpByXXx0mkVSW0+p+BOSdqF9fMp8p3Sw
	adR3MizY=; b=C12ycC+M1jI0q6ctTjOPunIMXek81GJ87oJ09vy9vdhpJwudFyG
	pCDfUs8qDu1lepkD2DYkHFR5Q8ukXKGvragPgzNynAFLUbyF/lfwtjmDttWzHPmj
	ZLOwPTn2bwPz0gnzDtjMTu8nHPAzDIUh6oW+6o9YHnqMqqVSEBv2nxh8b4HpSX7e
	1uYom5Ftw1Ms+TeNcgtT037jlnrKuCZ1Twa+L2YZoMA/+XVWGDnjfSuF6NfapLFU
	XOcjVkvX+JHsSnHPbmcOY928lfvdMmqxp80qsOrop3CnbcqAMvQqTU+p1sOqQLhS
	IaGatw9AncRnvCBoWUTB74Vfbv0n2G/4Qdw==
X-ME-Sender: <xms:0IWCadA-t7gxUpYXoS7hXP8kQZb6Iwy0KOI5xwh80Jj1DZmoVeEi4A>
    <xme:0IWCaShfY_OX1QseCjFkO-8zcZ-72_SF30kbu6M_e88rfQgJBIBAkJbxYSvIRDGIB
    IToCj8oL4tXKgebZ6VsqsmlsZoDcsU20dTQXvZd8WTLj7YWEYnxjw>
X-ME-Received: <xmr:0IWCadmBl792_dxrVs9kfJRKL9fnLX6OEWJYnAUNujpkH6eIqLJlYfuREKs6jMZkrSTvNBiNAqJG4foRjEypkU-pKrRguzYAJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedufeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0IWCaWpNV200lfQhWX9CzxSa6VrCVMQgZeXrILsgk4NgEIKpZiq1fw>
    <xmx:0IWCaeFnsvTbsKXf3pbWu2wAu4FD2pVP0G7AwNeAT7JmwXiO7bS05g>
    <xmx:0IWCaayuTKmu2BQLzXsvumbxGPeSSMervvLvV-8-F3OEowdPZiglVg>
    <xmx:0IWCabr6D7Hv2oauGVJa9MLIilH9vijBztiu38kw_slq9HJE8Zo4OQ>
    <xmx:0IWCaVERhfbrJrErcnZ1Ro73kRgehRA6XuprGqGaE746H_yVoSNg7Ixx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 18:33:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Justin Tobler" <jltobler@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 4/5] builtin/repo: find commit with most parents
In-Reply-To: <e48578d5-ec48-4369-901a-597de3be9455@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 04 Feb 2026 00:14:07 +0100")
References: <20260203221758.1164434-1-jltobler@gmail.com>
	<20260203221758.1164434-5-jltobler@gmail.com>
	<xmqqpl6lqw86.fsf@gitster.g>
	<e48578d5-ec48-4369-901a-597de3be9455@app.fastmail.com>
Date: Tue, 03 Feb 2026 15:33:35 -0800
Message-ID: <xmqqy0l9pflc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> By the way: why did this project stop doing 3+ parent merges?

If you mean Git, the primary reason is because I do not see much
value in Octopus merges, which is very hostile to bisection.  It was
"interesting" to view them in gitk while the tool was young and
nobody has seen such a structure, but curiosity rapidly wanes ;-).
