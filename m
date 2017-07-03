Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4651201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 22:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbdGCWIv (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 18:08:51 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:36714 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbdGCWIu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 18:08:50 -0400
Received: by mail-wr0-f170.google.com with SMTP id c11so240453449wrc.3
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mazzo-li.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aojg6EMOeyipbhasCIfAevPE2opkaZ4kWcxqH3l6vmU=;
        b=IhKPbBJtQmOTp694b3F9x/3YshSA3spdtywJaNJxXc7Cl6s4Nn7PIm8GvePt6obLZL
         MSvBczHz1bc8hvyECybbJl7XH6qIoud0RgnSd79RDduNF0NkNKFkkizJqXDscSVpJGmC
         XmnCjDxfL31Vf5ayeUmOK7FdIFD3w2HTrpTcIH6rN76DMpUMBNKP/XNKpBnWEcHGO95C
         drUh3QqUUw4p6BLxQgnkQZbcamY+GIWE8ype1xacqfImIZ32KvyVz67XgTYNDXKJNPt4
         ZeYVPfKSdiIsA8HoEHficSATv08F1wK3Us1awd3QE5t+SPKjmbu4SGvuncgBmiF09rfh
         /W1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aojg6EMOeyipbhasCIfAevPE2opkaZ4kWcxqH3l6vmU=;
        b=iw/TIiOvy0qqRBVUhfaJw09Gbe+wmkwEKxZLr4yzzVxQ9Bdv/8TKWJ+oJZb1kz2HDE
         h+8XB5gkBTpYoXxAMFsM7f0ke7vfPNd6H8rvU0c6RYZUIlcN88Gg7h4cchOtGh9LzaID
         yq1/H3VfR3EixVFznYsggbvZTQVeWEQtSDENnuXM6abEiXvnniKmZtj2sTY/PNKU+9qM
         wNF0VxnID7/8uyFlNVYEixliEjcxWAYsKr5KIJzCXR9HIXjlgwPA66bLjhHSwsWg76CP
         b0Hl5BMTYy1V7a6zE7RJ7N0lEAYBL0kSbpzoJtp9jLc02qxSMbFi50ei3fX96fxu1YvK
         WNXA==
X-Gm-Message-State: AKS2vOxdtsJ+XI8gFc/j9N0B1sRmph+e9Ozin9PuzPLaq9iQJq1jNy5C
        Item8Pb09jC3I3vScTTUTg==
X-Received: by 10.223.165.13 with SMTP id i13mr37541757wrb.35.1499119728659;
        Mon, 03 Jul 2017 15:08:48 -0700 (PDT)
Received: from spiros.lan ([2.227.248.226])
        by smtp.gmail.com with ESMTPSA id 90sm17222751wrk.38.2017.07.03.15.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jul 2017 15:08:48 -0700 (PDT)
From:   Francesco Mazzoli <f@mazzo.li>
To:     git@vger.kernel.org
Cc:     Francesco Mazzoli <f@mazzo.li>
Subject: [PATCH] push: add config option to --force-with-lease by default.
Date:   Tue,  4 Jul 2017 00:08:18 +0200
Message-Id: <1499119698-6408-1-git-send-email-f@mazzo.li>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <871spxchvm.fsf@gmail.com>
References: <871spxchvm.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The flag can be overridden with `--no-force-with-lease`, or by
passing the config via the command line.

Signed-off-by: Francesco Mazzoli <f@mazzo.li>
---
 Documentation/config.txt   | 5 +++++
 Documentation/git-push.txt | 4 +++-
 builtin/push.c             | 3 +++
 cache.h                    | 1 +
 config.c                   | 4 ++++
 environment.c              | 1 +
 6 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 06898a7..835b34b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2537,6 +2537,11 @@ push.default::
 	specific workflows; for instance, in a purely central workflow
 	(i.e. the fetch source is equal to the push destination),
 	`upstream` is probably what you want.  Possible values are:
+
+push.forceWithLease::
+	When true, `--force-with-lease` is the default behavior when
+	using `push --force`. Explicit invocations of `--force-with-lease`
+	or `--no-force-with-lease` take precedence.
 +
 --
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 0a63966..5182656 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -195,7 +195,9 @@ only if the "lease" is still valid.
 `--force-with-lease` alone, without specifying the details, will protect
 all remote refs that are going to be updated by requiring their
 current value to be the same as the remote-tracking branch we have
-for them.
+for them. This behavior can be made default using the `push.forceWithLease`
+configuration option. Consult linkgit:git-config[1]. For more
+information.
 +
 `--force-with-lease=<refname>`, without specifying the expected value, will
 protect the named ref (alone), if it is going to be updated, by
diff --git a/builtin/push.c b/builtin/push.c
index 03846e8..d8fa826 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -561,6 +561,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 
 	packet_trace_identity("push");
 	git_config(git_push_config, &flags);
+	if (push_force_with_lease) {
+		cas.use_tracking_for_rest = 1;
+	}
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 	set_push_cert_flags(&flags, push_cert);
 
diff --git a/cache.h b/cache.h
index 96055c2..5d29e8e 100644
--- a/cache.h
+++ b/cache.h
@@ -830,6 +830,7 @@ enum push_default_type {
 extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
 extern enum push_default_type push_default;
+extern int push_force_with_lease;
 
 enum object_creation_mode {
 	OBJECT_CREATION_USES_HARDLINKS = 0,
diff --git a/config.c b/config.c
index 1cd40a5..f1b1e28 100644
--- a/config.c
+++ b/config.c
@@ -1317,6 +1317,10 @@ static int git_default_push_config(const char *var, const char *value)
 		}
 		return 0;
 	}
+	if (!strcmp(var, "push.forcewithlease")) {
+		push_force_with_lease = git_config_bool(var, value);
+		return 0;
+	}
 
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
diff --git a/environment.c b/environment.c
index d40b21f..fb36c1b 100644
--- a/environment.c
+++ b/environment.c
@@ -53,6 +53,7 @@ unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
+int push_force_with_lease = 0;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
-- 
2.7.4

