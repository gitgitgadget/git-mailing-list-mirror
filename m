Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57539480978
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128529; cv=none; b=WUv/Obe0G6koSfH5KeBHG6Ru/faaDbwvkhkMmBUBEvRFEmhIRI7oSwkVFUhANHCjiUnKKJfw6lG341MMVoTF+zwFYv1jkMfDgAUPXFo+RiU8qv4Mtv9hWF77aXidGNv5VaKmvyyqzCh3llZOXCXDWd2SY0ae9wQQtYZP3eumBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128529; c=relaxed/simple;
	bh=HwUD+/ZOfjH/OQUA7M09JyqkK6QQOVqp4QxacIJTqhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TDnFEbOO7Y/AVNZDqagd6C0TSgQ5+tbAB1dOkonraCo/5V1hoVW4pJoRMj4ZERl1nKlnU7h+uiOxIUgnbvzr09RR4NbTJpxH7S7OHuMcnSgx6aCkVFfAlK+ndVzWXZbIqLYngZRwiywn7tV3ZWWY1sE1Q4x+RyfpZksGDsGJKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UymLndCv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZhfgNK7Y; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UymLndCv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZhfgNK7Y"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5DF97EC0072;
	Wed, 15 Jul 2026 11:15:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jul 2026 11:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784128527; x=1784214927; bh=15LyCY+Iq+
	UntTy158vctW+qVJ57wf6SdjlAnWz+Ccs=; b=UymLndCvrHZjuQkrOzWUZPHvZ2
	SzNM8MhqdYLkXhcbQlPhVTQkc9prYGVZWy902i/GzSHsf3A8+tOce4CocqK3u+eP
	KjMiZDuzf5qYUYAaM473Eb38393plqmYl6mgWSqKAcWf6RvqAU/9w4StMMGCoZ0N
	YG/Usxy1xcg8F98IdeO9SoWg5LfJPHJziYh6Wf1htbq/VdssNcFhT6pa9rCC/BIl
	5vlEdvLO4Ee3f9FSBEICmPEZ219hKHsnLQuuf4YkrqC+Ny4kYPgHpceT3tFqSpcv
	Xxcb3MK50PZgINpZnawBzoSw33H86+2Gt4uiIsDTaGymxlDDHC8dRWiHzCgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784128527; x=1784214927; bh=15LyCY+Iq+UntTy158vctW+qVJ57wf6Sdjl
	AnWz+Ccs=; b=ZhfgNK7YuWFz5r1eQMnBjC1bwL1HgZ1O3Vn1Jxv2UCw7kUXKHEr
	mbxGIq4FdHT/uGr1amyVmSTp4mAffv0NZqLSiTEWOqyn2cHQfJ1smAoH2UR4g1QI
	0/5SkoHVUVVVo2vmQyTyGqoc9TEJXwu0z1fS+xMxw3vJnIRcJzjmczgrBA14vLiG
	hj8pF7cggFae62CrjxAwruP4Sl0fpmz5VG7CnOHOwhUS/LiQqVBAJwloxKE+8tLK
	3mmDsEhJaiLe+S8ZcxIO25eNddQueqrbPI9o9hVWzoT8lhyA529jA//pFmiq6Evj
	c+wtiamFzGJcoTrQMHpOio6OFkkTbEM9JkQ==
X-ME-Sender: <xms:DqRXakGFaqTdgSasbDS-tYqZWU9vPCZIczcjMIZxhM8hG0gepon2QA>
    <xme:DqRXavkmzelKmKdx1yEBM5VNBoqovchzIT_eQYS_z4y1T562KQqOVkO2uQJkvKQLL
    JyAZk8h6Rc68Cmlp17jVIe4ao8J4tOFQ2mpE31mspuiLCHFykpf35Q>
