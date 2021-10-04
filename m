Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677A1C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 10:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471C361372
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 10:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhJDK7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 06:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbhJDK7m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 06:59:42 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9D8C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 03:57:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x7so61776844edd.6
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3/GilZnk6Z+bhIae4lkdom6f8cv8lFNygAuGbPsMmTE=;
        b=aew8x0boZCpn4wZ+piq4wpga5aooNs39I9PxL1f6eRK6R4Rpsn7PfDlry3Q55wmVHb
         us39FT/X0UaLR1jrB9JWr0EuUWkR+on3+r0phaZ2Ij8kRdMw/iwdUJ4m9rwLQqmtjxxr
         SHfvq6R8OuCWNc/1fZhesWKbApHNE71GTguyitT6tQjNUDsIYddA2tdezjWQcsGJf/sd
         T4twJqo9RZ6VCsqyfdqd3OCwSpjP7UCAHlWzC4OHWj5R8C561ZIZef9DYm+fyi5A9id+
         pufv3PlfNqSW439LrQZxXg+jsgbbg81n7NOQdbN8xn3AEuqerCAriFEI0eOlaVfeyPr5
         hpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3/GilZnk6Z+bhIae4lkdom6f8cv8lFNygAuGbPsMmTE=;
        b=wmQzUssjPlSFci04AtskA1wgdRLvY6CycsW4xIzitzz5m+V1LhmuSNMdaFO7NFdFBr
         OoWkwnI1wSpq7p2bRUnNulk9Cn8A8MPBhiyKbitKdJgm+ZJnbJFptYUT7d7MScvsjv9p
         nQSqgLFszOA512coSCh2n2dI8bVOZbHp40PcZ81sCTaXb0mRYWmQPs0avEnoR0txAp0S
         tDN+3ycNtiZQLR6TWVcbbCDLhckk2xsAbex+WKvw52vDsoSAOKFSQcRbBVEBoeLWkJoN
         Odb79K7+8yhOcGG2OosHT0oRjSjn+Tg8m0p+Qz8AWbSWMzquQAzv/Exb9VgGua2ydr+3
         4rDg==
X-Gm-Message-State: AOAM5312D3gAgkxdhvM1k6urt3HwwuPGkzc+hAq3A5KKNXyst5Ad1t0c
        hDNuSPvpKpA7ubuYBXxdQ5M=
X-Google-Smtp-Source: ABdhPJxOpIUF+AHO7wd5d4oFcTjM1kmXdZSpyAVsBX0vYX/6MnWtI2PvB7xjhzeD3B0S0eAvk++zXw==
X-Received: by 2002:a05:6402:2689:: with SMTP id w9mr17250374edd.188.1633345071371;
        Mon, 04 Oct 2021 03:57:51 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q14sm6290100ejc.93.2021.10.04.03.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 03:57:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Andrzej Hunt <andrzej@ahunt.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] hash: reduce size of algo member of object ID
Date:   Mon, 04 Oct 2021 10:47:43 +0200
References: <8da7bad2-b5a8-5aef-284b-dfa4e78556a9@web.de>
 <YVq3rqwz82RgpUfl@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YVq3rqwz82RgpUfl@coredump.intra.peff.net>
Message-ID: <87k0itnjkh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Jeff King wrote:

> On Sun, Oct 03, 2021 at 07:51:40AM +0200, Ren=C3=A9 Scharfe wrote:
>
>> cf0983213c (hash: add an algo member to struct object_id, 2021-04-26)
>> introduced the algo member as an int.  This increased the size of struct
>> object_id by 4 bytes (12.5%) and imposed a 4-byte alignment.  Currently
>> we only need to stored the values 0, 1 and 2 in it.  Let's use an
>> unsigned char instead to reduce the size overhead and lift the alignment
>> requirement.
>>=20
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> Not sure how to measure the performance impact of this change.  The perf
>> tests mentioned by cf0983213c don't show much of a difference with
>> GIT_PERF_REPEAT_COUNT=3D10 for me:
>
> Not surprising. If going from nothing to an int didn't have an impact on
> those tests, then going from an int to char isn't likely to, either.
>
>> 0001.1: rev-list --all                           0.11(0.08+0.02)     0.1=
1(0.08+0.02) +0.0%
>> 0001.2: rev-list --all --objects                 3.04(2.98+0.05)     3.0=
4(2.98+0.05) +0.0%
>> 0001.3: rev-list --parents                       0.05(0.04+0.01)     0.0=
5(0.03+0.01) +0.0%
>> 0001.5: rev-list -- dummy                        0.21(0.20+0.01)     0.2=
1(0.19+0.01) +0.0%
>> 0001.6: rev-list --parents -- dummy              0.22(0.20+0.01)     0.2=
2(0.20+0.01) +0.0%
>> 0001.8: rev-list $commit --not --all             0.06(0.05+0.00)     0.0=
6(0.05+0.00) +0.0%
>> 0001.9: rev-list --objects $commit --not --all   0.06(0.05+0.00)     0.0=
6(0.05+0.00) +0.0%
>
> I do think these probably aren't very good tests. They're going to
> mostly be dealing with actual object structs. Your patch changes the
> size of "struct object_id", but the object structs themselves still need
> 4-byte alignment. And they have a bunch of padding in the first place.
>
> If we instrument "git version --build-options" like this:
>
> diff --git a/help.c b/help.c
> index 3c3bdec213..718e32cadf 100644
> --- a/help.c
> +++ b/help.c
> @@ -11,6 +11,8 @@
>  #include "version.h"
>  #include "refs.h"
>  #include "parse-options.h"
> +#include "blob.h"
> +#include "tag.h"
>=20=20
>  struct category_description {
>  	uint32_t category;
> @@ -663,6 +665,11 @@ void get_version_info(struct strbuf *buf, int show_b=
uild_options)
>  		strbuf_addf(buf, "sizeof-long: %d\n", (int)sizeof(long));
>  		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
>  		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
> +		strbuf_addf(buf, "sizeof-object_id: %d\n", (int)sizeof(struct object_i=
d));
> +		strbuf_addf(buf, "sizeof-commit: %d\n", (int)sizeof(struct commit));
> +		strbuf_addf(buf, "sizeof-blob: %d\n", (int)sizeof(struct blob));
> +		strbuf_addf(buf, "sizeof-tree: %d\n", (int)sizeof(struct tree));
> +		strbuf_addf(buf, "sizeof-tag: %d\n", (int)sizeof(struct tag));
>  		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
>  	}
>  }
>
> then we can see that your patch doesn't the change the size of any of
> the structs at all! Even the original cf0983213c going from nothing to
> an int changed only "struct blob" (it went from 32 to 36 bytes).
>
> A more interesting test is something that stores a bunch of oids. A good
> candidate is "cat-file --batch-all-objects". In the default mode, it
> uses an oid_array to sort the set of objects. In unordered mode, it uses
> an oidset to mark seen ones.
>
> Here are hyperfine results. The three versions are:
>
>   - none: cf0983213c^
>   - int: cf0983213c
>   - char: cf0983213c with the equivalent of your patch on top
>
> All compiled with "gcc -O2", and run in a fully packed clone of
> linux.git.
>
> It looks like adding the "algo" field did make a big difference for the
> oid_array case, but changing it to a char doesn't seem to help at all:
>
>   $ hyperfine -L v none,int,char './git.{v} cat-file --batch-all-objects =
--batch-check=3D"%(objectname)"'
>   Benchmark #1: ./git.none cat-file --batch-all-objects --batch-check=3D"=
%(objectname)"
>     Time (mean =C2=B1 =CF=83):      1.653 s =C2=B1  0.009 s    [User: 1.6=
07 s, System: 0.046 s]
>     Range (min =E2=80=A6 max):    1.640 s =E2=80=A6  1.670 s    10 runs
>=20=20=20=20
>   Benchmark #2: ./git.int cat-file --batch-all-objects --batch-check=3D"%=
(objectname)"
>     Time (mean =C2=B1 =CF=83):      1.067 s =C2=B1  0.012 s    [User: 1.0=
17 s, System: 0.050 s]
>     Range (min =E2=80=A6 max):    1.053 s =E2=80=A6  1.089 s    10 runs
>=20=20=20=20
>   Benchmark #3: ./git.char cat-file --batch-all-objects --batch-check=3D"=
%(objectname)"
>     Time (mean =C2=B1 =CF=83):      1.092 s =C2=B1  0.013 s    [User: 1.0=
46 s, System: 0.046 s]
>     Range (min =E2=80=A6 max):    1.080 s =E2=80=A6  1.116 s    10 runs
>=20=20=20=20
>   Summary
>     './git.int cat-file --batch-all-objects --batch-check=3D"%(objectname=
)"' ran
>       1.02 =C2=B1 0.02 times faster than './git.char cat-file --batch-all=
-objects --batch-check=3D"%(objectname)"'
>       1.55 =C2=B1 0.02 times faster than './git.none cat-file --batch-all=
-objects --batch-check=3D"%(objectname)"'

