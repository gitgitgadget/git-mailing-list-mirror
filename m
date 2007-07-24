From: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] send-email: Update regex parsing for pine aliases
Date: Tue, 24 Jul 2007 09:50:38 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0707240949040.19035@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 16:51:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDLjV-00030y-E7
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 16:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbXGXOvL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 10:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbXGXOvJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 10:51:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:48871 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297AbXGXOvI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 10:51:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l6OEp11g023863;
	Tue, 24 Jul 2007 09:51:02 -0500
X-X-Sender: galak@blarg.am.freescale.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53603>

The pine address book format is tab seperated and the first field
is the nickname/alias and the third field is the email address as
per:

http://www.washington.edu/pine/tech-notes/low-level.html

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index a09b1c9..f43f92f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -237,7 +237,7 @@ my %parse_alias = (
 			$aliases{$1} = [ split(/\s+/, $2) ];
 		}}},
 	pine => sub { my $fh = shift; while (<$fh>) {
-		if (/^(\S+)\s+(.*)$/) {
+		if (/^(\S+)\t.*\t(.*)$/) {
 			$aliases{$1} = [ split(/\s*,\s*/, $2) ];
 		}}},
 	gnus => sub { my $fh = shift; while (<$fh>) {
-- 
1.5.2.2
