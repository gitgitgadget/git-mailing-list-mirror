Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7FE1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 08:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeKIRsR (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:48:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37788 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbeKIRsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 12:48:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id o15-v6so881370wrv.4
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 00:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d35r7NzY7xQi55HPfborvunr3CqvrJqDvpnt9k6KlIE=;
        b=sNXGEt+tBzp5mi1AnFuVlxZ4oJvY4jvz5ePEcZTGlOHQ2fxqio09klQIdg+oFSQYip
         xx57Z+OyRYQjOynyn30ukgsJP7kCQnmDObD9aelyhSdc4GSpJ2tPr4vag9SQTF29Pp0K
         Y4lRKN9pceXetPIL2wtb8/+gmqNi+tckMtS9ozQRihppWdgq224Le3qocFqnfTOmkP7A
         ghbyPKd6lJ4NVD7mzlrD4WwVu5x/li0Fp/+cylft5jjBVl6wUFScEevCJqL0JJe8ATIM
         oEjpuIzQHAnn/sJ6+NwcjbAOStgrvSNaiAs1MF44aA11Gfjr0/I/iZ/dMn9vdGHc3iUW
         Qvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d35r7NzY7xQi55HPfborvunr3CqvrJqDvpnt9k6KlIE=;
        b=USS7yw1aSHRUaHlqEE5L8xXRtAJNW9C9EE5IfzR437UDswBXmu6tb8aImQDAvi4YGH
         GXoK3ZntD9GzsDKPQ3aZduOdoc1JZ1It+E2BfHat4qThrD4Q7ujCyVR4Ygm+Aoc640XY
         8CvYxpPiPXCfk+Z9q0PuJUriO/V8yTUAc8Vyx4tPuOJogtfAUB8M3zX+/TE6Fuv17BFG
         9EtmAQwCvB0DlxYatCxIn4eJ4UFTAe4SCGkAupgy2ZjuFm63ElpEgjgxHzB+M+ArIa58
         mtM3X81a7g4iMl6Z8O5aDTW5+uj+xVlz+kiLVl/pGAntkN0LoGPAoQva9wVIZoRhYCmt
         2K7w==
X-Gm-Message-State: AGRZ1gL5Pc32LmaRJ+jRBQ/1VA/vbC2ILHBiKifZ46bbXEXc8s2GeW3O
        ObZd7zecuSx0526cMoaKYm/EcdDO
X-Google-Smtp-Source: AJdET5fu4TtCKxpOBm4zqqWnB7m6o3W9PyeyxeTj7r5GxTw6gU7sCDi/MrNcFdtzjxLMVzZcDL3+WA==
X-Received: by 2002:adf:9403:: with SMTP id 3-v6mr6952115wrq.54.1541750929039;
        Fri, 09 Nov 2018 00:08:49 -0800 (PST)
Received: from andromeda.lan (atoulouse-658-1-60-221.w92-136.abo.wanadoo.fr. [92.136.157.221])
        by smtp.googlemail.com with ESMTPSA id x194-v6sm3003973wmd.41.2018.11.09.00.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 00:08:48 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 16/16] rebase--interactive: move transform_todo_file() to rebase--interactive.c
Date:   Fri,  9 Nov 2018 09:08:05 +0100
Message-Id: <20181109080805.6350-17-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181109080805.6350-1-alban.gruin@gmail.com>
References: <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181109080805.6350-1-alban.gruin@gmail.com>
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
index 6871990544..580c6a3822 100644
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
+				      NULL, NULL, -1, flags);
+	todo_list_release(&todo_list);
+	return res;
+}
+
 static int get_revision_ranges(const char *upstream, const char *onto,
 			       const char **head_hash,
 			       char **revisions, char **shortrevisions)
diff --git a/sequencer.c b/sequencer.c
index a55df3526f..896dd04150 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4542,26 +4542,6 @@ int todo_list_write_to_file(struct todo_list *todo_list, const char *file,
 	return res;
 }
 
-int transform_todo_file(unsigned flags)
-{
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	int res;
-
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error(_("could not read '%s'."), todo_file);
-
-	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
-	res = todo_list_write_to_file(&todo_list, todo_file,
-				      NULL, NULL, -1, flags);
-	todo_list_release(&todo_list);
-	return res;
-}
-
 static const char edit_todo_list_advice[] =
 N_("You can fix this with 'git rebase --edit-todo' "
 "and then run 'git rebase --continue'.\n"
diff --git a/sequencer.h b/sequencer.h
index f6751d53b9..ee59233344 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -142,7 +142,6 @@ int sequencer_make_script(struct strbuf *out, int argc, const char **argv,
 			  unsigned flags);
 
 int sequencer_add_exec_commands(struct string_list *commands);
-int transform_todo_file(unsigned flags);
 int check_todo_list_from_file(void);
 int complete_action(struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-- 
2.19.1.872.ga867da739e

