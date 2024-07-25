Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826519AA52
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911746; cv=none; b=rYuP07SlUZoehJ0DRXEfIgYajogO193M32GQcfVhsD4OVI/yNZZIw/U29WdHjJLk0fAXDL+/nlnKS0r1PVhTzEvC9TKMSieMglsSW04lefSUIgphKiQ4Y4QY3rMfkkVaneZUDcuAT3YqWpMsG0vbpCU5ZlDSvnfOy3fMMSbvo+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911746; c=relaxed/simple;
	bh=pXkEoaOFwC8borfELJm2/PSW7qyYDL0uwbrHajpS/Vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GapEf8ffCpKtQP7XLbjj0cPfmQwhb8BZNh7YTE6euS59XsVqH7fHOnU4xgUppAz7AHKUXxF6iq6N/wpZmW1Ux+TNswADB3tzqP/edPim80WYtYZXKpXvpm9CE7Wi2lN7NakNENN+2+lTNtDoiQC3ncEX13l3wR29iyGL2VeZzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APtHTwVV; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APtHTwVV"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso58370566b.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 05:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721911743; x=1722516543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiD8NYxHJzssQ47t/Q71wy1Gc8vEcgHV6wOEJsdD9cg=;
        b=APtHTwVVMySbAkLICJW0nPvIpau628/PJl88U++ZMhLuZVvCANWwmxyOM9G+HaEcLg
         yGhIPEgjVkIAYOE/jKvuXhomU2y2ViTlbNL1lVs2sKzPPXK+N/T3aGUrHIZ12ePYkBWL
         mKMQAJNwsc8J4NupLYL6vKyw+F+JQHeIMu8UwsGY/IcsgNciBFlnmj6FNrIbzzYVrgQh
         yW9Q4Cm8HEjPvUQbfWYBiBHXzu31nu/sW+Ht9UyaRcVMsyDb3SLa5IkAAiJq6PVr0fu2
         Fc0TedUT579Ya0/NhTsk044zKpp5DHOqY88HojOqcO1Kd2ydF59nLgAP5CxCOgrvLGtF
         08/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721911743; x=1722516543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiD8NYxHJzssQ47t/Q71wy1Gc8vEcgHV6wOEJsdD9cg=;
        b=LkT/f30ZwZibDF1r+PoXnre1XbdQuaII0T7MMu+r5Iw9VDOxxt2GshRjkL/XxMaeEE
         eYUGdyOdHQLoo58qEQWeBzXykAQm2auN1T46G3niAMiA4GxvS5CCA7KV5BUMidGE8yuK
         JYO0QCBXw6gGaPWfOIRND9BKzOy0sDCoaaQlCQr/FVmLR+o0xZjdHqFlePIiSftsS1S9
         fc1gkEFrx5cPpp51MjXSJ10BYGxY4o8UOVWlFTd2nZ6m/CPovqwiuHA3HWOAv+cKfQVh
         eQbmcaUmLVwqt1rbJk/kYF9wLT8KBhq38WrF0uReDkS/8xaBO+JgJp/KovLkf2ayql6N
         ix5A==
X-Gm-Message-State: AOJu0YwS1a1bUZ96Nn33t72W242XK8h+17ppPJZ+pqndn9LGVNqzgG+Z
	0IAma10yso2fVCimZOgRPHXx4gOXSW06plUj/UZpB9jhx8/4YhV6nsLEBec9tdRON8XjleSCJkg
	v9ompe1S4j4g7SRqpP3004rAmdrk=
X-Google-Smtp-Source: AGHT+IGtb+OL8LyB8R9UtaArw8HJQ1M0p5QQLk8xayhpjNhvZpB0G1LPJAub4AgrR2hgt2y8xAZZ77Ff8qOCjDWMXYs=
X-Received: by 2002:a17:907:6d17:b0:a7a:9144:e251 with SMTP id
 a640c23a62f3a-a7acb38edc8mr162249666b.11.1721911742999; Thu, 25 Jul 2024
 05:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708161641.10335-2-shyamthakkar001@gmail.com> <20240711235159.5320-1-shyamthakkar001@gmail.com>
In-Reply-To: <20240711235159.5320-1-shyamthakkar001@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 25 Jul 2024 14:48:50 +0200
Message-ID: <CAP8UFD0apMhWA_F4La13=P3Mq433_Kq2qXzkVp9FNC+cWi_U9A@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3] t: port helper/test-hashmap.c to unit-tests/t-hashmap.c
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 1:52=E2=80=AFAM Ghanshyam Thakkar
<shyamthakkar001@gmail.com> wrote:
>
> helper/test-hashmap.c along with t0011-hashmap.sh test the hashmap.h
> library. Migrate them to the unit testing framework for better
> debugging, runtime performance and concise code.
>
> Along with the migration, make 'add' tests from the shellscript order

Nit: s/shellscript/shell script/

> agnostic in unit tests, since they iterate over entries with the same
> keys and we do not guarantee the order.

The above is not very clear. Maybe rephrasing a bit and adding an
example could help.

