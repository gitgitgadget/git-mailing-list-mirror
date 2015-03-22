From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: use __gitcomp_nl() for completing refs
Date: Sun, 22 Mar 2015 13:03:11 +0100
Message-ID: <1427025791-51676-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 13:03:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZebP-0005fh-2N
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 13:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbbCVMDa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2015 08:03:30 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:49315 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751632AbbCVMD3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2015 08:03:29 -0400
Received: from x590d7fa5.dyn.telefonica.de ([89.13.127.165] helo=localhost)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1YZebF-0000rB-Aq; Sun, 22 Mar 2015 13:03:26 +0100
X-Mailer: git-send-email 1.9.5.msysgit.0
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1427025806.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266069>

We do that almost everywhere, because it's faster for large number of
refs, see a31e62629 (completion: optimize refs completion, 2011-10-15).
These were the last two places where we still used __gitcomp() for
completing refs.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 731c289..be85438 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -977,7 +977,7 @@ _git_branch ()
=20
 	case "$cur" in
 	--set-upstream-to=3D*)
-		__gitcomp "$(__git_refs)" "" "${cur##--set-upstream-to=3D}"
+		__gitcomp_nl "$(__git_refs)" "" "${cur##--set-upstream-to=3D}"
 		;;
 	--*)
 		__gitcomp "
@@ -1045,7 +1045,7 @@ _git_checkout ()
=20
 _git_cherry ()
 {
-	__gitcomp "$(__git_refs)"
+	__gitcomp_nl "$(__git_refs)"
 }
=20
 _git_cherry_pick ()
--=20
1.9.5.msysgit.0
