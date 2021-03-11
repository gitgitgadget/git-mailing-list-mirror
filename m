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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A90C4361B
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B32A64FDF
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCKCLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhCKCL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:28 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747AAC061761
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:27 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id k10so14403353qte.17
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2NPGx/Kk0vx2WiO4XBV7sErSPH0XaHLjOZp5eGH8ocw=;
        b=r5o3hjsh0mD734q/57ERzBntx+UVDVYALBub93qxAaiLL9mYk39p67hsma/mB5L93W
         lHGhigGJAjGaR3BQde9zMKqrH7OnItg0nPSFMs/FlTV6mV4O7NdaTyLCg6jXcLFm3Uq3
         WF+PdeJCkDjdogHEn/q4wDXaI0Bhn3w0ugCQ0b0vBvEH1g6G7GiJpqO6/Nvxip92tzE1
         RBHTm19mcQgEeamW+6xiHNsga4YAJ+PB2T1d4/uU9HhylSn1bo214RdwsK6pqZjkBizx
         1vjrSCP9nhZT6VMCLw8/dGULQG0SsVdVOcEEp0q1WY1Jq9PvZzVRWn2/BVdspIfYKuku
         WZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2NPGx/Kk0vx2WiO4XBV7sErSPH0XaHLjOZp5eGH8ocw=;
        b=S8yhpBwi1BywslLHWbO3XbQ4b0PXpxwKpAHihWejalE4KxaqqtGevnbYEFwWhipF/f
         8PSlf2SD+YgmThYEX3rZsyYEQZ65+Iz02KX0tXUJrWtgwehKF+fVdLl4OKv+2iraxZeh
         j8dY4eXX4dmzNzhTRaokR2VWXmp233rXlC58shW+FMH1GIooXan6SLng3qSQ/HoD95+L
         L78LP/qHIa0D9LujtdPjtVzXdA4i9ijZE62yDVioIQHN1N0ORr1ZN/xUnNpehkw0eVUR
         1qubwneewP0yAnYx/DS/BUalA62x/yLNZcUG9JPEhKBiPZ3966oeKExCGBK2UnjJrspm
         ck2Q==
X-Gm-Message-State: AOAM531NSlMWCIyxEcPSxlVOw/f/SwZqX2RnMsJVKuEzDpPkb3nrtJVs
        HMhGymccWaJK8q4/dT3W1yNukQH8bV3zbMBgJC1b0B6hwPAyK3GyarWxB7vaLnCjNwWggBPJQV7
        JmtqM4/PHpUtbUkWRIWq9eiaDpNAXKvwfrcTAmBMOgLbl72wvz8gSxCsnjSRtzWB2xftgEMKojA
        ==
X-Google-Smtp-Source: ABdhPJx18Vxis0CtatM6DzSpdaFNhyxNP/Yjim0xXC/ef/b8V9Z3B2QimR4AlMG27QpMWSlNwSeO0tt8Wkg5sQW8SsQ=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:12a1:: with SMTP id
 w1mr5773159qvu.57.1615428686663; Wed, 10 Mar 2021 18:11:26 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:20 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-21-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 20/37] merge: use config-based hooks for post-merge hook
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach post-merge to use the hook.h library instead of the run-command.h
library to run hooks. This means that post-merge hooks can come from the
config as well as from the hookdir. post-merge is invoked only from
builtin/merge.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt | 3 +++
 builtin/merge.c            | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 0e7eb972ab..664ad4803e 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -242,6 +242,9 @@ save and restore any form of metadata associated with the working tree
 (e.g.: permissions/ownership, ACLS, etc).  See contrib/hooks/setgitperms.perl
 for an example of how to do this.
 
+Hooks executed during 'post-merge' will run in parallel, unless hook.jobs is
+configured to 1.
+
 pre-push
 ~~~~~~~~
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 33df744ab0..b473c8c5d3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -444,7 +444,9 @@ static void finish(struct commit *head_commit,
 		   const struct object_id *new_head, const char *msg)
 {
 	struct strbuf reflog_message = STRBUF_INIT;
+	struct run_hooks_opt opt;
 	const struct object_id *head = &head_commit->object.oid;
+	run_hooks_opt_init_async(&opt);
 
 	if (!msg)
 		strbuf_addstr(&reflog_message, getenv("GIT_REFLOG_ACTION"));
@@ -485,7 +487,9 @@ static void finish(struct commit *head_commit,
 	}
 
 	/* Run a post-merge hook */
-	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
+	strvec_push(&opt.args, squash ? "1" : "0");
+	run_hooks("post-merge", &opt);
+	run_hooks_opt_clear(&opt);
 
 	apply_autostash(git_path_merge_autostash(the_repository));
 	strbuf_release(&reflog_message);
-- 
2.31.0.rc2.261.g7f71774620-goog

