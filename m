Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C231F453
	for <e@80x24.org>; Tue, 29 Jan 2019 15:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfA2PD1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 10:03:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52170 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfA2PDU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 10:03:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so18225899wmj.1
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 07:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=22xPp1Fv7amChep2qhX+SwSsrpxE6rDmUr26GJ9pHEk=;
        b=ODCloTsjV6udJR57uum6zYKuBrPYU5VIogDnxz6IZI8NMMb3I3EIdcdd8UzKjxD5Ie
         KGrCfaoD+dV9nSq7jKG5mBFukKkcqaH/6z1sWAv5u+55sX/rnqqUOPgmBVciMTlM0gvY
         t6L+OaDDpGygh3rcq6FQgh7WyH0LkLLegTCVi5nha2z+RFcQRyXRdYIDJGE9TbsMPDM/
         etUDqJj9G7mCHLrVYd4IGCgdMrobYw9B5mH2tphazMjZ4Lk1I9cJodfUO+KDkli1yUxC
         ymBiFZqjoRan2tuKG1Tf6j+0hOLZ0HU9Bqw6frUJgm8BgLczVp2P6z+8GZRaublcP6YF
         9zoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=22xPp1Fv7amChep2qhX+SwSsrpxE6rDmUr26GJ9pHEk=;
        b=eSZ8VjES56RnLqiX4XuZfgaVA/PlN3YWPqOQoKEBBOKg6ceWWuNfjkfl9n+cnLKZYf
         9jSnGj+NQBHYlP1JjNeF0exOXAsweF+e9Uvn0Vc45z4y5fDYOeGJG51LcP/srL4oUosV
         XxbWyU/MsJNmMsr3gkTZ0Wz5WFfGlDo+Xaj1rG8ifguazTM9DYkWqdDtr9VUWVoteYGB
         +KDN/zmoAla9+Vm4iKUd4eifYhk1a+hzBaSNZkbrretfL1Y3sF3t+J8asH7xRr60fPd/
         +var3b+PJDFzXxaV/2mZhd9Y++lkaX+1W9UfzPef5ight0nIwl7BruGyPpCatRwI9UEQ
         oHkA==
X-Gm-Message-State: AJcUukeeEm3AcQoIlQd/TmuU/4btp7AFg1O9TxtF9j1qaVlyJRYjfay+
        vYhDbDMpbQbIldJlxgmb3fMRbvgK
X-Google-Smtp-Source: ALg8bN4973SJsi1fGZHKox75xBxbMAitwCwFIiqjroyIgqrgkGRMlVSG5XLeRQqJghtXq3Dqtvi7uw==
X-Received: by 2002:a1c:e345:: with SMTP id a66mr21103187wmh.12.1548774198839;
        Tue, 29 Jan 2019 07:03:18 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-47-104.w86-221.abo.wanadoo.fr. [86.221.54.104])
        by smtp.googlemail.com with ESMTPSA id 129sm4420851wmd.18.2019.01.29.07.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 07:03:18 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 16/16] rebase--interactive: move transform_todo_file() to rebase--interactive.c
Date:   Tue, 29 Jan 2019 16:01:59 +0100
Message-Id: <20190129150159.10588-17-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150159.10588-1-alban.gruin@gmail.com>
References: <20190123205821.27459-1-alban.gruin@gmail.com>
 <20190129150159.10588-1-alban.gruin@gmail.com>
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
 builtin/rebase--interactive.c | 26 +++++++++++++++++++++++++-
 sequencer.c                   | 23 -----------------------
 sequencer.h                   |  1 -
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 645ac587f7..7f1e88a087 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -35,6 +35,30 @@ static int edit_todo_file(unsigned flags)
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
+	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
+					&todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	res = todo_list_write_to_file(the_repository, &todo_list, todo_file,
+				      NULL, NULL, -1, flags);
+	todo_list_release(&todo_list);
+
+	if (res)
+		return error_errno(_("could not write '%s'."), todo_file);
+	return 0;
+}
+
 static int get_revision_ranges(const char *upstream, const char *onto,
 			       const char **head_hash,
 			       char **revisions, char **shortrevisions)
@@ -277,7 +301,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	}
 	case SHORTEN_OIDS:
 	case EXPAND_OIDS:
-		ret = transform_todo_file(the_repository, flags);
+		ret = transform_todo_file(flags);
 		break;
 	case CHECK_TODO_LIST:
 		ret = check_todo_list_from_file(the_repository);
diff --git a/sequencer.c b/sequencer.c
index 21b04e0642..5239700efc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4593,29 +4593,6 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
 	return res;
 }
 
-int transform_todo_file(struct repository *r, unsigned flags)
-{
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	int res;
-
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
-	res = todo_list_write_to_file(r, &todo_list, todo_file,
-				      NULL, NULL, -1, flags);
-	todo_list_release(&todo_list);
-
-	if (res)
-		return error_errno(_("could not write '%s'."), todo_file);
-	return 0;
-}
-
 static const char edit_todo_list_advice[] =
 N_("You can fix this with 'git rebase --edit-todo' "
 "and then run 'git rebase --continue'.\n"
diff --git a/sequencer.h b/sequencer.h
index 68acab980b..11afd47aa9 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -145,7 +145,6 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 
 int sequencer_add_exec_commands(struct repository *r,
 				struct string_list *commands);
-int transform_todo_file(struct repository *r, unsigned flags);
 int check_todo_list_from_file(struct repository *r);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-- 
2.20.1

