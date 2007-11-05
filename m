From: =?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
Subject: [PATCH] git-commit.sh: Fix usage checks regarding paths given when they do not make sense
Date: Mon,  5 Nov 2007 20:36:33 +0100
Message-ID: <1194291393-1067-1-git-send-email-B.Steinbrink@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: paolo.bonzini@lu.unisi.ch, krh@redhat.com, git@vger.kernel.org,
	=?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 05 20:36:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip7kh-0000Hk-C9
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 20:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbXKETgh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 14:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbXKETgh
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 14:36:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:52718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751037AbXKETgg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 14:36:36 -0500
Received: (qmail invoked by alias); 05 Nov 2007 19:36:34 -0000
Received: from i577BBDA2.versanet.de (EHLO localhost) [87.123.189.162]
  by mail.gmx.net (mp049) with SMTP; 05 Nov 2007 20:36:34 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18Xqas5CVkX4YSHhb0TEpyhybscCGD7Q/rnl4LYSP
	Uy3uyzzzCM9fdF
X-Mailer: git-send-email 1.5.3.5.561.g140d-dirty
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63541>

The checks that looked for paths given to git-commit in addition to
--all or --interactive expected only 3 values, while the case statement
actually provides 4, so the check was never triggered.

The bug was introduced in 6cbf07efc5702351897dee4742525c9b9f7828ac when
the case statement was extended to handle --interactive.

Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
---
 git-commit.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index fcb8443..d4471ff 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -282,9 +282,9 @@ unset only
 case "$all,$interactive,$also,$#" in
 *t,*t,*)
 	die "Cannot use -a, --interactive or -i at the same time." ;;
-t,,[1-9]*)
+t,,,[1-9]*)
 	die "Paths with -a does not make sense." ;;
-,t,[1-9]*)
+,t,,[1-9]*)
 	die "Paths with --interactive does not make sense." ;;
 ,,t,0)
 	die "No paths with -i does not make sense." ;;
--=20
1.5.3.5.561.g140d-dirty
