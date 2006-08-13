From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] pass DESTDIR to the generated perl/Makefile
Date: Sun, 13 Aug 2006 04:13:25 -0700
Message-ID: <11554676054185-git-send-email-normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Aug 13 13:13:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCDud-0001Lu-0r
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 13:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWHMLN3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 07:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWHMLN3
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 07:13:29 -0400
Received: from hand.yhbt.net ([66.150.188.102]:24469 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750980AbWHMLN3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Aug 2006 07:13:29 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id E2FBC7DC029;
	Sun, 13 Aug 2006 04:13:26 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 13 Aug 2006 04:13:25 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.2.g7c9b
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25280>

Makes life for binary packagers easier, as the Perl modules will
be installed inside DESTDIR.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Makefile.PL |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 97ee9af..8df46a4 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -22,10 +22,14 @@ if ($@) {
 	$pm{'private-Error.pm'} = '$(INST_LIBDIR)/Error.pm';
 }
 
+my %o;
+$o{DESTDIR} = $ENV{DESTDIR} if $ENV{DESTDIR};
+
 WriteMakefile(
 	NAME            => 'Git',
 	VERSION_FROM    => 'Git.pm',
 	PM		=> \%pm,
 	MYEXTLIB        => '../libgit.a',
 	INC             => '-I. -I..',
+	%o
 );
-- 
1.4.2.GIT
