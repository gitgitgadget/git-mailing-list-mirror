Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EBC17BA0
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 01:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279329; cv=none; b=WoR05Omo6YWOSn76nDJBuwTkyVeyJXlQbDlixVWniNUXYlN2Qdx/Tvh1SG1MkQGBXmk43+jin1D25e+sNl9HeUnyoHLvr5Ix2nUCbimdYJwDE4ro2XHjxo6hefLqruAPzfUy5K1Dh1gIvMrNk55d1d0oI+5jW4VzdEyCsGlBDjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279329; c=relaxed/simple;
	bh=oASy3gg0/whCPNqqk6wb8vfHF5UZJ2OjX6GH2p+uTY4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=re/G6IuJKAwqMNJOKqsp34sgRJys6vyM34oA+bhmirvAPqhPCeYs3FfLFu7/yqAYG2qyAuIZyPbAn3pzfiPvCP0YVvp0mB3OM888miY6H82l8nrA7fFrrekgDAbxaYUCz5DoYPUf/ZTdiSk2aYnCjTX+ayzGiBFin+N2oDFwHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hb7ctaEX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb7ctaEX"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7066a4a611dso1697597b3a.3
        for <git@vger.kernel.org>; Mon, 24 Jun 2024 18:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719279326; x=1719884126; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkOtoCfVED/pfIkEgRgMYgxdz+dYW055oZMl4W4yyAM=;
        b=hb7ctaEXHYuoBZ1mDiKLPJntcMDgs0KmyXfaIKh8PvUOm42Gaxcf3kJU4vHibiWF1l
         6pDNAYxNC2beBKxhLL0ArUaiQ3vDGeiyDs/oeMrRGndMWVX9c/CAJDsrf+KGGZK3AM+P
         +SN2pPMcgu37pHTmDEPwe0JaaD5zJdMHfxrhnnh6x5vlKHRCpOPCNFptHSns1dsjiiba
         BsRnJmZ9SOZ80mIZ+R5aXoIDduAxVjmLF/qqhvIf+tAvqaDNrwoGQVWZjSOzhzr7JQNN
         w4SPHLtZJBskK9k/qxC3wF76u1dJ2Hg7Rn6TvLTNS5xX6Cg4IO/RSM3KqOtEU4UJxo5Q
         aZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719279326; x=1719884126;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qkOtoCfVED/pfIkEgRgMYgxdz+dYW055oZMl4W4yyAM=;
        b=f1bZ0j74qWH1CSHQnXQTlqio5SS/zTPl8hX1QMMIZJ0P19Z5M4E34qQCgtAInAnRA/
         Q92Ikc2qu/vd0tnJv5P79CNGW06octdQMkTBbsbDWHJOLKo/nbKPSXNx3ddsi5Nxo8E2
         3l/9nfPVF+wN0QDk1n6d++fLnC+q2OJWEuuNOO+5OACuM6LLt8iHv0MMyra56pSPlwup
         mGdhClz7xF6CvQK35do71eWSIDMLfIYoEYr/ipwXaUxz3kb3nByk7r2Civpz2Fz3gyDR
         8vVGa72AVCG9U8l4YvY4lXAtzORcQBJND+ssjqXf9bmi7VRdidGAkxLdMYUjqtR4HNDZ
         w69Q==
X-Gm-Message-State: AOJu0YxwxLmM2ysPIegcBvZEq/c42awsjSHbLVg0uJ4nWOIhJfU5Hw9z
	VIZgBrIr+VEAgOOKwXJjvxOwAL93Ajf/JchfbHGN1d1J1NsNLDVa
X-Google-Smtp-Source: AGHT+IE9aSqZPvp1Q0cH8sCe2NzyjWGxdiMU9Qi+iR3t040mR9VKc5AB3GVZH0nmXuMwR1tO7HQJXA==
X-Received: by 2002:aa7:8a10:0:b0:706:6af8:e081 with SMTP id d2e1a72fcca58-70674548c80mr6148889b3a.1.1719279326146;
        Mon, 24 Jun 2024 18:35:26 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7068d2514e7sm1951991b3a.179.2024.06.24.18.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 18:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Jun 2024 07:05:20 +0530
