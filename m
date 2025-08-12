Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DD4280023
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003168; cv=none; b=Dghyq27ARZGYpJYU1gK/7yZ/axGTzlrIY3GENPdO9HyiT6g3sK8ahqVd0o9EcpwYcdPe0/9iSJpT5jiF3sUh6z7323OidQBk0jmrXQCgRZ0vX8f3rX0ofldyg62We9LMYffOEnS9npeir3NZxQQ5cA3YEyUTQCd0avcit0cqJ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003168; c=relaxed/simple;
	bh=n1/8TL7mXYXYzSYwpp+7ZG/Vhhij3mhOWvbAMAt/5FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzSNHf+uQil2Wu/JQPwpj2K0TgNjQLQhmtsIqvZ1RdrqjzcweuZaHPpEgg/vU+hPNECDYbWCg450XEVlUGCkR++xaBqDUyfkPwaDg2qgWjwAde3UK1rTtrbFpkQ3mkSS3KBugaR0yE8d0RyzvYYYJwdrKxwMsldwaxR6NEnkgvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TDr4UoPK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ge6CiBaM; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TDr4UoPK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ge6CiBaM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E6A81400138;
	Tue, 12 Aug 2025 08:52:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 12 Aug 2025 08:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755003165; x=1755089565; bh=K05USBaceV
	gYkGUbdsPUnSO5prcOXdk4W6+26jUPtio=; b=TDr4UoPKhKwyjszgfsh0tQODaO
	FKAPDd2bSdGDp7CUFduXrt1ArH1o4yayGoXLiEzkfPF9s0bMg1YjcfEgJ0vzjJEq
	CniUGIuFoQP2fAo8lCFHqXgH9noVvN5CPGtBJzBHNGrLqfiOVNIQcP/1GZPaXYmq
	RRLSzo5PJysl+8uMpI6YWL4Ktz2SRmAIAT8FgzV9HdBz6YGkhgJMYXOI2JjZRIsM
	wJByjqn0pC5MFkBfxfxSmNhAh7X7DvzHgYoaurUXKcpiE+aimUgqVCDVhSHcxrsl
	5gDsH1na5tlx6lCqMyXELZ6C2iYnLsyBf2Gy087+PgSYs+czkKBFm7VJgH7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755003165; x=1755089565; bh=K05USBaceVgYkGUbdsPUnSO5prcOXdk4W6+
	26jUPtio=; b=ge6CiBaMXAhAZgSEpU0DFMC/jAGiiqVoiEc35zQgddBpyMShHs8
	sqhHpLa99UgaxLOxCEXoz98qP7+LJwGgo1mpqjgmhN6mjoNQX/uZ/eQRY25cLQAF
	+yNdzvfJcEybrORpvRJEr+gEPS2cDaN3az0B1IQ6x2nYb4ysw72y9YZ1OXPg5vw2
	MxaUcGaFALhJQFRNhOF+nE15gx1ZHIgXZxzcaOrD0BpjrMMXkQdfkwIueYptfoRO
	GPcEsxNOKLdyeDlL5HaZzzStSFNGE6Tw017l6RQRPoPNW/PR/wXn7Pdx5klWREtI
	tGw9DYLGsHYzN63LOI+wA9xZjr9RVUzaLIg==
X-ME-Sender: <xms:HTmbaDP7eTXtUA3ywofJpIIcobKp0xJenCdj6K8Eer0n5dYyqqQdxA>
    <xme:HTmbaOK87F1HE4nQ-GjJDe-VnYAUyB4G-3FqAEacAfVM02GAuQlqn0xnRvNUShHY1
    qhuGM9juxn6DnaUBw>
