Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9916C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 15:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BE2820782
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 15:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="cpO3jny0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgHYPmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHYPm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 11:42:29 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8BCC061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 08:42:29 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id z3so7010048qkz.7
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hcBiU8etBwCzC3rl5H3XlDy062gfaHv98fu8SVx5xhQ=;
        b=cpO3jny0Mtnk1XyFXWW1tC+NqJ0CQ/Eq8awFRFkcP8lNpzO721ZwMGNsjMxvml9WBm
         6Pv5Au4jjdqBFie3bP+y+TeqGhz5Ixz5hvQC6uq6JMX5YZcCLribLNFjW6kou+CCQUwb
         VeCbvJBwAmsX5g1Lwqd3UjXIAExjw6HkbDLrMsWpJa3ctp4H1CLjHsTLnw9cHEBI6BVT
         GVrxGOTU7k4Xs5gGnq5byoH5JXLrXAVQ/LRrSvec1PXjA3ls4D3LWEgUlZZTSzRKpYh3
         56Ni7Y/VuwoPr14LQgAM09UdKgIpK8fsx4gg69Fq/oMQcCnV6gUOWvv8Cp/NMwuEmoBU
         D0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hcBiU8etBwCzC3rl5H3XlDy062gfaHv98fu8SVx5xhQ=;
        b=kMIPu3GFWYjNq+evFOnyFkO/VpP5b02ffAxXkb6SYKOPeIwbvaH8BRKYanCVuoUJ5n
         nSdj8BFuIZ8WKVVTL5uIyXNyDrCbT5U1W2FZFQAdlt9VpG9IeciD5yVLguXPxfoJ0HJJ
         BQr38YzCz99X0Fjvq4R+LHhLKyePI23+Hb5EBGWmWi03tZqCCI3hUzloCF6Du2ElpDKI
         WWBZUWDI2rnTkgJfE0K2/Tem1nupPvZ04jYISingAqAuBflf7LOvWKyROyEngYKpZ/8V
         o7FdptaC86mIpjF3aQ41VufOU2D8rTMpLXcQs0CF8Gml0bgWka/SXMYPLrgVAMsEi8MN
         VYKg==
X-Gm-Message-State: AOAM532Op9GDPwQReNtvpxDu63Ioc9lHQKQapaNT/+rF4gZfqS80Slhz
        FAEPlGaeKMj4+Z4tFyxePi8h6Y0dI/3OHpjh
X-Google-Smtp-Source: ABdhPJzHiAFFwdvJFweddRbHeuu8JNPblYgsY8U7HlmccUtWIbPqdfGg6fKZvyK4iA6iv3QxDKaEDA==
X-Received: by 2002:a37:6846:: with SMTP id d67mr8198651qkc.260.1598370146813;
        Tue, 25 Aug 2020 08:42:26 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1558:8dc0:5209:36ba])
        by smtp.gmail.com with ESMTPSA id i75sm12042772qke.70.2020.08.25.08.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 08:42:25 -0700 (PDT)
Date:   Tue, 25 Aug 2020 11:42:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
Message-ID: <20200825154224.GA9116@syl.lan>
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <20200825022614.GA1391422@coredump.intra.peff.net>
 <20200825023710.GA98081@syl.lan>
 <e7eb9fb6-f1ea-f932-efaa-7434ad809989@gmail.com>
 <20200825144146.GA7671@syl.lan>
 <6a34d7ee-8c6b-8c6c-93bd-0013dccccafb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a34d7ee-8c6b-8c6c-93bd-0013dccccafb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 11:14:41AM -0400, Derrick Stolee wrote:
> On 8/25/2020 10:41 AM, Taylor Blau wrote:
> > On Tue, Aug 25, 2020 at 09:14:19AM -0400, Derrick Stolee wrote:
> >> The code in builtin/repack.c looks good for sure. I have a quick question
> >> about this new test:
> >>
> >> +test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
> >> +	git multi-pack-index write &&
> >> +	cp $objdir/pack/multi-pack-index $objdir/pack/multi-pack-index.bak &&
> >> +	test_when_finished "rm -f $objdir/pack/multi-pack-index.bak" &&
> >> +
> >> +	# Write a new pack that is unknown to the multi-pack-index.
> >> +	git hash-object -w </dev/null >blob &&
> >> +	git pack-objects $objdir/pack/pack <blob &&
> >> +
> >> +	GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
> >> +	test_cmp_bin $objdir/pack/multi-pack-index \
> >> +		$objdir/pack/multi-pack-index.bak
> >> +'
> >> +
> >>
> >> You create an arbitrary blob, and then add it to a pack-file. Do we
> >> know that 'git repack' is definitely creating a new pack-file that makes
> >> our manually-created pack-file redundant?
> >>
> >> My suggestion is to have the test check itself:
> >>
> >> +test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
> >> +	git multi-pack-index write &&
> >> +	cp $objdir/pack/multi-pack-index $objdir/pack/multi-pack-index.bak &&
> >> +	test_when_finished "rm -f $objdir/pack/multi-pack-index.bak" &&
> >> +
> >> +	# Write a new pack that is unknown to the multi-pack-index.
> >> +	git hash-object -w </dev/null >blob &&
> >> +	HASH=$(git pack-objects $objdir/pack/pack <blob) &&
> >> +
> >> +	GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
> >> +	test_cmp_bin $objdir/pack/multi-pack-index \
> >> +		$objdir/pack/multi-pack-index.bak &&
> >> +	test_path_is_missing $objdir/pack/pack-$HASH.pack
> >> +'
> >> +
> >>
> >> This test fails for me, on the 'test_path_is_missing'. Likely, the
> >> blob is seen as already in a pack-file so is just pruned by 'git repack'
> >> instead. I thought that perhaps we need to add a new pack ourselves that
> >> overrides the small pack. Here is my attempt:
> >>
> >> test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
> >> 	git multi-pack-index write &&
> >> 	cp $objdir/pack/multi-pack-index $objdir/pack/multi-pack-index.bak &&
> >> 	test_when_finished "rm -f $objdir/pack/multi-pack-index.bak" &&
> >>
> >> 	# Write a new pack that is unknown to the multi-pack-index.
> >> 	BLOB1=$(echo blob1 | git hash-object -w --stdin) &&
> >> 	BLOB2=$(echo blob2 | git hash-object -w --stdin) &&
> >> 	cat >blobs <<-EOF &&
> >> 	$BLOB1
> >> 	$BLOB2
> >> 	EOF
> >> 	HASH1=$(echo $BLOB1 | git pack-objects $objdir/pack/pack) &&
> >> 	HASH2=$(git pack-objects $objdir/pack/pack <blobs) &&
> >> 	GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
> >> 	test_cmp_bin $objdir/pack/multi-pack-index \
> >> 		$objdir/pack/multi-pack-index.bak &&
> >> 	test_path_is_file $objdir/pack/pack-$HASH2.pack &&
> >> 	test_path_is_missing $objdir/pack/pack-$HASH1.pack
> >> '
> >>
> >> However, this _still_ fails on the "test_path_is_missing" line, so I'm not sure
> >> how to make sure your logic is tested. I saw that 'git repack' was writing
> >> "nothing new to pack" in the output, so I also tested adding a few commits and
> >> trying to force it to repack reachable data, but I cannot seem to trigger it
> >> to create a new pack that overrides only one pack that is not in the MIDX.
> >>
> >> Likely, I just don't know how 'git rebase' works well enough to trigger this
> >> behavior. But the test as-is is not testing what you want it to test.
> >
> > I think this case might actually be impossible to tickle in a test. I
> > thought that 'git repack -d' looked for existing packs whose objects are
> > a subset of some new pack generated. But, it's much simpler than that:
> > '-d' by itself just looks for packs that were already on disk with the
> > same SHA-1 as a new pack, and it removes the old one.
>
> If 'git repack' never calls remove_redundant_pack() unless we are doing
> a "full repack", then we could simplify this logic:
>
>  static void remove_redundant_pack(const char *dir_name, const char *base_name)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> -	strbuf_addf(&buf, "%s/%s.pack", dir_name, base_name);
> +	struct multi_pack_index *m = get_multi_pack_index(the_repository);
> +	strbuf_addf(&buf, "%s.pack", base_name);
> +	if (m && midx_contains_pack(m, buf.buf))
> +		clear_midx_file(the_repository);
> +	strbuf_insertf(&buf, 0, "%s/", dir_name);
>  	unlink_pack_path(buf.buf, 1);
>  	strbuf_release(&buf);
>  }
>
> to
>
>  static void remove_redundant_pack(const char *dir_name, const char *base_name)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> 	strbuf_addf(&buf, "%s/%s.pack", dir_name, base_name);
> +	clear_midx_file(the_repository);
>  	unlink_pack_path(buf.buf, 1);
>  	strbuf_release(&buf);
>  }
>
> and get the same results as we are showing in these tests. This does
> move us incrementally to a better situation: don't delete the MIDX
> if we aren't deleting pack files. But, I think we can get around it.

Makes sense, but reading your whole email we are better off leaving this
as-is and changing the test to exercise it more often.

