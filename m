Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE1AC33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AB220715
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FodSJ2GV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbgAGEKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:10:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37245 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbgAGEKa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:10:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so39765195wru.4
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XV5Oe00CbQIuNJl4+uXfEPJ9elUO/IUUd+QV7KfSxKs=;
        b=FodSJ2GV1Kw7uPv0thvNOyDLZKCrFbZ6pjL5VKL/egPxSxhh+vYL7nuzfSr2GuyKjY
         WtYrcRSuU7AD3s2uJfIZ2kJTx+kWfCvSEuH8XF/PSVUnFKc/+eLW3sFI325g4+mP6H/+
         BpXTwgOkkrYYVv4fmNyZZ5+Jixw7kF07y5Qa9snkuOFtsSVNQKWWT7P2mHWbbB98SShq
         BoZ/m9y11Fd5Lyn07Sbr8N0btraaFYAK2g/tCmqw7mRTBWh0ES6ALyCezVc3mKkiMeL7
         2MZu61/HqTbwJVESv7Jxdb38zN8Xz+1cREUz5p42DV4znmQpUc1ZAJulMYIYK+WWtitt
         mBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XV5Oe00CbQIuNJl4+uXfEPJ9elUO/IUUd+QV7KfSxKs=;
        b=NKsCRXW44SeznnfXEuLjj3KoS2aPiBCRslkLd/fmYtMG8ROH8p95uaKfcq8qCix+BB
         96xquvrfhYj7YlKQWN9ffXW2sNSBqQDn+d0UqXrbu+7kVXv/4suV9JBZMqjDHceU+7hX
         kuHL4tLLHzMNsfvjWpyvhBOcxehdoU4uHQOUJ4/wD+2hY6ecWIy3StB+K5SteagTwzO0
         BPEAVlCkelAcIsN/cBmL6KJlQ4U6jS7tl1G8ULMMr/84Lg2rhvitCc0o25UIlxOnsKln
         sU1HzBjJU2hMFbTrp885Flt7tWbOr8gkVIVmScCj6iuQoc+HRaXbQGj8/q2WVGwExdGA
         i7uQ==
X-Gm-Message-State: APjAAAWBDCcc2kMv+XVbtiTcKe4FbBuL4OSH+ra0qmjXiBTYjUVZanWB
        kyXsDw6ZT1YkzjfyD1PSJNxZKePt
X-Google-Smtp-Source: APXvYqwTvRZ6cdsVzH2sXigDt/YfanstzFWuJjmjaF2bo1O5kLpfuaVm5NqrH/gJ9pY4NtJPPXGFfg==
X-Received: by 2002:a05:6000:11c3:: with SMTP id i3mr11797822wrx.244.1578370227266;
        Mon, 06 Jan 2020 20:10:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13sm25975689wmd.36.2020.01.06.20.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:10:26 -0800 (PST)
Message-Id: <pull.507.v2.git.1578370226.gitgitgadget@gmail.com>
In-Reply-To: <pull.507.git.1577933387.gitgitgadget@gmail.com>
References: <pull.507.git.1577933387.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 04:10:25 +0000
Subject: [PATCH v2 0/1] [Outreachy] [RFC] branch: advise the user to checkout a different branch
 before deleting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a user attempts to delete a checked out branch, an error message is
displayed saying: "error: Cannot delete branch checked out at ". This patch
suggests displaying a hint after the error message advising the user to
checkout another branch first using "git checkout ".

Heba Waly (1):
  branch: advise the user to checkout a different branch before deleting

 advice.c          |  4 +++-
 advice.h          |  1 +
 builtin/branch.c  | 14 ++++++++++++++
 t/t3200-branch.sh |  6 ++++--
 4 files changed, 22 insertions(+), 3 deletions(-)


base-commit: 0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-507%2FHebaWaly%2Fdelete_branch_hint-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-507/HebaWaly/delete_branch_hint-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/507

