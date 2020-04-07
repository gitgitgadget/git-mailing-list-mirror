Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE36C2BB85
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FE4207FF
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkk2Bsmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgDGO2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:35 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43509 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgDGO2b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:31 -0400
Received: by mail-qk1-f194.google.com with SMTP id 13so1782620qko.10
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w6B8gL43WsD2IPA1NAxl28oY+FECJVQaDKQvwbKTeJo=;
        b=qkk2BsmiHyWDIba7wWtMEg+7yDNNoXMFiopotvvYJzhgBrJ88m+w4/VlXr9CAn1Ha3
         md4+qExwykP8XVH+h+Fc5zn93RqSNljB7D1pYmItplJNybdBH34zzin6AXFb6Yy0X1lE
         K+HVNCGvXA+yyMEbjcTa4yMZPsPYUwFXIpfWZIYdXW3tJyAO3qYLTSpxsF6/X/oB8Wxi
         1n3GuQzbZcamQx6JQbk8qfxc836ro+/Jxc+IYG+WK9H430zrA4/E9/12QxB7ocMIntyH
         E1B9hXf1SzmFEMMcr0S/cToYmdLhJ1Z05GIjQBOYvbUZKp5IxQm0KG8uFPuBfA7UNOKa
         SzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w6B8gL43WsD2IPA1NAxl28oY+FECJVQaDKQvwbKTeJo=;
        b=N/TQVjUWON6kLYBCUabhBUP0bh1ZMza1oUV94MeweQWQ/y5aARZxl60NkwaeJ3zhl0
         VILCS2F/Ndc1i6iYLkWX64nB+izHWcuGKYcQpRfZy7xSJPogpdkg22/EcbGyQUGjKOUN
         Acnsc0x8pm6RflMu2WWic5HiC5/Uck8wdKQPvWrKTdPmqWXziS3X4UlfnAVef3uxgtPY
         Inprm2k/g4rp1X728POvs0jw/n8ZMF89Y6EiC6PvTROahxduYRajau/sKoKm1nXR9Di0
         CaKTZCPhAqL7rB3teIFpPDtZ9PbcPMHK/XwvZsmCoTVczrAGXEZt9makFKYxERgZB/6/
         TspA==
X-Gm-Message-State: AGi0PubPb2hJ5Q5GkgoohS5DnQWlHlNh7DgCPCl53aSXu9yKQHdwhQD0
        EDwS9h2uq3E+pH4jJqspF5mPVG6v
X-Google-Smtp-Source: APiQypJzN2RYMbRyQ0X7OsRFkkl7gBToJSnQs4E6tb0+Ptk6pHpgbrOO1zaBWwvycTfgHJ0wT1srDw==
X-Received: by 2002:a37:4885:: with SMTP id v127mr2577173qka.173.1586269709496;
        Tue, 07 Apr 2020 07:28:29 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:28 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 09/22] sequencer: make apply_autostash() accept a path
Date:   Tue,  7 Apr 2020 10:27:56 -0400
Message-Id: <3dbed2a832a713cba677bb482668a39ffd7f5ebf.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to make apply_autostash() more generic for future extraction, make
it accept a `path` argument so that the location from where to read the
reference to the autostash commit can be customized. Remove the `opts`
argument since it was unused before anyway.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0d98ddc33c..4917c70a86 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3657,13 +3657,13 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 	return -1;
 }
 
-static int apply_autostash(struct replay_opts *opts)
+static int apply_autostash(const char *path)
 {
 	struct strbuf stash_sha1 = STRBUF_INIT;
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
 
-	if (!read_oneliner(&stash_sha1, rebase_path_autostash(),
+	if (!read_oneliner(&stash_sha1, path,
 			   READ_ONELINER_SKIP_IF_EMPTY)) {
 		strbuf_release(&stash_sha1);
 		return 0;
@@ -3756,7 +3756,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 		return error(_("%s: not a valid OID"), orig_head);
 
 	if (run_git_checkout(r, opts, oid_to_hex(onto), action)) {
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 		return error(_("could not detach HEAD"));
 	}
@@ -4070,7 +4070,7 @@ static int pick_commits(struct repository *r,
 				run_command(&hook);
 			}
 		}
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 
 		if (!opts->quiet) {
 			if (!opts->verbose)
@@ -5079,7 +5079,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		todo_list_add_exec_commands(todo_list, commands);
 
 	if (count_commands(todo_list) == 0) {
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 
 		return error(_("nothing to do"));
@@ -5090,12 +5090,12 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	if (res == -1)
 		return -1;
 	else if (res == -2) {
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 
 		return -1;
 	} else if (res == -3) {
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 		todo_list_release(&new_todo);
 
-- 
2.26.0.159.g23e2136ad0

