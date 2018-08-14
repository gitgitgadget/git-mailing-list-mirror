Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44D2F1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbeHNUyt (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 16:54:49 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:40171 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730474AbeHNUys (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 16:54:48 -0400
Received: by mail-yw1-f73.google.com with SMTP id t10-v6so26896464ywc.7
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 11:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yn7qpbvdKJk3R865k0w44wvMMRG0+UYCzw5vJbrkL+I=;
        b=AE3nEqeK5TvnCuHCVc9uwSzMH4gbLF5uqg8tzmOUbu1NBLwap6qG2S03kk8LoCzkW+
         0Tqufl+2KWfV2mdUlYuVAZXJCAA903uwrpcuoiYWd4f9ym/2KQnIKl1XBrbmAvb8DPIr
         sDwUh3gpf6Ianlcp5vh/lmxTaf5B323oScd7DlsHDhRzixldoVmU1lYggQDa8J1e0DVR
         rBM6l61etucJt4WLEW6FmYJ3i+c3TXGYBYVuqKA5kObzjV9cMrA3T6M8a1rH7W7vUDtf
         OT/uwSnlD6wZBJnQkPXpBDlgo74rdkmmWerAdgHA9vnP33Da2DB8C1fFx2ZtU7pG/ldA
         ItJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yn7qpbvdKJk3R865k0w44wvMMRG0+UYCzw5vJbrkL+I=;
        b=a1U9ACJO6hexOFlMxJ38Lr1q+xbKS294CP8hasIaX3TBw2DFOwmqKQCZYqf77Rjfb0
         U/lVH//OLX9wnqtxLQH/IqNzPcuTimw2JpjgE5VykWE6xLMV0Idu1a2zElRskHG8dP+P
         DDw3ACV0LCAsqABB9Ye4/JDEdyniLRCY9dx0oKRlXvanCEPQdsimaA7XUmf2O3br/oLz
         xZcLEpSa7mcS5lAFraVPcRdYYSKr1Ed4ErK9virFKAiIdWJNTZGh91oJjAz1yO4HS8oD
         Eno+E5Ba1nXpjPQVAIgktXN24QDOrvusYgpYEoF3cOEsXrdcSvafFKQlvI7BS4KJhz7U
         HyRQ==
X-Gm-Message-State: AOUpUlFyEYcgiv4szctvjCiH8IUITlgnPe3ZSjuDTauWes6Rjt0mBUfL
        CgFXMilkel9Q2Ct9/DZm7uz7Xh9leRbNkZXUO2VV
X-Google-Smtp-Source: AA+uWPyTbt0gvWsG/IF4tDGwhRmmeYpSeh1/hmDPU4voJ3+KIj8ToQpoz2DvOpPELi7cijpzm/QljWLazc2m2EA32r9k
X-Received: by 2002:a0d:da41:: with SMTP id c62-v6mr6666983ywe.98.1534269989401;
 Tue, 14 Aug 2018 11:06:29 -0700 (PDT)
Date:   Tue, 14 Aug 2018 11:06:26 -0700
In-Reply-To: <e01e202cb0445b72dc52a1c8763dbd9c737fb86e.1534267611.git.matvore@google.com>
Message-Id: <20180814180626.31788-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <e01e202cb0445b72dc52a1c8763dbd9c737fb86e.1534267611.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: Re: [PATCH v4 4/6] rev-list: handle missing tree objects properly
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jeffhost@microsoft.com,
        peff@peff.net, stefanbeller@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Previously, we assumed only blob objects could be missing. This patch
> makes rev-list handle missing trees like missing blobs. A missing tree
> will cause an error if --missing indicates an error should be caused,
> and the hash is printed even if the tree is missing.

The last sentence is difficult to understand - probably better to say
that all --missing= arguments and --exclude-promisor-objects work for
missing trees like they currently do for blobs (and do not fixate on
just --missing=error). And also demonstrate this in tests, like in
t6612.

> In list-objects.c we no longer print a message to stderr if a tree
> object is missing (quiet_on_missing is always true). I couldn't find
> any place where this would matter, or where the caller of
> traverse_commit_list would need to be fixed to show the error. However,
> in the future it would be trivial to make the caller show the message if
> we needed to.
> 
> This is not tested very thoroughly, since we cannot create promisor
> objects in tests without using an actual partial clone. t0410 has a
> promise_and_delete utility function, but the is_promisor_object function
> does not return 1 for objects deleted in this way. More tests will will
> come in a patch that implements a filter that can be used with git
> clone.

These two paragraphs are no longer applicable, I think.

> @@ -373,6 +375,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  	init_revisions(&revs, prefix);
>  	revs.abbrev = DEFAULT_ABBREV;
>  	revs.commit_format = CMIT_FMT_UNSPECIFIED;
> +	revs.do_not_die_on_missing_tree = 1;

Is this correct? I would have expected this to be set only if --missing
was set.

> -	process_tree_contents(ctx, tree, base);
> +	/*
> +	 * NEEDSWORK: we should not have to process this tree's contents if the
> +	 * filter wants to exclude all its contents AND the filter doesn't need
> +	 * to collect the omitted OIDs. We should add a LOFR_SKIP_TREE bit which
> +	 * allows skipping all children.
> +	 */
> +	if (parsed)
> +		process_tree_contents(ctx, tree, base);

I agree with Jeff Hostetler in [1] that a LOFR_SKIP_TREE bit is
desirable, but I don't think that this patch is the right place to
introduce this NEEDSWORK. For me, this patch is about skipping iterating
over the contents of a tree because the tree does not exist; this
NEEDSWORK is about skipping iterating over the contents of a tree
because we don't want its contents, and it is quite confusing to
conflate the two.

[1] https://public-inbox.org/git/d751d56b-84bb-a03d-5f2a-7dbaf8d947cc@jeffhostetler.com/

> @@ -124,6 +124,7 @@ struct rev_info {
>  			first_parent_only:1,
>  			line_level_traverse:1,
>  			tree_blobs_in_commit_order:1,
> +			do_not_die_on_missing_tree:1,

I know that the other flags don't have documentation, but I think it's
worth documenting this one because it is rather complicated. I have
provided a sample one in my earlier review - feel free to use that or
come up with your own.

> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 4984ca583..74e3c5767 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -186,6 +186,72 @@ test_expect_success 'rev-list stops traversal at missing and promised commit' '
>  	! grep $FOO out
>  '
>  
> +test_expect_success 'show missing tree objects with --missing=print' '
> +	rm -rf repo &&
> +	test_create_repo repo &&
> +	test_commit -C repo foo &&
> +	test_commit -C repo bar &&
> +	test_commit -C repo baz &&
> +
> +	TREE=$(git -C repo rev-parse bar^{tree}) &&
> +
> +	promise_and_delete $TREE &&
> +
> +	git -C repo config core.repositoryformatversion 1 &&
> +	git -C repo config extensions.partialclone "arbitrary string" &&
> +	git -C repo rev-list --quiet --missing=print --objects HEAD >missing_objs 2>rev_list_err &&
> +	echo "?$TREE" >expected &&
> +	test_cmp expected missing_objs &&
> +
> +	# do not complain when a missing tree cannot be parsed
> +	! grep -q "Could not read " rev_list_err
> +'

I think that the --exclude-promisor-tests can go in t0410 as you have
done, but the --missing tests (except for --missing=allow-promisor)
should go in t6112. (And like the existing --missing tests, they should
be done without setting extensions.partialclone.)

As for --missing=allow-promisor, I don't see them being tested anywhere
:-( so feel free to make a suggestion. I would put them in t6112 for
easy comparison with the other --missing tests.
