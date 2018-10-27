Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77FC41F453
	for <e@80x24.org>; Sat, 27 Oct 2018 21:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeJ1GMd (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 02:12:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46552 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbeJ1GMd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 02:12:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id i4-v6so4622231wrr.13
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 14:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KVVoEirU5fqtOAMsVePQdF5wwdY5YpHK6TeQ8d0FceA=;
        b=jkQ19oEYMm6WffdtD5hqTdFrsF3B93RxkxP1Yn++TBPwXxdKRWxzsfzGvlmrN65Xj1
         jc7HgR+M86m4okmgQRWDT7b/rObj9fDF8GZr3MJUfmlKZJMX3aNMTa7RzbzmuyA/BEQv
         yxXxeO3cMGt4wRRM71tRrPQvtKWmHRjWct7mUfSMfD4ErSZCdH3a0vmt7zK7nuHhxumY
         DTh44458Zre6ut8lEWyZEmwmqR5sWH8h7xEprHzdD0K0oiu6Ujm5nOWLroXYMSuC9FTB
         4wtybYI6Anq/eGn2PJ2GfKvu5qr4z1yHxLxnF/P7Ty0oXgBLPOKsQPgdkYcpcGPr8oHb
         N3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KVVoEirU5fqtOAMsVePQdF5wwdY5YpHK6TeQ8d0FceA=;
        b=anPSdROLA1o2zna3N0L1jYb29VB0YGLB68P3om+7xFx7ekfVEWQpM6gQVHdnKDX8Op
         kX21FJuPR3R3PxI57ak6pMl+3ZnYbbPe5baVq/6oSdnXlgYDeOyZoIhMpCNTs8ewNIeS
         uq7vWkMcp6rpTBFdNAFLCg04ovaLce53v0ngYjv7RKy6zWfxlWUfwZ6DIAgmLLgbOLq1
         XbcCqQlQ4jzl1YhduucRK3XzNuvWUx22ovX3h5bxa4graAn9g2zRrQ3Qjj6X3XHNFEff
         Wps3+LRyN0iMHF0Mh44CL3xcsWxU64uTwlCiTuQtxaXhfx2AERLBOm9MvK/LUJjY3XVe
         fuBg==
X-Gm-Message-State: AGRZ1gJmtwIz64tyWWAV2FRXmocFwc/0c8vjNWKmhl0smwz8PPoVACYu
        mvhL7xaj9Ufop6U+OfkgSpLVLRC6
X-Google-Smtp-Source: AJdET5dsKIt8g3XThybyjMokihXlud+l8I8VaovKTCUNjxylSPlBF/CmbCm557hj0qXJ0qu3tMN+1A==
X-Received: by 2002:adf:e68d:: with SMTP id r13-v6mr861471wrm.239.1540675812279;
        Sat, 27 Oct 2018 14:30:12 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-19-179.w86-222.abo.wanadoo.fr. [86.222.18.179])
        by smtp.googlemail.com with ESMTPSA id t198-v6sm9842514wmd.9.2018.10.27.14.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 14:30:11 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 16/16] rebase--interactive: move transform_todo_file() to rebase--interactive.c
Date:   Sat, 27 Oct 2018 23:29:30 +0200
Message-Id: <20181027212930.9303-17-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181027212930.9303-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As transform_todo_file() is only needed inside of rebase--interactive.c,
it is moved there from sequencer.c.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--interactive.c | 20 ++++++++++++++++++++
 sequencer.c                   | 20 --------------------
 sequencer.h                   |  1 -
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 0f83422aa0..28e6947ecb 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -34,6 +34,26 @@ static int edit_todo_file(unsigned flags)
 	return 0;
 }
 
+static int transform_todo_file(unsigned flags)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res;
+
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	res = todo_list_write_to_file(&todo_list, todo_file,
+				      NULL, NULL, 0, 0, -1, flags);
+	todo_list_release(&todo_list);
+	return res;
+}
+
 static int get_revision_ranges(const char *upstream, const char *onto,
 			       const char **head_hash,
 			       char **revisions, char **shortrevisions)
diff --git a/sequencer.c b/sequencer.c
index 3069d4c6a2..a1b81bd544 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4344,26 +4344,6 @@ int todo_list_write_to_file(struct todo_list *todo_list, const char *file,
 	return res;
 }
 
-int transform_todo_file(unsigned flags)
-{
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	int res;
-
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
-	res = todo_list_write_to_file(&todo_list, todo_file,
-				      NULL, NULL, 0, 0, -1, flags);
-	todo_list_release(&todo_list);
-	return res;
-}
-
 static const char edit_todo_list_advice[] =
 N_("You can fix this with 'git rebase --edit-todo' "
 "and then run 'git rebase --continue'.\n"
diff --git a/sequencer.h b/sequencer.h
index 6a1a23541f..d35ca61d5d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -134,7 +134,6 @@ int sequencer_make_script(struct strbuf *out, int argc, const char **argv,
 			  unsigned flags);
 
 int sequencer_add_exec_commands(const char *command);
-int transform_todo_file(unsigned flags);
 int check_todo_list_from_file(void);
 int complete_action(struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-- 
2.19.1

