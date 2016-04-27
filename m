From: Rafal Klys <rafalklys@wp.pl>
Subject: [PATCH] trailer: load config to handle core.commentChar
Date: Wed, 27 Apr 2016 21:24:22 +0200
Message-ID: <1461785062-23523-1-git-send-email-rafalklys@wp.pl>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Rafal Klys <rafalklys@wp.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 21:31:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avVBC-0001Yu-Sb
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 21:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbcD0TbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 15:31:19 -0400
Received: from mx4.wp.pl ([212.77.101.11]:26500 "EHLO mx4.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752660AbcD0TbS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 15:31:18 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Apr 2016 15:31:17 EDT
Received: (wp-smtpd smtp.wp.pl 23884 invoked from network); 27 Apr 2016 21:24:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1461785076; bh=OURzDUF4jVT3axZ74+hAHfCmU2RN61SYtB/RrAoQoNc=;
          h=From:To:Cc:Subject;
          b=WN1cTmcADEZsiYrztim2Jpz8iufbgDyxeQJnV/Rx8vQi9yG1Tot69cJFocMj2q4U4
           8ZxxZs+GoUPoKviTioK/1EyCzVb2A/o4aniU4Z+Virl7ncWQZiUDO88TKoqrGsmhJH
           jJiuW3TVQLYEd/J5GbmsFiWC+x3NKyto5sYlagO8=
Received: from staticline-31-183-163-223.toya.net.pl (HELO localhost.localdomain) (rafalklys@wp.pl@[31.183.163.223])
          (envelope-sender <rafalklys@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 27 Apr 2016 21:24:36 +0200
X-Mailer: git-send-email 2.8.1.68.g625efa9.dirty
X-WP-DKIM-Status: good (id: wp.pl)                                      
X-WP-MailID: c108f08c807ce4e39d025b28a492e44f
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO 0000000 [sfP0]                               
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292789>

Add call to git_config(git_default_config, NULL) to update the
comment_char_line from default '#' to possible different value set in
core.commentChar.

Signed-off-by: Rafal Klys <rafalklys@wp.pl>
---
 trailer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/trailer.c b/trailer.c
index 8e48a5c..a3700b4 100644
--- a/trailer.c
+++ b/trailer.c
@@ -888,6 +888,9 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 	git_config(git_trailer_default_config, NULL);
 	git_config(git_trailer_config, NULL);
 
+	/* for core.commentChar */
+	git_config(git_default_config, NULL);
+
 	lines = read_input_file(file);
 
 	if (in_place)
-- 
2.8.1.68.g625efa9.dirty
