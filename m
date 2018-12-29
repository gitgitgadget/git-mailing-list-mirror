Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6071F405
	for <e@80x24.org>; Sat, 29 Dec 2018 16:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeL2QF2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 11:05:28 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46203 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbeL2QFX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 11:05:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so19645391edt.13
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 08:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bWNtTFnXYx69UcBV3X/+Is7kJZzJadxICuJYhTKGQks=;
        b=E7FCuJSrsjONAk3QHEbClHeo0+byEX9K4NjU8RZqzaV2z6GQeaoHCVLcSpuQCaz8A7
         lmOl16EzH0qND3zaHwmwYmJakkjMhBI3T4py8OvHzfaVbOzI/XDHGVBBQABF9cSrFUMU
         Jqi7cq10HheGBMYG/mPRLfDRdd8dO5vXJkMalxWCe83qog6Q+Wdnf0NNZUjgFaWyNEih
         eJaQeMMlbUCpvjDfD3Ls6gz+/HhV9s0rgrP5FPq7jcADBhuHFtmJaNgmFl4A7oFpmm72
         xuDa5BM9cypPc7vKMr9xSFtdjFlQ5kXM/k2GDTAUwekeqCn8XZoU6RgFYoxTOYg9MWd+
         uyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWNtTFnXYx69UcBV3X/+Is7kJZzJadxICuJYhTKGQks=;
        b=UopWd0XiizJWMvK61bi/fYMfNsYh+j7pPXMX2gZfZWx8c/xN61Vzne0b/6bdqzAF5G
         Hn9J1wMXAd/xvjvUYSeB8Zx9lAM6E3zmiMlq09KGQ+46ui51miRYXCQaQmDfa+W8E2VK
         t+EFUaPct3A7ePmJgAGg9v6+Cnd1lMXMwBwZmo26kOVAm9qy5+iywaflNzWW6mD+FjdR
         FZK1w3Qinq1P1LaKEAInbgBuwe9K+sfwpbUxP/RogkFjPf2H1M+GuTJoSYn8vB3ZG7N6
         HL1wI8PfUAoqVfYvm+qMudAuOsIO8jjYnWeC39QvjqdKWODgQoWrIipyYpZZRdZqTZaU
         e1yw==
X-Gm-Message-State: AA+aEWZi0ZpCW2yQoEwGpvH9Uy0YWE4KVw6nNVIxubEOuQc7h9p1YHwX
        KXkAzm6OLxMq+kUIBkpmOVkQ7tkO
X-Google-Smtp-Source: AFSGD/U+F3axMRPCgm0UE8RCe3pCLLww3stjaid7D9/bcFHtq2ODlSDXzrp3phYjsfNIz/Zhmlj28Q==
X-Received: by 2002:a50:852b:: with SMTP id 40mr25820651edr.166.1546099521621;
        Sat, 29 Dec 2018 08:05:21 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-184-107.w86-199.abo.wanadoo.fr. [86.199.39.107])
        by smtp.googlemail.com with ESMTPSA id b49sm15108663edb.73.2018.12.29.08.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 08:05:21 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 16/16] rebase--interactive: move transform_todo_file() to rebase--interactive.c
Date:   Sat, 29 Dec 2018 17:04:13 +0100
Message-Id: <20181229160413.19333-17-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181229160413.19333-1-alban.gruin@gmail.com>
References: <20181109080805.6350-1-alban.gruin@gmail.com>
 <20181229160413.19333-1-alban.gruin@gmail.com>
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
index 127bb0b68e..6566247a7c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4587,29 +4587,6 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
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
index 7dd85bb399..bb3ca5783b 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -146,7 +146,6 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 
 int sequencer_add_exec_commands(struct repository *r,
 				struct string_list *commands);
-int transform_todo_file(struct repository *r, unsigned flags);
 int check_todo_list_from_file(struct repository *r);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-- 
2.20.1

