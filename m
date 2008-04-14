From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2 09/13] Select all lines with fake-editor
Date: Mon, 14 Apr 2008 02:21:05 +0200
Message-ID: <1208132469-26471-9-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-5-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-6-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-7-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-8-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 02:53:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlCx1-0004J2-BM
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 02:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324AbYDNAw0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 20:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754314AbYDNAwX
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 20:52:23 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1645 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753709AbYDNAv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 20:51:56 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 588054880A4; Mon, 14 Apr 2008 02:51:55 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRb-0006IH-MA; Mon, 14 Apr 2008 02:21:12 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRa-0006uA-42; Mon, 14 Apr 2008 02:21:10 +0200
X-Mailer: git-send-email 1.5.5
In-Reply-To: <1208132469-26471-8-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79442>

The old fake-editor selects only lines they start with pick, if you giv=
e
the number of a line. With the new commands mark, merge and reset it wa=
s
not possible to select such lines for the new TODO list. The new
fake-editor selects all kinds of lines, but replaces only the command
=E2=80=9Cpick=E2=80=9D with a different action.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 t/t3404-rebase-interactive.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index ceb9d74..0a8d065 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -92,9 +92,8 @@ for line in $FAKE_LINES; do
 		echo "merge ${line#merge}" | tr / ' '
 		echo "merge ${line#merge}" | tr / ' ' >> "$1";;
 	*)
-		echo sed -n "${line}s/^pick/$action/p"
-		sed -n "${line}p" < "$1".tmp
-		sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
+		sed -n "${line}{s/^pick/$action/; p;}" < "$1".tmp
+		sed -n "${line}{s/^pick/$action/; p;}" < "$1".tmp >> "$1"
 		action=3Dpick;;
 	esac
 done
--=20
1.5.5
