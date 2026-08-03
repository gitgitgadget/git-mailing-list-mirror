Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBBD3749EF
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750643; cv=none; b=Uwi15AeB4yI4TWbQqcQFP1uv9NkJioZuuDTjYiAMbQdbcWYOqsCBhsxo2Dg00kBNXnUJbgVskxulmvvSWJM8FN9QEvNdfaERp29duvoPea1UKNQSgnU48hdg6fj5vyoN0wheKdvOJt4pJPGRiIrnsE2tq6i7tyBu5GouQX4kjHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750643; c=relaxed/simple;
	bh=NV/aOrcoHwhGlff8TNjDFeUMHLBcis0TUXQ8+7bLXzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aR1ziSQ7Cz1Mc896xP2m61bRv/TPrdU9WTIt27EP3cmO2syRl7ehw3bhsNpQ6p4fh6zfIRymRO4RY5PKieeOzblQb8ivfUIuc4wq+/nNA9JR1J1qgiDlkYDq6Myl38r5Y3cX8nf7j3nm+cnulk0LjHT2hmByXWYPIthJPFnnYiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdXBW6nH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdXBW6nH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49557167508so16936975e9.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 02:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785750640; x=1786355440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CEl9Rodvh4UbRJoa5m6KMI/JQJ/UoHeYuSuhvWJXxY0=;
        b=IdXBW6nHXuBSXeqSHmaiE0+5BF87KxrvRAl1t3SmPuxisuiMfYF1tA0XtpshRZCKok
         VTwafboP2LcY0ZRcNa37W767zZeqP+Kmui9C1hoPcOKXIeF+y5QLvJHeyuJB/Am1uFyx
         1IgjTx+0Z83Y3URIxrTb7TVWjygWjEd6iJ867iEalTzaohxt0iTMZHmRSs2ARoUqMvzZ
         yck5mh+5RzHUSdRLPpaCNzCJyBiyJUTF0XDk7PCCFJMjJlw2x//jxhbS4hiXfQSPOK9/
         Ix7vcs97yXCNk00Q35aff+bwawRXKYcTev4Y6r0MvR8jFetRPkth3u+iB7PtpPFIiUKl
         VEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750640; x=1786355440;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CEl9Rodvh4UbRJoa5m6KMI/JQJ/UoHeYuSuhvWJXxY0=;
        b=HB9kyOetNvVrfe/yznMqfk8Co/RMLVGt3+NMNNqu3KVJzRnNBSoH2malX2nw1sEyLL
         W8BlM6rJ6GyuEzTrso9oL1XRct0W9FJ8+ojpLW0HY+Dzrxe7G5zQQZ+IzM8tNEIXxmG+
         czrlGq6WmpjqvBg6P83JjEKhuJhIABhNdBb0LxiM9Ip79Xhi9ctkIrlPCMCbHZuUp4cy
         vrHautUPXBhmj4Wqc1vtDdddGLwfO7sXKmCrQBVNVc3/ASiuIZVo4NCOMp4TWF3l/Yv+
         TBDIRNgPaQlRC6vqQTQ79t8IOGRQIFzdfCUjU9/pssP0N1+kMrKOvkxMujRRM2Ayz2SZ
         z6fA==
X-Gm-Message-State: AOJu0YxphvUrxUoNxOp9yGG9Y5TzPZSpHVUsIw2e4eNlE1NDUNAs5sIS
	g5irNZlL5gNrKamK/sMkQP/Npy4WIlufqYW8oetaPpi296Z3ESjri5skIeJmyA==
X-Gm-Gg: AR+sD127EsW/lEuKB+mkdRfMMzMbR3txgePtmibJ9XtZOYqOhnQh/bJJlB7C5k1jH//
	52saY53qm1cKnlYzB/bzL+2ug4QW4YCtbviw3njYTmiSk5Ii+71ckSXTz0elueWlGk89PK3YFM1
	uH6by3EdkXwj+5ARE8+fa1LnzQqZ4pzWxF2N6EIWz7I3G3li0XHv8j++CPJ7bPROlA8vzIVsPk+
	tRnzPkgxDXw6BIeN5AjWzjdXRcO+5bwoR3RCE55kd6Ehk+ith04lZkJAEakIDyoS9tOUNuoPxKJ
	5ER2tIrHka1U8JZwYeWyBcNQDfnd9MN7uTTojQ53oz97ffc6TwJGrTZFbxrdwu2DbpMXn8g+JKq
	wcIcm8UFGGHovEHXqR8EKgTaoHisbLE4aHRVV2a2IHYKx2sadgQzARbp7zYe07UoGzOXHP1yy5U
	OLfRR+PVoF1hEe3/iAAW5OY2SFkK7Bp9UNqEtjrrVbN9/5ZwSpgJfv3aZKGDwMHCOI
