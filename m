Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E847937A3CC
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755574; cv=none; b=KePEd1b5b6cwO86Da64LpHhHcZnhA7TfuHQTayz0OCDkN6tq1sLH0FnIdVvU0Yg80J2lW24klKOjT4X8GyN5/cyT5Q3lhoXWoVTVRzi5Y+9D+oMmgIq0WJctSmL9jHflWjGDaNSp4CQfYTfNThtMEEut1gb0lcCv/3m9YIiwk/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755574; c=relaxed/simple;
	bh=ZyND9bWxEtcRtS4BxJL1j6pfvx+s3TJjJ5aY6pzXf+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=InVie110vgEFTnYyJOEd06uTKPJiZUzXICjPUKb5vZZa3AIbqtCItzjBE4jxsqkzXTYF7W55WYSGdqH7D891bvyt4P/nwbSOPUza6FQ6dfQDjevFqbGDG+bZLqpveYskDpYK1/bxmdnVS0cqE7Q/L6XSvxlCcFHftBaok7a69g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LYO0E6fw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zkVScCQF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LYO0E6fw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zkVScCQF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 10DD8EC0038;
	Wed, 29 Oct 2025 12:32:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 29 Oct 2025 12:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761755572; x=1761841972; bh=5qGY9AZ+Qw
	cAe3ZSpXE+LApnBuC4HEEMFh45yJRWJug=; b=LYO0E6fwpv38LGx8zRUbC/iIt2
	I0PKNnXgbu5SxutIP+HDssZi2yNOfoGmvWNeoGfONnFlagzdMyfFic7icd9jzfma
	h0Ofd0jksApGC/knJqKp+bwJWHjsNZjwEAzdojAOKR9M8ZgETD8MstUndNbfzA7I
	TtG/dtcOp2mgipbd1WpYy6PUbhCLSt/QTfH7afmA9S+CNtwuibgpIK62jbRu1BuX
	EIsUGHcQc9V0K1usaf+ltuKInYBNhJtMTzkT0Qy4XJocbgwgyw4zpBimJjFO56YP
	5MYubPpiJ1bVbEvUDVPcBO7XMFA6PBjs7LytpGk6k+RzFFw8F+TqnrJHJN/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761755572; x=1761841972; bh=5qGY9AZ+QwcAe3ZSpXE+LApnBuC4HEEMFh4
	5yJRWJug=; b=zkVScCQFEs4op2T4ME50kC00/ccAUOvgLPMj32EmvUVBne80HRq
	mlxC+hXtsDS+UpVSh2fh8LgFy8h5tqNqGv1pLubTFcwGGnlgFAa/Tpw/xSV1cFo5
	RrKyuRzsWAJdSNvicupGtLu98xU+LHS3stImFfRR5FmOGWysUcsCjVGmSEAZmNk7
	rdAj+9yYcNNokWMOnDKbMPaPKeg0F5hNwVWUyjloEx6HKc5xWdW56jv99yh9a0ba
	GaWO1SXFCYV5++PTOSG9twTS8PdBVGZwmvW/bGDJqvMyGwBoDBsLKNOHxA9JCfOa
	eF3WyjFrVci1p3bORaHApqFYlRNjvOiN9fw==
X-ME-Sender: <xms:s0ECaYVUk41DX6QZkJ_30y0kAIX6z3XQl5xphkFdaSxagrnAPQpm4A>
    <xme:s0ECaTdhcwFWgfmmqISYo7MOA-ayKzLXRp2IjR61cHR_FA9rsDEbaeb2F_ApM23Bq
    KKQQy60a0VneeILp5tfUUqPWO0c--LfD246y0Vfzi_Q7PtM2TQWIB0>
X-ME-Received: <xmr:s0ECaUthPjv5ENe4FcKFQvM6qBtkAjirYCQACWm-jGoAlwwKABaxV5L4vu-w4rjVDN8zu_DPLgzFrxfDTQiuLJNRL4CUtInw50Ey>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieegvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:s0ECaS_5vYXPvE3J4z3_ME0VADgf0B7Ln6gtArn8iqfB33nNHgn4FA>
    <xmx:s0ECaf0PLU6qZyLjLzyzqMgxm61FAhY5mzNxGIAy0ZMKlvDl-cgsTQ>
    <xmx:s0ECaXB2xeylD5QTsT9LHGWGcIGk94wnASEsF0op7mTow98C94j88Q>
    <xmx:s0ECabdV9d02ZftoCugPXMqS76iVzykRKRHkGdceSRvXNWmS3J9GPA>
    <xmx:tEECaXvAwOVFDofyIls2QS5cFNbYbR046fcpC9Ca3H5dZV7BzGbe1x5m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 12:32:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 09/14] hash: expose hash context functions to Rust
In-Reply-To: <20251027004404.2152927-10-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 27 Oct 2025 00:43:59 +0000")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<20251027004404.2152927-10-sandals@crustytoothpaste.net>
Date: Wed, 29 Oct 2025 09:32:50 -0700
Message-ID: <xmqqqzulacst.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +struct git_hash_ctx *git_hash_alloc(void)
> +{
> +	return malloc(sizeof(struct git_hash_ctx));
> +}

Not an objection, but this looked especially curious to me because
it has been customary to use xmalloc() for a thing like this.  Going
forward, is our intention that we'd explicitly handle OOM allocation
failures ourselves, at least in the Rust part of the code base?
