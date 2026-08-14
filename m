Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0088048AE36
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734227; cv=none; b=h84gyfpldESOZD1fyDLQ+X7tkOkgC3HuzjWcPQcqaeRMcZNsWkhSB7IYDss3qnYnRcmQRINdZhYkzQY0ua+zHruLCHdxmWl2fSHJB1t5GXm1mg4SLu+6EMpB2hyzW+J0UyVVWNn4dtIBfYghRJVX3y3KRrnPJkxXjjduT0sxADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734227; c=relaxed/simple;
	bh=/pcpN50RPgBVda3rM06bhkqqoXBEl+TZjkQHPkNNuCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uxke92kma5Gx9/zbP/SHcJEj/PhsKsDszBXpIimRvEoU4zoPP1NOFYNW4Bz2vN7QhUW8s9qo283lvM/BTXImRJaxCZFm2QmC5PZWIDoH6ogBETNV76qh7zsLNqe6LSDqQ5YTVcK1qVZiyX+STs1vNqzfctdThgXV2Zar/XBqffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C+mJ1mBV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i7OMcOen; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C+mJ1mBV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i7OMcOen"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id F3692EC01E2;
	Fri, 14 Aug 2026 15:03:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 14 Aug 2026 15:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786734224;
	 x=1786820624; bh=fuWv+As0+FOCJfMy6VuRYOuEfk4UAbLc2GW8m2SpjLU=; b=
	C+mJ1mBVdV6vZotSLKlrcrywRtwONy1FyeeWySZxUN2m7x2HxUZjYeJdGbCim4JY
	0yZassxfjkCW3EOizBxKoYh3KCAaKq87vjUjOg0Om0Wq585DLKrcuI6nvpxPGLvJ
	nFaU4iTGY+T4g43W6oH7RXNH2QeY0fU/V4sRBVF0LcBK5K0duOw/8n0mQ5S8GtGP
	w39JlAyVK1br3NoXwUXd+5GMDLn/55FBqj7Am1fWLQfeP4+K8o1qwBE6SRj+ZyX/
	bRcqWTFY3nLz5RjNRlBJPChDjBph8W++KsMkAl4NxdvYCMSRy05vCRtr9FIHynfd
	Ws8/eVFki9gORu1b/89m9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786734224; x=
	1786820624; bh=fuWv+As0+FOCJfMy6VuRYOuEfk4UAbLc2GW8m2SpjLU=; b=i
	7OMcOenC3VMlgxnn+Di4Juv5Z5b/+ATWI0PEvp+R27fuHg0soM9WXffWD4pP/I/u
	TwippYgAfUB63nblIR5QtHAp2TigAi9x3SradzWS5Qfzz3FWQD1qWO9OVUqG3Zbz
	y+N0d+/CHtFwHlzsKpj83XSYRQexfJ2H0MbAPk0mUvi4IFWYpNgy1ZzZTijV52+i
	u3JyEvNksUD9AyMkPNsrq8OqxNROYf5uGQfvDPEJ/+G73crHuUo4MubvOd18Lzb1
	ZqW0G91S6nalUHAH+1z0FrMxUVNfoHOQaigUFxbusEBcoNtoR2a3EGN3QyjsmBQG
	qW25LsshP1wfxKvCNv1ZQ==
X-ME-Sender: <xms:kGZ_ajabJ4tyh9aupLuc-rJpUafLkryRO5eWcV2a8eDjilUul6OQTg>
    <xme:kGZ_apSARNry3sGyfabqQ6BEpNJD2qrenkIIrGnv_w3GXsdKDfZDpJ4M3OYbtHLEY
    ulgBTF3mvgjlCC6Pkx48NnZbOOt7R-fY9tSS4IfM69jJA3v_4TgeBI>