> The helper/test-hashmap.c is still not removed because it contains a
> performance test meant to be run by the user directly (not used in
> t/perf). And it makes sense for such a utility to be a helper.


> diff --git a/t/unit-tests/t-hashmap.c b/t/unit-tests/t-hashmap.c
> new file mode 100644
> index 0000000000..3112b10b33
> --- /dev/null
> +++ b/t/unit-tests/t-hashmap.c
> @@ -0,0 +1,358 @@
> +#include "test-lib.h"
> +#include "hashmap.h"
> +#include "strbuf.h"
> +
> +struct test_entry {
> +       int padding; /* hashmap entry no longer needs to be the first mem=
ber */
> +       struct hashmap_entry ent;
> +       /* key and value as two \0-terminated strings */
> +       char key[FLEX_ARRAY];
> +};
> +
> +static int test_entry_cmp(const void *cmp_data,
> +                         const struct hashmap_entry *eptr,
> +                         const struct hashmap_entry *entry_or_key,
> +                         const void *keydata)
> +{
> +       const int ignore_case =3D cmp_data ? *((int *)cmp_data) : 0;
> +       const struct test_entry *e1, *e2;
> +       const char *key =3D keydata;
> +
> +       e1 =3D container_of(eptr, const struct test_entry, ent);
> +       e2 =3D container_of(entry_or_key, const struct test_entry, ent);
> +
> +       if (ignore_case)
> +               return strcasecmp(e1->key, key ? key : e2->key);
> +       else
> +               return strcmp(e1->key, key ? key : e2->key);
> +}
> +
> +static const char *get_value(const struct test_entry *e)
> +{
> +       return e->key + strlen(e->key) + 1;
> +}
> +
> +static struct test_entry *alloc_test_entry(unsigned int ignore_case,
> +                                          const char *key, const char *v=
alue)

Nit: `unsigned int ignore_case` is a bool flag argument which we often
put at the end of function arguments, so perhaps:

static struct test_entry *alloc_test_entry(const char *key, const char *val=
ue,
                                          unsigned int ignore_case)

> +{
> +       size_t klen =3D strlen(key);
> +       size_t vlen =3D strlen(value);
> +       unsigned int hash =3D ignore_case ? strihash(key) : strhash(key);
> +       struct test_entry *entry =3D xmalloc(st_add4(sizeof(*entry), klen=
, vlen, 2));
> +
> +       hashmap_entry_init(&entry->ent, hash);
> +       memcpy(entry->key, key, klen + 1);
> +       memcpy(entry->key + klen + 1, value, vlen + 1);
> +       return entry;
> +}
> +
> +static struct test_entry *get_test_entry(struct hashmap *map,
> +                                        unsigned int ignore_case, const =
char *key)

Here also `unsigned int ignore_case` might want to be the last argument.

> +{
> +       return hashmap_get_entry_from_hash(
> +               map, ignore_case ? strihash(key) : strhash(key), key,
> +               struct test_entry, ent);
> +}
> +
> +static int key_val_contains(const char *key_val[][2], char seen[], size_=
t n,
> +                           struct test_entry *entry)
> +{
> +       for (size_t i =3D 0; i < n; i++) {
> +               if (!strcmp(entry->key, key_val[i][0]) &&
> +                   !strcmp(get_value(entry), key_val[i][1])) {
> +                       if (seen[i])
> +                               return 2;
> +                       seen[i] =3D 1;
> +                       return 0;
> +               }
> +       }
> +       return 1;
> +}
> +
> +static void setup(void (*f)(struct hashmap *map, int ignore_case),
> +                 int ignore_case)

Why `int ignore_case` here, instead of `unsigned int ignore_case` above?

It's nice that the `ignore_case` argument is the last argument though.

> +{
> +       struct hashmap map =3D HASHMAP_INIT(test_entry_cmp, &ignore_case)=
;
> +
> +       f(&map, ignore_case);
> +       hashmap_clear_and_free(&map, struct test_entry, ent);
> +}
> +
> +static void t_replace(struct hashmap *map, int ignore_case)

Here also, why `int ignore_case` here, instead of `unsigned int
ignore_case` towards the top of this file?

I won't mention it anymore below, but I think it might be better to
have `unsigned int ignore_case` everywhere.