*Rubs eyes*

Maybe I'm being really stupid here, but doesn't this say the opposite of
your summary? I.e. that adding the "int" field in cf0983213c made it
faster. It was ~1.6s before, now it's ~1.1s? I haven't used "hyperfine"
before, but this output is consistent with that:
=20=20=20=20
    $ hyperfine --warmup 2 -L v 1.6,1.0 'sleep {v}'
    Benchmark #1: sleep 1.6
      Time (mean =C2=B1 =CF=83):      1.604 s =C2=B1  0.000 s    [User: 2.2=
 ms, System: 1.1 ms]
      Range (min =E2=80=A6 max):    1.603 s =E2=80=A6  1.604 s    10 runs
=20=20=20=20=20
    Benchmark #2: sleep 1.0
      Time (mean =C2=B1 =CF=83):      1.004 s =C2=B1  0.000 s    [User: 2.5=
 ms, System: 0.9 ms]
      Range (min =E2=80=A6 max):    1.004 s =E2=80=A6  1.004 s    10 runs
=20=20=20=20=20
    Summary
      'sleep 1.0' ran
        1.60 =C2=B1 0.00 times faster than 'sleep 1.6'

[Goes and reads the downthread
<YVq5XCyLDr0SPBzx@coredump.intra.peff.net> where I see you made the same
discovery, should have probably done that first :)]

Anyway, just for experimenting I played with removing "int algo"
entirely on top of master. Diff on top at the end. That gives the same
sorts of results:
=20=20=20=20
    $ hyperfine --warmup 2 -L v algo-02,algo-03,no-algo-02,no-algo-03 '~/g/=
git/git.{v} cat-file --batch-all-objects --batch-check=3D"%(objectname)"'
    Benchmark #1: ~/g/git/git.algo-02 cat-file --batch-all-objects --batch-=
check=3D"%(objectname)"
      Time (mean =C2=B1 =CF=83):      1.283 s =C2=B1  0.022 s    [User: 1.2=
17 s, System: 0.066 s]
      Range (min =E2=80=A6 max):    1.265 s =E2=80=A6  1.336 s    10 runs
=20=20=20=20
    Benchmark #2: ~/g/git/git.algo-03 cat-file --batch-all-objects --batch-=
check=3D"%(objectname)"
      Time (mean =C2=B1 =CF=83):      1.261 s =C2=B1  0.032 s    [User: 1.1=
95 s, System: 0.066 s]
      Range (min =E2=80=A6 max):    1.240 s =E2=80=A6  1.343 s    10 runs
=20=20=20=20
    Benchmark #3: ~/g/git/git.no-algo-02 cat-file --batch-all-objects --bat=
ch-check=3D"%(objectname)"
      Time (mean =C2=B1 =CF=83):      1.911 s =C2=B1  0.034 s    [User: 1.8=
53 s, System: 0.058 s]
      Range (min =E2=80=A6 max):    1.878 s =E2=80=A6  1.977 s    10 runs
=20=20=20=20
    Benchmark #4: ~/g/git/git.no-algo-03 cat-file --batch-all-objects --bat=
ch-check=3D"%(objectname)"
      Time (mean =C2=B1 =CF=83):      1.880 s =C2=B1  0.011 s    [User: 1.8=
24 s, System: 0.056 s]
      Range (min =E2=80=A6 max):    1.864 s =E2=80=A6  1.905 s    10 runs
