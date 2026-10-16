Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEAE3DE451
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185162; cv=none; b=Kfsoi4WRtmO6ZmI8G7WDwsjEsF5izSexOPk2UgzxdINIA37chIV7R58pygQDuYdkZqtKyzbJ78meY92ETYv52l55cORurFiuRxaFH9tFA1IcvOUF+If7jJIgh9qq9O6I4KXhRKaYqB8H9mwAx07o1JThs95JiuFqOsHA4AchOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185162; c=relaxed/simple;
	bh=W0SKAHbame1zxXXPn9PC/o42G/0b/aSCoX9O/zUnl6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n7Rn+FD60aufQDfGe/Y+hB0Vq66wvIbGD0wRFJ5eIxEQ6UD/5/KFKXUxDIIyoHUMn7T3wncndHUf612jWaWf/NkQx0c9g/xbo4rvhdirnGnDoJnr8qVkaZ+LTZenKecsvsEKo3NgAxhd/HEpbyuQskrLnu4LWVhPpCpLwqzfjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IUe5Hyta; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cc5H9RgW; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IUe5Hyta";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cc5H9RgW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1876EEC010B
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 17:12:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 16 Oct 2026 17:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792185160; x=1792271560; bh=2KP1K60gUD
	kvZ3HvsdGzpHdTxxDMxAnbXokiC6ygiRg=; b=IUe5Hytai6lA3zSvY3cwNZuIP+
	TOwwV3rmxNXO+24t0rnWbMSmZHHbCJbg5wVmgfWYhbjGx66lTfpfPffqlOOQEE0e
	QpqEyxctl6XnwxJjdJ66IsI4Y5DEoPNmtteBa6aRl8851GFVnyF74cJ6riSCc22J
	DjktCtIxaxpoB7gwC5vo4wgu93xEgNFpNqzdXWbrrCl5EhSYa6eg9jPLJnbXW/CN
	iqVtuHf5gqf7dWOQGd13vPEYSnL8XHvZ+pVP3lCdcejRB83SlmqtJmAbiDy/uHLh
	tjeXI/X9aJ5JDIvB6KNvbMwjUVVspp1d8qZkMC9XJpJV31wANe927vUYFEhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792185160; x=1792271560; bh=2KP1K60gUDkvZ3HvsdGzpHdTxxDMxAnbXok
	iC6ygiRg=; b=Cc5H9RgW4UVsqwj1NYfUcMAW+E/S6WDuEF4aZPsBSth/sCzZ8XL
	KW41SJVTJq0QpoKsgsUBE4FgTkSF7p2T/3GZdpJ0IioLF6LoBtngdMczCt92jmB7
	tNXxD6xPek8rogj6RFUEDg/9l3u1JFxfa6xOmNV9iG3QKLJK6nOoKOIJPpAOz/af
	e/lWOja7VKblw9xF54/dt25vYiH+N0wDjsUXRlPpV//zSa6b5yTvXDOHfjKeaI3U
	az1O9zLafWWqLHypG08y46rATyl/VWzc4/lO/VzdBsiyGjBOMfnnPD4mOlVpNv5y
	QtkI4cJYVibRI2/RdlLCPdf2vnmKjXejxqg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792185160; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Ay5VnL4UCPHN+vYRdCWuyqwv5v3OFw5BxI7oJae5cTeqmuc
	HauruvM9Ymwa7TI8JUxyqjpzXshVSjndyw4+nQBvnRgbfGXkAT7h8eD5PKpkwEWp
	yzbK6Z+G0js7dLq+ok0shb74hiJal+ZJkLfePHSR8QpqiLTtZyxhFDJCm8WmbsOm
	s/ov9LsW6D3b84xp6NE+jqRmebVrmAg5qzpiFHluFngBC1+unqkUnHpX3R9D2lZF
	FZZQ0/bkQT/XhBKuspGoRD9OphJ3ASG2JNGebtlcls9FJwQ8cYvRwURlJeVUj0hw
	NPOCedNZFoIqfHUQdsbUrOzvLGbesn1AfsLmjvw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:WRkJ/xK62qF68LSCpH26JmZdDmX/dNHnUoqXWKMbrhA=:W0SKAHbame1zxXXPn9PC/o42G/0b/aSCoX9O/zUnl6g=;
