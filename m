Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707292620DE
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931699; cv=none; b=UfPUifuJf++IWo58wxXtRHUIf5C+Ecc6lKzbi7WTM3bEe2zqWGmU/dYzoTlWJqNK8O9cyAvy2pVWynI5/xXUTbzkFG7AxT1ewDdK939m7rm3O8098Bh89Z0uGR6FOxtQHtjOcS2he1ckLd1gaQqRUQejdAHbWevgSYpEWjJqz1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931699; c=relaxed/simple;
	bh=6O5fz1EpdlsO7LQAWP/GegzqTr2TZrHTxOt82R3EWhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F19keY2agaKyaAvig/YNTt2xkCLKVh8chEkStn5j+Z3uH1qWRW79h2bUy8pyN7hFEFXfyIZ8K9L2yWBUws4NN7Azr2uJCd3Xy/+Uu9+0rx5EiPMoorM1dcrrvy/+mHZViPtBt0JAyo4DCSAXjGwclVXary38JDqcSO/45S63Rhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wWGTNLxD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aMBobnkP; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wWGTNLxD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aMBobnkP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 84A881D000A9;
	Fri, 28 Aug 2026 11:41:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 28 Aug 2026 11:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787931686; x=1788018086; bh=ej021BNBMp
	W6HaAMGk+DOS6z1oJq3SFQfPZHZ6QVpJA=; b=wWGTNLxDnPWIkK0Yei6K7L3TP2
	a5orMGPK2AYtXxO4fqSi8MsaAk9L1zHVXNBitddlpEaaqwtoFwXukzraNjnHduTk
	faDf/dWI19TZzDXGnLvN3flvcNHBOGoWZoqhM0WMn+TsTh3NSye1hinixPSO5QvO
	gUG/CuX0YEJBC77tWRdVOfREu4yuJK9qOa3CiLXq0IjhJgA3l8Xo56Boe1FTKx0i
	Mzo2CH/ssHmWgn2gJFKs1nrq/yOalZ8NKPUGAGKnGg3EJG6OcCyUTnFYEZCWsAJc
	FMC4Kmb3xiq8ipYO3xtt6ggfRkGRG51neeQgxeKCidLHBafZtfEHZPWfVOvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787931686; x=1788018086; bh=ej021BNBMpW6HaAMGk+DOS6z1oJq3SFQfPZ
	HZ6QVpJA=; b=aMBobnkPG769I7mWk1dvzvty7pRhkgYXLLMzP0+eFAUn41W/GYJ
	ZBxu4C0t4GCnsjhg5dWn2n346n/qhqfSwsytcMIhpBm/jijYS30fDItx57IihpXR
	cZHlhApxbt0bgENRc7iA5IEBaOgbLAd4WKbk6nOsRHcnRRGnK8+uIr88YwWaWBeY
	VfVXNivTk6aCsPFX/cQfbbu0FhixyA7v7xesCg1gbFoRlkJZTkf5LxqRy740zKYt
	4siuFaCOfMGXjHBXADPNjmxgud/LV8VAq6UDLjfUk+W3QEv7aB5fTYM2JioAfWnH
	AXX2n3PuLl/VaxSWzUpSFJZiMayy9GZLeUw==
X-ME-Sender: <xms:JqyRairlKW6ZplN9O_mtfCkDZgV2tZ0GuyM5ebfKT61DQRNEUjvA_Q>
    <xme:JqyRang1n1WsZtz0Kvorl0pFvWjmmzCAPKaU7HkEpNeI-nRARCGPQ8ZK2Vej8JblQ
    QCQPONhvJp_N3_y1YUjdIw2okRBsSTn5Tp2f7tJENmxXInjDGMV9g>
