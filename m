Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 620891F404
	for <e@80x24.org>; Sun, 15 Apr 2018 20:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeDOU3V (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 16:29:21 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38455 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbeDOU3R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 16:29:17 -0400
Received: by mail-wr0-f194.google.com with SMTP id h3so7901787wrh.5
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vP1SCLLZRoV9FDKFdD4FNQ1N/5F+sbg3yHEzeXP3N3g=;
        b=p+nAsGgFNHWlMJsubIRvDdEA5mA8Do2nYbHiwj6nmI1APJ79GYGQ+Rr6rtNQxYILpc
         YyYFKn/PUNyHz3Duihur824yb8hIJqXM4uxa3eluKgyWxfATZdK0rv6uuPKm/gue/iWb
         WBPL2Hf1qo5ItMLFSZbkm3kSZ2vicwlsSAkl2TSB+NlWwxBbmOyEy3cLSDknhhzbzhW4
         afthXr8D0Fpy89W1zZ00YgwZ0AwUvAh/NBCG8Rtr1S0D4kjEOyhogM/kLSxfV5ott8Z6
         GgfynWfwBJvPfJWJuEzkMX8mxTAHy1rfAXzcsijhIlVxDOIPaCy6Xvt8w71/vpRNpl0p
         smcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vP1SCLLZRoV9FDKFdD4FNQ1N/5F+sbg3yHEzeXP3N3g=;
        b=jwETpnErbzvY7t1YBZ2AT7nFH0Ed/ZrfCzKO5XNi/869vapkK0P5feduCEitb4/6h7
         ciddvxBWfxLGx8DKywIzn34j7uljfgk9kBGjA4YQG7NO52Nu/5HZoaSbjuY6HJmZX+hg
         Dokkr4y1dlIudKwoArINP1WzjN309c8AVRuYxKrkrL8BVV6CN+iv1TI7TrBeRIUYvJnL
         D9Ees0zbHQf4PJj+ATrfI3+X5EM6Kcgi2NraLRwWoakkVjNoi4Yg5LedfoCx46DtRQjq
         YW1SwR4sW0D1FATkCTMrvILqaap5JjD257RzuIa1bPvbi2ffrs0ZfXDt2P5iV7IYxrun
         gUEQ==
X-Gm-Message-State: ALQs6tDhYZacn1rZOdhJ9C48nrgEe8kcq3GpNpvDKojjzurAEG43d7Ik
        wYV87o7Mb18ge3Hbnl6kSfRiy0W/
X-Google-Smtp-Source: AIpwx49v3R0HGWITIIED6YWTPfcUyT4Z73yGD7iyLwEmPiOzxCt4BcFEhVTqS/WMzyQpHpwbifUvfA==
X-Received: by 10.223.208.206 with SMTP id z14mr3721332wrh.157.1523824156025;
        Sun, 15 Apr 2018 13:29:16 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id l73sm14684202wma.10.2018.04.15.13.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 13:29:15 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v7 2/4] worktree: improve message when creating a new worktree
Date:   Sun, 15 Apr 2018 21:29:15 +0100
Message-Id: <20180415202917.4360-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <20180415202917.4360-1-t.gummerer@gmail.com>
References: <20180331151804.30380-1-t.gummerer@gmail.com>
 <20180415202917.4360-1-t.gummerer@gmail.com>
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
modes which are perform some magic under the hood, which should be
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

      Preparing worktree (resetting branch 'next' (was at caa68db14))
      HEAD is now at 26da330922 <title>

    or:

      Preparing worktree (new branch '<branch>')
      HEAD is now at 26da330922 <title>

  - 'git worktree add --detach' or 'git worktree add <path> <branch>',
    both of which create a new worktree with a detached HEAD, for which
    we will print the following output:

      Preparing worktree (detached HEAD 26da330922)
      HEAD is now at 26da330922 <title>

Additionally currently the "Preparing ..." line is printed to stderr,
while the "HEAD is now at ..." line is printed to stdout by 'git reset
--hard', which is used internally by 'git worktree add'.  Fix this
inconsistency by printing the "Preparing ..." message to stdout as
well.  As "Preparing ..." is not an error, stdout also seems like the
more appropriate output stream.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/worktree.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4d96a21a45..a2667d74fb 100644
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
@@ -355,6 +353,31 @@ static int add_worktree(const char *path, const char *refname,
 	return ret;
 }
 
+static void print_preparing_worktree_line(const char *branch,
+					  const char *new_branch,
+					  const char *new_branch_force)
+{
+	if (new_branch_force) {
+		struct commit *commit = lookup_commit_reference_by_name(new_branch_force);
+		if (!commit)
+			printf_ln(_("Preparing worktree (new branch '%s')"), new_branch_force);
+		else
+			printf_ln(_("Preparing worktree (resetting branch '%s' (was at %s))"),
+				  new_branch_force,
+				  find_unique_abbrev(commit->object.oid.hash,
+						     DEFAULT_ABBREV));
+	} else if (new_branch) {
+		printf_ln(_("Preparing worktree (new branch '%s')"), new_branch);
+	} else {
+		struct commit *commit = lookup_commit_reference_by_name(branch);
+		if (!commit)
+			die(_("invalid reference: %s"), branch);
+		printf_ln(_("Preparing worktree (detached HEAD %s)"),
+			  find_unique_abbrev(commit->object.oid.hash,
+					     DEFAULT_ABBREV));
+	}
+}
+
 static int add(int ac, const char **av, const char *prefix)
 {
 	struct add_opts opts;
@@ -434,6 +457,8 @@ static int add(int ac, const char **av, const char *prefix)
 		}
 	}
 
+	print_preparing_worktree_line(branch, new_branch, new_branch_force);
+
 	if (new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		cp.git_cmd = 1;
-- 
2.17.0.252.gfe0a9eaf31

