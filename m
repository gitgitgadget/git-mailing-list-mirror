From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] perl/Makefile: update NO_PERL_MAKEMAKER section
Date: Tue, 22 Jul 2008 16:15:41 -0500
Message-ID: <XKT02T_QW2tKLHpR7e3VuZjLXv3RP2E0GD54gXKrdIFm8xQsKvAyjg@cipher.nrlssc.navy.mil>
References: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:17:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPEm-0007b1-0D
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839AbYGVVQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756837AbYGVVQC
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:16:02 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54000 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834AbYGVVQA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:16:00 -0400
Received: by mail.nrlssc.navy.mil id m6MLFg6f020350; Tue, 22 Jul 2008 16:15:42 -0500
In-Reply-To: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Jul 2008 21:15:42.0188 (UTC) FILETIME=[190502C0:01C8EC40]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89533>

The perl modules must be copied to blib/lib so they are available for
testing.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 perl/Makefile |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/perl/Makefile b/perl/Makefile
index 5e079ad..2b0d3d5 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -22,8 +22,11 @@ clean:
 ifdef NO_PERL_MAKEMAKER
 instdir_SQ = $(subst ','\'',$(prefix)/lib)
 $(makfile): ../GIT-CFLAGS Makefile
-	echo all: > $@
-	echo '	:' >> $@
+	echo all: private-Error.pm Git.pm > $@
+	echo '	mkdir -p blib/lib' >> $@
+	echo '	$(RM) blib/lib/Git.pm; cp Git.pm blib/lib/' >> $@
+	echo '	$(RM) blib/lib/Error.pm; \
+	cp private-Error.pm blib/lib/Error.pm' >> $@
 	echo install: >> $@
 	echo '	mkdir -p $(instdir_SQ)' >> $@
 	echo '	$(RM) $(instdir_SQ)/Git.pm; cp Git.pm $(instdir_SQ)' >> $@
-- 
1.6.0.rc0.38.g8b8fb7
