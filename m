Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BF03CEBB2
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026496; cv=none; b=LSn8HKP8phywfLguPTeDoGgUmvTaIzBuan6s9+72G6yyEFD2xUEOZAJrE1z9OTS/zcBP83XUc6HJtIwGv8VB9mKzrlKxCCXBxx68CDPXMIm3fV5njFll05ktjKBvtsWwScFYgSH0n3YT/03gRDagQwE2HwAD3DcKDd1iuy4GyjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026496; c=relaxed/simple;
	bh=DvfOGBo9hjGPnQ3mg+JNx/zy61XLWVeY+MFPf0GSWgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GbeVyH8Zk5Ddmho/BTKCXa0og2Jx9iGCwOxl0fvxTmAqa8/NLRHtzVShrUJrMhQJR5KIhvwaEUS0YhaRMbfZW3iWc4RYEoq6i9pJ1qz0kXIrcUt5aFbTxc4vIKaBHEa3G8uA35OKzYvzcfsKl38XWSTqa9jGx2IWPSeHksoDYSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NUKEy0Sl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5VXWykdj; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NUKEy0Sl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5VXWykdj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BB6171D001C0;
	Fri, 20 Mar 2026 13:08:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 20 Mar 2026 13:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774026494; x=1774112894; bh=U7s5dqSLQG
	cMi0zuIBkBoq/S+AAEAiqK3fxkKyZuT24=; b=NUKEy0SlncKR+QNPkQIQaBN1Ef
	2lIBzveU4fH/UXFZow5NQd8+4zgSjbGFlnUD7qZbZ2HZFHBGbXlYLwXk9Bc5kx8A
	jZDN834QAjA4QF/MBuFM2QPIGAfOA5G2iBPlPjVc27jknYsRkBpHLNJahgq44dTT
	0FHtS0KZ5Lp28OlCM74WENNlff0V3lmnBN7eJQvsAjEGIveoX9TgxAdQe+LV/47q
	3G+cD2NVygmQrp0Z3alJcjGpUy9APLEOrcgq4k0aa7Ifk4X2jJXzaKMxudf80iIp
	gm1eG6FDMaSOnb+Q4AXk4f4BCCigXNSphB4bnMy/RTll0/Im2lcN1kLiFBrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774026494; x=1774112894; bh=U7s5dqSLQGcMi0zuIBkBoq/S+AAEAiqK3fx
	kKyZuT24=; b=5VXWykdjwDE105ADkolk5nmvdsoJPoR+HIRwugx9s5naNEgKG4W
	Ct9p0NYHQ6yRfUKbcvEdGRxxiTxtM5EN9xbr7kHTjuNv5eP2ywOAg/7cqiPKyz6k
	HTtPPhO/rguy5dxsXL2H1Do9eugn80PF1S5T6nsNBJHIBPkNBnMnt5VhBJEVfgW8
	3nNfaObE2LGqvBk5RQsLQiaHRh4F2q/OIf2/BrOum2dADCZ41I+6252LksXpk7Jc
	5Lj3Pz4OkXmg7T6Szy4Gd7a/kSUJ6VYOkn7TMXtPEBco8DkwB/FsVy4H8tgYbO+y
	E3PpyYNzNhz5tiDpmDm0a99fByZwsf4YkgQ==
X-ME-Sender: <xms:_n69aTOsGJG5UZ9DoesYxlC5CzAFxlo9fxxBURUdLG1l75DeuauFLw>
    <xme:_n69aRplrOLejzX631vkWT9xgQBJ_HG15bo-Mz3HxDrgL2wJ02EXSej8hpNPBRADs
    przF6zmYW9gUD0md3_WhQTLxKzq5bAUfsJXMW9tFvGJ8mA9uIhdSg>
X-ME-Received: <xmr:_n69acHC927BWVz3im75p03vi2ghCsvwcKD5euvT7hJjwFlWvaEpMjdne4eRgjMRJxr6KtHcUIlLOYaHVcBefj9_Pk0eYJZgew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohephihsihhnghhhtghinhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnh
    drtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_n69aerBUKQKBWcHRDwwO2a8YiPp0jvK18mV4BdRGQTe3G5LmOZmsg>
    <xmx:_n69adabyJoXcHMgIduh5bunUJBm9Sro9ewqwMmPwc7wJUtRAEEdgA>
    <xmx:_n69afW85O9E-kk_4IJ5SVcHVAJKduwafbnT5JEl0mcS0rWa0D2Ujg>
    <xmx:_n69ae8IDVzlVmlhQU-NK2h3EElqGzvd_QnFsxN-OBMdPEaG6dKAow>
    <xmx:_n69aXwnZXg5rP2wcyJdxBc76S1zHGzaG7L3ekT4T5bdbXo0DwAphTOe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 13:08:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Yuvraj Singh Chauhan <ysinghcin@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  stolee@gmail.com
Subject: Re: [PATCH v1] path-walk: fix NULL pointer dereference in error
 message
In-Reply-To: <CALnO6CDnwYaAPhp67kaYWtV48ULjWAR6ks1khVXmSs1oWUbRDQ@mail.gmail.com>
	(D. Ben Knoble's message of "Fri, 20 Mar 2026 11:16:48 -0400")
References: <20260320114823.3151961-1-ysinghcin@gmail.com>
	<CALnO6CDnwYaAPhp67kaYWtV48ULjWAR6ks1khVXmSs1oWUbRDQ@mail.gmail.com>
Date: Fri, 20 Mar 2026 10:08:13 -0700
Message-ID: <xmqqy0jme8ea.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> You mentioned git-backfill with a tree missing from the local odb; do
> you have a short reproduction script or test-case?

Interesting thing to ask.  THe code looks correct, though.
