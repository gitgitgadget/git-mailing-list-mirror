Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7638280309
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032461; cv=none; b=qd8wQiXKtoKy8VivKtRRlzRhEleV8HHq9fqYIRIUGdDiMxoZWo2a0G1JKKcJEb6uzj70O+4ko2Ug8JLklRm5P7X9/yAkCThlb8uPN3ORo/wsu/Ff6P3DD1TOvZBVKrYctDPK5KSikwsJvq0J9GPUqXhf4qvPdyVTpiBnD15FdjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032461; c=relaxed/simple;
	bh=wJtpqiaUvonEGI6HMXn6sP613IeX81LibA0ktfaw3Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B77OSn6gQQoqF09HnQ3AAj0rJlyCXxQJDUze5T8wsEPdBM3hf3i0cdYvFoIfueLW3pZBYwNCmMwwwgLq2e7ifq1ZXJ5hvrzL4zkXhO0UB1IjZAymGE8EH18g6LUc6m6kyVBc/GZwt1gr9UHHG46QqCMFioEIpU8GJ/w1PhDdwBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lXsMbKiR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pGvpqCmW; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lXsMbKiR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pGvpqCmW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 05805EC01DB;
	Tue, 21 Oct 2025 03:40:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 21 Oct 2025 03:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761032457; x=1761118857; bh=yAizgMziVE
	yROzHsQKYnaM0zZ1vVj3k5y65kGN+Sd8E=; b=lXsMbKiR4ATf0rAEXnHE3y+AZb
	3ZBS9PWyGedqj2N3PAjAO3VQ4YcP/tjRo2jt48KC7PVRQMqc9hrlFrZ0gf7sgRPK
	DYNA++7+yi0UHmkPID2OdF7KVUYsqMfDiDRLsGLgTIzLDUZxRopshhh9+p2/SzO6
	xvD8AoR+sJnB9Y/Hp6VpmUzJ+0k9Bop9DqrvCZdVGgMDK0x1vEMq2EUKnRuoBO1l
	KzUyK/9nOOLoSJgMfvJmrp8/drWOayGUnBY3PVUio9QCMVAmX85hB/oGJEnK6ch5
	82d5/QFtlj35+VgwhHVFhJ1qYfgAgBShH4G7AyhDPZzOk9zQ+ypyttMvXahg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761032457; x=1761118857; bh=yAizgMziVEyROzHsQKYnaM0zZ1vVj3k5y65
	kGN+Sd8E=; b=pGvpqCmWgAgMq/uIpt3bT1QGqj+2QP0e7qIB429J8saVbIUevgF
	xmnr+fkhvMeX4z+W7EzEIHDOj0L8A2b66wJtVKYOYRT0JvR+EIqqr78QB58VGu9t
	JUnABh792Tbc0bqyPyH49+n0LW/P1CgXov8z1DSFPoi2ByEa8Ws4q+7rXVu1fOua
	JTLdDk5rrt63uksI1kF4/2CmhiWvKMdZzhfmyPkpcAT873jW6EAVu0/pNOcgzd41
	KQQV0EYuLTwOzqA0JxwMnVUoHzK3q8Uo7HHT+uJgHwmxkE58dW7fpg+dfGJ/flf9
	j7Scht++G0sMy9yGoYbqfGIXy0Ss4emo1jw==
X-ME-Sender: <xms:CDn3aFxJa6ABxNsy7LH8AQpqMzJgglRl8N4tIY3cteA5bg3Ov4xcrQ>
    <xme:CDn3aEXfz6iLGuY9VPhYHQLgbAsIZfz53n6_8eQgl7uUqpy-jSVuGDKsbKgh7s5rv
    Ng9-WSBD-dDSQw_vhmprmgAT0Ez50ZlECt-jKEgiYNY5l2lOvP3DA>
