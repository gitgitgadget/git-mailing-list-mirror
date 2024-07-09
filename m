Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F11B86D4
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 21:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720561372; cv=none; b=e8omTwbY+TI9riWE0ArGCk8F4UR2xfEzG4FZuTq0hD+OoMAiaTN14bwysqo9cux7EWWk0q/zGzMDItIiUPvcOvFo8kKDZPfh85YXnDYlSQu4VAPZViYJ1mruyjkkxt5hoFoEHA/bT0JHom+QmANxSWZylhJsQvOo/q1Nvtlztb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720561372; c=relaxed/simple;
	bh=rxl6kJ+RjBQO5Ae5stmAut1SSku7h4qPWTLuxy/4Ue4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TjlNOGS56QvG7l5L16FUUd/PCHht0TZXJwQ/nwXWFU/CNbfcRyDof7WfJzflmA6Oe+Zus+2PydY2xtIFuwtGWsUy4rgcT+Nr4D1Pm4poDol9MPir/2Cq6phbEs3n9BeLSeBfOV+O/MhoRiz1NhC9s/w+I/RUYslnLeiLZYv01CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yfQ9zGd0; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yfQ9zGd0"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3B9083C453;
	Tue,  9 Jul 2024 17:42:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rxl6kJ+RjBQO5Ae5stmAut1SSku7h4qPWTLuxy
	/4Ue4=; b=yfQ9zGd0GDMgAi2Pu26JGLgaUPSkV8ZQ2wLCMuSvhAMT2e8AKCnyf5
	7jyOh7kD4VcIm5C28TCcQO+wqgCWRk53UI1TIxvPYSa1aCai8Rned8wUg+vXwEZD
	KI2Aw2YgogMPcrj3Rx78va8E9aLXRYYTsN8SZ82gFX2LXkQRVFZuE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3347C3C452;
	Tue,  9 Jul 2024 17:42:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B93503C451;
	Tue,  9 Jul 2024 17:42:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  git@vger.kernel.org,
  Christian Couder <christian.couder@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>,
  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t: port helper/test-hashmap.c to
 unit-tests/t-hashmap.c
In-Reply-To: <mlnerj7j6knamzj3ipnd7rgqd6xm5xrjep35rldhv6sikzipu5@72szgbso6cpo>
	(Josh Steadmon's message of "Tue, 9 Jul 2024 12:34:47 -0700")
References: <20240628124149.43688-1-shyamthakkar001@gmail.com>
	<20240708161641.10335-2-shyamthakkar001@gmail.com>
	<mlnerj7j6knamzj3ipnd7rgqd6xm5xrjep35rldhv6sikzipu5@72szgbso6cpo>
Date: Tue, 09 Jul 2024 14:42:45 -0700
Message-ID: <xmqqcynmdyy2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2E503892-3E3C-11EF-BB68-C38742FD603B-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

>> +static void t_put(struct hashmap *map, int ignore_case)
>> +{
>> +	struct test_entry *entry;
>> +	const char *key_val[][2] = { { "key1", "value1" },
>> +				     { "key2", "value2" },
>> +				     { "fooBarFrotz", "value3" } };
>> +
>> +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
>> +		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
>> +		check(hashmap_put_entry(map, entry, ent) == NULL);
>> +	}
>> +
>> +	entry = alloc_test_entry(ignore_case, "foobarfrotz", "value4");
>> +	entry = hashmap_put_entry(map, entry, ent);
>> +	check(ignore_case ? entry != NULL : entry == NULL);
>> +	free(entry);
>> +
>> +	check_int(map->tablesize, ==, 64);
>> +	check_int(hashmap_get_size(map), ==,
>> +		  ignore_case ? ARRAY_SIZE(key_val) : ARRAY_SIZE(key_val) + 1);
>> +}
>
> Ahhh, so you're using the same function for both case-sensitive and
> -insensitive tests. So I guess TEST_RUN isn't useful here after all.
> Personally I'd still rather get rid of setup(), but I don't feel super
> strongly about it.

Consulting the table with "fooBarFrotz" and checking what gets
returned (expect "value3" for !icase, or "value4" for icase) is one
of the things that are missing.  In fact, the values stored are not
even checked with the above test at all.

>> +static void t_replace(struct hashmap *map, int ignore_case)
>> +{
>> +	struct test_entry *entry;
>> +
>> +	entry = alloc_test_entry(ignore_case, "key1", "value1");
>> +	check(hashmap_put_entry(map, entry, ent) == NULL);
>> +
>> +	entry = alloc_test_entry(ignore_case, ignore_case ? "Key1" : "key1",
>> +				 "value2");
>> +	entry = hashmap_put_entry(map, entry, ent);
>> +	if (check(entry != NULL))
>> +		check_str(get_value(entry), "value1");
>> +	free(entry);
>> +
>> +	entry = alloc_test_entry(ignore_case, "fooBarFrotz", "value3");
>> +	check(hashmap_put_entry(map, entry, ent) == NULL);
>> +
>> +	entry = alloc_test_entry(ignore_case,
>> +				 ignore_case ? "foobarfrotz" : "fooBarFrotz",
>> +				 "value4");

Curious.  If the hashmap is set up for icase use, do callers still
need to downcase the key?  Shouldn't the library take care of that?
After all, test_entry_cmp() when the hashmap is being used in icase
mode does strcasecmp() anyway.

>> +	entry = hashmap_put_entry(map, entry, ent);
>> +	if (check(entry != NULL))
>> +		check_str(get_value(entry), "value3");

Here the stored value is checked, which is good.

>> +	free(entry);
>> +}
>> +
>> +static void t_get(struct hashmap *map, int ignore_case)
>> +{
>> +	struct test_entry *entry;
>> +	const char *key_val[][2] = { { "key1", "value1" },
>> +				     { "key2", "value2" },
>> +				     { "fooBarFrotz", "value3" },
>> +				     { ignore_case ? "key4" : "foobarfrotz", "value4" } };
>> +	const char *query[][2] = {
>> +		{ ignore_case ? "Key1" : "key1", "value1" },
>> +		{ ignore_case ? "keY2" : "key2", "value2" },
>> +		{ ignore_case ? "foobarfrotz" : "fooBarFrotz", "value3" }
>> +	};
>> +
>> +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
>> +		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
>> +		check(hashmap_put_entry(map, entry, ent) == NULL);
>> +	}
>> +
>> +	for (size_t i = 0; i < ARRAY_SIZE(query); i++) {
>> +		entry = get_test_entry(map, ignore_case, query[i][0]);
>> +		if (check(entry != NULL))
>> +			check_str(get_value(entry), query[i][1]);
>> +	}
>> +
>> +	check(get_test_entry(map, ignore_case, "notInMap") == NULL);
>> +}

It is getting dubious if it is worth having t_put, when t_get does
so similar things and more.

Same comment applies wrt icase, and not limited to t_get() but all
the remaining test functions (elided).

Thanks.

