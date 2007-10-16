From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Bisect: add a "bisect replay" test case.
Date: Tue, 16 Oct 2007 06:33:13 +0200
Message-ID: <20071016063313.17a6e7c1.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 06:26:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihe0c-0004Hs-5D
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 06:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbXJPE0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 00:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbXJPE0L
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 00:26:11 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:46641 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936AbXJPE0K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 00:26:10 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 8F05E1AB2B5;
	Tue, 16 Oct 2007 06:26:09 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 504451AB2B2;
	Tue, 16 Oct 2007 06:26:09 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61072>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6030-bisect-porcelain.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

	There is no bisect log/replay test case right now.
	Let's add one.

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 7f41a46..49f3601 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -167,6 +167,13 @@ test_expect_success 'bisect dunno: add line and then a new test' '
 	git bisect dunno &&
 	git bisect good > my_bisect_log.txt &&
 	grep "$HASH5 is first bad commit" my_bisect_log.txt &&
+	git bisect log > log_to_replay.txt
+	git bisect reset
+'
+
+test_expect_success 'bisect dunno and bisect replay' '
+	git bisect replay log_to_replay.txt > my_bisect_log.txt &&
+	grep "$HASH5 is first bad commit" my_bisect_log.txt &&
 	git bisect reset
 '
 
-- 
1.5.3.3.136.g591d1-dirty
