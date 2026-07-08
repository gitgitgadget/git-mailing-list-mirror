Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF1299959
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783538188; cv=none; b=gWGtoGEitqOj3F9U0o9asXRmGwxx9D3jWurZ5haVyFcOrv0XMXsPgkWi4d7Yxe7bxFx5z1Q07loC4GeoSxTnT5Vr2Wz25pZ1fAJjnnPUasAIvhwx9LhDug2TbgHAvuHh2wAEq5r2D1Fp+od9eDK/ba4/Lwjwhf7kqyheBdpjUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783538188; c=relaxed/simple;
	bh=NCpS8aEb8QYFuuDFy3nvSa/mglAUuKw9KQWcz73KrTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lHYfvxYn4lvqVCjY/l3hs91/d1TVIRLtAmnT60LJL4rDMrOqlJBEUdLmlqhWHOWfuHd+I+IIgjWu7LG6IlJHHIlcW6R+J8/CKKRKAzE3xw2nRS+s6vgZQnHPcltDp8KQHmo5maWQguN4sjMyAicY0yJDp+ZzQ6TqEz7/3tZ8chQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HcWPeL0v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z7Cp3NNq; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HcWPeL0v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z7Cp3NNq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8AB997A007E;
	Wed,  8 Jul 2026 15:16:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 08 Jul 2026 15:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783538185; x=1783624585; bh=xAEN9jPJFL
	gRIoapKQEPYdtjoxGYd6ZX/ZdvGMXkj5E=; b=HcWPeL0v36pqRyGPcHPFY3TTvU
	3VjDx6+q6gQopIAxIHQsuapUCElldi9pAL2WPZkzwbYkqQRSFvCs7p5zV5yl9/3q
	LHWGuXAew4ADK6u1rVsYb/OLZcDCifqKMpXBiG97gJ3f4DcKb46Q7+ChQeAVY2e0
	xJUrSnFQx/PcKhr8ex/i9YO76CLvvS2d4ToX0DAFJMLqzHLJW9+u77TLGQYDTKtc
	8Z08+rabcrRtDIjr8F9ESw3JGHIQFHmt9WGwS4GZDHsxwmMnzDeDv8gWV1G11SBo
	laD1/eJSejVfzzU4XjcLqkDqoMSfbpCQb2gvs2mK7vX7p9MH0niHGg8z5HnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783538185; x=1783624585; bh=xAEN9jPJFLgRIoapKQEPYdtjoxGYd6ZX/Zd
	vGMXkj5E=; b=Z7Cp3NNqmmiG3bLQFpa0gFmpufuA59xGOKPXRQc3ZOOuSRelwZ2
	kQWNZvHm9bygb0AyVAY/bYD0jb1OWSKGEhZTeoSUUfy+uLcbWGPcabvh35GVv+fS
	zdWDdNmJuod7xHukvTsjAhjumA5xK/rPfSEKoFzMW+OEht2wSlrQk1aa4fjLAocK
	wRHsxDaokRHDF/shDXddjjhLiCIiKNLEhxUmcKXJ7f9APHDRv32h4a7VKl5MLTyk
	u6cpoUcBUljKOgcv32HE/Zq4gvTQYQTfIr/JXBLo2QBiUtlSLijHOGyGy7Y43ObI
	DDXiXvnUqT7R/PWKbgjoNIjc9id3zbo4HSw==
X-ME-Sender: <xms:CKJOarO224UWl8ZClKJ8KwC6dRDJZzpQPfpli6LHfjOd2qLeSlYSRg>
    <xme:CKJOas9c5G7JnCJVOT0Gmuxr6Q-rlJnCxlCSTI6lD8hlTZtZ7ecxi6oPz6G_e-rMx
    PnDboxXKtaVreobTmEuStD9CtdVjPaYV_MMJ3OO73dPXOx-NOYeqw>
X-ME-Received: <xmr:CKJOavSLW-FE5o6k0aIRh08Ep7Wwo2IO-NzK6ZUqsUS7E4v1sPlLwergndZAZHcOS3wRW0zB31U5a15KTM_3C4BkdpCZ_0sBBJsctFg>
X-ME-Proxy-Cause: dmFkZTGuiKaP3GHYDPdhxNp1OcMKz8Pq/5DMS3QXJ2m5+2Q49+s3QLMQWHvg6yJRhjS2xc
    RAe05H8gmLT5ZspPHW7fJpsqPqPGDjqwKC99DQLbv+pJ8lP4d19y5TOV19pJ/wOetbsEdU
    Qutr9JQ8s+pQUyOoETUewgLa8pVPqn1aurrApIyz2+8q3L4MZXX9vElEwZsly1qF6p900n
    mZ1PRmwR8otG+4Ak6BjPpK2oQqwE8eqphGsvHhiLXdQ0MmzQJ/LF0+sHuErqEHeuwhxytw
    rLchSuT70aoS8kmzk9iUI2uCwi6MVANkDkQ3MAZYAjrSf6xS3jpOB9407y2cmmO7FDoQWx
    JoaB4VfThfm+9hX8Rx98eQpibIBHe/YmIB+clJr8YeXtwyUHMDzt0sTH0ZtUr37ivq2Tp3
    jsgoXSTnZM4Ijo9EZMozN0SIna3P1qAbcz2ROhhwPkNzuGMp20YYpok5d7D0FqrMsEi4WP
    DckF8hPLxrDFhACIQIxHIK7vDQT9OL8dgCu0qozuvbMm74dzbcxAgHsI/rgrR+tZJ8OTB6
    6cmVotHzHsvgVt9th5sRViKu5GO/HsDgod2TYqFtfSsTtLosAgcw0nAIN2FCIqUPNmFfLZ
    b3Gc0oK9lbsbWYHWGOO3s0AbA8sohuwXuB+b4jTPoL525arIa23848p/OIUA
