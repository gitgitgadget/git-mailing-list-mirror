Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB7981F403
	for <e@80x24.org>; Sat, 16 Jun 2018 05:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753889AbeFPFOv (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 01:14:51 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34221 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753736AbeFPFOu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 01:14:50 -0400
Received: by mail-lf0-f68.google.com with SMTP id o9-v6so17489863lfk.1
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 22:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wCwS2me0GzOghLOp5XQO240iyKKPVZrt3Hp2yvqX9j4=;
        b=GTgwvrBOyUqa2TD20tEtTdXWhfPzW73F95+B4wcL5lFdSiUig0DdToGcJdnwUS4GtY
         cDqFVqmidPRendvGHTjm/HZVG6eutIZxkuRAv1nmFH09+XUj12xWBPYAtVh7+/B/crip
         ne992DdO+ppJwnh5p3iy7rnzvPi8b+OmYFryp86csu/sWo2hkTjsazTa5qFCX1HBdP2w
         YK89VNDrhfVdu2D1F06JJCPlvkBeM6RJk23gXrDTuTGhE2UnjpYiGL24O/3pyBrMw6Ye
         1hpDSDrxUIpodg4LVsz7//l5exhYQWo9haBqk8TwcUXx0g1fpbyA6ZZ/uqPotQ3lGwI/
         u/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wCwS2me0GzOghLOp5XQO240iyKKPVZrt3Hp2yvqX9j4=;
        b=fTun9hVqXGl7QxgIgodS+QveBEYToxcUtQXyEYh9wbDcfskFDcU3c7ODsbAwmFP19a
         YrnKva3f2OvKcubcr7XXXZuOC1ewG/9rpGmSt0sfnqcfY9/X1CUNS6kTsZSTrunDakup
         DWRJjYCb8D+XLuXv7D/HaUZvNi80gEb1SU0HpaO5JZiWaWUPtePL0gyPXGoRFejWav+t
         ENGfcLy1M/Y2B0ZJh1dcsjBmrMdo2L8GA7WiFhl/1F9XYUgEQVLF+TiXbG8p89KIitEy
         t3/uNEycUT/xkRY5/UGHjuGa4RQtIs13OzvaeWBNy33uGJQZd2Xuatj0SKMW+7UNbZc7
         EyUQ==
X-Gm-Message-State: APt69E1+N9zID4Hn+K1vO6RmrMtuwat91GGkV+9SGX5LryQeFqI4ncw9
        AT4kSc785qTMxADG4RZ1a/A=
X-Google-Smtp-Source: ADUXVKK8t5Ica5Y6HnzGqbCI3JnEdO9Ux8hblr1fLa9ZSEF80im8szGLhJfhaa0DjSN447sBU20PHw==
X-Received: by 2002:a2e:93c9:: with SMTP id p9-v6mr3071382ljh.117.1529126088722;
        Fri, 15 Jun 2018 22:14:48 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x68-v6sm1772638lfb.25.2018.06.15.22.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 22:14:47 -0700 (PDT)
Date:   Sat, 16 Jun 2018 07:14:44 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Max Kirillov <max@max630.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees: do not fail reset because of unmerged
 skipped entry
Message-ID: <20180616051444.GA29754@duynguyen.home>
References: <20180615044251.10597-1-max@max630.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615044251.10597-1-max@max630.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 07:42:51AM +0300, Max Kirillov wrote:
> After modify/delete merge conflict happens in a file skipped by sparse
> checkout, "git reset --merge", which implements the "--abort" actions, and
> "git reset --hard" fail with message "Entry * not uptodate. Cannot update
> sparse checkout." The reason is that the entry is verified in
> apply_sparse_checkout() for being up-to-date even when it has a conflict.

Conflicted entries should not be skipped by design. Even if you
specify sparse patterns to ignore them, they must be checked out. When
a conflicted entry appears in apply_sparse_checkout() something else
is already wrong.

I think this is a better fix along that line. As you can see we
already un-skip staged entries. But I think I forgot (or did not know)
about CE_CONFLICTED. This change passes your new tests, but I didn't
try to run the whole test suite to see if I broke anything else.

-- 8< --
diff --git a/unpack-trees.c b/unpack-trees.c
index 3a85a02a77..eb544ee1b3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1246,7 +1246,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 		if (select_flag && !(ce->ce_flags & select_flag))
 			continue;
 
-		if (!ce_stage(ce))
+		if (!ce_stage(ce) && !(ce->ce_flags & CE_CONFLICTED))
 			ce->ce_flags |= skip_wt_flag;
 		else
 			ce->ce_flags &= ~skip_wt_flag;
-- 8< --

> Checking conflicted entry for being up-to-date is not performed in other
> cases. One obvious reason to not check it is that it is already modified
> by inserting conflict marks.
> 
> Fix by not checking conflicted entries before performing reset.
> Also, add test case which verifies the issue is fixed.
> 
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> I have tried to use sparse-checkout for merging and cherrypicking, to save on IO
> and disk space. It works, mostly, but there are issues here and there.
> This one was low hanging, and also pretty annoying.
> 
>  t/t3035-merge-sparse.sh | 46 +++++++++++++++++++++++++++++++++++++++++
>  unpack-trees.c          |  2 +-
>  2 files changed, 47 insertions(+), 1 deletion(-)
>  create mode 100755 t/t3035-merge-sparse.sh
> 
> diff --git a/t/t3035-merge-sparse.sh b/t/t3035-merge-sparse.sh
> new file mode 100755
> index 0000000000..c6b2b0b82a
> --- /dev/null
> +++ b/t/t3035-merge-sparse.sh
> @@ -0,0 +1,46 @@
> +#!/bin/sh
> +
> +test_description='merge with sparse files'
> +
> +. ./test-lib.sh
> +
> +# test_file $filename $content
> +test_file () {
> +	echo "$2" > "$1" &&
> +	git add "$1"
> +}
> +
> +# test_commit_this $message_and_tag
> +test_commit_this () {
> +	git commit -m "$1" &&
> +	git tag "$1"
> +}
> +
> +test_expect_success 'setup' '
> +	test_file checked-out init &&
> +	test_file modify_delete modify_delete_init &&
> +	test_commit_this init &&
> +	test_file modify_delete modify_delete_theirs &&
> +	test_commit_this theirs &&
> +	git reset --hard init &&
> +	git rm modify_delete &&
> +	test_commit_this ours &&
> +	git config core.sparseCheckout true &&
> +	echo "/checked-out" >.git/info/sparse-checkout &&
> +	git reset --hard &&
> +	! git merge theirs
> +'
> +
> +test_expect_success 'reset --hard works after the conflict' '
> +	git reset --hard
> +'
> +
> +test_expect_success 'setup: conflict back' '
> +	! git merge theirs
> +'
> +
> +test_expect_success 'Merge abort works after the conflict' '
> +	git merge --abort
> +'
> +
> +test_done
> diff --git a/unpack-trees.c b/unpack-trees.c
> index e73745051e..65ae0721a6 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -468,7 +468,7 @@ static int apply_sparse_checkout(struct index_state *istate,
>  		 * also stat info may have lost after merged_entry() so calling
>  		 * verify_uptodate() again may fail
>  		 */
> -		if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate_sparse(ce, o))
> +		if (!(ce->ce_flags & CE_UPDATE) && !(ce->ce_flags & CE_CONFLICTED) && verify_uptodate_sparse(ce, o))
>  			return -1;
>  		ce->ce_flags |= CE_WT_REMOVE;
>  		ce->ce_flags &= ~CE_UPDATE;
> -- 
> 2.17.0.1185.g782057d875
> 
