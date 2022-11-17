Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A33C433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 17:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240471AbiKQRHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 12:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbiKQRHG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 12:07:06 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D176EB52
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 09:07:04 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id i10so6660134ejg.6
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 09:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ghm21256THfbOn3KVvuWEi/DwX/iv9k5P345vocVON4=;
        b=YIIs4hsyU8idO8G6ywNlr0kLt1hdXOlOgdJSRIaPkpQJ/dGqJ1vNkaySCph+JkO4ro
         MY4ingj8CuRU+HFX9DLt4qMqASGPJwU0e6kBOb/hyK4S+xgcp671HTUxATx+M/4P/y2a
         +6SBSZReRSg2MzwKTFOWPCmZk2mYBBbZw3S3uZckUkqFvTP5Z6fByXtH9/xHQuJzWqlh
         +mfMV7I65le04J8ndRkeRleemzOGNGYIfW5WCJ4XHUTC2dvfJ9zclETV7a2NCsh4z/Ae
         GZ0OehtP4u40f6unbqGAsS07DcAo9TCVtxHty0ByRO4dMTjOKHr1i9mkvOJqRsr+Lv6I
         o/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghm21256THfbOn3KVvuWEi/DwX/iv9k5P345vocVON4=;
        b=nv5XC61mOG1oxnBvF3Ki50rFKng565vjWQJh9bocDqKheZMGMlRsiJ2ihJDGatCNT1
         f2hbZK5LBse1uN186VwOrnKDMpD+0zBYiz9cK6P4MrwUXOdLh+PPaT3DLghpQ/a7snZW
         Y8lVo2BYLGrakoqToQR8VSR1d8yFJd5jEnbrmn3APSq2bp2/SdMf8oYcZVn7t/5F1XiL
         JVU5xZPmYPYWV/2/hlxI8Rf5laG/wePv/7l3rkrCclcwc89eAoneymPO+/91Zh+cqAVE
         6f6ownFMZe4jRtXkuUnCbe5RAukOsvPUJw/1mUG7Ewu1QZQvet8XsLk8rxmqra2PrHpB
         /jaA==
X-Gm-Message-State: ANoB5pnFXR6LhRZU7+T9cZOM/prxpm9hJRKrUcV5g0r9VQjjkM6aff/Y
        1MYWcd1mdKAtJ9XvIOrPoMI5VHYRdqKL/g==
X-Google-Smtp-Source: AA0mqf6qFyF1jefUCOc6DwkOCXM6drksw7s3K6MQkdstDJbLrbHnWyK3bx3Oj/mhGIPOup99A65Wqg==
X-Received: by 2002:a17:907:8b13:b0:781:541:6599 with SMTP id sz19-20020a1709078b1300b0078105416599mr2895725ejc.45.1668704821991;
        Thu, 17 Nov 2022 09:07:01 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id jo25-20020a170906f6d900b007abafe43c3bsm601110ejb.86.2022.11.17.09.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 09:07:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oviLt-004w9E-0I;
        Thu, 17 Nov 2022 18:07:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 02/30] read-cache: add index.computeHash config option
Date:   Thu, 17 Nov 2022 17:13:45 +0100
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <030d76f52af654470026b0c4b1dfba2b6c996885.1667846164.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <030d76f52af654470026b0c4b1dfba2b6c996885.1667846164.git.gitgitgadget@gmail.com>
Message-ID: <221117.8635ahik7e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 07 2022, Derrick Stolee via GitGitGadget wrote:

> Summary
>   'without hash' ran
>     1.78 =C2=B1 0.76 times faster than 'with hash'
>
> These performance benefits are substantial enough to allow users the
> ability to opt-in to this feature, even with the potential confusion
> with older 'git fsck' versions.

The 0.76 part of that is probably just fs caches etc. screwing things
up. I tried it on a ramdisk with CFLAGS=3D-O3:
=09
	$ hyperfine -L v false,true './git -c index.computeHash=3D{v} -C /dev/shm/=
linux update-index --force-write' -w 1 -r 10
	Benchmark 1: ./git -c index.computeHash=3Dfalse -C /dev/shm/linux update-i=
ndex --force-write
	  Time (mean =C2=B1 =CF=83):      13.3 ms =C2=B1   0.3 ms    [User: 7.1 ms=
, System: 6.1 ms]
	  Range (min =E2=80=A6 max):    12.7 ms =E2=80=A6  13.6 ms    10 runs
=09=20
	Benchmark 2: ./git -c index.computeHash=3Dtrue -C /dev/shm/linux update-in=
