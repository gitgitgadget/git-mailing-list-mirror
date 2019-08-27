Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1756F1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 12:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbfH0MOl (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 08:14:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:34299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729660AbfH0MOj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 08:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566908062;
        bh=41F8m8yAK+MlUJ9yV9Dsi4GQk+pUgMYgG0KpzQ+kPNc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Y+mUD2Purhu0+tN2Hxj4gw37jA/ViFSoTxoSgLLkKtUV1P5jV5//WhYBB04ueXOjb
         TBZ4UjfWqyGEdyy3u30lJJOTo5bvKRIRJyFIxqUHdnUqtj3plYlPkYvVbVg3n7gUyG
         wA6k5a/eed3T2baBKs10lB8TcbDFBX7l6/uZCWfQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.149]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwwdl-1iREog3k9D-00yPDY; Tue, 27
 Aug 2019 14:14:22 +0200
Date:   Tue, 27 Aug 2019 14:14:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Subject: Re: [PATCH v3 07/11] Add a function to determine unique prefixes
 for a list of strings
In-Reply-To: <20190824123811.GL20404@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1908271342140.46@tvgsbejvaqbjf.bet>
References: <pull.170.v2.git.gitgitgadget@gmail.com> <pull.170.v3.git.gitgitgadget@gmail.com> <3000d7d08dfb64511b4ebf9d05617897dd7252f7.1563289115.git.gitgitgadget@gmail.com> <20190824123811.GL20404@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-879073916-1566908064=:46"
X-Provags-ID: V03:K1:Erq+zRAGvDzr+dosZsdvKI1oV5Tv2GPUmqoS8NceUkHyQFl+2Gv
 tz88M14rrHVFn/RpdPRyqaYYggsXrHhHesmxbQ+cg/4J0pn6dovFeNfseagVOJGN79iIWm7
 g9JtMYs610nuperKaFjz0pMlUYakrl7QO687I31kSYQv6wmNuTXh2zFEoOCXG3ic60Kjj2n
 aS8cgqhKe80sYxpCbT0lA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ONrErvu9UwA=:K5R/H3KfftiWk9spHYvQra
 PrqxJjj9+sVB59GmAKJwxnSvk1LNQhpZL5jJ2e1PMfQKrE6DqCJRtRPmXxzUWF/Am8+6FC5QH
 dYOogcROXAG85pmfa1Ax3/h7Hp9GDdTECxKQsCbTG350M3zjpQK3ublBXLHa0n/Mbel62Ox11
 vfcKWundqrBnFedTk/DpPyZ/onLQP5J232mzEDUgkybfK98QMabw0txD9N/qbhMAK60JWgxSa
 cGgeN+UiYdYgdq4MQKIAnObOxLsvM4TW4yk+x3B6fXAb4AoOgBGp0Enh+U75iqy3j+BynB/6P
 W83ykoP0cq1/H0oTtlVVUbbKHdoq5hYQ0uanBbqbuHn1M4qT0pUS3POyCr1eiZE42O9KHfgQh
 L+laL1TOxcmnk+TC98g9zmxHQ/mTPbL3C78QBPJrgU7TT85OgJEw5oJYxZewilhxR98no6H+z
 ob2t+20PqOO27OKSp9wLkFVnGDwDO+vv2X6ezeZCPgDVyizGagaiakATlI4nZB/G6J76DuspI
 cyZUUe6wHexb1JAX7h4Vt2SRC6US20N+h7JmQMeMiyqnDLi/hfKVCyecGM5oJnu3ful8qbydh
 clNlsToGj5RbO61rIe49kCI5V8l7chzua0wigriLwjMVm90rT6cEu7KICO1SxGDxwMkytL3P7
 tPPoAqbaQvJT3LiIdhpakdIqhnBXf20jzDi8jJAKMcTrOhBTMJq2ivDm8bFro+6jwmn1t0ITq
 2OqtvxNxqmJHv296VDkljnG8FVyi+9Wkm8rhhicxzj4jsfGq3nMiCEF0sQ8EnNjaQhy8MDalF
 gHg+7Mb6YKfEalMg3wFxaqnxsYhhuUFWPnVWRJqVfyOLDrveuXJcnqNpIZiBd0wE+k5UdwNYX
 s3E3NZmf8Lt6aT7oMEWCL6IddTb1QkHjMAMuIVRyXaOg/Ag3TF4YeiZsumCQETjxyUAghUl8O
 nQ5ZtWK7FqTRK6Hiy54WuPp/joh8jdUQcW4oGUXG8D10nalvw4DM7AlPycvWh1Z9WJr7PmpLC
 e1MyGjk0KoaLObERvuXPjwV+4B2dVfU/F4I9zPJvMn/xXiQaO/ZDCknL0WufBvW1Subp2N9Hp
 fJFWGB8PnEsnJrDvq/YvbkXad782Ti8WwVI0i9A8L0tIpHDLHNV/6h1PXWxzWO5qvPZNhRffZ
 u/BrQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-879073916-1566908064=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Sat, 24 Aug 2019, SZEDER G=C3=A1bor wrote:

