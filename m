Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10B5C20899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbdHBTlU (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:41:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34418 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbdHBTlS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:41:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id x64so166518wmg.1
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sBfx78PL9/V65cOblOdvZ/ZIflINXEkVlTWl42DRats=;
        b=GDTs/ErcIBkD9U41ugFfrzNDGMkiRWcdLD0V4Gxm5bWV5glKfp1AMrQXP1yJOigDJi
         hh25PRVwBo+zEyHGb7itGzCcC6qGYdcflictEqY8Uf9N7o7Nf/b1br386Ae0GeyvBUtg
         LFyCj1G66Eb/7KrGLiL4K8ulnOqZ9Ha8UHjmtZT4nQk+dNozamsYzOGN7YY6Ixxhy3ni
         gJht1STxn4jK6ZvvT9Dtu48Sqs2xFWvxiWvWwYZalK9vX7/Eum3RUwE36FbGW+dq52OB
         BKa/wrpr4643NBlCuLeoDb0Mr3pO3H4e11M4zLEzsApEZsB0+v/yYYpCVQwHV7r+AUzj
         JYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBfx78PL9/V65cOblOdvZ/ZIflINXEkVlTWl42DRats=;
        b=RHo51kVMGZj4nHdF+DV41GFpoxsiFBvGF/sZ6OoOzVYAmUWaRMZyeIYcfX8nyh2SHg
         AM5kHmbd8GEoTl+YOwcr3QtzQVisJpOEOJAxByByPFFVIfWrN4cWx77nxgkQwqMVOEoC
         2dSS9RvkbdarC4WFcL9FnBIwEbrXMwlMf+pV4k3NWdp1sLzp8Ift2sufzL6oxmjrILcM
         hC/ZhDSHzL9QFT8kOWmgteO8AaFVi89tr2ZpxI0shO44hLqOXKtmhRgQesbUaxz/4Cov
         ZNOb/aMa1HE7No4b6Wvtj9il4Irv1uVwavN+0EQMY5W4NdlrcAoAbfMMKoPBQ/tRjza+
         i6+A==
X-Gm-Message-State: AIVw111W7oBeps9XUrqoExYQd6xv51yMZgmruc4tHHd/fLCfYw/CenRE
        nHiMs5ZdUuTlKZqw
X-Received: by 10.28.226.137 with SMTP id z131mr4718140wmg.151.1501702876979;
        Wed, 02 Aug 2017 12:41:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id t13sm103576wra.22.2017.08.02.12.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 12:41:16 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 3/7] git.c: provide setup_auto_pager()
Date:   Wed,  2 Aug 2017 21:40:51 +0200
Message-Id: <82a3ffd035898992ae328fdb99a04be6ea48eb51.1501701128.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.12.ge2d9c4613
In-Reply-To: <cover.1501701128.git.martin.agren@gmail.com>
References: <cover.1500321657.git.martin.agren@gmail.com> <cover.1501701128.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous patch introduced a way for builtins to declare that they
will take responsibility for handling the `pager.foo`-config item. (See
the commit message of that patch for why that could be useful.)

Provide setup_auto_pager(), which builtins can call in order to handle
`pager.<cmd>`, including possibly starting the pager. Make this function
don't do anything if a pager has already been started, as indicated by
use_pager or pager_in_use().

Whenever this function is called from a builtin, git.c will already have
called commit_pager_choice(). Since commit_pager_choice() treats the
special value -1 as "punt" or "not yet decided", it is not a problem
that we might end up calling commit_pager_choice() once in git.c and
once (or more) in the builtin. Make the new function use -1 in the same
way and document it as "punt".

Don't add any users of setup_auto_pager just yet, one will follow in
a later patch.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin.h | 12 ++++++++++++
 git.c     | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/builtin.h b/builtin.h
index 0f3a7b770..42378f3aa 100644
--- a/builtin.h
+++ b/builtin.h
@@ -113,6 +113,18 @@ struct fmt_merge_msg_opts {
 extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 			 struct fmt_merge_msg_opts *);
 
+/**
+ * If a built-in has DELAY_PAGER_CONFIG set, the built-in should call this early
+ * when it wishes to respect the `pager.foo`-config. The `cmd` is the name of
+ * the built-in, e.g., "foo". If a paging-choice has already been setup, this
+ * does nothing. The default in `def` should be 0 for "pager off", 1 for "pager
+ * on" or -1 for "punt".
+ *
+ * You should most likely use a default of 0 or 1. "Punt" (-1) could be useful
+ * to be able to fall back to some historical compatibility name.
+ */
+extern void setup_auto_pager(const char *cmd, int def);
+
 extern int is_builtin(const char *s);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 79195ebbd..66832f232 100644
--- a/git.c
+++ b/git.c
@@ -33,6 +33,16 @@ static void commit_pager_choice(void) {
 	}
 }
 
+void setup_auto_pager(const char *cmd, int def)
+{
+	if (use_pager != -1 || pager_in_use())
+		return;
+	use_pager = check_pager_config(cmd);
+	if (use_pager == -1)
+		use_pager = def;
+	commit_pager_choice();
+}
+
 static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
 	const char **orig_argv = *argv;
-- 
2.14.0.rc1.12.ge2d9c4613

