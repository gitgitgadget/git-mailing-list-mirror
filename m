Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495231FF1A5
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358097; cv=none; b=jDLAsPaeMhP5eEX2sNZYJd9wgsdXX4Ohnoe2iYYXol3Ac7JGQAj1JDKXksa146S/884wT4+YPpLXCCvipAqcYkMGOGMlZ4NnvzzcQ8JtTknzbi+Rqls68BUeDuAd0XsKU3Kgr6I4SGiG/L02uaWCA0aEIaCt06pHtdRBeMIsJtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358097; c=relaxed/simple;
	bh=O9Sxy5NeJt9C/JJle1fvb3dYjfbPdjvC44mgNCczzQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wsae7pKe++YBdb9HZixA2Fi6igZmf3jv10MpP1+3otZ6frHgeIy8vxF7wIeF+bPgDpVCw2OYQj5fF1kAqaVqaq2VVC7ki9TMNl8MzavA2TaL9m7hZGcWHVDQ06/iRmAYAkqrTEtL4mrp87YaTk/5UFQg9g3Dmby8MUp7GPqOqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=4YYGM0rc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vl8eAU0k; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="4YYGM0rc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vl8eAU0k"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 35CDA11400A8;
	Wed,  8 Jan 2025 12:41:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 08 Jan 2025 12:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736358094;
	 x=1736444494; bh=yT21XRFBgDKCO0QuowltFS6Y4Mr9jx2l0J9Qx5o4NcQ=; b=
	4YYGM0rcVTZSgGGRkkageLQzBjpSPCpnkap9HP3IINF5baEneO8SjSlageCcVhCP
	D50ABKcYO4wFgNEG0Dwbq9LRBULxKeS9UP6KNA2y9UYMvO2WoiLpPbX7wEz/Xfo3
	JF4bKmxon3CZkqmXGkmKgrCQACBApGZpU29E99vK5eNpyFl33IWrfkeyIGxs5Qx4
	zFhnKIERbTyEh8l6vQHDn7TGWLQ0clxaCUvfeNLF5vZ8VXD4tWuhxRQa0Cro5iT3
	4xkDtqAAQrIBGZe6YDnELQ3B3GfjxwtTi3gAOpYZA+ElLcKx3xOPGhp6jAUrsXZY
	eiyTEjT1Ustf2FYfq9tO9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736358094; x=
	1736444494; bh=yT21XRFBgDKCO0QuowltFS6Y4Mr9jx2l0J9Qx5o4NcQ=; b=v
	l8eAU0kmyPvjD/rVoL8DwmCc2+dJIYYLq54X5Nd9mbqSIvWVZ5q4lVigIhPLdTe/
	eKooGyYXwA9opJIqVY4v/XEUdYbAtPwloR6YXvtpwlRIon5nSAlGunCD3Ulhzna0
	1TFKK+FX8yiRzqw+/S9ZAlyMj3i+h/GA/GT/gCqtsPl6agcmwqvsYf8ysqIINC/V
	sAKxozFw9Ex+RuRFVI6YuhDeb6PqsCWQI9s9cjudHTUpg4Goxj5pPkxar77oIYqU
	u1tBNopF6Du2LVQf0zzANp/1qKhEKou2iWFAf+ZQ0sqBUNIdFaURVtIYkBO5N6V8
	2+IrggB+opCNqcqlbJyQg==
X-ME-Sender: <xms:zbh-Z4mofX79adNr9gN4MyC9FyLWIsTXpVoWtd_lndMxbXSzKwY7pA>
    <xme:zbh-Z330LTU8oQ6dggSrrShj7vx1tcT2sIWu7xeD381XX2O7rM5Qs6etYuB5UNMJ1
    6td3eR8Oh8YjqDfcg>
X-ME-Received: <xmr:zbh-Z2q_1a4Elq2Rk5In8oek-LzYj1U4O-NIZDN3u99kj2gmMBefnheivvv0TGzci6ree1ay_waSqeyUh7_3zFEnib6pxwwlazUl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfi
    gvsgdruggvpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zbh-Z0kolyEZJpj73iRPklpjtQEave4nEx39XhM1CNZEewiBDxqRZg>
    <xmx:zbh-Z22BHcnVcfSLdJLfJGgHZvL377L2NAH_Qr8Vy-FsEn6nAPl0cg>
    <xmx:zbh-Z7ulOnu8-w0txsjT-DJfoCiQyOoVWoP6CARAos2mzM3uDUVcyA>
    <xmx:zbh-ZyUk4I0olDH_zBzCSwukQxnApuvMSs4U2cC6R8NCeYWauAlGkQ>
    <xmx:zrh-Zy93OQCN3w-ZGEcR0HdPyIvWi5bOt0PglGKGzghtn5S32GnVfcTU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 12:41:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t-reftable-basics: allow for `malloc` to be `#define`d
In-Reply-To: <e842ea8c-4ead-49d0-a48b-0d5f8c4e7c0c@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Wed, 8 Jan 2025 17:36:34 +0100")
References: <pull.1848.git.1736352005578.gitgitgadget@gmail.com>
	<e842ea8c-4ead-49d0-a48b-0d5f8c4e7c0c@web.de>
Date: Wed, 08 Jan 2025 09:41:32 -0800
Message-ID: <xmqqjzb5mcdv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

>> It is actually unnecessary to use those function pointers to
>> `malloc`/`realloc`/`free`, though: The `reftable` code goes out of its
>> way to fall back to the initial allocator when passing `NULL` parameters
>> instead. So let's do that instead of causing heap corruptions.
>
> Ugh.  That makes a lot of sense.  Sorry for the trouble! :-/

Thanks for a quick Ack.