X-ME-Received: <xmr:CDn3aFjMQuBOsmodQQjZMaYOB_VHrdI5F0YCVDNozD4-KATaB6uqkO9PnGRJ5RBdJcuf2qskmK8KaEXZgbH9PI9dR6l1aaccfeN1tgYtP9x3UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfehtefgveelhfeuueevuedvnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgr
    rdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    shhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvmhhilhihshhhrg
    hffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheprhgurghmrgiiihhosehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:CDn3aEAvEaYffg0VA8gfsLrtdZAhh9V0Qjjq51wZYf0m8_HmJTHifQ>
    <xmx:CDn3aLssA11OR83AcIt7LRTSWCBXj8U4LYRcKJT1KsBYA6pnOc4mnw>
    <xmx:CDn3aIcLprujtRZ6T5m13gBGUx00LEHKKBTnLljKLS7F_JzKNiEMOA>
    <xmx:CDn3aA-DRUmwF5DR-bth9e99bALSRQevMjnWWPdogYe1F8D_0kl3hw>
    <xmx:CDn3aG_Aw9W3VcSPCtcQ5T0Zt0ph-aSEW5YBCgFqCbIPPydfl4OHzV9A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 03:40:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f512140a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 07:40:53 +0000 (UTC)
Date: Tue, 21 Oct 2025 09:40:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 00/10] Convert remaining hooks to hook.h
Message-ID: <aPc4_Pyd37epd0j4@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017141544.1538542-1-adrian.ratiu@collabora.com>

On Fri, Oct 17, 2025 at 05:15:34PM +0300, Adrian Ratiu wrote:
> Hello everyone,
> 
> This is v2 of the series which converts the remaining hooks to the new API.
> 
> I addressed all the feedback received in v1, with two small exceptions
> (the ones starting with "Opted not to" in the below Changes list).
> 
> I had a minor conflict with an upstream change [1] which was trivial to fix.
> 
> I added 1 new commit and squashed together two commits (the simplified update
> hooks), so in total it's still 10 patches.
> 
> The plan is to follow this up with another series which enables config-based
> hooks and parallel hook execution, where possible.
> 
> As always this is based on the latest master branch, I've pushed it to GitHub
> and ran the CI pipeline [3]. The Win+Meson "missing libgitcore.a" and doc
> "invalid escape sequence" failures seem to be unrelated, since I get them
> without these patches.
> 
> 1: https://github.com/git/git/commit/22e7bc801cd9c5e5b5c4489b631be28e506fec42
> 2: https://github.com/10ne1/git/tree/dev/aratiu/hooks-conversion-v2
> 3: https://github.com/10ne1/git/actions/runs/18593709082
> 
> Changes between v1 -> v2:
> * Added a new commit with a mechanism to override ungroup options (Junio)
> * Addded a BUG if hook path_to_stdin and feed_pipe are both provided (Junio)
> * The feed_pipe cb can be set independently from path_to_stdin (Junio)
> * Simplified the post-rewrite callback (Patrick, Phillip and Junio)
> * Document that hook caller owns the feed_pipe_ctx (Junio)
> * Removed unnecessary "child" -> "notes_cp" renames (Phillip)
> * Reuse strbuf inside pre-push cb to avoid multiple alloc (Phillip)
> * Simplified pre-push hook cb logic (Phillip)
> * Rewrote reference-transaction cb logic to mirror pre-push (Patrick)
> * Simplified the update hook cb by removing the keepalive logic (Emily)
> * Squashed the simplified update and post-update conversions
> * Iterator types, if conditions and other small fixes (Patrick)
> * Fixed a conflict in refs.c with an upstream for loop sign compare check
> * Opted not to use -1 to signify no fd value instead of 0, because I'd have to
>   significantly rework the run-command.h .in/.out/.err API (Patrick)
> * Opted not to move sigchain_push(SIGPIPE, SIG_IGN); into pp_buffer_stdin())
>   because it will called too many times inside the process loop (Patrick)
> * Added Helped-by: Emily Shaffer tag to the reference-transaction coversion
> * Comments, typos, stray lines, commit rewordings (Ben, Patrick, Emily, Junio)

By the way, it would have helped to have a range-diff here so that it's
easy to see what exactly changed between the two different versions.
Could you maybe include that in subsequent iterations?

Thanks!

Patrick
