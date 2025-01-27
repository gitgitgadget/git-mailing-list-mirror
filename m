Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998A814E2E8
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994980; cv=none; b=iosIEYXJJryVgWmAwFqMHZKfpvWST3oZMalftwYLeRK3CCaST870t/CyerlXb5BriSO6S0GiL788bcnh3yZkNqiJJDnHM9tfrWKHe+tMFRQu0qLPmf+iDScr8Flg0N2fV3LbFlH0slqDL8I4Z8/HmYGAj1Mg3nZDssu1LjT/Q4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994980; c=relaxed/simple;
	bh=6fl6wc/Vjgqc52bl/v5sRYzw/UyiYAHtRMw/CMZHLHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QhhFgWVzeHlz8tTIBk9796Jjuo9ZChEPBgx+kPNlJhRLl90eM0HBKEGmgBBFe8DLV0yLN2BaFN130heC30YDEwmhky6RLvz+/9RhEgKsjtq2JTWVSSRSVisIOKVembZbL9nUvZ1m0/P5wq1CPAiHD6+RKCt09GWHtFDIuJ8myCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=t33TEDWb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NFYzlKWT; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="t33TEDWb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NFYzlKWT"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B9131140235;
	Mon, 27 Jan 2025 11:22:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 27 Jan 2025 11:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737994977; x=1738081377; bh=C4u5GiU9i+
	OleGYt+sLe9RZUeP+8xIElr70SyEsXpXM=; b=t33TEDWbMFN5RX0EMioNvEDvtf
	v9jv6KeTspY3tSTjHQNc/p/mnhQODwUv14ohTjHYeEnBKtyO9ir0HB+UN5Knx4uy
	BhMk69Ho8GfJbJnjaEjinlGBCwNj6Um0CFnfocxIi4b2kEYPfu9NLEyOlK7jFWt3
	aIN93ampNAKDvHa38WkEf3odCwUPqgydWm2S+63sT0cj2d7IWnWPMw3/+IvM46KO
	mgOBAtgbwp/MGE9nGVAhssHHJZHKJtppM9Bm068GlkBuhxkCsHSFmgVJMCb6aWj/
	Pkx7Wo5y7Ab5aT4iSpsw5A1k+WayWnAopuOu4p1NCOZ+8Oi5MB6mgQOq25vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737994977; x=1738081377; bh=C4u5GiU9i+OleGYt+sLe9RZUeP+8xIElr70
	SyEsXpXM=; b=NFYzlKWT5KrSC67YcVKKfIp7irAglj3NfwneNuQ1m55sU/RJ26D
	fWXGo7yTAKKMau2Ho3e6K7tXvPnqWz+ZpGs0lDvDMsWyxH3slWQMfD2NO74Snm1O
	vydqCtp7cQ9oKs2li6tKuEIb/oXNtWv8ZVNZZhYCHFM+J5seRopOqivbV5NQERqh
	zvXankG2H5osse1Re3TULeIDOHNlqzic3Ep8kGIN1xioJ5HcUFK7NA4rtRUGpr5b
	S/67Kj6RZKwC8CHZJTw7pgdH89HfYUb1VEM1Faz4UUqGmmi+n0A/DefX7OYZmzBM
	hkX41n9L1MSGIuXaojkZ6S3F8Wo95Qa5kmQ==
X-ME-Sender: <xms:4bKXZ0DXTH83A2GAKkkoyxGZGtulpJgkG8JDseLV6pIqN-ueggbRDw>
    <xme:4bKXZ2hCEXT8naCuSgN-lGwf6U7g0jH-pDb_aigHM-4HiBGiFT18319xDbvS4ya0O
    Vup5TCBIX7ETW6cMA>
X-ME-Received: <xmr:4bKXZ3kOQ0wePvhMg5ZAAI6RUyFjsWiy9v8_LLwM0B2RiAQijRIWmViQBrqfr8jCnvUpB7W84IieQzZv-5vRANZ5SEvMZRNaQ0Gk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4bKXZ6xL_UHH9ziK5ekDz2QKn9RgMnZAT9KAqdpt0VfX3cu2e1kpsA>
    <xmx:4bKXZ5SEqdHUMie5GLmylWOrVPSJzXHzXaURPaqJ2-1h2v_3dcJrdg>
    <xmx:4bKXZ1YHoaOfQbrV7P8S74z7-p74g_nuXYgOdgT9r6BzY4lZwbP8Aw>
    <xmx:4bKXZyT1DCIJwPwtmw33wqn-0dqj2YDi6pVsXec8k9IQQtFBnzlw2g>
    <xmx:4bKXZ4GMniA6bRZuBj5pf8UE6pje2NeJy6Yco_JaFF3Khclv2jAhLXPC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 11:22:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes.Schindelin@gmx.de,
  karthik.188@gmail.com,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v4] refs/reftable: fix uninitialized memory access of
 `max_index`
In-Reply-To: <Z5ddq3DE071XLzEg@pks.im> (Patrick Steinhardt's message of "Mon,
	27 Jan 2025 11:19:23 +0100")
References: <b7e3dd3cc870024f0e80dad26c5a7a96483c6cf4.1737970803.git.ps@pks.im>
	<Z5ddq3DE071XLzEg@pks.im>
Date: Mon, 27 Jan 2025 08:22:55 -0800
Message-ID: <xmqqmsfcusyo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jan 27, 2025 at 10:44:08AM +0100, Patrick Steinhardt wrote:
>> Karthik is out of office this week, so I'm taking over this series for
>> him to ensure that it lands soonish. The only change compared to v3 is
>> an adapted commit message based on my own feedback.
>
> Ugh, sorry, forgot to set the In-reply-to header. This was meant as a
> reply to [1].
>
> Patrick
>
> [1]: <CAOLa=ZR=Hz+LU0n-uC2dpk8_sLqAyaxO0NswJH8bP_kEdDdbUQ@mail.gmail.com>

Thanks, that was very helpful.  This turns the v3 that was a
replacement for a patch that was already in 'next' into an
incremental form, and replaces the kn/reflog-migration-fix-fix topic
which was my tentative attempt.

Will queue.
