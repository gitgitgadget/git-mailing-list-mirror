Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2857B242D66
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745409434; cv=none; b=mJEcZBDyabZCkoH2v2knQ9nPVkNrK9XXaujg+4yjOsxEvyHtcwaS774fERPDM0efa3+ssaCUzl4ArlnE8it7QQ/LRb4JY9i+eKGoevn+GQxhARkgWydIHbfSYyRxfDBkfFwzxMzoYnqM7b0+Rv0fCsp6Jz8deQ1BEtkhuASfDlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745409434; c=relaxed/simple;
	bh=HG+ndd/1GMHAhSDZFlRpWOyQzAGVDIp5eZqk0O43U8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvxCwm1BDLj/Tqyrd5JK1ii6GPqy9pJ5SSB2MKHJyIUKCOxGgSheHosb204Qwsk5OSv+Uik4kgHii8U6ZwCo1JYoNUEZREzr0KVPS9r6GhPV5FDdFeSHPLmSxE87TOOS9y/qycDukusdstb3yRAXOqPA+inMw3jVZo3q0R+98Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j9bsQVwL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vkGaZPhV; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j9bsQVwL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vkGaZPhV"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 17A7E1380505;
	Wed, 23 Apr 2025 07:57:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 23 Apr 2025 07:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745409431; x=1745495831; bh=7pr0NRAjFe
	e/nfugiQ+C7nTIBpSvOsLLij+CCSJXslc=; b=j9bsQVwLH3AalfaeD07o6xAtN5
	0555pvBzIzNKBl67R/5auq2Hh7Vhf1gUaadnHBR1+TlPt0KIFjjEO+VrzmBJoTtj
	bS8JP/YcCT33xY6Jc1fVZbS0/NFnMkqNAOqiFLDvO6Vo+RhDIjwl6NPEdEYi5kKx
	gwfZ0Dbf58qjFxs01SjLTOdhmuE+NByBlmoV9E/V/sYbI0BxgiPnrXRL86H60etR
	ZBmn+g3z2Nw+bO8inJbb+RbY+9nJ8pOZtWcFKLxHP3+MavV3AwQX12rL/sucmanj
	mIgAk9BOEsOabxJsofHKyShoGm5fv+1PLN0ZrfUYcB4K5LqgPvw+EE+rJ8tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745409431; x=1745495831; bh=7pr0NRAjFee/nfugiQ+C7nTIBpSvOsLLij+
	CCSJXslc=; b=vkGaZPhVJoZhACBYk5tT9exrgFuwZFB6ctCwB9b/TMXSEqUrpYp
	sAWVHPcoek4zQPwvGw3p4cmIT7t+dK/yZXNgcDglx3DLe7eP3EYV/Pddqkf3IsI2
	ykRxoqr/SXASP0duQKBy12BzWwfc9kT8Kz5mMG+K0PQeXGfHoRPqlVpJWA1aCkao
	BsxB0jQGHOi23QFQDf2LPJeA38efjiuufw2c6Dl9je1JTvHbvp5I4iU75sXwQQra
	J7+qarbcrhImGFcUHsk1OClvNKnbgfsNOK7FVQb9GnNx1z6+Ow0zzG6L4UL26EYA
	VcYZ19+/iYfmlP25l4TPjMk4QqZMZiVWAyQ==
X-ME-Sender: <xms:ltUIaEuRcJsCOL1c76vJ-Va_lJtU5iMi9IbxmJZP9PVoKJumOkU0Uw>
    <xme:ltUIaBdbkZSFj7PvTiBFZyc1J0kfZkmz99EX9wR5CAKaHU4Cf6-SwTgTA2hR0AEMJ
    n7Pupek9wb30ii70w>