dex --force-write
	  Time (mean =C2=B1 =CF=83):      34.8 ms =C2=B1   0.4 ms    [User: 28.9 m=
s, System: 5.8 ms]
	  Range (min =E2=80=A6 max):    34.2 ms =E2=80=A6  35.1 ms    10 runs
=09=20
	Summary
	  './git -c index.computeHash=3Dfalse -C /dev/shm/linux update-index --for=
ce-write' ran
	    2.62 =C2=B1 0.07 times faster than './git -c index.computeHash=3Dtrue =
-C /dev/shm/linux update-index --force-write'

I also see that if I compile with OPENSSL_SHA1=3DY, then:
=09
	$ hyperfine -L v false,true './git -c index.computeHash=3D{v} -C /dev/shm/=
linux update-index --force-write'=20
	Benchmark 1: ./git -c index.computeHash=3Dfalse -C /dev/shm/linux update-i=
ndex --force-write
	  Time (mean =C2=B1 =CF=83):      14.0 ms =C2=B1   1.3 ms    [User: 7.7 ms=
, System: 6.2 ms]
	  Range (min =E2=80=A6 max):    13.1 ms =E2=80=A6  21.7 ms    206 runs
=09=20
	  Warning: Statistical outliers were detected. Consider re-running this be=
nchmark on a quiet PC without any interferences from other programs. It mig=
ht help to use the '--warmup' or '--prepare'=20
	options.
=09=20
	Benchmark 2: ./git -c index.computeHash=3Dtrue -C /dev/shm/linux update-in=
dex --force-write
	  Time (mean =C2=B1 =CF=83):      21.0 ms =C2=B1   1.0 ms    [User: 15.0 m=
s, System: 6.0 ms]
	  Range (min =E2=80=A6 max):    20.1 ms =E2=80=A6  28.4 ms    138 runs
=09=20
	  Warning: Statistical outliers were detected. Consider re-running this be=
nchmark on a quiet PC without any interferences from other programs. It mig=
ht help to use the '--warmup' or '--prepare'=20
	options.
=09=20
	Summary
	  './git -c index.computeHash=3Dfalse -C /dev/shm/linux update-index --for=
ce-write' ran
	    1.50 =C2=B1 0.15 times faster than './git -c index.computeHash=3Dtrue =
-C /dev/shm/linux update-index --force-write'

Which, FWIW is something worth considering. I.e. when we introduced
sha1dc we did so with the "big hammer" of the existing hashing API,
which is all or nothing, and we pick the hash when we compile git.

But that left a lot of things slower for no good reason, e.g. when we do
this hashing of the trailers. So if we could just compile with two
implementations, and give users the choice of "use the faster hash when
you're not communicating with other git repos" we could make things
faster in some cases, without the potential format interop issues.

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
> +index.computeHash::
> +	When enabled, compute the hash of the index file as it is written
> +	and store the hash at the end of the content. This is enabled by
> +	default.
> ++

If we have a boolean option it makes sense to make its name reflect the
opt-in nature. So "index.skipHash". Then just say "If enabled", and skip
the "this is enabled by default, and then later this code:

> +	int compute_hash;
> [...]
> +	if (!git_config_get_maybe_bool("index.computehash", &compute_hash) &&
> +	    !compute_hash)
> +		f->skip_hash =3D 1;

Can just become:

	git_config_get_maybe_bool("index.skipHash", &f->skip_hash);

I.e. git_config_get_maybe_bool() leaves the passed-in dest value alone
if it doesn't have it in the config, and you only use this
"compute_hash" as an inverted version of "skip_hash".

> +If you disable `index.computHash`, then older Git clients may report that
> +your index is corrupt during `git fsck`.
> diff --git a/read-cache.c b/read-cache.c
> index 32024029274..f24d96de4d3 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1817,6 +1817,8 @@ static int verify_hdr(const struct cache_header *hd=
r, unsigned long size)
>  	git_hash_ctx c;
>  	unsigned char hash[GIT_MAX_RAWSZ];
>  	int hdr_version;
> +	int all_zeroes =3D 1;
> +	unsigned char *start, *end;
>=20=20
>  	if (hdr->hdr_signature !=3D htonl(CACHE_SIGNATURE))
>  		return error(_("bad signature 0x%08x"), hdr->hdr_signature);
> @@ -1827,10 +1829,23 @@ static int verify_hdr(const struct cache_header *=
hdr, unsigned long size)
>  	if (!verify_index_checksum)
>  		return 0;
>=20=20
> +	end =3D (unsigned char *)hdr + size;
> +	start =3D end - the_hash_algo->rawsz;
> +	while (start < end) {
> +		if (*start !=3D 0) {
> +			all_zeroes =3D 0;
> +			break;
> +		}
> +		start++;
> +	}

