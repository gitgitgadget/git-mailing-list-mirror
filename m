Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606ACC27C40
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 14:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbjHXONG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 10:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241611AbjHXOMy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 10:12:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A411BC2
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 07:12:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31781e15a0cso5907967f8f.3
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692886368; x=1693491168;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oH6f+qRi805w3vZuDR21nd9rpqnBdsEMNYzzsFqZUgw=;
        b=ETQB0NwBTLFcgz8myP95Kf1QeaTxN05FQG4GD+FNwV0AjJU+O2VC2fQfLbdZBkJTXW
         lQ86agS1jMqYnjbXNvvi4FGmWOzbSVL2ubkqyubwoCrKzduAcrmwIXLsRnxzEUs+osjH
         bxCtTxjNIhXtCHTRlW7K4F2gdTDr3omK+vSi2AIwq6RQ8DAhHit2YJUQBI3dqBEfnvmk
         IuZhM604HQv6JBmQRHcMllMJSIvy9yg1ltd7Mruot7aQigVZXOcwCBNF3HeeD5MYQP0S
         Mwi7lWlN3Ja2ALyq/QrogiX1s07CD0XUSDH09n1ZMpgAnNnlXKa77bOBOLuIfwM337eu
         vWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692886368; x=1693491168;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oH6f+qRi805w3vZuDR21nd9rpqnBdsEMNYzzsFqZUgw=;
        b=lqTKR2lJbIbyMPoqxOnwELB/8pW9hjYP6F2u2RhvE0In4ON2tTnhj2Lg1pGQDZAfsb
         +BSgtgFM0b0Nuya6RJaz4Kiv2E896SpDBVjacZV4bVgc9cgc6Q2Y8qNiXkekJkQgwI/I
         3tCuRgexRYVm9+6FB3YSsdVS2LKXR4u5cFHPopWGfavYMj6QoWPVv3KL6DTyB5rkoory
         qOcwyqYUicqfsdhN75D/My9UnyS0igaXZnyD2pqLdWlggv/mw0Xm5FoFW6q/J+n2gUIQ
         OxjPQqK9brditXFTUpO0m1ZPDekLj7mHtBKzm3swCaDpqRO5X9fVhY0xkPYVEH8RlEkO
         0qig==
X-Gm-Message-State: AOJu0Yw8tsWO3W3qiqazBIocM47ZuMEPBhhPKoW/A2s36+ujtZVMN0Z9
        m2uMEgitVUwpXyKI2HN2JDUmBhwwzn8=
X-Google-Smtp-Source: AGHT+IH9fhBSV3oUTwga5Z2rMDN9hJkhgq6j/3WrxQJmualrFg2iWe21LY9GSWtS0/hsQopJRqdE5Q==
X-Received: by 2002:adf:f3cd:0:b0:313:e9f6:3378 with SMTP id g13-20020adff3cd000000b00313e9f63378mr11482056wrp.4.1692886367435;
        Thu, 24 Aug 2023 07:12:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020adfe790000000b0030ae53550f5sm22190262wrm.51.2023.08.24.07.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 07:12:46 -0700 (PDT)
Message-ID: <pull.1577.v2.git.1692886365.gitgitgadget@gmail.com>
In-Reply-To: <pull.1577.git.1692389061490.gitgitgadget@gmail.com>
References: <pull.1577.git.1692389061490.gitgitgadget@gmail.com>
From:   "Kevin Backhouse via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Aug 2023 14:12:43 +0000
Subject: [PATCH v2 0/2] This fixes a minor memory leak (detected by LeakSanitizer) in git merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kevin Backhouse <kevinbackhouse@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Thank you for your comments. As you suggested, I have added similar fixes in
merge-recursive.c and updated the commit message. I have also added a test.

Thanks,

Kev

Kevin Backhouse (2):
  Regression test for https://github.com/gitgitgadget/git/pull/1577
  Fix minor memory leak found by LeakSanitizer.

 merge-ort-wrappers.c  |  4 +++-
 merge-ort.c           |  4 +++-
 merge-recursive.c     | 32 ++++++++++++++++++++++----------
 t/t9904-merge-leak.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 12 deletions(-)
 create mode 100755 t/t9904-merge-leak.sh


base-commit: f9972720e9a405e4f6924a7cde0ed5880687f4d0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1577%2Fkevinbackhouse%2Ffree-merge-bases-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1577/kevinbackhouse/free-merge-bases-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1577