Range-diff vs v1:

 1:  82bf24ce53 ! 1:  19a7cc1889 branch: advise the user to checkout a different branch before deleting
     @@ -3,15 +3,48 @@
          branch: advise the user to checkout a different branch before deleting
      
          Display a hint to the user when attempting to delete a checked out
     -    branch saying "Checkout another branch before deleting this one:
     -    git checkout <branch_name>".
     +    branch.
      
          Currently the user gets an error message saying: "error: Cannot delete
     -    branch <branch_name> checked out at <path>". The hint will be displayed
     +    branch <branch> checked out at <path>". The hint will be displayed
          after the error message.
      
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
      
     + diff --git a/advice.c b/advice.c
     + --- a/advice.c
     + +++ b/advice.c
     +@@
     + int advice_checkout_ambiguous_remote_branch_name = 1;
     + int advice_nested_tag = 1;
     + int advice_submodule_alternate_error_strategy_die = 1;
     ++int advice_delete_checkedout_branch = 1;
     + 
     + static int advice_use_color = -1;
     + static char advice_colors[][COLOR_MAXLEN] = {
     +@@
     + 	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
     + 	{ "nestedTag", &advice_nested_tag },
     + 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
     +-
     ++	{ "deleteCheckedoutBranch", &advice_delete_checkedout_branch },
     ++	
     + 	/* make this an alias for backward compatibility */
     + 	{ "pushNonFastForward", &advice_push_update_rejected }
     + };
     +
     + diff --git a/advice.h b/advice.h
     + --- a/advice.h
     + +++ b/advice.h
     +@@
     + extern int advice_checkout_ambiguous_remote_branch_name;
     + extern int advice_nested_tag;
     + extern int advice_submodule_alternate_error_strategy_die;
     ++extern int advice_delete_checkedout_branch;
     + 
     + int git_default_advice_config(const char *var, const char *value);
     + __attribute__((format (printf, 1, 2)))
     +
       diff --git a/builtin/branch.c b/builtin/branch.c
       --- a/builtin/branch.c
       +++ b/builtin/branch.c
     @@ -19,8 +52,20 @@
       				error(_("Cannot delete branch '%s' "
       					"checked out at '%s'"),
       				      bname.buf, wt->path);
     -+				advise(_("Checkout another branch before deleting this "
     -+						 "one: git checkout <branch_name>"));
     ++				if (advice_delete_checkedout_branch) {
     ++					if (wt->is_current) {
     ++						advise(_("The branch you are trying to delete is already "
     ++							"checked out, run the following command to "
     ++							"checkout a different branch then try again:\n"
     ++							"git switch <branch>"));
     ++					}
     ++					else {
     ++						advise(_("The branch you are trying to delete is checked "
     ++							"out on another worktree, run the following command "
     ++							"to checkout a different branch then try again:\n"
     ++							"git -C %s switch <branch>"), wt->path);
     ++					}
     ++				}
       				ret = 1;
       				continue;
       			}
     @@ -29,12 +74,15 @@
       --- a/t/t3200-branch.sh
       +++ b/t/t3200-branch.sh
      @@
     + 
       test_expect_success 'deleting currently checked out branch fails' '
       	git worktree add -b my7 my7 &&
     - 	test_must_fail git -C my7 branch -d my7 &&
     +-	test_must_fail git -C my7 branch -d my7 &&
      -	test_must_fail git branch -d my7 &&
     -+	test_must_fail git branch -d my7 >actual.out 2>actual.err &&
     -+	test_i18ngrep "hint: Checkout another branch" actual.err &&
     ++	test_must_fail git -C my7 branch -d my7 2>output1.err &&
     ++	test_must_fail git branch -d my7 2>output2.err &&
     ++	test_i18ngrep "hint: The branch you are trying to delete is already checked out" output1.err &&
     ++	test_i18ngrep "hint: The branch you are trying to delete is checked out on another worktree" output2.err &&
       	rm -r my7 &&
       	git worktree prune
       '

-- 
gitgitgadget
