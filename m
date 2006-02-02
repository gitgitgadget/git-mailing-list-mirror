From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 1/2] Provide a more meaningful initial "From " line when using --compose in git-send-email.
Date: Thu, 2 Feb 2006 11:56:06 -0500
Message-ID: <11388993663675-git-send-email-ryan@michonline.com>
References: <11388993661745-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 18:00:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4hlO-0005Ww-PB
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 17:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWBBQ4u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 11:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWBBQ4u
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 11:56:50 -0500
Received: from mail.autoweb.net ([198.172.237.26]:29358 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S932168AbWBBQ4t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2006 11:56:49 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1F4hlC-000525-Rc
	for git@vger.kernel.org; Thu, 02 Feb 2006 11:56:49 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F4hlB-00029C-0f; Thu, 02 Feb 2006 11:56:42 -0500
Received: from localhost
	([127.0.0.1] helo=mythryan2 ident=ryan)
	by mythical with smtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F4hkc-0000OI-GC; Thu, 02 Feb 2006 11:56:06 -0500
In-Reply-To: <11388993661745-git-send-email-ryan@michonline.com>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15512>

git-send-email, when used with --compose, provided the user with a mbox-format
file to edit.  Some users, however, were confused by the leading, blank, "From
" line, so this change puts the value that will appear on the From: line of the
actual email on this line, along with a note that the line is ignored.

Signed-off-by: Ryan Anderson <ryan@michonline.com>

---

 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

c6b0c22e482aa6fe314e4be077d705c98fee7bf2
diff --git a/git-send-email.perl b/git-send-email.perl
index ec1428d..51b7513 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -125,7 +125,7 @@ if ($compose) {
 	# effort to have it be unique
 	open(C,">",$compose_filename)
 		or die "Failed to open for writing $compose_filename: $!";
-	print C "From \n";
+	print C "From $from # This line is ignored.\n";
 	printf C "Subject: %s\n\n", $initial_subject;
 	printf C <<EOT;
 GIT: Please enter your email below.
-- 
1.1.4.g3dcbd
