From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] import-tars: be nice to wrong directory modes
Date: Sun, 29 Apr 2007 01:59:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704290159230.29859@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 29 02:00:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhwqJ-0002pJ-Eu
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 02:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbXD2AAk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 20:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754460AbXD2AAk
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 20:00:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:34312 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754470AbXD1X7y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 19:59:54 -0400
Received: (qmail invoked by alias); 28 Apr 2007 23:59:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 29 Apr 2007 01:59:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DOktCN6JDvmHXgqZam6cdLBWbp4kdiwdWEZ5zLn
	fVz/EdWc25tyHa
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45802>


Some tars seem to have modes 0755 for directories, not 01000755. Do
not generate an empty object for them, but ignore them.

Noticed by riddochc on IRC.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/fast-import/import-tars.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index 1842146..5575080 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -52,6 +52,7 @@ foreach my $tar_file (@ARGV)
 			Z8 Z1 Z100 Z6
 			Z2 Z32 Z32 Z8 Z8 Z*', $_;
 		last unless $name;
+		next if $name =~ '/$';
 		$mode = oct $mode;
 		$size = oct $size;
 		$mtime = oct $mtime;
-- 
1.5.2.rc0.2496.g74f7