=20=20=20=20
    Summary
      '~/g/git/git.algo-03 cat-file --batch-all-objects --batch-check=3D"%(=
objectname)"' ran
        1.02 =C2=B1 0.03 times faster than '~/g/git/git.algo-02 cat-file --=
batch-all-objects --batch-check=3D"%(objectname)"'
        1.49 =C2=B1 0.04 times faster than '~/g/git/git.no-algo-03 cat-file=
 --batch-all-objects --batch-check=3D"%(objectname)"'
        1.52 =C2=B1 0.05 times faster than '~/g/git/git.no-algo-02 cat-file=
 --batch-all-objects --batch-check=3D"%(objectname)"'

Of course I did that thinking it might be worthwhile to provide say a
compile-time option for SHA-1-only deployments of git, but that's when I
went along with your misreading of the hyperfine output, seems it
actually makes it fasterer :)

Aside: I recently started testing git on HP/UX's aCC, which is quite
whiny about things like this:

    "blame.c", line 2677: warning #4232-D: conversion from "struct object *=
" to a more strictly aligned type "struct commit *" may cause misaligned ac=
cess
                found =3D (struct commit *)obj;

Which I initially thought might be changed by something like Ren=C3=A9's
patch, but is (I think) due to the timestamp_t in commit.h, presumably
it's 32bit on HP/UX still? And int is 64 (I haven't actually been able
to fully complie git yet, so...).

 Just an aside, but also wondering how if anything that & other
alignment might have to do with these results on platforms/compilers
that are less whiny about it. Or maybe it's all aligned on x86_64
(again, didn't check).

> I'm actually surprised it had this much of an impact. But I guess this
> benchmark really is mostly just memcpy-ing oids into a big array,
> sorting it, and printing the result. If that array is 12% bigger, we'd
> expect at least a 12% speedup. But adding in non-linear elements like
> growing the array (though I guess that is amortized linear) and sorting
> (which picks up an extra log(n) term) make the difference.
>
> It's _kind of_ silly in a sense, since usually you'd ask for other parts
> of the object, which will make the speed difference relatively smaller.
> But just dumping a bunch of oids is actually not an unreasonable thing
> to do. I suspect it got a lot slower with 32-byte GIT_MAX_RAWSZ, too
> (even when you're using 20-byte sha1), but I don't think there's an easy
> way to get out of that.

[I wrote the below before seeing that you misread the "hyperfine"
output, but most of it applies still]:

Not easy, but it might not be super-duper-hard either, I think it might
be a worthwhile thing to try, and these results seem to back that up.

I had a mostly-working patch for that that I never submitted and just
hacked up one afternoon. I was experimenting with it for something
different: To have Git support a SHA-160 (completely non-standard, the
lowest is SHA-224), i.e. a SHA-256 truncated to SHA-1 size.

The advantage being that for say a system that has various
outside-of-git (e.g. DB columns) hardcoded to SHA-1 size you could
convert the repo to SHA-256, but use SHA-1-sized hashes publicly. Less
secure than SHA-256 obviously, but only proportionally to the reduction
in bits, and would still be less hairy than a SHA-1 derivative.

I didn't think it was worthwhile & threw it away after playing with it,
but anyway...

Once you've got that, which requires disconnecting the hard assumption
in hash.h and friends about hash type =3D=3D hash length, i.e. oid_to_hex()
and friends need to have variants that take 160, 224 etc.

You can also do it the other way around. Say have a format like the
commit-graph reference 80 bit objects, but have the object store stored
in the full 256 bits.

That obviously creates all sorts of hairy edge cases where none exist
today. I.e. if you set the storage hash a SHA-1 repo to be 1/4 the size
that it is now you can't push/pull anything, or if you could we'd need
to piggy-back on the planned on-the-fly SHA-1<->SHA-256 rewriting.

But it might be interesting & useful for these performance
reasons. I.e. it's pretty easy (and I had some throwaway version of this
working with only the "occasional" segfault) to get a copy of "git"
running that say stores all OIDs as 1/4 their size.

As long as you know you've got no collisions you can use that as a quick
side-index. All your problems with interoperability are ones we'll need
to deal with for SHA-1<->SHA-256, although you'll have the extra
potential problem of collisions (which is X% likely depending on your
object numbers & size of truncation you choose).

Diff at end:

diff --git a/builtin/show-index.c b/builtin/show-index.c
index 0e0b9fb95bc..b63a3bf60b9 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -74,7 +74,6 @@ int cmd_show_index(int argc, const char **argv, const cha=
r *prefix)
 		for (i =3D 0; i < nr; i++) {
 			if (fread(entries[i].oid.hash, hashsz, 1, stdin) !=3D 1)
 				die("unable to read sha1 %u/%u", i, nr);
-			entries[i].oid.algo =3D hash_algo_by_ptr(the_hash_algo);
 		}
 		for (i =3D 0; i < nr; i++)
 			if (fread(&entries[i].crc, 4, 1, stdin) !=3D 1)
diff --git a/hash.h b/hash.h
index 9e25c40e9ac..bd1855b65ec 100644
--- a/hash.h
+++ b/hash.h
@@ -115,7 +115,6 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst=
, const git_SHA256_CTX *s
=20
 struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
-	int algo;	/* XXX requires 4-byte alignment */
 };
