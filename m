Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE0BC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 19:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiG1TXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 15:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiG1TXB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 15:23:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1352967593
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 12:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659036173;
        bh=ipCUUF4bUZxwh1bao7cf6H37AhulE2ZNRndSQQQ/Nys=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eIYMVG0IGAPsSScvzSUzBQHaU1T9gDo6LoBBoKtjaL1sUOGV+bM7dxR/CyjizCi/F
         31VmfXz003ry8boeVKE1UgxkTw22T33cF4x0J7ET9Z/G9UDaAO8RoV/15BaqSxh+Ao
         2IVdRdQK0tO818qHJ/KYczmmOedHFcmSN6ijLMHo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.196.158] ([89.1.214.237]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXXyP-1ny69S12Qp-00YwdV; Thu, 28
 Jul 2022 21:22:53 +0200
Date:   Thu, 28 Jul 2022 21:22:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable
 and add tests
In-Reply-To: <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com>
Message-ID: <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr>
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>        <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8g+Omnb85usEcajTl9Cy6aklEQpcTmpnWGJStgQMqjS6LLOCqtQ
 VBiDqkZgGh2cmNEhXQ/iy0jYTVPfpP7uJJew7NRG+TPNODS0H/ooBU+KLN6BlI9lXiujy5N
 WKw8nLya0wbBDFfmKHzIyFZ3Maout0F4SR8zYx2OVjzdc/NNi5QzuUhUdIBiTskoLnhEDHo
 iJqpIRfJwTVDvzMIQrR3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eak62pQkb60=:oeGBPEUvKNoFqyZPphP8Bg
 /heq2oX2DJUvGMIITf/Uci5cGSsICvEwBlzI8t/djQF6dfCKHX9ZCnugwYky/tQLnhAD6Ls/o
 bIciwOb8swUcwC8UGeszL9nqig5l/HwqTun+qY4TdOlgudHw7h/2ezZT0l6WdXVBkR/Zb7LpX
 kWXLbbQv4pyWQr2iiA9SQH5Gjt6UprloInmBDV1hwr64C6/VDwbc7PIZu9spgK5Ym4VkrxZu5
 PazwhUqYBqRpgirtW02jTSfPoD5+/E8yT4dJKR2cTlx7uPHKmqMt8Ueo9TlrwTWaWgyXZNP6h
 sifHz9gDrOWN76N313hACecPoEW+wobfWAI9HKEvdpxzSDM07r5/0UZkGra25W0sV+5WHQ+Ea
 SvIgenQC4P4i4Ky0cNzkF3NUQJqpu/Ra1q/YlBQRg2LH9kAN1eXmxPyljYw+GSc4rpQz9YXeI
 SMIZCmntlmU5t1EJYufNue5XysLev9fQ/SU5/bRL/tM9Tsrtu6fIV2Uv8HCGQlWUgfY/CrTdO
 7oejca7S6xw9lU2onTar2FUac2KEciSl6ZFpY3mNQZEF2bPlplqT7qRy+iGp6RYnxby59zmB4
 dH2aPdrHVgcTd6w8IkpNXJBdurmLKRr2Yy6nAO+VHVc9Wtq2N5tl9axu58TwFQxKwYY0nxuQh
 LRU9LXRBHEifxklzZ0R4aiWl8d/yfc64cNv6FWh+yVi8cQv7W3dh7//NO311+JiI7tKXHnHFd
 Pxu4wYj/64ErRZyD6EV8jO2SnMRMzsQYp9I4Fb/jPdKqRKgBp4jeIR4q/1qRHz7THJx1tL5Fj
 GYtqVo5PJ1stNoj5O5APUGksD6pXg9WPhrtGeWYN4bACMuHqGLohpUJpqhUlx0c1R2g44PPj1
 KT9qCk2zVcadtoUJa0FsECMCARiyiQ3qJdZ+r0EhDuA8hkIryNa5dpOwEvz15f64G9FFXfJ5J
 gM0qBDHIRbRCl+CPQFYa5mUNqrGmKchVfrhnfH3Mz9WcUOb5gSMmhJtUZW8k0zSKCx6CMsVff
 19lW/U97j/NIUmRXpHoShdaDD0pC12XM1FZMVwooowX6ZSXqo7wQcslcby4zZnMGlmtieA2QW
 2sSyd3uiTA+dZPhOGm85Wl0JHYhN79WRT1KDtbkzrSIrHc8CQi+64scCw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

On Wed, 20 Jul 2022, Abhradeep Chakraborty via GitGitGadget wrote:

> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> Teach Git to provide a way for users to enable/disable bitmap lookup
> table extension by providing a config option named 'writeBitmapLookupTab=
le'.
> Default is false.
>
> Also add test to verify writting of lookup table.
>
> Mentored-by: Taylor Blau <me@ttaylorr.com>
> Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Co-Authored-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>  Documentation/config/pack.txt     |   7 +
>  builtin/multi-pack-index.c        |   7 +
>  builtin/pack-objects.c            |   8 +
>  midx.c                            |   3 +
>  midx.h                            |   1 +
>  t/t5310-pack-bitmaps.sh           | 792 ++++++++++++++++--------------
>  t/t5311-pack-bitmaps-shallow.sh   |  53 +-
>  t/t5326-multi-pack-bitmaps.sh     | 421 +++++++++-------

That's quite a large a change, and unfortunately I pinpointed a flake to
this patch when running with GIT_TEST_DEFAULT_HASH=3Dsha256. The symptom i=
s
this:

=2D- snip --
[...]
+ diff -u expect.normalized actual.normalized
+ rm -f expect.normalized actual.normalized
ok 317 - enumerate --objects (full bitmap, other)

expecting success of 5326.318 'bitmap --objects handles non-commit objects=
 (full bitmap, other)':
                git rev-list --objects --use-bitmap-index $branch tagged-b=
lob >actual &&
                grep $blob actual

+ git rev-list --objects --use-bitmap-index other tagged-blob
+ grep bff4ed5e839bd73e821f78b45a7fa34208aa85596535ec8e9ac5eab477ca6f81 ac=
tual
bff4ed5e839bd73e821f78b45a7fa34208aa85596535ec8e9ac5eab477ca6f81
ok 318 - bitmap --objects handles non-commit objects (full bitmap, other)

expecting success of 5326.319 'clone from bitmapped repository':
                rm -fr clone.git &&
                git clone --no-local --bare . clone.git &&
                git rev-parse HEAD >expect &&
                git --git-dir=3Dclone.git rev-parse HEAD >actual &&
                test_cmp expect actual

+ rm -fr clone.git
+ git clone --no-local --bare . clone.git
Cloning into bare repository 'clone.git'...
remote: Enumerating objects: 756, done.
remote: Counting objects: 100% (754/754), done.
remote: Compressing objects: 100% (281/281), done.
remote: Total 756 (delta 245), reused 740 (delta 234), pack-reused 2
Receiving objects: 100% (756/756), 77.50 KiB | 8.61 MiB/s, done.
fatal: REF_DELTA at offset 221 already resolved (duplicate base 4d332072f1=
61629ffe4652ecd3ce377ef88447bec73f05ab0f3515f98bd061cf?)
fatal: fetch-pack: invalid index-pack output
error: last command exited with $?=3D128
not ok 319 - clone from bitmapped repository
#
#                       rm -fr clone.git &&
#                       git clone --no-local --bare . clone.git &&
#                       git rev-parse HEAD >expect &&
#                       git --git-dir=3Dclone.git rev-parse HEAD >actual &=
&
#                       test_cmp expect actual
#
1..319
=2D- snap --

On a hunch, I ran this through valgrind (took a while) but it did not
point out the problem.

Again, this is only with SHA-256 (and somewhat flaky), it passes every
time with SHA-1. Maybe you can reproduce on your side with that
information?

Sadly, this patch is way too large for me to do a drive-by debugging
session, so I will have to leave it to you to investigate further.

Ciao,
Dscho

>  t/t5327-multi-pack-bitmaps-rev.sh |  24 +-
>  9 files changed, 733 insertions(+), 583 deletions(-)
>
> diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.t=
xt
> index ad7f73a1ead..b955ca572ec 100644
> --- a/Documentation/config/pack.txt
> +++ b/Documentation/config/pack.txt
> @@ -164,6 +164,13 @@ When writing a multi-pack reachability bitmap, no n=
ew namehashes are
>  computed; instead, any namehashes stored in an existing bitmap are
>  permuted into their appropriate location when writing a new bitmap.
>
> +pack.writeBitmapLookupTable::
> +	When true, Git will include a "lookup table" section in the
> +	bitmap index (if one is written). This table is used to defer
> +	loading individual bitmaps as late as possible. This can be
> +	beneficial in repositories that have relatively large bitmap
> +	indexes. Defaults to false.
> +
>  pack.writeReverseIndex::
>  	When true, git will write a corresponding .rev file (see:
>  	link:../technical/pack-format.html[Documentation/technical/pack-format=
.txt])
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 5edbb7fe86e..55402b46f41 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -87,6 +87,13 @@ static int git_multi_pack_index_write_config(const ch=
ar *var, const char *value,
>  			opts.flags &=3D ~MIDX_WRITE_BITMAP_HASH_CACHE;
>  	}
>
> +	if (!strcmp(var, "pack.writebitmaplookuptable")) {
> +		if (git_config_bool(var, value))
> +			opts.flags |=3D MIDX_WRITE_BITMAP_LOOKUP_TABLE;
> +		else
> +			opts.flags &=3D ~MIDX_WRITE_BITMAP_LOOKUP_TABLE;
> +	}
> +
>  	/*
>  	 * We should never make a fall-back call to 'git_default_config', sinc=
e
>  	 * this was already called in 'cmd_multi_pack_index()'.
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 39e28cfcafc..46e26774963 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3148,6 +3148,14 @@ static int git_pack_config(const char *k, const c=
har *v, void *cb)
>  		else
>  			write_bitmap_options &=3D ~BITMAP_OPT_HASH_CACHE;
>  	}
> +
> +	if (!strcmp(k, "pack.writebitmaplookuptable")) {
> +		if (git_config_bool(k, v))
> +			write_bitmap_options |=3D BITMAP_OPT_LOOKUP_TABLE;
> +		else
> +			write_bitmap_options &=3D ~BITMAP_OPT_LOOKUP_TABLE;
> +	}
> +
>  	if (!strcmp(k, "pack.usebitmaps")) {
>  		use_bitmap_index_default =3D git_config_bool(k, v);
>  		return 0;
> diff --git a/midx.c b/midx.c
> index 5f0dd386b02..9c26d04bfde 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1072,6 +1072,9 @@ static int write_midx_bitmap(char *midx_name, unsi=
gned char *midx_hash,
>  	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
>  		options |=3D BITMAP_OPT_HASH_CACHE;
>
> +	if (flags & MIDX_WRITE_BITMAP_LOOKUP_TABLE)
> +		options |=3D BITMAP_OPT_LOOKUP_TABLE;
> +
>  	prepare_midx_packing_data(&pdata, ctx);
>
>  	commits =3D find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, c=
tx);
> diff --git a/midx.h b/midx.h
> index 22e8e53288e..5578cd7b835 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -47,6 +47,7 @@ struct multi_pack_index {
>  #define MIDX_WRITE_REV_INDEX (1 << 1)
>  #define MIDX_WRITE_BITMAP (1 << 2)
>  #define MIDX_WRITE_BITMAP_HASH_CACHE (1 << 3)
> +#define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
>
>  const unsigned char *get_midx_checksum(struct multi_pack_index *m);
>  void get_midx_filename(struct strbuf *out, const char *object_dir);
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index f775fc1ce69..c0607172827 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -26,22 +26,413 @@ has_any () {
>  	grep -Ff "$1" "$2"
>  }
>
> -setup_bitmap_history
> -
> -test_expect_success 'setup writing bitmaps during repack' '
> -	git config repack.writeBitmaps true
> -'
> -
> -test_expect_success 'full repack creates bitmaps' '
> -	GIT_TRACE2_EVENT=3D"$(pwd)/trace" \
> +test_bitmap_cases () {
> +	writeLookupTable=3Dfalse
> +	for i in "$@"
> +	do
> +		case "$i" in
> +		"pack.writeBitmapLookupTable") writeLookupTable=3Dtrue;;
> +		esac
> +	done
> +
> +	test_expect_success 'setup test repository' '
> +		rm -fr * .git &&
> +		git init &&
> +		git config pack.writeBitmapLookupTable '"$writeLookupTable"'
> +	'
> +	setup_bitmap_history
> +
> +	test_expect_success 'setup writing bitmaps during repack' '
> +		git config repack.writeBitmaps true
> +	'
> +
> +	test_expect_success 'full repack creates bitmaps' '
> +		GIT_TRACE2_EVENT=3D"$(pwd)/trace" \
> +			git repack -ad &&
> +		ls .git/objects/pack/ | grep bitmap >output &&
> +		test_line_count =3D 1 output &&
> +		grep "\"key\":\"num_selected_commits\",\"value\":\"106\"" trace &&
> +		grep "\"key\":\"num_maximal_commits\",\"value\":\"107\"" trace
> +	'
> +
> +	basic_bitmap_tests
> +
> +	test_expect_success 'pack-objects respects --local (non-local loose)' =
'
> +		git init --bare alt.git &&
> +		echo $(pwd)/alt.git/objects >.git/objects/info/alternates &&
> +		echo content1 >file1 &&
> +		# non-local loose object which is not present in bitmapped pack
> +		altblob=3D$(GIT_DIR=3Dalt.git git hash-object -w file1) &&
> +		# non-local loose object which is also present in bitmapped pack
> +		git cat-file blob $blob | GIT_DIR=3Dalt.git git hash-object -w --stdi=
n &&
> +		git add file1 &&
> +		test_tick &&
> +		git commit -m commit_file1 &&
> +		echo HEAD | git pack-objects --local --stdout --revs >1.pack &&
> +		git index-pack 1.pack &&
> +		list_packed_objects 1.idx >1.objects &&
> +		printf "%s\n" "$altblob" "$blob" >nonlocal-loose &&
> +		! has_any nonlocal-loose 1.objects
> +	'
> +
> +	test_expect_success 'pack-objects respects --honor-pack-keep (local no=
n-bitmapped pack)' '
> +		echo content2 >file2 &&
> +		blob2=3D$(git hash-object -w file2) &&
> +		git add file2 &&
> +		test_tick &&
> +		git commit -m commit_file2 &&
> +		printf "%s\n" "$blob2" "$bitmaptip" >keepobjects &&
> +		pack2=3D$(git pack-objects pack2 <keepobjects) &&
> +		mv pack2-$pack2.* .git/objects/pack/ &&
> +		>.git/objects/pack/pack2-$pack2.keep &&
> +		rm $(objpath $blob2) &&
> +		echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >2a.pa=
ck &&
> +		git index-pack 2a.pack &&
> +		list_packed_objects 2a.idx >2a.objects &&
> +		! has_any keepobjects 2a.objects
> +	'
> +
> +	test_expect_success 'pack-objects respects --local (non-local pack)' '
> +		mv .git/objects/pack/pack2-$pack2.* alt.git/objects/pack/ &&
> +		echo HEAD | git pack-objects --local --stdout --revs >2b.pack &&
> +		git index-pack 2b.pack &&
> +		list_packed_objects 2b.idx >2b.objects &&
> +		! has_any keepobjects 2b.objects
> +	'
> +
> +	test_expect_success 'pack-objects respects --honor-pack-keep (local bi=
tmapped pack)' '
> +		ls .git/objects/pack/ | grep bitmap >output &&
> +		test_line_count =3D 1 output &&
> +		packbitmap=3D$(basename $(cat output) .bitmap) &&
> +		list_packed_objects .git/objects/pack/$packbitmap.idx >packbitmap.obj=
ects &&
> +		test_when_finished "rm -f .git/objects/pack/$packbitmap.keep" &&
> +		>.git/objects/pack/$packbitmap.keep &&
> +		echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >3a.pa=
ck &&
> +		git index-pack 3a.pack &&
> +		list_packed_objects 3a.idx >3a.objects &&
> +		! has_any packbitmap.objects 3a.objects
> +	'
> +
> +	test_expect_success 'pack-objects respects --local (non-local bitmappe=
d pack)' '
> +		mv .git/objects/pack/$packbitmap.* alt.git/objects/pack/ &&
> +		rm -f .git/objects/pack/multi-pack-index &&
> +		test_when_finished "mv alt.git/objects/pack/$packbitmap.* .git/object=
s/pack/" &&
> +		echo HEAD | git pack-objects --local --stdout --revs >3b.pack &&
> +		git index-pack 3b.pack &&
> +		list_packed_objects 3b.idx >3b.objects &&
> +		! has_any packbitmap.objects 3b.objects
> +	'
> +
> +	test_expect_success 'pack-objects to file can use bitmap' '
> +		# make sure we still have 1 bitmap index from previous tests
> +		ls .git/objects/pack/ | grep bitmap >output &&
> +		test_line_count =3D 1 output &&
> +		# verify equivalent packs are generated with/without using bitmap ind=
ex
> +		packasha1=3D$(git pack-objects --no-use-bitmap-index --all packa </de=
v/null) &&
> +		packbsha1=3D$(git pack-objects --use-bitmap-index --all packb </dev/n=
ull) &&
> +		list_packed_objects packa-$packasha1.idx >packa.objects &&
> +		list_packed_objects packb-$packbsha1.idx >packb.objects &&
> +		test_cmp packa.objects packb.objects
> +	'
> +
> +	test_expect_success 'full repack, reusing previous bitmaps' '
>  		git repack -ad &&
> -	ls .git/objects/pack/ | grep bitmap >output &&
> -	test_line_count =3D 1 output &&
> -	grep "\"key\":\"num_selected_commits\",\"value\":\"106\"" trace &&
> -	grep "\"key\":\"num_maximal_commits\",\"value\":\"107\"" trace
> -'
> +		ls .git/objects/pack/ | grep bitmap >output &&
> +		test_line_count =3D 1 output
> +	'
> +
> +	test_expect_success 'fetch (full bitmap)' '
> +		git --git-dir=3Dclone.git fetch origin second:second &&
> +		git rev-parse HEAD >expect &&
> +		git --git-dir=3Dclone.git rev-parse HEAD >actual &&
> +		test_cmp expect actual
> +	'
> +
> +	test_expect_success 'create objects for missing-HAVE tests' '
> +		blob=3D$(echo "missing have" | git hash-object -w --stdin) &&
> +		tree=3D$(printf "100644 blob $blob\tfile\n" | git mktree) &&
> +		parent=3D$(echo parent | git commit-tree $tree) &&
> +		commit=3D$(echo commit | git commit-tree $tree -p $parent) &&
> +		cat >revs <<-EOF
> +		HEAD
> +		^HEAD^
> +		^$commit
> +		EOF
> +	'
> +
> +	test_expect_success 'pack-objects respects --incremental' '
> +		cat >revs2 <<-EOF &&
> +		HEAD
> +		$commit
> +		EOF
> +		git pack-objects --incremental --stdout --revs <revs2 >4.pack &&
> +		git index-pack 4.pack &&
> +		list_packed_objects 4.idx >4.objects &&
> +		test_line_count =3D 4 4.objects &&
> +		git rev-list --objects $commit >revlist &&
> +		cut -d" " -f1 revlist |sort >objects &&
> +		test_cmp 4.objects objects
> +	'
> +
> +	test_expect_success 'pack with missing blob' '
> +		rm $(objpath $blob) &&
> +		git pack-objects --stdout --revs <revs >/dev/null
> +	'
> +
> +	test_expect_success 'pack with missing tree' '
> +		rm $(objpath $tree) &&
> +		git pack-objects --stdout --revs <revs >/dev/null
> +	'
> +
> +	test_expect_success 'pack with missing parent' '
> +		rm $(objpath $parent) &&
> +		git pack-objects --stdout --revs <revs >/dev/null
> +	'
> +
> +	test_expect_success JGIT,SHA1 'we can read jgit bitmaps' '
> +		git clone --bare . compat-jgit.git &&
> +		(
> +			cd compat-jgit.git &&
> +			rm -f objects/pack/*.bitmap &&
> +			jgit gc &&
> +			git rev-list --test-bitmap HEAD
> +		)
> +	'
> +
> +	test_expect_success JGIT,SHA1 'jgit can read our bitmaps' '
> +		git clone --bare . compat-us.git &&
> +		(
> +			cd compat-us.git &&
> +			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
> +			git repack -adb &&
> +			# jgit gc will barf if it does not like our bitmaps
> +			jgit gc
> +		)
> +	'
> +
> +	test_expect_success 'splitting packs does not generate bogus bitmaps' =
'
> +		test-tool genrandom foo $((1024 * 1024)) >rand &&
> +		git add rand &&
> +		git commit -m "commit with big file" &&
> +		git -c pack.packSizeLimit=3D500k repack -adb &&
> +		git init --bare no-bitmaps.git &&
> +		git -C no-bitmaps.git fetch .. HEAD
> +	'
> +
> +	test_expect_success 'set up reusable pack' '
> +		rm -f .git/objects/pack/*.keep &&
> +		git repack -adb &&
> +		reusable_pack () {
> +			git for-each-ref --format=3D"%(objectname)" |
> +			git pack-objects --delta-base-offset --revs --stdout "$@"
> +		}
> +	'
> +
> +	test_expect_success 'pack reuse respects --honor-pack-keep' '
> +		test_when_finished "rm -f .git/objects/pack/*.keep" &&
> +		for i in .git/objects/pack/*.pack
> +		do
> +			>${i%.pack}.keep || return 1
> +		done &&
> +		reusable_pack --honor-pack-keep >empty.pack &&
> +		git index-pack empty.pack &&
> +		git show-index <empty.idx >actual &&
> +		test_must_be_empty actual
> +	'
> +
> +	test_expect_success 'pack reuse respects --local' '
> +		mv .git/objects/pack/* alt.git/objects/pack/ &&
> +		test_when_finished "mv alt.git/objects/pack/* .git/objects/pack/" &&
> +		reusable_pack --local >empty.pack &&
> +		git index-pack empty.pack &&
> +		git show-index <empty.idx >actual &&
> +		test_must_be_empty actual
> +	'
> +
> +	test_expect_success 'pack reuse respects --incremental' '
> +		reusable_pack --incremental >empty.pack &&
> +		git index-pack empty.pack &&
> +		git show-index <empty.idx >actual &&
> +		test_must_be_empty actual
> +	'
> +
> +	test_expect_success 'truncated bitmap fails gracefully (ewah)' '
> +		test_config pack.writebitmaphashcache false &&
> +		git repack -ad &&
> +		git rev-list --use-bitmap-index --count --all >expect &&
> +		bitmap=3D$(ls .git/objects/pack/*.bitmap) &&
> +		test_when_finished "rm -f $bitmap" &&
> +		test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
> +		mv -f $bitmap.tmp $bitmap &&
> +		git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
> +		test_cmp expect actual &&
> +		test_i18ngrep corrupt.ewah.bitmap stderr
> +	'
> +
> +	test_expect_success 'truncated bitmap fails gracefully (cache)' '
> +		git repack -ad &&
> +		git rev-list --use-bitmap-index --count --all >expect &&
> +		bitmap=3D$(ls .git/objects/pack/*.bitmap) &&
> +		test_when_finished "rm -f $bitmap" &&
> +		test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
> +		mv -f $bitmap.tmp $bitmap &&
> +		git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
> +		test_cmp expect actual &&
> +		test_i18ngrep corrupted.bitmap.index stderr
> +	'
> +
> +	# Create a state of history with these properties:
> +	#
> +	#  - refs that allow a client to fetch some new history, while sharing=
 some old
> +	#    history with the server; we use branches delta-reuse-old and
> +	#    delta-reuse-new here
> +	#
> +	#  - the new history contains an object that is stored on the server a=
s a delta
> +	#    against a base that is in the old history
> +	#
> +	#  - the base object is not immediately reachable from the tip of the =
old
> +	#    history; finding it would involve digging down through history we=
 know the
> +	#    other side has
> +	#
> +	# This should result in a state where fetching from old->new would not
> +	# traditionally reuse the on-disk delta (because we'd have to dig to r=
ealize
> +	# that the client has it), but we will do so if bitmaps can tell us ch=
eaply
> +	# that the other side has it.
> +	test_expect_success 'set up thin delta-reuse parent' '
> +		# This first commit contains the buried base object.
> +		test-tool genrandom delta 16384 >file &&
> +		git add file &&
> +		git commit -m "delta base" &&
> +		base=3D$(git rev-parse --verify HEAD:file) &&
> +
> +		# These intermediate commits bury the base back in history.
> +		# This becomes the "old" state.
> +		for i in 1 2 3 4 5
> +		do
> +			echo $i >file &&
> +			git commit -am "intermediate $i" || return 1
> +		done &&
> +		git branch delta-reuse-old &&
> +
> +		# And now our new history has a delta against the buried base. Note
> +		# that this must be smaller than the original file, since pack-object=
s
> +		# prefers to create deltas from smaller objects to larger.
> +		test-tool genrandom delta 16300 >file &&
> +		git commit -am "delta result" &&
> +		delta=3D$(git rev-parse --verify HEAD:file) &&
> +		git branch delta-reuse-new &&
> +
> +		# Repack with bitmaps and double check that we have the expected delt=
a
> +		# relationship.
> +		git repack -adb &&
> +		have_delta $delta $base
> +	'
> +
> +	# Now we can sanity-check the non-bitmap behavior (that the server is =
not able
> +	# to reuse the delta). This isn't strictly something we care about, so=
 this
> +	# test could be scrapped in the future. But it makes sure that the nex=
t test is
> +	# actually triggering the feature we want.
> +	#
> +	# Note that our tools for working with on-the-wire "thin" packs are li=
mited. So
> +	# we actually perform the fetch, retain the resulting pack, and inspec=
t the
> +	# result.
> +	test_expect_success 'fetch without bitmaps ignores delta against old b=
ase' '
> +		test_config pack.usebitmaps false &&
> +		test_when_finished "rm -rf client.git" &&
> +		git init --bare client.git &&
> +		(
> +			cd client.git &&
> +			git config transfer.unpackLimit 1 &&
> +			git fetch .. delta-reuse-old:delta-reuse-old &&
> +			git fetch .. delta-reuse-new:delta-reuse-new &&
> +			have_delta $delta $ZERO_OID
> +		)
> +	'
> +
> +	# And do the same for the bitmap case, where we do expect to find the =
delta.
> +	test_expect_success 'fetch with bitmaps can reuse old base' '
> +		test_config pack.usebitmaps true &&
> +		test_when_finished "rm -rf client.git" &&
> +		git init --bare client.git &&
> +		(
> +			cd client.git &&
> +			git config transfer.unpackLimit 1 &&
> +			git fetch .. delta-reuse-old:delta-reuse-old &&
> +			git fetch .. delta-reuse-new:delta-reuse-new &&
> +			have_delta $delta $base
> +		)
> +	'
> +
> +	test_expect_success 'pack.preferBitmapTips' '
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
> +
> +			# create enough commits that not all are receive bitmap
> +			# coverage even if they are all at the tip of some reference.
> +			test_commit_bulk --message=3D"%s" 103 &&
> +
> +			git rev-list HEAD >commits.raw &&
> +			sort <commits.raw >commits &&
> +
> +			git log --format=3D"create refs/tags/%s %H" HEAD >refs &&
> +			git update-ref --stdin <refs &&
> +
> +			git repack -adb &&
> +			test-tool bitmap list-commits | sort >bitmaps &&
> +
> +			# remember which commits did not receive bitmaps
> +			comm -13 bitmaps commits >before &&
> +			test_file_not_empty before &&
> +
> +			# mark the commits which did not receive bitmaps as preferred,
> +			# and generate the bitmap again
> +			perl -pe "s{^}{create refs/tags/include/$. }" <before |
> +				git update-ref --stdin &&
> +			git -c pack.preferBitmapTips=3Drefs/tags/include repack -adb &&
> +
> +			# finally, check that the commit(s) without bitmap coverage
> +			# are not the same ones as before
> +			test-tool bitmap list-commits | sort >bitmaps &&
> +			comm -13 bitmaps commits >after &&
> +
> +			! test_cmp before after
> +		)
> +	'
> +
> +	test_expect_success 'complains about multiple pack bitmaps' '
> +		rm -fr repo &&
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
> +
> +			test_commit base &&
> +
> +			git repack -adb &&
> +			bitmap=3D"$(ls .git/objects/pack/pack-*.bitmap)" &&
> +			mv "$bitmap" "$bitmap.bak" &&
> +
> +			test_commit other &&
> +			git repack -ab &&
> +
> +			mv "$bitmap.bak" "$bitmap" &&
> +
> +			find .git/objects/pack -type f -name "*.pack" >packs &&
> +			find .git/objects/pack -type f -name "*.bitmap" >bitmaps &&
> +			test_line_count =3D 2 packs &&
> +			test_line_count =3D 2 bitmaps &&
> +
> +			git rev-list --use-bitmap-index HEAD 2>err &&
> +			grep "ignoring extra bitmap file" err
> +		)
> +	'
> +}
>
> -basic_bitmap_tests
> +test_bitmap_cases
>
>  test_expect_success 'incremental repack fails when bitmaps are requeste=
d' '
>  	test_commit more-1 &&
> @@ -54,375 +445,12 @@ test_expect_success 'incremental repack can disabl=
e bitmaps' '
>  	git repack -d --no-write-bitmap-index
>  '
>
> -test_expect_success 'pack-objects respects --local (non-local loose)' '
> -	git init --bare alt.git &&
> -	echo $(pwd)/alt.git/objects >.git/objects/info/alternates &&
> -	echo content1 >file1 &&
> -	# non-local loose object which is not present in bitmapped pack
> -	altblob=3D$(GIT_DIR=3Dalt.git git hash-object -w file1) &&
> -	# non-local loose object which is also present in bitmapped pack
> -	git cat-file blob $blob | GIT_DIR=3Dalt.git git hash-object -w --stdin=
 &&
> -	git add file1 &&
> -	test_tick &&
> -	git commit -m commit_file1 &&
> -	echo HEAD | git pack-objects --local --stdout --revs >1.pack &&
> -	git index-pack 1.pack &&
> -	list_packed_objects 1.idx >1.objects &&
> -	printf "%s\n" "$altblob" "$blob" >nonlocal-loose &&
> -	! has_any nonlocal-loose 1.objects
> -'
> -
> -test_expect_success 'pack-objects respects --honor-pack-keep (local non=
-bitmapped pack)' '
> -	echo content2 >file2 &&
> -	blob2=3D$(git hash-object -w file2) &&
> -	git add file2 &&
> -	test_tick &&
> -	git commit -m commit_file2 &&
> -	printf "%s\n" "$blob2" "$bitmaptip" >keepobjects &&
> -	pack2=3D$(git pack-objects pack2 <keepobjects) &&
> -	mv pack2-$pack2.* .git/objects/pack/ &&
> -	>.git/objects/pack/pack2-$pack2.keep &&
> -	rm $(objpath $blob2) &&
> -	echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >2a.pac=
k &&
> -	git index-pack 2a.pack &&
> -	list_packed_objects 2a.idx >2a.objects &&
> -	! has_any keepobjects 2a.objects
> -'
> -
> -test_expect_success 'pack-objects respects --local (non-local pack)' '
> -	mv .git/objects/pack/pack2-$pack2.* alt.git/objects/pack/ &&
> -	echo HEAD | git pack-objects --local --stdout --revs >2b.pack &&
> -	git index-pack 2b.pack &&
> -	list_packed_objects 2b.idx >2b.objects &&
> -	! has_any keepobjects 2b.objects
> -'
> -
> -test_expect_success 'pack-objects respects --honor-pack-keep (local bit=
mapped pack)' '
> -	ls .git/objects/pack/ | grep bitmap >output &&
> -	test_line_count =3D 1 output &&
> -	packbitmap=3D$(basename $(cat output) .bitmap) &&
> -	list_packed_objects .git/objects/pack/$packbitmap.idx >packbitmap.obje=
cts &&
> -	test_when_finished "rm -f .git/objects/pack/$packbitmap.keep" &&
> -	>.git/objects/pack/$packbitmap.keep &&
> -	echo HEAD | git pack-objects --honor-pack-keep --stdout --revs >3a.pac=
k &&
> -	git index-pack 3a.pack &&
> -	list_packed_objects 3a.idx >3a.objects &&
> -	! has_any packbitmap.objects 3a.objects
> -'
> -
> -test_expect_success 'pack-objects respects --local (non-local bitmapped=
 pack)' '
> -	mv .git/objects/pack/$packbitmap.* alt.git/objects/pack/ &&
> -	rm -f .git/objects/pack/multi-pack-index &&
> -	test_when_finished "mv alt.git/objects/pack/$packbitmap.* .git/objects=
/pack/" &&
> -	echo HEAD | git pack-objects --local --stdout --revs >3b.pack &&
> -	git index-pack 3b.pack &&
> -	list_packed_objects 3b.idx >3b.objects &&
> -	! has_any packbitmap.objects 3b.objects
> -'
> -
> -test_expect_success 'pack-objects to file can use bitmap' '
> -	# make sure we still have 1 bitmap index from previous tests
> -	ls .git/objects/pack/ | grep bitmap >output &&
> -	test_line_count =3D 1 output &&
> -	# verify equivalent packs are generated with/without using bitmap inde=
x
> -	packasha1=3D$(git pack-objects --no-use-bitmap-index --all packa </dev=
/null) &&
> -	packbsha1=3D$(git pack-objects --use-bitmap-index --all packb </dev/nu=
ll) &&
> -	list_packed_objects packa-$packasha1.idx >packa.objects &&
> -	list_packed_objects packb-$packbsha1.idx >packb.objects &&
> -	test_cmp packa.objects packb.objects
> -'
> -
> -test_expect_success 'full repack, reusing previous bitmaps' '
> -	git repack -ad &&
> -	ls .git/objects/pack/ | grep bitmap >output &&
> -	test_line_count =3D 1 output
> -'
> -
> -test_expect_success 'fetch (full bitmap)' '
> -	git --git-dir=3Dclone.git fetch origin second:second &&
> -	git rev-parse HEAD >expect &&
> -	git --git-dir=3Dclone.git rev-parse HEAD >actual &&
> -	test_cmp expect actual
> -'
> -
> -test_expect_success 'create objects for missing-HAVE tests' '
> -	blob=3D$(echo "missing have" | git hash-object -w --stdin) &&
> -	tree=3D$(printf "100644 blob $blob\tfile\n" | git mktree) &&
> -	parent=3D$(echo parent | git commit-tree $tree) &&
> -	commit=3D$(echo commit | git commit-tree $tree -p $parent) &&
> -	cat >revs <<-EOF
> -	HEAD
> -	^HEAD^
> -	^$commit
> -	EOF
> -'
> -
> -test_expect_success 'pack-objects respects --incremental' '
> -	cat >revs2 <<-EOF &&
> -	HEAD
> -	$commit
> -	EOF
> -	git pack-objects --incremental --stdout --revs <revs2 >4.pack &&
> -	git index-pack 4.pack &&
> -	list_packed_objects 4.idx >4.objects &&
> -	test_line_count =3D 4 4.objects &&
> -	git rev-list --objects $commit >revlist &&
> -	cut -d" " -f1 revlist |sort >objects &&
> -	test_cmp 4.objects objects
> -'
> -
> -test_expect_success 'pack with missing blob' '
> -	rm $(objpath $blob) &&
> -	git pack-objects --stdout --revs <revs >/dev/null
> -'
> +test_bitmap_cases "pack.writeBitmapLookupTable"
>
> -test_expect_success 'pack with missing tree' '
> -	rm $(objpath $tree) &&
> -	git pack-objects --stdout --revs <revs >/dev/null
> -'
> -
> -test_expect_success 'pack with missing parent' '
> -	rm $(objpath $parent) &&
> -	git pack-objects --stdout --revs <revs >/dev/null
> -'
> -
> -test_expect_success JGIT,SHA1 'we can read jgit bitmaps' '
> -	git clone --bare . compat-jgit.git &&
> -	(
> -		cd compat-jgit.git &&
> -		rm -f objects/pack/*.bitmap &&
> -		jgit gc &&
> -		git rev-list --test-bitmap HEAD
> -	)
> -'
> -
> -test_expect_success JGIT,SHA1 'jgit can read our bitmaps' '
> -	git clone --bare . compat-us.git &&
> -	(
> -		cd compat-us.git &&
> -		git repack -adb &&
> -		# jgit gc will barf if it does not like our bitmaps
> -		jgit gc
> -	)
> -'
> -
> -test_expect_success 'splitting packs does not generate bogus bitmaps' '
> -	test-tool genrandom foo $((1024 * 1024)) >rand &&
> -	git add rand &&
> -	git commit -m "commit with big file" &&
> -	git -c pack.packSizeLimit=3D500k repack -adb &&
> -	git init --bare no-bitmaps.git &&
> -	git -C no-bitmaps.git fetch .. HEAD
> -'
> -
> -test_expect_success 'set up reusable pack' '
> -	rm -f .git/objects/pack/*.keep &&
> -	git repack -adb &&
> -	reusable_pack () {
> -		git for-each-ref --format=3D"%(objectname)" |
> -		git pack-objects --delta-base-offset --revs --stdout "$@"
> -	}
> -'
> -
> -test_expect_success 'pack reuse respects --honor-pack-keep' '
> -	test_when_finished "rm -f .git/objects/pack/*.keep" &&
> -	for i in .git/objects/pack/*.pack
> -	do
> -		>${i%.pack}.keep || return 1
> -	done &&
> -	reusable_pack --honor-pack-keep >empty.pack &&
> -	git index-pack empty.pack &&
> -	git show-index <empty.idx >actual &&
> -	test_must_be_empty actual
> -'
> -
> -test_expect_success 'pack reuse respects --local' '
> -	mv .git/objects/pack/* alt.git/objects/pack/ &&
> -	test_when_finished "mv alt.git/objects/pack/* .git/objects/pack/" &&
> -	reusable_pack --local >empty.pack &&
> -	git index-pack empty.pack &&
> -	git show-index <empty.idx >actual &&
> -	test_must_be_empty actual
> -'
> -
> -test_expect_success 'pack reuse respects --incremental' '
> -	reusable_pack --incremental >empty.pack &&
> -	git index-pack empty.pack &&
> -	git show-index <empty.idx >actual &&
> -	test_must_be_empty actual
> -'
> -
> -test_expect_success 'truncated bitmap fails gracefully (ewah)' '
> -	test_config pack.writebitmaphashcache false &&
> -	git repack -ad &&
> -	git rev-list --use-bitmap-index --count --all >expect &&
> -	bitmap=3D$(ls .git/objects/pack/*.bitmap) &&
> -	test_when_finished "rm -f $bitmap" &&
> -	test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
> -	mv -f $bitmap.tmp $bitmap &&
> -	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
> -	test_cmp expect actual &&
> -	test_i18ngrep corrupt.ewah.bitmap stderr
> -'
> -
> -test_expect_success 'truncated bitmap fails gracefully (cache)' '
> -	git repack -ad &&
> -	git rev-list --use-bitmap-index --count --all >expect &&
> -	bitmap=3D$(ls .git/objects/pack/*.bitmap) &&
> -	test_when_finished "rm -f $bitmap" &&
> -	test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
> -	mv -f $bitmap.tmp $bitmap &&
> -	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
> -	test_cmp expect actual &&
> -	test_i18ngrep corrupted.bitmap.index stderr
> -'
> -
> -# Create a state of history with these properties:
> -#
> -#  - refs that allow a client to fetch some new history, while sharing =
some old
> -#    history with the server; we use branches delta-reuse-old and
> -#    delta-reuse-new here
> -#
> -#  - the new history contains an object that is stored on the server as=
 a delta
> -#    against a base that is in the old history
> -#
> -#  - the base object is not immediately reachable from the tip of the o=
ld
> -#    history; finding it would involve digging down through history we =
know the
> -#    other side has
> -#
> -# This should result in a state where fetching from old->new would not
> -# traditionally reuse the on-disk delta (because we'd have to dig to re=
alize
> -# that the client has it), but we will do so if bitmaps can tell us che=
aply
> -# that the other side has it.
> -test_expect_success 'set up thin delta-reuse parent' '
> -	# This first commit contains the buried base object.
> -	test-tool genrandom delta 16384 >file &&
> -	git add file &&
> -	git commit -m "delta base" &&
> -	base=3D$(git rev-parse --verify HEAD:file) &&
> -
> -	# These intermediate commits bury the base back in history.
> -	# This becomes the "old" state.
> -	for i in 1 2 3 4 5
> -	do
> -		echo $i >file &&
> -		git commit -am "intermediate $i" || return 1
> -	done &&
> -	git branch delta-reuse-old &&
> -
> -	# And now our new history has a delta against the buried base. Note
> -	# that this must be smaller than the original file, since pack-objects
> -	# prefers to create deltas from smaller objects to larger.
> -	test-tool genrandom delta 16300 >file &&
> -	git commit -am "delta result" &&
> -	delta=3D$(git rev-parse --verify HEAD:file) &&
> -	git branch delta-reuse-new &&
> -
> -	# Repack with bitmaps and double check that we have the expected delta
> -	# relationship.
> -	git repack -adb &&
> -	have_delta $delta $base
> -'
> -
> -# Now we can sanity-check the non-bitmap behavior (that the server is n=
ot able
> -# to reuse the delta). This isn't strictly something we care about, so =
this
> -# test could be scrapped in the future. But it makes sure that the next=
 test is
> -# actually triggering the feature we want.
> -#
> -# Note that our tools for working with on-the-wire "thin" packs are lim=
ited. So
> -# we actually perform the fetch, retain the resulting pack, and inspect=
 the
> -# result.
> -test_expect_success 'fetch without bitmaps ignores delta against old ba=
se' '
> -	test_config pack.usebitmaps false &&
> -	test_when_finished "rm -rf client.git" &&
> -	git init --bare client.git &&
> -	(
> -		cd client.git &&
> -		git config transfer.unpackLimit 1 &&
> -		git fetch .. delta-reuse-old:delta-reuse-old &&
> -		git fetch .. delta-reuse-new:delta-reuse-new &&
> -		have_delta $delta $ZERO_OID
> -	)
> -'
> -
> -# And do the same for the bitmap case, where we do expect to find the d=
elta.
> -test_expect_success 'fetch with bitmaps can reuse old base' '
> -	test_config pack.usebitmaps true &&
> -	test_when_finished "rm -rf client.git" &&
> -	git init --bare client.git &&
> -	(
> -		cd client.git &&
> -		git config transfer.unpackLimit 1 &&
> -		git fetch .. delta-reuse-old:delta-reuse-old &&
> -		git fetch .. delta-reuse-new:delta-reuse-new &&
> -		have_delta $delta $base
> -	)
> -'
> -
> -test_expect_success 'pack.preferBitmapTips' '
> -	git init repo &&
> -	test_when_finished "rm -fr repo" &&
> -	(
> -		cd repo &&
> -
> -		# create enough commits that not all are receive bitmap
> -		# coverage even if they are all at the tip of some reference.
> -		test_commit_bulk --message=3D"%s" 103 &&
> -
> -		git rev-list HEAD >commits.raw &&
> -		sort <commits.raw >commits &&
> -
> -		git log --format=3D"create refs/tags/%s %H" HEAD >refs &&
> -		git update-ref --stdin <refs &&
> -
> -		git repack -adb &&
> -		test-tool bitmap list-commits | sort >bitmaps &&
> -
> -		# remember which commits did not receive bitmaps
> -		comm -13 bitmaps commits >before &&
> -		test_file_not_empty before &&
> -
> -		# mark the commits which did not receive bitmaps as preferred,
> -		# and generate the bitmap again
> -		perl -pe "s{^}{create refs/tags/include/$. }" <before |
> -			git update-ref --stdin &&
> -		git -c pack.preferBitmapTips=3Drefs/tags/include repack -adb &&
> -
> -		# finally, check that the commit(s) without bitmap coverage
> -		# are not the same ones as before
> -		test-tool bitmap list-commits | sort >bitmaps &&
> -		comm -13 bitmaps commits >after &&
> -
> -		! test_cmp before after
> -	)
> -'
> -
> -test_expect_success 'complains about multiple pack bitmaps' '
> -	rm -fr repo &&
> -	git init repo &&
> -	test_when_finished "rm -fr repo" &&
> -	(
> -		cd repo &&
> -
> -		test_commit base &&
> -
> -		git repack -adb &&
> -		bitmap=3D"$(ls .git/objects/pack/pack-*.bitmap)" &&
> -		mv "$bitmap" "$bitmap.bak" &&
> -
> -		test_commit other &&
> -		git repack -ab &&
> -
> -		mv "$bitmap.bak" "$bitmap" &&
> -
> -		find .git/objects/pack -type f -name "*.pack" >packs &&
> -		find .git/objects/pack -type f -name "*.bitmap" >bitmaps &&
> -		test_line_count =3D 2 packs &&
> -		test_line_count =3D 2 bitmaps &&
> -
> -		git rev-list --use-bitmap-index HEAD 2>err &&
> -		grep "ignoring extra bitmap file" err
> -	)
> +test_expect_success 'verify writing bitmap lookup table when enabled' '
> +	GIT_TRACE2_EVENT=3D"$(pwd)/trace2" \
> +		git repack -ad &&
> +	grep "\"label\":\"writing_lookup_table\"" trace2
>  '
>
>  test_done
> diff --git a/t/t5311-pack-bitmaps-shallow.sh b/t/t5311-pack-bitmaps-shal=
low.sh
> index 872a95df338..9dae60f73e3 100755
> --- a/t/t5311-pack-bitmaps-shallow.sh
> +++ b/t/t5311-pack-bitmaps-shallow.sh
> @@ -17,23 +17,40 @@ test_description=3D'check bitmap operation with shal=
low repositories'
>  # the tree for A. But in a shallow one, we've grafted away
>  # A, and fetching A to B requires that the other side send
>  # us the tree for file=3D1.
> -test_expect_success 'setup shallow repo' '
> -	echo 1 >file &&
> -	git add file &&
> -	git commit -m orig &&
> -	echo 2 >file &&
> -	git commit -a -m update &&
> -	git clone --no-local --bare --depth=3D1 . shallow.git &&
> -	echo 1 >file &&
> -	git commit -a -m repeat
> -'
> -
> -test_expect_success 'turn on bitmaps in the parent' '
> -	git repack -adb
> -'
> -
> -test_expect_success 'shallow fetch from bitmapped repo' '
> -	(cd shallow.git && git fetch)
> -'
> +test_shallow_bitmaps () {
> +	writeLookupTable=3Dfalse
> +
> +	for i in "$@"
> +	do
> +		case $i in
> +		"pack.writeBitmapLookupTable") writeLookupTable=3Dtrue;;
> +		esac
> +	done
> +
> +	test_expect_success 'setup shallow repo' '
> +		rm -rf * .git &&
> +		git init &&
> +		git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
> +		echo 1 >file &&
> +		git add file &&
> +		git commit -m orig &&
> +		echo 2 >file &&
> +		git commit -a -m update &&
> +		git clone --no-local --bare --depth=3D1 . shallow.git &&
> +		echo 1 >file &&
> +		git commit -a -m repeat
> +	'
> +
> +	test_expect_success 'turn on bitmaps in the parent' '
> +		git repack -adb
> +	'
> +
> +	test_expect_success 'shallow fetch from bitmapped repo' '
> +		(cd shallow.git && git fetch)
> +	'
> +}
> +
> +test_shallow_bitmaps
> +test_shallow_bitmaps "pack.writeBitmapLookupTable"
>
>  test_done
> diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.=
sh
> index 4fe57414c13..3b206adcee6 100755
> --- a/t/t5326-multi-pack-bitmaps.sh
> +++ b/t/t5326-multi-pack-bitmaps.sh
> @@ -15,17 +15,24 @@ GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=3D0
>  sane_unset GIT_TEST_MIDX_WRITE_REV
>  sane_unset GIT_TEST_MIDX_READ_RIDX
>
> -midx_bitmap_core
> -
>  bitmap_reuse_tests() {
>  	from=3D$1
>  	to=3D$2
> +	writeLookupTable=3Dfalse
> +
> +	for i in $3-${$#}
> +	do
> +		case $i in
> +		"pack.writeBitmapLookupTable") writeLookupTable=3Dtrue;;
> +		esac
> +	done
>
>  	test_expect_success "setup pack reuse tests ($from -> $to)" '
>  		rm -fr repo &&
>  		git init repo &&
>  		(
>  			cd repo &&
> +			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
>  			test_commit_bulk 16 &&
>  			git tag old-tip &&
>
> @@ -43,6 +50,7 @@ bitmap_reuse_tests() {
>  	test_expect_success "build bitmap from existing ($from -> $to)" '
>  		(
>  			cd repo &&
> +			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
>  			test_commit_bulk --id=3Dfurther 16 &&
>  			git tag new-tip &&
>
> @@ -59,6 +67,7 @@ bitmap_reuse_tests() {
>  	test_expect_success "verify resulting bitmaps ($from -> $to)" '
>  		(
>  			cd repo &&
> +			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
>  			git for-each-ref &&
>  			git rev-list --test-bitmap refs/tags/old-tip &&
>  			git rev-list --test-bitmap refs/tags/new-tip
> @@ -66,244 +75,294 @@ bitmap_reuse_tests() {
>  	'
>  }
>
> -bitmap_reuse_tests 'pack' 'MIDX'
> -bitmap_reuse_tests 'MIDX' 'pack'
> -bitmap_reuse_tests 'MIDX' 'MIDX'
> +test_midx_bitmap_cases () {
> +	writeLookupTable=3Dfalse
> +	writeBitmapLookupTable=3D
> +
> +	for i in "$@"
> +	do
> +		case $i in
> +		"pack.writeBitmapLookupTable")
> +			writeLookupTable=3Dtrue
> +			writeBitmapLookupTable=3D"$i"
> +			;;
> +		esac
> +	done
> +
> +	test_expect_success 'setup test_repository' '
> +		rm -rf * .git &&
> +		git init &&
> +		git config pack.writeBitmapLookupTable '"$writeLookupTable"'
> +	'
>
> -test_expect_success 'missing object closure fails gracefully' '
> -	rm -fr repo &&
> -	git init repo &&
> -	test_when_finished "rm -fr repo" &&
> -	(
> -		cd repo &&
> +	midx_bitmap_core
>
> -		test_commit loose &&
> -		test_commit packed &&
> +	bitmap_reuse_tests 'pack' 'MIDX' "$writeBitmapLookupTable"
> +	bitmap_reuse_tests 'MIDX' 'pack' "$writeBitmapLookupTable"
> +	bitmap_reuse_tests 'MIDX' 'MIDX' "$writeBitmapLookupTable"
>
> -		# Do not pass "--revs"; we want a pack without the "loose"
> -		# commit.
> -		git pack-objects $objdir/pack/pack <<-EOF &&
> -		$(git rev-parse packed)
> -		EOF
> +	test_expect_success 'missing object closure fails gracefully' '
> +		rm -fr repo &&
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
>
> -		test_must_fail git multi-pack-index write --bitmap 2>err &&
> -		grep "doesn.t have full closure" err &&
> -		test_path_is_missing $midx
> -	)
> -'
> +			test_commit loose &&
> +			test_commit packed &&
>
> -midx_bitmap_partial_tests
> +			# Do not pass "--revs"; we want a pack without the "loose"
> +			# commit.
> +			git pack-objects $objdir/pack/pack <<-EOF &&
> +			$(git rev-parse packed)
> +			EOF
>
> -test_expect_success 'removing a MIDX clears stale bitmaps' '
> -	rm -fr repo &&
> -	git init repo &&
> -	test_when_finished "rm -fr repo" &&
> -	(
> -		cd repo &&
> -		test_commit base &&
> -		git repack &&
> -		git multi-pack-index write --bitmap &&
> +			test_must_fail git multi-pack-index write --bitmap 2>err &&
> +			grep "doesn.t have full closure" err &&
> +			test_path_is_missing $midx
> +		)
> +	'
>
> -		# Write a MIDX and bitmap; remove the MIDX but leave the bitmap.
> -		stale_bitmap=3D$midx-$(midx_checksum $objdir).bitmap &&
> -		rm $midx &&
> +	midx_bitmap_partial_tests
>
> -		# Then write a new MIDX.
> -		test_commit new &&
> -		git repack &&
> -		git multi-pack-index write --bitmap &&
> +	test_expect_success 'removing a MIDX clears stale bitmaps' '
> +		rm -fr repo &&
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
> +			test_commit base &&
> +			git repack &&
> +			git multi-pack-index write --bitmap &&
> +
> +			# Write a MIDX and bitmap; remove the MIDX but leave the bitmap.
> +			stale_bitmap=3D$midx-$(midx_checksum $objdir).bitmap &&
> +			rm $midx &&
> +
> +			# Then write a new MIDX.
> +			test_commit new &&
> +			git repack &&
> +			git multi-pack-index write --bitmap &&
> +
> +			test_path_is_file $midx &&
> +			test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
> +			test_path_is_missing $stale_bitmap
> +		)
> +	'
>
> -		test_path_is_file $midx &&
> -		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
> -		test_path_is_missing $stale_bitmap
> -	)
> -'
> +	test_expect_success 'pack.preferBitmapTips' '
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
>
> -test_expect_success 'pack.preferBitmapTips' '
> -	git init repo &&
> -	test_when_finished "rm -fr repo" &&
> -	(
> -		cd repo &&
> +			test_commit_bulk --message=3D"%s" 103 &&
>
> -		test_commit_bulk --message=3D"%s" 103 &&
> +			git log --format=3D"%H" >commits.raw &&
> +			sort <commits.raw >commits &&
>
> -		git log --format=3D"%H" >commits.raw &&
> -		sort <commits.raw >commits &&
> +			git log --format=3D"create refs/tags/%s %H" HEAD >refs &&
> +			git update-ref --stdin <refs &&
>
> -		git log --format=3D"create refs/tags/%s %H" HEAD >refs &&
> -		git update-ref --stdin <refs &&
> +			git multi-pack-index write --bitmap &&
> +			test_path_is_file $midx &&
> +			test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
>
> -		git multi-pack-index write --bitmap &&
> -		test_path_is_file $midx &&
> -		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
> +			test-tool bitmap list-commits | sort >bitmaps &&
> +			comm -13 bitmaps commits >before &&
> +			test_line_count =3D 1 before &&
>
> -		test-tool bitmap list-commits | sort >bitmaps &&
> -		comm -13 bitmaps commits >before &&
> -		test_line_count =3D 1 before &&
> +			perl -ne "printf(\"create refs/tags/include/%d \", $.); print" \
> +				<before | git update-ref --stdin &&
>
> -		perl -ne "printf(\"create refs/tags/include/%d \", $.); print" \
> -			<before | git update-ref --stdin &&
> +			rm -fr $midx-$(midx_checksum $objdir).bitmap &&
> +			rm -fr $midx &&
>
> -		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
> -		rm -fr $midx &&
> +			git -c pack.preferBitmapTips=3Drefs/tags/include \
> +				multi-pack-index write --bitmap &&
> +			test-tool bitmap list-commits | sort >bitmaps &&
> +			comm -13 bitmaps commits >after &&
>
> -		git -c pack.preferBitmapTips=3Drefs/tags/include \
> -			multi-pack-index write --bitmap &&
> -		test-tool bitmap list-commits | sort >bitmaps &&
> -		comm -13 bitmaps commits >after &&
> +			! test_cmp before after
> +		)
> +	'
>
> -		! test_cmp before after
> -	)
> -'
> +	test_expect_success 'writing a bitmap with --refs-snapshot' '
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
>
> -test_expect_success 'writing a bitmap with --refs-snapshot' '
> -	git init repo &&
> -	test_when_finished "rm -fr repo" &&
> -	(
> -		cd repo &&
> +			test_commit one &&
> +			test_commit two &&
>
> -		test_commit one &&
> -		test_commit two &&
> +			git rev-parse one >snapshot &&
>
> -		git rev-parse one >snapshot &&
> +			git repack -ad &&
>
> -		git repack -ad &&
> +			# First, write a MIDX which see both refs/tags/one and
> +			# refs/tags/two (causing both of those commits to receive
> +			# bitmaps).
> +			git multi-pack-index write --bitmap &&
>
> -		# First, write a MIDX which see both refs/tags/one and
> -		# refs/tags/two (causing both of those commits to receive
> -		# bitmaps).
> -		git multi-pack-index write --bitmap &&
> +			test_path_is_file $midx &&
> +			test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
>
> -		test_path_is_file $midx &&
> -		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
> +			test-tool bitmap list-commits | sort >bitmaps &&
> +			grep "$(git rev-parse one)" bitmaps &&
> +			grep "$(git rev-parse two)" bitmaps &&
>
> -		test-tool bitmap list-commits | sort >bitmaps &&
> -		grep "$(git rev-parse one)" bitmaps &&
> -		grep "$(git rev-parse two)" bitmaps &&
> +			rm -fr $midx-$(midx_checksum $objdir).bitmap &&
> +			rm -fr $midx &&
>
> -		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
> -		rm -fr $midx &&
> +			# Then again, but with a refs snapshot which only sees
> +			# refs/tags/one.
> +			git multi-pack-index write --bitmap --refs-snapshot=3Dsnapshot &&
>
> -		# Then again, but with a refs snapshot which only sees
> -		# refs/tags/one.
> -		git multi-pack-index write --bitmap --refs-snapshot=3Dsnapshot &&
> +			test_path_is_file $midx &&
> +			test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
>
> -		test_path_is_file $midx &&
> -		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
> +			test-tool bitmap list-commits | sort >bitmaps &&
> +			grep "$(git rev-parse one)" bitmaps &&
> +			! grep "$(git rev-parse two)" bitmaps
> +		)
> +	'
>
> -		test-tool bitmap list-commits | sort >bitmaps &&
> -		grep "$(git rev-parse one)" bitmaps &&
> -		! grep "$(git rev-parse two)" bitmaps
> -	)
> -'
> +	test_expect_success 'write a bitmap with --refs-snapshot (preferred ti=
ps)' '
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
>
> -test_expect_success 'write a bitmap with --refs-snapshot (preferred tip=
s)' '
> -	git init repo &&
> -	test_when_finished "rm -fr repo" &&
> -	(
> -		cd repo &&
> +			test_commit_bulk --message=3D"%s" 103 &&
>
> -		test_commit_bulk --message=3D"%s" 103 &&
> +			git log --format=3D"%H" >commits.raw &&
> +			sort <commits.raw >commits &&
>
> -		git log --format=3D"%H" >commits.raw &&
> -		sort <commits.raw >commits &&
> +			git log --format=3D"create refs/tags/%s %H" HEAD >refs &&
> +			git update-ref --stdin <refs &&
>
> -		git log --format=3D"create refs/tags/%s %H" HEAD >refs &&
> -		git update-ref --stdin <refs &&
> +			git multi-pack-index write --bitmap &&
> +			test_path_is_file $midx &&
> +			test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
>
> -		git multi-pack-index write --bitmap &&
> -		test_path_is_file $midx &&
> -		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
> +			test-tool bitmap list-commits | sort >bitmaps &&
> +			comm -13 bitmaps commits >before &&
> +			test_line_count =3D 1 before &&
>
> -		test-tool bitmap list-commits | sort >bitmaps &&
> -		comm -13 bitmaps commits >before &&
> -		test_line_count =3D 1 before &&
> +			(
> +				grep -vf before commits.raw &&
> +				# mark missing commits as preferred
> +				sed "s/^/+/" before
> +			) >snapshot &&
>
> +			rm -fr $midx-$(midx_checksum $objdir).bitmap &&
> +			rm -fr $midx &&
> +
> +			git multi-pack-index write --bitmap --refs-snapshot=3Dsnapshot &&
> +			test-tool bitmap list-commits | sort >bitmaps &&
> +			comm -13 bitmaps commits >after &&
> +
> +			! test_cmp before after
> +		)
> +	'
> +
> +	test_expect_success 'hash-cache values are propagated from pack bitmap=
s' '
> +		rm -fr repo &&
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
>  		(
> -			grep -vf before commits.raw &&
> -			# mark missing commits as preferred
> -			sed "s/^/+/" before
> -		) >snapshot &&
> +			cd repo &&
> +			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
>
> -		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
> -		rm -fr $midx &&
> +			test_commit base &&
> +			test_commit base2 &&
> +			git repack -adb &&
>
> -		git multi-pack-index write --bitmap --refs-snapshot=3Dsnapshot &&
> -		test-tool bitmap list-commits | sort >bitmaps &&
> -		comm -13 bitmaps commits >after &&
> +			test-tool bitmap dump-hashes >pack.raw &&
> +			test_file_not_empty pack.raw &&
> +			sort pack.raw >pack.hashes &&
>
> -		! test_cmp before after
> -	)
> -'
> +			test_commit new &&
> +			git repack &&
> +			git multi-pack-index write --bitmap &&
>
> -test_expect_success 'hash-cache values are propagated from pack bitmaps=
' '
> -	rm -fr repo &&
> -	git init repo &&
> -	test_when_finished "rm -fr repo" &&
> -	(
> -		cd repo &&
> +			test-tool bitmap dump-hashes >midx.raw &&
> +			sort midx.raw >midx.hashes &&
>
> -		test_commit base &&
> -		test_commit base2 &&
> -		git repack -adb &&
> +			# ensure that every namehash in the pack bitmap can be found in
> +			# the midx bitmap (i.e., that there are no oid-namehash pairs
> +			# unique to the pack bitmap).
> +			comm -23 pack.hashes midx.hashes >dropped.hashes &&
> +			test_must_be_empty dropped.hashes
> +		)
> +	'
>
> -		test-tool bitmap dump-hashes >pack.raw &&
> -		test_file_not_empty pack.raw &&
> -		sort pack.raw >pack.hashes &&
> +	test_expect_success 'no .bitmap is written without any objects' '
> +		rm -fr repo &&
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
>
> -		test_commit new &&
> -		git repack &&
> -		git multi-pack-index write --bitmap &&
> +			empty=3D"$(git pack-objects $objdir/pack/pack </dev/null)" &&
> +			cat >packs <<-EOF &&
> +			pack-$empty.idx
> +			EOF
>
> -		test-tool bitmap dump-hashes >midx.raw &&
> -		sort midx.raw >midx.hashes &&
> +			git multi-pack-index write --bitmap --stdin-packs \
> +				<packs 2>err &&
>
> -		# ensure that every namehash in the pack bitmap can be found in
> -		# the midx bitmap (i.e., that there are no oid-namehash pairs
> -		# unique to the pack bitmap).
> -		comm -23 pack.hashes midx.hashes >dropped.hashes &&
> -		test_must_be_empty dropped.hashes
> -	)
> -'
> +			grep "bitmap without any objects" err &&
>
> -test_expect_success 'no .bitmap is written without any objects' '
> -	rm -fr repo &&
> -	git init repo &&
> -	test_when_finished "rm -fr repo" &&
> -	(
> -		cd repo &&
> +			test_path_is_file $midx &&
> +			test_path_is_missing $midx-$(midx_checksum $objdir).bitmap
> +		)
> +	'
> +
> +	test_expect_success 'graceful fallback when missing reverse index' '
> +		rm -fr repo &&
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
>
> -		empty=3D"$(git pack-objects $objdir/pack/pack </dev/null)" &&
> -		cat >packs <<-EOF &&
> -		pack-$empty.idx
> -		EOF
> +			test_commit base &&
>
> -		git multi-pack-index write --bitmap --stdin-packs \
> -			<packs 2>err &&
> +			# write a pack and MIDX bitmap containing base
> +			git repack -adb &&
> +			git multi-pack-index write --bitmap &&
>
> -		grep "bitmap without any objects" err &&
> +			GIT_TEST_MIDX_READ_RIDX=3D0 \
> +				git rev-list --use-bitmap-index HEAD 2>err &&
> +			! grep "ignoring extra bitmap file" err
> +		)
> +	'
> +}
>
> -		test_path_is_file $midx &&
> -		test_path_is_missing $midx-$(midx_checksum $objdir).bitmap
> -	)
> -'
> +test_midx_bitmap_cases
> +
> +test_midx_bitmap_cases "pack.writeBitmapLookupTable"
>
> -test_expect_success 'graceful fallback when missing reverse index' '
> +test_expect_success 'multi-pack-index write writes lookup table if enab=
led' '
>  	rm -fr repo &&
>  	git init repo &&
>  	test_when_finished "rm -fr repo" &&
>  	(
>  		cd repo &&
> -
>  		test_commit base &&
> -
> -		# write a pack and MIDX bitmap containing base
> -		git repack -adb &&
> -		git multi-pack-index write --bitmap &&
> -
> -		GIT_TEST_MIDX_READ_RIDX=3D0 \
> -			git rev-list --use-bitmap-index HEAD 2>err &&
> -		! grep "ignoring extra bitmap file" err
> +		git config pack.writeBitmapLookupTable true &&
> +		git repack -ad &&
> +		GIT_TRACE2_EVENT=3D"$(pwd)/trace" \
> +			git multi-pack-index write --bitmap &&
> +		grep "\"label\":\"writing_lookup_table\"" trace
>  	)
>  '
>
> diff --git a/t/t5327-multi-pack-bitmaps-rev.sh b/t/t5327-multi-pack-bitm=
aps-rev.sh
> index d30ba632c87..5ed16a820d1 100755
> --- a/t/t5327-multi-pack-bitmaps-rev.sh
> +++ b/t/t5327-multi-pack-bitmaps-rev.sh
> @@ -17,7 +17,27 @@ GIT_TEST_MIDX_READ_RIDX=3D0
>  export GIT_TEST_MIDX_WRITE_REV
>  export GIT_TEST_MIDX_READ_RIDX
>
> -midx_bitmap_core rev
> -midx_bitmap_partial_tests rev
> +test_midx_bitmap_rev () {
> +     writeLookupTable=3Dfalse
> +
> + 	for i in "$@"
> + 	do
> + 		case $i in
> + 		"pack.writeBitmapLookupTable") writeLookupTable=3Dtrue;;
> + 		esac
> + 	done
> +
> +     test_expect_success 'setup bitmap config' '
> +         rm -rf * .git &&
> +         git init &&
> +         git config pack.writeBitmapLookupTable '"$writeLookupTable"'
> +     '
> +
> +     midx_bitmap_core rev
> +     midx_bitmap_partial_tests rev
> + }
> +
> + test_midx_bitmap_rev
> + test_midx_bitmap_rev "pack.writeBitmapLookupTable"
>
>  test_done
> --
> gitgitgadget
>
>
>
