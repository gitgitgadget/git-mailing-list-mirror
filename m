Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456A370D63
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716844; cv=none; b=J7TgzkN3nODFTq/SR3ou2wJGnjkLMKS8Y7EUHZJd/iogY8pQynudVGjvqOcN9MeE1Nxvm/35IMnrmgSYcrcPUosSP2Z54VF3cUwMZqY6wpDNU57AlRxeiwL1WLhp/V3l1y07z02i5Z4oU3qIAECuiUDBubWZaIaco8GZ/4T2lTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716844; c=relaxed/simple;
	bh=e2vnwxD/bMzUVb4ivFwLyRowZzQN6SHS/Y35Hzl79u4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L1rniwt20gwdFI4YefBmBBPM9w5KyCnfTNGQQTIXPg4A+SnL0bb5VvWizc8iVfVej24cxkefVDnx1KETDP4FGQ/DBMTAUNHPB+IDhokKY+W+fuAbR2v2YQAec3CkJdkYEqFTsL/lREnb21mKFb24jdBGg0vJr01CAVwSz7IAi8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CCFeiqZI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P9MN0qCu; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CCFeiqZI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P9MN0qCu"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 254F37A0753;
	Tue, 29 Sep 2026 17:20:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 29 Sep 2026 17:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790716841; x=1790803241; bh=e2vnwxD/bM
	zUVb4ivFwLyRowZzQN6SHS/Y35Hzl79u4=; b=CCFeiqZIAUZM0TdhFoa/jqWWCD
	r9iNGklz1tJQWXOKAZDEO9FiSUw4i+MQgIaHRPFxF9Zel98lfxn2VrlgxyIe8fac
	VXGn6cNJTjj8QtDyn2xIPfqrAgHtHzlGr0ya8rkQT8f0jJFG6o9dK2RP3P2SwqJR
	JDdl3iIBt1KCP2TwaPjsSE5YuexxoXlILsdqxG2XQyiQCsZelx2nCOSreqknZEM5
	n8u7R5tI6PYyybwo9fXZelCWWyY8O1JMkgkPOC9ty8E8/oxg8q/hfIwc1culSZVv
	em8ANULw+CTJiQwUE/+oFps3ALkgvcWlsypGlBZfJl6B3kzX+tSvEiXm2ADw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790716841; x=1790803241; bh=e2vnwxD/bMzUVb4ivFwLyRowZzQN6SHS/Y3
	5Hzl79u4=; b=P9MN0qCuNCwB1g1z/fcAnC2pAKHcgo8gLGWD/TXNeA0GcYDlNgq
	Fe5hb4wif28JKS3SXugGBUF6kVdgxXiJo12kZF2+Gc5wnhXq3It6u8BABtDXCJDb
	Ey0sBd20tKYCtBVpZSdHmGOWS/enqfl+dc9/0ijOy0t4EXRIdPtFizp/HLbYIuc1
	JIsh40b9ic/fSdcOJ6KK+7BOpzAndqZjszvfbYzP9ixm88m8CpB00Bz8VHC0/x1J
	nAEtaAlMs/gSlyipE4IPVCQbAZng0GVdmo8iSjCqwKqcrLas90/9975s4CYMHMkS
	gz3c4el2euphicnpqDjiNm/7O/9GLh0aTiw==
X-ME-Sender: <xms:qSu8aq6CHCwTZVvvAI5DLTyxyVfccOOErAJBsTx9Qb_dhZZImMNedw>
    <xme:qSu8ank5ZbkNafv9H0xL30MO_mH0GSxhFuk8sS5oDhkGhvMLrjHydUsvh4B2-7o69
    9AIVxuR1KE0KPWlx2AOOCXucm1T7_Bqw_LmLgzOosWZwVWDEzw53g>
X-ME-Received: <xmr:qSu8ajSJCxTB8Dz21V46sXOqwhH8X77ttkZJWc9-1cRIgXwqUJ0Vi3wGfHSPrcdlZ2Oqn0N492UepUS09TmUDb_uJRbOml080MIL>
X-ME-Proxy-Cause: dmFkZTEJyiumIr5W9vvUr1T9NBZFL5qvIZpi/BgEz0Pk6cZd5rtk6vKtm01yK9U0EJLAKy
    r2GiKGwHMQ21xQR/tFtKkpAvSSRRQXhe3dWMLIyNMcY/+5+ogABdxKT38NK3jX86XgmneY
    yZ6Na5qBaknYYEP1tHeSdCa9ee/c3iwnOeTUff2Adgek1cG3Fpase9Je8LOhC+iZi/Akl7
    HGvd3tTg7MEisaKnm6EvgOn7MBZSK/4OTtHaijOpbQuvD/X3e7PVlSToOWpheIALYmh6du
    pFx9hVSEE5S/ceqUZ6eVxzMj1ca/SZm2PGIAyXGWd/2e/EaKvsbr5smxtIf+gDaxbh4NFd
    ZXNXIf74ftH/fx/ZZ0YqPZe0uDHVY9DM2g/IsKJ6SbLgFjYExyZiNaFZTRdvl8pPYSgBkl
    Bk+vrAW/Hd7VHzLnpO5XYo/NpjNc/lgISe/vrj7p3ILaksEMUSwy/mDzP9J2k+USDUCrnz
    g405qujHKI7WMmua7Iay0KT3Qm1GFrHvSCIB81lpAx9yz3MntY1XnXlU2dxxc6FASDbELo
    EECVXjQ0N8deprEZpriVOJUOKMssFr2aJ6Uwcf3wIXFMcy4BztWFI5eHfF5z3w6f2zxBh0
    o1qD1tlI3ZS/dGyv7b2RYbxPObs616q76Jklz3JBY+dLU0C3SGZckOezQqtg
X-ME-Proxy: <xmx:qSu8auGSC14FY4r2QEHGu1I9-3-sI8A9TEBnDhSxM3n6edDL9pv4rg>
    <xmx:qSu8agF_xVwOb9S06HJXB0x4qlGfaw90x7QgUKAglqT7a585PR8pCA>
    <xmx:qSu8akQYTnL2fMZVZCDS9A3gL9YEylHt7TwnEJbhNWvC-4Gpa0MiMw>
    <xmx:qSu8apLjxTk-MDLoWTZ14VVbG-boqEYm9_ssaQmNGIWwSDFymIZsAg>
    <xmx:qSu8ameOIm6EYTtCtppO-OvgAhH_5pe-lcgOF81HPgAE5YLtz35VK5vx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 17:20:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH] [doc] Use `man git` to teach users how to navigate the
 docs
In-Reply-To: <9a628695-3c82-4cbb-96ba-8bd9c1c7570f@app.fastmail.com> (Julia
	Evans's message of "Tue, 29 Sep 2026 17:00:18 -0400")
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
	<CCB1855E-759F-4741-BE49-23FC6DD402A6@gmail.com>
	<xmqqo6dgkead.fsf@gitster.g>
	<064ec9c5-d539-4d21-96a7-6ad0ead5a061@app.fastmail.com>
	<xmqqfqyrg7j7.fsf@gitster.g>
	<9a628695-3c82-4cbb-96ba-8bd9c1c7570f@app.fastmail.com>
Date: Tue, 29 Sep 2026 14:20:40 -0700
Message-ID: <xmqqqzibeouv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> I tried to read `git help cli`, got extremely confused, and gave up so I'm
> not sure what that style is but I'm always happy to be corrected if there's
> a different preferred style :)

"Options come first and then args." appears very early.


