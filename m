Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AED3176F5
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755447162; cv=none; b=W4KgLdRhO8H44oaDzz0YxG5tWEqY7CwiBYGO1pH7s1OtrmDQRsM7jBtnQMV4Mo1kUp8u6yBrT/0ROO0bzv0aiTP1ONAnQZ9I21B9kAV2NVOFXegZLWfU4gjWsjiJilH3wSGd2rUhw96uJTAmlwvQk+x5wfXUvEi6hPBMGN2tXp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755447162; c=relaxed/simple;
	bh=1iRECIWj50r53N1w/3ePk7R9IBPiplN8X3Nnhj+VCiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lpvoc9YyZ7M+erb0mCzz7Ino09ChmlwQSHXr1MQxjoNgMifWbh7a1wBhlXqtxPc1tG9w81+C6BEjFVPd+Lt4p+5TawVffBaQJQifUlItR2CmgFMczXZ3tFIyWpXMQyHxBDovvkwk8CK77i5Hd8hEdB8UwQzLhebLQzHvStbCZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gLUhPjiQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KC7ZkAwG; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gLUhPjiQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KC7ZkAwG"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 453BF140002F;
	Sun, 17 Aug 2025 12:12:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 17 Aug 2025 12:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755447157; x=1755533557; bh=Bu38uaob7K
	8v7Kr5wdvOcXk3/jHJ8p6JNspLMMcz2/4=; b=gLUhPjiQ8BlwCxExeBB4bmN3C0
	eC6IPAekp9SxsBLCA3Ndcwlv4BoI1kDjhcIqDIHzLGIq3jcVhgX40w+Y1cYEGNXm
	V3WbSUezrdwKVZ0nQfu9eSmfGHdj3na3jkSXMIxfZ2mEyQxfKSL/tRRpeEIcXVZs
	YYjM8ZyoBH3os4OlsoyGLNrfN+9rlpjm5VBOt2MJq0ocsm3tmxw0NhsqvBE0ywQk
	DiYj8AeDBf3xCTErbTiWbzQ8nqhW8YTxQlze9Gn4TOUfmss8uz5wgR4cuPLaJQX0
	oKMbwW6X/Sx3/zoF0498ZbSwfS4p0xOsQxiic+Fj3WbW6WV/pGVDSeeoTXTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755447157; x=1755533557; bh=Bu38uaob7K8v7Kr5wdvOcXk3/jHJ8p6JNsp
	LMMcz2/4=; b=KC7ZkAwGgTyRYmqVQ7Iv1Z54pn9XQuYauqT2lEKMnPE6h1gUU+N
	ubYzDevzVcy7ath9LMHgOVvmdRUEeV2VR0y26DcvhaqtYqXkYUG9UjESHbMpFlI8
	VRALOu1xZvGqX4OapT4ehnmm5PJ6hC88TDbwcEEEfht7SDeAb0WQhQcINsd4UKgK
	NwHQoDwmkhqoGEqAo68/9Z5MVSrWpekKGZX57GfNZ/qylEp/BY6W8GL12Vsax5T6
	OcnwuXboL31+1QxjzdLiKA+48nvcHl2Ua2AwebCSWVeibLta+fqobNiY04OD8P23
	e0Gfn0Rw46S21/0eCehFYuJ1b+oWyT18cpw==
X-ME-Sender: <xms:df-haAvfei4IIPbkW_XmdwVwLAJz8UQ_E4-NXMGZXoyoDYGvtopYRQ>
    <xme:df-haIDnwsRGhWLDQtIP8yO934qS9YP-3I9eLL2X2s2QYA4nVYeZKcgyEGFHTnV65
    p-p8yuUstf9Ub5Djw>
X-ME-Received: <xmr:df-haIWfGSar9HOEerIE0ExZF-WSgyoaPud2wYZjuX-n6Er_bweKrA9fyVwv2h_0YUCyqxbJ9-CQr8n1JuVm13VU0T3ttOBDGomjiSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:df-haGCfF1C6WNetilgV962bhfdq6L4FKvan2ZSisO_1QEuLww-3Lw>
    <xmx:df-haL9pVc5gxtSeJwZ9jTbPl0AMBGAL4CRS-EviXuABVrtTElu3cw>
    <xmx:df-haNGzXj17uwgF0b61Gr5UxzniQTxYQ0hw6-52atSkajQXzShoig>
    <xmx:df-haJM8uVSW9r756HkNehdSrj79GzDlCcy9uaAImhvMYeIYZhnVVw>
    <xmx:df-haLqOnmBNWDgW2oO8bfR6quDbnP4j3k2NePSi0UlKDHhmr7auBNXA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Aug 2025 12:12:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] cmake: accommodate for `UNIT_TEST_SOURCES`
In-Reply-To: <3a5e72a3-ae92-5fa7-2bf8-4276afcfd863@gmx.de> (Johannes
	Schindelin's message of "Sat, 16 Aug 2025 19:09:28 +0200 (CEST)")
References: <pull.1947.git.1754256267117.gitgitgadget@gmail.com>
	<3a5e72a3-ae92-5fa7-2bf8-4276afcfd863@gmx.de>
Date: Sun, 17 Aug 2025 09:12:35 -0700
Message-ID: <xmqqbjoekjv0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> this patch is still required; I sent this before -rc0 was released so that
> it could be included in v2.51.0 final. Could you please still merge it?
>
> Thanks,
> Johannes

Thanks for pinging.  With so much traffic, a single patch without
any discussion thread went completely under the rader.

Will apply directly to 'master'.

