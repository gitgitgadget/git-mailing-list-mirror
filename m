Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA72820374
	for <e@80x24.org>; Mon, 22 Apr 2019 00:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfDVAHh (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 20:07:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33412 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDVAHh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 20:07:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id t16so5000915plo.0
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 17:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w1tC4Sn8n/CG6++68KI8Ka6GpuX0F9HdFURsFJy2urw=;
        b=Rc90+/gyKJpjY3QaOBxr2jsZZFYvfNbLNEfYLgqAyUaehYT9vi9WbqulI+nZdKai0T
         xZm1RprLKCpJtU/z2WvZJvXZxXvCMVvcxaniHw+mluesE5/dpljpXoAJ7vx7Gz7YSo//
         fdwGVdiOHADpsvsznoQhOiEa2qinrydjaJyDYOxZoFtLoexxiUStFtfuEQj++2Ek8R/B
         2aYcjPKoYwv1PmHoj2p6tvsKkdnruf+QfLXUiq2+Idjg6qqfkPUMAuTfVUdbgLbZsq4f
         51LNZYf+rG50fs0SQaQZIbxAnqZEYQNjqIg2mg0nV6bOZYi5vSSitFJMgBt1U7H3bG7N
         /5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w1tC4Sn8n/CG6++68KI8Ka6GpuX0F9HdFURsFJy2urw=;
        b=c2ksVpvbM1mLef6c3U8RfgSU2qqTeHRJcNIEkVlG5gfC/4d5Y6FRIfWArLKgLAs1JU
         JsvMKY/4s0iqdoyeTqjcBJGQA5biEFHsDhtqgGtpX8ad9W/QNuVQjg7gMQkIdJxYjGR6
         EKB+vfYlal2NnhWM4bqwhpJ3k1ZtHIMOM1BBVDgdoifOatGjRCFz3vCswFdZh6NnFkwk
         PBLvwpkgJqNhOztQ0Q9nUcioCQiT+C/oQwlphZq7jdc96iOYD8O0JxDX2gm2JqCdq5bm
         vD6Jkh46awixeFENYk8C89jPMq0Oh9m3TBPrDn1j8b0XxVpsf0kf3J1XX4uL2Dt23XJ4
         iIaw==
X-Gm-Message-State: APjAAAVzgS9eI7iSMiB61n9K1UL5/nTWt/JrLt3UDsTKYonK5og8rIK3
        DEbL2oY1Piv1We7KLXnwuEE7r5aJ
X-Google-Smtp-Source: APXvYqwXferr4Myecm265F7JlTWKFwORD4y9K1I/bVjPjI3gvDf/FB9OaoiUjkaS3Yxe9kHXXdZjQQ==
X-Received: by 2002:a17:902:b605:: with SMTP id b5mr15544295pls.206.1555891656388;
        Sun, 21 Apr 2019 17:07:36 -0700 (PDT)
Received: from phord-x1.hsd1.ca.comcast.net ([2601:647:5701:455f:49f6:143c:5261:44c0])
        by smtp.gmail.com with ESMTPSA id h189sm21163918pfc.125.2019.04.21.17.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 17:07:35 -0700 (PDT)
From:   Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phil Hord <phil.hord@gmail.com>
Subject: [PATCH/RFC 2/2] rebase: add --break switch
Date:   Sun, 21 Apr 2019 17:07:12 -0700
Message-Id: <20190422000712.13584-3-phil.hord@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190422000712.13584-1-phil.hord@gmail.com>
References: <20190422000712.13584-1-phil.hord@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phil Hord <phil.hord@gmail.com>

Expand the rebase edit switches to include the break switch. This
switch lets the user add a "break" instruction to the todo-list
before the mentioned reference.

This switch is a little different from the ones added so far because
it adds a new instruction between commits in the todo-list instead of
changing the command used to include a commit. It is a little like
"exec" in this regard, except it doesn't add the command after every
commit.

It is not immediately clear whether we should add the break command
before or after the referenced commit.  That is, when the user says
'--break ref', does she mean to break after ref is picked or before
it?  The answer comes when we realize that a 'break' after a ref
is functionally the same as '--edit ref'. Since the user didn't
say '--edit ref', clearly she must have wanted to break _before_ ref
is picked.  So, insert the break before the mentioned ref.

Annoyingly, however, when git stops at a break, it declares that the
previous commit is the one we stopped on, which is always different
from the one the user specified. Does anyone care?  Should --break
effectively be an alias for --edit?

    '--break <ref>' to stop the rebase before the mentioned commit

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 builtin/rebase--interactive.c | 3 +++
 builtin/rebase.c              | 4 ++++
 sequencer.c                   | 7 +++++++
 sequencer.h                   | 1 +
 4 files changed, 15 insertions(+)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 9285d05443..a81fa9c1c5 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -164,6 +164,7 @@ static int resolve_commit_list(const struct string_list *str,
 static int resolve_edits_commit_list(struct sequence_edits *edits)
 {
 	return resolve_commit_list(&edits->drop, &edits->revs) ||
+	       resolve_commit_list(&edits->breaks, &edits->revs) ||
 	       resolve_commit_list(&edits->edit, &edits->revs) ||
 	       resolve_commit_list(&edits->reword, &edits->revs);
 }
@@ -302,6 +303,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 			   N_("restrict-revision"), N_("restrict revision")),
 		OPT_STRING(0, "squash-onto", &squash_onto, N_("squash-onto"),
 			   N_("squash onto")),
+		OPT_STRING_LIST(0, "break", &edits.breaks, N_("revision"),
+				N_("stop before the mentioned ref")),
 		OPT_STRING_LIST(0, "drop", &edits.drop, N_("revision"),
 				N_("drop the mentioned ref from the "
 				   "todo list")),
diff --git a/builtin/rebase.c b/builtin/rebase.c
index a8101630cf..02079c4172 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1053,6 +1053,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 					      NULL };
 	const char *gpg_sign = NULL;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
