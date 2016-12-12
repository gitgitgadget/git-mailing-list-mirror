Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D4D11FF76
	for <e@80x24.org>; Mon, 12 Dec 2016 08:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbcLLIeY (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 03:34:24 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33349 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752590AbcLLIeX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 03:34:23 -0500
Received: by mail-pg0-f65.google.com with SMTP id 3so317578pgd.0
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 00:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S+4iGAzaHV1gO5xF2pzFm11hHzeQ5QF1E4i5zSK9mAQ=;
        b=ATHhTlCfLJjUHSVdGV6dILrStyr6as+3xToJ9dLwAk7ENA3Rt9qYl1xQBfmt9wHJxX
         mSKLfHjpHxnWgYwLEPqlKHGB7BbvA8db3d+/cJJW3rR8g4qaZUYqzOvBwicFEac43gNW
         Zc/Cb+jlhvBo4USpId/KZxRJhZwM9F8oGiSlP2nWDhdqLPiRrcQqIT/S79lGdK1Zy+Sc
         W4DtvDFlW8I+X5XvD8ynBGU0UoAFFc/zGNeGcOfCNdzA+5uXuR0HGisB5cKPobcBrgBJ
         M7X9VzyyXdEDfo2x2uRDIXs/Im2KOYsqYgQZ8iEhWRlCPehOkkZk96rm8P61e8rQopVd
         dI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S+4iGAzaHV1gO5xF2pzFm11hHzeQ5QF1E4i5zSK9mAQ=;
        b=lAQSMVPlBbXHu0LqMU93hjQT3ZDTnq9MXJHlvxGkwTEnIG1f40HY5UwHGhuEwUUlXL
         Jno3zmnRVZURQ+6bj98k2WIF9RmQjmbAbjHf8sNJc3GHVDBWqYNg2ANvE96SLs6ilY+l
         rau/1Qw5twl8A951TMuAcHKq+QMbt8f56goH+xQrljhqQt+FCqiS0yloJE6rzc73fhbB
         UPgbfl0hfxD1ZVPBeWLICn2PmXBmtq46yLxiX8/x0N4T7NXwwzZAhMA6Elaltba/Kn3f
         lpxx1oINqC8Hs69WSZOsWwC9ZhhJ2INYKaaAR/0fFkQIFg+MAZKGxWsZKjCuVC/z4KmC
         9Z/g==
X-Gm-Message-State: AKaTC00lAxMjSViQZLHnt+lXFyAC8TPjAVT2cx+SY7j+0Cbl8CTOlfq2REQgtFoyqmdH2Q==
X-Received: by 10.84.134.3 with SMTP id 3mr181786610plg.90.1481531662602;
        Mon, 12 Dec 2016 00:34:22 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:7c96:d02a:8bca:ca4])
        by smtp.gmail.com with ESMTPSA id c15sm74509940pfd.36.2016.12.12.00.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 00:34:22 -0800 (PST)
From:   Chris Packham <judge.packham@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jacob.keller@gmail.com, gitster@pobox.com,
        Chris Packham <judge.packham@gmail.com>
Subject: [RFC/PATCH] merge: Add '--continue' option as a synonym for 'git commit'
Date:   Mon, 12 Dec 2016 21:34:13 +1300
Message-Id: <20161212083413.7334-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAFOYHZAsU_gNb=_K=iMFKFdt60SJ4Wm=Ag5=XMXuQgxNxCqWLA@mail.gmail.com>
References: <CAFOYHZAsU_gNb=_K=iMFKFdt60SJ4Wm=Ag5=XMXuQgxNxCqWLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'git merge' the --continue option which allows 'continuing' a
merge by completing it. The traditional way of completing a merge after
resolving conflicts is to use 'git commit'. Now with commands like 'git
rebase' and 'git cherry-pick' having a '--continue' option adding such
an option to 'git merge' presents a consistent UI.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
So here is a quick patch that adds the --continue option. I need to add
some tests (suggestions for where to start are welcome).

 Documentation/git-merge.txt | 13 ++++++++++++-
 builtin/merge.c             | 17 ++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index b758d5556..765b0f26e 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
 'git merge' <msg> HEAD <commit>...
 'git merge' --abort
+'git merge' --continue
 
 DESCRIPTION
 -----------
@@ -61,6 +62,9 @@ reconstruct the original (pre-merge) changes. Therefore:
 discouraged: while possible, it may leave you in a state that is hard to
 back out of in the case of a conflict.
 
+The fourth syntax ("`git merge --continue`") can only be run after the
+merge has resulted in conflicts. 'git merge --continue' will take the
+currently staged changes and complete the merge.
 
 OPTIONS
 -------
@@ -99,6 +103,12 @@ commit or stash your changes before running 'git merge'.
 'git merge --abort' is equivalent to 'git reset --merge' when
 `MERGE_HEAD` is present.
 
+--continue::
+	Take the currently staged changes and complete the merge.
++
+'git merge --continue' is equivalent to 'git commit' when
+`MERGE_HEAD` is present.
+
 <commit>...::
 	Commits, usually other branch heads, to merge into our branch.
 	Specifying more than one commit will create a merge with
@@ -277,7 +287,8 @@ After seeing a conflict, you can do two things:
 
  * Resolve the conflicts.  Git will mark the conflicts in
    the working tree.  Edit the files into shape and
-   'git add' them to the index.  Use 'git commit' to seal the deal.
+   'git add' them to the index.  Use 'git merge --continue' to seal the
+   deal.
 
 You can work through the conflict with a number of tools:
 
diff --git a/builtin/merge.c b/builtin/merge.c
index b65eeaa87..1ce18cbbe 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -65,6 +65,7 @@ static int option_renormalize;
 static int verbosity;
 static int allow_rerere_auto;
 static int abort_current_merge;
+static int continue_current_merge;
 static int allow_unrelated_histories;
 static int show_progress = -1;
 static int default_to_upstream = 1;
@@ -223,6 +224,8 @@ static struct option builtin_merge_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "abort", &abort_current_merge,
 		N_("abort the current in-progress merge")),
+	OPT_BOOL(0, "continue", &continue_current_merge,
+		N_("continue the current in-progress merge")),
 	OPT_BOOL(0, "allow-unrelated-histories", &allow_unrelated_histories,
 		 N_("allow merging unrelated histories")),
 	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting"), 1),
@@ -739,7 +742,7 @@ static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
 	if (err_msg)
 		error("%s", err_msg);
 	fprintf(stderr,
-		_("Not committing merge; use 'git commit' to complete the merge.\n"));
+		_("Not committing merge; use 'git merge --continue' to complete the merge.\n"));
 	write_merge_state(remoteheads);
 	exit(1);
 }
@@ -1166,6 +1169,18 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		goto done;
 	}
 
+	if (continue_current_merge) {
+		int nargc = 1;
+		const char *nargv[] = {"commit", NULL};
+
+		if (!file_exists(git_path_merge_head()))
+			die(_("There is no merge in progress (MERGE_HEAD missing)."));
+
+		/* Invoke 'git commit' */
+		ret = cmd_commit(nargc, nargv, prefix);
+		goto done;
+	}
+
 	if (read_cache_unmerged())
 		die_resolve_conflict("merge");
 
-- 
2.11.0

