Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5A2C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 20:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbiBYUos (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiBYUor (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 15:44:47 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B741AE65C
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 12:44:14 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s24so9023745edr.5
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 12:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=K0l1Bkkuxz3jGu8w2r3XvRqq+NjRiZm0tP9alprILFk=;
        b=GD0pyBK+dh/C5vwq7K6H7Bk5Y3A3+50+MdUxrwUFXOeJIzllwkvvOu1oReDaDsby9C
         KXDs5bT5yaIdWxyrtS1iY46ML2JcQ4FqYwg6CW6Sk6wN4E3GrSLb1YECJUaAEJpBwYIi
         LBNhlFp5IbPWPwEz6w4Nu3Botbw3ltnSf9qPtX5Da4tx8ReLySN/6X5okqvSGICrrMkE
         uYmy1DGzv9SmyK16l5cGCL98u5qXUqcs5AkTtGGgwpFgz6C2PDZkJ3JKwaFINbiUUDtz
         drMfJbV5OHwipjNftWyNktRL1V7kQ+c+imoHFsMh5xgxi0sTv3dQy0GWYGu8roU/JItK
         6UMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=K0l1Bkkuxz3jGu8w2r3XvRqq+NjRiZm0tP9alprILFk=;
        b=UMt4htWm9nv5RFmYRG1hulsUeZ7kGQto3/yMsynvPc9hJqsDiWmKz+MHhki9A+H9sG
         HwZoxWG8itHg5VUqhW6JAcPdHZZ2+2f7DRonmxAWX5eLq8tDUAfuJatrnLiiqgG1/Etb
         6TUG/T3lp3b/VnocTYQoWzG+IFe13mEMyRgk3THY/1f/5Fj5QxXzzJkORMjVHqsNi/c5
         Y5WeSl3tmzMSRqe6mHml6zOHP6ZgnGx8RSimg9nEaYSnRZ6T5QIgwqSyzzn/GtWqJG8C
         T7Nb7MLjNSUv6ZN4waTcmHryFJFAmq2s2u7uQzpRT/1doGYf8Veosh31uqdegcjHlfvv
         EUuA==
X-Gm-Message-State: AOAM531QLkOfPMNjr1ufl/5LWeNYCPQw3NO5eAtr8pbQGBbY0OrVHAJq
        LVgvgcCOHCpNlqKth2QFE/FjnSjVgK9/gQ==
X-Google-Smtp-Source: ABdhPJwgNSiIQEbxgFSRbigpxrJFXAb56w5AzGGQptvNJ78L1xc7wvuY9Ko/ZpJ3HT2aTLXoXK141w==
X-Received: by 2002:aa7:d2d5:0:b0:410:8765:d2de with SMTP id k21-20020aa7d2d5000000b004108765d2demr8823310edr.148.1645821853163;
        Fri, 25 Feb 2022 12:44:13 -0800 (PST)
Received: from gmgdl ([109.36.128.147])
        by smtp.gmail.com with ESMTPSA id b15-20020a50cccf000000b0040f74c6abedsm1886246edj.77.2022.02.25.12.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 12:44:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNhRj-000gh7-WC;
        Fri, 25 Feb 2022 21:44:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 05/23] fsmonitor-settings: bare repos are incompatible
 with FSMonitor
Date:   Fri, 25 Feb 2022 21:42:09 +0100
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <44cc61e186cb65fa6b2c1d5a0f080fc0b2265e57.1644940773.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <44cc61e186cb65fa6b2c1d5a0f080fc0b2265e57.1644940773.git.gitgitgadget@gmail.com>
Message-ID: <220225.86ee3q7k2s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 15 2022, Jeff Hostetler via GitGitGadget wrote:

> +static void create_reason_message(struct repository *r,
> +				  struct strbuf *buf_reason)
> +{
> +	struct fsmonitor_settings *s = r->settings.fsmonitor;
> +
> +	switch (s->reason) {
> +	case FSMONITOR_REASON_ZERO:
> +		return;
> +
> +	case FSMONITOR_REASON_BARE:
> +		strbuf_addstr(buf_reason,
> +			      _("bare repos are incompatible with fsmonitor"));
> +		return;
> +
> +	default:
> +		BUG("Unhandled case in create_reason_message '%d'", s->reason);
> +	}
> +}
> +
> +enum fsmonitor_reason fsm_settings__get_reason(struct repository *r,
> +					       struct strbuf *buf_reason)
> +{
> +	lookup_fsmonitor_settings(r);
> +
> +	strbuf_reset(buf_reason);
> +	if (r->settings.fsmonitor->mode == FSMONITOR_MODE_INCOMPATIBLE)
> +		create_reason_message(r, buf_reason);
> +
> +	return r->settings.fsmonitor->reason;
> +}

This API (just looking at one small bit discussed because related bits
conflict with another series) seems to require a lot of ceremony just to
get a const char * error.

I tried this on top of "seen", and the parts I compile on Linux (so not
the fsmonitor--daemon.c) were happy with it.

 builtin/fsmonitor--daemon.c | 14 +++++++-------
 builtin/update-index.c      |  9 ++++-----
 fsmonitor-settings.c        | 47 +++++++++++++++------------------------------
 fsmonitor-settings.h        |  5 +++--
 4 files changed, 29 insertions(+), 46 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 591433e897d..7ad7bc718b3 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1496,7 +1496,7 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 {
 	const char *subcmd;
 	int free_console = 0;
-
+	enum fsmonitor_mode fsm_mode;
 	struct option options[] = {
 		OPT_BOOL(0, "free-console", &free_console, N_("free console")),
 		OPT_INTEGER(0, "ipc-threads",
@@ -1524,12 +1524,12 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 	prepare_repo_settings(the_repository);
 	fsm_settings__set_ipc(the_repository);
 
-	if (fsm_settings__get_mode(the_repository) == FSMONITOR_MODE_INCOMPATIBLE) {
-		struct strbuf buf_reason = STRBUF_INIT;
-		fsm_settings__get_reason(the_repository, &buf_reason);
-		error("%s '%s'", buf_reason.buf, xgetcwd());
-		strbuf_release(&buf_reason);
-		return -1;
+	fsm_mode = fsm_settings__get_mode(the_repository);
+	if (fsm_mode == FSMONITOR_MODE_INCOMPATIBLE) {
+		enum fsmonitor_reason fsm_reason = fsm_settings__get_reason(the_repository);
+		const char *reason = fsm_settings_incompatible_reason_msg(fsm_mode, fsm_reason);
+
+		return error("%s", reason ? reason : "???");
 	}
 
 	if (!strcmp(subcmd, "start"))
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 61b0b98ccaf..f8f638d33d9 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1237,13 +1237,12 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	if (fsmonitor > 0) {
 		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+		enum fsmonitor_reason fsm_reason = fsm_settings__get_reason(r);
 
 		if (fsm_mode == FSMONITOR_MODE_INCOMPATIBLE) {
-			struct strbuf buf_reason = STRBUF_INIT;
-			fsm_settings__get_reason(r, &buf_reason);
-			error("%s", buf_reason.buf);
-			strbuf_release(&buf_reason);
-			return -1;
+			const char *reason = fsm_settings_incompatible_reason_msg(fsm_mode, fsm_reason);
+
+			return error("%s", reason ? reason : "???");
 		}
 
 		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index de69ace246a..e37b342aa2b 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -103,6 +103,13 @@ enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
 	return r->settings.fsmonitor->mode;
 }
 
+enum fsmonitor_reason fsm_settings__get_reason(struct repository *r)
+{
+	lookup_fsmonitor_settings(r);
+
+	return r->settings.fsmonitor->reason;
+}
+
 const char *fsm_settings__get_hook_path(struct repository *r)
 {
 	lookup_fsmonitor_settings(r);
@@ -142,43 +149,19 @@ void fsm_settings__set_disabled(struct repository *r)
 	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
 }
 
-static void create_reason_message(struct repository *r,
-				  struct strbuf *buf_reason)
+const char *fsm_settings_incompatible_reason_msg(enum fsmonitor_mode mode,
+						 enum fsmonitor_reason reason)
 {
-	struct fsmonitor_settings *s = r->settings.fsmonitor;
+	assert(mode == FSMONITOR_MODE_INCOMPATIBLE);
 
-	switch (s->reason) {
+	switch (reason) {
 	case FSMONITOR_REASON_ZERO:
-		return;
-
+		return NULL;
 	case FSMONITOR_REASON_BARE:
-		strbuf_addstr(buf_reason,
-			      _("bare repos are incompatible with fsmonitor"));
-		return;
-
+		return _("bare repos are incompatible with fsmonitor");
 	case FSMONITOR_REASON_VIRTUAL:
-		strbuf_addstr(buf_reason,
-			      _("virtual repos are incompatible with fsmonitor"));
-		return;
-
+		return _("virtual repos are incompatible with fsmonitor");
 	case FSMONITOR_REASON_REMOTE:
-		strbuf_addstr(buf_reason,
-			      _("remote repos are incompatible with fsmonitor"));
-		return;
-
-	default:
-		BUG("Unhandled case in create_reason_message '%d'", s->reason);
+		return _("remote repos are incompatible with fsmonitor");
 	}
 }
-
-enum fsmonitor_reason fsm_settings__get_reason(struct repository *r,
-					       struct strbuf *buf_reason)
-{
-	lookup_fsmonitor_settings(r);
-
-	strbuf_reset(buf_reason);
-	if (r->settings.fsmonitor->mode == FSMONITOR_MODE_INCOMPATIBLE)
-		create_reason_message(r, buf_reason);
-
-	return r->settings.fsmonitor->reason;
-}
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index fca25887c0f..81be1ef1801 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -25,9 +25,10 @@ void fsm_settings__set_hook(struct repository *r, const char *path);
 void fsm_settings__set_disabled(struct repository *r);
 
 enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
+enum fsmonitor_reason fsm_settings__get_reason(struct repository *r);
 const char *fsm_settings__get_hook_path(struct repository *r);
-enum fsmonitor_reason fsm_settings__get_reason(struct repository *r,
-					       struct strbuf *buf_reason);
+const char *fsm_settings_incompatible_reason_msg(enum fsmonitor_mode mode,
+						 enum fsmonitor_reason reason);
 
 struct fsmonitor_settings;
 