X-ME-Proxy: <xmx:CKJOauncx6m25puEoRod6mdnSiieCTmGEvrpnDzuw6mKwSNk-2BYog>
    <xmx:CKJOavSanzyU8WwaSjmIPqsg1PZV4AsmEOdpKYQCUdgVO71xF2nFmQ>
    <xmx:CKJOasN_svRpyGB-FhpdhMbv9mIZTbezLHauc3gor_oL-kGKjwd4GQ>
    <xmx:CKJOaoWrePhv3_-4EtZrw7FuWpDwncFxljpM3nsy-NSIru3Frdy59w>
    <xmx:CaJOanRZCeSIXiiFTuCLeliVXHnJEXyS-BJ6hXqNZ-_U17MuGhJ1aNbX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 15:16:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Henrique Ferreiro <hferreiro@igalia.com>
Cc: Henrique Ferreiro via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] unpack-trees: avoid quadratic index scan in
 next_cache_entry()
In-Reply-To: <4c0a31e9-9b20-46c8-8f1f-0fda34515270@igalia.com> (Henrique
	Ferreiro's message of "Wed, 8 Jul 2026 20:31:35 +0200")
References: <pull.2353.git.git.1783458106037.gitgitgadget@gmail.com>
	<xmqqv7aqzdvq.fsf@gitster.g>
	<4c0a31e9-9b20-46c8-8f1f-0fda34515270@igalia.com>
Date: Wed, 08 Jul 2026 12:16:23 -0700
Message-ID: <xmqqzf01thq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Henrique Ferreiro <hferreiro@igalia.com> writes:

> On 07/07/2026 23:30, Junio C Hamano wrote:
>> "Henrique Ferreiro via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>>
>>> diff --git a/unpack-trees.c b/unpack-trees.c
>>> index b42020f16b..ed9fef453a 100644
>>> --- a/unpack-trees.c
>>> +++ b/unpack-trees.c
>>> @@ -671,8 +671,10 @@ static struct cache_entry *next_cache_entry(struct unpack_trees_options *o)
>>>   
>>>   	while (pos < index->cache_nr) {
>>>   		struct cache_entry *ce = index->cache[pos];
>>> -		if (!(ce->ce_flags & CE_UNPACKED))
>>> +		if (!(ce->ce_flags & CE_UNPACKED)) {
>>> +			o->internal.cache_bottom = pos;
>>>   			return ce;
>>> +		}
>>>   		pos++;
>> Nice spotting.
>>
>> Does this trick work correctly even when a path's sorting order
>> differs between the index and tree objects, which is precisely why
>> .cache_bottom was introduced, to allow backward scanning while
>> bounding the lookback distance?

> IIUC, .cache_bottom points at the first entry that needs to be 
> processed. With this change, that still holds true even when entries are 
> processed out of index order. find_cache_pos() also advances 
> cache_bottom past unpacked entries since e53e6b4433 (unpack-trees: Make 
> index lookahead less pessimal, 2010-06-10).

That sounds sensible.

>>> diff --git a/t/perf/p0009-diff-pathspec.sh b/t/perf/p0009-diff-pathspec.sh
>>> new file mode 100755
>>> index 0000000000..0f1dccfbb4
>>> --- /dev/null
>>> +++ b/t/perf/p0009-diff-pathspec.sh
>>> @@ -0,0 +1,27 @@
>>> +#!/bin/sh
>>> +
>>> +test_description='Tests performance of diffing the working tree with a pathspec'
>>> +
>>> +. ./perf-lib.sh
>>> +
>>> +test_perf_fresh_repo
>>> +
>>> +# The entries exist only in the index, which is enough to
>>> +# exercise the index scan.
>>> +test_expect_success 'setup' '
>>> +	count=100000 &&
>>
>> You will probably want to mimic how t/perf/p4209-pickaxe.sh helps
>> testers by adjusting the count based on how the EXPENSIVE
>> prerequisite is configured.

I think this comment still needs addressing, though.

Thanks.

>>> +	blob=$(echo content | git hash-object -w --stdin) &&
>>> +	{
>>> +		printf "100644 $blob\taaa/file\n" &&
>>> +		printf "100644 $blob\tf%s\n" $(test_seq $count)
>>> +	} | git update-index --index-info &&
>>> +	git commit -q -m initial &&
>>> +	mkdir -p aaa &&
>>> +	echo content >aaa/file
>>> +'
