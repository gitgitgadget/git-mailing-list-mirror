Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E25272803
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780359063; cv=none; b=UL1GmeeM8zGZa6VzFiKPEZvBL8hyPb9d5vTHvC64gd1SGlWQgUjLzQ2kWd1K3yRLHxpiwjB4NGl0Be6VRDJj5hvTJREHvZ9Y7plg25b/8yQ3oykTMnLEkvYPEVZnad2oiZDA8j0CTUQktbzHhu1P45cfnS9snzckOAkS8bQ89rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780359063; c=relaxed/simple;
	bh=ibymPd0c8u4+1w6aSqUM+qJCQ2Qd1nS2hufH6A7D3XY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k6By/94G0b4CHPsn9596FTWdfR1SpcPkdoRWtlypTIrSTuTzG8mvCFOCOHtk85Pbe4iVw86nfz5iWYFLVDI11/xvVuAywZrih0avcKYNSu4k82zhbL67J88q0Mzm53NzQ4YAuSXaxZJw1JLmaN8YkkI/hLHG1hg7ow3HAB2S1U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VcZhtUTe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EHmQHyUX; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VcZhtUTe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EHmQHyUX"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D5371400163;
	Mon,  1 Jun 2026 20:11:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 01 Jun 2026 20:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780359061; x=1780445461; bh=kMjldPgGlx
	nySGp2wsq3YMWjAKVR0G3B8hzxeaveeAE=; b=VcZhtUTewa9NbVUWJsG8K/N5i2
	6yGUrFXVlTZUKC6QDb/nhzkR7dS5T9HtU2q44cX6gkCqafw2odjBZ9GqakEv1dZ1
	7zfJOf3tCfJZtbMJDD/fbJlCnBmBh25x5I/DSWDj66or3C5I+TKN3pbFEWHZH4Qy
	CSU5SaW1EIU6rBjDRLO3PruWJJn9sgQylx/jneVsCCM7pz1NtHDLycl4ZYLUBl3n
	zPqR7Tj/SyUXL5dIF9+T6Tw/nqxM6M3/KRWTyzvN8AX15JX72Dci6BA1ucXlikXj
	mwiCn7XhOvF86IJidghLu89QKMbHPf2UIt18/lH+zN5WOfQHu3zaz5eJOXrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780359061; x=1780445461; bh=kMjldPgGlxnySGp2wsq3YMWjAKVR0G3B8hz
	xeaveeAE=; b=EHmQHyUXHW23klt8fXJ3AfJwtqv4R03bAe2/zKGiF7b5XFy9gep
	9+x9tw/gbHqbAP7COopMf/+GNdyGGluo69AoRcUGamulBj8tMBihZSIb6YeD9fVT
	LO6AvYKIatBtoK6b+r4thfx+c0zyhnvra51hOUK8d/My6Qma2ZgRHmGzps1QqN+k
	yXT8naHzR7fPD/1yc2CmvZWnWVJk7xZr7H/kzP2yqOKHSnb+AI8a5HRZaq6kB9Pw
	9yY5aArDChpzfBE2cNEy5mYfMDdDieJl41lWRekQV98H4P077R/fVWw/vOv8HWa9
	chKStsmYpY7R0woudFiXlte/6O+4esrP1iQ==
X-ME-Sender: <xms:lR8eaqVzsFaBUws7XF4jO4gn7dCJBkRgHfYA7mUYY1gemAcZjFV9Zg>
    <xme:lR8eatdhUD5gxH6butNuthquIX9TNip5LqLR-xXS2LB202PcynscuE0HG7vOLWo5N
    UmOgp6EnOOJKzMnUOWxmR0B6F8R5j4s2gnczZ6YShRSP3hkD-jYwA>
X-ME-Received: <xmr:lR8eamtlZwfoEZ-5GDKw_k9jNGaEeo7oDzG5uApvTC6Qi9H1P3ArUyMTihMumU12bfVVsed574T51g7fRt4y5xSvkcg5G9a9njHT>
X-ME-Proxy-Cause: dmFkZTEqvH5uezGDYxOYaV7V0alJhOkSMfjTNBlpG+NPN4IhwK7I/trUmPRdr7UhCoC1XS
    gdWyo7f/PaYW1ZkmoQtt1hAV8pupJQqpCDjCEw0ZUxj3ONinQPhXS/S81dZFuJGwlNCuSU
    oV2moV7IfcsZHnz9jQmEJkW0RwOorwEj4i0Tql12pI7nWO1N5vZnliXgaP5QRFfwhLV9zq
    7RjQ0uSw++3sxjbXkKlAmBmUx/uMUK31qg8Bbn6QBw29RPuLLyR6Lplr3vvi18Oxu+cq6m
    cIam7T+VaXkDhYVKD2XElMTpvM0SPKZ32DFvH0JgL7Zw/wdbj4vH72BQ2njYUqgEwbpNFP
    bN7kmQvGGO5dqteg2n1dbRldc31w345C+Xs+PtPaQE8cAF/fgu1kdCeXtIfHNuCvAZuh4p
    DFTHmoDCry2h/Z8jDrU3K6cl2ZOgTvi2QisKzjSw8cL7lXeeO5BtwweydLGdkEAMeLfxCq
    oaYBJUydou8LE4NdMB+7texsfdgFsEkTytVqbzE0YWiUkPeR0JNnNKjABLafKLiij8frvR
    hkKu045N8KWwKx45Hf+cnOBs9zvdjx2p8/ZfcERWYXmg33RCIx0BBxliJgeAdViCYE/e+U
    lT2YSpckuDwzHLzIh131VtM4sBdl2Y86adgcF9mGBgMbPONSmjgjDja3uQAg
X-ME-Proxy: <xmx:lR8eas96adogEca3VHZCKb6QoEmmsYW5Pmo1fLLc6xwZ3wbEW0uN2Q>
    <xmx:lR8eah0BKbEq7vfN_mScAdmiMJPtSMo7VwEo0j7J6m4EU4GiwcOi-g>
    <xmx:lR8eahDhLXZILTvaI6LrZd5yOnCwb5eORFwB0eRL8517Iy6HXDNl4Q>
    <xmx:lR8eatd7tjqcuSQ0HPIABlPWAHlZxB30sJbsX0vNVBy_tH6n26uxMw>
    <xmx:lR8eamCApSWmAlDxUUjU9W9CGkCJvTtTHIF0377816lU8kemEQZiyrt_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 20:11:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tuomas Ahola <taahol@utu.fi>,  <git@vger.kernel.org>,  Jacob Keller
 <jacob.keller@gmail.com>
Subject: Re: [PATCH] describe: fix --exclude, --match with --contains and --all
In-Reply-To: <3ad3a7ad-14de-4972-acbd-433ad4ced7f8@intel.com> (Jacob Keller's
	message of "Mon, 1 Jun 2026 15:35:08 -0700")
References: <20260528232950.187002-2-jacob.e.keller@intel.com>
	<xmqqo6hwcves.fsf@gitster.g> <20260531234644.97LRl%taahol@utu.fi>
	<xmqq33z7ay9e.fsf@gitster.g>
	<3ad3a7ad-14de-4972-acbd-433ad4ced7f8@intel.com>
Date: Tue, 02 Jun 2026 09:10:59 +0900
Message-ID: <xmqqldcxztrg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> Ya something like that is probably better. I'll look at cooking up a v2
> which improves the test here. I think part of the issue is that the
> previous tests setup a bunch of tags and branches, so figuring out what
> all the possible outputs are is tricky. Probably I can just add
> additional excludes until there is only one answer.

That sounds workable.  Thanks.