X-ME-Received: <xmr:kGZ_auRJMv5PO_6gpCx7fXrlMEJRTZkbcsVfjEa0zNp1xP3-roNahqpvooyLH2mOqPbsz24qKOIUALS5xjYSaebiWdRhMPf9uA>
X-ME-Proxy-Cause: dmFkZTE7CLUv0Fv1HlDc0Oq9QWvw7t1notjfJ3FbPUAnR8D+vTStStWLIoyWHsGhOCa9fq
    rZjz70TmspBwQhlfG68LF4GJflrlN31yFLV9/MdHcULjXZMY5be+6YcbCR+GaOA5EWPtB8
    PGlQOTehs/ZxlDxwjKOliulvQTJkw/2rKl3T/bMDvyuY3f0Y3ac0Lmy7yzkfMFIVDcT32m
    vVX4Ee2UCA3SUXuLBIR9Txe4cypR1EFtBfv8cX1oE2vCdM1mMTX3r/SsW1H5cRKaiOMBn9
    T/K5Dlt/kGpVzyd+mLSY91uXHyf1pYM0u+fET8OGaXVyxnjLevwQHV6qIqReQcwDjhz4jP
    IG5sJvFmOTnYBOcWK1RE+S87jQWgFJ0U8oLxQRm3ZQ4kjIlpqRSKJw+h+uKY+DBFXOIple
    QateQkMNrNUQYtntwnutZlb4JyFtcI0z3gn7z8VwtYMcB/Evf8WVS7GFIOWsKVo05rBsee
    qvchSxOau6y0/MUxEXyP+bi+H7rz//M/2/ikvYqTwlcjhRMGDNU44P7Eyih9M79WvJTnhQ
    dscF4q0a+4frnWe+5U3liW4G0rwbfUBVTi3RWif6dZ28OCNv22jLop+NiE4LsUDhqhgNjC
    m3jQLyIUGz7jewWa4wwTDA5aiIXKiUapXRNrnRsW870FoDnv/mfm3Z2wj08w
X-ME-Proxy: <xmx:kGZ_alR4ncWuOfVaLlZK3_lYJ9TdwVffCcFWh9rKw_LHgfIn53ygVQ>
    <xmx:kGZ_ar5wrZg4lTA-z0rU9kGH4XECrmWkAMus7aD7GCrtWIs0FO_cRQ>
    <xmx:kGZ_ap0OSIx_oBw0ipVD0SloNrV2BRc42tRRyS0ZOhkfy-VkRGUiOw>
    <xmx:kGZ_auCOxGyRUr55tWoUhnQrishKPZC4weeAKG9Q_GLm3HzHPNshwg>
    <xmx:kGZ_atw5QM6AUoM_yPifqb5HDNMmudn7XaF89D4bO3hAWojzld0TP5nC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 15:03:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/4] odb: decouple source path comparisons from
 `the_repository`
In-Reply-To: <20260814171724.GB2563235@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 14 Aug 2026 13:17:24 -0400")
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
	<20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>
	<20260814171724.GB2563235@coredump.intra.peff.net>
Date: Fri, 14 Aug 2026 12:03:43 -0700
Message-ID: <xmqqpkzkmsmo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jeff King <peff@peff.net> writes:

> How bad is a duplicate alternate? It's a minor performance issue, I'd
> think. We would add its packs to the list (though hardly ever look
> through them, as the "first" copy would satisfy most requests, and the
> unused second copies end up at the back of the MRU list). You'd only pay
> the extra lookup cost for an object which we fail to find entirely,
> which is rare-ish (mostly speculative lookups for fetches).

There may be a future application to be written to go through list
of alternates---enumerate all objects that exist in the first one,
and then remove them as duplicates to other alternates.  Oops, there
was a duplicated entry and we ended up removing the objects from the
first one registered under a different spelling.

Oops (U+1F60F Smirking Face 😏).

> So I kind of wonder if we could just do away with considering case
> insensitivity here at all. We'd err on the side of correctness in the
> ambiguous cases, and this code complexity can just go away.

I like the simplicity.

> Alternatively, I think we could probably make the check more thorough in
> a similar way. Always consider a pair of case-insensitive matches as
> possible duplicates, and then for each possible duplicate use stat() to
> check their st_dev and st_ino values. That keeps things cheap for normal
> cases, and we pay only the stat() before de-duping. It's correct and
> doesn't rely on the repo, though it is a bit more somewhat complicated
> code.

Hmph, I prefer not to trust st_dev and st_ino on platforms where
case insensitivity can possibly become an issue, though.

> [1] Even on a single filesystem I think case-sensitivity check is not
>     completely sufficient either. We know that filesystems do more
>     complicated one-way transformations than just case folding, like
>     unicode normalization or even removing some funky code points.
>     We'd miss those "equivalent" spellings.

macOS?

