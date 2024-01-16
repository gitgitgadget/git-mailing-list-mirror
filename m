Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DFD1CFBF
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705445149; cv=none; b=bou536MlsuDOCJG2MEBAw6/7AgmsTqkWDq3rFjGFKpksUqd8ULNkM0WKmVTt5oRYFopq09lpMM4JI5sQgmBq5alAJ2GWV0iRE+qQd1lZGnnqR6i9RHhLzjWy+PnO/kAxOPtCHILuUfUvJ+6qCLRd/Re6SsoJuq+s07ilbs0X7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705445149; c=relaxed/simple;
	bh=+sHiR4kS4c/0cVZA6r8yfBsVfEYZTJkbJpovmMiDF2E=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=h7mdQso+x8P5gxdXX1mBAH6z7V98ucoynK6nG6R/mfxgIMPzDeaUfjB5ABTVW/uY0HUHAw418Zk68whw+i4NLfG8Bxz4h3P2wzgzI6CpxnB1Wgd0zGp5SeIXD7uSXLAudYnG8bktvSG1ZmP4felJMbBIZ85QgMJmnFMtAnudPbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KqNsykcO; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KqNsykcO"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FDB51A52E;
	Tue, 16 Jan 2024 17:45:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+sHiR4kS4c/0cVZA6r8yfBsVfEYZTJkbJpovmM
	iDF2E=; b=KqNsykcO3brrt8PO9AMdPyk0zi63I7J2dfsOkEQjcZO6nyIb5xWYg8
	0X6ATOFIjhz2r68/P81UnV1cdyg+6KzvhdheA3WitYsauKGDucgoEBvNASYbruKn
	ghlts/NfQCXByWA6/phBpF7+qJg11V6fZNvCs4jKfRySVQ5PcjcLo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 90CE21A52C;
	Tue, 16 Jan 2024 17:45:46 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2437D1A52A;
	Tue, 16 Jan 2024 17:45:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2024, #01; Tue, 2)
In-Reply-To: <Zabr1Glljjgl/UUB@nand.local> (Taylor Blau's message of "Tue, 16
	Jan 2024 15:49:24 -0500")
References: <xmqq5y0bcjpw.fsf@gitster.g> <ZZWOtnP2IHNldcy6@nand.local>
	<xmqqa5pm9tnx.fsf@gitster.g> <20240113183544.GA3000857@szeder.dev>
	<20240113225157.GD3000857@szeder.dev> <Zabr1Glljjgl/UUB@nand.local>
Date: Tue, 16 Jan 2024 14:45:41 -0800
Message-ID: <xmqqfrywyk16.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FAED4BD4-B4C0-11EE-ABF9-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> OK, everything seems fine thus far, until we inspect the value of
> g->bloom_filter_settings, which is NULL, becuase of this hunk from
> commit-graph.c::graph_read_bloom_data():
>
>     if (hash_version != 1)
>       return 0;
>
> which terminates the function before we assign g->bloom_filter_settings
> for the existing (written with v2 Bloom filters) graph layer.
>
> I don't think that there is a way to fix this in a backwards compatible
> way, but I'm comfortable with that in this instance since we don't
> expect users to upgrading to v2 Bloom filters and then writing new graph
> layers using a non-v2 compatible version of Git.

A big red button solution to avoid this would be to uprev the
repository format version once you start writing v2 Bloom filters
anywhere in the layers.  That way, existing Git clients would not be
able to touch it.  I do not know if the cure is more severe than the
disease in that case, though.

In any case, at least, we should be able to prepare the code that we
teach to grok v2 today so that they do not trigger the same segfault
when they see a commit graph layer containing v3 Bloom filters (or
later).  Then we won't have to have the same conversation when we
somehow need to update Bloom filters again.



