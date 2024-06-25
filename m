Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4B413C9A2
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719343015; cv=none; b=J2kC3LiHtepGrarc1TKFLcd+K64gWE7NeD7CYI1Hh6GYiAEiYV/M6R1siSNQH22bRNs+P+mTKl3AZX9yw6u68sNwd8M+rtvTda2YfjyVsjANOcvfrXNPy+MvP4+U1i1SlrQY+HL67TWskPDYz6/gsVvFLbi/YQg59zVOqg2Xqak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719343015; c=relaxed/simple;
	bh=oCIywCCT2rnjTVSj9PSF0A5RoFcSzIQ1ttMLiT+oHq0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AKTo0zADA/7/kSozYHOlSOXpspOKj56zG4bXAhBCenLB6GNi3KLAoHY9kNhxrRl7RneWZAGDZnR7GZtaqI7+MtcSOwyJu90jHcb3zAX2FMcfwayo1KvSgDPg0jGIyaDvsIhzosrFQXVKLaflAmZOUE0zhUixhxaD+iRJsux3Dwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULaaF4Jl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULaaF4Jl"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f480624d0fso46479095ad.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 12:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719343013; x=1719947813; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvruBWNMFf6QBLasFil/Qd9gfFBnInN5wGMKb6aLhEs=;
        b=ULaaF4Jl5tDeLoiIr+ATcgJsx0+dVxA+M8mPYlap5s06keihZR0cbX2cI8A5cCYBuF
         lKs8YlQ6l0aUYF4+EP6dagCXp7Jni1GzAkhFAO25aAIeBmk97Go8s1xHb41jfLdDCndA
         yywuU9uVn34o/s7favtytEczcuzJrUlZQy7+XiY3ewPXTvBjvW3OvYfjSXU7KVEbYRPA
         cHR7j7oVkegAdH/yck4HScebqYLO/cw3vj5nz6R3Xa2yDbJqOJuNjT+GD9GVrJkUjrk6
         /+I/2qUuWfDaU7EpAwYQo7tNSsX41YqZhgNgh8I9CIFvgIs15HOuijmhFX6GFCHhnlGh
         sexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719343013; x=1719947813;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dvruBWNMFf6QBLasFil/Qd9gfFBnInN5wGMKb6aLhEs=;
        b=qm71nf3kQnckhMKB05o58lBRThwZ75kcMdJBrJ+25ok05tJMVC1RIRoMfaWjep6Uj8
         oZiwZcyCZMuXdNakxmEc2fd/TJna0pHOz41006rHXj/0faRzZ3DZFD24r7Sva8gR39zN
         zkig/XvFpmZnD/78h1FETeKsxeXSLXez0yEf+CoVBZvFL/8Tz0vJrER60x7eDR6T6Mdk
         wIE+pvQvhnJ6b31tcKnkPvw+KHc1YuXOMBEyJdJaj/Iw0ZJ478W69tkINNmzo86bFxGp
         ZHpMOX5mtVq5i/U1L5lqjhUKc+8dp8FOZ9VRRmWUw+aSty21NecGY3QKkT9IHD+eG5wB
         qprw==
X-Gm-Message-State: AOJu0YxDz83xeP1GQnoqyLrNlyh5c2lz7qjKh8ClRkwwH/HIArOu5BJm
	VKa10/qNesrp+jEqElygPJ2J73nkZh2SViydyXMhU4rSwcjMaeee
X-Google-Smtp-Source: AGHT+IG73zpSJt69Py7Tu0rxpYKJFxTb8Tw0ZrYwc6DUDl6TOovYsUoPcOodPGtxTcFsSGdXXocXPg==
X-Received: by 2002:a17:902:d2cc:b0:1fa:3428:53c2 with SMTP id d9443c01a7336-1fa3428591bmr83703915ad.63.1719343012349;
        Tue, 25 Jun 2024 12:16:52 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f3089sm84840425ad.26.2024.06.25.12.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 12:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Jun 2024 00:46:46 +0530
Message-Id: <D29C89BS8UEJ.14F33FD8XJATD@gmail.com>
Cc: <git@vger.kernel.org>, <christian.couder@gmail.com>, "Christian Couder"
 <chriscool@tuxfamily.org>, "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>,
 "Josh Steadmon" <steadmon@google.com>
Subject: Re: [GSoC][PATCH] t: migrate helper/test-oidmap.c to
 unit-tests/t-oidmap.c
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: <phillip.wood@dunelm.org.uk>, "Jonathan Nieder" <jrnieder@gmail.com>
References: <20240619175036.64291-1-shyamthakkar001@gmail.com>
 <ZnP6G6SSBynlBNUj@google.com>
 <827f6cea-2367-403f-ba8b-055c9c8a7259@gmail.com>
In-Reply-To: <827f6cea-2367-403f-ba8b-055c9c8a7259@gmail.com>

Phillip Wood <phillip.wood123@gmail.com> wrote:
> Hi Ghanshyam
>
> On 20/06/2024 10:45, Jonathan Nieder wrote:
> > Ghanshyam Thakkar wrote:
> >=20
> >> helper/test-oidmap.c along with t0016-oidmap.sh test the oidmap.h
> >> library which is built on top of hashmap.h to store arbitrary
> >> datastructure (which must contain oidmap_entry, which is a wrapper
> >> around object_id).
>
> I'm not really sure what the sentence is trying to say. I think it would
> be helpful to start the commit message with an introductory sentence
> explaining that the oidmap is currently tested via `test-tool` and this
> commit converts those tests to unit tests.

Got it. Will improve. I just wanted to explain the basics of oidmap to
help ease the review process.