> On Tue, Jul 16, 2019 at 07:58:42AM -0700, Slavica Djukic via GitGitGadge=
t wrote:
> > In the `git add -i` command, we show unique prefixes of the commands a=
nd
> > files, to give an indication what prefix would select them.
> >
> > Naturally, the C implementation looks a lot different than the Perl
> > implementation: in Perl, a trie is much easier implemented, while we
> > already have a pretty neat hashmap implementation in C that we use for
> > the purpose of storing (not necessarily unique) prefixes.
> >
> > The idea: for each item that we add, we generate prefixes starting wit=
h
> > the first letter, then the first two letters, then three, etc, until w=
e
> > find a prefix that is unique (or until the prefix length would be
> > longer than we want). If we encounter a previously-unique prefix on th=
e
> > way, we adjust that item's prefix to make it unique again (or we mark =
it
> > as having no unique prefix if we failed to find one). These partial
> > prefixes are stored in a hash map (for quick lookup times).
> >
> > To make sure that this function works as expected, we add a test using=
 a
> > special-purpose test helper that was added for that purpose.
> >
> > Note: We expect the list of prefix items to be passed in as a list of
> > pointers rather than as regular list to avoid having to copy informati=
on
> > (the actual items will most likely contain more information than just
> > the name and the length of the unique prefix, but passing in `struct
> > prefix_item *` would not allow for that).
>
> > diff --git a/prefix-map.c b/prefix-map.c
> > new file mode 100644
> > index 0000000000..747ddb4ebc
> > --- /dev/null
> > +++ b/prefix-map.c
> > @@ -0,0 +1,109 @@
> > +#include "cache.h"
> > +#include "prefix-map.h"
> > +
> > +static int map_cmp(const void *unused_cmp_data,
> > +		   const void *entry,
> > +		   const void *entry_or_key,
> > +		   const void *unused_keydata)
> > +{
> > +	const struct prefix_map_entry *a =3D entry;
> > +	const struct prefix_map_entry *b =3D entry_or_key;
> > +
> > +	return a->prefix_length !=3D b->prefix_length ||
> > +		strncmp(a->name, b->name, a->prefix_length);
> > +}
> > +
> > +static void add_prefix_entry(struct hashmap *map, const char *name,
> > +			     size_t prefix_length, struct prefix_item *item)
> > +{
> > +	struct prefix_map_entry *result =3D xmalloc(sizeof(*result));
> > +	result->name =3D name;
> > +	result->prefix_length =3D prefix_length;
> > +	result->item =3D item;
> > +	hashmap_entry_init(result, memhash(name, prefix_length));
> > +	hashmap_add(map, result);
> > +}
> > +
> > +static void init_prefix_map(struct prefix_map *prefix_map,
> > +			    int min_prefix_length, int max_prefix_length)
> > +{
> > +	hashmap_init(&prefix_map->map, map_cmp, NULL, 0);
> > +	prefix_map->min_length =3D min_prefix_length;
> > +	prefix_map->max_length =3D max_prefix_length;
> > +}
> > +
> > +static void add_prefix_item(struct prefix_map *prefix_map,
> > +			    struct prefix_item *item)
> > +{
> > +	struct prefix_map_entry e =3D { { NULL } }, *e2;
> > +	int j;
> > +
> > +	e.item =3D item;
> > +	e.name =3D item->name;
> > +
> > +	for (j =3D prefix_map->min_length;
> > +	     j <=3D prefix_map->max_length && e.name[j]; j++) {
> > +		/* Avoid breaking UTF-8 multi-byte sequences */
> > +		if (!isascii(e.name[j]))
> > +			break;
> > +
> > +		e.prefix_length =3D j;
> > +		hashmap_entry_init(&e, memhash(e.name, j));
> > +		e2 =3D hashmap_get(&prefix_map->map, &e, NULL);
> > +		if (!e2) {
> > +			/* prefix is unique at this stage */
> > +			item->prefix_length =3D j;
> > +			add_prefix_entry(&prefix_map->map, e.name, j, item);
> > +			break;
> > +		}
> > +
> > +		if (!e2->item)
> > +			continue; /* non-unique prefix */
> > +
> > +		if (j !=3D e2->item->prefix_length || memcmp(e.name, e2->name, j))
> > +			BUG("unexpected prefix length: %d !=3D %d (%s !=3D %s)",
> > +			    j, (int)e2->item->prefix_length, e.name, e2->name);
> > +
> > +		/* skip common prefix */
> > +		for (; j < prefix_map->max_length && e.name[j]; j++) {
> > +			if (e.item->name[j] !=3D e2->item->name[j])
> > +				break;
> > +			add_prefix_entry(&prefix_map->map, e.name, j + 1,
> > +					 NULL);
> > +		}
> > +
> > +		/* e2 no longer refers to a unique prefix */
> > +		if (j < prefix_map->max_length && e2->name[j]) {
> > +			/* found a new unique prefix for e2's item */
> > +			e2->item->prefix_length =3D j + 1;
> > +			add_prefix_entry(&prefix_map->map, e2->name, j + 1,
> > +					 e2->item);
> > +		}
> > +		else
> > +			e2->item->prefix_length =3D 0;
> > +		e2->item =3D NULL;
> > +
> > +		if (j < prefix_map->max_length && e.name[j]) {
> > +			/* found a unique prefix for the item */
> > +			e.item->prefix_length =3D j + 1;
> > +			add_prefix_entry(&prefix_map->map, e.name, j + 1,
> > +					 e.item);
> > +		} else
> > +			/* item has no (short enough) unique prefix */
> > +			e.item->prefix_length =3D 0;
> > +
> > +		break;
> > +	}
> > +}
> > +
> > +void find_unique_prefixes(struct prefix_item **list, size_t nr,
> > +			  int min_length, int max_length)
> > +{
> > +	int i;
> > +	struct prefix_map prefix_map;
> > +
> > +	init_prefix_map(&prefix_map, min_length, max_length);
> > +	for (i =3D 0; i < nr; i++)
> > +		add_prefix_item(&prefix_map, list[i]);
> > +	hashmap_free(&prefix_map.map, 1);
> > +}
>
> Between the commit message, the in-code comment, the names of the new
> files, and implementation I was left somewhat confused about what this
> is about and how it works.  TBH, I didn't even try to understand how
> all the above works, in particular the add_prefix_item() function.

