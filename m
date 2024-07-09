Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3841FA3
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720567660; cv=none; b=iZTJkneqROgHBuAEb2PoHVyglRloEV33v9jwgF836DE8N/DFfrKUJ1svfVIYvyaSEUZ7H699Sb8nYLwNtNH1iJZYZjuUiU7jeegA7qNJg2tX+qOA4e4l6DI9QhZFG591r5BOkLPPZEcBZaJJp1lVnyYafs2kWCONqd0qKQShsgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720567660; c=relaxed/simple;
	bh=GXg5wigt1GRlr+rVZAPAGv+3Ak4nTmG6JH2+sfmP6zc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=nFTses4Pnqc4l0naB4yJw9WHFBR8hk26EW/mBDRZh+zNH5Sn4/nfLBxF6u54nCQqFXaAx+B7uO5f9NdRreNRT6fGKSggMF01hKN3DF+BbX0Ib3mq5xHppEXfRtuWjkv+pKt0aRzR1FbxmoAPfWezkluc2Zc65zl8Yzk46PFono8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7qpThBB; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7qpThBB"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-710437d0affso3281020a12.3
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 16:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720567658; x=1721172458; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krZgc8Z8bsQsYQUUXA68xZf4nBhqE8zphGdzNMmn1Gc=;
        b=G7qpThBBgdO1cVNRkeSiaNBz6GqwpSmDpUzR/0gJhsZzfA3oMbQup5w+3eRL31Zh+G
         6lH9bdHPIuQCnUXVLzVfAIidIf012y7wYGP7AHr20gNvsgSNvcJPe+0RgruAG4Mr27me
         rP64lwGZRp7pZksqIMapcCcWwSLyYUe6ArAHuO80/dJ2awVxwU9x8+7OdvG/QW7/Izn/
         jbMp5x3aEVxp9Fmv8szUGJtrJ9Q/we44REvhTKYV6m5wTOzrNWxQ7pNejCxYh9xBjLvE
         l2aG3vhEwNlDMJf2rPzjY324gIvXL99dWOhK/ZYDtXKWb3FMoSljKcEjB0J4UI6sehYA
         xWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720567658; x=1721172458;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=krZgc8Z8bsQsYQUUXA68xZf4nBhqE8zphGdzNMmn1Gc=;
        b=QRk6VBux1uLhso0D4jrZAMmu7DlgqC5MLg4FJ4ssdRg26tA3rm6gQTjvgSor8fbqqj
         cqvZ/+RfazsJAvPOTLp4Ou4U3bIWqGqvQm08qmAx6ajOJrbNHLC5IjWMCYnK7Khf0fng
         6WfUlMV7pu+hb3A02O9an5Ew07kB/99n8QveqBT4HKQ2uKR8stHdTGYQdwkcLlTWzz2c
         af8uUSoXHP/di38d9g8/aLhMdG3gh2h49d6bMitamwNPzmjxxOCz7KF4daG3ms09EYbf
         eIcZ6NRarqAeWK78OjxfnSyMkkLwUgpElx9gkd3dSVMzqVszCnETTaVnB407aJozAeS9
         dDcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQkPLHPchufAw9Xi8FP9C3KO9MlPNsVZkv75qZNJdve9vLojP1T5uJibILPqhxxzfYW/jMqTRnGQuSeRmwnOUvAEVq
X-Gm-Message-State: AOJu0YyAOth26hvbaHr69tsg9EB3aIOIa/GUN2DYhw/ihHPXW9FNVgOu
	OEIS14yi4uk9alBXVt6DUl/Bo5uhNUfDZAK7Qpxl+E8/dvomnVTi
X-Google-Smtp-Source: AGHT+IG7sjKXIiLRR+u3YWcmP52azNkbxtFXro5FcPfcMb78qlGINM3fBLD0YkeFWXRXBkLX6/ZFIg==
X-Received: by 2002:a05:6a20:db0c:b0:1c0:f1a8:d9da with SMTP id adf61e73a8af0-1c29822d487mr3508739637.21.1720567657659;
        Tue, 09 Jul 2024 16:27:37 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6acf417sm21289945ad.265.2024.07.09.16.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 16:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jul 2024 04:57:32 +0530