> These entries can be accessed by querying their
> >> associated object_id.
> >>
> >> Migrate them to the unit testing framework for better performance,
> >> concise code and better debugging. Along with the migration also plug
> >> memory leaks and make the test logic independent for all the tests.
>
> >> The migration removes 'put' tests from t0016, because it is used as
> >> setup to all the other tests, so testing it separately does not yield
> >> any benefit.
>
> Thanks sounds sensible, thanks for explaining it in the commit message.
>
> Overall the patch looks pretty good, I've left a couple of comments
> below.
>
> >> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> >> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> >> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> >> ---
>
> >> diff --git a/t/unit-tests/t-oidmap.c b/t/unit-tests/t-oidmap.c
> >> new file mode 100644
> >> index 0000000000..9b98a3ed09
> >> --- /dev/null
> >> +++ b/t/unit-tests/t-oidmap.c
> >> @@ -0,0 +1,165 @@
> >> +#include "test-lib.h"
> >> +#include "lib-oid.h"
> >> +#include "oidmap.h"
> >> +#include "hash.h"
> >> +#include "hex.h"
> >> +
> >> +/*
> >> + * elements we will put in oidmap structs are made of a key: the entr=
y.oid
> >> + * field, which is of type struct object_id, and a value: the name fi=
eld (could
> >> + * be a refname for example)
> >> + */
> >> +struct test_entry {
> >> +	struct oidmap_entry entry;
> >> +	char name[FLEX_ARRAY];
> >> +};
> >> +
> >> +static const char *key_val[][2] =3D { { "11", "one" },
> >> +				    { "22", "two" },
> >> +				    { "33", "three" } };
> >> +
> >> +static int put_and_check_null(struct oidmap *map, const char *hex,
> >> +			      const char *entry_name)
> >> +{
> >> +	struct test_entry *entry;
> >> +
> >> +	FLEX_ALLOC_STR(entry, name, entry_name);
> >> +	if (get_oid_arbitrary_hex(hex, &entry->entry.oid))
> >> +		return -1;
>
> When writing unit tests it is important to make sure that they fail,
> rather than just return early if there is an error. There are a number
> of places like this that return early without calling one of the check()
> macros to make the test fail.

They do fail. `get_oid_arbitrary_hex()` from 'unit-tests/lib-oid.h' is
a function specifically built for the use in unit tests. And it
contains in built `check_*` to ensure that the tests fails if something
goes wrong and also prints diagnostic info. Maybe we can add a check here
as well to know the line number at which the call failed, but since we
already print queried hex value and other diagnostic info from
`get_oid_arbitrary_hex()`, I thought it would be enough.

> >> +	if (!check(oidmap_put(map, entry) =3D=3D NULL))
> >> +		return -1;
> >> +	return 0;
> >> +}
> >> +
> >> +static void setup(void (*f)(struct oidmap *map))
> >> +{
> >> +	struct oidmap map =3D OIDMAP_INIT;
> >> +	int ret =3D 0;
> >> +
> >> +	for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++)
> >> +		if ((ret =3D put_and_check_null(&map, key_val[i][0],
> >> +					      key_val[i][1])))
>
> Given there is only one caller I think it would be easier to see what is
> going on if the function body was just inlined into the loop here.

Yeah, will do.

> >> +			break;
> >> +
> >> +	if (!ret)
> >> +		f(&map);
> >> +	oidmap_free(&map, 1);
> >> +}
>
> The tests for replace, get, remove all look like faithful translations
> of the old script and are fine apart from some missing check() calls
> when get_oid_arbitrary_hex() fails.
>
> >> +static int key_val_contains(struct test_entry *entry)
> >> +{
> >> +	/* the test is small enough to be able to bear O(n) */
>
> It is good to think about that but I'm not sure we need a comment about
> it in a small test like this.

Got it. Will remove.

> >> +	for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> >> +		if (!strcmp(key_val[i][1], entry->name)) {
> >> +			struct object_id oid;
> >> +			if (get_oid_arbitrary_hex(key_val[i][0], &oid))
> >> +				return -1;
> >> +			if (oideq(&entry->entry.oid, &oid))
> >> +				return 0;
> >> +		}
> >> +	}
> >> +	return 1;
> >> +}
>
> So if we cannot construct the oid we return -1, if the oid matches we
> return 0 and if the oid does not match we return 1
>
> >> +static void t_iterate(struct oidmap *map)
> >> +{
> >> +	struct oidmap_iter iter;
> >> +	struct test_entry *entry;
> >> +	int ret;
> >> +
> >> +	oidmap_iter_init(map, &iter);
> >> +	while ((entry =3D oidmap_iter_next(&iter))) {
> >> +		if (!check_int((ret =3D key_val_contains(entry)), =3D=3D, 0)) {
> >> +			if (ret =3D=3D -1)
> >> +				return;
> >> +			test_msg("obtained entry was not given in the input\n"
> >> +				 "  name: %s\n   oid: %s\n",
> >> +				 entry->name, oid_to_hex(&entry->entry.oid));
>
> This checks that all of the expect objects are present, but does not
> check for duplicate objects. An alternative would be to build an array
> of all the entries, then sort it by oid and compare that to a sorted
> version of `key_val`. That is what the scripted version does. We don't
> have any helpers for comparing arrays so you'd need to do that by
> comparing each element in a loop.
>
> >> +		}
> >> +	}
> >> +	check_int(hashmap_get_size(&map->map), =3D=3D, ARRAY_SIZE(key_val));
>
> One could argue that this helps guard against duplicate entries but
> that's only true if we trust hashmap_get_size() so I think keeping this
> to check that hashmap_get_size() gives the correct size and changing the
> loop above would be better.

Yeah, since I was not sure if hashmap's order is predictable, I first
checked if the entry exists and later checked if the size matches. I'll
try to do the array approach you mentioned.

Thank you for the review.
