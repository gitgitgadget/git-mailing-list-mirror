From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] am: invoke perl's strftime in C locale
Date: Tue, 15 Jan 2013 00:59:33 +0400
Message-ID: <20130114205933.GA25947@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 22:08:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TurGC-0002XZ-6E
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 22:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758002Ab3ANVHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 16:07:39 -0500
Received: from vint.altlinux.org ([194.107.17.35]:33567 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756559Ab3ANVHj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 16:07:39 -0500
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2013 16:07:39 EST
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id 2CCF2226C0AA;
	Mon, 14 Jan 2013 20:59:34 +0000 (UTC)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id 04418519000D; Tue, 15 Jan 2013 00:59:34 +0400 (MSK)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213532>

This fixes "hg" patch format support for locales other than C and en_*,
see https://bugzilla.altlinux.org/show_bug.cgi?id=28248

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 git-am.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index c682d34..64b88e4 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -334,7 +334,7 @@ split_patches () {
 			# Since we cannot guarantee that the commit message is in
 			# git-friendly format, we put no Subject: line and just consume
 			# all of the message as the body
-			perl -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
+			LC_ALL=C perl -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
 				if ($subject) { print ; }
 				elsif (/^\# User /) { s/\# User/From:/ ; print ; }
 				elsif (/^\# Date /) {

-- 
ldv
