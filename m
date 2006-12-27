From: Quy Tonthat <qtonthat@gmail.com>
Subject: [PATCH] git-send-email: default value for "From:" field.
Date: Thu, 28 Dec 2006 01:16:21 +1100
Message-ID: <45928035.6000605@gmail.com>
References: <200612271343.kBRDhKfA009927@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 15:16:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzZaH-00078t-V3
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 15:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932821AbWL0OQ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 09:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932840AbWL0OQ2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 09:16:28 -0500
Received: from pecan-mail.exetel.com.au ([220.233.0.8]:44990 "EHLO
	pecan.exetel.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932821AbWL0OQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 09:16:27 -0500
Received: from [220.233.69.95] (helo=[192.168.64.35])
	by pecan.exetel.com.au with esmtp (Exim 4.63)
	(envelope-from <qtonthat@gmail.com>)
	id 1GzZZu-0007uX-NP; Thu, 28 Dec 2006 01:16:23 +1100
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
In-Reply-To: <200612271343.kBRDhKfA009927@laptop13.inf.utfsm.cl>
X-Enigmail-Version: 0.94.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35471>

If user hits enter at the prompt for
"Who should the emails appear to be from?",
the value for "From:" field was emptied instead of GIT_COMMITER_IDENT.

Signed-off-by: Quy Tonthat <qtonthat@gmail.com>
---
It seems the original code assumes readline to accept
an extra argument for default value. I don't remember I ever encountered
that feature from readline. Is there anything like that out there ?

 git-send-email.perl |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4c87c20..ba39d39 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -178,11 +178,10 @@ my $prompting = 0;
 if (!defined $from) {
 	$from = $author || $committer;
 	do {
-		$_ = $term->readline("Who should the emails appear to be from? ",
-			$from);
+		$_ = $term->readline("Who should the emails appear to be from? [$from] ");
 	} while (!defined $_);
 
-	$from = $_;
+	$from = $_ if ($_);
 	print "Emails will be sent from: ", $from, "\n";
 	$prompting++;
 }
-- 
1.4.4.3.q5
