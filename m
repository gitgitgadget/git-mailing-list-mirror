Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0971C433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 09:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789B520679
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 09:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0p/WqBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgFZJzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgFZJzn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 05:55:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BE4C08C5DB
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 02:55:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so8236147wme.5
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 02:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=3PTj4VRENxzwWcqR4TZlHeHBhBiWUf/is80xJx6e5CY=;
        b=C0p/WqBQN2zBmKvhmwE+R7jmUbH3LLnCdVm6izDiVEm+KaH6fzx8fAqfIGm+0tvuwK
         IsOczr03sQCTr/Ly/lyA4kG7/RIWqilxMyR7/FuNMcQinxSP2KL6Q1GgzyZnOi14crCL
         4eGW4vyw46aSa+yBnj4ZAIQxD0EXfZ6ms1JiuX/1c6NQoP+AwP8mqWQR9oepaQe5ey2q
         GvoxvMg3gaSoda6hdTy+02ARAGxES4ujUVA92+vYe+ZisNMya2xXoKEOytVMYBcxENih
         pvxviD97jb5JhWGDwb+jU+8zUPg0gESr+fFw80sLp3Chrf7x2NVfBcrPwbKXbD3lr5cX
         tKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=3PTj4VRENxzwWcqR4TZlHeHBhBiWUf/is80xJx6e5CY=;
        b=cC3y09QTo1S9Wa82PBsGIkmSlwjNhdJ7iarKL0Lfqv0PNO/1ZAA3gZCf0JP+2ukk28
         wRx2spCgoInwnV1cgvc9/mv3LYKgwn9ChtzfZScEvYrhycOtGDrMqccsbu+v3BJH1RQw
         cJZAnbsdTkOyPPioDHCS0QYbCeT/Fg4O6er1Q692rrHvs3+TQqwgSvkD0eCMuK91YV3g
         lPY194Ib8TNo9HMT4bGdIZz3QuPBNtJ2N47bs8YJ+ExyPAdGfcrx490ElXKx4ORHqs3m
         P+5JLc0eFbUqwwfs3+2Dlcn7Z0X8uwf1sLg4TL5ZRATONKcyWcuvEtcwzfpWbX6yzY5S
         A+Bg==
X-Gm-Message-State: AOAM533iQcFB4qBKLCJ78/+yILfR2s3YK3RDtE0meUSVBgBFkmQEd3qA
        1GlMcp+RX6Mr5wkgXRgwPE0=
X-Google-Smtp-Source: ABdhPJwqRP9W+zH8kDLmubovp6TovvZRxkmPfPSMOK5bAPEgwuqF/aSBTkysI/RAskYM/dCGrSQu0w==
X-Received: by 2002:a7b:cb59:: with SMTP id v25mr2437565wmj.141.1593165341465;
        Fri, 26 Jun 2020 02:55:41 -0700 (PDT)
Received: from localhost.localdomain (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id n14sm14327755wro.81.2020.06.26.02.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 02:55:40 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v5 3/5] sequencer: rename amend_author to author_to_free
Date:   Fri, 26 Jun 2020 10:55:26 +0100
Message-Id: <20200626095528.117524-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626095528.117524-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200626095528.117524-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>

The purpose of amend_author was to free() the malloc()'d string
obtained from get_author() when amending a commit. But we can
also use the variable to free() the author at our convenience.
Rename it to convey this meaning.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 368d397970..29f6d1bc39 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1335,7 +1335,7 @@ static int try_to_commit(struct repository *r,
 	struct commit_extra_header *extra = NULL;
 	struct strbuf err = STRBUF_INIT;
 	struct strbuf commit_msg = STRBUF_INIT;
-	char *amend_author = NULL;
+	char *author_to_free = NULL;
 	const char *hook_commit = NULL;
 	enum commit_msg_cleanup_mode cleanup;
 	int res = 0;
@@ -1357,7 +1357,7 @@ static int try_to_commit(struct repository *r,
 			strbuf_addstr(msg, orig_message);
 			hook_commit = "HEAD";
 		}
-		author = amend_author = get_author(message);
+		author = author_to_free = get_author(message);
 		unuse_commit_buffer(current_head, message);
 		if (!author) {
 			res = error(_("unable to parse commit author"));
@@ -1474,7 +1474,7 @@ static int try_to_commit(struct repository *r,
 	free_commit_extra_headers(extra);
 	strbuf_release(&err);
 	strbuf_release(&commit_msg);
-	free(amend_author);
+	free(author_to_free);
 
 	return res;
 }
-- 
2.27.0

