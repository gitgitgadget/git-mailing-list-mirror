From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 5/6] t5570: repack everything into one file
Date: Wed,  4 Jan 2012 16:55:38 +0100
Message-ID: <1325692539-26748-6-git-send-email-drizzd@aon.at>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 17:04:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiTK2-0001tT-Mf
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 17:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188Ab2ADQEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 11:04:08 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:8377 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756157Ab2ADQEE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 11:04:04 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 2427D2C400B;
	Wed,  4 Jan 2012 17:04:57 +0100 (CET)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1325692539-26748-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187927>

Subsequently we assume that there is only one pack. Currently this is
true only by accident. Pass '-a -d' to repack in order to guarantee that
assumption to hold true.

The prune-packed command is now redundant since repack -d already calls
it.
---
 t/t5570-git-daemon.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index a7d666c..f2b374b 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -50,8 +50,7 @@ test_expect_failure 'remote detects correct HEAD' '
 test_expect_success 'prepare pack objects' '
 	cp -R "$DAEMON_DOCUMENT_ROOT_PATH"/repo.git "$DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git &&
 	(cd "$DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git &&
-	 git --bare repack &&
-	 git --bare prune-packed
+	 git --bare repack -a -d
 	)
 '
 
-- 
1.7.8
