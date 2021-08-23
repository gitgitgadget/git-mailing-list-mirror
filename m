Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0867C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 00:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF7D61354
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 00:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhHWAyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 20:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhHWAyq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 20:54:46 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A0CC061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 17:54:04 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n24so19766206ion.10
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 17:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/01mFwfrN/PFx1K7Qe5mprBBS2tGDT/NeG7cDHdkvWg=;
        b=vqRGmX6LYkBuniSzyb04gqOL1fmbRzzqQRjmtTDzBp8XxaMsOC5L+s1S5SeNh6aGy5
         jfGDXuzVpyJZmp/L+Zfpp+rGCqQF4/asB+6MqOo6/Z76awbamKjMdApII4cv/US17/a8
         RT8VPNKJ920tkl3ZS5eif90gGILDwQCHbdiVo+vDdjQefwwsM35xuRGjL03wyZ1crz48
         AZduv/L94dwyCtJBV7JMEcCwvFzNba8kSslZsTvyrvI5Z05bnA3I02PNVfD+fTmwHWk+
         picIF0EyNRGIV6WBMNQnJu4zYhC/J6i4gWdGvWBtBXuiWN4ViOQzP8EFaRqvbgkI6CVU
         1+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/01mFwfrN/PFx1K7Qe5mprBBS2tGDT/NeG7cDHdkvWg=;
        b=ez5rOqJxZpD6/RdNMtGHn1qUdB0sgCZUsJafVv/qHxsrgxMVtyaRM4ftFiQ4F1oY5G
         LJ0QJlcuN4mvH4RQnt5euOvD10RudPwKEV329ox9xzit1Toxl/KAB2l6Z3qdLvxSj0Gr
         ZnriBVmoGHFKLWwjXz4UVN6DwAjIFwdFMgrWMJHGKGl7+vV30uTSjYWk5pf8gRvQ6K57
         f0UnQMU4eeo4pURCuc/FBHe4jGNGkPXHLWY1umee2mKOzXhlRVKkJKlDxpW9T3rG/09J
         1net0cvUwg+oTDfc9Prl0t09Xhn6GrmVG3OjrUscCW4BmzB+Agkljz0hUBqldRvidwV+
         chQQ==
X-Gm-Message-State: AOAM532h9R9t1shg+sesrJHjfWihxG0DAYLJ5hmrodBKWT6ramHe1Drk
        4IqJtLC0zqQkZsyFJQ43dPVHBA==
X-Google-Smtp-Source: ABdhPJwIEdvrOBzcSmxxQTJ6FDLeSGvirQcdpmhcCJe0SS5x3gRYjYVnGRKz6u8bmZyN3q/w1EiN7w==
X-Received: by 2002:a02:cd2c:: with SMTP id h12mr27216424jaq.84.1629680043613;
        Sun, 22 Aug 2021 17:54:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q14sm7563778ilj.34.2021.08.22.17.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 17:54:03 -0700 (PDT)
Date:   Sun, 22 Aug 2021 20:54:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] multi-pack-index: fix --object-dir from outside repo
Message-ID: <YSLxqnxlyEUQ+ljJ@nand.local>
References: <20210820193504.37044-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820193504.37044-1-johannes@sipsolutions.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 20, 2021 at 09:35:04PM +0200, Johannes Berg wrote:
> If using --object-dir to point into a repo, 'write' will
> segfault trying to access the object-dir via the repo it
> found, but that's not fully initialized. Fix it to use
> the object_dir properly.

Thanks for CC'ing me; I have definitely been wondering about the
intended behavior of `--object-dir` on the list recently [1].

I think your patch message could use some clarifying, though.  Invoking

    cd $REPO/..
    git multi-pack-index write --object-dir=$REPO/.git/objects