Let me try to explain it here, and maybe you can help me by suggesting
an improved commit message and/or code comments?

The problem is this: given a set of items with labels (e.g. file names),
find, for each item, the unique prefix that identifies it. Example:
given the files `hello.txt`, `heaven.txt` and `hell.txt`, the items'
unique prefixes would be `hello`, `hea` and `hell.`, respectively.

In `git add -i`, we actually only want to allow alphanumerical prefixes,
and we also want at least one, and at most three characters, so only the
second item would have an admissible unique prefix: `hea`.

> However, I think it would be much-much simpler to first sort (a copy
> of?) the array of prefix item pointers based on their 'name' field,
> and then look for a unique prefix in each neighboring pair.  Perhaps
> it would even be faster, because it doesn't have to allocate a bunch
> of hashmap items, though I don't think that it matters much in
> practice (i.e. I expect the number of items to be fairly small;
> presumably nobody will run interactive add after a mass refactoring
> modifying thousands of files).

The time complexity of the sorted list would be O(n*log(n)), while the
hashmap-based complexity would be an amortized O(n).

And yes, you would not _want_ to run interactive add after a mass
refactoring. But it happens. It happens to me more times than I care to
admit. And you know what? I really appreciate that even the Perl version
is relatively snappy in those circumstances.

> > diff --git a/prefix-map.h b/prefix-map.h
> > new file mode 100644
> > index 0000000000..ce3b8a4a32
> > --- /dev/null
> > +++ b/prefix-map.h
> > @@ -0,0 +1,40 @@
> > +#ifndef PREFIX_MAP_H
> > +#define PREFIX_MAP_H
> >
> > +#include "hashmap.h"
> > +
> > +struct prefix_item {
> > +	const char *name;
> > +	size_t prefix_length;
> > +};
>
> This struct is part of find_unique_prefixes()'s signature, good.
>
> > +struct prefix_map_entry {
> > +	struct hashmap_entry e;
> > +	const char *name;
> > +	size_t prefix_length;
> > +	/* if item is NULL, the prefix is not unique */
> > +	struct prefix_item *item;
> > +};
> > +
> > +struct prefix_map {
> > +	struct hashmap map;
> > +	int min_length, max_length;
> > +};
>
> However, neither of these two structs nor the hashmap appear in the
> function's signature, but are all implementation details.  Therefore,
> they should not be defined and included here in the header but in the
> .c source file.  (But as mentioned above, I think this could be
> implemented much simpler without these data structures.)

Right you are!

> Furthermore, this is not a map.
> A map, in general, is a container of key-value pairs that allows
> efficient insertion, removal and lookup.  This so-called prefix_map
> does none of that, so it should not be called a map.

What would you call it instead?

(I went with "map" because the underlying data structure is a "hash
map", I know, not the best argument, but I failed to find a better
name...)

