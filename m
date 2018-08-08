Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E74208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 13:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeHHQLh (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 12:11:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42398 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeHHQLh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 12:11:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4-v6so1281890edp.9
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 06:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xqccnSSZh25PfAn9kX6uhY/hwmuGU9my1HHJZ7TLspY=;
        b=crjzpNDFrch3p50bUFRZBgldt9Chx27KR7+kEdHEEfYAux+DJ9MVwfRkK44Tggc1aO
         w6TPQ3xygW47TS0yGF6q90xjpCiuWNujy8GokwQl9YhVLaK5Hlc0gJ+cW2B5WCzyKHqv
         NVkJTpPYXRJkqtbwCGzmFSZTQ7i0NxChmt3BkWW4CRgo/+GYP0homyYXCGyI33wWnegA
         QlsQzjv8w2bBi2r3G/UQaOod4H7pf+pu1vpP8Q8cgLh9S5Z5RgE7OoL8S4YZnR5Z5b5E
         yRZ4KqGqCaZZbjEpesJ5lwwqhA7dcIoS5pTsh3lZ5CiZRKoNqk5gEgJn9SzorEpKZSYz
         8iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xqccnSSZh25PfAn9kX6uhY/hwmuGU9my1HHJZ7TLspY=;
        b=V/zQay982SivedOHwjbU8mpIiHpKLqwkS6ISv/hIuY8LdExodgRuyYIr6pqoPoEeAL
         udJrZrJ+F0qpmU2qV1tMUfusKIN5pX7T63SizEaFcZzqVqk1FxPeu0k1OWiUTXJwE+aJ
         hNXPK5HOd5FNhp+cqPzuZpqHydUBbCvprE4SVjkc6z/5LFeyhomEJhNuqIJmq8/bPke1
         8PJA2xD8kwPuXHaxu493dZuePkxpYJ44YcHUwNJ8hNys7N2A7i7vg4lvvPsihjID02E9
         cgjQJ5fgreg1hJukfGPmhktpFlxp5xA2CjNlm1WbgucTYdfNagJPqOd0JFTnmzQtyRRb
         jERA==
X-Gm-Message-State: AOUpUlGy+6pjgBaCYaWLOyQcA3cKZZwSA7hiYr9w0n0rS5nN2xUmOiU2
        fh3AbNgCpoYtkXCmPz1ga5aqAWq9
X-Google-Smtp-Source: AA+uWPzID1OUNzGhgfjY2nngWwFwQSPr+uYxwb9kMDE043y2rfm1lA711Ri10XLlZ9YNyVudypZO3Q==
X-Received: by 2002:aa7:c592:: with SMTP id g18-v6mr3413198edq.214.1533736309805;
        Wed, 08 Aug 2018 06:51:49 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id u3-v6sm1619420edo.44.2018.08.08.06.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 06:51:49 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 11/11] builtin rebase: support `git rebase <upstream> <switch-to>`
Date:   Wed,  8 Aug 2018 19:33:30 +0545
Message-Id: <20180808134830.19949-12-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808134830.19949-1-predatoramigo@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit adds support for `switch-to` which is used to switch to the
target branch if needed. The equivalent codes found in shell script
`git-legacy-rebase.sh` is converted to builtin `rebase.c`.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 63634210c0..b2ddfa8dbf 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -79,6 +79,7 @@ struct rebase_options {
 	struct commit *onto;
 	const char *onto_name;
 	const char *revisions;
+	const char *switch_to;
 	int root;
 	struct commit *restrict_revision;
 	int dont_finish_rebase;
@@ -186,6 +187,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 		opts->flags & REBASE_DIFFSTAT ? "t" : "");
 	add_var(&script_snippet, "force_rebase",
 		opts->flags & REBASE_FORCE ? "t" : "");
+	if (opts->switch_to)
+		add_var(&script_snippet, "switch_to", opts->switch_to);
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -564,9 +567,23 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * orig_head -- commit object name of tip of the branch before rebasing
 	 * head_name -- refs/heads/<that-branch> or NULL (detached HEAD)
 	 */
-	if (argc > 0)
-		 die("TODO: handle switch_to");
-	else {
+	if (argc == 1) {
+		/* Is it "rebase other branchname" or "rebase other commit"? */
+		branch_name = argv[0];
+		options.switch_to = argv[0];
+
+		/* Is it a local branch? */
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "refs/heads/%s", branch_name);
+		if (!read_ref(buf.buf, &options.orig_head))
+			options.head_name = xstrdup(buf.buf);
+		/* If not is it a valid ref (branch or commit)? */
+		else if (!get_oid(branch_name, &options.orig_head))
+			options.head_name = NULL;
+		else
+			die(_("fatal: no such branch/commit '%s'"),
+			    branch_name);
+	} else if (argc == 0) {
 		/* Do not need to switch branches, we are already on it. */
 		options.head_name =
 			xstrdup_or_null(resolve_ref_unsafe("HEAD", 0, NULL,
@@ -585,7 +602,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 		if (get_oid("HEAD", &options.orig_head))
 			die(_("Could not resolve HEAD to a revision"));
-	}
+	} else
+		BUG("unexpected number of arguments left to parse");
 
 	if (read_index(the_repository->index) < 0)
 		die(_("could not read index"));
@@ -612,6 +630,28 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
+			/* Lazily switch to the target branch if needed... */
+			if (options.switch_to) {
+				struct object_id oid;
+
+				if (get_oid(options.switch_to, &oid) < 0) {
+					ret = !!error(_("could not parse '%s'"),
+						      options.switch_to);
+					goto cleanup;
+				}
+
+				strbuf_reset(&buf);
+				strbuf_addf(&buf, "rebase: checkout %s",
+					    options.switch_to);
+				if (reset_head(&oid, "checkout",
+					       options.head_name, 0) < 0) {
+					ret = !!error(_("could not switch to "
+							"%s"),
+						      options.switch_to);
+					goto cleanup;
+				}
+			}
+
 			if (!(options.flags & REBASE_NO_QUIET))
 				; /* be quiet */
 			else if (!strcmp(branch_name, "HEAD") &&
-- 
2.18.0

