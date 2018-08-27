Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E49AF1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 22:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbeH1CBg (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 22:01:36 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:42843 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeH1CBg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 22:01:36 -0400
Received: by mail-pg1-f201.google.com with SMTP id q67-v6so300572pgq.9
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 15:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=aCFqJOYCQ2D6+64iy9PJiT4ytID+WRjNJ3Fxkdh7TAY=;
        b=TJk+Z1V7m0KOaq4yc15IEOvhQw6jKpT2LNkkokysrqsJZU8P7adAzhhNQZGNVUiUq+
         Cuh+CyXK/PncErL5tswo10s5+/nJBW53Ms/1sXiEXzEQ8bCx8fbxtkjoh1pyFrB9THFS
         hcEUjnNF8TPvM2DlCQJamg63Lj6DWusdVmotlgmvoQsfgOWZTR2BMNBbURR0guI5RudI
         RzXGDQD2aPsnoNQ8Je0acbeWX6UDWEOVlSSZXMqM/EnBwiLSFIKDZ+jIQI5yUgcb1vwd
         6Pk6fi/BWaRMDcq5IKZ1vdxDECGuMx2x80HC+egDk+CCz0SiUaVmrHorlHnkhPeBQqRJ
         8xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=aCFqJOYCQ2D6+64iy9PJiT4ytID+WRjNJ3Fxkdh7TAY=;
        b=hYllCKJCHXNnlYFgEH3lvxx4SdINoG/wA5Z29p9Wdq/GoZqtknJD07vqoKye//jV32
         qWrrN/kD6kMPm4BLwSIaiJePPF51HvU/R5c9i1AJ7hSWQl462/3oRoXUH4a2QEpzS9iW
         QPhLQMT9f/P05VM1NdZyC2nNxqdGgFlaFynnPxFkbHelN1Prr+2txlfVNkfRsUbfqMPC
         0UnkABoSf42EwcZnxMoRNa3tKu3MeEB2uilq2UzLuIOkC0b1mLdWzEmA03BZeTIFDiD0
         TgV3Lwtwl+FTKutN0HwW4o89jLg35KAzNFy4YBCyZH8dZYznx6rJXIyPaTdjRfJsA6u+
         8+dQ==
X-Gm-Message-State: APzg51Df0UGYYDSZGi0SzBch6fVNU1Wgepja+7nvyRXlZfJr2Bgrv66y
        9HpzP/NcaQ7dmlquKYU5QzFl6alxrmTPmyXj+yMVjigW3jrqRU1lH9uOuZKIlAX6N0vW2CzMcSv
        qR5KhGSP4vE9S9OW0dnBR8myhdn65CG0HOE6ck2/Hl0ta2s75T/h7ngLHW7Mo
X-Google-Smtp-Source: ANB0VdaJTP2Cv5CkzDFPO5YWgZEfemE1pTwZdpmrs8KaCvriCQ9sabCo24qzcjo0O2UvVUlLE7kRhpx6BMbQ
MIME-Version: 1.0
X-Received: by 2002:a63:6c3:: with SMTP id 186-v6mr212611pgg.178.1535407983873;
 Mon, 27 Aug 2018 15:13:03 -0700 (PDT)
Date:   Mon, 27 Aug 2018 15:12:57 -0700
In-Reply-To: <20180827221257.149257-1-sbeller@google.com>
Message-Id: <20180827221257.149257-2-sbeller@google.com>
References: <20180827221257.149257-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0
Subject: [PATCH 2/2] submodule.c: warn about missing submodule git directories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the continuation of f2d48994dc1 (submodule.c: submodule_move_head
works with broken submodules, 2017-04-18), which tones down the case of
"broken submodule" in case of a missing git directory of the submodule to
be only a warning.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c                   | 16 ++++++++++++++++
 t/t2013-checkout-submodule.sh |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 50cbf5f13ed..689439a3d0c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1641,6 +1641,22 @@ int submodule_move_head(const char *path,
 		} else {
 			char *gitdir = xstrfmt("%s/modules/%s",
 				    get_git_common_dir(), sub->name);
+
+			if (!is_git_directory(gitdir)) {
+				/*
+				 * It is safe to assume we could just clone
+				 * the submodule here, as we passed the
+				 * is_submodule_active test above (i.e. the
+				 * user is interested in this submodule.
+				 *
+				 * However as this code path is exercised
+				 * for operations that typically do not involve
+				 * network operations, let's not do that for now.
+				 */
+				warning(_("Submodule '%s' missing"), path);
+				free(gitdir);
+				return 0;
+			}
 			connect_work_tree_and_git_dir(path, gitdir, 0);
 			free(gitdir);
 
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index c69640fc341..82ef4576b91 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -81,7 +81,7 @@ test_expect_success 'setup superproject with historic submodule' '
 	test_must_be_empty super1/.gitmodules
 '
 
-test_expect_failure 'checkout old state with deleted submodule' '
+test_expect_success 'checkout old state with deleted submodule' '
 	test_when_finished "rm -rf super1 sub1 super1_clone" &&
 	git clone --recurse-submodules super1 super1_clone &&
 	git -C super1_clone checkout --recurse-submodules historic_state
-- 
2.18.0