Message-Id: <D28PNKAL7263.TAZ31N4UDX5E@gmail.com>
Cc: <git@vger.kernel.org>, <christian.couder@gmail.com>, "Christian Couder"
 <chriscool@tuxfamily.org>, "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>,
 "Josh Steadmon" <steadmon@google.com>, "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [GSoC][PATCH] t: migrate helper/test-oidmap.c to
 unit-tests/t-oidmap.c
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Jonathan Nieder" <jrnieder@gmail.com>
References: <20240619175036.64291-1-shyamthakkar001@gmail.com>
 <ZnP6G6SSBynlBNUj@google.com>
In-Reply-To: <ZnP6G6SSBynlBNUj@google.com>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ghanshyam Thakkar wrote:
>
> > helper/test-oidmap.c along with t0016-oidmap.sh test the oidmap.h
> > library which is built on top of hashmap.h to store arbitrary
> > datastructure (which must contain oidmap_entry, which is a wrapper
> > around object_id). These entries can be accessed by querying their
> > associated object_id.
> >
> > Migrate them to the unit testing framework for better performance,
> > concise code and better debugging. Along with the migration also plug
> > memory leaks and make the test logic independent for all the tests.
> > The migration removes 'put' tests from t0016, because it is used as
> > setup to all the other tests, so testing it separately does not yield
> > any benefit.
> >
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> > Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> > ---
> > This patch is depenedent on 'gt/unit-test-oidtree' for lib-oid.
>
> Very neat! I'm cc-ing Josh Steadmon for unit test framework expertise.
>
> Patch left unsnipped for reference.

Friendly reminder for reviews/acks. :)

Thanks.

