From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v4 4/4] Hack fix for 'submodule update does not fetch already
 present commits'
Date: Mon, 26 Nov 2012 16:00:19 -0500
Message-ID: <30459164cc221165a20cd4a54daac76ddb101269.1353962698.git.wking@tremily.us>
References: <20121123175402.GH2806@odin.tremily.us>
 <cover.1353962698.git.wking@tremily.us>
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:02:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td5oV-00058l-O4
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 22:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756513Ab2KZVBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 16:01:35 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:35837 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab2KZVB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 16:01:28 -0500
Received: from odin.tremily.us ([unknown] [72.68.108.240])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME4004N251Q4I70@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 26 Nov 2012 15:01:12 -0600 (CST)
Received: from localhost (tyr.tremily.us [192.168.0.5])
	by odin.tremily.us (Postfix) with ESMTP id 6B9056DEFCF; Mon,
 26 Nov 2012 16:01:02 -0500 (EST)
X-Mailer: git-send-email 1.8.0.3.g95edff1.dirty
In-reply-to: <cover.1353962698.git.wking@tremily.us>
In-reply-to: <cover.1353962698.git.wking@tremily.us>
References: <cover.1353962698.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210493>

From: "W. Trevor King" <wking@tremily.us>

---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 28eb4b1..f4a681c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -640,7 +640,7 @@ Maybe you want to use 'update --init'?")"
 				subforce="-f"
 			fi
 
-			if test -z "$nofetch"
+			if test -z "$nofetch" -a "$subsha1" != "$sha1"
 			then
 				# Run fetch only if $sha1 isn't present or it
 				# is not reachable from a ref.
-- 
1.8.0.3.g95edff1.dirty
