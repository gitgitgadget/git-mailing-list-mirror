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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FE4C47088
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7922B613BE
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbhE0ALE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbhE0AKv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:10:51 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945DDC061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:17 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id i141-20020a379f930000b02902e94f6d938dso2103194qke.5
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wOw1tZPeGzt3zbyODH5czmUPBe+O1PfnhDXsKLtPqtc=;
        b=nmMKey+ANLGLQkPFp3mGmd3ZkkSBnH3j/5t0yvK1PBfU3flc9KxWSaVXYAsjoQVtLa
         HylrdwPS2dHWmV+njRxjH1rptVckhqpInp4rE3bLIsDKYkS8C7l76nDjo6MDHAY95FXc
         lp/XxNcgW+r/n/ACTaUT2EWybist26ToY+f5iSvIOC2462nn/4FiSgtauAVvqN6BihS/
         s5vOrDLiWIy3sUGHfi7IUKOUbH0rcNrqNzsyfSxzToLD5s/NENAyNZE8DHzzkqGqediP
         PgsiBEq2X9ytjn0a0QBHkT71DRsLZYgBjIaJpHB5qRviM285e+ptKwSboX0Waf/yjjFA
         wlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wOw1tZPeGzt3zbyODH5czmUPBe+O1PfnhDXsKLtPqtc=;
        b=qTF8ac6RAVSFI2zmtVsSEgcXvMP5PbGeatwIhYZ9cXO5AREVysxLyHUxfaZG6itYX3
         nKD6RDUto4qvJuSayiTlk18y3fwvh/gLF7sfdPw/iDX2xZzqKunGAA/tAgWmfnNOlasf
         o7Ss+S2Mskbijf69Gow2d3pJepCFcaXmD1sYq43/8iR0dCk8SbJAKridAvfaghG87t5S
         z1NpFh02ob/m2JxJIZFCOl4csuSuT5vFreXfjcQTx1iV/pzL0AF/bV64zCqyExirhA5n
         IPz9X3jghkF10AAQB4b8FrtzOz+M/HhYyHWU/B6AaLiCoOoPfqvYow3FZByoW7St3Oam
         GrTA==
X-Gm-Message-State: AOAM531EkBES7zIs8mNNlXI418XGheQigfH2i+PmuBcJk4jV1UOc0gAO
        H63zW60EWldl+IqqrWleTSeFGvqw/vjLCWLlVprMrGEqz3qd4SXzu2zdiAM3udKKq0HsxkfGt/Q
        vUcacyyb79B+kY20njzYp+2VtmtXeyzvhKvUUT3qwgyDBLgwYu9sKQn2pUbvr2yqAeEr5aNrGVg
        ==
X-Google-Smtp-Source: ABdhPJzkz6JJY+gMyHFb5ezkYgqRJCI29HShEO4ekhOsXmTKmqQSkEVs5u9cBY9AkxWivkC89zvUt5/foBC18zAOJWo=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:391:: with SMTP id
 l17mr844887qvy.22.1622074156713; Wed, 26 May 2021 17:09:16 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:27 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-9-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 08/37] hook: introduce hook_exists()
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a helper to easily determine whether any hooks exist for a given
hook event.

Many callers want to check whether some state could be modified by a
hook; that check should include the config-based hooks as well. Optimize
by checking the config directly. Since commands which execute hooks
might want to take args to replace 'hook.runHookDir', let
'hook_exists()' take a hookdir_opt to override that config.

In some cases, external callers today use find_hook() to discover the
location of a hook and then run it manually with run-command.h (that is,
not with run_hook_le()). Later, those cases will call hook.h:run_hook()
directly instead.

Once the entire codebase is using hook_exists() instead of find_hook(),
find_hook() can be safely rolled into hook_exists() and removed from
run-command.h.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 hook.c | 19 +++++++++++++++++++
 hook.h | 10 ++++++++++
 2 files changed, 29 insertions(+)

diff --git a/hook.c b/hook.c
index b631da659b..008167dbe5 100644
--- a/hook.c
+++ b/hook.c
@@ -248,6 +248,25 @@ void run_hooks_opt_init(struct run_hooks_opt *o)
 	o->run_hookdir = configured_hookdir_opt();
 }
 
+int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir)
+{
+	const char *value = NULL; /* throwaway */
+	struct strbuf hook_key = STRBUF_INIT;
+	int could_run_hookdir;
+
+	if (should_run_hookdir == HOOKDIR_USE_CONFIG)
+		should_run_hookdir = configured_hookdir_opt();
+
+	could_run_hookdir = (should_run_hookdir == HOOKDIR_INTERACTIVE ||
+				should_run_hookdir == HOOKDIR_WARN ||
+				should_run_hookdir == HOOKDIR_YES)
+				&& !!find_hook(hookname);
+
+	strbuf_addf(&hook_key, "hook.%s.command", hookname);
+
+	return (!git_config_get_value(hook_key.buf, &value)) || could_run_hookdir;
+}
+
 void run_hooks_opt_clear(struct run_hooks_opt *o)
 {
 	strvec_clear(&o->env);
diff --git a/hook.h b/hook.h
index fb5132305f..5f770b53ed 100644
--- a/hook.h
+++ b/hook.h
@@ -23,6 +23,7 @@ struct list_head* hook_list(const char *hookname);
 
 enum hookdir_opt
 {
+	HOOKDIR_USE_CONFIG,
 	HOOKDIR_NO,
 	HOOKDIR_ERROR,
 	HOOKDIR_WARN,
@@ -56,6 +57,15 @@ struct run_hooks_opt
 void run_hooks_opt_init(struct run_hooks_opt *o);
 void run_hooks_opt_clear(struct run_hooks_opt *o);
 
+/*
+ * Returns 1 if any hooks are specified in the config or if a hook exists in the
+ * hookdir. Typically, invoke hook_exsts() like:
+ *   hook_exists(hookname, configured_hookdir_opt());
+ * Like with run_hooks, if you take a --run-hookdir flag, reflect that
+ * user-specified behavior here instead.
+ */
+int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir);
+
 /*
  * Runs all hooks associated to the 'hookname' event in order. Each hook will be
  * passed 'env' and 'args'.
-- 
2.31.1.818.g46aad6cb9e-goog

