Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912D1D523
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705448563; cv=none; b=IIfCKqIo4O8sEx1coIWKGARDI9w7JJ/BNEirVheFgqu4nrzReS+xRxTFDndU1vnnX+eVib9bAwW//KmG46+odb98e065eoq11lMmQcIQu9WA2bCH3Iw8K3gqkIHLRGJhD9nRsv0l3vcZhAgAD2gXY7F/mbgvB1KttoPmyyHmrmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705448563; c=relaxed/simple;
	bh=C9IsWCryPs8CmEXFuSEQceKiM4ZGx5yYJLDH0+NgD18=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=SkEjPbdKpFAlKYb7KtBxsY1Re8KZxs18ZVnmRBD75qnsavHwsq/z1x1ZJIKkg01a13UiSPPdnZRIkjXpIFDp3LNAhaOnlNNoixQSSE2id5Z/AJ6BRXLCJF1yRxjGf8bmekAnryR9yUd8t76krnLMHqqe8/QxwRqQZKKk4xRDI1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XuzsJHOC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XuzsJHOC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71DCA1B8890;
	Tue, 16 Jan 2024 18:42:40 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=C9IsWCryPs8CmEXFuSEQceKiM4ZGx5yYJLDH0+
	NgD18=; b=XuzsJHOC0pp0Pdzmqxs8NtJ+gewQOv5s8smRzkPfGlvvHmRTtSgbSU
	QV+ZlAXYSijnXV0IOeCDy5Ia785K2B1Qtqs2VF5Vk01M/GFYh5aC0xYZB9wZgRWA
	xY4XuJ9ktNeYZQ1gub5pwtB85w6k30pAMVjZ/ecnGGZijfbkCGXLI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 69EC01B888F;
	Tue, 16 Jan 2024 18:42:40 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4D811B888D;
	Tue, 16 Jan 2024 18:42:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2024, #01; Tue, 2)
In-Reply-To: <ZacRx1rbESvYiVgN@nand.local> (Taylor Blau's message of "Tue, 16
	Jan 2024 18:31:19 -0500")
References: <xmqq5y0bcjpw.fsf@gitster.g> <ZZWOtnP2IHNldcy6@nand.local>
	<xmqqa5pm9tnx.fsf@gitster.g> <20240113183544.GA3000857@szeder.dev>
	<20240113225157.GD3000857@szeder.dev> <Zabr1Glljjgl/UUB@nand.local>
	<xmqqfrywyk16.fsf@gitster.g> <ZacRx1rbESvYiVgN@nand.local>
Date: Tue, 16 Jan 2024 15:42:38 -0800
Message-ID: <xmqqedegx2tt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EF73C9B0-B4C8-11EE-A2DF-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

>> A big red button solution to avoid this would be to uprev the
>> repository format version once you start writing v2 Bloom filters
>> anywhere in the layers.  That way, existing Git clients would not be
>> able to touch it.  I do not know if the cure is more severe than the
>> disease in that case, though.
>
> I tend to think that in this case the cure is probably worse than the
> disease. I expect it to be extremely rare that a user would upgrade to a
> modern version of Git, write commit-graphs, then downgrade, and try to
> write more commit-graphs.

But then the big red button solution would rarely misfire for users
because they will not downgrade (and see "gee, I now need to stick
to the newer version"), no?

I am not seriously suggesting to do this, but I am not sure if
documenting "don't do this because you'll break your repository"
is sufficient.

>> In any case, at least, we should be able to prepare the code that we
>> teach to grok v2 today so that they do not trigger the same segfault
>> when they see a commit graph layer containing v3 Bloom filters (or
>> later).  Then we won't have to have the same conversation when we
>> somehow need to update Bloom filters again.
>
> This series should accomplish that by loading the Bloom chunk
> unconditionally, and only reading its filters when they match the
> given hash_version.

Good.
