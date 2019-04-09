Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5911B20248
	for <e@80x24.org>; Tue,  9 Apr 2019 15:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDIPKs (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 11:10:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32954 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfDIPKs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 11:10:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id b8so1779315edq.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bR1GND7LWtjy4Am+rm8QtM3bYLY81Xtj2nUdSe7G2YE=;
        b=CYmskW0qvzdoK/5wpx7O3n+FgG1k6hfwU3JmU27GPvCQd0SeStYEJCSkBRAqFsHowF
         Q46XJeTH+nMJNwSt0IRMppiZljlmEnhqmoObI/DHLBaJ3kcI4MKYH/3SwVwQJZERCqFv
         dX4eawPef5ZktDACv9sByJkNKbToUkRoeqGKv/+xtplvEX62SE7Byx386DnuA35/UAp2
         tB2MVWfBQYRY3ox/wByTaZrOfDeMDVaLoVb8LiyCACqqbbb56EZ9z8EZ7gyhfad7hqMZ
         GIR0DEaIG3SQrgfrwZd8KJFgIUkbO1oiY3AylC51P8msrKmyyYCqodGVbGqAfYtn/XXw
         KNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=bR1GND7LWtjy4Am+rm8QtM3bYLY81Xtj2nUdSe7G2YE=;
        b=kbJAoxakEGsGcCeiSjHejcDlMW2XpfIFiqqCw4oru6MIMTyNl8FI1VqCET+IFJfV5H
         Y8hVPOc4tShVq7cIZ8gY9v8U4qO2+GeBGx8pBeLvdXX8s3CqyrDgWRVwRlF7e2Foj2HK
         UryO2r6e/bKCCiaRZND2blnU3iXoMVnaZHIIXm12tqBhmTZvN1AdaMs3u71tEjxjLu90
         8KOid7Z9yIUBfxrdZA7i/ihlPqwTjU8slqcbrxIdQKL7vRtz4ZtJuAMi70JPzA8MGHkR
         SQK5y66BD0ti9xSt/o44tKzWapD7wJjPBy3BV4oZPZJ254vjQwKwvpU7h0HphFUyzKZt
         Swig==
X-Gm-Message-State: APjAAAU5nnHv2U+SJO5lrxJQVPvfJQC+IAw95UZ8lhLhG8WetHd4PT3t
        qYX8Bvb+VWllx2N29X+ZeHk=
X-Google-Smtp-Source: APXvYqzph+pqfutwz2YN5AZZVwULBJREiLyQtLV8BxfB+t4QZ4b6hKaB8hUv1bFqjXn7Zfq5dvOkhQ==
X-Received: by 2002:aa7:c589:: with SMTP id g9mr6395080edq.247.1554822645731;
        Tue, 09 Apr 2019 08:10:45 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id a25sm1087095edr.94.2019.04.09.08.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 08:10:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
References: <20190214043127.GA19019@sigill.intra.peff.net> <20190214043743.GB19183@sigill.intra.peff.net> <20190309024944.zcbwgvn52jsw2a2e@dcvr> <20190310233956.GB3059@sigill.intra.peff.net> <20190312031303.5tutut7zzvxne5dw@dcvr> <20190312104954.GA2023@sigill.intra.peff.net> <20190313015133.n7f7lyujnlwfytre@dcvr> <20190313145417.GA24101@sigill.intra.peff.net> <20190314091254.nescpfp3n6mbjpmh@dcvr>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190314091254.nescpfp3n6mbjpmh@dcvr>
Date:   Tue, 09 Apr 2019 17:10:43 +0200
Message-ID: <87zhoz8b9o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 14 2019, Eric Wong wrote:

> Jeff King <peff@peff.net> wrote:
>> On Wed, Mar 13, 2019 at 01:51:33AM +0000, Eric Wong wrote:
>>
>> > But I did find =C3=86var's forgotten gitperformance doc and thread
>> > where the topic was brought up:
>> >
>> >   https://public-inbox.org/git/20170403211644.26814-1-avarab@gmail.com/
>>
>> One thing that thread reminded me of: we probably also want to default
>> pack.writebitmaphashcache on. Otherwise the time saved during the object
>> enumeration can backfire when we spend much more time trying delta
>> compression (because we don't know the pathnames of any objects).
>
> Interesting...  I found a big improvement with public-inbox
> just using bitmaps; but have never tried the hash cache.
>
>> The reason it defaults to off is for on-disk compatibility with JGit.
>
> Right.  Our documentation seems to indicate JGit just warns (but
> doesn't fall over), so maybe that can be considered separately.
>
> I've never used JGit myself; and was satisfied enough with
> bitmaps alone that I never tried the hash-cache.
>
>> But I have very little experience running without the hash-cache on. We
>> added it very early on because we found performance was not great
>> without it (I don't know if people running JGit have run into the same
>> problem and if not, why not).
>
> As far as serving clones and fetches, public-inbox-init has
> always created bare repos with bitmaps enabled, but without
> the hash-cache for compatibility concerns.
>
> That's a lot of fetches and clones over the years.
>
>> > +test_expect_success 'incremental repack does not complain' '
>> > +	git -C bare.git repack -q 2>repack.err &&
>> > +	! test -s repack.err
>> > +'
>>
>> This last line could use "test_must_be_empty".
>
> Thanks for the review!
>
> ---------8<-----------
> Subject: [PATCH] repack: enable bitmaps by default on bare repos
>
> A typical use case for bare repos is for serving clones and
> fetches to clients.  Enable bitmaps by default on bare repos to
> make it easier for admins to host git repos in a performant way.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> Helped-by: Jeff King <peff@peff.net>
> ---
>  Documentation/config/repack.txt |  2 +-
>  builtin/repack.c                |  5 ++++-
>  t/t7700-repack.sh               | 19 ++++++++++++++++++-
>  3 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config/repack.txt b/Documentation/config/repac=
k.txt
> index a5c37813fd..9c413e177e 100644
> --- a/Documentation/config/repack.txt
> +++ b/Documentation/config/repack.txt
> @@ -24,4 +24,4 @@ repack.writeBitmaps::
>  	packs created for clones and fetches, at the cost of some disk
>  	space and extra time spent on the initial repack.  This has
>  	no effect if multiple packfiles are created.
> -	Defaults to false.
> +	Defaults to true on bare repos, false otherwise.
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 67f8978043..caca113927 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -14,7 +14,7 @@
>
>  static int delta_base_offset =3D 1;
>  static int pack_kept_objects =3D -1;
> -static int write_bitmaps;
> +static int write_bitmaps =3D -1;
>  static int use_delta_islands;
>  static char *packdir, *packtmp;
>
> @@ -343,6 +343,9 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix)
>  	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
>  		die(_("--keep-unreachable and -A are incompatible"));
>
> +	if (write_bitmaps < 0)
> +		write_bitmaps =3D (pack_everything & ALL_INTO_ONE) &&
> +				 is_bare_repository();
>  	if (pack_kept_objects < 0)
>  		pack_kept_objects =3D write_bitmaps;
>
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 6162e2a8e6..86d05160a3 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -221,5 +221,22 @@ test_expect_success 'repack --keep-pack' '
>  	)
>  '
>
> -test_done
> +test_expect_success 'bitmaps are created by default in bare repos' '
> +	git clone --bare .git bare.git &&
> +	git -C bare.git repack -ad &&
> +	bitmap=3D$(ls bare.git/objects/pack/*.bitmap) &&
> +	test_path_is_file "$bitmap"
> +'
> +
> +test_expect_success 'incremental repack does not complain' '
> +	git -C bare.git repack -q 2>repack.err &&
> +	test_must_be_empty repack.err
> +'
>
> +test_expect_success 'bitmaps can be disabled on bare repos' '
> +	git -c repack.writeBitmaps=3Dfalse -C bare.git repack -ad &&
> +	bitmap=3D$(ls bare.git/objects/pack/*.bitmap 2>/dev/null || :) &&
> +	test -z "$bitmap"
> +'
> +
> +test_done

I've found a case where turning bitmaps on does horrible things for
bitmap "push" performance.

As it turns out it's not related to this patch per-se, because I had a
*.bitmap for other reasons, but replying to this because we'd presumably
get the same thing in the bare repo case once this merges down.

I can't share the repo, but I had a report where just a "git push" of a
topic branch that was 2/58 ahead/behind took ~2 minutes just in
"Enumerating objects", but ~500ms without bitmaps.

Using a horrible "print to stderr"[1] monkeypatch I'd get without
bitmaps and reported by trace2 / ts:

    Apr 09 16:45:15 16:45:15.365817 git.c:433                         | d1 =
| main                     | cmd_name     |     |           |           |  =
          | pack-objects (push/pack-objects)
    Apr 09 16:45:15 16:45:15.366220 builtin/pack-objects.c:3493       | d1 =
| main                     | region_enter | r1  |  0.000928 |           | p=
ack-objects | label:enumerate-objects
    Apr 09 16:45:15 16:45:15.366241 builtin/pack-objects.c:3495       | d1 =
| main                     | region_enter | r1  |  0.000950 |           | p=
ack-objects | ..label:enumerate-objects-prepare-packing-data
    Apr 09 16:45:15 16:45:15.366384 builtin/pack-objects.c:3498       | d1 =
| main                     | region_leave | r1  |  0.001091 |  0.000141 | p=
ack-objects | ..label:enumerate-objects-prepare-packing-data
    Apr 09 16:45:15 16:45:15.366394 builtin/pack-objects.c:3510       | d1 =
| main                     | region_enter | r1  |  0.001102 |           | p=
ack-objects | ..label:enumerate-objects-get-obj-list
    Apr 09 16:45:15 get obj list 1
    Apr 09 16:45:15 get obj list 2, did 29391 lines
    Apr 09 16:45:15 get obj list 3
    Apr 09 16:45:15 get obj list 4
    Apr 09 16:45:15 get obj list 5
    Apr 09 16:45:15 get obj list 6
    Apr 09 16:45:15 get obj list 7
    Apr 09 16:45:15 get obj list 8
    Apr 09 16:45:15 get obj list 9
    Apr 09 16:45:15 16:45:15.776559 builtin/pack-objects.c:3514       | d1 =
| main                     | region_leave | r1  |  0.411263 |  0.410161 | p=
ack-objects | ..label:enumerate-objects-get-obj-list
    Apr 09 16:45:15 16:45:15.776577 builtin/pack-objects.c:3517       | d1 =
| main                     | region_enter | r1  |  0.411285 |           | p=
ack-objects | ..label:enumerate-objects-cleanup-preferred-base
    Apr 09 16:45:15 16:45:15.776584 builtin/pack-objects.c:3520       | d1 =
| main                     | region_leave | r1  |  0.411292 |  0.000007 | p=
ack-objects | ..label:enumerate-objects-cleanup-preferred-base
    Apr 09 16:45:15 16:45:15.776605 builtin/pack-objects.c:3530       | d1 =
| main                     | region_leave | r1  |  0.411313 |  0.410385 | p=
ack-objects | label:enumerate-objects
    Apr 09 16:45:15 16:45:15.776609 builtin/pack-objects.c:3542       | d1 =
| main                     | region_enter | r1  |  0.411318 |           | p=
ack-objects | label:write-pack-file
    Apr 09 16:45:15 16:45:15.794235 builtin/pack-objects.c:3544       | d1 =
| main                     | region_leave | r1  |  0.428942 |  0.017624 | p=
ack-objects | label:write-pack-file

But with pack.useBitmaps=3Dtrue:

    Apr 09 16:39:59 16:39:59.139022 git.c:433                         | d1 =
| main                     | cmd_name     |     |           |           |  =
          | pack-objects (push/pack-objects)
    Apr 09 16:39:59 16:39:59.139398 builtin/pack-objects.c:3493       | d1 =
| main                     | region_enter | r1  |  0.000869 |           | p=
ack-objects | label:enumerate-objects
    Apr 09 16:39:59 16:39:59.139419 builtin/pack-objects.c:3495       | d1 =
| main                     | region_enter | r1  |  0.000892 |           | p=
ack-objects | ..label:enumerate-objects-prepare-packing-data
    Apr 09 16:39:59 16:39:59.139551 builtin/pack-objects.c:3498       | d1 =
| main                     | region_leave | r1  |  0.001023 |  0.000131 | p=
ack-objects | ..label:enumerate-objects-prepare-packing-data
    Apr 09 16:39:59 16:39:59.139559 builtin/pack-objects.c:3510       | d1 =
| main                     | region_enter | r1  |  0.001032 |           | p=
ack-objects | ..label:enumerate-objects-get-obj-list
    Apr 09 16:39:59 get obj list 1
    Apr 09 16:39:59 get obj list 2, did 29392 lines
    Apr 09 16:39:59 get obj list 3
    Apr 09 16:39:59 prepping walk
    Apr 09 16:39:59 opening packed bitmap...
    Apr 09 16:39:59 opening packed bitmap done
    Apr 09 16:39:59 walking 29392 pending
    Apr 09 16:39:59 done walking 29392 pending
    Apr 09 16:39:59 prepare_bitmap_walk 3
    Apr 09 16:39:59 prepare_bitmap_walk 4
    Apr 09 16:39:59 prepare_bitmap_walk 5
    Apr 09 16:40:00 prepare_bitmap_walk 6
    Apr 09 16:40:00 prepare_bitmap_walk 6.1
    Apr 09 16:41:35 prepare_bitmap_walk 6.2
    Apr 09 16:41:35 prepare_bitmap_walk 7
    Apr 09 16:41:52 prepare_bitmap_walk 8
    Apr 09 16:41:52 walking?
    Apr 09 16:41:52 traversing
    Apr 09 16:41:52 traversing done
    Apr 09 16:41:52 16:41:52.091634 builtin/pack-objects.c:3514       | d1 =
| main                     | region_leave | r1  | 112.953099 | 112.952067 |=
 pack-objects | ..label:enumerate-objects-get-obj-list
    Apr 09 16:41:52 16:41:52.091655 builtin/pack-objects.c:3517       | d1 =
| main                     | region_enter | r1  | 112.953128 |           | =
pack-objects | ..label:enumerate-objects-cleanup-preferred-base
    Apr 09 16:41:52 16:41:52.091668 builtin/pack-objects.c:3520       | d1 =
| main                     | region_leave | r1  | 112.953141 |  0.000013 | =
pack-objects | ..label:enumerate-objects-cleanup-preferred-base
    Apr 09 16:41:52 16:41:52.091700 builtin/pack-objects.c:3530       | d1 =
| main                     | region_leave | r1  | 112.953172 | 112.952303 |=
 pack-objects | label:enumerate-objects
    Apr 09 16:41:52 16:41:52.091706 builtin/pack-objects.c:3542       | d1 =
| main                     | region_enter | r1  | 112.953179 |           | =
pack-objects | label:write-pack-file
    Apr 09 16:41:52 16:41:52.111966 builtin/pack-objects.c:3544       | d1 =
| main                     | region_leave | r1  | 112.973438 |  0.020259 | =
pack-objects | label:write-pack-file

I.e. almost all the time is in get_object_list_from_bitmap() and around
1m30s in just this in pack-bitmap.c:

    haves_bitmap =3D find_objects(bitmap_git, revs, haves, NULL);

And then another ~20s in:

    wants_bitmap =3D find_objects(bitmap_git, revs, wants, haves_bitmap);

This is with 10 packs and where only the largest (initial clone pack)
had a *.bitmap, but I can also reproduce with a 'git repack -A -d -b',
i.e. with only one pack with a *.bitmap, although that makes it a bit
better for the first bit, and almost completely cuts down on the time
spent in the second phase:

    Apr 09 17:08:37 17:08:37.261507 builtin/pack-objects.c:3493       | d1 =
| main                     | region_enter | r1  |  0.000922 |           | p=
ack-objects | label:enumerate-objects
    Apr 09 17:08:37 17:08:37.261527 builtin/pack-objects.c:3495       | d1 =
| main                     | region_enter | r1  |  0.000943 |           | p=
ack-objects | ..label:enumerate-objects-prepare-packing-data
    Apr 09 17:08:37 17:08:37.261600 builtin/pack-objects.c:3498       | d1 =
| main                     | region_leave | r1  |  0.001015 |  0.000072 | p=
ack-objects | ..label:enumerate-objects-prepare-packing-data
    Apr 09 17:08:37 17:08:37.261608 builtin/pack-objects.c:3510       | d1 =
| main                     | region_enter | r1  |  0.001024 |           | p=
ack-objects | ..label:enumerate-objects-get-obj-list
    Apr 09 17:08:37 get obj list 1
    Apr 09 17:08:37 get obj list 2, did 29380 lines
    Apr 09 17:08:37 get obj list 3
    Apr 09 17:08:37 prepping walk
    Apr 09 17:08:37 opening packed bitmap...
    Apr 09 17:08:37 opening packed bitmap done
    Apr 09 17:08:37 walking 29380 pending
    Apr 09 17:08:37 done walking 29380 pending
    Apr 09 17:08:37 prepare_bitmap_walk 3
    Apr 09 17:08:37 prepare_bitmap_walk 4
    Apr 09 17:08:37 prepare_bitmap_walk 5
    Apr 09 17:08:38 prepare_bitmap_walk 6
    Apr 09 17:08:38 prepare_bitmap_walk 6.1
    Apr 09 17:09:07 prepare_bitmap_walk 6.2
    Apr 09 17:09:07 prepare_bitmap_walk 7
    Apr 09 17:09:09 prepare_bitmap_walk 8
    Apr 09 17:09:09 walking?
    Apr 09 17:09:09 traversing
    Apr 09 17:09:09 traversing done
    Apr 09 17:09:09 17:09:09.229185 builtin/pack-objects.c:3514       | d1 =
| main                     | region_leave | r1  | 31.968595 | 31.967571 | p=
ack-objects | ..label:enumerate-objects-get-obj-list
    Apr 09 17:09:09 17:09:09.229203 builtin/pack-objects.c:3517       | d1 =
| main                     | region_enter | r1  | 31.968619 |           | p=
ack-objects | ..label:enumerate-objects-cleanup-preferred-base
    Apr 09 17:09:09 17:09:09.229214 builtin/pack-objects.c:3520       | d1 =
| main                     | region_leave | r1  | 31.968630 |  0.000011 | p=
ack-objects | ..label:enumerate-objects-cleanup-preferred-base
    Apr 09 17:09:09 17:09:09.229242 builtin/pack-objects.c:3530       | d1 =
| main                     | region_leave | r1  | 31.968658 | 31.967736 | p=
ack-objects | label:enumerate-objects
    Apr 09 17:09:09 17:09:09.229265 builtin/pack-objects.c:3542       | d1 =
| main                     | region_enter | r1  | 31.968681 |           | p=
ack-objects | label:write-pack-file
    Apr 09 17:09:09 17:09:09.251998 builtin/pack-objects.c:3544       | d1 =
| main                     | region_leave | r1  | 31.991412 |  0.022731 | p=
ack-objects | label:write-pack-file

I don't have time to dig more into this now, just wanted to send these
initial results...

1.



    diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
    index a154fc29f6..8b2af1740e 100644
    --- a/builtin/pack-objects.c
    +++ b/builtin/pack-objects.c
    @@ -3052,2 +3052,3 @@ static int get_object_list_from_bitmap(struct rev=
_info *revs)
     {
    +	fprintf(stderr, "prepping walk\n");
     	if (!(bitmap_git =3D prepare_bitmap_walk(revs)))
    @@ -3055,2 +3056,3 @@ static int get_object_list_from_bitmap(struct rev=
_info *revs)

    +	fprintf(stderr, "walking?\n");
     	if (pack_options_allow_reuse() &&
    @@ -3066,3 +3068,5 @@ static int get_object_list_from_bitmap(struct rev=
_info *revs)

    +	fprintf(stderr, "traversing\n");
     	traverse_bitmap_commit_list(bitmap_git, &add_object_entry_from_bitmap=
);
    +	fprintf(stderr, "traversing done\n");
     	return 0;
    @@ -3091,2 +3095,3 @@ static void get_object_list(int ac, const char **=
av)
     	int save_warning;
    +	int lns =3D 0;

    @@ -3102,3 +3107,5 @@ static void get_object_list(int ac, const char **=
av)

    +	fprintf(stderr, "get obj list 1\n");
     	while (fgets(line, sizeof(line), stdin) !=3D NULL) {
    +		lns++;
     		int len =3D strlen(line);
    @@ -3128,4 +3135,6 @@ static void get_object_list(int ac, const char **=
av)

    +	fprintf(stderr, "get obj list 2, did %d lines\n", lns);
     	warn_on_object_refname_ambiguity =3D save_warning;

    +	fprintf(stderr, "get obj list 3\n");
     	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
    @@ -3133,2 +3142,3 @@ static void get_object_list(int ac, const char **=
av)

    +	fprintf(stderr, "get obj list 4\n");
     	if (use_delta_islands)
    @@ -3136,2 +3146,3 @@ static void get_object_list(int ac, const char **=
av)

    +	fprintf(stderr, "get obj list 5\n");
     	if (prepare_revision_walk(&revs))
    @@ -3140,2 +3151,3 @@ static void get_object_list(int ac, const char **=
av)

    +	fprintf(stderr, "get obj list 6\n");
     	if (!fn_show_object)
    @@ -3146,2 +3158,3 @@ static void get_object_list(int ac, const char **=
av)

    +	fprintf(stderr, "get obj list 7\n");
     	if (unpack_unreachable_expiration) {
    @@ -3157,2 +3170,3 @@ static void get_object_list(int ac, const char **=
av)

    +	fprintf(stderr, "get obj list 8\n");
     	if (keep_unreachable)
    @@ -3163,2 +3177,3 @@ static void get_object_list(int ac, const char **=
av)
     		loosen_unused_packed_objects(&revs);
    +	fprintf(stderr, "get obj list 9\n");

    @@ -3478,3 +3493,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
     			    the_repository);
    +	trace2_region_enter("pack-objects", "enumerate-objects-prepare-packin=
g-data",
    +			    the_repository);
     	prepare_packing_data(the_repository, &to_pack);
    +	trace2_region_leave("pack-objects", "enumerate-objects-prepare-packin=
g-data",
    +			    the_repository);

    @@ -3482,11 +3501,28 @@ int cmd_pack_objects(int argc, const char **arg=
v, const char *prefix)
     		progress_state =3D start_progress(_("Enumerating objects"), 0);
    -	if (!use_internal_rev_list)
    +	if (!use_internal_rev_list) {
    +		trace2_region_enter("pack-objects", "enumerate-objects-read-stdin",
    +				    the_repository);
     		read_object_list_from_stdin();
    -	else {
    +		trace2_region_leave("pack-objects", "enumerate-objects-read-stdin",
    +				    the_repository);
    +	} else {
    +		trace2_region_enter("pack-objects", "enumerate-objects-get-obj-list",
    +				    the_repository);
     		get_object_list(rp.argc, rp.argv);
     		argv_array_clear(&rp);
    +		trace2_region_leave("pack-objects", "enumerate-objects-get-obj-list",
    +				    the_repository);
     	}
    +	trace2_region_enter("pack-objects", "enumerate-objects-cleanup-prefer=
red-base",
    +			    the_repository);
     	cleanup_preferred_base();
    -	if (include_tag && nr_result)
    +	trace2_region_leave("pack-objects", "enumerate-objects-cleanup-prefer=
red-base",
    +			    the_repository);
    +	if (include_tag && nr_result) {
    +		trace2_region_enter("pack-objects", "enumerate-objects-add-tags",
    +				    the_repository);
     		for_each_ref(add_ref_tag, NULL);
    +		trace2_region_leave("pack-objects", "enumerate-objects-add-tags",
    +				    the_repository);
    +	}
     	stop_progress(&progress_state);
    diff --git a/pack-bitmap.c b/pack-bitmap.c
    index 4695aaf6b4..0ab71597fd 100644
    --- a/pack-bitmap.c
    +++ b/pack-bitmap.c
    @@ -693,5 +693,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev=
_info *revs)
     	 * because we may not need to use it */
    +	fprintf(stderr, "opening packed bitmap...\n");
     	if (open_pack_bitmap(revs->repo, bitmap_git) < 0)
     		goto cleanup;
    +	fprintf(stderr, "opening packed bitmap done\n");

    +	fprintf(stderr, "walking %d pending\n", revs->pending.nr);
     	for (i =3D 0; i < revs->pending.nr; ++i) {
    @@ -720,2 +723,3 @@ struct bitmap_index *prepare_bitmap_walk(struct rev=
_info *revs)
     	}
    +	fprintf(stderr, "done walking %d pending\n", revs->pending.nr);

    @@ -726,2 +730,3 @@ struct bitmap_index *prepare_bitmap_walk(struct rev=
_info *revs)
     	 */
    +	fprintf(stderr, "prepare_bitmap_walk 3\n");
     	if (haves && !in_bitmapped_pack(bitmap_git, haves))
    @@ -729,2 +734,3 @@ struct bitmap_index *prepare_bitmap_walk(struct rev=
_info *revs)

    +	fprintf(stderr, "prepare_bitmap_walk 4\n");
     	/* if we don't want anything, we're done here */
    @@ -738,2 +744,3 @@ struct bitmap_index *prepare_bitmap_walk(struct rev=
_info *revs)
     	 */
    +	fprintf(stderr, "prepare_bitmap_walk 5\n");
     	if (load_pack_bitmap(bitmap_git) < 0)
    @@ -741,2 +748,3 @@ struct bitmap_index *prepare_bitmap_walk(struct rev=
_info *revs)

    +	fprintf(stderr, "prepare_bitmap_walk 6\n");
     	object_array_clear(&revs->pending);
    @@ -745,3 +753,5 @@ struct bitmap_index *prepare_bitmap_walk(struct rev=
_info *revs)
     		revs->ignore_missing_links =3D 1;
    + 		fprintf(stderr, "prepare_bitmap_walk 6.1\n");
     		haves_bitmap =3D find_objects(bitmap_git, revs, haves, NULL);
    + 		fprintf(stderr, "prepare_bitmap_walk 6.2\n");
     		reset_revision_walk();
    @@ -752,4 +762,6 @@ struct bitmap_index *prepare_bitmap_walk(struct rev=
_info *revs)
     	}
    +	fprintf(stderr, "prepare_bitmap_walk 7\n");

     	wants_bitmap =3D find_objects(bitmap_git, revs, wants, haves_bitmap);
    +	fprintf(stderr, "prepare_bitmap_walk 8\n");

    diff --git a/revision.c b/revision.c
    index eb8e51bc63..4592d01ee7 100644
    --- a/revision.c
    +++ b/revision.c
    @@ -63,2 +63,4 @@ static void mark_tree_contents_uninteresting(struct r=
epository *r,

    +	fprintf(stderr, "MTCU\n");
    +
     	if (parse_tree_gently(tree, 1) < 0)
    @@ -167,2 +169,4 @@ static void add_children_by_path(struct repository =
*r,

    +	fprintf(stderr, "ACBP\n");
    +
     	if (!tree)