+	struct string_list breaks = STRING_LIST_INIT_NODUP;
 	struct string_list reword = STRING_LIST_INIT_NODUP;
 	struct string_list edit = STRING_LIST_INIT_NODUP;
 	struct string_list drop = STRING_LIST_INIT_NODUP;
@@ -1138,6 +1139,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST('x', "exec", &exec, N_("exec"),
 				N_("add exec lines after each commit of the "
 				   "editable list")),
+		OPT_STRING_LIST(0, "break", &breaks, N_("revision"),
+				N_("stop before the mentioned ref")),
 		OPT_STRING_LIST(0, "drop", &drop, N_("revision"),
 				N_("drop the mentioned ref from the "
 				   "todo list")),
@@ -1404,6 +1407,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.cmd = xstrdup(buf.buf);
 	}

+	forward_switches(&options, "--break", &breaks);
 	forward_switches(&options, "--drop", &drop);
 	forward_switches(&options, "--edit", &edit);
 	forward_switches(&options, "--reword", &reword);
diff --git a/sequencer.c b/sequencer.c
index d7384d987c..4a1a371757 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4261,6 +4261,7 @@ static const char *label_oid(struct object_id *oid, const char *label,

 void free_sequence_edits(struct sequence_edits *edits)
 {
+	string_list_clear(&edits->breaks, 0);
 	string_list_clear(&edits->drop, 0);
 	string_list_clear(&edits->edit, 0);
 	string_list_clear(&edits->reword, 0);
@@ -4294,6 +4295,7 @@ static int check_unused_refs(const struct string_list *refs)
 static int check_unused_edits(const struct sequence_edits *edits)
 {
 	return check_unused_refs(&edits->drop) ||
+		check_unused_refs(&edits->breaks) ||
 		check_unused_refs(&edits->edit) ||
 		check_unused_refs(&edits->reword);
 }
@@ -4320,6 +4322,11 @@ static void add_edit_todo_inst(struct strbuf *buf, const struct object_id *oid,
 {
 	enum todo_command cmd = TODO_PICK;

+	if (consume_oid(oid, &edits->breaks)) {
+		add_todo_cmd(buf, TODO_BREAK, flags);
+		strbuf_addstr(buf, "\n");
+	}
+
 	if (consume_oid(oid, &edits->drop))
 		cmd = TODO_DROP;
 	else if (consume_oid(oid, &edits->edit))
diff --git a/sequencer.h b/sequencer.h
index 7887509fea..310829f222 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -139,6 +139,7 @@ int sequencer_remove_state(struct replay_opts *opts);
  */
 struct sequence_edits {
 	struct commit_list *revs;
+	struct string_list breaks;
 	struct string_list drop;
 	struct string_list edit;
 	struct string_list reword;
--
2.20.1
