From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: [PATCH v2 4/4] Documentation for format.coverletter and --cover-letter
Date: Mon,  4 May 2009 11:59:02 +0200
Message-ID: <1241431142-8444-5-git-send-email-ft@bewatermyfriend.org>
References: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Frank Terbeck <ft@bewatermyfriend.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 12:00:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0uyE-0007yi-I6
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 12:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878AbZEDJ7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 05:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753636AbZEDJ7e
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 05:59:34 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:57030 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbZEDJ7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 05:59:30 -0400
Received: from [212.117.84.176] (helo=fsst.voodoo.lan)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M0uxL-00081a-A5; Mon, 04 May 2009 11:59:27 +0200
Received: from hawk by fsst.voodoo.lan with local (Exim 4.69)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M0uwy-0002Cv-F2; Mon, 04 May 2009 11:59:04 +0200
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org>
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118224>

Signed-off-by: Frank Terbeck <ft@bewatermyfriend.org>
---
 Documentation/config.txt           |    9 +++++++++
 Documentation/git-format-patch.txt |   17 ++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5dcad94..2842cb1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -723,6 +723,15 @@ format.attach::
 	value as the boundary.  See the --attach option in
 	linkgit:git-format-patch[1].
 
+format.coverauto::
+	A boolean variable, if set linkgit:git-format-patch[1] will behave
+	as if it was called with its --cover-letter option, unless it was
+	run with its --stdout option.
+
+format.coverletter::
+	Configures how long a patch series needs to be for cover letters
+	to be created. The default is 2.
+
 format.numbered::
 	A boolean which can enable or disable sequence numbers in patch
 	subjects.  It defaults to "auto" which enables it only if there
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 6f1fc80..64f90a1 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -19,7 +19,7 @@ SYNOPSIS
 		   [--ignore-if-in-upstream]
 		   [--subject-prefix=Subject-Prefix]
 		   [--cc=<email>]
-		   [--cover-letter]
+		   [--cover-letter[=(always|never|<length>)]]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
 
@@ -107,7 +107,11 @@ include::diff-options.txt[]
 
 --stdout::
 	Print all commits to the standard output in mbox format,
-	instead of creating a file for each one.
+	instead of creating a file for each one. This also disables
+	the format.coverauto option if it was set. If you really want
+	cover letters to be included in --stdout output you have to
+	specify the --cover-letter option after the --stdout option
+	on the command line.
 
 --attach[=<boundary>]::
 	Create multipart/mixed attachment, the first part of
@@ -163,10 +167,17 @@ if that is not set.
 	to any configured headers, and may be used multiple times.
 	For example, --add-header="Organization: git-foo"
 
---cover-letter::
+--cover-letter[=(always|never|<length>)]::
 	In addition to the patches, generate a cover letter file
 	containing the shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
+	Per default, cover letters are created if a patch series is least two
+	patches long (the format.coverletter allows you to change that default
+	length). If a parameter is given it overwrites the default minimum
+	series length. If the parameter is 0 or 'never', a cover letter will
+	not be generated even if the format.coverletter option would trigger
+	normally it. If the parameter is 1 or 'always' a cover letter will
+	be generated even if the patch series is only one patch long.
 
 --suffix=.<sfx>::
 	Instead of using `.patch` as the suffix for generated
-- 
1.6.2.2.446.gfbdc0
