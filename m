Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2733C33CAA
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811B921835
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Q9/f2/3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgATReA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:34:00 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43044 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726897AbgATRd6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Jan 2020 12:33:58 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 76926607F5;
        Mon, 20 Jan 2020 17:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579541635;
        bh=laT3+WG/WkXGvGL5trvHjIVz6X43Hp5fjMGjAVFkUe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Q9/f2/3kF5g32EpbT4ee2EJn0JiQLIUI8fH855h9hcNi6lLGvGY1wV4HN35OwegPF
         iZh/RTLS398Qf6eChaVFhwrp8lV27CxRN6G32E3KZOWIBnUUov+VYoS0oOLUC8q5Dd
         Ua55Q5LyZc5AACxXt3QV+SZ7mte62e6yHF/cA80rfrkQ2bg64G2i7nnV4IzMVsS7NP
         KKBh2rPZaHAusV7iD3AqmVGGIa+/H6NpkiY1ZbQJ0yql5kZHhMjZcTxQnk2rp+Vb4E
         EreurkkupkNXQwMkmBauqdXLrWhY8JbCCDqbnyG4ZtaoCmpzdPTiuxwSREUKoJTpr9
         cyvcmJOPdb6T9TxK3qsQog6waKDGTRhJhFQZt5jvGIQyFUin4HZX1CwtFGWwxCZWu6
         jDYeyAimdw5aiWtzEtp6vixgFokwUJkPTK/hW3TRf5Q4VVGnWKExlYOPZrUt45IXDB
         ar5+XPkOi21q20e6yIr2ejhRjDS7E/w+gFjbePQv1I1U2HBAXwQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v4 1/5] doc: move author and committer information to git-commit(1)
Date:   Mon, 20 Jan 2020 17:33:39 +0000
Message-Id: <20200120173343.4102954-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309
In-Reply-To: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
References: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While at one time it made perfect sense to store information about
configuring author and committer information in the documentation for
git commit-tree, in modern Git that operation is seldom used.  Most
users will use git commit and expect to find comprehensive documentation
about its use in the manual page for that command.

Considering that there is significant confusion about how one is to use
the user.name and user.email variables, let's put as much documentation
as possible into an obvious place where users will be more likely to
find it.

In addition, expand the environment variables section to describe their
use more fully.  Even though we now describe all of the options there
and in the configuration settings documentation, preserve the existing
text in git-commit.txt so that people can easily reason about the
ordering of the various options they can use.  Explain the use of the
author.* and committer.* options as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/config/user.txt     |  2 +-
 Documentation/git-commit-tree.txt | 26 +++++---------------------
 Documentation/git-commit.txt      | 27 ++++++++++++++++++++++++---
 Documentation/git.txt             | 27 +++++++++++++++++++++++++--
 4 files changed, 55 insertions(+), 27 deletions(-)

diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index 0557cbbceb..a1f80e823c 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -13,7 +13,7 @@ committer.email::
 	Also, all of these can be overridden by the `GIT_AUTHOR_NAME`,
 	`GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME`,
 	`GIT_COMMITTER_EMAIL` and `EMAIL` environment variables.
-	See linkgit:git-commit-tree[1] for more information.
+	See linkgit:git-commit[1] for more information.
 
 user.useConfigOnly::
 	Instruct Git to avoid trying to guess defaults for `user.email`
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 4b90b9c12a..adc2e0d4b7 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -42,6 +42,10 @@ tend to just write the result to the file that is pointed at by
 `.git/HEAD`, so that we can always see what the last committed
 state was.
 
+A commit comment is read from stdin. If a changelog
+entry is not provided via "<" redirection, 'git commit-tree' will just wait
+for one to be entered and terminated with ^D.
+
 OPTIONS
 -------
 <tree>::
@@ -69,7 +73,6 @@ OPTIONS
 	Do not GPG-sign commit, to countermand a `--gpg-sign` option
 	given earlier on the command line.
 
-
 Commit Information
 ------------------
 
@@ -79,26 +82,6 @@ A commit encapsulates:
 - author name, email and date
 - committer name and email and the commit time.
 