=20
 /* A suitably aligned type for stack allocations of hash contexts. */
@@ -213,12 +212,7 @@ static inline int hashcmp(const unsigned char *sha1, c=
onst unsigned char *sha2)
=20
 static inline int oidcmp(const struct object_id *oid1, const struct object=
_id *oid2)
 {
-	const struct git_hash_algo *algop;
-	if (!oid1->algo)
-		algop =3D the_hash_algo;
-	else
-		algop =3D &hash_algos[oid1->algo];
-	return hashcmp_algop(oid1->hash, oid2->hash, algop);
+	return hashcmp_algop(oid1->hash, oid2->hash, the_hash_algo);
 }
=20
 static inline int hasheq_algop(const unsigned char *sha1, const unsigned c=
har *sha2, const struct git_hash_algo *algop)
@@ -239,12 +233,7 @@ static inline int hasheq(const unsigned char *sha1, co=
nst unsigned char *sha2)
=20
 static inline int oideq(const struct object_id *oid1, const struct object_=
id *oid2)
 {
-	const struct git_hash_algo *algop;
-	if (!oid1->algo)
-		algop =3D the_hash_algo;
-	else
-		algop =3D &hash_algos[oid1->algo];
-	return hasheq_algop(oid1->hash, oid2->hash, algop);
+	return hasheq_algop(oid1->hash, oid2->hash, the_hash_algo);
 }
=20
 static inline int is_null_oid(const struct object_id *oid)
@@ -260,23 +249,16 @@ static inline void hashcpy(unsigned char *sha_dst, co=
nst unsigned char *sha_src)
 static inline void oidcpy(struct object_id *dst, const struct object_id *s=
rc)
 {
 	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
-	dst->algo =3D src->algo;
 }
=20
 /* Like oidcpy() but zero-pads the unused bytes in dst's hash array. */
 static inline void oidcpy_with_padding(struct object_id *dst,
 				       const struct object_id *src)
 {
-	size_t hashsz;
-
-	if (!src->algo)
-		hashsz =3D the_hash_algo->rawsz;
-	else
-		hashsz =3D hash_algos[src->algo].rawsz;
+	size_t hashsz =3D the_hash_algo->rawsz;
=20
 	memcpy(dst->hash, src->hash, hashsz);
 	memset(dst->hash + hashsz, 0, GIT_MAX_RAWSZ - hashsz);
-	dst->algo =3D src->algo;
 }
=20
 static inline struct object_id *oiddup(const struct object_id *src)
@@ -294,13 +276,11 @@ static inline void hashclr(unsigned char *hash)
 static inline void oidclr(struct object_id *oid)
 {
 	memset(oid->hash, 0, GIT_MAX_RAWSZ);
-	oid->algo =3D hash_algo_by_ptr(the_hash_algo);
 }
