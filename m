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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A0BC433E9
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB2A22B51
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgLVAF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgLVAF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:05:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59083C061282
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l8so15808504ybj.16
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JBKVjRnbzqESSv9JqchxvmDRnDuoKg97DbxCNoBxVeU=;
        b=jo7HPMX9/haT7U5c7l30Hi5oT3X29kRasLgEbvpDMhN6D2xPnMK4Vcd1lgdlJzgi6G
         M7ArJD76GsfIESfOmY77rI8/cOfcOUYelGEvcEpNvgKzcZRCQIGakq3N6NB5GdQHfKVV
         3UteO7w4aYzH4TC3+7P649MD4z9fr4FrAyg0rSwYvpQgmJXxG8MO2uRbCf+2//TS4IXO
         H2UJ79GpWiLPOVPqWlE1HMg0SW5bps2bSqGNjEz+Tk95jmH/EiPWc9PzMaJJZbR0DyZE
         TARmp6bERjSdVUhuAw3mglBl7KqJHZ15CvBjbw6AzY+vXvGsxCXQYsegzESdaocAnpgy
         r4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JBKVjRnbzqESSv9JqchxvmDRnDuoKg97DbxCNoBxVeU=;
        b=FnR9y/qgINeS8bF5OXDpjR6vNBwF8LBnuyFS+yeZqNAv45JMnuQTIzz00rUBe6TZIb
         B6dohn6DRtCxmOFj5t5xd59ejnB5BbCtiybNGhTbqxIsZIsAGzd2MsePvmfX49FbP0sk
         qoONNGJjyNEhST0Ndnz1WXNPLWtwdy6PGlwQiha7x+D9ccs+y8FWKY+TwdSjpnxqIMZm
         L9ixjufWCrx2zSWOMRabrM5EwvokQrQpXP3SJOXLZqZZx6G2jd5rCB+oKzoqk9nt7CHl
         POQ0NLp7AXce+7CDYC1xwG+gZlUGeBkKLQRE8XjRVszPJILzQ2YS1JW68aIx824hA4Cc
         BIaQ==
X-Gm-Message-State: AOAM533XB3/860pqFbSrVfXrbWxd6lBiyNQEDCEMgN/m5nJfa08Nos0C
        H9MITs8+LqbhP0FMqjZtJ9H4CGEB64nv2aUSWUcyzthOWSjR/cBQKj18bfA7sxrDMVAhnu9toAX
        MKs/AYcgBmgLI6vHyE1abcCS/HdKtDAq3BFjBxZmpoo4I3Fv7Y1+TRXnhReA9hNQ5bNUxBqT2uw
        ==
X-Google-Smtp-Source: ABdhPJwGJ/KYXLzttTkSyVYRh88TEeVKplzXloMWuufDEALKagtbd7Wo4ea9e2D5gPAv0AtYWToCBkIVfrsV8udajKE=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:ab30:: with SMTP id
 u45mr25601483ybi.516.1608595488527; Mon, 21 Dec 2020 16:04:48 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:04:21 -0800
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Message-Id: <20201222000435.1529768-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000435.1529768-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v3 03/17] merge: use config-based hooks for post-merge hook
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
 Documentation/githooks.txt | 2 ++
 builtin/merge.c            | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 0842cd812c..f6ddf1aa22 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -236,6 +236,8 @@ save and restore any form of metadata associated with the working tree
 (e.g.: permissions/ownership, ACLS, etc).  See contrib/hooks/setgitperms.perl
 for an example of how to do this.
 
+Hooks executed during 'post-merge' will run in parallel by default.
+
 pre-push
 ~~~~~~~~
 
diff --git a/builtin/merge.c b/builtin/merge.c
index d654b6923c..717fbaa019 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -443,6 +443,7 @@ static void finish(struct commit *head_commit,
 		   const struct object_id *new_head, const char *msg)
 {
 	struct strbuf reflog_message = STRBUF_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
 	const struct object_id *head = &head_commit->object.oid;
 
 	if (!msg)
@@ -484,7 +485,9 @@ static void finish(struct commit *head_commit,
 	}
 
 	/* Run a post-merge hook */
-	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
+	strvec_push(&opt.args, squash ? "1" : "0");
+	run_hooks("post-merge", &opt);
+	run_hooks_opt_clear(&opt);
 
 	apply_autostash(git_path_merge_autostash(the_repository));
 	strbuf_release(&reflog_message);
-- 
2.28.0.rc0.142.g3c755180ce-goog

