From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/5] gitweb: git_print_log: signoff line is non-empty line
Date: Mon, 28 Aug 2006 14:48:13 +0200
Message-ID: <11567692953331-git-send-email-jnareb@gmail.com>
References: <11567692943154-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 28 14:49:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHgXo-0005ac-D0
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 14:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWH1Msa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 08:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWH1Msa
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 08:48:30 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:10418 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1750754AbWH1MsY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 08:48:24 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7SCl2M9031913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Aug 2006 14:47:02 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7SCmFDN017626;
	Mon, 28 Aug 2006 14:48:15 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7SCmFaP017625;
	Mon, 28 Aug 2006 14:48:15 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11567692943154-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26153>

This correct minor error in git_print_log that didn't add final empty
line when requested, if commit log ended with signoff.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 81d3e76..8987967 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1394,6 +1394,7 @@ sub git_print_log ($;%) {
 	foreach my $line (@$log) {
 		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
 			$signoff = 1;
+			$empty = 0;
 			if (! $opts{'-remove_signoff'}) {
 				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
 				next;
-- 
1.4.1.1
