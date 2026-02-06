Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EF8309EF4
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406743; cv=none; b=ppSIjgt0nOjAlIxy6E6zQ6zXAwGcGBG714cE7mh6NcMK1wELnzQJKLVV8h43inIZIXYyF/kvvWbp+U73adgMl96P2NAbZxdvMjuO9f+uaFeyLP+B6sEamRI4OOd1RWL5mQdJOCsgrjc4t8P5GdawcdE9riMAe2gYyE1B2+hnTf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406743; c=relaxed/simple;
	bh=1IuUMLVIHaXezpuPig/2FHxac3YhtZCGUAF1PO1X+dw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RZY/A30fRXg7xbKZZbIfjrcaEBpjZZwRqKdT9q0Yw8lSxDVsdeGkuOmG53A7bq2CJZocRvbJYUt+pqFGBtEZ3N6tNf6InD9BSwar4s6LRjkIL/4wg89rPM96RD0kZZhKwjeSDx9qVS5f1a7TU1BraQM8DjgACrnDmMTsRNXCnGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z6rY+ZoX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IoI0GnMH; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z6rY+ZoX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IoI0GnMH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 80437EC01D8;
	Fri,  6 Feb 2026 14:39:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 06 Feb 2026 14:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770406742; x=1770493142; bh=4HPEf++2/O
	np9TWjmV1ibLQw4u29/j5GIamPAFpXkw0=; b=Z6rY+ZoXJzqbLBzQd2K+6wNjie
	qR1M7TOXT6lrQxeGyUmuf5Vyk9kljaDqP9HcZsJmjW51b47TRKwuZ8AAXcznfFnW
	gYsAJue1ov7VIAhP/Q1+xw+VHVQ5UIh7uDtCtwjpoiiOD4Ab0VqjBlr8mPqOnKzk
	dWeOn0oRbMx0lT81L3H5I16nGFxo18v8d8PdVpgpsZTwmfANQGKlrjUFILHtcjli
	xdr+0vsrVhwM3NZHog3TTJ8UFv2cteMPwXBmuJgojPDNnSa29MmhbSq6dHXJkPrL
	Sgiyc6rqhSgdddEM30jjqMG00dyc6azi2Ewm3n2rwxpDqPWvwmJ13phxoYqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770406742; x=1770493142; bh=4HPEf++2/Onp9TWjmV1ibLQw4u29/j5GIam
	PAFpXkw0=; b=IoI0GnMHu5CcpjX3GA8qFO6GTiL44jzTli+vs1PinhWRbi+vVM/
	P740335qFNE+sEQrAHtqsjZW9XWBlXp/Txiw4wI37DxbzFnZhuVcHAmaPqmybz3q
	y+Q6FkN4D9GUjRf2nlpjRmlTtColzo0QaoZ1Rkc1Jky1KlBBNORGHV/CBTLS7+sd
	24PwYrmdgTThm588FIBTlsN/U6TNBH/aT4q+etEgd8YNG/5/6Wy6LKIjDoqWTFSo
	s+ozBoO4KS1Ac8a5Xo8dDEzcLcyeHHZIiGaT5fOOKneZ3wgp5PmpX6I/mtGxLbjD
	b6oM2RKvseThsWu42VsfawE8rgoTatgN1rA==
X-ME-Sender: <xms:VkOGafq5IDlVnKcINJt2Oa2NTwe3VYtoZn5NXuyK_gz9G1CWH7S1ZQ>
    <xme:VkOGaQqMrFsBPXX3Tc__nP_OfZ9x76PSJQzK_GNwYi2kl1w02gjswiPnsLpztQqmu
    2dRCqp-TQcMX1vg8O3jAymdOge4jI1LYAlgcuq2pe9nodCn1Jd_eg>
X-ME-Received: <xmr:VkOGaROqakGY8mlbtEPV8dfdM4CReRUtFA1lIcoq6wckTmszwIBEcKzfVkrG4jDm1Ci5-g-kC-LPRFAk2DY22EThChZk_VKLeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeltdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehjuhhnihhosehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VkOGaRyK28saF7QYORaQGLwuPTtq6OcLV4QhHs0cUBcQcz8fm5N84w>
    <xmx:VkOGaasroFG42sO7O-R6NfVE58i9tbf6zwZ4D2zVhLWTLZcnCXYejA>
    <xmx:VkOGaa6HqIJvsgMfkaa_wGupdZfklFi-TShNaaENR3Hq3h5UrxS9kw>
    <xmx:VkOGaZQs-4s5mlDVyer5nL42nSpzZ6uZ7tQuswK8Cs1x44EcCcetDw>
    <xmx:VkOGacfoVMm53EoJFaEmh6ZrzXkAhtwI4R9wsjltt9mBt0mTJarfXUpG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 14:39:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <junio@pobox.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #09)
In-Reply-To: <aXk2FjTUMMThs5Kp@nand.local> (Taylor Blau's message of "Tue, 27
	Jan 2026 17:03:02 -0500")
References: <xmqqecnbeyvr.fsf@gitster.g> <aXk2FjTUMMThs5Kp@nand.local>
Date: Fri, 06 Feb 2026 11:39:00 -0800
Message-ID: <xmqq1pixek6j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Jan 27, 2026 at 09:42:00AM -0800, Junio C Hamano wrote:
>> * ps/odb-for-each-object (2026-01-26) 16 commits
>>  - odb: drop unused `for_each_{loose,packed}_object()` functions
>>  - reachable: convert to use `odb_for_each_object()`
>>  - builtin/pack-objects: use `packfile_store_for_each_object()`
>>  - odb: introduce mtime fields for object info requests
>>  - treewide: drop uses of `for_each_{loose,packed}_object()`
>>  - treewide: enumerate promisor objects via `odb_for_each_object()`
>>  - builtin/fsck: refactor to use `odb_for_each_object()`
>>  - odb: introduce `odb_for_each_object()`
>>  - packfile: introduce function to iterate through objects
>>  - packfile: extract function to iterate through objects of a store
>>  - object-file: introduce function to iterate through objects
>>  - object-file: extract function to read object info from path
>>  - odb: fix flags parameter to be unsigned
>>  - odb: rename `FOR_EACH_OBJECT_*` flags
>>  - Merge branch 'ps/packfile-store-in-odb-source' into ps/odb-for-each-object
>>  - Merge branch 'ps/read-object-info-improvements' into ps/odb-for-each-object
>>
>>  Revamp object enumeration API around odb.
>>
>>  Will merge to 'next'?
>>  source: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
>
> I have some lingering questions about the mtime-related changes. I am
> not opposed to the series in general, but I think some more time to
> continue the discussion in that thread would be beneficial before
> starting to merge it down.

Has any further discussions took place outside the original thread

https://lore.kernel.org/git/20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im/

or are we pretty much done with this iteration and polish
incrementally if necessary?

Thanks.

