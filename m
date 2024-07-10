Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167543156
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720606776; cv=none; b=JH+86DhijEcchf007/W51HTcyQCIe2VxdkLJZVEzamcrqXC5jCAcFrvIt8PCBeciy4nj8F/FrWE4I4cmDxObMgp5nG7s4t1xz250NC1x2oEsn8j7nDKTnxC97cW9qlyXiV6SNF5oqnc/3+yiLABU2BiAoYonrgPqW+KRHyLdNsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720606776; c=relaxed/simple;
	bh=yInHHOtt4weBQgGSR1La7L10ykEUCfSN8CmmOn35mc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l1Zm6cc1a5MyA/9DmqbW7f24SVqL9nQNhxqPSTBeauLdiFc7mw3A93rFasmkdEjcqQ2pAQpq0qwFSsJeKW7/Vn6vZjxXYbH+SawiOs9UzMHH4Ity52tldKBMOXOEeas8XzsbSPgL6zUSpagjyeU6l+gFF+9cL+HrRBD62u1C7Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPwDCtY7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPwDCtY7"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266edee10cso14755755e9.2
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 03:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720606772; x=1721211572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ek2492lEzXMCvXgUWwr7Bj29vRy1pyCcFTqiZNQ+nqY=;
        b=JPwDCtY7t7CB4g4607vcTtgNxKE74K/DkcU3sVjCUExgREnzn9L3evpPtfLZbsPPVb
         0oUTvcIu2+/Wy37dwx1e8P+iv4qRFdluXiaTh+BWdgk253kVZh87Ha/uIIVR7WZeJi5w
         /hjyvse/0vAvBeKZ4RAUDOYdcwKQlMq1WneswK5dcvIHYzDchsMj6bLEnI9GdwMcUjpo
         LzodQtY1qxqFrQk45DoVT0iCInsGbWyuKVGsnMhzSE8QxgYEHS/Hys+oSxZkAIh34RMC
         waT9co6JtNOAkfP/qxskPa5BjqndbmYogILpcQME0GJrRzDc14nrZzMHI+3E52YKBsMl
         QFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720606772; x=1721211572;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ek2492lEzXMCvXgUWwr7Bj29vRy1pyCcFTqiZNQ+nqY=;
        b=QfZQHbCa2v7lr5/xoRPFySKm7nq9oNNA/bNLHiGPjVzRnGm2radgc4ZBQzXdL3gKnQ
         FKyPpP4XhVrQhNPr81YKxZ6N6M2Cj41oM470mals9DTBvKyczcKxMt+W7KruDKJdBB8R
         juZ6S4TT1EqvHbyR+ud0/qg4uBdVgyStbut0gZ36k7hUiwFsw9uCZkOmW8/HvA8iMYm9
         /FhIEuD72LuH4EyYyRFtfgVTBpdb71A5RosjlEjbHAr05GlbUybSUb6wLG5+krpVKgtS
         7h5aLVIQLRM/wq75zHW15cOfkvNpISaE2pdjRJfzdiSkQepeBdnHPTMkOK6RU8pESFCA
         iPdw==
X-Forwarded-Encrypted: i=1; AJvYcCUwna2hMqmQmyijH/JOJwjmAu179RB8Rp3e3eVG5lO6KWsdAhH3dn+hYuKnvBzgJFwJAmo1uTBzK7SPdjjQEMJWETBf
X-Gm-Message-State: AOJu0YynR13r983JJ4EIljV3BXyy0A2tZ7eXlhFbWLKKAb39HgPOxYSV
	eFQnkrceQYKsEMTM4dLtabHaEYEa1bbYCYxnCFYfkBFUXO4ChpiD
