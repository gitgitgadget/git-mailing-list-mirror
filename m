Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BC4B1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 16:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbeFZQRk (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 12:17:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39730 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752526AbeFZQRi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 12:17:38 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so2451168wmc.4
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 09:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q+gMQVq2ysHhZarAgowHBrHdp4YgPj6xPopvaPu8xX0=;
        b=Y3s9oqhzEBWrTdLPOTtnM+gWxyVivFnEJUx88LMVEa5tfLp5i4O19te+J7QunDRswn
         c39eEosf9qPU4lKiaEXQZGasN1+LeSeLjAhP6lwShITLyRQ31Fs+ZHDDRKj4WrcpfD5P
         kAL73paFZY5NaXIrUJHAklwbgnkg4rAqQ2BqOGE0v5MTuUzfFFzcZbU1qHrI9QZA/B27
         hY9D/qFKoxcDgKoQP9xbTtfUB1rs4dDkksuEYHXMJYMofOfyl7lMjTYbW0EW4tXUDFlp
         S43O55GR/lDgreBLhOnK01mlf6Q1l/nrSo9GJm3SGCV/EUQvSnyDqylEZWxzfJSks9FT
         yo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q+gMQVq2ysHhZarAgowHBrHdp4YgPj6xPopvaPu8xX0=;
        b=b51U4BbfPs2YE4BkUN6dLFFG3Sfs9qm+hdGyCngFTTcL1N+IAE4BnMv333OGczYpwg
         3rAsOQ7laViFlVcbzAUP8vGI6fOF9W611z/+/duVMm2s+MeA1BB95+Y/9IIq7ZCHr+aD
         31jSNoCdw4NXT8gtqJgbgA14mJGhxmpbnvRQnIkVhXp/TREHsX8aaiGP9M67pRtNskvw
         9wzrEZ4wn+1m4JSXwnwYtknosVgaQLEVB/Lq6njCWVtjbplqlf2700H3kNQ1YLFOCCvK
         dbb4ck4AdlsRpOOnWmMmZAUBbA+Re9xtX+eOtG6MvjiMjb17hwuCyoYMSO0LoQRHDmaR
         TCKg==
X-Gm-Message-State: APt69E0G+JUm3zQS/rrZhu8drWwPeop6nRC1/P+cUqbdIgH8dFVCY1jc
        Xkbthc9O0QkRjh6I2wtFSlWhS38r
X-Google-Smtp-Source: AAOMgpfFW0WOiqLlaD75oVdHyoO+DRxCaXHM7ijTMg/tDU6wu2KyvLdxSl+Vpa68zDhNWtaGx3pSNg==
X-Received: by 2002:a1c:8ec1:: with SMTP id q184-v6mr2258551wmd.104.1530029856628;
        Tue, 26 Jun 2018 09:17:36 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.googlemail.com with ESMTPSA id g88-v6sm3790319wmc.27.2018.06.26.09.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 09:17:35 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 1/2] sequencer: make two functions and an enum from sequencer.c public
Date:   Tue, 26 Jun 2018 18:16:42 +0200
Message-Id: <20180626161643.31152-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626161643.31152-1-alban.gruin@gmail.com>
References: <20180607103012.22981-1-alban.gruin@gmail.com>
 <20180626161643.31152-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes rebase_path_todo(), get_missign_commit_check_level() and the
enum check_level accessible outside sequencer.c.  This will be needed
for the rewrite of append_todo_help() from shell to C, as it will be in
a new library source file, rebase-interactive.c.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 8 ++------
 sequencer.h | 6 ++++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0a291c91f..881a4f7f4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -52,7 +52,7 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
  * the lines are processed, they are removed from the front of this
  * file and written to the tail of 'done'.
  */
-static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
+GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
 /*
  * The rebase command lines that have already been processed. A line
  * is moved here when it is first handled, before any associated user
@@ -4223,11 +4223,7 @@ int transform_todos(unsigned flags)
 	return i;
 }
 
-enum check_level {
-	CHECK_IGNORE = 0, CHECK_WARN, CHECK_ERROR
-};
-
-static enum check_level get_missing_commit_check_level(void)
+enum check_level get_missing_commit_check_level(void)
 {
 	const char *value;
 
diff --git a/sequencer.h b/sequencer.h
index c5787c6b5..08397b0d1 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -3,6 +3,7 @@
 
 const char *git_path_commit_editmsg(void);
 const char *git_path_seq_dir(void);
+const char *rebase_path_todo(void);
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
 
@@ -57,6 +58,10 @@ struct replay_opts {
 };
 #define REPLAY_OPTS_INIT { .action = -1, .current_fixups = STRBUF_INIT }
 
+enum check_level {
+	CHECK_IGNORE = 0, CHECK_WARN, CHECK_ERROR
+};
+
 /* Call this to setup defaults before parsing command line options */
 void sequencer_init_config(struct replay_opts *opts);
 int sequencer_pick_revisions(struct replay_opts *opts);
@@ -79,6 +84,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 
 int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
+enum check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
 int skip_unnecessary_picks(void);
 int rearrange_squash(void);
-- 
2.18.0