> > Note that 'git repack' uses 'git pack-objects' internally to find
> > objects and generate a packfile. When calling 'git pack-objects', 'git
> > repack -d' passes '--all' and '--unpacked', which means that there is no
> > way we'd generate a new pack with the same SHA-1 as an existing pack
> > ordinarily.
> >
> > So, I think this case is impossible, or at least astronomically
> > unlikely. What is more interesting (and untested) is that adding a _new_
> > pack doesn't cause us to invalidate the MIDX. Here's a patch that does
> > that:
> >
> >   diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> >   index 16a1ad040e..620f2058d6 100755
> >   --- a/t/t5319-multi-pack-index.sh
> >   +++ b/t/t5319-multi-pack-index.sh
> >   @@ -391,18 +391,27 @@ test_expect_success 'repack removes multi-pack-index when deleting packs' '
> >           test_path_is_missing $objdir/pack/multi-pack-index
> >    '
> >
> >   -test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
> >   -       git multi-pack-index write &&
> >   -       cp $objdir/pack/multi-pack-index $objdir/pack/multi-pack-index.bak &&
> >   -       test_when_finished "rm -f $objdir/pack/multi-pack-index.bak" &&
> >   -
> >   -       # Write a new pack that is unknown to the multi-pack-index.
> >   -       git hash-object -w </dev/null >blob &&
> >   -       git pack-objects $objdir/pack/pack <blob &&
> >   -
> >   -       GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
> >   -       test_cmp_bin $objdir/pack/multi-pack-index \
> >   -               $objdir/pack/multi-pack-index.bak
> >   +test_expect_success 'repack preserves multi-pack-index when creating packs' '
> >   +       git init preserve &&
> >   +       test_when_finished "rm -fr preserve" &&
> >   +       (
> >   +               cd preserve &&
> >   +               midx=.git/objects/pack/multi-pack-index &&
> >   +
> >   +               test_commit "initial" &&
> >   +               git repack -ad &&
> >   +               git multi-pack-index write &&
> >   +               ls .git/objects/pack | grep "\.pack$" >before &&
> >   +
> >   +               cp $midx $midx.bak &&
> >   +
> >   +               test_commit "another" &&
> >   +               GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
> >   +               ls .git/objects/pack | grep "\.pack$" >after &&
> >   +
> >   +               test_cmp_bin $midx.bak $midx &&
> >   +               ! test_cmp before after
> >   +       )
> >    '
>
> After looking at the callers to remote_redundant_pack() I noticed that it is only
> called after inspecting the "names" struct, which contains the names of the packs
> to group into a new pack-file. We can use a .keep file to preserve the pack-file(s) in
> the MIDX but also to ensure multiple pack-files outside of the MIDX are repacked and
> deleted. While this is very unlikely in the wild, it is definitely possible.

Great idea.

> test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
> 	git init preserve &&
> 	test_when_finished "rm -fr preserve" &&
> 	(
> 		cd preserve &&
> 		midx=.git/objects/pack/multi-pack-index &&
>
> 		test_commit 1 &&
> 		HASH1=$(git pack-objects --all .git/objects/pack/pack) &&
> 		touch .git/objects/pack/pack-$HASH1.keep &&
>
> 		cat >pack-input <<-\EOF &&

Escaping the heredoc shouldn't be necessary, so this can be written
instead as '<<-EOF'.

> 		HEAD
> 		^HEAD~1
> 		EOF
>
> 		test_commit 2 &&
> 		HASH2=$(git pack-objects --revs .git/objects/pack/pack <pack-input) &&
> 		touch .git/objects/pack/pack-$HASH2.keep &&
>
> 		git multi-pack-index write &&
> 		cp $midx $midx.bak &&
>
> 		test_commit 3 &&
> 		HASH3=$(git pack-objects --revs .git/objects/pack/pack <pack-input) &&
>
> 		test_commit 4 &&
> 		HASH4=$(git pack-objects --revs .git/objects/pack/pack <pack-input) &&
>
> 		GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -ad &&
> 		test_path_is_file .git/objects/pack/pack-$HASH1.pack &&
> 		test_path_is_file .git/objects/pack/pack-$HASH2.pack &&
> 		test_path_is_missing .git/objects/pack/pack-$HASH3.pack &&
> 		test_path_is_missing .git/objects/pack/pack-$HASH4.pack

...and we should check that 'test_cmp $midx.bak $midx' is clean, i.e.,
that we didn't touch the MIDX.

>        )
> '
>
> I believe this checks your condition properly enough.

Otherwise, I think that this test looks great. Thanks for suggesting
it. I'll send a new patch now...

> Thanks,
> -Stolee

Thanks,
Taylor
