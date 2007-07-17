From: Eddie Kohler <kohler@cs.ucla.edu>
Subject: gitweb: get_file_owner and XML special characters
Date: Tue, 17 Jul 2007 13:06:37 -0700
Message-ID: <469D214D.7030101@cs.ucla.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050009010700090909000202"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 17 22:13:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAtQP-0004da-JG
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 22:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933597AbXGQUNc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 16:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933337AbXGQUNb
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 16:13:31 -0400
Received: from smtp-8.smtp.ucla.edu ([169.232.47.138]:42900 "EHLO
	smtp-8.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932923AbXGQUNa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 16:13:30 -0400
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jul 2007 16:13:30 EDT
Received: from mail.ucla.edu (mail.ucla.edu [169.232.47.145])
	by smtp-8.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6HK6SnS025195
	for <git@vger.kernel.org>; Tue, 17 Jul 2007 13:06:28 -0700
Received: from [131.179.33.130] (Cs-33-130.CS.UCLA.EDU [131.179.33.130])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6HK6RaH027707
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 17 Jul 2007 13:06:28 -0700
User-Agent: Thunderbird 1.5.0.12 (X11/20070530)
X-Probable-Spam: no
X-Spam-Hits: 0.654
X-Spam-Report: SPF_SOFTFAIL
X-Scanned-By: smtp.ucla.edu on 169.232.47.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52795>

This is a multi-part message in MIME format.
--------------050009010700090909000202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I think current gitweb generates invalid XHTML when get_file_owner returns a 
string containing <>&.  (Version 1.5.2.1 certainly does, and in a quick browse 
of current source I didn't notice relevant changes.)

Here is a dirty patch to fix this problem.  Apologies if it is no longer a 
problem or if the patch is gross.
Thanks,
Eddie (newbie)


--------------050009010700090909000202
Content-Type: text/x-patch;
 name="0001-Escape-HTML-special-characters-in-file-owner.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Escape-HTML-special-characters-in-file-owner.patch"

>From 1c6ba7b6b28808cea0f2f9ab46733ddefdac329a Mon Sep 17 00:00:00 2001
From: Eddie Kohler <kohler@cs.ucla.edu>
Date: Tue, 17 Jul 2007 13:06:08 -0700
Subject: [PATCH] Escape HTML special characters in file owner

---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c8ba3a2..540d9a6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2050,7 +2050,7 @@ sub get_file_owner {
 	}
 	my $owner = $gcos;
 	$owner =~ s/[,;].*$//;
-	return to_utf8($owner);
+	return $cgi->escapeHTML(to_utf8($owner));
 }
 
 ## ......................................................................
-- 
1.5.2.2


--------------050009010700090909000202--
