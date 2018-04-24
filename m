Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 839241F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeDXV5P (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:57:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51724 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeDXV5N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:57:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id j4so3823357wme.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hWZt8pVEDNbZ8uAMZYWFmUBF4JbO3Ed4bhQDeh8NqqA=;
        b=ioccnUZvlfdAWVjSDm7hE4qnbgIDpABuPpj/W0lH2TxJYNB30ORtxaNBTG1CIKNq6i
         hRhXFIEpYTqyUu0kdNpTFmpy468tjzHOX5sWFhLDEIxwoVH/mGPJyd58ohzyqHcXGyN0
         tPKy/8otOfNis5ZxYYsO4cYiAi9cF/rd/OLqgIu7ihNw4kdxSQ9lRrh25sirNRuV0nSa
         O3LQS4agvt1RaeZzjGyBqGMc3mgPWNQuqpe2yNi9IlIJyAX5ZOg1fUMBpu6PNXVqHk4t
         WE2/fWkuYXd9odaT8KHgmSZuqHMDG96SscmjZITdLXBPkfFvs8C60v6yat9tL5fTN6bD
         gEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hWZt8pVEDNbZ8uAMZYWFmUBF4JbO3Ed4bhQDeh8NqqA=;
        b=hR9uv8/Qk/YjjXMWVx8ChpVYxgICX8EjkEspgcbL9c/7/6QEi6Oc0lfUWn3sbgTvlM
         U0Bh6j+zSD1AxL5h+KMJL4nZUc/MHRui7OiKok5zcCQ1K4f/dlCLokN7u6kDz/xRdwCp
         4vR5qcV3cpbmSNakt4P0vgpvq9mlcSmz8Z2zOX9lVloo83a0uX9290L/9yo4ej0lEAtV
         E/emiu/4xLGMketxiv8Rn3kn9nJG0J3cH+79n04eP4LSXKAyAQwkrxjp2UT3FFmegKmT
         65dYwL1sgOo5CmkoVCkeusxYc29/FjctSRURjA/7RaGVCOrOClP3Sxzxe8IFlNSNX5bS
         fr0w==
X-Gm-Message-State: ALQs6tAP7N5Hk8gTRpbFe2PLxRV/eW8ECmfSY0PITEWQSzVOZiR983YE
        D22RmM1wWdy9QmQJyNOkvczqTlw3
X-Google-Smtp-Source: AIpwx4+0VBFSKGWCx4lau8qVZL9fLtY7kJWXPMoWJ9BE9eA/aXvg+FUe0ooNCP+yrryDeqsTB+IejA==
X-Received: by 10.28.182.70 with SMTP id g67mr13813674wmf.88.1524607031094;
        Tue, 24 Apr 2018 14:57:11 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id m16sm16037605wmb.42.2018.04.24.14.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:57:10 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v9 2/4] worktree: improve message when creating a new worktree
Date:   Tue, 24 Apr 2018 22:56:33 +0100
Message-Id: <20180424215635.9183-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.76.ga910c1dec4
In-Reply-To: <20180424215635.9183-1-t.gummerer@gmail.com>
References: <20180423193848.5159-1-t.gummerer@gmail.com>
 <20180424215635.9183-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git worktree add' produces output like the following:

    Preparing ../foo (identifier foo)
    HEAD is now at 26da330922 <title>

The '../foo' is the path where the worktree is created, which the user
has just given on the command line.  The identifier is an internal
implementation detail, which is not particularly relevant for the user
and indeed isn't mentioned explicitly anywhere in the man page.

Instead of this message, print a message that gives the user a bit more
detail of what exactly 'git worktree' is doing.  There are various dwim
modes which perform some magic under the hood, which should be
helpful to users.  Just from the output of the command it is not always
visible to users what exactly has happened.

Help the users a bit more by modifying the "Preparing ..." message and
adding some additional information of what 'git worktree add' did under
the hood, while not displaying the identifier anymore.

Currently there are several different cases:

  - 'git worktree add -b ...' or 'git worktree add <path>', both of
    which create a new branch, either through the user explicitly
    requesting it, or through 'git worktree add' implicitly creating
    it.  This will end up with the following output:

      Preparing worktree (new branch '<branch>')
      HEAD is now at 26da330922 <title>

  - 'git worktree add -B ...', which may either create a new branch if
    the branch with the given name does not exist yet, or resets an
    existing branch to the current HEAD, or the commit-ish given.
    Depending on which action is taken, we'll end up with the following
    output:

      Preparing worktree (resetting branch '<branch>'; was at caa68db14)
      HEAD is now at 26da330922 <title>

    or:

      Preparing worktree (new branch '<branch>')
      HEAD is now at 26da330922 <title>

  - 'git worktree add --detach' or 'git worktree add <path>
    <commit-ish>', both of which create a new worktree with a detached
    HEAD, for which we will print the following output:

      Preparing worktree (detached HEAD 26da330922)
      HEAD is now at 26da330922 <title>

  - 'git worktree add <path> <local-branch>', which checks out the
    branch and prints the following output:

      Preparing worktree (checking out '<local-branch>')
      HEAD is now at 47007d5 <title>

Additionally currently the "Preparing ..." line is printed to stderr,
while the "HEAD is now at ..." line is printed to stdout by 'git reset
--hard', which is used internally by 'git worktree add'.  Fix this
inconsistency by printing the "Preparing ..." message to stdout as
well.  As "Preparing ..." is not an error, stdout also seems like the
more appropriate output stream.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/worktree.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index bf305c8b7b..39bf1ea865 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -301,8 +301,6 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
 
-	fprintf_ln(stderr, _("Preparing %s (identifier %s)"), path, name);
-
 	argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 	cp.git_cmd = 1;
@@ -355,6 +353,40 @@ static int add_worktree(const char *path, const char *refname,
 	return ret;
 }
 
+static void print_preparing_worktree_line(int detach,
+					  const char *branch,
+					  const char *new_branch,
+					  int force_new_branch)
+{
+	if (force_new_branch) {
+		struct commit *commit = lookup_commit_reference_by_name(new_branch);
+		if (!commit)
+			printf_ln(_("Preparing worktree (new branch '%s')"), new_branch);
+		else
+			printf_ln(_("Preparing worktree (resetting branch '%s'; was at %s)"),
+				  new_branch,
+				  find_unique_abbrev(commit->object.oid.hash,
+						     DEFAULT_ABBREV));
+	} else if (new_branch) {
+		printf_ln(_("Preparing worktree (new branch '%s')"), new_branch);
+	} else {
+		struct strbuf s = STRBUF_INIT;
+		if (!detach && !strbuf_check_branch_ref(&s, branch) &&
+		    ref_exists(s.buf))
+			printf_ln(_("Preparing worktree (checking out '%s')"),
+				  branch);
+		else {
+			struct commit *commit = lookup_commit_reference_by_name(branch);
+			if (!commit)
+				die(_("invalid reference: %s"), branch);
+			printf_ln(_("Preparing worktree (detached HEAD %s)"),
+				  find_unique_abbrev(commit->object.oid.hash,
+						     DEFAULT_ABBREV));
+		}
+		strbuf_release(&s);
+	}
+}
+
 static int add(int ac, const char **av, const char *prefix)
 {
 	struct add_opts opts;
@@ -435,6 +467,8 @@ static int add(int ac, const char **av, const char *prefix)
 		}
 	}
 
+	print_preparing_worktree_line(opts.detach, branch, new_branch, !!new_branch_force);
+
 	if (new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		cp.git_cmd = 1;
-- 
2.16.1.74.g7afd1c25cc.dirty

