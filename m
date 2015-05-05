From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: remove credential helpers from porcelain commands
Date: Tue,  5 May 2015 15:19:32 +0200
Message-ID: <1430831972-6788-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 05 15:20:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypcm3-0005vE-6W
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 15:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423464AbbEENUb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 May 2015 09:20:31 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:38459 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423470AbbEENU1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 May 2015 09:20:27 -0400
Received: from x590c583f.dyn.telefonica.de ([89.12.88.63] helo=localhost)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1Ypclm-0002xg-KU; Tue, 05 May 2015 15:20:24 +0200
X-Mailer: git-send-email 1.9.5.msysgit.0
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1430832024.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268393>

Don't offer the "main" 'git credential' command or any of the credentia=
l
helpers from contrib/credential/ when completing git commands.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

I was tempted to simply filter out 'credential-*', so we don't have to
update this list when new credential helpers arrive.  However, the
'git-credential-*' "namespace" is not explicitly reserved for credentia=
l
helpers, users have to set the 'credential.helper' config variable to t=
ell
explicitly that 'git-credential-foo' should be used as credential helpe=
r,
and who knows, someone might have his own 'git-credential-bar' command =
that
does something completely unrelated to git's credential system, so in t=
he
end decided against it.  And credential helpers don't pop up too freque=
ntly
anyway.

However, if you think filtering out 'credential-*' is the way to go, I'=
m
happy to reroll.

 contrib/completion/git-completion.bash | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index e0eb6ae..527bb00 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -665,8 +665,13 @@ __git_list_porcelain_commands ()
 		checkout-index)   : plumbing;;
 		commit-tree)      : plumbing;;
 		count-objects)    : infrequent;;
+		credential        : credentials;;
 		credential-cache) : credentials helper;;
+		credential-gnome-keyring) : credentials helpe;;
+		credential-netrc) : credentials helper;;
+		credential-osxkeychain) : credentials helper;;
 		credential-store) : credentials helper;;
+		credential-wincred) : credentials helper;;
 		cvsexportcommit)  : export;;
 		cvsimport)        : import;;
 		cvsserver)        : daemon;;
--=20
1.9.5.msysgit.0