Message-Id: <D2LEBVI9SZXC.3D4M7X4SN99BX@gmail.com>
Subject: Re: [GSoC][PATCH v2] t: port helper/test-hashmap.c to
 unit-tests/t-hashmap.c
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Josh Steadmon" <steadmon@google.com>, "Ghanshyam Thakkar"
 <shyamthakkar001@gmail.com>, <git@vger.kernel.org>, "Christian Couder"
 <christian.couder@gmail.com>, "Phillip Wood" <phillip.wood123@gmail.com>,
 "Christian Couder" <chriscool@tuxfamily.org>, "Kaartic Sivaraam"
 <kaartic.sivaraam@gmail.com>
References: <20240628124149.43688-1-shyamthakkar001@gmail.com>
 <20240708161641.10335-2-shyamthakkar001@gmail.com>
 <mlnerj7j6knamzj3ipnd7rgqd6xm5xrjep35rldhv6sikzipu5@72szgbso6cpo>
In-Reply-To: <mlnerj7j6knamzj3ipnd7rgqd6xm5xrjep35rldhv6sikzipu5@72szgbso6cpo>

Josh Steadmon <steadmon@google.com> wrote:
>
> This looks like a good conversion to me. There are a few small
> improvements that could be made, but mostly LGTM. Comments are inline
> below.
>
>
> On 2024.07.08 21:45, Ghanshyam Thakkar wrote:
> > helper/test-hashmap.c along with t0011-hashmap.sh test the hashmap.h
> > library. Migrate them to the unit testing framework for better
> > debugging, runtime performance and consice code.
>
> Typo: s/consice/concise/

Will update.