has... different behavior depending on which side of the "write"
argument you put `--object-dir". On the left-hand side (i.e.,
"--object-dir=... write", you get something like:

    cd $REPO/..
    git multi-pack-index --object-dir=$REPO/.git/objects write

    zsh: segmentation fault  git.compile multi-pack-index ...

because the_repository->objects->odb isn't initialized (so reading
`path` in `clear_midx_files_ext` crashes). But in the opposite order
(i.e., "write --object-dir=...") you get:

    BUG: environment.c:280: git environment hasn't been setup
    zsh: abort      git.compile multi-pack-index write

because we catch that case much earlier in get_object_directory(). Why?
Because cmd_multi_pack_index() fills in the value of object_dir with
get_object_directory() if it isn't filled in already, but seeing "write"
causes us to stop parsing and dispatch to the sub-command
cmd_multi_pack_index_write().

I discussed this a little in [1] also (see the part about using
RUN_SETUP instead). There are definitely different ways to handle that;
you could equally imagine only dying if we were both outside of a Git
repository and didn't point at one via `--object-dir`.

But that's separate from another issue which is fixed by your patch
which is that we don't respect the value of `--object-dir` when cleaning
up MIDX .rev files via clear_midx_files_ext().

Your fix there (to use the path of an object_dir instead of a repository
struct) makes sense (since we don't ever fill in a repository struct
corresponding to the `--object-dir` parameter from the MIDX code).

But I think that's a separate issue than the RUN_SETUP thing I mentioned
earlier, so I would probably consider breaking this into two patches,
the first which addresses the RUN_SETUP thing, and the second which is
this fix.

>  static int midx_checksum_valid(struct multi_pack_index *m)
> @@ -1086,7 +1086,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>
>  	if (flags & MIDX_WRITE_REV_INDEX)
>  		write_midx_reverse_index(midx_name, midx_hash, &ctx);
> -	clear_midx_files_ext(the_repository, ".rev", midx_hash);
> +	clear_midx_files_ext(object_dir, ".rev", midx_hash);

We can rely on this value always being non-NULL, so this is good.

> -static void clear_midx_files_ext(struct repository *r, const char *ext,
> +static void clear_midx_files_ext(const char *object_dir, const char *ext,
>  				 unsigned char *keep_hash)
>  {
>  	struct clear_midx_data data;
> @@ -1146,7 +1146,7 @@ static void clear_midx_files_ext(struct repository *r, const char *ext,
>  				    hash_to_hex(keep_hash), ext);
>  	data.ext = ext;
>
> -	for_each_file_in_pack_dir(r->objects->odb->path,
> +	for_each_file_in_pack_dir(object_dir,
>  				  clear_midx_file_ext,
>  				  &data);

And here's the most important part of the change, which is obviously
correct. But note to other reviewers that this has nothing to do with
the RUN_SETUP issue I mentioned earlier, since
for_each_file_in_pack_dir() doesn't care about that.

> +test_expect_success 'multi-pack-index with --object-dir need not be in repo' '
> +	p="$(pwd)" &&
> +	rm -f $objdir/multi-pack-index &&
> +	cd / &&
> +	git multi-pack-index --object-dir="$p/$objdir" write &&
> +	cd "$p"
> +'
> +

I agree with Stolee that there should be a new repo created within the
current working directory, that way you can "cd .." and be both outside
of the repo you just created, but not outside of the test environment.

But let's make sure that we're not deleting any files that we should be
leaving alone. So it might be good to do something like:

    git init repo &&
    test_when_finished "rm -fr repo" &&
    (
      cd repo &&

      test_commit base &&
      git repack -d &&
    ) &&

    rev="$objdir/pack/multi-pack-index-$(midx_checksum $objdir).rev" &&
    touch $rev &&

    git multi-pack-index write --object-dir=repo/.git/objects &&

    test_path_is_file repo/.git/objects/pack/multi-pack-index &&
    test_path_is_file repo/.git/objects/multi-pack-index &&
    test_path_is_file $objdir/pack/multi-pack-index &&
    test_path_is_file $rev

That isn't testing the "invoked from a non-repo, but --object-dir" is
given case, but I think that's fine since they really are separate
things.

Note also that midx_checksum doesn't exist, but it is merely a wrapper
over a test-tool that prints out (for a multi_pack_index "m") `m->data +
m->data_len - the_hash_algo->rawsz`.

So between splitting the patch, clarifying the patch message, and
implementing support for this new test helper, this may be more of a
project than you were bargaining for ;). Let me know if you want any
help. I also don't mind taking care of it myself, since I promised in
[1] that I'd fix this issue anyway.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/YQMFIljXl7sAAA%2FL@nand.local/