=20
 static inline void oidread(struct object_id *oid, const unsigned char *has=
h)
 {
 	memcpy(oid->hash, hash, the_hash_algo->rawsz);
-	oid->algo =3D hash_algo_by_ptr(the_hash_algo);
 }
=20
 static inline int is_empty_blob_sha1(const unsigned char *sha1)
@@ -325,7 +305,7 @@ static inline int is_empty_tree_oid(const struct object=
_id *oid)
=20
 static inline void oid_set_algo(struct object_id *oid, const struct git_ha=
sh_algo *algop)
 {
-	oid->algo =3D hash_algo_by_ptr(algop);
+	return;
 }
=20
 const char *empty_tree_oid_hex(void);
diff --git a/hex.c b/hex.c
index 4f64d346963..6538e415a37 100644
--- a/hex.c
+++ b/hex.c
@@ -143,7 +143,7 @@ char *hash_to_hex_algop_r(char *buffer, const unsigned =
char *hash,
=20
 char *oid_to_hex_r(char *buffer, const struct object_id *oid)
 {
-	return hash_to_hex_algop_r(buffer, oid->hash, &hash_algos[oid->algo]);
+	return hash_to_hex_algop_r(buffer, oid->hash, &hash_algos[GIT_HASH_SHA1]);
 }
=20
 char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_a=
lgo *algop)
@@ -161,5 +161,5 @@ char *hash_to_hex(const unsigned char *hash)
=20
 char *oid_to_hex(const struct object_id *oid)
 {
-	return hash_to_hex_algop(oid->hash, &hash_algos[oid->algo]);
+	return hash_to_hex_algop(oid->hash, &hash_algos[GIT_HASH_SHA1]);
 }
diff --git a/http-push.c b/http-push.c
index 3309aaf004a..3ce453e14a4 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1011,8 +1011,6 @@ static void remote_ls(const char *path, int flags,
 /* extract hex from sharded "xx/x{38}" filename */
 static int get_oid_hex_from_objpath(const char *path, struct object_id *oi=
d)
 {
-	oid->algo =3D hash_algo_by_ptr(the_hash_algo);
-
 	if (strlen(path) !=3D the_hash_algo->hexsz + 1)
 		return -1;
=20
diff --git a/object-file.c b/object-file.c
index be4f94ecf3b..be1385c5e72 100644
--- a/object-file.c
+++ b/object-file.c
@@ -58,27 +58,21 @@
=20
 static const struct object_id empty_tree_oid =3D {
 	.hash =3D EMPTY_TREE_SHA1_BIN_LITERAL,
-	.algo =3D GIT_HASH_SHA1,
 };
 static const struct object_id empty_blob_oid =3D {
 	.hash =3D EMPTY_BLOB_SHA1_BIN_LITERAL,
-	.algo =3D GIT_HASH_SHA1,
 };
 static const struct object_id null_oid_sha1 =3D {
 	.hash =3D {0},
-	.algo =3D GIT_HASH_SHA1,
 };
 static const struct object_id empty_tree_oid_sha256 =3D {
 	.hash =3D EMPTY_TREE_SHA256_BIN_LITERAL,
-	.algo =3D GIT_HASH_SHA256,
 };
 static const struct object_id empty_blob_oid_sha256 =3D {
 	.hash =3D EMPTY_BLOB_SHA256_BIN_LITERAL,
-	.algo =3D GIT_HASH_SHA256,
 };
 static const struct object_id null_oid_sha256 =3D {
 	.hash =3D {0},
-	.algo =3D GIT_HASH_SHA256,
 };
=20
 static void git_hash_sha1_init(git_hash_ctx *ctx)
@@ -105,7 +99,6 @@ static void git_hash_sha1_final_oid(struct object_id *oi=
d, git_hash_ctx *ctx)
 {
 	git_SHA1_Final(oid->hash, &ctx->sha1);
 	memset(oid->hash + GIT_SHA1_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA1_RAWSZ);
-	oid->algo =3D GIT_HASH_SHA1;
 }
=20
=20
@@ -137,7 +130,6 @@ static void git_hash_sha256_final_oid(struct object_id =
*oid, git_hash_ctx *ctx)
 	 * but keep it in case we extend the hash size again.
 	 */
 	memset(oid->hash + GIT_SHA256_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA256_RAWSZ);
-	oid->algo =3D GIT_HASH_SHA256;
 }
=20
 static void git_hash_unknown_init(git_hash_ctx *ctx)
diff --git a/oidtree.c b/oidtree.c
index 0d39389bee2..61f4d9515b5 100644
--- a/oidtree.c
+++ b/oidtree.c
@@ -33,9 +33,6 @@ void oidtree_insert(struct oidtree *ot, const struct obje=
ct_id *oid)
 	struct cb_node *on;
 	struct object_id k;
=20
-	if (!oid->algo)
-		BUG("oidtree_insert requires oid->algo");
-
 	on =3D mem_pool_alloc(&ot->mem_pool, sizeof(*on) + sizeof(*oid));
=20
 	/*
@@ -62,13 +59,6 @@ int oidtree_contains(struct oidtree *ot, const struct ob=
ject_id *oid)
=20
 	oidcpy_with_padding(&k, oid);
=20
-	if (oid->algo =3D=3D GIT_HASH_UNKNOWN)
-		klen -=3D sizeof(oid->algo);
-
-	/* cb_lookup relies on memcmp on the struct, so order matters: */
-	klen +=3D BUILD_ASSERT_OR_ZERO(offsetof(struct object_id, hash) <
-				offsetof(struct object_id, algo));
-
 	return cb_lookup(&ot->tree, (const uint8_t *)&k, klen) ? 1 : 0;
 }