>
> > Along with the migration, make 'add' tests from the shellscript order
> > agnostic in unit tests, since they iterate over entries with the same
> > keys and we do not guarantee the order.
> >=20
> > The helper/test-hashmap.c is still not removed because it contains a
> > performance test meant to be run by the user directly (not used in
> > t/perf). And it makes sense for such a utility to be a helper.
> >=20
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> > Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> > ---
> > The changes in v2 are inspired from the review of another similar
> > test t-oidmap: https://lore.kernel.org/git/16e06a6d-5fd0-4132-9d82-5c6f=
13b7f9ed@gmail.com/
> >=20
> > The v2 also includes some formatting corrections and one of the
> > testcases, t_add(), was changed to be more similar to the original.
> >=20
> >  Makefile                 |   1 +
> >  t/helper/test-hashmap.c  | 100 +----------
> >  t/t0011-hashmap.sh       | 260 ----------------------------
> >  t/unit-tests/t-hashmap.c | 359 +++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 362 insertions(+), 358 deletions(-)
> >  delete mode 100755 t/t0011-hashmap.sh
> >  create mode 100644 t/unit-tests/t-hashmap.c
>
> [snip]
>
> > diff --git a/t/unit-tests/t-hashmap.c b/t/unit-tests/t-hashmap.c
> > new file mode 100644
> > index 0000000000..1c951fcfd8
> > --- /dev/null
> > +++ b/t/unit-tests/t-hashmap.c
> > @@ -0,0 +1,359 @@
> > +#include "test-lib.h"
> > +#include "hashmap.h"
> > +#include "strbuf.h"
> > +
> > +struct test_entry {
> > +	int padding; /* hashmap entry no longer needs to be the first member =
*/
> > +	struct hashmap_entry ent;
> > +	/* key and value as two \0-terminated strings */
> > +	char key[FLEX_ARRAY];
> > +};
> > +
> > +static int test_entry_cmp(const void *cmp_data,
> > +			  const struct hashmap_entry *eptr,
> > +			  const struct hashmap_entry *entry_or_key,
> > +			  const void *keydata)
> > +{
> > +	const int ignore_case =3D cmp_data ? *((int *)cmp_data) : 0;
> > +	const struct test_entry *e1, *e2;
> > +	const char *key =3D keydata;
> > +
> > +	e1 =3D container_of(eptr, const struct test_entry, ent);
> > +	e2 =3D container_of(entry_or_key, const struct test_entry, ent);
> > +
> > +	if (ignore_case)
> > +		return strcasecmp(e1->key, key ? key : e2->key);
> > +	else
> > +		return strcmp(e1->key, key ? key : e2->key);
> > +}
> > +
> > +static const char *get_value(const struct test_entry *e)
> > +{
> > +	return e->key + strlen(e->key) + 1;
> > +}
> > +
> > +static struct test_entry *alloc_test_entry(unsigned int ignore_case,
> > +					   const char *key, const char *value)
> > +{
> > +	size_t klen =3D strlen(key);
> > +	size_t vlen =3D strlen(value);
> > +	unsigned int hash =3D ignore_case ? strihash(key) : strhash(key);
> > +	struct test_entry *entry =3D xmalloc(st_add4(sizeof(*entry), klen, vl=
en, 2));
> > +
> > +	hashmap_entry_init(&entry->ent, hash);
> > +	memcpy(entry->key, key, klen + 1);
> > +	memcpy(entry->key + klen + 1, value, vlen + 1);
> > +	return entry;
> > +}
>
> So we're duplicating `struct test_entry`, `test_entry_cmp()`, and
> `alloc_test_entry()`, which have (almost) identical definitions in
> t/helper/test-hashmap.c. I wonder if it's worth splitting these into a
> separate .c file. Maybe it's too much of a pain to add Makefile rules to
> share objects across the test helper and the unit tests. Something to
> keep in mind I guess, if we find that we want to share more code than
> this.
>
>
> > +static struct test_entry *get_test_entry(struct hashmap *map,
> > +					 unsigned int ignore_case, const char *key)
> > +{
> > +	return hashmap_get_entry_from_hash(
> > +		map, ignore_case ? strihash(key) : strhash(key), key,
> > +		struct test_entry, ent);
> > +}
> > +
> > +static int key_val_contains(const char *key_val[][3], size_t n,
> > +			    struct test_entry *entry)
> > +{
> > +	for (size_t i =3D 0; i < n; i++) {
> > +		if (!strcmp(entry->key, key_val[i][0]) &&
> > +		    !strcmp(get_value(entry), key_val[i][1])) {
> > +			if (!strcmp(key_val[i][2], "USED"))
> > +				return 2;
> > +			key_val[i][2] =3D "USED";
> > +			return 0;
> > +		}
> > +	}
> > +	return 1;
> > +}
> > +
> > +static void setup(void (*f)(struct hashmap *map, int ignore_case),
> > +		  int ignore_case)
> > +{
> > +	struct hashmap map =3D HASHMAP_INIT(test_entry_cmp, &ignore_case);
> > +
> > +	f(&map, ignore_case);
> > +	hashmap_clear_and_free(&map, struct test_entry, ent);
> > +}
>
> As I mentioned in my review [1] on Ren=C3=A9's TEST_RUN series, I don't
> think
> we get much value out of having a setup + callback approach when the
> setup is minimal. Would you consider rewriting a v2 using TEST_RUN once
> that is ready in `next`?
>
> [1]
> https://lore.kernel.org/git/tswyfparvchgi7qxrjxbx4eb7cohypzekjqzbnkbffses=
aiazs@vtewtz7o6twi/
>
> > +static void t_put(struct hashmap *map, int ignore_case)
> > +{
> > +	struct test_entry *entry;
> > +	const char *key_val[][2] =3D { { "key1", "value1" },
> > +				     { "key2", "value2" },
> > +				     { "fooBarFrotz", "value3" } };
> > +
> > +	for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> > +		entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]=
);
> > +		check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> > +	}
> > +
> > +	entry =3D alloc_test_entry(ignore_case, "foobarfrotz", "value4");
> > +	entry =3D hashmap_put_entry(map, entry, ent);
> > +	check(ignore_case ? entry !=3D NULL : entry =3D=3D NULL);
> > +	free(entry);
> > +
> > +	check_int(map->tablesize, =3D=3D, 64);
> > +	check_int(hashmap_get_size(map), =3D=3D,
> > +		  ignore_case ? ARRAY_SIZE(key_val) : ARRAY_SIZE(key_val) + 1);
> > +}
>
> Ahhh, so you're using the same function for both case-sensitive and
> -insensitive tests. So I guess TEST_RUN isn't useful here after all.
> Personally I'd still rather get rid of setup(), but I don't feel super
> strongly about it.