Didn't you just re-invent oidread()? :)

Just to narrate my way through this. Before we called verify_hdr() we
did:

        hdr =3D (const struct cache_header *)mmap;
        if (verify_hdr(hdr, mmap_size) < 0)

So, we mmap()'d the index on disk, and whe "hdr" is the struct version
of this data, we then cast that back to an "unsigned char *" here,
because we're interested in just the raw bytes.

Then we "jump to the end" here, and start iterating over the rawsz at
the end, because we're just reading if we have a null_oid().

Then, right after that verify_hdr() call, the veriy next thing we'll do is:

	oidread(&istate->oid, (const unsigned char *)hdr + mmap_size - the_hash_al=
go->rawsz);

So, maybe I'm missing some subtlety still, and some of this is existing
baggage in the pre-image (we used to have the sha1 in the struct, a
*long* time ago).

But isn't this equivalent?:
=09
	diff --git a/read-cache.c b/read-cache.c
	index f24d96de4d3..39b5b8419f5 100644
	--- a/read-cache.c
	+++ b/read-cache.c
	@@ -1812,13 +1812,14 @@ int verify_index_checksum;
	 /* Allow fsck to force verification of the cache entry order. */
	 int verify_ce_order;
=09=20
	-static int verify_hdr(const struct cache_header *hdr, unsigned long size)
	+static int verify_hdr(const char *const mmap, const size_t size,
	+		      const struct cache_header **hdrp, struct object_id *oid)
	 {
	+	const struct cache_header *hdr =3D (const struct cache_header *)mmap;
	 	git_hash_ctx c;
	 	unsigned char hash[GIT_MAX_RAWSZ];
	 	int hdr_version;
	-	int all_zeroes =3D 1;
	-	unsigned char *start, *end;
	+	const unsigned char *end =3D (unsigned char *)mmap + size;
=09=20
	 	if (hdr->hdr_signature !=3D htonl(CACHE_SIGNATURE))
	 		return error(_("bad signature 0x%08x"), hdr->hdr_signature);
	@@ -1826,20 +1827,12 @@ static int verify_hdr(const struct cache_header *h=
dr, unsigned long size)
	 	if (hdr_version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < hdr_version)
	 		return error(_("bad index version %d"), hdr_version);
=09=20
	+	*hdrp =3D hdr;
	+	oidread(oid, end - the_hash_algo->rawsz);
	+
	 	if (!verify_index_checksum)
	 		return 0;
	-
	-	end =3D (unsigned char *)hdr + size;
	-	start =3D end - the_hash_algo->rawsz;
	-	while (start < end) {
	-		if (*start !=3D 0) {
	-			all_zeroes =3D 0;
	-			break;
	-		}
	-		start++;
	-	}
	-
	-	if (all_zeroes)
	+	if (is_null_oid(oid))
	 		return 0;
=09=20
	 	the_hash_algo->init_fn(&c);
	@@ -2358,11 +2351,8 @@ int do_read_index(struct index_state *istate, const=
 char *path, int must_exist)
	 			mmap_os_err());
	 	close(fd);
=09=20
	-	hdr =3D (const struct cache_header *)mmap;
	-	if (verify_hdr(hdr, mmap_size) < 0)
	+	if (verify_hdr(mmap, mmap_size, &hdr, &istate->oid) < 0)
	 		goto unmap;
	-
	-	oidread(&istate->oid, (const unsigned char *)hdr + mmap_size - the_hash_=
algo->rawsz);
	 	istate->version =3D ntohl(hdr->hdr_version);
	 	istate->cache_nr =3D ntohl(hdr->hdr_entries);
	 	istate->cache_alloc =3D alloc_nr(istate->cache_nr);

I.e. we just make the verify function be in charge of populating our
"oid", which we can do that early, as we'd error out later in the
function if it doesn't match.

We could avoid the "hdrp" there, but if we're doing the cast it's
probably good for readability to just do it once.

> +test_expect_success 'index.computeHash config option' '
> +	(
> +		rm -f .git/index &&
> +		git -c index.computeHash=3Dfalse add a &&
> +		git fsck
> +	)
> +'

You can skip the subshell here, but for a non-RFC let's leave the test
in a nice state for the next test someone adds, so maybe:

	test_when_finished "rm -rf repo" &&
	git clone . repo &&
	[...]

Lastly, on this again:

> These performance benefits are substantial enough to allow users the
> ability to opt-in to this feature, even with the potential confusion
> with older 'git fsck' versions.

Isn't an unstated major caveat here that it's not "an older verison",
but if you on *your version* set the config to "true" your index doesn't
have a hash, so it's persisted until you wipe the index?