X-Google-Smtp-Source: AGHT+IG9q348Oev0oChR++Se3/scwmNV72vs0WY36VZAXkjfOI+iT5HcGfI+t9LmYxJplbVuHCVTiw==
X-Received: by 2002:a05:600c:3042:b0:426:6eb9:2643 with SMTP id 5b1f17b1804b1-426707d890amr32595795e9.11.1720606772312;
        Wed, 10 Jul 2024 03:19:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1? ([2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42795cdaff9sm16494135e9.44.2024.07.10.03.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 03:19:32 -0700 (PDT)
Message-ID: <2d7fd61d-0b2c-465f-9f24-47c99ab5b56c@gmail.com>
Date: Wed, 10 Jul 2024 11:19:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v2] t: port helper/test-hashmap.c to
 unit-tests/t-hashmap.c
To: Josh Steadmon <steadmon@google.com>,
 Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org,
 Christian Couder <christian.couder@gmail.com>,
 Christian Couder <chriscool@tuxfamily.org>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
References: <20240628124149.43688-1-shyamthakkar001@gmail.com>
 <20240708161641.10335-2-shyamthakkar001@gmail.com>
 <mlnerj7j6knamzj3ipnd7rgqd6xm5xrjep35rldhv6sikzipu5@72szgbso6cpo>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <mlnerj7j6knamzj3ipnd7rgqd6xm5xrjep35rldhv6sikzipu5@72szgbso6cpo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2024 20:34, Josh Steadmon wrote:
> On 2024.07.08 21:45, Ghanshyam Thakkar wrote:

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

I'm not sure - we have to pass ignore_case to HASHMAP_INIT and the test 
function so using setup() means we cannot pass different values to the 
two different functions.

For parameterized tests where we calling the same function with 
different inputs using a setup function allows us to
  - write more concise test code
  - easily change the setup of all the tests if the api changes in the
    future.
  - consistently free resources at the end of a test making it easier to
    write leak-free tests
  - assert pre- and post- conditions on all tests

Using TEST_RUN is useful to declare the different inputs for each test. 
For example in the oid-array tests it allows us to write

     TEST_RUN("ordered enumeration") {
         const char *input[] = { "88", "44", "aa", "55" };
         const char *expected[] = { "44", "55", "88", "aa" };

         TEST_ENUMERATION(input, expected)
     }

rather than declaring a bunch of variables up front a long way from 
where they are used.

>> +static void t_add(struct hashmap *map, int ignore_case)
>> +{
>> +	struct test_entry *entry;
>> +	const char *key_val[][3] = {
>> +		{ "key1", "value1", "UNUSED" },
>> +		{ ignore_case ? "Key1" : "key1", "value2", "UNUSED" },
>> +		{ "fooBarFrotz", "value3", "UNUSED" },
>> +		{ ignore_case ? "Foobarfrotz" : "fooBarFrotz", "value4", "UNUSED" }
>> +	};
>> +	const char *queries[] = { "key1",
>> +				  ignore_case ? "Foobarfrotz" : "fooBarFrotz" };
>> +
>> +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
>> +		entry = alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]);
>> +		hashmap_add(map, &entry->ent);
>> +	}
>> +
>> +	for (size_t i = 0; i < ARRAY_SIZE(queries); i++) {
> 
> Since we only have one query, can we remove the loop and simplify the
> following block of code?
> 
> Also (here and elsewhere), it might be less confusing to say "UNSEEN" /
> "SEEN" instead of "UNUSED" / "USED". The latter makes it sound to me
> like there's some API requirement to have a 3-item array that we don't
> actually need, but in this case those fields are actually used in
> key_val_contains() to track duplicates.

The third element just needs to be a boolean flag so it might be better 
to use a struct

	const struct {
		char *key;
		char *val;
		char seen;
	} key_val[] = {
		{ .key = "key1", .val = "value1" },
		{ .key = ignore_case ? "Key1" : "key1" .val = "value2" },		{ .key = 
"fooBarFrotz" .val = "value3" },
		{ .key = ignore_case ? "Foobarfrotz" : "fooBarFrotz", .value = "value4" }
	};

Best Wishes

Phillip

