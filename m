From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/9] fetch doc: move FETCH_HEAD material lower and add an example
Date: Tue,  3 Jun 2014 15:16:25 -0700
Message-ID: <1401833792-2486-3-git-send-email-gitster@pobox.com>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com>
Cc: Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 00:16:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrx0p-00058l-LN
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 00:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965440AbaFCWQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 18:16:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63668 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965067AbaFCWQr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 18:16:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 379CD1DD61;
	Tue,  3 Jun 2014 18:16:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Lm/k
	LW5WhiYc+4juq4ZTBB4s0Jc=; b=jnR1mh8vE3DHFlxX+awsTUfDfwh4Bfg8JhXl
	IivxjIf7w+RRn6hBVsS119qjIMR09qhaXdJqZFZn6WejQLCqX2TjBQm0ARLmsOF8
	CYpFuhSRXP1/hpmGlXHW/E/x8nJ/kAWcanS61ZnHSquFWgq/bL7Vfik+Pp04Y4cc
	HmZmU+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Im9CyQHBmfCRrZq69FFhB+nQXDdgWE9BKOQVAVNYAvo22kvWgkYZdrtMFb7IH7z9
	tV9/UpVeOqLPyX1A7qc/qeq0rUQm9qQ2x4fZEiwIZ4j6Uv+a3jBPssACL+oHnKXa
	5B9H1lYmC2VXl8Tnw5PxOtMDb6SJJYE12m20FPc9FOk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F5621DD60;
	Tue,  3 Jun 2014 18:16:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 74CB51DD5B;
	Tue,  3 Jun 2014 18:16:43 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-518-g8437b4f
In-Reply-To: <1401833792-2486-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BE6A4CDE-EB6C-11E3-B095-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250697>

From: Marc Branchaud <marcnarc@xiplink.com>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-fetch.txt | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 78fe948..06106b9 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -18,13 +18,9 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Fetch branches and/or tags (collectively, "refs") from one or more
-other repositories, along with the objects necessary to complete
-their histories.
-
-The names of refs that are fetched, together with the object names
-they point at, are written to `.git/FETCH_HEAD`.  This information
-can be used to learn what was fetched.  In addition, the remote-tracking
-branches are updated (see description on <refspec> below for details).
+other repositories, along with the objects necessary to complete their
+histories.  Remote-tracking branches are updated (see the description
+of <refspec> below for ways to control this behavior).
 
 By default, any tag that points into the histories being fetched is
 also fetched; the effect is to fetch tags that
@@ -34,7 +30,7 @@ configuring remote.<name>.tagopt.  By using a refspec that fetches tags
 explicitly, you can fetch tags that do not point into branches you
 are interested in as well.
 
-'git fetch' can fetch from either a single named repository,
+'git fetch' can fetch from either a single named repository or URL,
 or from several repositories at once if <group> is given and
 there is a remotes.<group> entry in the configuration file.
 (See linkgit:git-config[1]).
@@ -42,6 +38,10 @@ there is a remotes.<group> entry in the configuration file.
 When no remote is specified, by default the `origin` remote will be used,
 unless there's an upstream branch configured for the current branch.
 
+The names of refs that are fetched, together with the object names
+they point at, are written to `.git/FETCH_HEAD`.  This information
+may be used by scripts or other git commands, such as linkgit:git-pull[1].
+
 OPTIONS
 -------
 include::fetch-options.txt[]
@@ -78,6 +78,19 @@ the local repository by fetching from the branches (respectively)
 The `pu` branch will be updated even if it is does not fast-forward,
 because it is prefixed with a plus sign; `tmp` will not be.
 
+* Peek at a remote's branch, without configuring the remote in your local
+repository:
++
+------------------------------------------------
+$ git fetch git://git.kernel.org/pub/scm/git/git.git maint
+$ git log FETCH_HEAD
+------------------------------------------------
++
+The first command fetches the `maint` branch from the repository at
+`git://git.kernel.org/pub/scm/git/git.git` and the second command uses
+`FETCH_HEAD` to examine the branch with linkgit:git-log[1].  The fetched
+objects will eventually be removed by git's built-in housekeeping (see
+linkgit:git-gc[1]).
 
 BUGS
 ----
-- 
2.0.0-511-g1433423
