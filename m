Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5355F1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfAWU7t (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:59:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35281 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfAWU7r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:59:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so4144506wrb.2
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xLIDl5+6UAcPjlAePh0r10VvNSTysYz4SvnNEGQ3BLw=;
        b=JuloyhfnfWe6UNN5ZYCqZ/dvMuQdlz8utjsaxnH0jUBzb5kzW3s8cbqOLDMHnU5Q7G
         aMIpGjRpxXZX6lr4Aq8vGWt7HenMFsR2NmJstYncfmHM17SI61672gxbOLqnWeYLprJj
         S0nAM4A1f5glwbZLxCg/UKap/r2HayZu3Cdu08iFxhRrnv+91cIjtecRAfqbH7m096rf
         6UfGFvoaJ2XupNOoH6ZuVsvIt6s1avMWJVDYTq7MO683dpM32OJP2Dx/PVUHrZHGAb7Y
         C9Qj9m/U3ulJBROZHOxRJ79vA5tfrfU+T7uDFPHl3PKx9yNJcx57DuCydXyU9Z+0fEug
         RJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xLIDl5+6UAcPjlAePh0r10VvNSTysYz4SvnNEGQ3BLw=;
        b=G8uZLxaTMIjtreugYiWC7QmCjaKocOu7mT9Y1aptKZPneJn9v5vat3APpY8bUEvbos
         g5qGF35CT/GTT4lbsUhwjuVjMPHaOCLsu1U23wYfayd8FJAxZjBJLFojK5xHAZAEpwfl
         pubTs+aXrqyx+5W38bY1aL7qg3PV17EivV87XLeQqZCOwJrqfI2QWnHm2HaGPFBLdCYx
         AbivV9zM62Wm5HJTi2JfIYzJU6OD+LawF30aBi4qmW8lBU4H4N10UQcmxeKc93CXsgYl
         UTRdxYlW5kjGr9oBBfZmIJiSS+9H0BZVhDYMbnAcUyDVh0YYnsiui+0dpMTwQT6Rq/Jl
         XwdA==
X-Gm-Message-State: AJcUukcVVQXXMGNdF7TFTXt8rdavN8THIKe5XOFtlzkm8jJe6TEl55ZR
        IqKi+0gIsBvrE/CEATcI6o+tvspu
X-Google-Smtp-Source: ALg8bN5mtSXL/oyflrADkB/OtqZyt12dqOAV+JIJJdTWNEVKNRl+lUXA5Tc7kuY1DuBo3T1FI2atYg==
X-Received: by 2002:adf:91a3:: with SMTP id 32mr3929906wri.99.1548277185657;
        Wed, 23 Jan 2019 12:59:45 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-2-163.w86-222.abo.wanadoo.fr. [86.222.145.163])
        by smtp.googlemail.com with ESMTPSA id h13sm80634127wrp.61.2019.01.23.12.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:59:45 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 16/16] rebase--interactive: move transform_todo_file() to rebase--interactive.c
Date:   Wed, 23 Jan 2019 21:58:21 +0100
Message-Id: <20190123205821.27459-17-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123205821.27459-1-alban.gruin@gmail.com>
References: <20181229160413.19333-1-alban.gruin@gmail.com>
 <20190123205821.27459-1-alban.gruin@gmail.com>
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
Unchanged since v4.

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