-While parent object ids are provided on the command line, author and
-committer information is taken from the following environment variables,
-if set:
-
-	GIT_AUTHOR_NAME
-	GIT_AUTHOR_EMAIL
-	GIT_AUTHOR_DATE
-	GIT_COMMITTER_NAME
-	GIT_COMMITTER_EMAIL
-	GIT_COMMITTER_DATE
-
-(nb "<", ">" and "\n"s are stripped)
-
-In case (some of) these environment variables are not set, the information
-is taken from the configuration items user.name and user.email, or, if not
-present, the environment variable EMAIL, or, if that is not set,
-system user name and the hostname used for outgoing mail (taken
-from `/etc/mailname` and falling back to the fully qualified hostname when
-that file does not exist).
-
 A commit comment is read from stdin. If a changelog
 entry is not provided via "<" redirection, 'git commit-tree' will just wait
 for one to be entered and terminated with ^D.
@@ -117,6 +100,7 @@ FILES
 SEE ALSO
 --------
 linkgit:git-write-tree[1]
+linkgit:git-commit[1]
 
 GIT
 ---
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index ced5a9beab..30c30ccd80 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -367,9 +367,6 @@ changes to tracked files.
 +
 For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
-:git-commit: 1
-include::date-formats.txt[]
-
 EXAMPLES
 --------
 When recording your own work, the contents of modified files in
@@ -463,6 +460,30 @@ alter the order the changes are committed, because the merge
 should be recorded as a single commit.  In fact, the command
 refuses to run when given pathnames (but see `-i` option).
 
+COMMIT INFORMATION
+------------------
+
+Author and committer information is taken from the following environment
+variables, if set:
+
+	GIT_AUTHOR_NAME
+	GIT_AUTHOR_EMAIL
+	GIT_AUTHOR_DATE
+	GIT_COMMITTER_NAME
+	GIT_COMMITTER_EMAIL
+	GIT_COMMITTER_DATE
+
+(nb "<", ">" and "\n"s are stripped)
+
+In case (some of) these environment variables are not set, the information
+is taken from the configuration items `user.name` and `user.email`, or, if not
+present, the environment variable EMAIL, or, if that is not set,
+system user name and the hostname used for outgoing mail (taken
+from `/etc/mailname` and falling back to the fully qualified hostname when
+that file does not exist).
+
+:git-commit: 1
+include::date-formats.txt[]
 
 DISCUSSION
 ----------
diff --git a/Documentation/git.txt b/Documentation/git.txt
index b1597ac002..0093c647bf 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -482,13 +482,36 @@ double-quotes and respecting backslash escapes. E.g., the value
 Git Commits
 ~~~~~~~~~~~
 `GIT_AUTHOR_NAME`::
+	The human-readable name used in the author identity when creating commit or
+	tag objects, or when writing reflogs. Overrides the `user.name` and
+	`author.name` configuration settings.
+
 `GIT_AUTHOR_EMAIL`::
+	The email address used in the author identity when creating commit or
+	tag objects, or when writing reflogs. Overrides the `user.email` and
+	`author.email` configuration settings.
+
 `GIT_AUTHOR_DATE`::
+	The date used for the author identity when creating commit or tag objects, or
+	when writing reflogs. See linkgit:git-commit[1] for valid formats.
+
 `GIT_COMMITTER_NAME`::
+	The human-readable name used in the committer identity when creating commit or
+	tag objects, or when writing reflogs. Overrides the `user.name` and
+	`committer.name` configuration settings.
+
 `GIT_COMMITTER_EMAIL`::
+	The email address used in the author identity when creating commit or
+	tag objects, or when writing reflogs. Overrides the `user.email` and
+	`committer.email` configuration settings.
+
 `GIT_COMMITTER_DATE`::
-'EMAIL'::
-	see linkgit:git-commit-tree[1]
+	The date used for the committer identity when creating commit or tag objects, or
+	when writing reflogs. See linkgit:git-commit[1] for valid formats.
+
+`EMAIL`::
+	The email address used in the author and committer identities if no other
+	relevant environment variable or configuration setting has been set.
 
 Git Diffs
 ~~~~~~~~~