Range-diff vs v1:

 -:  ----------- > 1:  f940104a781 Regression test for https://github.com/gitgitgadget/git/pull/1577
 1:  64b00e4448d ! 2:  353e1960b44 This fixes a minor memory leak (detected by LeakSanitizer) in git merge.
     @@ Metadata
      Author: Kevin Backhouse <kevinbackhouse@github.com>
      
       ## Commit message ##
     -    This fixes a minor memory leak (detected by LeakSanitizer) in git merge.
     +    Fix minor memory leak found by LeakSanitizer.
      
     -    To reproduce (with an ASAN build):
     +    The callers of merge_recursive() and merge_ort_recursive() expects the
     +    commit list passed in as the merge_bases parameter to be fully
     +    consumed by the function and does not free it when the function
     +    returns.  In normal cases, the commit list does get consumed, but when
     +    the function returns early upon encountering an error, it forgets to
     +    clean it up.
      
     -    ```
     -    mkdir test
     -    cd test
     -    git init
     -    echo x > x.txt
     -    git add .
     -    git commit -m "WIP"
     -    git checkout -b dev
     -    echo y > x.txt
     -    git add .
     -    git commit -m "WIP"
     -    git checkout main
     -    echo z > x.txt
     -    git add .
     -    git commit -m "WIP"
     -    echo a > x.txt
     -    git add .
     -    git merge dev
     -    ```
     -
     -    The fix is to call free_commit_list(merge_bases) when an error occurs.
     +    Fix this by freeing the list in the code paths for error returns.
      
          Signed-off-by: Kevin Backhouse <kevinbackhouse@github.com>
      
     @@ merge-ort.c: static void merge_ort_internal(struct merge_options *opt,
       		opt->branch1 = saved_b1;
       		opt->branch2 = saved_b2;
       		opt->priv->call_depth--;
     +
     + ## merge-recursive.c ##
     +@@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
     + 		opt->branch1 = "Temporary merge branch 1";
     + 		opt->branch2 = "Temporary merge branch 2";
     + 		if (merge_recursive_internal(opt, merged_merge_bases, iter->item,
     +-					     NULL, &merged_merge_bases) < 0)
     +-			return -1;
     ++					     NULL, &merged_merge_bases) < 0) {
     ++			clean = -1;
     ++			goto out;
     ++		}
     + 		opt->branch1 = saved_b1;
     + 		opt->branch2 = saved_b2;
     + 		opt->priv->call_depth--;
     + 
     +-		if (!merged_merge_bases)
     +-			return err(opt, _("merge returned no commit"));
     ++		if (!merged_merge_bases) {
     ++			clean = err(opt, _("merge returned no commit"));
     ++			goto out;
     ++		}
     + 	}
     + 
     + 	/*
     +@@ merge-recursive.c: static int merge_recursive_internal(struct merge_options *opt,
     + 				     repo_get_commit_tree(opt->repo,
     + 							  merged_merge_bases),
     + 				     &result_tree);
     ++
     ++out:
     + 	strbuf_release(&merge_base_abbrev);
     + 	opt->ancestor = NULL;  /* avoid accidental re-use of opt->ancestor */
     ++	free_commit_list(merge_bases);
     + 	if (clean < 0) {
     + 		flush_output(opt);
     + 		return clean;
     +@@ merge-recursive.c: static int merge_start(struct merge_options *opt, struct tree *head)
     + 	assert(!opt->record_conflict_msgs_as_headers);
     + 	assert(!opt->msg_header_prefix);
     + 
     ++	CALLOC_ARRAY(opt->priv, 1);
     ++	string_list_init_dup(&opt->priv->df_conflict_file_set);
     ++
     + 	/* Sanity check on repo state; index must match head */
     + 	if (repo_index_has_changes(opt->repo, head, &sb)) {
     + 		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
     +@@ merge-recursive.c: static int merge_start(struct merge_options *opt, struct tree *head)
     + 		return -1;
     + 	}
     + 
     +-	CALLOC_ARRAY(opt->priv, 1);
     +-	string_list_init_dup(&opt->priv->df_conflict_file_set);
     + 	return 0;
     + }
     + 
     + static void merge_finalize(struct merge_options *opt)
     + {
     + 	flush_output(opt);
     +-	if (!opt->priv->call_depth && opt->buffer_output < 2)
     +-		strbuf_release(&opt->obuf);
     ++	strbuf_release(&opt->obuf);
     + 	if (show(opt, 2))
     + 		diff_warn_rename_limit("merge.renamelimit",
     + 				       opt->priv->needed_rename_limit, 0);
     +@@ merge-recursive.c: int merge_trees(struct merge_options *opt,
     + 
     + 	assert(opt->ancestor != NULL);
     + 
     +-	if (merge_start(opt, head))
     ++	if (merge_start(opt, head)) {
     ++		merge_finalize(opt);
     + 		return -1;
     ++	}
     + 	clean = merge_trees_internal(opt, head, merge, merge_base, &ignored);
     + 	merge_finalize(opt);
     + 
     +@@ merge-recursive.c: int merge_recursive(struct merge_options *opt,
     + 	prepare_repo_settings(opt->repo);
     + 	opt->repo->settings.command_requires_full_index = 1;
     + 
     +-	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
     ++	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1))) {
     ++		free_commit_list(merge_bases);
     ++		merge_finalize(opt);
     + 		return -1;
     ++	}
     + 	clean = merge_recursive_internal(opt, h1, h2, merge_bases, result);
     + 	merge_finalize(opt);
     + 

-- 
gitgitgadget
