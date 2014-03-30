From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 2/3] patch-id: document new behaviour
Date: Sun, 30 Mar 2014 21:09:26 +0300
Message-ID: <1396202583-2572-2-git-send-email-mst@redhat.com>
References: <1396202583-2572-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, jrnieder@gmail.com, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 20:09:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUKAf-0006eV-Oy
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 20:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbaC3SJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2014 14:09:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4204 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbaC3SJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 14:09:09 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2UI8xxn004431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 30 Mar 2014 14:08:59 -0400
Received: from redhat.com (vpn1-7-185.ams2.redhat.com [10.36.7.185])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s2UI8vOM014487;
	Sun, 30 Mar 2014 14:08:58 -0400
Content-Disposition: inline
In-Reply-To: <1396202583-2572-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245484>

Clarify that patch ID is now a sum of hashes, not a hash.
Document --stable and --unstable flags.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes from v2:
	explicitly list the kinds of changes against which patch ID is stable

 Documentation/git-patch-id.txt | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 312c3b1..30923e0 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -8,14 +8,14 @@ git-patch-id - Compute unique ID for a patch
 SYNOPSIS
 --------
 [verse]
-'git patch-id' < <patch>
+'git patch-id' [--stable | --unstable] < <patch>
 
 DESCRIPTION
 -----------
-A "patch ID" is nothing but a SHA-1 of the diff associated with a patch, with
-whitespace and line numbers ignored.  As such, it's "reasonably stable", but at
-the same time also reasonably unique, i.e., two patches that have the same "patch
-ID" are almost guaranteed to be the same thing.
+A "patch ID" is nothing but a sum of SHA-1 of the diff hunks associated with a
+patch, with whitespace and line numbers ignored.  As such, it's "reasonably
+stable", but at the same time also reasonably unique, i.e., two patches that
+have the same "patch ID" are almost guaranteed to be the same thing.
 
 IOW, you can use this thing to look for likely duplicate commits.
 
@@ -27,6 +27,19 @@ This can be used to make a mapping from patch ID to commit ID.
 
 OPTIONS
 -------
+
+--stable::
+	Use a symmetrical sum of hashes as the patch ID.
+	With this option, reordering file diffs that make up a patch or
+	splitting a diff up to multiple diffs that touch the same path
+	does not affect the ID.
+	This is the default.
+
+--unstable::
+	Use a non-symmetrical sum of hashes, such that reordering
+	or splitting the patch does affect the ID.
+	This was the default value for git 1.9 and older.
+
 <patch>::
 	The diff to create the ID of.
 
-- 
MST