Sure, I'll get rid of setup().

>
> > +static void t_replace(struct hashmap *map, int ignore_case)
> > +{
> > +	struct test_entry *entry;
> > +
> > +	entry =3D alloc_test_entry(ignore_case, "key1", "value1");
> > +	check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> > +
> > +	entry =3D alloc_test_entry(ignore_case, ignore_case ? "Key1" : "key1"=
,
> > +				 "value2");
> > +	entry =3D hashmap_put_entry(map, entry, ent);
> > +	if (check(entry !=3D NULL))
> > +		check_str(get_value(entry), "value1");
> > +	free(entry);
> > +
> > +	entry =3D alloc_test_entry(ignore_case, "fooBarFrotz", "value3");
> > +	check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> > +
> > +	entry =3D alloc_test_entry(ignore_case,
> > +				 ignore_case ? "foobarfrotz" : "fooBarFrotz",
> > +				 "value4");
> > +	entry =3D hashmap_put_entry(map, entry, ent);
> > +	if (check(entry !=3D NULL))
> > +		check_str(get_value(entry), "value3");
> > +	free(entry);
> > +}
> > +
> > +static void t_get(struct hashmap *map, int ignore_case)
> > +{
> > +	struct test_entry *entry;
> > +	const char *key_val[][2] =3D { { "key1", "value1" },
> > +				     { "key2", "value2" },
> > +				     { "fooBarFrotz", "value3" },
> > +				     { ignore_case ? "key4" : "foobarfrotz", "value4" } };
> > +	const char *query[][2] =3D {
> > +		{ ignore_case ? "Key1" : "key1", "value1" },
> > +		{ ignore_case ? "keY2" : "key2", "value2" },
> > +		{ ignore_case ? "foobarfrotz" : "fooBarFrotz", "value3" }
> > +	};
> > +
> > +	for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> > +		entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]=
);
> > +		check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> > +	}
> > +
> > +	for (size_t i =3D 0; i < ARRAY_SIZE(query); i++) {
> > +		entry =3D get_test_entry(map, ignore_case, query[i][0]);
> > +		if (check(entry !=3D NULL))
> > +			check_str(get_value(entry), query[i][1]);
> > +	}
> > +
> > +	check(get_test_entry(map, ignore_case, "notInMap") =3D=3D NULL);
> > +}
> > +
> > +static void t_add(struct hashmap *map, int ignore_case)
> > +{
> > +	struct test_entry *entry;
> > +	const char *key_val[][3] =3D {
> > +		{ "key1", "value1", "UNUSED" },
> > +		{ ignore_case ? "Key1" : "key1", "value2", "UNUSED" },
> > +		{ "fooBarFrotz", "value3", "UNUSED" },
> > +		{ ignore_case ? "Foobarfrotz" : "fooBarFrotz", "value4", "UNUSED" }
> > +	};
> > +	const char *queries[] =3D { "key1",
> > +				  ignore_case ? "Foobarfrotz" : "fooBarFrotz" };
> > +
> > +	for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> > +		entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]=
);
> > +		hashmap_add(map, &entry->ent);
> > +	}
> > +
> > +	for (size_t i =3D 0; i < ARRAY_SIZE(queries); i++) {
>
> Since we only have one query, can we remove the loop and simplify the
> following block of code?

We have two queries as can be seen above. One is "key1" and the other is
"Foobarfrotz"/"fooBarFrotz".

> Also (here and elsewhere), it might be less confusing to say "UNSEEN" /
> "SEEN" instead of "UNUSED" / "USED". The latter makes it sound to me
> like there's some API requirement to have a 3-item array that we don't
> actually need, but in this case those fields are actually used in
> key_val_contains() to track duplicates.

Yeah, "UNSEEN" is definitely less confusing. Will change.

>
> > +		int count =3D 0;
> > +		entry =3D hashmap_get_entry_from_hash(map,
> > +			ignore_case ? strihash(queries[i]) :
> > +				      strhash(queries[i]),
> > +			queries[i], struct test_entry, ent);
> > +
> > +		hashmap_for_each_entry_from(map, entry, ent)
> > +		{
> > +			int ret;
> > +			if (!check_int((ret =3D key_val_contains(
> > +						key_val, ARRAY_SIZE(key_val),
> > +						entry)), =3D=3D, 0)) {
> > +				switch (ret) {
> > +				case 1:
> > +					test_msg("found entry was not given in the input\n"
> > +						 "    key: %s\n  value: %s",
> > +						 entry->key, get_value(entry));
> > +					break;
> > +				case 2:
> > +					test_msg("duplicate entry detected\n"
> > +						 "    key: %s\n  value: %s",
> > +						 entry->key, get_value(entry));
> > +					break;
> > +				}
> > +			} else {
> > +				count++;
> > +			}
> > +		}
> > +		check_int(count, =3D=3D, 2);
> > +	}
> > +	check_int(hashmap_get_size(map), =3D=3D, ARRAY_SIZE(key_val));
> > +	check(get_test_entry(map, ignore_case, "notInMap") =3D=3D NULL);
> > +}
> > +
> > +static void t_remove(struct hashmap *map, int ignore_case)
> > +{
> > +	struct test_entry *entry, *removed;
> > +	const char *key_val[][2] =3D { { "key1", "value1" },
> > +				     { "key2", "value2" },
> > +				     { "fooBarFrotz", "value3" } };
> > +	const char *remove[][2] =3D { { ignore_case ? "Key1" : "key1", "value=
1" },
> > +				    { ignore_case ? "keY2" : "key2", "value2" } };
> > +
> > +	for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> > +		entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]=
);
> > +		check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> > +	}
> > +
> > +	for (size_t i =3D 0; i < ARRAY_SIZE(remove); i++) {
> > +		entry =3D alloc_test_entry(ignore_case, remove[i][0], "");
> > +		removed =3D hashmap_remove_entry(map, entry, ent, remove[i][0]);
> > +		if (check(removed !=3D NULL))
> > +			check_str(get_value(removed), remove[i][1]);
> > +		free(entry);
> > +		free(removed);
> > +	}
> > +
> > +	entry =3D alloc_test_entry(ignore_case, "notInMap", "");
> > +	check(hashmap_remove_entry(map, entry, ent, "notInMap") =3D=3D NULL);
> > +	free(entry);
> > +}
>
> Is there a reason why you don't check the table size as the shell test
> did? (similar to what you have in t_put())

