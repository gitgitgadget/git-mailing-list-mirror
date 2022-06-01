Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB66C433EF
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 10:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352026AbiFAKZ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 06:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbiFAKZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 06:25:58 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B897759314
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 03:25:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h19so1567626edj.0
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 03:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wRBmF/tnbk5Z5aA7+L28h42FpeqJx/GWC/5dV+wWkXc=;
        b=JvXJWCkA4TSv2yIoJV0p6SLxV8q+lrth1Dp14sFLfI1YCbfOiVia4yyhkodN22fEjw
         CBDIdzy3In1Y3SWphH1IWCGykJak9wumLZmtCscqFpxXd2NwGkW8WdHcf4BtbwE2zNqO
         srA/qVFwQa1UjB5vgN9FKb5R08CHAhSwgKHPuFIIbVnnNuT1UznTLTfBcoOhfwsUP802
         g/Tx1HRzf67n9FCgGjvL2wIm8Hn57E/pHSbMg/WCgWipVptraxg/NXX/KWgAp+8xsR/Y
         0++ejyJmRIUUur3OGQCvDdU9AcR5rFv2UcHPCl9kw7JcHgx/Y+E9yVVzwVKmaMPqJAnX
         bOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wRBmF/tnbk5Z5aA7+L28h42FpeqJx/GWC/5dV+wWkXc=;
        b=kPjj5HtFOeiL6NiM/FMi07QvqtNvzL9svk+uCycMzfOZqcyq2dQHei8hDJiaVi207P
         jFTzGU/AD4bmNWe3dakPcTxUz4ZRQB8wMr+Yv8W5UppTFlU1JZtlKDr6dq5rLNpFc/yl
         spWTLwzzvRdeGrhA739i2UK8FUQ/5H7t6GHg61zwRu06HnGE2SoMtQM8ynnQ0ZdCMYcR
         XKAbdBMtn3kNvIkywe4ckgdKMjl7TgdlukT2LOp+nSLZhASZIpWm+mQN4iyiULX0qAgw
         iAvgvPWxaT/SapiKrvmxDudmJUvdyUz6MD/N21Sg5t3BoOYtnnsRLZVu3370lqoeSonK
         XrWg==
X-Gm-Message-State: AOAM530vd2jD6UEwM6rGpLyvLWx7bVpw7ywKn3iIp7g6mSXgoA0cF8jY
        +dnFK5Uv+I3KEIUf86cn/eFMxPiGWOJogQ==
X-Google-Smtp-Source: ABdhPJy8rkxztq5AxRRG1qPR80VCELRCkm3bWVdM4CbGDeju6KKGbjaVu9ULBFRXs2HV7iXymy9/cg==
X-Received: by 2002:a05:6402:3693:b0:42c:d459:eee4 with SMTP id ej19-20020a056402369300b0042cd459eee4mr27226645edb.351.1654079154992;
        Wed, 01 Jun 2022 03:25:54 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id n13-20020a056402060d00b0042dd630eb2csm734005edv.96.2022.06.01.03.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 03:25:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nwLY2-0017W2-06;
        Wed, 01 Jun 2022 12:25:54 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <dstolee@gmail.com>
Subject: Flaky SANITIZE=leak test "regression" in v2.36.0 (was: [PATCH v2
 1/2] merge-ort: fix small memory leak in detect_and_process_renames())
Date:   Wed, 01 Jun 2022 12:09:45 +0200
References: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
 <pull.1152.v2.git.1645320591.gitgitgadget@gmail.com>
 <f1f7fc97fe2fe5079365bb91c71fb7033378995d.1645320592.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <f1f7fc97fe2fe5079365bb91c71fb7033378995d.1645320592.git.gitgitgadget@gmail.com>
Message-ID: <220601.86czfs1xzi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 20 2022, Elijah Newren via GitGitGadget wrote:

[I fat-fingered an empty E-Mail reply to this earlier in
https://lore.kernel.org/git/220601.86h7541yqj.gmgdl@evledraar.gmail.com/,
sorry!]

