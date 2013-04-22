From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] git add: --ignore-removal is a better named --no-all
Date: Mon, 22 Apr 2013 13:43:54 -0700
Message-ID: <1366663435-13598-2-git-send-email-gitster@pobox.com>
References: <7vehe3qi5m.fsf@alter.siamese.dyndns.org>
 <1366663435-13598-1-git-send-email-gitster@pobox.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 22:44:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUNau-0002UE-Ra
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283Ab3DVUoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:44:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38718 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754929Ab3DVUn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 16:43:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72A2D1818D;
	Mon, 22 Apr 2013 20:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ofB1
	aY2D6utMUuWW/H0R7xuThQw=; b=lNQIVINrD9+XHV3xN4NhIMtWcQAQ3FiYUcwJ
	ler1i/a4ZgHBOxxoeJG8Dkax6vVIYg9Uu7WXBRYiAkv0isGa7rckX0RejjOQy9AK
	6L/iDJxzNih4PNCX2qvmJ+heAAd7u/3173g9jU+rVMqHOrquNdirH+Yvi+meNg04
	QVpLPW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	g3aNhNHedxdVVPD2p2HIlxZL9RXrU8LtPAXQ4sFdA/GqJ4SOnevY1SUSI8Tnsz9J
	AfQjX+fJR/JYqHmrIPWY7vfVTW6CfXN7P+ieXTiYXz7sZOS8csPSHQNW8o3frpxy
	B/2Uer+ZzBHtRefyOYwO4LZvldWBjVtiayFnm02gKlU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A7241818B;
	Mon, 22 Apr 2013 20:43:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD21A18186;
	Mon, 22 Apr 2013 20:43:58 +0000 (UTC)
X-Mailer: git-send-email 1.8.2.1-683-g39c426e
In-Reply-To: <1366663435-13598-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5B772C0C-AB8D-11E2-BC4E-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222088>

In the historical context of "git add --all ." that tells the
command to pay attention to "all kinds of changes" (implying
"without ignoring removals"), the option "--no-all" to countermand
it may have made some sense, but because we will be making "--all"
the default when a pathspec is given, it makes more sense to rename
the option to a more explicit "--ignore-removal".  The "-all" option
naturally becomes its negation: "--no-ignore-removal".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-add.txt | 10 ++++++----
 builtin/add.c             | 11 +++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 5c501a2..48754cb 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -9,9 +9,9 @@ SYNOPSIS
 --------
 [verse]
 'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
-	  [--edit | -e] [--[no-]all | [--update | -u]] [--intent-to-add | -N]
-	  [--refresh] [--ignore-errors] [--ignore-missing] [--]
-	  [<pathspec>...]
+	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]
+	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]
+	  [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -111,6 +111,7 @@ of Git, hence the form without <pathspec> should not be used.
 
 -A::
 --all::
+--no-ignore-removal::
 	Update the index not only where the working tree has a file
 	matching <pathspec> but also where the index already has an
 	entry.	This adds, modifies, and removes index entries to
@@ -122,6 +123,7 @@ and its subdirectories. This default will change in a future version
 of Git, hence the form without <pathspec> should not be used.
 
 --no-all::
+--ignore-removal::
 	Update the index by adding new files that are unknown to the
 	index and files modified in the working tree, but ignore
 	files that have been removed from the working tree.  This
@@ -130,7 +132,7 @@ of Git, hence the form without <pathspec> should not be used.
 This option is primarily to help the current users of Git, whose
 "git add <pathspec>..." ignores removed files.  In future versions
 of Git, "git add <pathspec>..." will be a synonym to "git add -A
-<pathspec>..." and "git add --no-all <pathspec>..." will behave like
+<pathspec>..." and "git add --ignore-removal <pathspec>..." will behave like
 today's "git add <pathspec>...", ignoring removed files.
 
 -N::
diff --git a/builtin/add.c b/builtin/add.c
index 54cd2d4..aefbc45 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -382,6 +382,13 @@ static int ignore_add_errors, intent_to_add, ignore_missing;
 static int addremove = ADDREMOVE_DEFAULT;
 static int addremove_explicit = -1; /* unspecified */
 
+static int ignore_removal_cb(const struct option *opt, const char *arg, int unset)
+{
+	/* if we are told to ignore, we are not adding removals */
+	*(int *)opt->value = !unset ? 0 : 1;
+	return 0;
+}
+
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__VERBOSE(&verbose, N_("be verbose")),
@@ -393,6 +400,10 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
 	OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the fact that the path will be added later")),
 	OPT_BOOL('A', "all", &addremove_explicit, N_("add changes from all tracked and untracked files")),
+	{ OPTION_CALLBACK, 0, "ignore-removal", &addremove_explicit,
+	  NULL /* takes no arguments */,
+	  N_("ignore paths removed in the working tree (same as --no-all)"),
+	  PARSE_OPT_NOARG, ignore_removal_cb },
 	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
-- 
1.8.2.1-683-g39c426e
