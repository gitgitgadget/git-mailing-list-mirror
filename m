Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAAFC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 17:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiATRtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 12:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiATRtv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 12:49:51 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A15C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 09:49:51 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id o20-20020a656a54000000b003441a994d60so4071816pgu.6
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 09:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rMcxUYa+pYWoaPyu7/jTRBRqiC6fopgEoB9QwP13mZM=;
        b=R3xxZDa5hwL3RUM1zkTtxKM4EqLfkPwizsjDm2dMPnOiJuW8LsTHkDv53/+IsY6qyJ
         d4jeDnlEH2AcYLonj8TzZ+QZptjQMpZAeQJd85gGRdmCr66BwVRjXjPUDHXYZPu8ti7A
         ZeOjGmj27TkcmJuOk8eIzyxNU1VP5U9r8PeAn42oojBQa7/6dtQcjX8TG0GKbODn1O0S
         p072N0yK6SzVBiCnwjjj44wgOVSRmu37VDKq4WZIeQy5JSqN9vMSRFYTeHOyYsP9KSrw
         bEx/S0gJvCjgUdqkFsAE7ZtwID45oRTFVSG6LpjVhl9J4mgzOMQPHo0x+HMnspouzaCE
         kDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rMcxUYa+pYWoaPyu7/jTRBRqiC6fopgEoB9QwP13mZM=;
        b=FC9t8tQfNyr9q7n6Qfjz48pt2RuSm+PNhnPibqEQ/Bj9FnS0QdwPekGSywzkfynjVc
         1jxkK16dzii/tQIoK5ZOavcaIn3lvcncZyyGfTDhbhIb7cZEm/DMPvst3SpIr61vXXKv
         PCBT+A1c9m0fJUd2tyfObtbZQA00S2oYK5A0pVI1qq7ioPLTY84fUe9/RbOWc8J7pb9j
         hMMkMPRQrt0VvKTTQn5iCHlEQp594B+AxIs+ICiVwIzwDsTteKkozEkPB/zLZ2oNOVZz
         Nk5Vkn9WNK+jNGnir7h4Ob7KGjEaSdBIBywi+ekDw/YmlpENHS0WcMmTyIGOH51ZhRf2
         rqYA==
X-Gm-Message-State: AOAM532CyWGnMBj4yPoWH42uPWPCDqeuDNDE0/WNqjCZT9NnVukY7aNk
        I6dnTvdri8SuiiwnTrRy+Dq4SE9WFTRPfeV40YQNAKkxcUKKGzJFA+i6NjIipCd40LfIXta0HSN
        3e5jPckn9yz/KK+5RHKWeF66j8MbZuvlHZ5wo+0ShnUejmxkApTzBZpbO+0GoIKU=
X-Google-Smtp-Source: ABdhPJwHRUI+D4AlTUpHuQ2TWkt0jx7wQDRhCmVJKAURN8w8aRd3NYdjaOwh71oWPtfcZsVJ2ZQO0PQwpT2vYQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d883:b0:14a:4ba5:6e72 with SMTP
 id b3-20020a170902d88300b0014a4ba56e72mr149780plz.27.1642700990908; Thu, 20
 Jan 2022 09:49:50 -0800 (PST)
Date:   Thu, 20 Jan 2022 09:49:40 -0800
In-Reply-To: <20220120174942.94231-1-chooglen@google.com>
Message-Id: <20220120174942.94231-2-chooglen@google.com>
Mime-Version: 1.0
References: <20220119000056.58503-1-chooglen@google.com> <20220120174942.94231-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v7 1/3] fetch: use goto cleanup in cmd_fetch()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace an early return with 'goto cleanup' in cmd_fetch() so that the
string_list is always cleared (the string_list_clear() call is purely
cleanup; the string_list is not reused). This makes cleanup consistent
so that a subsequent commit can use 'goto cleanup' to bail out early.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/fetch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index eaab8056bf..0a625cb137 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2095,7 +2095,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			gtransport->smart_options->acked_commits = &acked_commits;
 		} else {
 			warning(_("protocol does not support --negotiate-only, exiting"));
-			return 1;
+			result = 1;
+			goto cleanup;
 		}
 		if (server_options.nr)
 			gtransport->server_options = &server_options;
@@ -2151,8 +2152,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		strvec_clear(&options);
 	}
 
-	string_list_clear(&list, 0);
-
 	prepare_repo_settings(the_repository);
 	if (fetch_write_commit_graph > 0 ||
 	    (fetch_write_commit_graph < 0 &&
@@ -2170,5 +2169,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (enable_auto_gc)
 		run_auto_maintenance(verbosity < 0);
 
+ cleanup:
+	string_list_clear(&list, 0);
 	return result;
 }
-- 
2.33.GIT