> +{
> +       struct test_entry *entry;
> +
> +       entry =3D alloc_test_entry(ignore_case, "key1", "value1");
> +       check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> +
> +       entry =3D alloc_test_entry(ignore_case, ignore_case ? "Key1" : "k=
ey1",
> +                                "value2");
> +       entry =3D hashmap_put_entry(map, entry, ent);
> +       if (check(entry !=3D NULL))
> +               check_str(get_value(entry), "value1");
> +       free(entry);
> +
> +       entry =3D alloc_test_entry(ignore_case, "fooBarFrotz", "value3");
> +       check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> +
> +       entry =3D alloc_test_entry(ignore_case,
> +                                ignore_case ? "foobarfrotz" : "fooBarFro=
tz",
> +                                "value4");

Maybe using something like "FOObarFrotZ" instead of "foobarfrotz"
would make it clear that we don't need to downcase in case we ignore
case.

> +       entry =3D hashmap_put_entry(map, entry, ent);
> +       if (check(entry !=3D NULL))
> +               check_str(get_value(entry), "value3");
> +       free(entry);
> +}
> +
> +static void t_get(struct hashmap *map, int ignore_case)
> +{
> +       struct test_entry *entry;
> +       const char *key_val[][2] =3D { { "key1", "value1" },
> +                                    { "key2", "value2" },
> +                                    { "fooBarFrotz", "value3" },
> +                                    { ignore_case ? "key4" : "foobarfrot=
z", "value4" } };
> +       const char *query[][2] =3D {
> +               { ignore_case ? "Key1" : "key1", "value1" },
> +               { ignore_case ? "keY2" : "key2", "value2" },
> +               { ignore_case ? "foobarfrotz" : "fooBarFrotz", "value3" }
> +       };

I think adding a test case like:

               { ignore_case ? "FOOBarFrotZ" : "foobarfrotz",
                 ignore_case ? : "value3" : "value4" }

which is a bit similar to what Junio suggested, could help a bit check
that things work well especially when not ignoring the case.

> +       for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> +               entry =3D alloc_test_entry(ignore_case, key_val[i][0], ke=
y_val[i][1]);
> +               check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL=
);
> +       }
> +
> +       for (size_t i =3D 0; i < ARRAY_SIZE(query); i++) {
> +               entry =3D get_test_entry(map, ignore_case, query[i][0]);
> +               if (check(entry !=3D NULL))
> +                       check_str(get_value(entry), query[i][1]);
> +               else
> +                       test_msg("query key: %s", query[i][0]);
> +       }
> +
> +       check_pointer_eq(get_test_entry(map, ignore_case, "notInMap"), NU=
LL);
> +       check_int(map->tablesize, =3D=3D, 64);
> +       check_int(hashmap_get_size(map), =3D=3D, ARRAY_SIZE(key_val));
> +}
> +
> +static void t_add(struct hashmap *map, int ignore_case)
> +{
> +       struct test_entry *entry;
> +       const char *key_val[][2] =3D {
> +               { "key1", "value1" },
> +               { ignore_case ? "Key1" : "key1", "value2" },
> +               { "fooBarFrotz", "value3" },
> +               { ignore_case ? "Foobarfrotz" : "fooBarFrotz", "value4" }
> +       };
> +       const char *queries[] =3D { "key1",
> +                                 ignore_case ? "Foobarfrotz" : "fooBarFr=
otz" };

It is tricky that here `queries` is not defined and doesn't contain
the same things as in the other functions above:

const char *queries[][2] =3D ...

Maybe changing the name to something like `query_keys` would help make
people aware that here it contains only keys.

> +       char seen[ARRAY_SIZE(key_val)] =3D { 0 };
> +
> +       for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> +               entry =3D alloc_test_entry(ignore_case, key_val[i][0], ke=
y_val[i][1]);
> +               hashmap_add(map, &entry->ent);
> +       }
> +
> +       for (size_t i =3D 0; i < ARRAY_SIZE(queries); i++) {
> +               int count =3D 0;
> +               entry =3D hashmap_get_entry_from_hash(map,
> +                       ignore_case ? strihash(queries[i]) :
> +                                     strhash(queries[i]),
> +                       queries[i], struct test_entry, ent);
> +
> +               hashmap_for_each_entry_from(map, entry, ent)
> +               {
> +                       int ret;
> +                       if (!check_int((ret =3D key_val_contains(
> +                                               key_val, seen,
> +                                               ARRAY_SIZE(key_val), entr=
y)),
> +                                      =3D=3D, 0)) {
> +                               switch (ret) {
> +                               case 1:
> +                                       test_msg("found entry was not giv=
en in the input\n"
> +                                                "    key: %s\n  value: %=
s",
> +                                                entry->key, get_value(en=
try));
> +                                       break;
> +                               case 2:
> +                                       test_msg("duplicate entry detecte=
d\n"
> +                                                "    key: %s\n  value: %=
s",
> +                                                entry->key, get_value(en=
try));
> +                                       break;
> +                               }
> +                       } else {
> +                               count++;
> +                       }
> +               }
> +               check_int(count, =3D=3D, 2);
> +       }
> +
> +       for (size_t i =3D 0; i < ARRAY_SIZE(seen); i++) {
> +               if (!check_int(seen[i], =3D=3D, 1))
> +                       test_msg("following key-val pair was not iterated=
 over:\n"
> +                                "    key: %s\n  value: %s",
> +                                key_val[i][0], key_val[i][1]);
> +       }
> +
> +       check_int(hashmap_get_size(map), =3D=3D, ARRAY_SIZE(key_val));
> +       check_pointer_eq(get_test_entry(map, ignore_case, "notInMap"), NU=
LL);
> +}

Thanks!