X-Received: by 2002:a05:600c:1393:b0:495:4fd4:619b with SMTP id 5b1f17b1804b1-4980c649c54mr222222575e9.1.1785750639786;
        Mon, 03 Aug 2026 02:50:39 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b67529sm225414585e9.8.2026.08.03.02.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:50:39 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org,
	Harald Nordgren <haraldnordgren@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Matt Hunter <m@lfurio.us>,
	Patrick Steinhardt <ps@pks.im>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v10 3.1/3.7] fixup! history: add squash subcommand to fold a range
Date: Mon,  3 Aug 2026 10:49:21 +0100
Message-ID: <15bba505bf84745e221945186ed0ab4da4be22a0.1785750108.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1785750108.git.phillip.wood@dunelm.org.uk>
References: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com> <cover.1785750108.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunlem.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Rework the parsing of rev-list options

The code for setting up the options for setup_revisions() is a strange
mix of passing options and directly setting members of struct rev_info.
Consistently set the required options in the struct so that we don't
have to duplicate argv. This matches what we do in "git replay".

While I don't think it is possible for the user to override
--ancestry-path currently, add checks incase that becomes possible
in the future.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/history.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 423c8beaaf..1d6d934bbe 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1015,7 +1015,7 @@ static int cmd_history_split(int argc,
  * but the range must have a single base and must not reach a root commit.
  */
 static int resolve_squash_range(struct repository *repo,
-				const char **argv,
+				int argc, const char **argv,
 				struct commit **base_out,
 				struct commit **oldest_out,
 				struct commit **tip_out,
@@ -1024,7 +1024,6 @@ static int resolve_squash_range(struct repository *repo,
 	struct rev_info revs;
 	struct commit *commit, *base = NULL, *oldest = NULL, *tip = NULL;
 	struct commit_list *boundaries = NULL, *b;
-	struct strvec args = STRVEC_INIT;
 	size_t i;
 	int ret;
 
@@ -1034,26 +1033,31 @@ static int resolve_squash_range(struct repository *repo,
 	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
 	revs.simplify_history = 0;
 	revs.boundary = 1;
+	revs.ancestry_path = 1;
+	revs.limited = 1;
+	revs.ancestry_path_implicit_bottoms = 1;
 
-	strvec_push(&args, "ignored");
-	strvec_push(&args, "--ancestry-path");
-	strvec_pushv(&args, argv);
-	setup_revisions_from_strvec(&args, &revs, NULL);
-	if (args.nr != 1) {
-		ret = error(_("unrecognized argument: %s"), args.v[1]);
+	argc = setup_revisions(argc, argv, &revs, NULL);
+	if (argc > 1) {
+		ret = error(_("unrecognized argument: %s"), argv[1]);
 		goto out;
 	}
 
 	if (revs.reverse != 1 || revs.topo_order != 1 ||
 	    revs.sort_order != REV_SORT_IN_GRAPH_ORDER ||
-	    revs.simplify_history != 0 || revs.boundary != 1) {
+	    revs.simplify_history != 0 || revs.boundary != 1 ||
+	    revs.ancestry_path != 1 || revs.limited != 1 ||
+	    revs.ancestry_path_implicit_bottoms != 1) {
 		warning(_("ignoring rev-list options that would change how the "
 			  "range is walked"));
 		revs.reverse = 1;
 		revs.topo_order = 1;
 		revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
 		revs.simplify_history = 0;
 		revs.boundary = 1;
+		revs.ancestry_path = 1;
+		revs.limited = 1;
+		revs.ancestry_path_implicit_bottoms = 1;
 	}
 
 	/*
@@ -1124,7 +1128,6 @@ static int resolve_squash_range(struct repository *repo,
 	commit_list_free(boundaries);
 	reset_revision_walk();
 	release_revisions(&revs);
-	strvec_clear(&args);
 	return ret;
 }
 
@@ -1290,8 +1293,8 @@ static int cmd_history_squash(int argc,
 	int ret;
 
 	argc = parse_options(argc, argv, prefix, options, usage,
-			     PARSE_OPT_KEEP_UNKNOWN_OPT);
-	if (!argc) {
+			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
+	if (argc < 2) {
 		ret = error(_("command expects a revision range"));
 		goto out;
 	}
@@ -1300,7 +1303,10 @@ static int cmd_history_squash(int argc,
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
 
-	ret = resolve_squash_range(repo, argv, &base, &oldest, &tip,
+	strbuf_addstr(&reflog_msg, "squash: updating ");
+	strbuf_join_argv(&reflog_msg, argc - 1, argv + 1, ' ');
+
+	ret = resolve_squash_range(repo, argc, argv, &base, &oldest, &tip,
 				   &interior);
 	if (ret < 0)
 		goto out;
@@ -1353,9 +1359,6 @@ static int cmd_history_squash(int argc,
 		ret = error(_("failed writing squashed commit"));
 		goto out;
 	}
-
-	strbuf_addstr(&reflog_msg, "squash: updating ");
-	strbuf_join_argv(&reflog_msg, argc, argv, ' ');
 
 	ret = handle_reference_updates(&revs, action, tip, rewritten,
 				       reflog_msg.buf, dry_run,
-- 
2.54.0.200.gfd8d68259e3

