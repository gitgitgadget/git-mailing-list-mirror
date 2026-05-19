Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD5E360745
	for <git@vger.kernel.org>; Tue, 19 May 2026 05:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779170216; cv=none; b=odgU26zCk18cCHf+57uy1nezq0EZdOyoDveaa8d3T7gy/+/w9b7AdkWwUgaFuBwcn5VYETlCVeFycq7hn/Yu57ZLyFkgWtb2wHsOu3IXcdkDYkPdD060jk4x28yugNDRBZOmMlL1jEQBkE69kTVn1yBlAC70NP8t960kDUb/poU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779170216; c=relaxed/simple;
	bh=eyHfZ8Vnj/6hvZ9Bkgx0IiZlAmeEBGJuyn38NEUOYYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GFmoCG/wSnX9rWdpVrg1ine+gG1XKQnLr8AhBZ9xyholrNY3x9pnZZrXjqMoSL0UkxcSDQ0Pv5r2hFZVOB0ng6Xiz/otH4gg3N5F7zyhSihBlWBrkoyxZ8XSxca0q9sg2FfOHWOuilY0iyzc0xAcJqcrhycXZAYMVWvOAhSa8Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q6Y1XOok; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h66RAQVq; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q6Y1XOok";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h66RAQVq"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 30C01EC0223;
	Tue, 19 May 2026 01:56:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 19 May 2026 01:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779170213; x=1779256613; bh=cK0G9sbija
	XbSb7Wa0lWvq+Zh2/PrId9Lwdd4N1cmUk=; b=Q6Y1XOoklcOTnhFzSCXOu84s+A
	eByQLnpKB8CX+BqloT4rPGwBxZiCVD0uyDOHygur6HrqbpzHYETfsnAvGkuEXxXb
	WzB73l6XVX6EXJbJgCeauFuJsanQ91Z6XN0OG/8ogB//7yPfer0NhF7wFPbynriN
	VILEjSZCZRwCi5H1XVEyb9KJaMDlkOYlN7jY3eryE/imIFK1Fvp3Tc7C2WqyHru/
	ecrNH+wghqEJZbiTr+3cqU0S3DHQSJ49VhE1zn3DdejtXTBUsS160f8zR1h7YxYf
	l775n2SRmFGg+lR06fjLfSdjmlOd5JASiq+30Olyxd1wNc8S8fBO4cXMHRFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779170213; x=1779256613; bh=cK0G9sbijaXbSb7Wa0lWvq+Zh2/PrId9Lwd
	d4N1cmUk=; b=h66RAQVq6DpP64EA5Vex1fAmGAvJ0CP8es6364XvvYlTX9qbJ2e
	dhzQBg5/TKbrNkSAAcL7lnV/jzjLVBt2nM13K0ukcnJ5PCPfeufIsbWzkRJ0v061
	39EwbyYLXOdeUNwYcYuQPwoQY0HVW9/Bdbpsxh1N7SV5Uqa1QwDILpqLpViXKBK8
	xb4rQz2FyZ4WZmsh+fhP7o3syeIo1mTCP7cvm6HBdW9SUje3sQgqpz9MH3HWYRW3
	OfzKpoayJPis6Mr8lqXorRxMc6VmyxFXx2fFV6LJAzD/NDI4DKUIjsOcaFnhbxls
	uJHMywLT3zZ8RyfqG2Ge5IFOUmZY/bbl+RQ==
X-ME-Sender: <xms:pPsLapHN2odkIENJoSh0iGIXPVgzWZYXCk48VA6jxGUc757-LnSQ-w>
    <xme:pPsLalOzsse-6MKs6jkbB-bY8UUle-J2TKOND8VzIBtToUGvQLQ0WT_huB3EBDg2X
    pzN5XUDmRr8O2ET4a-HJOOj5NVFZLz95mxjuTMt2jFYr1GouvKPGw>
X-ME-Received: <xmr:pPsLajd_yYEWfBJWL6t2k_tj8Df5fsKziCGlAUOToidYl05CCPyqYWfMIm6EXZF7EkhJXXlvRFDRC7hAwkxHQQi7jyybt73QQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedtleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrvhhisehprhgv
    vhgrshdrughkpdhrtghpthhtohepuggrnhhivghlrdhmrggthhesshhushgvrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pPsLaqu-a8kWX7ymHgNyrPm6m3dqg3SkAdZs4K1d3-HFR6_m7AM6nw>
    <xmx:pPsLasmN59SxOyvpKVSON5SyDq5DmnjdmIrKZ81E-kGXvcXen6vDOA>
    <xmx:pPsLakxOQreSXgPqB950GCvjtxPGaQwdv8MaQp47bl0QSUj6psPTlQ>
    <xmx:pPsLamPm3AUqJKQncXe1PUD-v6jMuqhD6uM9FMelavYRyNVd-Qh0jg>
    <xmx:pfsLag1m4nBykkDur6dnIXaHj0u7fp7SbLSwN6tipC5NhWwe9NPmClOn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 01:56:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Rasmus Villemoes <ravi@prevas.dk>,  Daniel Mach
 <daniel.mach@suse.com>
Subject: Re: [PATCH] commit: fall back to full read when maybe_tree is NULL
In-Reply-To: <20260519050513.GA1635924@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 19 May 2026 01:05:13 -0400")
References: <20260519050513.GA1635924@coredump.intra.peff.net>
Date: Tue, 19 May 2026 14:56:51 +0900
Message-ID: <xmqqcxys7xi4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> It also means we have to reimplement a bit of the commit parsing. We
> can't just use parse_commit_buffer() here, because it expects an
> unparsed struct and wants to load everything, including parent links.
> But we don't know if the parent list has been munged during traversal,
> so it's not safe for us to touch it. Fortunately, it's quite easy to
> load just the tree, as it is always the first line of the commit object.

I was hoping that existing code to parse out the tree in
parse_commit_buffer() will become a call into this new helper
function, so that we avoid duplicating the logic.

> Moreover, this strategy does nothing if we lose access to the graph file
> unexpectedly (e.g., due to a system error).

Or simultaneous repack may lose the file from the filesystem,
perhaps?

> +static void load_tree_from_commit_contents(struct repository *r, struct commit *commit)
> +{
> +	enum object_type type;
> +	unsigned long size;
> +	char *buf;
> +	const char *p;
> +	struct object_id tree_oid;
> +
> +	buf = odb_read_object(r->objects, &commit->object.oid, &type, &size);
> +	if (!buf)
> +		return;
> +
> +	if (type == OBJ_COMMIT &&
> +	    skip_prefix(buf, "tree ", &p) &&
> +	    !parse_oid_hex(p, &tree_oid, &p) &&
> +	    *p == '\n')
> +		set_commit_tree(commit, lookup_tree(r, &tree_oid));
> +
> +	free(buf);
> +}

Looks quite straight-forward.  Don't you need to pay attention to
r->hash_algo and call parse_oid_hex_algop() instead?

Or are we pretty much sure that "r" is always "the_repository" here,
in which case parse_oid_hex() that uses "the_hash_algo" would be
sufficient?

Thanks.