X-ME-Received: <xmr:JqyRavgmhnxS0iKHY_yGQvYQC-7Z6Frx0BAwcjypsHsphxkFQ9jtmLOk27ezLRAi6B6BSOySTj5HZIz1jFPlUkR3A6s9Qo_PDA>
X-ME-Proxy-Cause: dmFkZTEEjfNzfMOvu0xiAuEz92dGYnVJbznp7M69E04ilZSHByk2tyqHWPpyBJJnMHvh/U
    KI10QUzEuG6DWnqrO57KFPIJuKK/PvIveE7AAR7501WXCu65C1SoOEDiDjYVv/djPJe/Y3
    TPJvs+Rqs2yrMunbAWuX1wPwaWMzw7GK5VP3gB/i5pjK6uoXtzcZfpD16OgZ90jwDo2xdu
    HPgmXYSxIHvx6ri+PEw2Ly/lOS1BEO6ku13uTBVBGcyr9tQ0UDUCNJban+faaxivXrjb2j
    kyJ0dsUNHqqo+oNLJMO0kYWZiBK28WITDaMS25fKjrAaTG+Z4zHj84m/gCaX2RVCFb6Ubl
    ul4R0kUP6xQT0M37Y+nhCQSfIszkMFs+2ZPeGQy85qbXBb91U5oJ3Af9tTCKlH9cN5hG4s
    TmDvRupd4DxfKkCPJSiZmd3WGwYo6T/eYtsy/FS/3hizx30VGuhhQCtdUFdBUXhKyh7lCv
    pIs9Iy0fQc397BeIThia4fKB4v8MxG2y9Jx+P+GUuJgUCHbcHpE4K5m3VC4V5eusjVPLXt
    8bWRS45R5hhIEGFPL0ity4rInUsP8gKgz8NXQLRKtG/MihHAzi4igmomQQj/HgYkvbZCc0
    hksKRBXDYHgbeZ4qbMgXG/911E6Olb00LQtnW6njawS+UKQd4d2GvNGgfJBg
X-ME-Proxy: <xmx:JqyRatiRYg7TdXlYtm07TnCHudHywUkvzfh8389mJMHIem1aTYIbbg>
    <xmx:JqyRavLlNaf3gqjwOc0ZcfF-FLzeUUTdt1JoOZ-evMbbuUg9MaHcxg>
    <xmx:JqyRasGtnnniqLGbKHRSYvacnWQNISg4RdE3JjDoIxiiqrsvkwYH2A>
    <xmx:JqyRajSp0DpF_IuVOFBgg2KkH-iy2AH0_2lSL_fqZIHcDaNAHRyeXQ>
    <xmx:JqyRagyy4D7i1PbB7xSG8KQBUPDrTHiv1_bQK_H5OysbiBJ2VG7LApRI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 11:41:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH v3 1/5] commit: clarify FROM_REBASE_PICK and
 is_from_rebase() names
In-Reply-To: <7e198a20fa47f0d5b2c50ffc7046bdfc792b62af.1787903085.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Fri, 28 Aug 2026
	07:44:41 +0000")
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v3.git.git.1787903085.gitgitgadget@gmail.com>
	<7e198a20fa47f0d5b2c50ffc7046bdfc792b62af.1787903085.git.gitgitgadget@gmail.com>
Date: Fri, 28 Aug 2026 08:41:24 -0700
Message-ID: <xmqq7bla6ymz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Commit 430b75f7209c (commit: give correct advice for empty commit during
> a rebase, 2019-12-06) introduced a FROM_REBASE_PICK enum value and an
> is_from_rebase() function.  Those names failed to convey that they were
> specifically about hitting a commit that becomes empty when rebasing.
> Clarify their names now.

Becomes empty is different from picking an empty commit, right.  I
am not sure if "is_from_rebase_empty()" conveys the difference and
more importantly, I am afraid it hints the latter.  I have a feeling
that EMPTY_REBASE (instead of REBASE_EMPTY) may match what we want
to express slightly better, but not by a large margin to make a
difference.  Perhaps Phillip has a better idea?

> While at it, change `whence == FROM_REBASE_EMPTY` to use
> `is_from_rebase_empty(whence)`.

Very much appreciated.
