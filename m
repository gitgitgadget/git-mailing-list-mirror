Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490BF202F3
	for <e@80x24.org>; Wed, 20 Jul 2016 17:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbcGTRZP (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 13:25:15 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35856 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495AbcGTRY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 13:24:57 -0400
Received: by mail-lf0-f65.google.com with SMTP id 33so4000601lfw.3
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 10:24:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XC44HthdrMqmY/oNG8R/z+oqGSvnsRHDhuNTJ3raaa8=;
        b=fCR5ohIo9SuZ+soicmE2o5QlyLCgDdnbNqDFBOXUE0/vNjlpqS3d5IgVfK3KbxxhpJ
         9c+jD9tFYhrc5Rhuqdi22DrRdpMZwciS5IaR/N+iJbcOmvhD0DDSYMEMJtlsa4gmilEq
         s/mEb9fqtNGsnZxuXE+YvQ1u3Nkuc68gV1k8+b125kjaGyCa93nB+m9LwdahiRNHkNx1
         MpL+e8nm6WntyNmobpvwe8GYjM682zwVdNwTyl3wpiAt4rwbSJOv6w3+bDEIAr0jzgI1
         OZXfAzRPvoIE6eWt+T9pmwc0J6cajwNQEjAthFPUSu/S0tgCgIN+hrcndA/IyZpth7Dl
         5EKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XC44HthdrMqmY/oNG8R/z+oqGSvnsRHDhuNTJ3raaa8=;
        b=HuBs1S5yS+mPOSPZbPY8ltg5m4IwnN4MdE9oonnzxW50kSnHVyvVxcjTkAWU6C5TgA
         0crvx8U12RgUlGbxoiGo5HcoTAiuao+HBpKCH7Q+CGBf9UPcsOwe7mRavSniNSGx5Ouc
         2eNUHZN/5E5V1iV4wKnalBBwJt87zjJq3wx42kVgSivFwTZORnQBtHkOVVb/Y3SaGNzx
         OdAEoo8wNW0/mgsDDe7qf/9Q6cyoOkuetk5MV+eqCcABTpeUjrIDidUKPCMUAFo+5IzU
         CX8RwkexCTC86oDhpHbva3Xj7hXXtzHsDc1rgv/tH1f5VygGFjJ2DSzyymJvNYGjI0LH
         EeCA==
X-Gm-Message-State: ALyK8tKCWMXak+E2VbGC+iEWfqsvnOxnhlAr9SgolXBAaWXBhJtRjjhJl7lrTlGgq5A+tQ==
X-Received: by 10.25.87.12 with SMTP id l12mr18803314lfb.153.1469035495972;
        Wed, 20 Jul 2016 10:24:55 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g74sm777884ljg.24.2016.07.20.10.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jul 2016 10:24:54 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	max@max630.net, Junio C Hamano <gitster@pobox.com>,
	git@drmicha.warpmail.net, Jens.Lehmann@web.de,
	larsxschneider@gmail.com, sbeller@google.com, mhagger@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 2/4] submodule: update core.worktree using git-config
Date:	Wed, 20 Jul 2016 19:24:17 +0200
Message-Id: <20160720172419.25473-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.566.gbd532d4
In-Reply-To: <20160720172419.25473-1-pclouds@gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To access a separate repository, the first step should be read its
config file to determine if this repository layout is supported or
not, or if we understand all repo extensions, of it is a linked
worktree. Only then should know where to update the config file.

Unfortunately, our C code base is not ready for doing all that in the
same process. The repo detection is not meant to be used for peeking
in other repository, and config code would read config.worktree that
is in _current_ $GIT_DIR.

For now, let's spawn a new process and let all that done separately.

PS. submodule-helper also updates core.worktree. But in there, we
create a new clone, we know what is the initial repository layout, so
we know we can simply update "config" file without risks.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 submodule.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index abc2ac2..b912871 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1128,7 +1128,9 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
 	const char *real_work_tree = xstrdup(real_path(work_tree));
+	struct child_process cp = CHILD_PROCESS_INIT;
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
@@ -1136,13 +1138,17 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 		   relative_path(git_dir, real_work_tree, &rel_path));
 
 	/* Update core.worktree setting */
-	strbuf_reset(&file_name);
-	strbuf_addf(&file_name, "%s/config", git_dir);
-	git_config_set_in_file(file_name.buf, "core.worktree",
-			       relative_path(real_work_tree, git_dir,
-					     &rel_path));
+	strbuf_addstr(&path, relative_path(real_work_tree, git_dir,
+					   &rel_path));
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "-C", work_tree, NULL);
+	argv_array_pushl(&cp.args, "--work-tree", ".", NULL);
+	argv_array_pushl(&cp.args, "config", "core.worktree", path.buf, NULL);
+	if (run_command(&cp) < 0)
+		die(_("failed to update core.worktree for %s"), git_dir);
 
 	strbuf_release(&file_name);
+	strbuf_release(&path);
 	strbuf_release(&rel_path);
 	free((void *)real_work_tree);
 }
-- 
2.9.1.566.gbd532d4

