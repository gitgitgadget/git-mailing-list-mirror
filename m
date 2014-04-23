From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v4 5/6] patch-id: document new behaviour
Date: Wed, 23 Apr 2014 15:15:02 +0300
Message-ID: <1398255277-26303-5-git-send-email-mst@redhat.com>
References: <1398255277-26303-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 14:14:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcw4S-0007a4-Dj
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 14:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbaDWMOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 08:14:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57120 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753261AbaDWMOS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 08:14:18 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3NCEHgx003092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 23 Apr 2014 08:14:18 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3NCEGow018247
	for <git@vger.kernel.org>; Wed, 23 Apr 2014 08:14:17 -0400
Content-Disposition: inline
In-Reply-To: <1398255277-26303-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246824>

Clarify that patch ID can now be a sum of hashes, not a hash.
Document how command line and config options affect the
behaviour.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/git-patch-id.txt | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 312c3b1..61d4a67 100644
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
 
@@ -27,6 +27,21 @@ This can be used to make a mapping from patch ID to commit ID.
 
 OPTIONS
 -------
+
+--stable::
+	Use a symmetrical sum of hashes as the patch ID.
+	With this option, reordering file diffs that make up a patch or
+	splitting a diff up to multiple diffs that touch the same path
+	does not affect the ID.
+	This is the default if patchid.stable is set to true, or if patchid.stable
+	is not set and diff.orderfile is set to some value.
+
+--unstable::
+	Use a non-symmetrical sum of hashes, such that reordering
+	or splitting the patch does affect the ID.
+	This is the default if patchid.stable is set to false, or if neither patchid.stable
+	nor diff.orderfile are set.
+
 <patch>::
 	The diff to create the ID of.
 
-- 
MST
