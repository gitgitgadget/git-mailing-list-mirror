Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D7B44C50B
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913985; cv=none; b=HF9SP9OwKh60gBlcrOA530g4fl/eQM3nbL9sWQ1vYcNeL1lYpxbt7jr9PNEVr/MDb9hGaXpqP7ILtxprsPCiKP0uFCaZGE8+scbbblbaEOml/FrQ89qao3wATH501sec0WSBdU2nWG7wfK2yQ5wLXcciOfDC4+JC22YH7xKyoGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913985; c=relaxed/simple;
	bh=OEw9Yg9++uVHZlgXUjlD8UrOZVTCJWgSThiRb5sR2Rw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p24in9DEneiri7VhuVxJpB6QwxIYs11OZOlCRGJO4wsgUQYwQXB5NZ/foyHOHtyn+5lhdnSQoJAX9TbbjDbErcx2uNUbqWAIdSU7UrBkyQnbmASVf9qPoLQq8YfIBGLB5+tHy71km8WR8fzHNW4niT4obpC69zBGeEtzK3ZfIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uwcIUzBG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P5SO9gye; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uwcIUzBG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P5SO9gye"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id AC01D1D0040E;
	Fri, 24 Jul 2026 13:26:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 24 Jul 2026 13:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784913976; x=1785000376; bh=kps/W/e5Y7
	7v79bSU5PUoQiOFzXOAvRJsQ7l5lqJgpY=; b=uwcIUzBGBQXJtgxRTrvqA8Pgnk
	xhiVNJRn1jBNBReQXC39eiMBUrwWDugdEM2hEUix2BkQ0YfrU3SXFPJ126rc0t4n
	w3glHk/OCwzyAApvdj2+3OQ+N7KOytw1My+O31zl5B3rfsFp84XCxcfpkLO/rWSQ
	gV3IeGv/MmNIOOZsEiFU29J2+PUGixhvAhe1HCMj5fQ4YF7wjdYgEL7VeVorC+15
	itZLrjckmphz6bgEYFZbmAlURfoijKdQlKr4UALzaYhMEoqVQTW5qB2lft0tJypY
	d2umXmrPwSIDrIt3OMzxuFFi8SOj3vkKPev6R/hsIu4vj3vxWFk10udqoUmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784913976; x=1785000376; bh=kps/W/e5Y77v79bSU5PUoQiOFzXOAvRJsQ7
	l5lqJgpY=; b=P5SO9gyedwWIT7lfRQy+0iNjv/+dge9rXKYF254Wr4DRRN6+aJF
	eS8YmuSvSwu0y+XXQ9GHWAniF8l9tRnaj0D3LlC7QE6uH6t/KZ5V2vJ4SlxlBPAS
	YCju1wbP6z1aJGp1IRDrcpxb6DqjyKaaO0PcFNo8HCu5KjQTgchffNMHIU7zONUQ
	qW8OR8ZFPTg5zvjPe8+wGjabH99ugyJFfU8IOccnRwARh+whpdSWCxr1nyD7E1FH
	KkhYq4w+w7Lf77gQU3idf6jA3Y5BOA/rcmA85olkoCqBQtvcLque2NJPZXAWopcl
	/cV4C+YHFxvFehQHVnRpSiEHmOPCjPwLd9A==
X-ME-Sender: <xms:OKBjaji6_7dcoAnp58dnbIomlRN6wnfqwINzzSadxhI3lbhmtxfpXw>
    <xme:OKBjaneRogaKr47_Rv_J-Y--IxRNn2kXN6bHdvymynamAXYEQ9v2T86rJW-aRR_ew
    a6OlBWxPWhOjOuWhkelQi4npwAMKd8kwteTO9wUsPYyIsRKo8-qy3k>
X-ME-Received: <xmr:OKBjagfiGmIlcQeXmQ3gw_RP_bSTXPFwjfkZeSeQvm-vN4Qt6e1veE1rcnLbUulCIj9ZAoO_Fff6Cvs-5aK4RNcaK8TN-YP-2w>
X-ME-Proxy-Cause: dmFkZTGQJcg8w2MM53Yv/Zq05YIld54lBf8oJrz1PsfWNSNglyvmqZCaxFgS20+BCHlbUq
    Zl0E3GLqff6w7gELUSed8mv2kYo0awHpds02pt9Vij4kx+qioZOjZLmlvjQoSS4vtHmv1t
    AY32Oqy3vlAeVC1JaU8/+R6MwhwAW1LVuUvYWKJWPOjANu1j6ERajV9uvDRbPyp0qo2hG9
    HfcS+ylh9YqDVr6FFGk7SKpSp8RGh5ydb6fPr2G/o99d8ZZ3zZGY1ccYDcV2cpHASMEtKP
    5cNrZG7fvmW4f4SlTpSJ9Cv8A1qigZ5jj2VbnM7ZaMa9wsN8Fnv+k13+SSiolPX3ClDGNd
    3C2Dl8Cpc7eTz6yB9KSkSP7Y/nJvNHffMbMkJZZ6VtjaiwqU0i1uYNUeL4zI9aXpViWkhm
    xD0a+2GFHuqC4SalLQg0U7YaeWLdptvBikKV4fEM0uI43F7qEhoV6bQSB9q9W0drnGeYTc
    fPxWIlLVR/5xuww5wpQaP7/awHa5N4dEzcLgsKJ+meH6aL/UZQXVlyWGwMkW3qn9AZRGvW
    UyZBYg5gQv2euXJPUYzKu6pPJwCP30Fv6VkQ7mLRjXhI8gHrQS2FGyDbpqG6RhUht70tH9
    aCv59jNJlJdrK+HtgknpRkvbLFCuxtqM5gTp1OGu19orD8CbCzHvvGvf4GYQ
X-ME-Proxy: <xmx:OKBjap8Kw0UyJn2ADTMwwvGp7QjuFPRv8eCsmMf-7dWGKJrK7q6n4A>
    <xmx:OKBjaknbiwaacgISRGC1PkgmO7WVuQeLRin-2qielJb-L6V2ElTN7A>
    <xmx:OKBjaj91bfDn6VG04ztclCNMbgxBkSOzJzPQI2QrXatVhZdhfcdVIg>
    <xmx:OKBjaqmP2NtzS9190c3Fxu8ly_SEE7Wg59Qy6jRBz3UgVyMS9L4jug>
    <xmx:OKBjavkGr0AEVdZ1RbJe2ycpph32CIdeYT9zl_kCagTSzxDMWMs-OMUY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 13:26:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] loose: load loose object map for the correct source
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-1-3b3d265d979b@pks.im>
	(Patrick Steinhardt's message of "Fri, 24 Jul 2026 05:48:40 +0200")
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
	<20260724-pks-odb-create-on-disk-v1-1-3b3d265d979b@pks.im>
Date: Fri, 24 Jul 2026 10:26:14 -0700
Message-ID: <xmqq5x248fk9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When loading the loose object map via `load_one_loose_object_map()` we
> pass in both a repository and the corresponding source. We ultimately
> don't really respect the passed-in source though as we instead always
> load the map via the common directory. This doesn't make any sense
> though, as the function is called in a loop through all sources, and as
> such the expectation is that we'll load the map that belongs to the
> given source.
>
> Fix this bug by instead loading the map via the loose source's path.

Makes perfect sense.  We still need access to the 'repo' to learn
the hash algorithm used in the repository along with built-in object
names, but they are now obtained from the repository associated with
the loose object source, which is far more consistent.


