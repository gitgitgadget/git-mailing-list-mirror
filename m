From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 2 Jan 2009 11:58:56 +0100
Message-ID: <20090102105856.GB14691@localhost>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20090101204652.GA26128@chistera.yi.org> <alpine.LFD.2.00.0901011747010.5086@localhost.localdomain> <20090102105537.GA14691@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adeodato =?iso-8859-1?Q?Sim=F3?= <dato@net.com.org.es>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 12:00:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIhlL-0007Wg-2O
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 12:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757251AbZABK7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 05:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756714AbZABK67
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 05:58:59 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:17584 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412AbZABK67 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 05:58:59 -0500
Received: from darc.dyndns.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Jan 2009 11:58:56 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LIhk0-00045l-6G; Fri, 02 Jan 2009 11:58:56 +0100
Content-Disposition: inline
In-Reply-To: <20090102105537.GA14691@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 02 Jan 2009 10:58:56.0790 (UTC) FILETIME=[1BD46360:01C96CC9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104372>

Only two choices, and I still get it wrong. The diffs should be labeled the
other way around, of course.

*** git diff --patience ******************** git diff ********************
 #include <stdio.h>                   | #include <stdio.h>
                                      |
+int fib(int n)                       |-// Frobs foo heartily
+{                                    |-int frobnitz(int foo)
+    if(n > 2)                        |+int fib(int n)
+    {                                | {
+        return fib(n-1) + fib(n-2);  |-    int i;
+    }                                |-    for(i = 0; i < 10; i++)
+    return 1;                        |+    if(n > 2)
+}                                    |     {
+                                     |-        printf("Your answer is: ");
 // Frobs foo heartily                |-        printf("%d\n", foo);
 int frobnitz(int foo)                |+        return fib(n-1) + fib(n-2);
 {                                    |     }
     int i;                           |+    return 1;
     for(i = 0; i < 10; i++)          | }
     {                                |
-        printf("Your answer is: ");  |-int fact(int n)
         printf("%d\n", foo);         |+// Frobs foo heartily
     }                                |+int frobnitz(int foo)
 }                                    | {
                                      |-    if(n > 1)
-int fact(int n)                      |+    int i;
-{                                    |+    for(i = 0; i < 10; i++)
-    if(n > 1)                        |     {
-    {                                |-        return fact(n-1) * n;
-        return fact(n-1) * n;        |+        printf("%d\n", foo);
-    }                                |     }
-    return 1;                        |-    return 1;
-}                                    | }
-                                     |
 int main(int argc, char **argv)      | int main(int argc, char **argv)
 {                                    | {
-    frobnitz(fact(10));              |-    frobnitz(fact(10));
+    frobnitz(fib(10));               |+    frobnitz(fib(10));
 }                                    | }
