Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB1EC433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 16:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiKDQ6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 12:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiKDQ54 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 12:57:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1E0CC6
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 09:57:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u6so5409056plq.12
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBOHJaDj0BdOUT1mOxpTVfacc0awccHV8RR4qndFdCE=;
        b=FKsBsJa201IJRbbZr6M5dcqLbYfJMuINO0/N5RkuE+9dgm/MMXxrwX+z9Z2f5SZ+8l
         Mw8bvHZRTV8U5uyBBxnyvI3XQOpHzp2v3v55zHPG6JDeaqrPLiwZp3YTzpodRfqJBU2A
         f2F4TUgfJrQErgmfRQCAtbU65i37hnQhbt6BdxGt6frqMtN2O2YOR/gPZNnNAjp9DJUC
         TWTZuiVm0mgCcVTDupnmsy2LrVbZAx7mLseGRZCikLxSm7kQnSIe74aIbAiDT0n713Cg
         K+1VuMSu3hRVRba+w7Aickd+GV3otTNeD0qi5Kp1vHqwjxKrSz6AWCVUYX8hDjE2HB6c
         wbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBOHJaDj0BdOUT1mOxpTVfacc0awccHV8RR4qndFdCE=;
        b=ZVVorHeBvs5EXwkg6+B9gE2TMy8qnCnKcYbGWtVxVOVL+mQrlFsJ4Dj+IRfhRRxzZM
         uSKVKMdyvwKyTg8U3ZDcMXagDRKmuXLodLD8BdKWHp5nit11fdG9r+7ard2NBTZKYyDV
         /BgIiga3cLZgYCa4nGH8mLcQ9uH1PGTCGFZu1T2pzdzYqmiCbs3moYPaVZDvBCHXQEcd
         Hzm2Dka4lZkT16sG1OM41XCkCU93HIeAKRTLtybPHdxOWPwAhO3pV3CNvH293CMcuKCA
         xUS3M/C7eGjXjDX+VqMHFPxMJDY7+6jCeJyS9ir7OULwiYPjKfuhef45RlRqMfnwdzYC
         BEUQ==
X-Gm-Message-State: ACrzQf0EqEemVRqP1a6scXTReeSo97WIf8POJA14+2LtTy1Z6NmNmDnN
        5nx8En/10tYpFjftSaOfoRMzBKDjV0X1iPnb8/DvwOYvM6HtsIkfS0mdL+kkEaQU5zmUWeTbLdd
        a50V2PFxVm7YUtdxXYZrmAjbQayVmlaYb4wheRKTiqBH479nf2lyMJy0dbQ==
X-Google-Smtp-Source: AMsMyM7WebWYWwSS5SEZGPeOLtp3U9gdIfruEgXufG/I7bLfrjVdeNIYSFSmk25s+dEXblnyp7mAOw==
X-Received: by 2002:a17:902:d891:b0:186:634e:5525 with SMTP id b17-20020a170902d89100b00186634e5525mr36021273plz.126.1667581072704;
        Fri, 04 Nov 2022 09:57:52 -0700 (PDT)
Received: from localhost.localdomain (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id a26-20020aa7971a000000b005622f99579esm2939015pfg.160.2022.11.04.09.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:57:52 -0700 (PDT)
From:   Victoria Dye <vdye@github.com>
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        "herr . kaste" <herr.kaste@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH] rebase --update-refs: avoid unintended ref deletion
Date:   Fri,  4 Nov 2022 09:57:36 -0700
Message-Id: <20221104165735.68899-1-vdye@github.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <bf5bc739-cb88-61ff-ed6b-09b1316f2f35@github.com>
References: <bf5bc739-cb88-61ff-ed6b-09b1316f2f35@github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In b3b1a21d1a5 (sequencer: rewrite update-refs as user edits todo list,
2022-07-19), the 'todo_list_filter_update_refs()' step was added to handle
the removal of 'update-ref' lines from a 'rebase-todo'. Specifically, it
removes potential ref updates from the "update refs state" if a ref does not
have a corresponding 'update-ref' line.

