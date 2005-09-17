From: Linus Torvalds <torvalds@osdl.org>
Subject: [Take 2] Make "git shortlog" understand raw logs
Date: Fri, 16 Sep 2005 18:02:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509161758270.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Sep 17 03:04:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGR7N-0008Vc-4E
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 03:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVIQBC7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 21:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVIQBC7
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 21:02:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16819 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750800AbVIQBC7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 21:02:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8H12oBo031047
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Sep 2005 18:02:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8H12kFf022933;
	Fri, 16 Sep 2005 18:02:48 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8746>


This is a nicer fix for git-shortlog being unable to handle the raw log 
format. Just use a more permissive regexp instead of doing two nearly 
identical ones.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git-shortlog.perl b/git-shortlog.perl
--- a/git-shortlog.perl
+++ b/git-shortlog.perl
@@ -108,7 +108,7 @@ sub changelog_input {
 		if ($pstate == 1) {
 			my ($email);
 
-			next unless /^Author: (.*)<(.*)>.*$/;
+			next unless /^[Aa]uthor:? (.*)<(.*)>.*$/;
 	
 			$n_records++;
 	
