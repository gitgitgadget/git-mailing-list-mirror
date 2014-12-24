From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 5/5] engine.pl: provide more debug print statements
Date: Wed, 24 Dec 2014 10:47:14 +0000
Message-ID: <1419418034-6276-6-git-send-email-philipoakley@iee.org>
References: <1419418034-6276-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Msysgit <msysgit@googlegroups.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 11:47:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3jTZ-0004aY-9c
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 11:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbaLXKra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 05:47:30 -0500
Received: from b216.a.smtp2go.com ([216.22.18.216]:36588 "EHLO
	b216.a.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbaLXKr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2014 05:47:27 -0500
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1419418034-6276-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261806>

Assist developers transitioning between the two cultures
by including appropriate, but commented out, debug statements.

This acts as a poor man's --verbose option. The test suite doesn't
cover the contrib/buildsystems (or Msysgit's msvc-build) contributions
so fails to notice breakages there-in.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 contrib/buildsystems/engine.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index e913280..24a4c61 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -41,6 +41,7 @@ EOM
 # Parse command-line options
 while (@ARGV) {
     my $arg = shift @ARGV;
+	#print "Arg: $arg \n";
     if ("$arg" eq "-h" || "$arg" eq "--help" || "$arg" eq "-?") {
 	showUsage();
 	exit(0);
@@ -123,6 +124,7 @@ sub parseMakeOutput
     print "Parsing GNU Make output to figure out build structure...\n";
     my $line = 0;
     while (my $text = shift @makedry) {
+		#print "Make: $text\n"; # show the makedry line
         my $ate_next;
         do {
             $ate_next = 0;
@@ -257,6 +259,7 @@ sub handleCompileLine
         } elsif ($part =~ /\.(c|cc|cpp)$/) {
             $sourcefile = $part;
         } else {
+            print "full line: $line\n";
             die "Unhandled compiler option @ line $lineno: $part";
         }
     }
@@ -282,6 +285,7 @@ sub handleLibLine
             $libout = $part;
             $libout =~ s/\.a$//;
         } else {
+            print "full line: $line\n";
             die "Unhandled lib option @ line $lineno: $part";
         }
     }
-- 
2.1.0