However, because 'write_update_refs_state()' will not update the state if
the 'refs_to_oids' list was empty, removing *all* 'update-ref' lines will
result in the state remaining unchanged from how it was initialized (with
all refs' "after" OID being null). Then, when the ref update is applied, all
refs will be updated to null and consequently deleted.

To fix this, add a 'force_if_empty' flag to allow writing the update refs
state even if 'refs_to_oids' is empty. The three usages of
'write_update_refs_state()' are updated as follows:

- in 'todo_list_filter_update_refs()': force_if_empty is 1 because update
  ref entries are removed here. This setting fixes the ref deletion issue.
- in 'do_update_ref()': force_if_empty is 0, since this method only modifies
  (does not add or delete) ref update entries.
- in 'todo_list_add_update_ref_commands()': force_if_empty is 0, since this
  method strictly adds ref update entries.

Additionally, add a test covering the "all update-ref lines removed" case.

Reported-by: herr.kaste <herr.kaste@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
This fixes the issue reported in [1]. I initially misinterpreted the root
cause (thought that 'todo_list_filter_update_refs()' was only applied in the
case of '--edit-todo'). After looking into it a bit more, it appears that
the actual failure case is much narrower, occurring only when *all*
'update-ref' lines were deleted from the 'rebase-todo'.

Thanks!
- Victoria

[1] https://lore.kernel.org/git/CAFzd1+5F4zqQ1CNeY2xaaf0r__JmE4ECiBt5h5OdiJHbaE78VA@mail.gmail.com/

 sequencer.c                   | 15 ++++++++++-----
 t/t3404-rebase-interactive.sh | 24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e658df7e8ff..4d99a4fd6ca 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4122,7 +4122,7 @@ static int do_merge(struct repository *r,
 	return ret;
 }

-static int write_update_refs_state(struct string_list *refs_to_oids)
+static int write_update_refs_state(struct string_list *refs_to_oids, int force_if_empty)
 {
 	int result = 0;
 	struct lock_file lock = LOCK_INIT;
@@ -4130,7 +4130,12 @@ static int write_update_refs_state(struct string_list *refs_to_oids)
 	struct string_list_item *item;
 	char *path;

-	if (!refs_to_oids->nr)
+	/*
+	 * If 'force' is specified, we want to write the updated refs even if
+	 * the list is empty. This is only needed for callers that may have
+	 * deleted items from 'refs_to_oids'.
+	 */
+	if (!refs_to_oids->nr && !force_if_empty)
 		return 0;

 	path = rebase_path_update_refs(the_repository->gitdir);
@@ -4260,7 +4265,7 @@ void todo_list_filter_update_refs(struct repository *r,
 	}

 	if (updated)
-		write_update_refs_state(&update_refs);
+		write_update_refs_state(&update_refs, 1);
 	string_list_clear(&update_refs, 1);
 }

@@ -4281,7 +4286,7 @@ static int do_update_ref(struct repository *r, const char *refname)
 		}
 	}

-	write_update_refs_state(&list);
+	write_update_refs_state(&list, 0);
 	string_list_clear(&list, 1);
 	return 0;
 }
@@ -6015,7 +6020,7 @@ static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
 		}
 	}

-	res = write_update_refs_state(&ctx.refs_to_oids);
+	res = write_update_refs_state(&ctx.refs_to_oids, 0);

 	string_list_clear(&ctx.refs_to_oids, 1);

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4f5abb5ad25..e7d3721ece8 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1964,6 +1964,30 @@ test_expect_success 'respect user edits to update-ref steps' '
 	test_cmp_rev HEAD refs/heads/no-conflict-branch
 '

+test_expect_success '--update-refs: do not delete refs if all update-ref are removed' '
+	git checkout -b test-refs-not-removed no-conflict-branch &&
+	git branch -f base HEAD~4 &&
+	git branch -f first HEAD~3 &&
+	git branch -f second HEAD~3 &&
+	git branch -f third HEAD~1 &&
+	git branch -f tip &&
+	(
+		set_cat_todo_editor &&
+		test_must_fail git rebase -i --update-refs base >todo.raw &&
+		sed -e "/^update-ref/d" <todo.raw >todo
+	) &&
+	(
+		set_replace_editor todo &&
+		git rebase -i --update-refs base
+	) &&
+
+	test_cmp_rev HEAD~3 refs/heads/first &&
+	test_cmp_rev HEAD~3 refs/heads/second &&
+	test_cmp_rev HEAD~1 refs/heads/third &&
+	test_cmp_rev HEAD refs/heads/tip &&
+	test_cmp_rev HEAD refs/heads/no-conflict-branch
+'
+
 test_expect_success '--update-refs: check failed ref update' '
 	git checkout -B update-refs-error no-conflict-branch &&
 	git branch -f base HEAD~4 &&
--
2.38.0