X-ME-Received: <xmr:HTmbaEHBsfMVw72XdUK3BLHAsg84ZqyCrgbmTiG-QSbtrfMQryfObXly4GLvVd0VSqD3MbtKczX22OmCKL8sKWvds4bD8eIMGSiHUDAu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefvdekfefhudetfeevteeigfeutdfhheeiie
    efheegvddvfeekhfduteefjedvjeenucffohhmrghinheprhgvrgguhidrthgtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HTmbaGQsAua3hfZ006Uhp3XSGDsN9rQ5PH4w3VRmMc7Ac4btFmb_oQ>
    <xmx:HTmbaAGqliQr2IlfE1BFuhXrXjduXzyG3pUVe7PiiNsb_moA3c9a4w>
    <xmx:HTmbaC_7Y2NyjU5DorJFZz9mh_a9tuHS7cJ5GGkgSio7aVV1sbsWMw>
    <xmx:HTmbaKIkZCiXThvyVCJE08zRHVhb2fxKT_fextHbllPRGh-nsqHTEw>
    <xmx:HTmbaFyM_1NeP4v7FCQbmSCcoOjcod7J5sG9I-prNPtMxAlQBRyGp-Xk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 08:52:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca606707 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 12 Aug 2025 12:52:44 +0000 (UTC)
Date: Tue, 12 Aug 2025 14:52:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #05; Mon, 11)
Message-ID: <aJs5Gee3ZVCJX8dk@pks.im>
References: <xmqqwm79x7ra.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwm79x7ra.fsf@gitster.g>

On Tue, Aug 12, 2025 at 01:29:45AM -0700, Junio C Hamano wrote:
> * ms/refs-list (2025-08-05) 6 commits
>  - t: add test for git refs list subcommand
>  - t6300: refactor tests to be shareable
>  - builtin/refs: add list subcommand
>  - builtin/for-each-ref: factor out core logic into a helper
>  - builtin/for-each-ref: align usage string with the man page
>  - doc: factor out common option
> 
>  The "list" subcommand of "git refs" acts as a front-end for
>  "git for-each-ref".
> 
>  Comments?
>  source: <20250805092758.5321-1-meetsoni3017@gmail.com>

I've reviewed this version and am happy with the result. From my point
of view it's ready to cook in 'next'.

> * ps/commit-graph-wo-globals (2025-08-07) 10 commits
>  - commit-graph: stop passing in redundant repository
>  - commit-graph: stop using `the_repository`
>  - commit-graph: stop using `the_hash_algo`
>  - commit-graph: refactor `parse_commit_graph()` to take a repository
>  - commit-graph: store the hash algorithm instead of its length
>  - commit-graph: stop using `the_hash_algo` via macros
>  - commit-graph: fix sign comparison warnings
>  - commit-graph: fix type for some write options
>  - commit-graph: stop using signed integers to count Bloom filters
>  - trace2: introduce function to trace unsigned integers
> 
>  Remove dependency on the_repository and other globals from the
>  commit-graph code, and other changes unrelated to de-globaling.
> 
>  Will merge to 'next'?
>  source: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>

I don't intend to reroll this series for now. As long as you are happy
with the signedness-related patches I think this should be ready.

> * tc/t0450-harden (2025-08-08) 2 commits
>  . t0450: add allowlist for builtins with missing .adoc
>  . t0450: fix test for out-of-tree builds
> 
>  Test updates.
> 
>  Expecting a reroll?
>  cf. <xmqq7bzdfoxe.fsf@gitster.g>
>  source: <20250808095943.3312265-1-toon@iotcl.com>

Toon is currently out of office, so this'll take a while to be rerolled.
I'll have a look at whether I can reconstruct the seemingly-missing
file.

> * en/ort-rename-fixes (2025-08-06) 7 commits
>  - merge-ort: fix directory rename on top of source of other rename/delete
>  - merge-ort: fix incorrect file handling
>  - merge-ort: clarify the interning of strings in opt->priv->path
>  - t6423: fix missed staging of file in testcases 12i,12j,12k
>  - t6423: document two bugs with rename-to-self testcases
>  - merge-ort: drop unnecessary temporary in check_for_directory_rename()
>  - merge-ort: update comments to modern testfile location
> 
>  Various bugs about rename handling in "ort" merge strategy have
>  been fixed.
> 
>  Will merge to 'next'?
>  source: <pull.1943.v3.git.1754522122.gitgitgadget@gmail.com>

The patch series looks reasonable to me, but that's basically just going
by the commit messages. I wouldn't claim to really understand our merge
machinery, so my opinion is only of limited use.

Patrick
