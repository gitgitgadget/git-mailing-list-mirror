Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DBB41F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 20:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbeJHDIu (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 23:08:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39524 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbeJHDIu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 23:08:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id 61-v6so17827564wrb.6
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 13:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHdkcsiWDiIW490lyZ3JpitTbg1V1pur8blPR1lks0Q=;
        b=VQ+CuR3CWro6bTb6r666o3Z5OahAUDNn7Fn189qQdhUmxBYUo/NmspE0runY3dHthh
         KvmJOa33H7R/8FRsqnoCkN2IjeekGES+jjv+XrH7DUIhVoB1bGUDngDp4sfc9dMxHUwY
         p/RYwrsEb+Kf9V3di4NQgZ3IgSwfSaeCT6Bu8X7exBMZTH9nNF3kJzrnuQ7Mh03cLNGg
         vRsjmEKfCdKFZ/OEOZahiA+PFcUUt/uh4xpgRI47H9YF9NPXTylQbxskX+7mvccRFZSp
         qGNj4+CDBPiS4jo1y5x6hSs/BN1Dq2/xNymwF6f5aKdu2G3HzYokssIbDNWQo9S6ekUb
         Umtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHdkcsiWDiIW490lyZ3JpitTbg1V1pur8blPR1lks0Q=;
        b=gYBXVFFGl7Ht9S5r6XwMzyNsRScEAVtiKecvw1wc/MAPT2QUKsJM58AmKU8XVY4oSp
         0gPJ2K1/A2xanUUomWO4aQafcHHNESaMNql2PgeQz4wLjuLikKIuRQ7yvKfb9ep0pH9D
         QOAPU4HW7Qo1ZCfn7LTdWLz1MhzLDaYfAZ5Hwi9CXZ6UALN6RAwG00Jx8+wNNGLE5oy0
         qJ1Xh1NVoUxkLAGr9ZlPpW9G0uUfUadJLX73SbFHXTiMADcY4ouuFnfdLOjIhWiQlZ4H
         3mxybpDTgjagYLg59p2JRDn7XKS7JTbK0kbhNjNLbN2MtSCqn7Ak7vlaNF40p8otJA4s
         tr6w==
X-Gm-Message-State: ABuFfojVF6TVugHzLmzzjMxFMQao2JvHfPzKKNJXMqqJ8WUTuwlGtx24
        AvF1bP4TNGYulUCx2i9uWms9rDVO
X-Google-Smtp-Source: ACcGV605sbvj2YOUuMn63yPXv1inYQ5GBvNcNRjoS2+2BLUmcPOY2c57Kz0c5EuMnK/CYBZn6jJpIQ==
X-Received: by 2002:adf:dd4c:: with SMTP id u12-v6mr13717504wrm.2.1538942425113;
        Sun, 07 Oct 2018 13:00:25 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm17082538wmd.10.2018.10.07.13.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 13:00:24 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH 15/15] rebase--interactive: move transform_todo_file() to rebase--interactive.c
Date:   Sun,  7 Oct 2018 21:54:18 +0200
Message-Id: <20181007195418.25752-16-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181007195418.25752-1-alban.gruin@gmail.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
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
 builtin/rebase--interactive.c | 21 +++++++++++++++++++++
 sequencer.c                   | 21 ---------------------
 sequencer.h                   |  1 -
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 264e940b47..50b5c25402 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -33,6 +33,27 @@ static int edit_todo_file(unsigned flags)
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
+	todo_list_transform(&todo_list, flags);
+
+	res = write_message(todo_list.buf.buf, todo_list.buf.len, todo_file, 0);
+	todo_list_release(&todo_list);
+	return res;
+}
+
 static int get_revision_ranges(const char *upstream, const char *onto,
 			       const char **head_hash,
 			       char **revisions, char **shortrevisions)
diff --git a/sequencer.c b/sequencer.c
index 65bf251ba5..e837e52b64 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4485,27 +4485,6 @@ void todo_list_transform(struct todo_list *todo_list, unsigned flags)
 		BUG("unusable todo list");
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
-	todo_list_transform(&todo_list, flags);
-
-	res = write_message(todo_list.buf.buf, todo_list.buf.len, todo_file, 0);
-	todo_list_release(&todo_list);
-	return res;
-}
-
 int check_todo_list_from_file(void)
 {
 	struct todo_list old_todo = TODO_LIST_INIT, new_todo = TODO_LIST_INIT;
diff --git a/sequencer.h b/sequencer.h
index fa84918c55..a4b0113206 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -137,7 +137,6 @@ int sequencer_make_script(struct strbuf *out, int argc, const char **argv,
 			  unsigned flags);
 
 int sequencer_add_exec_commands(const char *command);
-int transform_todo_file(unsigned flags);
 int check_todo_list_from_file(void);
 int complete_action(struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-- 
2.19.1

