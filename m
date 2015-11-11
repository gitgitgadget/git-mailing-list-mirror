From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH 4/5] ff-refs: Add documentation
Date: Tue, 10 Nov 2015 21:11:24 -0500
Message-ID: <1447207885-10911-5-git-send-email-rappazzo@gmail.com>
References: <1447207885-10911-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net,
	dturner@twopensource.com, pclouds@gmail.com,
	sunshine@sunshineco.com, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 11 03:13:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwKum-0007SP-FL
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 03:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbbKKCN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 21:13:26 -0500
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34783 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbbKKCNY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 21:13:24 -0500
Received: by ykfs79 with SMTP id s79so28235952ykf.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 18:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nIkIsBFcug4RgPtHo+gKxJAp6npA8wt31vFHqih7wKU=;
        b=wpbJzkdk7UZd27ai7rDdW4K84L2RHv7S/HXoG94tkoOQC35ufyRoAX6LEfuEoAgGo3
         lw62ZcW423dE2qOJQqAUDmzCxNJmml8w8gDwFeBghWu3KPeAcZdBjhdkkAh6Ndb3PCxo
         OvcxHIB8JJmPOz9pN18em2RSg4usdbGFP97nubK0ACpwtX2nA6BjHaJU/QKuCEsn0DfJ
         hHFBuiXB9RBEzrikv5a9RGVyHDJLYUNphH//H/K5/0Tj4qpYwp3deZf0dhlLZYvvi2RO
         92eVL2cOCGP2oQ5GzusfbEf5XIyHhfgWAvDivxOPXY0xTtp+Ra+g/yLC4ANeQrRmtUQm
         wk3Q==
X-Received: by 10.129.72.198 with SMTP id v189mr6398478ywa.220.1447208003836;
        Tue, 10 Nov 2015 18:13:23 -0800 (PST)
Received: from localhost.localdomain (ool-18e4990e.dyn.optonline.net. [24.228.153.14])
        by smtp.gmail.com with ESMTPSA id m128sm7948819ywm.34.2015.11.10.18.13.22
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Nov 2015 18:13:23 -0800 (PST)
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1447207885-10911-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281147>

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 Documentation/git-ff-refs.txt | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/git-ff-refs.txt

diff --git a/Documentation/git-ff-refs.txt b/Documentation/git-ff-refs.txt
new file mode 100644
index 0000000..569d1d4
--- /dev/null
+++ b/Documentation/git-ff-refs.txt
@@ -0,0 +1,55 @@
+git-ff-refs(1)
+============
+
+NAME
+----
+git-ff-refs - Fast-forward each local branch to its upstream (if possible)
+
+
+SYNOPSIS
+--------
+[verse]
+'git ff-refs' [<options>]
+
+
+DESCRIPTION
+-----------
+Update local branches to their tracked upstream if and only if the local branch
+can be fast-forwarded to the upstream ref.  Local branches which have diverged
+from the upstream will not be updated.
+
+Each local branch tracking an upstream will be reported with a status based on
+whether or not it it was updated.  The statuses are:
+
+	UP-TO-DATE - The local branch is the same or equal to the upstream
+	UPDATED - The branch was fast forwarded
+	WOULD-UPDATE - With `--dry-run`, the branch is fast forwardable
+	REMOTE-MISSING - The branch is tracking an upstream that is not present
+	NON-FAST-FORWARD - The branch has diverged from the upstream
+	SKIPPED - With `--skip-worktrees` the branch is fast forwardable but checked
+		out in a local worktree
+	WOULD-SKIP - With `--skip-worktrees` and `--dry-run`, the branch is fast
+		forwardable but checked out in a local worktree
+	UNABLE-TO-UPDATE - An error occurred while trying to update the branch
+
+OPTIONS
+-------
+--dry-run::
+	Report the updatable state of each branch without acutally updating anything.
+	In a dry run, fast-forwardable branches are marked 'WOULD-UPDATE' instead of
+	'UPDATED'.
+
+--skip-worktrees::
+	Does not update branches which are checked out in any worktree.  Branches
+	which are fast-forwardable that are checked out in any worktree are marked
+	'SKIPPED'.  If `--dry-run` is also set, those branches are marked 'WOULD-SKIP'.
+
+
+SEE ALSO
+--------
+linkgit:git-update-ref[1]
+linkgit:git-merge[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
2.6.2