> >  Makefile                |   2 +-
> >  t/helper/test-oidmap.c  | 123 ------------------------------
> >  t/helper/test-tool.c    |   1 -
> >  t/helper/test-tool.h    |   1 -
> >  t/t0016-oidmap.sh       | 112 ---------------------------
> >  t/unit-tests/t-oidmap.c | 165 ++++++++++++++++++++++++++++++++++++++++
> >  6 files changed, 166 insertions(+), 238 deletions(-)
> >  delete mode 100644 t/helper/test-oidmap.c
> >  delete mode 100755 t/t0016-oidmap.sh
> >  create mode 100644 t/unit-tests/t-oidmap.c
> >=20
> > diff --git a/Makefile b/Makefile
> > index 03751e0fc0..f7ed50f3a9 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -810,7 +810,6 @@ TEST_BUILTINS_OBJS +=3D test-match-trees.o
> >  TEST_BUILTINS_OBJS +=3D test-mergesort.o
> >  TEST_BUILTINS_OBJS +=3D test-mktemp.o
> >  TEST_BUILTINS_OBJS +=3D test-oid-array.o
> > -TEST_BUILTINS_OBJS +=3D test-oidmap.o
> >  TEST_BUILTINS_OBJS +=3D test-online-cpus.o
> >  TEST_BUILTINS_OBJS +=3D test-pack-mtimes.o
> >  TEST_BUILTINS_OBJS +=3D test-parse-options.o
> > @@ -1334,6 +1333,7 @@ THIRD_PARTY_SOURCES +=3D sha1dc/%
> > =20
> >  UNIT_TEST_PROGRAMS +=3D t-ctype
> >  UNIT_TEST_PROGRAMS +=3D t-mem-pool
> > +UNIT_TEST_PROGRAMS +=3D t-oidmap
> >  UNIT_TEST_PROGRAMS +=3D t-oidtree
> >  UNIT_TEST_PROGRAMS +=3D t-prio-queue
> >  UNIT_TEST_PROGRAMS +=3D t-strbuf
> > diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
> > deleted file mode 100644
> > index bd30244a54..0000000000
> > --- a/t/helper/test-oidmap.c
> > +++ /dev/null
> > @@ -1,123 +0,0 @@
> > -#include "test-tool.h"
> > -#include "hex.h"
> > -#include "object-name.h"
> > -#include "oidmap.h"
> > -#include "repository.h"
> > -#include "setup.h"
> > -#include "strbuf.h"
> > -#include "string-list.h"
> > -
> > -/* key is an oid and value is a name (could be a refname for example) =
*/
> > -struct test_entry {
> > -	struct oidmap_entry entry;
> > -	char name[FLEX_ARRAY];
> > -};
> > -
> > -#define DELIM " \t\r\n"
> > -
> > -/*
> > - * Read stdin line by line and print result of commands to stdout:
> > - *
> > - * hash oidkey -> sha1hash(oidkey)
> > - * put oidkey namevalue -> NULL / old namevalue
> > - * get oidkey -> NULL / namevalue
> > - * remove oidkey -> NULL / old namevalue
> > - * iterate -> oidkey1 namevalue1\noidkey2 namevalue2\n...
> > - *
> > - */
> > -int cmd__oidmap(int argc UNUSED, const char **argv UNUSED)
> > -{
> > -	struct string_list parts =3D STRING_LIST_INIT_NODUP;
> > -	struct strbuf line =3D STRBUF_INIT;
> > -	struct oidmap map =3D OIDMAP_INIT;
> > -
> > -	setup_git_directory();
> > -
> > -	/* init oidmap */
> > -	oidmap_init(&map, 0);
> > -
> > -	/* process commands from stdin */
> > -	while (strbuf_getline(&line, stdin) !=3D EOF) {
> > -		char *cmd, *p1, *p2;
> > -		struct test_entry *entry;
> > -		struct object_id oid;
> > -
> > -		/* break line into command and up to two parameters */
> > -		string_list_setlen(&parts, 0);
> > -		string_list_split_in_place(&parts, line.buf, DELIM, 2);
> > -		string_list_remove_empty_items(&parts, 0);
> > -
> > -		/* ignore empty lines */
> > -		if (!parts.nr)
> > -			continue;
> > -		if (!*parts.items[0].string || *parts.items[0].string =3D=3D '#')
> > -			continue;
> > -
> > -		cmd =3D parts.items[0].string;
> > -		p1 =3D parts.nr >=3D 1 ? parts.items[1].string : NULL;
> > -		p2 =3D parts.nr >=3D 2 ? parts.items[2].string : NULL;
> > -
> > -		if (!strcmp("put", cmd) && p1 && p2) {
> > -
> > -			if (repo_get_oid(the_repository, p1, &oid)) {
> > -				printf("Unknown oid: %s\n", p1);
> > -				continue;
> > -			}
> > -
> > -			/* create entry with oid_key =3D p1, name_value =3D p2 */
> > -			FLEX_ALLOC_STR(entry, name, p2);
> > -			oidcpy(&entry->entry.oid, &oid);
> > -
> > -			/* add / replace entry */
> > -			entry =3D oidmap_put(&map, entry);
> > -
> > -			/* print and free replaced entry, if any */
> > -			puts(entry ? entry->name : "NULL");
> > -			free(entry);
> > -
> > -		} else if (!strcmp("get", cmd) && p1) {
> > -
> > -			if (repo_get_oid(the_repository, p1, &oid)) {
> > -				printf("Unknown oid: %s\n", p1);
> > -				continue;
> > -			}
> > -
> > -			/* lookup entry in oidmap */
> > -			entry =3D oidmap_get(&map, &oid);
> > -
> > -			/* print result */
> > -			puts(entry ? entry->name : "NULL");
> > -
> > -		} else if (!strcmp("remove", cmd) && p1) {
> > -
> > -			if (repo_get_oid(the_repository, p1, &oid)) {
> > -				printf("Unknown oid: %s\n", p1);
> > -				continue;
> > -			}
> > -
> > -			/* remove entry from oidmap */
> > -			entry =3D oidmap_remove(&map, &oid);
> > -
> > -			/* print result and free entry*/
> > -			puts(entry ? entry->name : "NULL");
> > -			free(entry);
> > -
> > -		} else if (!strcmp("iterate", cmd)) {
> > -
> > -			struct oidmap_iter iter;
> > -			oidmap_iter_init(&map, &iter);
> > -			while ((entry =3D oidmap_iter_next(&iter)))
> > -				printf("%s %s\n", oid_to_hex(&entry->entry.oid), entry->name);
> > -
> > -		} else {
> > -
> > -			printf("Unknown command %s\n", cmd);
> > -
> > -		}
> > -	}
> > -
> > -	string_list_clear(&parts, 0);
> > -	strbuf_release(&line);
> > -	oidmap_free(&map, 1);
> > -	return 0;
> > -}
> > diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> > index 253324a06b..5f013d8b2b 100644
> > --- a/t/helper/test-tool.c
> > +++ b/t/helper/test-tool.c
> > @@ -45,7 +45,6 @@ static struct test_cmd cmds[] =3D {
> >  	{ "mergesort", cmd__mergesort },
> >  	{ "mktemp", cmd__mktemp },
> >  	{ "oid-array", cmd__oid_array },
> > -	{ "oidmap", cmd__oidmap },
> >  	{ "online-cpus", cmd__online_cpus },
> >  	{ "pack-mtimes", cmd__pack_mtimes },
> >  	{ "parse-options", cmd__parse_options },
> > diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> > index 460dd7d260..c7d3e43694 100644
> > --- a/t/helper/test-tool.h
> > +++ b/t/helper/test-tool.h
> > @@ -38,7 +38,6 @@ int cmd__lazy_init_name_hash(int argc, const char **a=
rgv);
> >  int cmd__match_trees(int argc, const char **argv);
> >  int cmd__mergesort(int argc, const char **argv);
> >  int cmd__mktemp(int argc, const char **argv);
> > -int cmd__oidmap(int argc, const char **argv);
> >  int cmd__online_cpus(int argc, const char **argv);
> >  int cmd__pack_mtimes(int argc, const char **argv);
> >  int cmd__parse_options(int argc, const char **argv);
> > diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
> > deleted file mode 100755
> > index 0faef1f4f1..0000000000
> > --- a/t/t0016-oidmap.sh
> > +++ /dev/null
> > @@ -1,112 +0,0 @@
> > -#!/bin/sh
> > -
> > -test_description=3D'test oidmap'
> > -
> > -TEST_PASSES_SANITIZE_LEAK=3Dtrue
> > -. ./test-lib.sh
> > -
> > -# This purposefully is very similar to t0011-hashmap.sh
> > -
> > -test_oidmap () {
> > -	echo "$1" | test-tool oidmap $3 >actual &&
> > -	echo "$2" >expect &&
> > -	test_cmp expect actual
> > -}
> > -
> > -
> > -test_expect_success 'setup' '
> > -
> > -	test_commit one &&
> > -	test_commit two &&
> > -	test_commit three &&
> > -	test_commit four
> > -
> > -'
> > -
> > -test_expect_success 'put' '
> > -
> > -test_oidmap "put one 1
> > -put two 2
> > -put invalidOid 4
> > -put three 3" "NULL
> > -NULL
> > -Unknown oid: invalidOid
> > -NULL"
> > -
> > -'
> > -
> > -test_expect_success 'replace' '
> > -
> > -test_oidmap "put one 1
> > -put two 2
> > -put three 3
> > -put invalidOid 4
> > -put two deux
> > -put one un" "NULL
> > -NULL
> > -NULL
> > -Unknown oid: invalidOid
> > -2
> > -1"
> > -
> > -'
> > -
> > -test_expect_success 'get' '
> > -
> > -test_oidmap "put one 1
> > -put two 2
> > -put three 3
> > -get two
> > -get four
> > -get invalidOid
> > -get one" "NULL
> > -NULL
> > -NULL
> > -2
> > -NULL
> > -Unknown oid: invalidOid
> > -1"
> > -
> > -'
> > -
> > -test_expect_success 'remove' '
> > -
> > -test_oidmap "put one 1
> > -put two 2
> > -put three 3
> > -remove one
> > -remove two
> > -remove invalidOid
> > -remove four" "NULL
> > -NULL
> > -NULL
> > -1
> > -2
> > -Unknown oid: invalidOid
> > -NULL"
> > -
> > -'
> > -
> > -test_expect_success 'iterate' '
> > -	test-tool oidmap >actual.raw <<-\EOF &&
> > -	put one 1
> > -	put two 2
> > -	put three 3
> > -	iterate
> > -	EOF
> > -
> > -	# sort "expect" too so we do not rely on the order of particular oids
> > -	sort >expect <<-EOF &&
> > -	NULL
> > -	NULL
> > -	NULL
> > -	$(git rev-parse one) 1
> > -	$(git rev-parse two) 2
> > -	$(git rev-parse three) 3
> > -	EOF
> > -
> > -	sort <actual.raw >actual &&
> > -	test_cmp expect actual
> > -'
> > -
> > -test_done
> > diff --git a/t/unit-tests/t-oidmap.c b/t/unit-tests/t-oidmap.c
> > new file mode 100644
> > index 0000000000..9b98a3ed09
> > --- /dev/null
> > +++ b/t/unit-tests/t-oidmap.c
> > @@ -0,0 +1,165 @@
> > +#include "test-lib.h"
> > +#include "lib-oid.h"
> > +#include "oidmap.h"
> > +#include "hash.h"
> > +#include "hex.h"
> > +
> > +/*
> > + * elements we will put in oidmap structs are made of a key: the entry=
.oid
> > + * field, which is of type struct object_id, and a value: the name fie=
ld (could
> > + * be a refname for example)
> > + */
> > +struct test_entry {
> > +	struct oidmap_entry entry;
> > +	char name[FLEX_ARRAY];
> > +};
> > +
> > +static const char *key_val[][2] =3D { { "11", "one" },
> > +				    { "22", "two" },
> > +				    { "33", "three" } };
> > +
> > +static int put_and_check_null(struct oidmap *map, const char *hex,
> > +			      const char *entry_name)
> > +{
> > +	struct test_entry *entry;
> > +
> > +	FLEX_ALLOC_STR(entry, name, entry_name);
> > +	if (get_oid_arbitrary_hex(hex, &entry->entry.oid))
> > +		return -1;
> > +	if (!check(oidmap_put(map, entry) =3D=3D NULL))
> > +		return -1;
> > +	return 0;
> > +}
> > +
> > +static void setup(void (*f)(struct oidmap *map))
> > +{
> > +	struct oidmap map =3D OIDMAP_INIT;
> > +	int ret =3D 0;
> > +
> > +	for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++)
> > +		if ((ret =3D put_and_check_null(&map, key_val[i][0],
> > +					      key_val[i][1])))
> > +			break;
> > +
> > +	if (!ret)
> > +		f(&map);
> > +	oidmap_free(&map, 1);
> > +}
> > +
> > +static void t_replace(struct oidmap *map)
> > +{
> > +	struct test_entry *entry, *prev;
> > +
> > +	FLEX_ALLOC_STR(entry, name, "un");
> > +	if (get_oid_arbitrary_hex("11", &entry->entry.oid))
> > +		return;
> > +	prev =3D oidmap_put(map, entry);
> > +	if (!check(prev !=3D NULL))
> > +		return;
> > +	check_str(prev->name, "one");
> > +	free(prev);
> > +
> > +	FLEX_ALLOC_STR(entry, name, "deux");
> > +	if (get_oid_arbitrary_hex("22", &entry->entry.oid))
> > +		return;
> > +	prev =3D oidmap_put(map, entry);
> > +	if (!check(prev !=3D NULL))
> > +		return;
> > +	check_str(prev->name, "two");
> > +	free(prev);
> > +}
> > +
> > +static void t_get(struct oidmap *map)
> > +{
> > +	struct test_entry *entry;
> > +	struct object_id oid;
> > +
> > +	if (get_oid_arbitrary_hex("22", &oid))
> > +		return;
> > +	entry =3D oidmap_get(map, &oid);
> > +	if (!check(entry !=3D NULL))
> > +		return;
> > +	check_str(entry->name, "two");
> > +
> > +	if (get_oid_arbitrary_hex("44", &oid))
> > +		return;
> > +	check(oidmap_get(map, &oid) =3D=3D NULL);
> > +
> > +	if (get_oid_arbitrary_hex("11", &oid))
> > +		return;
> > +	entry =3D oidmap_get(map, &oid);
> > +	if (!check(entry !=3D NULL))
> > +		return;
> > +	check_str(entry->name, "one");
> > +}
> > +
> > +static void t_remove(struct oidmap *map)
> > +{
> > +	struct test_entry *entry;
> > +	struct object_id oid;
> > +
> > +	if (get_oid_arbitrary_hex("11", &oid))
> > +		return;
> > +	entry =3D oidmap_remove(map, &oid);
> > +	if (!check(entry !=3D NULL))
> > +		return;
> > +	check_str(entry->name, "one");
> > +	check(oidmap_get(map, &oid) =3D=3D NULL);
> > +	free(entry);
> > +
> > +	if (get_oid_arbitrary_hex("22", &oid))
> > +		return;
> > +	entry =3D oidmap_remove(map, &oid);
> > +	if (!check(entry !=3D NULL))
> > +		return;
> > +	check_str(entry->name, "two");
> > +	check(oidmap_get(map, &oid) =3D=3D NULL);
> > +	free(entry);
> > +
> > +	if (get_oid_arbitrary_hex("44", &oid))
> > +		return;
> > +	check(oidmap_remove(map, &oid) =3D=3D NULL);
> > +}
> > +
> > +static int key_val_contains(struct test_entry *entry)
> > +{
> > +	/* the test is small enough to be able to bear O(n) */
> > +	for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> > +		if (!strcmp(key_val[i][1], entry->name)) {
> > +			struct object_id oid;
> > +			if (get_oid_arbitrary_hex(key_val[i][0], &oid))
> > +				return -1;
> > +			if (oideq(&entry->entry.oid, &oid))
> > +				return 0;
> > +		}
> > +	}
> > +	return 1;
> > +}
> > +
> > +static void t_iterate(struct oidmap *map)
> > +{
> > +	struct oidmap_iter iter;
> > +	struct test_entry *entry;
> > +	int ret;
> > +
> > +	oidmap_iter_init(map, &iter);
> > +	while ((entry =3D oidmap_iter_next(&iter))) {
> > +		if (!check_int((ret =3D key_val_contains(entry)), =3D=3D, 0)) {
> > +			if (ret =3D=3D -1)
> > +				return;
> > +			test_msg("obtained entry was not given in the input\n"
> > +				 "  name: %s\n   oid: %s\n",
> > +				 entry->name, oid_to_hex(&entry->entry.oid));
> > +		}
> > +	}
> > +	check_int(hashmap_get_size(&map->map), =3D=3D, ARRAY_SIZE(key_val));
> > +}
> > +
> > +int cmd_main(int argc UNUSED, const char **argv UNUSED)
> > +{
> > +	TEST(setup(t_replace), "replace works");
> > +	TEST(setup(t_get), "get works");
> > +	TEST(setup(t_remove), "remove works");
> > +	TEST(setup(t_iterate), "iterate works");
> > +	return test_done();
> > +}
> > --=20
> > 2.45.2
> >=20
> >=20