X-ME-Sender: <xms:R5PSagbnza-8nZv3GK-oCC2oYHEkLqwF77WNiUo1HoCc23IClRhkwg>
    <xme:R5PSavECNP0gcgX6ervXkpzcY1K1D-czpseIqq-y6qCQVN0JO8P3Ay5-euMf5Ncb1
    phK06X9IMo011inZI87q_JXunczta7fWSmuUm7IeTks40cDfWBr9Eo>
X-ME-Received: <xmr:R5PSakwhuYZWY3HWNG-ZleEEw96KViRT8gSYOR_vNbyR_9lCaH-3ioCEH5xXo6G2l3LdGRjhaVjUSk0fFFMmPCkON7PK3voBAmep>
X-ME-Proxy-Cause: dmFkZTF98ngdNF874fRdw2SRngsAFZRBhYfyhANOAw/qjqk5Hgxk2Dd9LoaCcFSJQ7Z+gN
    NuZzGYgTbME36HEzzUe88r4qeR19EWlcTLjoy3j9kztlBm8H0DU3onQOm6Yh3ZiPg6e6Hy
    rzGGWixndyZhy4lAnOn8UHXX7ZEAT2BI0V2AqAal2Cl9AeahnN6LKBgDIguzy34rn1CeiN
    QMnoIRC2C3ub5ZqGmBNZVTjvzZGKaUzJUv8igew7LbVul2VfBui7wFUnys+H/J1nvygi8X
    KJc9Ldvj2GdCux4cdjDKFbWPNYHC/xUGJYFE1eTXyG4Djun8vb7CkBcnxBoa6wux9FfVBd
    nViUpmZB+17/g0Ucr/ZZwwQOqC9pGazJBFvl8SJzAcyfE9o1kMGRvZbO+cUoVTZ4+xLplY
    OPSvufL0Il9X+3CvKSeJZ9zqrmuT8vvszNWgcR5ud4okhdLWXNAe8onV37wxXaHGZ0ey1j
    +8nLcs7n9s0mhJEP3KzavxzV40tqbQillqNfKZnU9x/TzOewIobo3K7P+WQBN2L28mO9HU
    eM28vcH3vpUW/Usr6x4cxo4hhMbZh4emk4yoveCxLASj+UrcD4BHRcNOXv0X4aWXKZqqDz
    SlIEMKVGzT5zXz9wpZ0yEMl9aTc+Z5Z9PIbbSFvx10IPO52mxy4OJEqUbhrQ
X-ME-Proxy: <xmx:R5PSahnlui4BUZa_-zEh1n26vpy2wf7m1x_dqSOAdXs1x3en2QDkCA>
    <xmx:R5PSatnQ6RZXwUhM_aLo60X_3NqACANtYI-y9oQL05Uaj1CPtiu-Jg>
    <xmx:R5PSajwBbRiJ_p4npOw-_ze49MCDncUdm4tv72C-nbN5AL0HZ6MxAw>
    <xmx:R5PSairl3Y42qZn8TqCzL-gXR7witPsBXvvpWAisjScyh3RpwpZnkg>
    <xmx:SJPSaj-eVnl0Ez7RLumxQuqvvxOa5acAtoqee2B5en37Qm-aFnzOaDYW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 17:12:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3] doc: use `man git` to teach users how to navigate
 the docs
In-Reply-To: <pull.2242.v3.git.1792178103727.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Fri, 16 Oct 2026 19:15:03 +0000")
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
	<pull.2242.v3.git.1792178103727.gitgitgadget@gmail.com>
Date: Fri, 16 Oct 2026 14:12:38 -0700
Message-ID: <xmqqcxt9e4e1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Changes in v3: (just updates to the commit message)
>     
>      * Add a sentence summarizing the goals "give a more realistic view of
>        what the documentation actually provides."
>      * Explain why we're removing https://git.github.io/htmldocs/git.html,
>        gitcli, and the user manual, and the data model
>      * Mention the plan to include the tutorial again here once we have one
>        we're happy with

Thanks, queued.