X-ME-Received: <xmr:DqRXagYqLaRfv5Z3Z_ZVQ818d2lV72qNeQt2d_omrAbhlzFQPgM43HA0vKwEj3St5mP7VwTZembzhINUv08bph0F9TwDjqJf020MmnM>
X-ME-Proxy-Cause: dmFkZTFqBXeZoro3zn64zDhzH3KhON8mWpD65j4Tcfqrc6eVsRbxbPr2Jnb3+Swln5sljH
    612LmYzUSxUwOoDmdaNdsQSbpci+0CxDx4CERzgCMu8Bf4FHvWoCshlssL5cFjcqlDAM2v
    4fW+nEtMg1EKvgE4bDaLn/kR99ICp/vpJ1nnFvNfGmO5NEiOTNmnEvX5TPRmGzj9KlqrKV
    3XvFsZqtHHKHOexZp52bmsnVAGz1dERQ6gzHOgcHo5UaBX9jRVDqTZa/H3/0bB46ZCOaax
    HpdHk1IbUlLLwFRPNFMT8rht9l381q35P67Gw3eAriowXvwcgUamL1o4V/85z3PRRZjeWD
    uYbZjQ12or0d6zYYxE9q3lIZBFSLwYvCR8FrTT488YBqpuBimFUpBZIc7v6ByxXQp2rJo3
    cEUVd4IEDOt9W6uC4yad2emSBfjtH2MDuDB91vn3CFhSt8jD086A8CF8jJwOExNuxzaG6e
    Ukh1cCK+YxDsDjSN0JwGXZ2fhgwUY8HX6d9i05wPbHvWuUhBrZyQrZrbq9IJiq5zPHgyaD
    Rr9hwRA57TckdjvG/8PYyBVtFPcAHNhrE020MNSdz8MgwTD0erZjA9DwvhlSN36D7+8ZyS
    c9reIKwbboCNqqntx5L4yTGVurWe0PSQbVkJJKk+B4h8BwxePb50rnARbjOA
X-ME-Proxy: <xmx:D6RXasG2M_sqllLKtP78oLwyjcpr3iTkX1InChAAvUcRw0guoXCz5g>
    <xmx:D6RXapIK14of_x-b2Fb9DaBbuUt_6rMi7ieOiFkxxZz5kduZTSqZpQ>
    <xmx:D6RXavML9P1eJNfkb0ls-RGlVFxVI9lQaBUdYNkpp75K9Ml_o9wJWA>
    <xmx:D6RXahnEg5VT0xPDtlPQYs1YIR6hoNAeLAQHGtUsWNBdymGlnVPJgg>
    <xmx:D6RXanIRD_BF7QqADEfqjY_gcPKE4GIollSTxZdJ1hWBpq5UEv4-DQAM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 11:15:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Justin Tobler
 <jltobler@gmail.com>,  Jeff King <peff@peff.net>,  Taylor Blau
 <ttaylorr@openai.com>
Subject: Re: [PATCH v4 0/9] odb: introduce object filters to
 `odb_for_each_object()`
In-Reply-To: <874ii0h2uf.fsf@emacs.iotcl.com> (Toon Claes's message of "Wed,
	15 Jul 2026 14:08:56 +0200")
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
	<20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
	<874ii0h2uf.fsf@emacs.iotcl.com>
Date: Wed, 15 Jul 2026 08:15:24 -0700
Message-ID: <xmqqo6g8p9mb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Hi,
>>
>> this patch series introduces object filters to `odb_for_each_object()`.
>> The intent of this is to make `git cat-file --batch-all-objects` work
>> with pluggable object databases. Right now it doesn't because it reaches
>> into internals of the "packed" backend to efficiently handle bitmapped
>> objects.
>>
>> The series is built on top of f85a7e6620 (Start Git 2.56 cycle,
>> 2026-07-06) with ps/odb-drop-whence at 8a7ad23e11 (odb: document object
>> info fields, 2026-07-02) merged into it.
>>
>> Changes in v4:
>>   - Fix references to an old function name in commit messages.
>
> Thanks for fixing that! This version looks fine by me.

Great.  Thanks all for working well together.