X-ME-Received: <xmr:ltUIaPzKTrzypqDzvL5bUyo9MDNXxfkhPlZVbUoEpsNKLwATufkm4fbUtQDCZZB1e5YmWR8_9YckbQAvDKcamkUj5kw_y5UKtou8h2d1Yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeiheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeegjeeigf
    ekfefhffegledvueeiveduudeikeejfefhjeefieejkeduffekfeehieenucffohhmrghi
    nheprggujhhushhtmhgvnhhtshdrphhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ltUIaHNBHuWnCw6UTKEbR6QKRMLOH8gDl1mYLwLgNJmAe0hnLbLt_w>
    <xmx:ltUIaE_09giCLyS5gn5UJzVHUFw5KOc8yg2q6YB-x6ofHhD6UcEB7w>
    <xmx:ltUIaPWbX-zvFXXFV_U1mRmLRvhNKFGT27SawXqWqgpSZXdUdZaIqA>
    <xmx:ltUIaNcWTTn6Jon0YQ8UIkzxpZt4e89Ff2MxCL5Kz2iP2ukH8orw7w>
    <xmx:l9UIaAstd1uwihzAtAuAFYLdgU-WtkcSainqbBMKnDah9bCzUsOMa4yB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 07:57:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a09baa4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Apr 2025 11:57:09 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:57:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2025, #06; Tue, 22)
Message-ID: <aAjVlMoBZxuo8YZH@pks.im>
References: <xmqqselz1tl2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqselz1tl2.fsf@gitster.g>

On Tue, Apr 22, 2025 at 07:48:25PM -0700, Junio C Hamano wrote:
> * es/meson-cleanup (2025-04-21) 6 commits
>  - meson: only check for missing networking syms on non-Windows; add compat impls
>  - meson: fix typo in function check that prevented checking for hstrerror
>  - meson: add a couple missing networking dependencies
>  - meson: do a full usage-based compile check for sysinfo
>  - meson: check for getpagesize before using it
>  - meson: simplify and parameterize various standard function checks
> 
>  Code clean-up for meson-based build infrastructure.
> 
>  Comments?
>  source: <20250421175247.240971-6-eschwartz@gentoo.org>

I had a couple of comments, but overall this looks almost ready to go
for me. I do expect a reroll with a couple of small adjustments.

> * ps/fewer-perl (2025-04-16) 5 commits
>  - Documentation: stop depending on Perl to generate command list
>  - Documentation: stop depending on Perl to massage user manual
>  - request-pull: stop depending on Perl
>  - filter-branch: stop depending on Perl
>  - Merge branch 'ps/test-wo-perl-prereq' into ps/fewer-perl
> 
>  Reduce requirement for Perl in our documentation build and a few
>  scripts.
> 
>  Will merge to 'next'?
>  source: <20250416-b4-pks-drop-perl-v2-0-bdd0492e9498@pks.im>

Fine with me, I don't plan for another reroll for now.

> * ps/reftable-api-revamp (2025-04-07) 17 commits
>  - reftable/table: move printing logic into test helper
>  - reftable/constants: make block types part of the public interface
>  - reftable/table: introduce iterator for table blocks
>  - reftable/table: add `reftable_table` to the public interface
>  - reftable/block: expose a generic iterator over reftable records
>  - reftable/block: make block iterators reseekable
>  - reftable/block: store block pointer in the block iterator
>  - reftable/block: create public interface for reading blocks
>  - git-zlib: use `struct z_stream_s` instead of typedef
>  - reftable/block: rename `block_reader` to `reftable_block`
>  - reftable/block: rename `block` to `block_data`
>  - reftable/table: move reading block into block reader
>  - reftable/block: simplify how we track restart points
>  - reftable/blocksource: consolidate code into a single file
>  - reftable/reader: rename data structure to "table"
>  - reftable: fix formatting of the license header
>  - Merge branch 'ps/reftable-sans-compat-util' into ps/reftable-api-revamp
> 
>  Overhaul of the reftable API.
> 
>  Will merge to 'next'?
>  cf. <3okrcl7bdpy75hzyzpmrp7fluan4n3zvsroioq64id4a2kt3o4@fc6fetilb6y2>
>  source: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>

It's been cooking for a while already, and I have addressed all feedback
I received. So from my point of view this can be merged so that we can
finally start working on `git refs verify` for the reftable backend :)

Patrick
