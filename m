Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F1451F404
	for <e@80x24.org>; Sat, 17 Mar 2018 22:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeCQWUZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 18:20:25 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33746 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbeCQWUY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 18:20:24 -0400
Received: by mail-wr0-f196.google.com with SMTP id z73so10713654wrb.0
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 15:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=312NMis5jDZgQMFX2pQwsxTvGPpO6h5gp56PlzvynMA=;
        b=mzO7bcupW7mAVUP1Fyfw6bgu5IqSLcWWXM1qBfGh5TUv30+MGaIcRzBO34FoXaj2ZM
         lJfKneAAHU5BVjGu4NAuIAjKgste/MHEPBMZ6kJJaOeK+najo0hF4XkgEO9YDgI9CFhJ
         hOBBsvOrxPiyS/VPAcoA0458bf8iw1jILw6tFfUH5tebgYgBmIlagvg7lxxXFgG8/QOd
         VruXPscxasgCaQHiOp/dNVT7z4nhMEenUQ5xiOeNfdX+vD6PyIB0DUDlk7f/iFpyaJSt
         BZK752GS4T7VmtJqhKI3w/iFHg4JzZslemaJ2T1GFsGsIlNwCnCE5CZtzZCcL//e7bIq
         bDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=312NMis5jDZgQMFX2pQwsxTvGPpO6h5gp56PlzvynMA=;
        b=PZ82mF2wxon9LktTGVaA5BYeerHiYL1wQttHeXwydhZiTb6nN5AdFNr7O3ZbCxkMUs
         zzheW81LppnJkhJwkWbj96GzQ/3yfpC5W1H1NvCyrlwnExRC2aIoFC8fWkmzJgpcuHEC
         eajBtbRNHTwuN63chex453zNhloOZ4QfOB+8jvvxnb2o3SNI33V2xnLpxHXZB3b7RnP8
         CSMtFeXRQdrKdfhvomeqYnO8iRrOIZxdyipyGm/512IRHuc5hKaOJm89hbjPtyTmrg0R
         fVPvX/U0uVwweZ5i/0FyBKOgK29qxeBic6QGtrK1E7c3LdXNsVh5rfCjB3oASattjAdc
         8NNw==
X-Gm-Message-State: AElRT7FldhiE+ttdduJAyFfHaespcRZ7V6PUBeYRjjcJzTZZqbOecBzw
        AkiIbNY6ShTWTy0OWzGmilK0+e9t
X-Google-Smtp-Source: AG47ELuqIZdJoCcGBce36i7pVSQl+X/IaINelpSwOfeNuVy2TK+QFwE9346xL4XGIuMa3G2gb45mDA==
X-Received: by 10.223.198.70 with SMTP id u6mr5096069wrg.216.1521325223215;
        Sat, 17 Mar 2018 15:20:23 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 31sm9039897wrr.59.2018.03.17.15.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 15:20:22 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 0/4] worktree: teach "add" to check out existing branches
Date:   Sat, 17 Mar 2018 22:22:15 +0000
Message-Id: <20180317222219.4940-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f06
In-Reply-To: <20180317220830.30963-1-t.gummerer@gmail.com>
References: <20180317220830.30963-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please ignore v3 of this series, I just noticed that I botched the
last commit :(  sorry about the noise.

Previous rounds (other than v3) are at <20180121120208.12760-1-t.gummerer@gmail.com>
and <20180204221305.28300-1-t.gummerer@gmail.com>.  Thanks Duy, Eric
and Junio for the comments on the previous round.

This round improves the end user facing messages, and factors out a
dwim_branch function as suggested by Duy.

Interdiff between this and v2 below:

diff --git a/builtin/worktree.c b/builtin/worktree.c
index ea420bb90b..df5c0427ba 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -304,8 +304,6 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
 
-	fprintf(stderr, _("Preparing %s (identifier %s)"), path, name);
-
 	argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 	cp.git_cmd = 1;
@@ -322,12 +320,12 @@ static int add_worktree(const char *path, const char *refname,
 		goto done;
 
 	if (opts->checkout_existing_branch)
-		fprintf(stderr, _(", checking out existing branch '%s'"),
+		fprintf(stderr, _("checking out branch '%s'"),
 			refname);
 	else if (opts->new_branch)
-		fprintf(stderr, _(", creating new branch '%s'"), opts->new_branch);
+		fprintf(stderr, _("creating branch '%s'"), opts->new_branch);
 
-	fprintf(stderr, _(", setting HEAD to %s"),
+	fprintf(stderr, _("worktree HEAD is now at %s"),
 		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
 
 	strbuf_reset(&sb);
@@ -373,6 +371,31 @@ static int add_worktree(const char *path, const char *refname,
 	return ret;
 }
 
+static const char *dwim_branch(const char *path, struct add_opts *opts)
+{
+	int n;
+	const char *s = worktree_basename(path, &n);
+	const char *branchname = xstrndup(s, n);
+	struct strbuf ref = STRBUF_INIT;
+
+	if (!strbuf_check_branch_ref(&ref, branchname) &&
+	    ref_exists(ref.buf)) {
+		opts->checkout_existing_branch = 1;
+		strbuf_release(&ref);
+		UNLEAK(branchname);
+		return branchname;
+	}
+
+	opts->new_branch = branchname;
+	if (guess_remote) {
+		struct object_id oid;
+		const char *remote =
+			unique_tracking_name(opts->new_branch, &oid);
+		return remote;
+	}
+	return NULL;
+}
+
 static int add(int ac, const char **av, const char *prefix)
 {
 	struct add_opts opts;
@@ -425,27 +448,9 @@ static int add(int ac, const char **av, const char *prefix)
 	}
 
 	if (ac < 2 && !opts.new_branch && !opts.detach) {
-		int n;
-		const char *s = worktree_basename(path, &n);
-		const char *branchname = xstrndup(s, n);
-		struct strbuf ref = STRBUF_INIT;
-
-		if (!strbuf_check_branch_ref(&ref, branchname) &&
-		    ref_exists(ref.buf)) {
-			branch = branchname;
-			opts.checkout_existing_branch = 1;
-			UNLEAK(branch);
-		} else {
-			opts.new_branch = branchname;
-			if (guess_remote) {
-				struct object_id oid;
-				const char *remote =
-					unique_tracking_name(opts.new_branch, &oid);
-				if (remote)
-					branch = remote;
-			}
-		}
-		strbuf_release(&ref);
+		const char *dwim_branchname = dwim_branch(path, &opts);
+		if (dwim_branchname)
+			branch = dwim_branchname;
 	}
 
 	if (ac == 2 && !opts.new_branch && !opts.detach) {

Thomas Gummerer (4):
  worktree: improve message when creating a new worktree
  worktree: be clearer when "add" dwim-ery kicks in
  worktree: factor out dwim_branch function
  worktree: teach "add" to check out existing branches

 Documentation/git-worktree.txt |  9 ++++--
 builtin/worktree.c             | 58 ++++++++++++++++++++++++++--------
 t/t2025-worktree-add.sh        | 15 +++++++--
 3 files changed, 64 insertions(+), 18 deletions(-)

-- 
2.17.0.rc0.231.g781580f06

