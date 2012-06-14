From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Thu, 14 Jun 2012 20:34:11 +0200
Message-ID: <1339698851-15428-1-git-send-email-zbyszek@in.waw.pl>
References: <7vipezaaig.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin@laptop.org>, git@vger.kernel.org,
	gitster@pobox.com,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 20:34:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfEsd-0003zF-1R
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 20:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756526Ab2FNSer convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jun 2012 14:34:47 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:38553 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756423Ab2FNSeq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 14:34:46 -0400
Received: from 69-mo7-2.acn.waw.pl ([85.222.93.69] helo=ameba.home.aster.pl)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SfEsT-0002TA-Ug; Thu, 14 Jun 2012 20:34:42 +0200
X-Mailer: git-send-email 1.7.11.rc3.129.ga90bc7a.dirty
In-Reply-To: <7vipezaaig.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200027>

=46rom: Martin Langhoff <martin@laptop.org>

git log -G'regex' is a very usable alternative to the classic
pickaxe. Minimal patch to make it usable from gitk.

[zj: reword message]
Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
Martin's off on holidays, so I'm sending v2 after rewording.

 gitk-git/gitk | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 22270ce..24eaead 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2232,7 +2232,8 @@ proc makewindow {} {
     set gm [makedroplist .tf.lbar.gdttype gdttype \
 		[mc "containing:"] \
 		[mc "touching paths:"] \
-		[mc "adding/removing string:"]]
+		[mc "adding/removing string:"] \
+		[mc "with changes matching regex:"]]
     trace add variable gdttype write gdttype_change
     pack .tf.lbar.gdttype -side left -fill y
=20
@@ -4595,6 +4596,8 @@ proc do_file_hl {serial} {
 	set gdtargs [concat -- $relative_paths]
     } elseif {$gdttype eq [mc "adding/removing string:"]} {
 	set gdtargs [list "-S$highlight_files"]
+    } elseif {$gdttype eq [mc "with changes matching regex:"]} {
+	set gdtargs [list "-G$highlight_files"]
     } else {
 	# must be "containing:", i.e. we're searching commit info
 	return
--=20
1.7.11.rc3.129.ga90bc7a.dirty
