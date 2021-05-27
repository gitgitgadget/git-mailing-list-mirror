Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D665C47088
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1845C613BE
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbhE0ALG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbhE0AK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:10:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5ACC061761
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so3655437ybo.11
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JXaUam9jeE2CtQntpC2GRDCstNDRkBt3WO/Vq6o61SQ=;
        b=VKOUgtpeV5WMe7ZvGIO+dFAxBcbAzsvFWUQ/GoGsW9j44Ao6ffrHuT0uPMeLCEqWDS
         teM7r3CfCO8AIqbSLC3pM4zqaAkFat4+6GUnIZToCFvWaUQJQew9pQRWQIjujxyUgbK5
         7drgeXQ1zasOhSdzNkJV5pvD9tIDAdQKiZ5fKTSroTttyZYQQUIz0JLiIwXU4KZsWxeO
         7JWPTW6YOVacCfnWeBi27gdjyQYzYyxf42YdCWe/ny5ZOPc4K2aogH0LpKqaPTVAK0h4
         6RQgeupwBf5jm8P5/bd/cVJUHqgweQJXd///D48hp9pD5S0F30XTv/Pbeslvw695nlfp
         aMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JXaUam9jeE2CtQntpC2GRDCstNDRkBt3WO/Vq6o61SQ=;
        b=CFEpcW8H+gyHGsdmxuhprvO5fzxYmDrtaCbliip4PNfm6AR0PLITsFJb1GuHRqk6c6
         901XUB/lP5Mmacs76cYHj7tny4v60euoljqkT8hLKYh2iU/naFZMI4/QB7M4pLv8p2sc
         LsiUpQp72OVTLtEMl2vpLqUbiLeQGzrkJtCfA5JYFgeGBIRjEjmCKnVZDNsUV9m/fsrl
         b3NqN/C6mcc4KFpfbDP0Rdm67fTk3xpBqzIozEwDztM5LIeO9rWH+7KrpJ2iKd/R4sWd
         X7vS5lA4KI/+z3OYST2rjw6snyCIEjl43NADONWPFA9nK9JN8VfdMyLQnoDETzYwoT9k
         /HGg==
X-Gm-Message-State: AOAM531ZjDL/nqbl8/hbxYvXQNbcF3eAOVCI/qnyAEAHWxRB7p2bFRTC
        ZMN1aj8kmgnMVNmSALCs8DKqc2i7gzwR1P6B4ZqUnWVDkYu0VQkYBtOqxcvbzms+hWrALXGlOvk
        ct3TSSyH1oRDUOCiy2m17Z7l/qXnyxkY7/ZqsWsOZG3M6Av0k735W5WN3TI3AhshU3FXPCpdEOQ
        ==
X-Google-Smtp-Source: ABdhPJywyxx3Q/X50IQRGggntxamuoP/DgknCwNEesl0JTH+UCDACYFv16IPrYXy4Ciaeo9PQtCBk9PinYlFQqzutDI=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a25:8804:: with SMTP id
 c4mr827637ybl.469.1622074160424; Wed, 26 May 2021 17:09:20 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:29 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-11-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 10/37] run-command: allow stdin for run_processes_parallel
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While it makes sense not to inherit stdin from the parent process to
avoid deadlocking, it's not necessary to completely ban stdin to
children. An informed user should be able to configure stdin safely. By
setting `some_child.process.no_stdin=1` before calling `get_next_task()`
we provide a reasonable default behavior but enable users to set up
stdin streaming for themselves during the callback.

`some_child.process.stdout_to_stderr`, however, remains unmodifiable by
`get_next_task()` - the rest of the run_processes_parallel() API depends
on child output in stderr.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 run-command.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index be6bc128cd..5237984ebe 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1693,6 +1693,14 @@ static int pp_start_one(struct parallel_processes *pp)
 	if (i == pp->max_processes)
 		BUG("bookkeeping is hard");
 
+	/*
+	 * By default, do not inherit stdin from the parent process - otherwise,
+	 * all children would share stdin! Users may overwrite this to provide
+	 * something to the child's stdin by having their 'get_next_task'
+	 * callback assign 0 to .no_stdin and an appropriate integer to .in.
+	 */
+	pp->children[i].process.no_stdin = 1;
+
 	code = pp->get_next_task(&pp->children[i].process,
 				 &pp->children[i].err,
 				 pp->data,
@@ -1704,7 +1712,6 @@ static int pp_start_one(struct parallel_processes *pp)
 	}
 	pp->children[i].process.err = -1;
 	pp->children[i].process.stdout_to_stderr = 1;
-	pp->children[i].process.no_stdin = 1;
 
 	if (start_command(&pp->children[i].process)) {
 		code = pp->start_failure(&pp->children[i].err,
-- 
2.31.1.818.g46aad6cb9e-goog

