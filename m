From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 9/9] Bisect: add a "bisect replay" test case.
Date: Mon, 22 Oct 2007 07:49:39 +0200
Message-ID: <20071022074939.1af47ae3.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 07:42:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijq3s-0007lY-ED
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 07:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbXJVFmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 01:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbXJVFmh
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 01:42:37 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:35018 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000AbXJVFmg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 01:42:36 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A5EB01AB2AE;
	Mon, 22 Oct 2007 07:42:35 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 6061F1AB2AA;
	Mon, 22 Oct 2007 07:42:35 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61947>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6030-bisect-porcelain.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index db82259..16d0c4a 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -167,6 +167,13 @@ test_expect_success 'bisect skip: add line and then a new test' '
 	git bisect skip &&
 	git bisect good > my_bisect_log.txt &&
 	grep "$HASH5 is first bad commit" my_bisect_log.txt &&
+	git bisect log > log_to_replay.txt
+	git bisect reset
+'
+
+test_expect_success 'bisect skip and bisect replay' '
+	git bisect replay log_to_replay.txt > my_bisect_log.txt &&
+	grep "$HASH5 is first bad commit" my_bisect_log.txt &&
 	git bisect reset
 '
 
-- 
1.5.3.3.136.g591d1-dirty
