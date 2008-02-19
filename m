From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] push: document the status output
Date: Tue, 19 Feb 2008 11:26:45 -0500
Message-ID: <20080219162645.GC30451@sigill.intra.peff.net>
References: <d9b18b1827a183e5b3b785a092605eab1ff4b6e7.1203438181.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jason Garber <jgarber@ionzoft.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:27:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVJh-0000v0-Fz
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbYBSQ0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 11:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752825AbYBSQ0u
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:26:50 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4260 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227AbYBSQ0t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 11:26:49 -0500
Received: (qmail 22690 invoked by uid 111); 19 Feb 2008 16:26:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 19 Feb 2008 11:26:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Feb 2008 11:26:45 -0500
Content-Disposition: inline
In-Reply-To: <d9b18b1827a183e5b3b785a092605eab1ff4b6e7.1203438181.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74428>

The output was meant to be a balance of self-explanatory and
terse. In case we have erred too far on the terse side, it
doesn't hurt to explain in more detail what each line means.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-push.txt |   49 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 650ee91..3128170 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -108,6 +108,55 @@ the remote repository.
 
 include::urls-remotes.txt[]
 
+OUTPUT
+------
+
+The output of "git push" depends on the transport method used; this
+section describes the output when pushing over the git protocol (either
+locally or via ssh).
+
+The status of the push is output in tabular form, with each line
+representing the status of a single ref. Each line is of the form:
+
+-------------------------------
+ <flag> <summary> <from> -> <to> (<reason>)
+-------------------------------
+
+flag::
+	A single character indicating the status of the ref. This is
+	blank for a successfully pushed ref, `!` for a ref that was
+	rejected or failed to push, and '=' for a ref that was up to
+	date and did not need pushing (note that the status of up to
+	date refs is shown only when `git push` is running verbosely).
+
+summary::
+	For a successfully pushed ref, the summary shows the old and new
+	values of the ref in a form suitable for using as an argument to
+	`git log` (this is `<old>..<new>` in most cases, and
+	`<old>...<new>` for forced non-fast forward updates). For a
+	failed update, more details are given for the failure.
+	The string `rejected` indicates that git did not try to send the
+	ref at all (typically because it is not a fast forward). The
+	string `remote rejected` indicates that the remote end refused
+	the update; this rejection is typically caused by a hook on the
+	remote side. The string `remote failure` indicates that the
+	remote end did not report the successful update of the ref
+	(perhaps because of a temporary error on the remote side, a
+	break in the network connection, or other transient error).
+
+from::
+	The name of the local ref being pushed, minus its
+	`refs/<type>/` prefix. In the case of deletion, the
+	name of the local ref is omitted.
+
+to::
+	The name of the remote ref being updated, minus its
+	`refs/<type>/` prefix.
+
+reason::
+	A human-readable explanation. In the case of successfully pushed
+	refs, no explanation is needed. For a failed ref, the reason for
+	failure is described.
 
 Examples
 --------
-- 
1.5.4.1.143.ge7e51-dirty
