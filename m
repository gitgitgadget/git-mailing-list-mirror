Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF7B20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 17:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbdK0Rg7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 12:36:59 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39973 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbdK0Rg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 12:36:58 -0500
Received: by mail-pl0-f67.google.com with SMTP id 62so8888757plc.7
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 09:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pYZfYEMNVXjtz71u0aPJNebjsmwX7IP5kkpFaEbVOGc=;
        b=ISu+K3u+X9Z+X5v+/536Uch69kTSAS7uXsP5/xM0DjRxQXrmSaiFFS7u8qnvODO1A3
         ADhfFnjTR0fUn+xK8DKV3Qvh1Sw/MOmc0F6lFtAXZGjKH4ZI7JttUBuPW7aAaHMKEFzm
         jcLbv/g1xIJiopji7yjXAWFR2p0Dmli91eXf/4yP8Aek1V8bt2NKIFEFBLf4IsA4vzcc
         EzD8UeJoRnLmniOS7GRMItqbiTHhIDk8Wa+xaXfswrflxy77/2C7vqTmigsWQ3KlDXLA
         NKheOXSnqc/6kIjfPg2pHpmGA90mtpwGHLuKyCnT9y3y2FnIJ/5RtzhVonDYrDDxU0+s
         v5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pYZfYEMNVXjtz71u0aPJNebjsmwX7IP5kkpFaEbVOGc=;
        b=qbeohA5zgJrAcsM7XTWIofsoOqpaE4y0z6LlZ3k93CDf2eRu6PWmZ2jEz1/fhqRma1
         +mdALmi+SC08F7hSY+N5x+31gwX/4wZw9LHpu9s0BbRwAaZTLxVP5/B8y88sP2yV2FoO
         PzqIi/kmUmwcS4i+YTtdFYyjYhoijoPnc0lkDmrETqt+b091C4uhY9uR8iPBWvrsUSqr
         crgCboonzYgLI70DwFf/2FYH6iXgn9wCWd/68mY5izCDRQsm6FwQdw/5XEYqXemPU+3m
         HBehI3UZZJ2V+jeSpO7C6ZG0We0PG51LD99d7tQMwB0eM+jEUwWy38x/XNrXJncUdU8o
         d0bA==
X-Gm-Message-State: AJaThX43ghrsqo6EXFZbE4oymtkiOqhl11yhqTZxaL/5sP4eAFQTPN/m
        UroshUHVsXvKBw3f858GwCg=
X-Google-Smtp-Source: AGs4zMYi8AqmBuFgspVgwVLytV79k7MZpbEgXODUjVfr1wfJTRPeLbYNQdTDRkPzk51IWPWKhRmJcg==
X-Received: by 10.84.197.35 with SMTP id m32mr4611306pld.214.1511804217658;
        Mon, 27 Nov 2017 09:36:57 -0800 (PST)
Received: from localhost.localdomain ([2405:204:73c7:b4fb:72c8:dd31:37ff:6021])
        by smtp.gmail.com with ESMTPSA id m11sm44592280pfh.35.2017.11.27.09.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 09:36:56 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [RFC PATCH v2] builtin/worktree: enhance worktree removal
Date:   Mon, 27 Nov 2017 23:06:21 +0530
Message-Id: <20171127173621.6707-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <20883815-0d9b-a4d8-cc93-0eb8b918551f@gmail.com>
References: <20883815-0d9b-a4d8-cc93-0eb8b918551f@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git worktree remove" removes both the named worktree
directory and the administrative information for it after
checking that there is no local modifications that would be
lost (which is a handy safety measure). However, due to a
possible oversight, it aborts with an error if the worktree
directory is _already_ removed.

The user could use "git worktree prune" after seeing the
error and realizing the situation, but at that point, there
is nothing gained by leaving only the administrative data
behind. Teach "git worktree remove" to go ahead and remove
the trace of the worktree in such a case.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Changes in v2:

  - incorporated the suggestion to avoid quieting `validate_worktree()`
    to detect inexistent directory (thanks, Eric!)

  - used the suggested (much better) commit message

 builtin/worktree.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index b5afba164..6eab91889 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -605,6 +605,23 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	return update_worktree_location(wt, dst.buf);
 }
 
+/* Removes the .git/worktrees/worktree_id directory for
+ * the given worktree_id
+ *
+ * Returns 0 on success and non-zero value in case of failure
+ */
+static int remove_worktree_entry(char *worktree_id) {
+	int ret = 0;
+	struct strbuf we_path = STRBUF_INIT;
+	strbuf_addstr(&we_path, git_common_path("worktrees/%s", worktree_id));
+	if (remove_dir_recursively(&we_path, 0)) {
+		error_errno(_("failed to delete '%s'"), we_path.buf);
+		ret = -1;
+	}
+	strbuf_release(&we_path);
+	return ret;
+}
+
 static int remove_worktree(int ac, const char **av, const char *prefix)
 {
 	int force = 0;
@@ -634,6 +651,16 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 			die(_("already locked, reason: %s"), reason);
 		die(_("already locked, no reason"));
 	}
+
+	if (!file_exists(wt->path)) {
+	/* There's a worktree entry but the worktree directory
+	 * doesn't exist. So, just remove the worktree entry.
+	 */
+		ret = remove_worktree_entry(wt->id);
+		free_worktrees(worktrees);
+		return ret;
+	}
+
 	if (validate_worktree(wt, 0))
 		return -1;
 
@@ -670,13 +697,7 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 		error_errno(_("failed to delete '%s'"), sb.buf);
 		ret = -1;
 	}
-	strbuf_reset(&sb);
-	strbuf_addstr(&sb, git_common_path("worktrees/%s", wt->id));
-	if (remove_dir_recursively(&sb, 0)) {
-		error_errno(_("failed to delete '%s'"), sb.buf);
-		ret = -1;
-	}
-	strbuf_release(&sb);
+	ret = remove_worktree_entry(wt->id);
 	free_worktrees(worktrees);
 	return ret;
 }
-- 
2.15.0.345.gf926f18f3

