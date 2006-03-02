From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 1/3] Handle \No newline at end of file.
Date: Thu, 2 Mar 2006 00:23:37 -0500
Message-ID: <11412770173208-git-send-email-ryan@michonline.com>
References: <114127659642-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Thu Mar 02 06:24:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEgIe-0001Ff-2D
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 06:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWCBFYT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 00:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWCBFYT
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 00:24:19 -0500
Received: from mail.autoweb.net ([198.172.237.26]:44474 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751224AbWCBFYS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 00:24:18 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FEgIR-00033X-Nh; Thu, 02 Mar 2006 00:24:17 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FEgIH-0000qT-BK; Thu, 02 Mar 2006 00:24:05 -0500
Received: from localhost
	([127.0.0.1] helo=mythryan2 ident=ryan)
	by mythical with smtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FEgHp-00046z-Gd; Thu, 02 Mar 2006 00:23:37 -0500
In-Reply-To: <114127659642-git-send-email-ryan@michonline.com>
X-Mailer: git-send-email
To: Junio C Hamano <junkio@cox.net>
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17052>

Signed-off-by: Ryan Anderson <ryan@michonline.com>

---

 git-annotate.perl |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

e30d9ddd62cf016124dd9f32e14809d0a38c69e2
diff --git a/git-annotate.perl b/git-annotate.perl
index f9c2c6c..d6028c9 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -304,6 +304,12 @@ sub _git_diff_parse {
 			}
 			$ri++;
 
+		} elsif (m/^\\/) {
+			;
+			# Skip \No newline at end of file.
+			# But this can be internationalized, so only look
+			# for an initial \
+
 		} else {
 			if (substr($_,1) ne get_line($slines,$ri) ) {
 				die sprintf("Line %d (%d) does not match:\n|%s\n|%s\n%s => %s\n",
-- 
1.2.2.g1070
