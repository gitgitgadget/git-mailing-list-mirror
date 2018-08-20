Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48BBD1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 15:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeHTS5j (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 14:57:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43861 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeHTS5j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 14:57:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id f135-v6so11236177lfg.10
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 08:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=12BPE4CUuTJhGYacxwGPLVj1nu91SoyOcZPMWVlXxEE=;
        b=ahTO4gGq/e1dgx1a/2gnCMSzbCUldZu11ywZ9t+W1SDuri4Bbio8UCd1e1WDkBfc5w
         UW5rxwH6hF6PZENDROFD/lMZcnud4JMili/2wf5f+3eBoCR9HcG38wv8dIQ//2n989l8
         KE7BtPZN5JgVMzJwmDH13Ey8UdL6BqEmKr+NOG9dcAJzYUEMtU5NPCi9euTLUdbiDCWw
         vMeeQP4eXyRGRHmzeL3CJ+7n1MhscZjqWbHlGhzhsYnow61nPKyxtiuphQsqgWRBNnse
         3BA3QVK922eETqodIdIW3VAw62PJ4u3N7lcybmoQWW2JmJux9QJsMbQi+hMS2voFlq1E
         VYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=12BPE4CUuTJhGYacxwGPLVj1nu91SoyOcZPMWVlXxEE=;
        b=EFnHG5mOmtpswTn3iYSVc8a6JNqdVC01Ts+87kM8yUTJ4B3+RUrbmE7IjfeFR9hT6Q
         d4xWUukJQdVZzRAOadVBcqr8BQ4yGYIQMhAx1hMMnwanrrGNtXWwtjfi6t7vnRGkHPml
         ocNMtiHkoHAHW8IZNSlQLb2XmniHo+opNFJBYRAA+E57dfHVpF1kB3FSegQVNzLNFiMb
         Nk5LvvK3kQzIZnoBhOBnenVD/vqyW8aHh3TVU8Tkj/NyNuUUnRRCkWKN9QeGO4TMWbxI
         v+TukBhJs4oayQ0hvVzGKziXw8YQnDW7I2a9MzjTWHfB9/5LOymi8B1f5RtEiE6k1PXd
         qkVQ==
X-Gm-Message-State: AOUpUlF1lhNgqq1ILi/3IJcpq6bOZSdrPrG7cTM3JKEfWWYut4SZ5wAs
        3rC822gTStapMhO2wmxlDKXReUNA
X-Google-Smtp-Source: AA+uWPwA0ok47OtWHKVEagygq99+Bzj2Ini9C2l0aeR8QhSxOXckuHw70iHjbxWBpy/ReJ1dzKP+1w==
X-Received: by 2002:a19:290c:: with SMTP id p12-v6mr28798516lfp.124.1534779689357;
        Mon, 20 Aug 2018 08:41:29 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n3-v6sm1659729lji.96.2018.08.20.08.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 08:41:28 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC] commit: new option to abort -a something is already staged
Date:   Mon, 20 Aug 2018 17:41:20 +0200
Message-Id: <20180820154120.19297-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1003.g5e2e2c8169
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So many times I have carefully cherry picked changes to the index with
`git add -p` then accidentally did `git commit -am ....` (usually by
retrieving a command from history and pressing Enter too quickly)
which destroyed beautiful index.

One way to deal with this is some form of `git undo` that allows me to
retrieve the old index. That's not a lot of work by itself. The problem
is designing that `git undo` interface because there are more undo
options that this.

Instead, let's handle just this problem for now. This new option
commit.preciousDirtyIndex, if set to false, will not allow `commit -a`
to continue if the final index is different from the existing one. I
don't think this can be achieved with hooks because the hooks don't
know about "-a" or different commit modes.

Or is there a better way to handle this?

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt |  5 +++++
 builtin/commit.c         | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 95ad715a44..3937681ee9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1417,6 +1417,11 @@ commit.gpgSign::
 	convenient to use an agent to avoid typing your GPG passphrase
 	several times.
 
+commit.preciousDirtyIndex::
+	If some changes are partially staged in the index (i.e.
+	"git commit -a" and "git commit" commit different changes), reject
+	"git commit -a".
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/builtin/commit.c b/builtin/commit.c
index 213fca2d8e..489e4b9f50 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -98,6 +98,7 @@ static const char *author_message, *author_message_buffer;
 static char *edit_message, *use_message;
 static char *fixup_message, *squash_message;
 static int all, also, interactive, patch_interactive, only, amend, signoff;
+static int allow_dirty_index = 1;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int config_commit_verbose = -1; /* unspecified */
@@ -385,10 +386,24 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	 * (B) on failure, rollback the real index.
 	 */
 	if (all || (also && pathspec.nr)) {
+		int compare_oid = all && !allow_dirty_index;
+		struct object_id previous_oid;
+
+		if (compare_oid) {
+			if (update_main_cache_tree(0) || !the_index.cache_tree)
+				die(_("error building trees"));
+			if (the_index.cache_tree->entry_count >= 0)
+				oidcpy(&previous_oid, &the_index.cache_tree->oid);
+			else
+				oidclr(&previous_oid);
+		}
 		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
+		if (compare_oid && the_index.cache_tree &&
+		    oidcmp(&previous_oid, &the_index.cache_tree->oid))
+			die(_("staged content is different, aborting"));
 		if (write_locked_index(&the_index, &index_lock, 0))
 			die(_("unable to write new_index file"));
 		commit_style = COMMIT_NORMAL;
@@ -1413,6 +1428,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
 		return 0;
 	}
+	if (!strcmp(k, "commit.preciousdirtyindex")) {
+		allow_dirty_index = !git_config_bool(k, v);
+		return 0;
+	}
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
-- 
2.18.0.1003.g5e2e2c8169

