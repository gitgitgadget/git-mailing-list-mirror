Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48F6520248
	for <e@80x24.org>; Tue,  5 Mar 2019 19:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfCETTB (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:19:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46336 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfCETTA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:19:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id i16so10715444wrs.13
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 11:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SoZHKHShXesorq0akSJo1jP4Q2lmfcrWzS0iTqNTd98=;
        b=FxRiXc99ErbIEy3BLhBE7355YuUYdJ/KTJblgkro7PJ22hHKU50JP0RZig0MJd72AO
         qE4JDhwoyU6x0QBAz4Yqp0o51/4YvICzrA4NqlvU52MWApyJ8ib3ydXG90GFrDl93YsF
         hQX7LVAf5ThWkBsPM3mKvs1bhDIPGEXeT5G4w/sWFsVK9mGUM5Q6q9smN87xyao0YxM9
         q2uSmHPmKiYMIFNSm/SHKz5eS2wVDpaMqVv8/5UMDYKspfGXpSbrp1fp6OwShlk/jtH3
         w99+C7fIb8Nb0XBMTNN6tF3ChDFTzge3P4FJudCcQc7O4Yy50WfgWKS7SJm51pOCwavl
         lRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SoZHKHShXesorq0akSJo1jP4Q2lmfcrWzS0iTqNTd98=;
        b=Bfm1ne5VG70gzSBngqD2QcrA3b9Hs/An1oL8kzpc5gILX4vtG0Ip1wc2nzwmTsHHvL
         SbUHv2Yao9QjjBfzQu77rC+PT05pZf8msXxz6i5dVpNN+PG8hBrY4ORybPSvbu5oDseY
         bfi8kWT7vfO7UHKUL5viYABu2s3Zpb3ztAsHNJDhpNsVKOJssLkToOJZRGtNvrMIBTir
         viy2w/XQWZ9kCpJXc8y8KJOHS3EbCce9G19J3Cmn+y7hDoAeeRPM8PY/44iVbKliDVhG
         bOKGTDUPrIITr8KIq9HMdtGavbqKAk8i4EKlikQB+NzNfc3XQ9Wap/T/pBK/StXOSeR/
         cHZA==
X-Gm-Message-State: APjAAAXcM+mj3bpZL/6bUkVnPP9ScINWhkVE5X4cnmdriGydar0hAT7e
        Gp6tnc+HXEUVzvhX5PxwA7tfyQrK
X-Google-Smtp-Source: APXvYqzxt2XVUczdRnWqz3JBDtoiX9wovoE5WL7sNZRPALIb1TNjeUONkimqTNdmh01yrXxUGFN4yg==
X-Received: by 2002:a5d:5544:: with SMTP id g4mr277059wrw.269.1551813537968;
        Tue, 05 Mar 2019 11:18:57 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-67-51.w92-136.abo.wanadoo.fr. [92.136.29.51])
        by smtp.googlemail.com with ESMTPSA id r6sm10038219wrx.48.2019.03.05.11.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:18:57 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 18/18] rebase--interactive: move transform_todo_file()
Date:   Tue,  5 Mar 2019 20:18:05 +0100
Message-Id: <20190305191805.13561-19-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190305191805.13561-1-alban.gruin@gmail.com>
References: <20190210132648.12821-1-alban.gruin@gmail.com>
 <20190305191805.13561-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As transform_todo_file() is only needed inside of
rebase--interactive.c for `rebase -p', it is moved there from
sequencer.c.

The parameter r (repository) is dropped along the way.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
New commit, but was a part of "rebase--interactive: move several
functions to rebase--interactive.c" from the v7.

 builtin/rebase--interactive.c | 26 +++++++++++++++++++++++++-
 sequencer.c                   | 23 -----------------------
 sequencer.h                   |  1 -
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index b277239f21..4d9c1e62bb 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -64,6 +64,30 @@ static int rearrange_squash_in_todo_file(void)
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
 static int edit_todo_file(unsigned flags)
 {
 	const char *todo_file = rebase_path_todo();
@@ -330,7 +354,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	}
 	case SHORTEN_OIDS:
 	case EXPAND_OIDS:
-		ret = transform_todo_file(the_repository, flags);
+		ret = transform_todo_file(flags);
 		break;
 	case CHECK_TODO_LIST:
 		ret = check_todo_list_from_file(the_repository);
diff --git a/sequencer.c b/sequencer.c
index c56c3add1a..2a0fcb1cce 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4632,29 +4632,6 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
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
index 195891a267..7cca49eff2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -143,7 +143,6 @@ int sequencer_remove_state(struct replay_opts *opts);
 int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			  const char **argv, unsigned flags);
 
-int transform_todo_file(struct repository *r, unsigned flags);
 void todo_list_add_exec_commands(struct todo_list *todo_list,
 				 struct string_list *commands);
 int check_todo_list_from_file(struct repository *r);
-- 
2.20.1

