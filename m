Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954002773C3
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143510; cv=none; b=L+0p9pFSn80OYT9TtdOfNG9qqiJaof5kZjVEkPnIOShyx2nDZ02QBJ9biHhHKKgobTWsuWdWLHhOe9VVNRX5q9hCULJwanOtR0Une1R/HUJM/4tdPHXzd4Oq1Cbs/yc2TqDeSOkTsCr/He/N4ZPuQ/V6r/8FnXgNK7qulD8EYfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143510; c=relaxed/simple;
	bh=jxPuXgH/St4N4GLPW13FiW7JY3tltExuJnxL7yR7Q1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Od2ULClA94p1K3gvaM7wPqxkRiQ2YWfBsAo4CHLPAY+6a3BFLYr4n27rfO/90uKuJ3JqTw+UVMe1Cha7eCR4NHXDt34J/cjO8FhF30NrBi9z2Xv/RjAfyPpFn/1LJ77BGMq3GA3REyLtcqp2T6A5jfKxE+KnI3JpqSDHLnUVnQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CyJQ6rJo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qR/j3KeE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CyJQ6rJo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qR/j3KeE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A63D8EC02FD;
	Wed, 22 Oct 2025 10:31:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 22 Oct 2025 10:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761143506; x=1761229906; bh=PDU2i5cPMM
	bBdglFx+9uNSVsvTkpAiYcx4M3LCzfCMA=; b=CyJQ6rJoB89qVeAi/MZUyRyUmg
	LmzxabFxg0NfoI4BPWJLhxusSlmsrF9+dfw/rqXc86bxF5fNAB2HOGXTRMSMAXwP
	3C9F5WA5dm5DxACw5DP48m7bKttJIFUVQCjM/cb7hCISym3J4AFWk0WcLRlX+BK+
	f1ncHSjy2P3Jnv6I6cDeNZLqjUuJlm3AIldqCQqaKs7hL8WG0wHpBsHr5BrYKcFl
	JgvNr2+YZ4miJ8UE2I8hnxN+LA8S73sLwuPzezvFoRHBmkTYVfv3qm+BoB/HNUXr
	4YaxpnFaJ6SuJJ2QRSU0eOVmcQKIlRMj9tC1hRBFn620mn0PdLi/1w8HeOaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761143506; x=1761229906; bh=PDU2i5cPMMbBdglFx+9uNSVsvTkpAiYcx4M
	3LCzfCMA=; b=qR/j3KeEnpRqCiXQDrAfFIgJb/48Qtjwzb4BWCtXeWbVYPoGeTl
	nG1FzfFqvTPguY83nkyS+KUkIzP0aduxhHXrjypNMHpaBJfbrimaz0M5RqoDZ9++
	/ZE3bKRRaCCXYpMGliIf+13CblItx1NzAg4+qzyE/Rfg47UT6h4MKwkW0CX3lp7/
	EedS+AD00xgackRdC4CBIbGyV1f4z3EdWuAiwZqtvQenBqaqdoh4OUKxRDpseMBJ
	tBhZidT2Mg3bm+/0pdnYWTFUY4Z/Jt4byWRhiC/L4GM6SagA/6HnFWedcDWzBF7X
	FKH7wxxssBpFC1LGdReaJ+dnCJcotQhEfXA==
X-ME-Sender: <xms:0ur4aNou4PAzEwpXRUeDX1Xt8nS6VTURd1_4UJwLeeGX7R_p4TDK0Q>
    <xme:0ur4aGi1sFFrSDI9o9B3cYfPegy21vGnwf6r21uG8tahvAE3xvy2zb2CECWSj1rM9
    sOj6EWpdHl1jHwdpvOc4DA_OUuiqu-P_cSwATDdb9aUBBmq06N1HQ>
X-ME-Received: <xmr:0ur4aChAK5qgQMF4sfYjDS9dfAqa0sypkfFudHddttGNK4Ljv2ha3LQaLkCyo1jc4xbKv5_u_smKDGUyd9e3zBr9SebZof2mhLpY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeefkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephihlughhohhmvgdvugdvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjrghkvgesiihi
    mhhmvghrmhgrnhdrihhopdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0ur4aEhrj9rnG8g5TBbqRMAFg8NXIuui1WekeFGNGgtU4eynDIzlEw>
    <xmx:0ur4aKIa6XSrYTB-oOJQMsSvFBKUnehvcabuCoTv_L3XOcUhjN3A4w>
    <xmx:0ur4aLE8gkI4INYvy4TNG1TTmXqwkhVYXeqvaFZQxTndp2eV6zC27Q>
    <xmx:0ur4aGQlYBvXkpvCgrW4g5jC550FLjfFTtN31aeqZDFg1Ui99OiDCA>
    <xmx:0ur4aAin2FaL7wwL7LkS42Ml_6vrFvdl5RiFzcOzder2nBEMRd0uEtV7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 10:31:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Jeff King <peff@peff.net>,  Jake Zimmerman <jake@zimmerman.io>,
  git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
In-Reply-To: <E76C71D8-103E-4C37-B05C-86DC180BD519@gmail.com> (Lidong Yan's
	message of "Wed, 22 Oct 2025 12:46:55 +0800")
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
	<20251017075153.GA4078773@coredump.intra.peff.net>
	<xmqq7bwt1kyf.fsf@gitster.g>
	<20251018094037.GA1060824@coredump.intra.peff.net>
	<xmqqh5vww7xa.fsf@gitster.g>
	<20251021073640.GB259661@coredump.intra.peff.net>
	<xmqqy0p4wcac.fsf@gitster.g>
	<E76C71D8-103E-4C37-B05C-86DC180BD519@gmail.com>
Date: Wed, 22 Oct 2025 07:31:44 -0700
Message-ID: <xmqqa51j0zzj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

>> + diff_free_file(o);
>> + o->file = xfopen("/dev/null", "w");
>> + o->close_file = 1;
>> + o->color_moved = 0;
>> o->dry_run = 1;
>> o->found_changes = 0;
>> diff_flush_patch(p, o);
>> 
>
> This would make everything going to "/dev/null" after the flush_quietly() call.
> I think we need to restore o->file.

Ah, true, the original location was only for NO_OUTPUT but the other
caller to the diff_flush_patch_quietly() helper does deal with other
cases as well.

Thanks.
