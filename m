From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [RFC] gitk using diff-tree -M for merges
Date: Fri, 11 May 2007 10:45:56 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070511084556.GB5485@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 10:46:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmQlL-0006oR-11
	for gcvg-git@gmane.org; Fri, 11 May 2007 10:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbXEKIqD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 11 May 2007 04:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbXEKIqD
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 04:46:03 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:34315 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751555AbXEKIqA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 May 2007 04:46:00 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HmQlD-0000kG-CN
	for git@vger.kernel.org; Fri, 11 May 2007 10:45:59 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l4B8ju1U007296
	for <git@vger.kernel.org>; Fri, 11 May 2007 10:45:56 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l4B8juj4007295
	for git@vger.kernel.org; Fri, 11 May 2007 10:45:56 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46945>

Hello,

looking at the diff that commit 070739fd351702ea9bb4f65595728ae25a48807=
5
introduced with gitk from 1.5.2-rc3 [1], I'd prefer gitk using the
option -M for diff-tree to detect that in 3f28f63f git-gui.sh exists,
too.  Currently the diff is a bit longer that the whole file, with -M i=
t
would be empty.

Probably using -M hurts performance, so it should better be a config
option?

Below is a patch that hardcodes -M, I didn't check if there are more
places where it should be added.

What do you think?

Best regards
Uwe

[1] the following is a nice view:

	gitk 070739fd351702ea9bb4f65595728ae25a488075 ^53a58245863eff3d70aaa3a=
c75d7d57e843fc91d^ ^e701ccc3883959b4ba5fada7a903e8e9eaddcba7

diff --git a/gitk b/gitk
index a57e84c..bcc4637 100755
--- a/gitk
+++ b/gitk
@@ -4240,7 +4240,7 @@ proc mergediff {id l} {
     set diffids $id
     # this doesn't seem to actually affect anything...
     set env(GIT_DIFF_OPTS) $diffopts
-    set cmd [concat | git diff-tree --no-commit-id --cc $id]
+    set cmd [concat | git diff-tree -M --no-commit-id --cc $id]
     if {[catch {set mdf [open $cmd r]} err]} {
 	error_popup "Error getting merge diffs: $err"
 	return

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+electron+mass%3D
