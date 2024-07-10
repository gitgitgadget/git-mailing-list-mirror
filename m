Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9F19538B
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720640524; cv=none; b=Gy9PkEYaCSJ/AKNzAuKkWAUwichsK/MjF8yfcEcbUQA5eLhx5CeQDH9A48UeKWCqUlBqLW51efSAwWWWPTKU+8Ny55763Q4dLb9f3u+93AEV3VZQ8iz3L1rg6PB5vhg2ZPwLySvATSEZ+mgXZoeWL5GlJs+zPeSa+QzepnvV9Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720640524; c=relaxed/simple;
	bh=eHMrQHy/mio/1rYBro3WBuReVdbz1sLVtPrpfpRTqjw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YcS2e5AjitAvjMOU69ryPTJi79XRdeI3q26CUbOrL1SUKui+pQVg//g7OPhdow4PrVXkn6/WJlgBogSEsG+7gXBuZWg6QRkb5c/mVWjZeGJecaoK+Q/QJNUxTtB+q+OLFi4gHRmqDOeNukcbGNckmI51TfzDmXID9boQBM+/4sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiL0+oVM; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiL0+oVM"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c9785517c0so153999a91.0
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 12:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720640523; x=1721245323; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TY8dyw65wAE8IFa/p0wAT80mnx7vq5msaqvTyqFk3XY=;
        b=hiL0+oVMA4Pqlpk6T47JCXf+1yT///lzxRruIT8YsJ2rbVbfCcPdNpg2FCBtLDttFv
         BkdGZSWSo2ZEFZYlhFWrxPeVGyuMuqGneg3VWh5YVTlZ01AVqhYzGrk30qZOd1pG8l4H
         EYdvY8Vhs3uXYxS3/YSfHe/QcFq1WDGn56NGFiV5Jd0KdNFCpIVnHtzZ/Up5iEq/Jxnj
         Woy5toYr1oJ3BVRA0YYbVHaWqxKHTBzdUPWeQCRczFr5yc+YYashU1Uw/VOZZQt3qqoo
         4qLxDbgt5vji3Jbev03OFcdbnZn7nvkWvzPjlwY2mEQstPni64MFg4LEN8n6/SBlRpOI
         TySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720640523; x=1721245323;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TY8dyw65wAE8IFa/p0wAT80mnx7vq5msaqvTyqFk3XY=;
        b=O664TcsY0kZKO6jnUKl0NyUEnq4xoo7TC+Cz3c8JgBM1uPXZ0y+dPE7yK1N6+oUifo
         LN5sWR8tDrVYNaMaHpeynQQL0dS/pc3beRH6jUAerQoBsHftFqoYeS0OjnDeMkBKuTTF
         pi1gLtaIJNf9YHfOcdb3vCodDk56MagSKLKwuNhJcKPK40zVHWyGKOsSpKjVA8dVThIr
         /71r5uDbDcOR1VQMa6GDXRtHlw/niEpTgl6JT1OczxJamBviP9wRwsef+vV2hinyTiWr
         Nv81LqHWrAl2RF3liEzEmfhZG94iy5WnKyyLyXia7C8FTJqGlQAeZSNjZ/DQZpDEe5bP
         kPow==
X-Gm-Message-State: AOJu0YxReRw/zWGyTQFSsyitnyDDlOsyeC3dfZOHFpzm3Jgt8fuweXDL
	QfcSA4a0VmEhXVH4aKZG+Qa5r0BdGsZB8QffVRPRjAS+TAs149kz
X-Google-Smtp-Source: AGHT+IHxDOs7EaIqN5+SzseXgVv9n0JB9FuhcmQHCsb266b4dGeb4uvxZIGirUiCc1jR6dGRIy9gMQ==
X-Received: by 2002:a17:90a:c702:b0:2c2:db95:80bd with SMTP id 98e67ed59e1d1-2ca35d928f6mr4599396a91.49.1720640522548;
        Wed, 10 Jul 2024 12:42:02 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca352c5a18sm4152218a91.41.2024.07.10.12.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 12:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jul 2024 01:11:56 +0530
Message-Id: <D2M45OWGEGU8.2TWYW1FQ2X3I@gmail.com>
Cc: <git@vger.kernel.org>, "Christian Couder" <christian.couder@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>, "Christian Couder"
 <chriscool@tuxfamily.org>, "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t: port helper/test-hashmap.c to
 unit-tests/t-hashmap.c
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Josh Steadmon"
 <steadmon@google.com>
References: <20240628124149.43688-1-shyamthakkar001@gmail.com>
 <20240708161641.10335-2-shyamthakkar001@gmail.com>
 <mlnerj7j6knamzj3ipnd7rgqd6xm5xrjep35rldhv6sikzipu5@72szgbso6cpo>
 <xmqqcynmdyy2.fsf@gitster.g>
In-Reply-To: <xmqqcynmdyy2.fsf@gitster.g>

