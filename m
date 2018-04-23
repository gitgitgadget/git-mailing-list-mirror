Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20E171F424
	for <e@80x24.org>; Mon, 23 Apr 2018 19:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932382AbeDWTpX (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 15:45:23 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36553 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932244AbeDWTpW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 15:45:22 -0400
Received: by mail-wr0-f193.google.com with SMTP id u18-v6so17174198wrg.3
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 12:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cKTAC1n+S7lugnDjnJHXN/ByP27EHbk1TjfBDNogpWk=;
        b=lFGPwcCz+VPhbNXRyFP2H0YAOmYeTUaMMJkJ546ZmjMtIbOKzDF2i8RgrlDXGoHE+9
         iBQXEUbAMW2kJ3CgVdcaVlNfWy/qTvQG5XYh9CiLU8jfc/GdBoTL55eyNRBTLv8fIzru
         PvWodPTlPu8qpSYq4pNf5V0zqAy48rGumAlVptH27Yz3q1FSnXK18LT2GWHfsZbly2UH
         5uMC/vST7xb/e5VgZ0fzvk+yX2BSK35igWAX5sQJOUeqlJLOs5Vhu3fghJdg8uqJZrYq
         5F2lKVNBnSm5jc+nnlhfQY5F3V/YMF3nG+qsTbEjFXbC3OVF3sniWyjnSphbmlvWpfR2
         731Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cKTAC1n+S7lugnDjnJHXN/ByP27EHbk1TjfBDNogpWk=;
        b=khZ0kjBlbAJ+oTP8zLMKI+sEcS72Mx5LJgYN8q4oOnH0vuUz/9Q50g4zb2Jy10dDqR
         Fb6mJfG1spT4SvjSfMcL6runS3AepzRR+X9XbZ0OgrXsE0QEhOE0blaveslgJhc581e+
         JXHRq/xHBMFS0hwHlT6h7maoG1h8SNr0/GNuQZP5sTUOnoCQO+TlFILac0hZlyngxGX5
         lt94Rn8/y8TttM11cBc9p+RrS/1VIOdek7NxDFMdnOrqcHKo6/d2dMZoCX1ophG+qKUn
         V+q3MVqUkoReE/Bs5CS9ZhzLZkQFKfs+LeIOcvaZGkO5nUUBdBw7y7YmAQPg8uEsvyFf
         Na4w==
X-Gm-Message-State: ALQs6tBKlyqNe+G04zCGiwqbMj70y8m/pD26eMYJeYPHD2mvd2/OU1zY
        fgtukwz4N1bczsVlU+2RKGriY77o
X-Google-Smtp-Source: AB8JxZro9P6gC4YBvNwhYUfgWBq0+FTLC3uH7toAhhokm/hkjNuYUU53NOnwcfoUEDjRYCag0zQGWg==
X-Received: by 10.28.58.147 with SMTP id h141mr10710071wma.67.1524512720739;
        Mon, 23 Apr 2018 12:45:20 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id j21-v6sm17293895wrb.49.2018.04.23.12.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 12:45:19 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v8 2/4] worktree: improve message when creating a new worktree
Date:   Mon, 23 Apr 2018 20:38:46 +0100
Message-Id: <20180423193848.5159-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.74.g7afd1c25cc.dirty
In-Reply-To: <20180423193848.5159-1-t.gummerer@gmail.com>
References: <20180415202917.4360-1-t.gummerer@gmail.com>
 <20180423193848.5159-1-t.gummerer@gmail.com>
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

Currently this ends up in three different cases:

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

      Preparing worktree (resetting branch 'next'; was at caa68db14)
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
    branch prints the following output:

      Preparing worktree (checking out '<branch>')
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
index 4d96a21a45..d348101216 100644
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
+					  const char *new_branch_force)
+{
+	if (new_branch_force) {
+		struct commit *commit = lookup_commit_reference_by_name(new_branch_force);
+		if (!commit)
+			printf_ln(_("Preparing worktree (new branch '%s')"), new_branch_force);
+		else
+			printf_ln(_("Preparing worktree (resetting branch '%s'; was at %s)"),
+				  new_branch_force,
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
@@ -434,6 +466,8 @@ static int add(int ac, const char **av, const char *prefix)
 		}
 	}
 
+	print_preparing_worktree_line(opts.detach, branch, new_branch, new_branch_force);
+
 	if (new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		cp.git_cmd = 1;
-- 
2.16.1.74.g7afd1c25cc.dirty

