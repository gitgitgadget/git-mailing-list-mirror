Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C05E0211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 20:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390787AbfAKUZt (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 15:25:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52682 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389104AbfAKUZt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 15:25:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so3574608wml.2
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 12:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OrrYfmjV8KZ27KOv+e5HyLjRtIR2G4azf2VnT6tcOB0=;
        b=IL8sqIfKcsBatpTnnfiLuUhC19ioaB2gQAaZmMfA6hzaY3CHdBSnbyGL7/rZK4WZyx
         6G4pwSXV5S/tJdOD89ntLlW/U9M8LQCsyauCgbWkpaLWgbIo46gQ3YsbanvSSkrQBIu2
         4RuC0axKmSPMC7N+kKD2C4JEoy3yioD7QITsFX1tZVIYDk8KBnPxzXbnqJtLhK8H90R8
         MwGOsnfw/b5XLjvAnv8X+sjxJqd+a+izsW6BBv/6MNSJjSFYXfQoEQdPxsoLbwFZmDvJ
         tSIgzGad52cSPZC+kJq8jtmcvE0feCYNTC/tGRtqfRHe8N1kpx7jSthAweYWrd8OEFFK
         Xhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OrrYfmjV8KZ27KOv+e5HyLjRtIR2G4azf2VnT6tcOB0=;
        b=IhqYRr9mJ53JGWISpotA/VFBmqjuUzpQPV+q3z5+hwNL5zybsIxkIy2E9vseDSu5wq
         7bmfKcxHrhZkPtYobKHZcgtRxSMhaPMOM+L1Dja/8J3UhMfXpUmMDy9q0uvuA+RmRJ3h
         G5GLENchVK6rbFYBLikOyCIVai1Niu6wUdM3l5ysruzIPBVXs2THWQKSKrOz2aRUXo6X
         jD9jYVMvRJVooVo7ct4lBFzASohlrUfTx7koXTah/D0mVBUIC2MF54YG5vsncrcGShBM
         OU8EheY+aiiNvrlSCuuYrvXNRD3I1e+aXG5CBu0ZRw+1dD5qnQkg0Dx/dR82BEsHcEq7
         140A==
X-Gm-Message-State: AJcUukdaPhTPCkQ0W0mjSJBFncEqT3sqVP/gpNZPGBqxkOztrJEvwYNn
        NZONkBSxQIhFlGCQFkO7EXs=
X-Google-Smtp-Source: ALg8bN7LKX3oO5/8hrTYLOyZH5XYmlZo5hwG7ttLX1E+FuV9jhmfJdq8H7bYpwzjMzAPc247nXP6pg==
X-Received: by 2002:a7b:c315:: with SMTP id k21mr3443334wmj.145.1547238346327;
        Fri, 11 Jan 2019 12:25:46 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t63sm17375966wmt.8.2019.01.11.12.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 12:25:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 1/6] revision: add mark_tree_uninteresting_sparse
References: <pull.89.v3.git.gitgitgadget@gmail.com>
        <pull.89.v4.git.gitgitgadget@gmail.com>
        <817e30a287e12ce8e94ce41fcb969dd8ae53b9ce.1544822533.git.gitgitgadget@gmail.com>
        <xmqqzhs7x9nm.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 11 Jan 2019 12:25:45 -0800
In-Reply-To: <xmqqzhs7x9nm.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 11 Jan 2019 11:43:25 -0800")
Message-ID: <xmqqva2vx7p2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> In preparation for a new algorithm that walks fewer trees when
>> creating a pack from a set of revisions, create a method that
>> takes an oidset of tree oids and marks reachable objects as
>> UNINTERESTING.
>> ...
>> There is one new assumption in this approach: we are also given
>> the oids of the interesting trees. This implementation does not
>> use those trees at the moment, but we will use them in a later
>> rewrite of this method.

Ahh....


> The proposed log message claims that the method takes an oidset and
> marks reachable objects as uninteresting, but the implementation
> only marks those that are reachable from already uninteresting
> trees.  Either one of them must be wrong.
>
> Did you mean to have this instead?
>
> 		if (!tree)
> 			continue;
> 		/*
> 		 * Force traversal of the tree, even if it has been
> 		 * already marked as UNINTERESTING.
> 		 */
> 		tree->object.flags &= ~UNINTERESTING;
> 		mark_tree_uninteresting(r, tree);

So, I assumed that the implementation was wrong, but it is the other
way around.  You do mean to pick only already uninteresting trees
out of "set" and mark its reachables.

One thing that would make me worried is what help the callers of
this function will get (or they may have to devise the way
themselves) to avoid having to traverse the same tree number of
times.  A tree can be made uninteresting after a traversal of
another tree that contains it, but the logic in this function

> +		if (tree->object.flags & UNINTERESTING) {
> +			/*
> +			 * Remove the flag so the next call
> +			 * is not a no-op. The flag is added
> +			 * in mark_tree_unintersting().
> +			 */
> +			tree->object.flags ^= UNINTERESTING;
> +			mark_tree_uninteresting(r, tree);
> +		}

ignores the fact that it is already UNINTERESTING (in fact, in a
sense it is even worse---it cannot be used to make a not-yet
UNINTERESTING one into UNINTERESTING), drops the UNINTERESING bit
and forces the traversal of that tree.  The only thing I see that
would work as a saving grace is that mark_tree_uninteresting()
itself would honor existing UNINTERESING bit and refuses to recurse
into its subtrees, but that means blobs at the top-level of such a
tree would be marked UNINTERESING while those in its subtrees can be
left not-UNINTERESING, which sounds like inviting a mess.

It does *not* immediately mean this function is misdesigned.  It
just means that the caller needs to carefully follow whatever
calling convention this series will establish in the later patches
(which we haven't seen yet at this point).

> By the way, one of the bigger reasons why I have to ask, instead of
> making an educated guess, is because "struct oidset *set" parameter
> does not give any useful information with the variable name to the
> readers.  We know it is a set because its type is oidset; readers
> need to know what meaning the 'set' has, what it is used for, why
> the caller wants to (or decides not to) place a tree object in the
> set when it calls it.  None of that can be read from its name.