I also have to admit that I thought that I could fix the design where
`git-add--interactive.perl` creates this trie, but then still performs a
linear search when searching by prefix. That seems not to be possible,
though, as the unique prefixes are limited to certain character ranges,
while the lookup-by-prefix is not limited in that way.

> > +/*
> > + * Find unique prefixes in a given list of strings.
>
> ... and stores the length of the unique prefixes in the
> 'prefix_length' field of the elements of the given array.

Good idea. I changed it to also explain what is meant by "unique
prefix":

 * Given a list of names, find unique prefixes (i.e. the first <n> charact=
ers
 * that uniquely identify the names) and store the lengths of the unique
 * prefixes in the 'prefix_length' field of the elements of the given arra=
y..

> > + *
> > + * Typically, the `struct prefix_item` information will be but a fiel=
d in the
>
> s/but //, perhaps?

Sure. I am relatively certain that it is correct grammar, but it is
probably a good idea to remove it.

> > + * actual item struct; For this reason, the `list` parameter is speci=
fied as a
> > + * list of pointers to the items.
> > + *
> > + * The `min_length`/`max_length` parameters define what length the un=
ique
> > + * prefixes should have.
> > + *
> > + * If no unique prefix could be found for a given item, its `prefix_l=
ength`
> > + * will be set to 0.
> > + */
> > +void find_unique_prefixes(struct prefix_item **list, size_t nr,
>
> The first argument is not a list but an array.

Indeed.

> > +			  int min_length, int max_length);
>
> size_t, perhaps?  These are closely related to
> 'prefix_item.prefix_length', which is already (rightfully) size_t.

True.

> > +#endif
> > diff --git a/t/helper/test-prefix-map.c b/t/helper/test-prefix-map.c
> > new file mode 100644
> > index 0000000000..3f1c90eaf0
> > --- /dev/null
> > +++ b/t/helper/test-prefix-map.c
> > @@ -0,0 +1,58 @@
> > +#include "test-tool.h"
> > +#include "cache.h"
> > +#include "prefix-map.h"
> > +
> > +static size_t test_count, failed_count;
> > +
> > +static void check(int succeeded, const char *file, size_t line_no,
> > +		  const char *fmt, ...)
> > +{
> > +	va_list ap;
> > +
> > +	test_count++;
> > +	if (succeeded)
> > +		return;
> > +
> > +	va_start(ap, fmt);
> > +	fprintf(stderr, "%s:%d: ", file, (int)line_no);
> > +	vfprintf(stderr, fmt, ap);
> > +	fputc('\n', stderr);
> > +	va_end(ap);
> > +
> > +	failed_count++;
> > +}
> > +
> > +#define EXPECT_SIZE_T_EQUALS(expect, actual, hint) \
> > +	check(expect =3D=3D actual, __FILE__, __LINE__, \
> > +	      "size_t's do not match: %" \
> > +	      PRIdMAX " !=3D %" PRIdMAX " (%s) (%s)", \
> > +	      (intmax_t)expect, (intmax_t)actual, #actual, hint)
> > +
> > +int cmd__prefix_map(int argc, const char **argv)
> > +{
> > +#define NR 5
> > +	struct prefix_item items[NR] =3D {
>
> You don't have to tell the compiler how many elements this array will
> contain, it will figure that out on its own.
>
> > +		{ "unique" },
> > +		{ "hell" },
> > +		{ "hello" },
> > +		{ "wok" },
> > +		{ "world" },
> > +	};
> > +	struct prefix_item *list[NR] =3D {
>
> Likewise.

That is correct.

What the compiler _cannot_ figure out, on its own, however, is that
`items` and `list` _need_ to contain the same number of items.

Hence the need for `NR`.

> > +		items, items + 1, items + 2, items + 3, items + 4
> > +	};
> > +
> > +	find_unique_prefixes(list, NR, 1, 3);
>
> This could be find_unique_prefixes(list, ARRAY_SIZE(list), 1, 3), and
> then there is no need for that NR macro anymore.
>
> > +
> > +#define EXPECT_PREFIX_LENGTH_EQUALS(expect, index) \
> > +	EXPECT_SIZE_T_EQUALS(expect, list[index]->prefix_length, \
> > +			     list[index]->name)
> > +
> > +	EXPECT_PREFIX_LENGTH_EQUALS(1, 0);
> > +	EXPECT_PREFIX_LENGTH_EQUALS(0, 1);
> > +	EXPECT_PREFIX_LENGTH_EQUALS(0, 2);
> > +	EXPECT_PREFIX_LENGTH_EQUALS(3, 3);
> > +	EXPECT_PREFIX_LENGTH_EQUALS(3, 4);
> > +
> > +	return !!failed_count;
> > +}

Thank you for your review!
Dscho

--8323328-879073916-1566908064=:46--
