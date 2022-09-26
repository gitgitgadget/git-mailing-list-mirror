Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4469EC07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 16:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbiIZQTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbiIZQSq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 12:18:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1837CF34C9
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 08:08:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id rk17so1556776ejb.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=QbIm6Q4tDUXWgO6f0A/4NfQUpgrDy4NjXdNQcqpJ1i8=;
        b=GiVMvu403bPklfaLmTfNb1HbVwJazXQ/iDZ2eKaRui9gXLpFx7phPEth2vdYsSy8sP
         zMmifnhJThi522LmjPxuqlHexLMHyMewdQ1y22Ks8a1jTkJvzXYd6tj+kaDWCWZJ8oEF
         MwI+yZEkw+KNjOl5OK6Z2HRbXj9y4Jm8lvTQLbjZw357VDPyrDXwrneU67fvZySiIxvZ
         h6gxaPHA7DAfvXGYAqBrN3h3GGP7tyJKRoL3mTfl5LdAMwQCVeOlpQTfZibWytJtP9LW
         CL+60BWvkcGxLjPmt/rfeP0VbeQk4Jz/+O2j0jleSZJrl7PHDsvMsRNPTxs2iL6dedhN
         HN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=QbIm6Q4tDUXWgO6f0A/4NfQUpgrDy4NjXdNQcqpJ1i8=;
        b=OhM5dvaFyu6pkHBgIpXzSr2BpfWjApdizMKGGd0unEeN7Q9eaJzRZ6yBE5D52gACMg
         lvvkWWhyNtJA9R49ZBsIOGMldFifWGWVFMcACe6f73YcyLBmBemSSl/ZqGzuSn8hRF8C
         FVCwzUn2O+1rP0MLRunZKKdkLUGlmXMnudZk9FdXNTpPYQrOyobu3h7dI7aAmyaaHV0w
         RE0NlILgTiy9CiBc8bUhLDLT/Vyy/yOTcdbaPVU9sdaAHOQ49GgyUu6TQ8hc7goV38Xa
         REJEdxd+n6/XLVG6moP94DRcpDFY01EFS1Hg4HfNcW9+bTCewrmk+V7gitjnsrt19b/a
         8q/g==
X-Gm-Message-State: ACrzQf0QF378kFWkb9OCAGdb0ToO3qsI+poRBf4mZZ3NeKDxCVRDppz+
        EHi/ppkv0D8w2DExUXWo6cMAFjqMV28=
X-Google-Smtp-Source: AMsMyM5d9kw7yKaJsYh6TulZZW8XJ/O0//UOYQNXXER/Rgkd2SdjR0TBclTipo87l0gpaOMVaNhSug==
X-Received: by 2002:a17:907:6d03:b0:782:abba:936c with SMTP id sa3-20020a1709076d0300b00782abba936cmr13708147ejc.758.1664204881050;
        Mon, 26 Sep 2022 08:08:01 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g18-20020aa7c592000000b00456eb245ca0sm5738288edq.27.2022.09.26.08.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 08:08:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ocpiB-0009eq-1o;
        Mon, 26 Sep 2022 17:07:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        me@ttaylorr.com, chakrabortyabhradeep79@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] pack-bitmap: remove trace2 region from hot path
Date:   Mon, 26 Sep 2022 17:01:24 +0200
References: <pull.1365.git.1663938034607.gitgitgadget@gmail.com>
 <pull.1365.v2.git.1664198277250.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1365.v2.git.1664198277250.gitgitgadget@gmail.com>
Message-ID: <220926.868rm618ds.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 26 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The trace2 region around the call to lazy_bitmap_for_commit() in
> bitmap_for_commit() was added in 28cd730680d (pack-bitmap: prepare to
> read lookup table extension, 2022-08-14). While adding trace2 regions is
> typically helpful for tracking performance, this method is called
> possibly thousands of times as a commit walk explores commit history
> looking for a matching bitmap. When trace2 output is enabled, this
> region is emitted many times and performance is throttled by that
> output.
>
> For now, remove these regions entirely.
>
> This is a critical path, and it would be valuable to measure that the
> time spent in bitmap_for_commit() does not increase when using the
> commit lookup table. The best way to do that would be to use a mechanism
> that sums the time spent in a region and reports a single value at the
> end of the process. This technique was introduced but not merged by [1]
> so maybe this example presents some justification to revisit that
> approach.

Just getting rid of this seems like a good thing for now.

But aside: Yes, one way to mitigate this rather than removing the
tracing would be to make it really fast.

But just skimming pack-bitmap.c do we really need trace2 at the
granularity of a single commit? Looking at who calls bitmap_for_commit()
wouldn't something like this sketch-out be much more useful?:
	
	diff --git a/pack-bitmap.c b/pack-bitmap.c
	index 9d5205055a5..439aec220c7 100644
	--- a/pack-bitmap.c
	+++ b/pack-bitmap.c
	@@ -830,10 +830,8 @@ struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
	 		if (!bitmap_git->table_lookup)
	 			return NULL;
	 
	-		trace2_region_enter("pack-bitmap", "reading_lookup_table", the_repository);
	 		/* NEEDSWORK: cache misses aren't recorded */
	 		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
	-		trace2_region_leave("pack-bitmap", "reading_lookup_table", the_repository);
	 		if (!bitmap)
	 			return NULL;
	 		return lookup_stored_bitmap(bitmap);
	@@ -1042,6 +1040,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
	 	 * The ones without bitmaps in the index will be stored in the
	 	 * `not_mapped_list` for further processing.
	 	 */
	+	/* begin trace2 find roots? */
	 	while (roots) {
	 		struct object *object = roots->item;
	 		roots = roots->next;
	@@ -1055,6 +1054,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
	 		object_list_insert(object, &not_mapped);
	 	}
	 
	+	/* end trace2 find roots? */
	 	/*
	 	 * Best case scenario: We found bitmaps for all the roots,
	 	 * so the resulting `or` bitmap has the full reachability analysis
	@@ -1100,7 +1100,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
	 		incdata.base = base;
	 		incdata.seen = seen;
	 
	-		revs->include_check = should_include;
	+		revs->include_check = should_include; // Will call bitmap_for_commit()
	 		revs->include_check_obj = should_include_obj;
	 		revs->include_check_data = &incdata;
	 
	@@ -1110,9 +1110,11 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
	 		show_data.bitmap_git = bitmap_git;
	 		show_data.base = base;
	 
	+		/* begin trace2 rev list? */
	 		traverse_commit_list(revs,
	 				     show_commit, show_object,
	 				     &show_data);
	+		/* end trace2 rev list? */
	 
	 		revs->include_check = NULL;
	 		revs->include_check_obj = NULL;
	

This is *not* the same as stricking the tracing into
bitmap_for_commit(), but do we really need the tracing that far inside
our loop?