> From: Elijah Newren <newren@gmail.com>
>
> detect_and_process_renames() detects renames on both sides of history
> and then combines these into a single diff_queue_struct.  The combined
> diff_queue_struct needs to be able to hold the renames found on either
> side, and since it knows the (maximum) size it needs, it pre-emptively
> grows the array to the appropriate size:
> [...]
> diff --git a/merge-ort.c b/merge-ort.c
> index d85b1cd99e9..3d7f9feb6f7 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3086,12 +3086,11 @@ static int detect_and_process_renames(struct merge_options *opt,
>  				      struct tree *side1,
>  				      struct tree *side2)
>  {
> -	struct diff_queue_struct combined;
> +	struct diff_queue_struct combined = { 0 };
>  	struct rename_info *renames = &opt->priv->renames;
> -	int need_dir_renames, s, clean = 1;
> +	int need_dir_renames, s, i, clean = 1;
>  	unsigned detection_run = 0;
>  
> -	memset(&combined, 0, sizeof(combined));
>  	if (!possible_renames(renames))
>  		goto cleanup;
>  
> @@ -3175,13 +3174,9 @@ simple_cleanup:
>  		free(renames->pairs[s].queue);
>  		DIFF_QUEUE_CLEAR(&renames->pairs[s]);
>  	}
> -	if (combined.nr) {
> -		int i;
> -		for (i = 0; i < combined.nr; i++)
> -			pool_diff_free_filepair(&opt->priv->pool,
> -						combined.queue[i]);
> -		free(combined.queue);
> -	}
> +	for (i = 0; i < combined.nr; i++)
> +		pool_diff_free_filepair(&opt->priv->pool, combined.queue[i]);
> +	free(combined.queue);
>  
>  	return clean;
>  }

I haven't been able to find whether this actually causes anything bad,
but when I started digging into SANITIZE=leak failures I found that this
change made t6435-merge-sparse.sh flaky in the v2.36.0 release when
compiled with SANITIZE=leak.

I.e. it "should" fail, but with 8d60e9d2010 (merge-ort: fix small memory
leak in detect_and_process_renames(), 2022-02-20) it will sometimes
succeed.

I bisected it between 2.35.0..2.36.0 with:

	git bisect run sh -c 'make SANITIZE=leak && (cd t && ! (for i in $(seq 1 20); do ./t6435-merge-sparse.sh >/dev/null && echo $? || echo $?; done | grep -q 0))'

I.e. "fail if we succeed" (there's some redundancy in the ad-hoc
one-liner). Manually debugging it with:
	
	diff --git a/dir.c b/dir.c
	index d91295f2bcd..3e860769c26 100644
	--- a/dir.c
	+++ b/dir.c
	@@ -878,6 +878,8 @@ void add_pattern(const char *string, const char *base,
	 	unsigned flags;
	 	int nowildcardlen;
	 
	+	fprintf(stderr, "adding pattern %s\n", string);
	+
	 	parse_path_pattern(&string, &patternlen, &flags, &nowildcardlen);
	 	if (flags & PATTERN_FLAG_MUSTBEDIR) {
	 		FLEXPTR_ALLOC_MEM(pattern, pattern, string, patternlen);

Turns up this odd case, i.e. we "should" fail at the end of the "setup"
in this bit of test code:

	[...]
        test_commit_this ours &&
        git config core.sparseCheckout true &&
        echo "/checked-out" >.git/info/sparse-checkout &&
        git reset --hard &&
        test_must_fail git merge their

Here we leak in "git reset", so we "should" get a leak like:
	
	[...]	
	+ git tag ours
	+ git config core.sparseCheckout true
	+ echo /checked-out
	+ git reset --hard
	adding pattern /checked-out
	adding pattern /checked-out
	adding pattern /checked-out
	HEAD is now at 3dfe889 ours
	
	=================================================================
	==25385==ERROR: LeakSanitizer: detected memory leaks
	
	Indirect leak of 512 byte(s) in 1 object(s) allocated from:
	    #0 0x7f9652ef50aa in __interceptor_calloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:90
	    #1 0x6ab6dc in xcalloc /home/avar/g/git/wrapper.c:140
	    #2 0x58e5ac in alloc_table /home/avar/g/git/hashmap.c:79
	    #3 0x58e8e9 in hashmap_init /home/avar/g/git/hashmap.c:168
	    #4 0x569808 in add_patterns_from_buffer /home/avar/g/git/dir.c:1136
	    #5 0x5697a1 in add_patterns /home/avar/g/git/dir.c:1124
	    #6 0x56996a in add_patterns_from_file_to_list /home/avar/g/git/dir.c:1164
	    #7 0x56e0b2 in get_sparse_checkout_patterns /home/avar/g/git/dir.c:3273
	    #8 0x56a240 in init_sparse_checkout_patterns /home/avar/g/git/dir.c:1451
	[...]
	
That's consistent with what I see before, but sometimes it'll succeed
like this:

	[...]		
	+ git tag ours
	+ git config core.sparseCheckout true
	+ echo /checked-out
	+ git reset --hard
	adding pattern /checked-out   
	HEAD is now at 3dfe889 ours   
        [...]

I.e. for some reason the same "reset --hard" now adds one, not three
patterns (which before were all identical).

Now, the "flaky success" with SANITIZE=leak does appear to be new in
8d60e9d2010, but before that running this in a loop reveals that the 2nd
test sometimes succeeds, so perhaps the underlying "issue" isn't new.

I say "issue" because I haven't dug enough to see if this has any impact
on anything, and the failure I discovered doesn't per-se matter now.

But perhaps this observed indeterminism is pointing the way to some
deeper bug here? Or maybe it isn't...
	
