Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89E1C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 16:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJJQFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJJQEh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 12:04:37 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DB972865
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id ay36so7126534wmb.0
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4rQTbvaCRVozw1Biie9jlqbUFXmD36XSWvWFWJBH7c=;
        b=g7Kc2UDHcSqOYowtkoCHSGjgGoKFHU/PZFEAO9ysRNNKjcmnXpK95Caou7Kp5U32NC
         jR1TMuGK5evOz88ZTq9mDBPLrPfPjGM+0q+vVMTst/ZoW87fbHHsjcNAUUcYeRJACdd/
         NRZb81tSw/MLn+kuZeqsB7OPzzqKa2F3lso54B0r1Tk72tU5qnqANcH41DFpqUZIHEiV
         2upz/FMadKDk7d49x0jzi3bHg1e/FRK3WQMKj/ThriPs3MqgSeTiovg2jqBV5a6WY2YX
         t2yA3RSumN/tHKUMCmcvoNONK4qdv0Ht+4zeRvMOMzyENkN2LgIvtqHfeRnY72RX/jxf
         CV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4rQTbvaCRVozw1Biie9jlqbUFXmD36XSWvWFWJBH7c=;
        b=xAbL1y2+FOWfq0QB6lfktAzJgnOnkJlMwyPxLfL76QD80Ri+m8J2n9hWaVpgCAZG3g
         PLv59KWe8nwr+oCSPN0z1x0N77cJFel/xXw/PTQ2ZqflISd1s7Sg+x99w3gSTH72Zscg
         mpaYTNvJxLvW9lXVchVlSBmJmM2zkpfMdjbu1yP/yvm/k7aXjJd+UDKxu5THORhstHuM
         j5721hNZb/1LggpEziSQlWCSWP+/A32KZRS920wOI22B/1UwnMpwdOCtoRJdYjw8gI4F
         ybdMpQ5pCMDVSQYvrz7Pfk226hosQ/2G0eHbgRe7LM4F7oxxFrSG9YQu/9kNzhwI3i98
         iv+Q==
X-Gm-Message-State: ACrzQf10GbqHv+MMn2Ytg0qNHU5U7KEYHhyu1R6O3px0Vzrgyf3Lgtq5
        4lzSTd4WSPrvCJUIi19loZwwgTX33H4=
X-Google-Smtp-Source: AMsMyM7tvyBKJpgJfTQ1Ke7auuK10cQAtqIEJEQGC1VhzMCxHnaxikGCGXOUwRq9+cIUhNl54M2zig==
X-Received: by 2002:a7b:cb93:0:b0:3c5:81c5:9dc8 with SMTP id m19-20020a7bcb93000000b003c581c59dc8mr6873199wmi.196.1665417870986;
        Mon, 10 Oct 2022 09:04:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b003c4ecff4e25sm7274962wmq.9.2022.10.10.09.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:04:30 -0700 (PDT)
Message-Id: <83f2cd893a4c47c947a93fe99d202d67f540e963.1665417859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
References: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
        <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 16:04:16 +0000
Subject: [PATCH v4 08/11] bundle: add flags to verify_bundle(), skip walk
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The verify_bundle() method checks if a bundle can be applied to a given
repository. This not only verifies that certain commits exist in the
repository, but Git also checks that these commits are reachable.

This behavior dates back to the original git-bundle builtin written in
2e0afafebd8 (Add git-bundle: move objects and references by archive,
2007-02-22), but the message does not go into detail why the
reachability check is important.

Since verify_bundle() is called from unbundle(), we need to add an
option to pipe the flags through that method.

When unbundling from a list of bundles, Git will create refs that point
to the tips of the latest bundle, which makes this reachability walk
succeed, in theory. However, the loose refs cache does not get
invalidated and hence the reachability walk fails. By disabling the
reachability walk in the bundle URI code, we can get around this
reachability check.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/bundle.c |  5 +++--
 bundle-uri.c     |  8 +++++++-
 bundle.c         | 12 +++++++-----
 bundle.h         | 15 +++++++++++++--
 transport.c      |  2 +-
 5 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 2adad545a2e..7d983a238f0 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -119,7 +119,8 @@ static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
 		goto cleanup;
 	}
 	close(bundle_fd);
-	if (verify_bundle(the_repository, &header, !quiet)) {
+	if (verify_bundle(the_repository, &header,
+			  quiet ? 0 : VERIFY_BUNDLE_VERBOSE)) {
 		ret = 1;
 		goto cleanup;
 	}
@@ -185,7 +186,7 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 		strvec_pushl(&extra_index_pack_args, "-v", "--progress-title",
 			     _("Unbundling objects"), NULL);
 	ret = !!unbundle(the_repository, &header, bundle_fd,
-			 &extra_index_pack_args) ||
+			 &extra_index_pack_args, 0) ||
 		list_bundle_refs(&header, argc, argv);
 	bundle_header_release(&header);
 cleanup:
diff --git a/bundle-uri.c b/bundle-uri.c
index 8a7c11c6393..ad5baabdd94 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -301,7 +301,13 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	if ((bundle_fd = read_bundle_header(file, &header)) < 0)
 		return 1;
 
-	if ((result = unbundle(r, &header, bundle_fd, NULL)))
+	/*
+	 * Skip the reachability walk here, since we will be adding
+	 * a reachable ref pointing to the new tips, which will reach
+	 * the prerequisite commits.
+	 */
+	if ((result = unbundle(r, &header, bundle_fd, NULL,
+			       VERIFY_BUNDLE_SKIP_REACHABLE)))
 		return 1;
 
 	/*
diff --git a/bundle.c b/bundle.c
index 0208e6d90d3..36ffeb1e0eb 100644
--- a/bundle.c
+++ b/bundle.c
@@ -189,7 +189,7 @@ static int list_refs(struct string_list *r, int argc, const char **argv)
 
 int verify_bundle(struct repository *r,
 		  struct bundle_header *header,
-		  int verbose)
+		  enum verify_bundle_flags flags)
 {
 	/*
 	 * Do fast check, then if any prereqs are missing then go line by line
@@ -222,7 +222,8 @@ int verify_bundle(struct repository *r,
 			error("%s", message);
 		error("%s %s", oid_to_hex(oid), name);
 	}
-	if (revs.pending.nr != p->nr)
+	if (revs.pending.nr != p->nr ||
+	    (flags & VERIFY_BUNDLE_SKIP_REACHABLE))
 		goto cleanup;
 	req_nr = revs.pending.nr;
 	setup_revisions(2, argv, &revs, NULL);
@@ -259,7 +260,7 @@ int verify_bundle(struct repository *r,
 			clear_commit_marks(commit, ALL_REV_FLAGS);
 	}
 
-	if (verbose) {
+	if (flags & VERIFY_BUNDLE_VERBOSE) {
 		struct string_list *r;
 
 		r = &header->references;
@@ -620,7 +621,8 @@ err:
 }
 
 int unbundle(struct repository *r, struct bundle_header *header,
-	     int bundle_fd, struct strvec *extra_index_pack_args)
+	     int bundle_fd, struct strvec *extra_index_pack_args,
+	     enum verify_bundle_flags flags)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
@@ -634,7 +636,7 @@ int unbundle(struct repository *r, struct bundle_header *header,
 		strvec_clear(extra_index_pack_args);
 	}
 
-	if (verify_bundle(r, header, 0))
+	if (verify_bundle(r, header, flags))
 		return -1;
 	ip.in = bundle_fd;
 	ip.no_stdout = 1;
diff --git a/bundle.h b/bundle.h
index 0c052f54964..9f798c00d93 100644
--- a/bundle.h
+++ b/bundle.h
@@ -29,7 +29,14 @@ int read_bundle_header_fd(int fd, struct bundle_header *header,
 int create_bundle(struct repository *r, const char *path,
 		  int argc, const char **argv, struct strvec *pack_options,
 		  int version);
-int verify_bundle(struct repository *r, struct bundle_header *header, int verbose);
+
+enum verify_bundle_flags {
+	VERIFY_BUNDLE_VERBOSE = (1 << 0),
+	VERIFY_BUNDLE_SKIP_REACHABLE = (1 << 1)
+};
+
+int verify_bundle(struct repository *r, struct bundle_header *header,
+		  enum verify_bundle_flags flags);
 
 /**
  * Unbundle after reading the header with read_bundle_header().
@@ -40,9 +47,13 @@ int verify_bundle(struct repository *r, struct bundle_header *header, int verbos
  * Provide "extra_index_pack_args" to pass any extra arguments
  * (e.g. "-v" for verbose/progress), NULL otherwise. The provided
  * "extra_index_pack_args" (if any) will be strvec_clear()'d for you.
+ *
+ * Before unbundling, this method will call verify_bundle() with the
+ * given 'flags'.
  */
 int unbundle(struct repository *r, struct bundle_header *header,
-	     int bundle_fd, struct strvec *extra_index_pack_args);
+	     int bundle_fd, struct strvec *extra_index_pack_args,
+	     enum verify_bundle_flags flags);
 int list_bundle_refs(struct bundle_header *header,
 		int argc, const char **argv);
 
diff --git a/transport.c b/transport.c
index 52db7a3cb09..c5d3042731a 100644
--- a/transport.c
+++ b/transport.c
@@ -178,7 +178,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle_inner(transport);
 	ret = unbundle(the_repository, &data->header, data->fd,
-		       &extra_index_pack_args);
+		       &extra_index_pack_args, 0);
 	transport->hash_algo = data->header.hash_algo;
 	return ret;
 }
-- 
gitgitgadget