=20
@@ -80,9 +70,6 @@ static enum cb_next iter(struct cb_node *n, void *arg)
 	/* Copy to provide 4-byte alignment needed by struct object_id. */
 	memcpy(&k, n->k, sizeof(k));
=20
-	if (x->algo !=3D GIT_HASH_UNKNOWN && x->algo !=3D k.algo)
-		return CB_CONTINUE;
-
 	if (x->last_nibble_at) {
 		if ((k.hash[*x->last_nibble_at] ^ x->last_byte) & 0xf0)
 			return CB_CONTINUE;
@@ -100,7 +87,6 @@ void oidtree_each(struct oidtree *ot, const struct objec=
t_id *oid,
=20
 	x.fn =3D fn;
 	x.arg =3D arg;
-	x.algo =3D oid->algo;
 	if (oidhexsz & 1) {
 		x.last_byte =3D oid->hash[klen];
 		x.last_nibble_at =3D &klen;
diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
index 180ee28dd93..6e22b422ddc 100644
--- a/t/helper/test-oidtree.c
+++ b/t/helper/test-oidtree.c
@@ -13,7 +13,7 @@ int cmd__oidtree(int argc, const char **argv)
 	struct oidtree ot;
 	struct strbuf line =3D STRBUF_INIT;
 	int nongit_ok;
-	int algo =3D GIT_HASH_UNKNOWN;
+	int algo =3D GIT_HASH_SHA1;
=20
 	oidtree_init(&ot);
 	setup_git_directory_gently(&nongit_ok);
@@ -25,7 +25,6 @@ int cmd__oidtree(int argc, const char **argv)
 		if (skip_prefix(line.buf, "insert ", &arg)) {
 			if (get_oid_hex_any(arg, &oid) =3D=3D GIT_HASH_UNKNOWN)
 				die("insert not a hexadecimal oid: %s", arg);
-			algo =3D oid.algo;
 			oidtree_insert(&ot, &oid);
 		} else if (skip_prefix(line.buf, "contains ", &arg)) {
 			if (get_oid_hex(arg, &oid))
@@ -37,7 +36,6 @@ int cmd__oidtree(int argc, const char **argv)
 			memcpy(buf, arg, strlen(arg));
 			buf[hash_algos[algo].hexsz] =3D '\0';
 			get_oid_hex_any(buf, &oid);
-			oid.algo =3D algo;
 			oidtree_each(&ot, &oid, strlen(arg), print_oid, NULL);
 		} else if (!strcmp(line.buf, "clear")) {
 			oidtree_clear(&ot);
