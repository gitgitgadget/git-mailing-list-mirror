From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] t3902 - skip test if file system doesn't support HT in names
Date: Sun, 12 Aug 2007 11:24:30 -0400
Message-ID: <11869322701036-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Mark Levedahl <mdl123@verizon.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 17:24:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKFJI-0003LS-C5
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 17:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936627AbXHLPYu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 12 Aug 2007 11:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936566AbXHLPYu
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 11:24:50 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:40634 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936468AbXHLPYr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 11:24:47 -0400
Received: from fal-l07294-lp.us.ray.com ([71.246.233.117])
 by vms048.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JMO009QD2SVO3Y5@vms048.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 12 Aug 2007 10:24:31 -0500 (CDT)
X-Mailer: git-send-email 1.5.3.rc4.79.g9714d-dirty
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55688>

Windows / cygwin don't support HT, LF, or TAB in file name so this test
is meaningless there.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 t/t3902-quoted.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index 63f950b..245fb3b 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -7,6 +7,12 @@ test_description=3D'quoted output'
=20
 . ./test-lib.sh
=20
+P1=3D'pathname	with HT'
+: >"$P1" 2>&1 && test -f "$P1" && rm -f "$P1" || {
+	echo >&2 'Filesystem does not support HT in names'
+	test_done
+}
+
 FN=3D'=E6=BF=B1=E9=87=8E'
 GN=3D'=E7=B4=94'
 HT=3D'	'
--=20
1.5.3.rc4.79.g9714d-dirty