Huh, I seem to have forgotten to put this snippet here:
 =20
	check_int(map->tablesize, =3D=3D, 64);
	check_int(hashmap_get_size(map), =3D=3D, ARRAY_SIZE(key_val) - ARRAY_SIZE(=
remove));
=09
I'll add it in v3.

>
> > +static void t_iterate(struct hashmap *map, int ignore_case)
> > +{
> > +	struct test_entry *entry;
> > +	struct hashmap_iter iter;
> > +	const char *key_val[][3] =3D { { "key1", "value1", "UNUSED" },
> > +				     { "key2", "value2", "UNUSED" },
> > +				     { "fooBarFrotz", "value3", "UNUSED" } };
> > +	int count =3D 0;
> > +
> > +	for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> > +		entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1]=
);
> > +		check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> > +	}
> > +
> > +	hashmap_for_each_entry(map, &iter, entry, ent /* member name */)
> > +	{
> > +		int ret;
> > +		if (!check_int((ret =3D key_val_contains(key_val, ARRAY_SIZE(key_val=
),
> > +						       entry)), =3D=3D, 0)) {
> > +			switch (ret) {
> > +			case 1:
> > +				test_msg("found entry was not given in the input\n"
> > +					 "    key: %s\n  value: %s",
> > +					 entry->key, get_value(entry));
> > +				break;
> > +			case 2:
> > +				test_msg("duplicate entry detected\n"
> > +					 "    key: %s\n  value: %s",
> > +					 entry->key, get_value(entry));
> > +				break;
> > +			}
> > +		} else {
> > +			count++;
> > +		}
> > +	}
> > +	check_int(count, =3D=3D, ARRAY_SIZE(key_val));
> > +	check_int(hashmap_get_size(map), =3D=3D, ARRAY_SIZE(key_val));
> > +}
> > +
> > +static void t_alloc(struct hashmap *map, int ignore_case)
> > +{
> > +	struct test_entry *entry, *removed;
> > +
> > +	for (int i =3D 1; i <=3D 51; i++) {
> > +		char *key =3D xstrfmt("key%d", i);
> > +		char *value =3D xstrfmt("value%d", i);
> > +		entry =3D alloc_test_entry(ignore_case, key, value);
> > +		check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> > +		free(key);
> > +		free(value);
> > +	}
> > +	check_int(map->tablesize, =3D=3D, 64);
> > +	check_int(hashmap_get_size(map), =3D=3D, 51);
> > +
> > +	entry =3D alloc_test_entry(ignore_case, "key52", "value52");
> > +	check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> > +	check_int(map->tablesize, =3D=3D, 256);
> > +	check_int(hashmap_get_size(map), =3D=3D, 52);
> > +
> > +	for (int i =3D 1; i <=3D 12; i++) {
> > +		char *key =3D xstrfmt("key%d", i);
> > +		char *value =3D xstrfmt("value%d", i);
> > +
> > +		entry =3D alloc_test_entry(ignore_case, key, "");
> > +		removed =3D hashmap_remove_entry(map, entry, ent, key);
> > +		if (check(removed !=3D NULL))
> > +			check_str(value, get_value(removed));
> > +		free(key);
> > +		free(value);
> > +		free(entry);
> > +		free(removed);
> > +	}
> > +	check_int(map->tablesize, =3D=3D, 256);
> > +	check_int(hashmap_get_size(map), =3D=3D, 40);
> > +
> > +	entry =3D alloc_test_entry(ignore_case, "key40", "");
> > +	removed =3D hashmap_remove_entry(map, entry, ent, "key40");
> > +	if (check(removed !=3D NULL))
> > +		check_str("value40", get_value(removed));
> > +	check_int(map->tablesize, =3D=3D, 64);
> > +	check_int(hashmap_get_size(map), =3D=3D, 39);
> > +	free(entry);
> > +	free(removed);
> > +}
> > +
> > +static void t_intern(struct hashmap *map, int ignore_case)
> > +{
> > +	const char *values[] =3D { "value1", "Value1", "value2", "value2" };
> > +
> > +	for (size_t i =3D 0; i < ARRAY_SIZE(values); i++) {
> > +		const char *i1 =3D strintern(values[i]);
> > +		const char *i2 =3D strintern(values[i]);
> > +
> > +		if (!check(!strcmp(i1, values[i])))
>
> Should we use check_str() here? Or does that add too much extraneous
> detail when the test_msg() below is what we really care about?

It would repetitive as both print the same thing but test_msg() has more
context.

> > +			test_msg("strintern(%s) returns %s\n", values[i], i1);
> > +		else if (!check(i1 !=3D values[i]))
>
> Similarly, check_pointer_eq() here?

How would we use check_pointer_eq() here as we are checking to make
sure they are not equal?

>
> > +			test_msg("strintern(%s) returns input pointer\n",
> > +				 values[i]);
> > +		else if (!check(i1 =3D=3D i2))
>
> And check_pointer_eq() here as well.

Will update here.

Thanks for the review.