Junio C Hamano <gitster@pobox.com> wrote:
> Josh Steadmon <steadmon@google.com> writes:
>
> >> +static void t_put(struct hashmap *map, int ignore_case)
> >> +{
> >> +	struct test_entry *entry;
> >> +	const char *key_val[][2] =3D { { "key1", "value1" },
> >> +				     { "key2", "value2" },
> >> +				     { "fooBarFrotz", "value3" } };
> >> +
> >> +	for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> >> +		entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1=
]);
> >> +		check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> >> +	}
> >> +
> >> +	entry =3D alloc_test_entry(ignore_case, "foobarfrotz", "value4");
> >> +	entry =3D hashmap_put_entry(map, entry, ent);
> >> +	check(ignore_case ? entry !=3D NULL : entry =3D=3D NULL);
> >> +	free(entry);
> >> +
> >> +	check_int(map->tablesize, =3D=3D, 64);
> >> +	check_int(hashmap_get_size(map), =3D=3D,
> >> +		  ignore_case ? ARRAY_SIZE(key_val) : ARRAY_SIZE(key_val) + 1);
> >> +}
> >
> > Ahhh, so you're using the same function for both case-sensitive and
> > -insensitive tests. So I guess TEST_RUN isn't useful here after all.
> > Personally I'd still rather get rid of setup(), but I don't feel super
> > strongly about it.
>
> Consulting the table with "fooBarFrotz" and checking what gets
> returned (expect "value3" for !icase, or "value4" for icase) is one
> of the things that are missing. In fact, the values stored are not
> even checked with the above test at all.

Yeah, I tried to replicate the 'put' tests from the shellscript.
However, t_get() does the same thing as you mentioned below, so I'll
just remove it and rename t_get() to t_put_get(), and add some
missing checks from t_put() to t_put_get().

>
> >> +static void t_replace(struct hashmap *map, int ignore_case)
> >> +{
> >> +	struct test_entry *entry;
> >> +
> >> +	entry =3D alloc_test_entry(ignore_case, "key1", "value1");
> >> +	check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> >> +
> >> +	entry =3D alloc_test_entry(ignore_case, ignore_case ? "Key1" : "key1=
",
> >> +				 "value2");
> >> +	entry =3D hashmap_put_entry(map, entry, ent);
> >> +	if (check(entry !=3D NULL))
> >> +		check_str(get_value(entry), "value1");
> >> +	free(entry);
> >> +
> >> +	entry =3D alloc_test_entry(ignore_case, "fooBarFrotz", "value3");
> >> +	check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> >> +
> >> +	entry =3D alloc_test_entry(ignore_case,
> >> +				 ignore_case ? "foobarfrotz" : "fooBarFrotz",
> >> +				 "value4");
>
> Curious. If the hashmap is set up for icase use, do callers still
> need to downcase the key? Shouldn't the library take care of that?
> After all, test_entry_cmp() when the hashmap is being used in icase
> mode does strcasecmp() anyway.

Of course we don't need to downcase. But the idea is to insert
"fooBarFrotz" then insert "foobarfrotz" to check if it is considered the
same or not. In a way, it is also testing test_entry_cmp() and
alloc_test_entry(). If we pass "fooBarFrotz" both the times
we can't be sure if it downcases or not, as both are same, we'd
pass even if it didn't downcase. After all, we are testing the
library rather than using it.

Thanks.

>
> >> +	entry =3D hashmap_put_entry(map, entry, ent);
> >> +	if (check(entry !=3D NULL))
> >> +		check_str(get_value(entry), "value3");
>
> Here the stored value is checked, which is good.
>
> >> +	free(entry);
> >> +}
> >> +
> >> +static void t_get(struct hashmap *map, int ignore_case)
> >> +{
> >> +	struct test_entry *entry;
> >> +	const char *key_val[][2] =3D { { "key1", "value1" },
> >> +				     { "key2", "value2" },
> >> +				     { "fooBarFrotz", "value3" },
> >> +				     { ignore_case ? "key4" : "foobarfrotz", "value4" } };
> >> +	const char *query[][2] =3D {
> >> +		{ ignore_case ? "Key1" : "key1", "value1" },
> >> +		{ ignore_case ? "keY2" : "key2", "value2" },
> >> +		{ ignore_case ? "foobarfrotz" : "fooBarFrotz", "value3" }
> >> +	};
> >> +
> >> +	for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> >> +		entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1=
]);
> >> +		check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> >> +	}
> >> +
> >> +	for (size_t i =3D 0; i < ARRAY_SIZE(query); i++) {
> >> +		entry =3D get_test_entry(map, ignore_case, query[i][0]);
> >> +		if (check(entry !=3D NULL))
> >> +			check_str(get_value(entry), query[i][1]);
> >> +	}
> >> +
> >> +	check(get_test_entry(map, ignore_case, "notInMap") =3D=3D NULL);
> >> +}
>
> It is getting dubious if it is worth having t_put, when t_get does
> so similar things and more.
>
> Same comment applies wrt icase, and not limited to t_get() but all
> the remaining test functions (elided).
>
> Thanks.

