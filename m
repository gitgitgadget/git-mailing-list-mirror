From: Alex Vandiver <alexmv@MIT.EDU>
Subject: [PATCH 2/2] git-svn: Correctly report max revision when following deleted paths
Date: Wed,  6 May 2009 16:18:53 -0400
Message-ID: <1241641133-6974-2-git-send-email-alexmv@mit.edu>
References: <1241641133-6974-1-git-send-email-alexmv@mit.edu>
Cc: Alex Vandiver <alexmv@MIT.EDU>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 22:36:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1nqf-0004fl-9w
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 22:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760700AbZEFUfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 16:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760337AbZEFUfx
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 16:35:53 -0400
Received: from SOUTH-STATION-ANNEX.MIT.EDU ([18.72.1.2]:61195 "EHLO
	south-station-annex.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755089AbZEFUfw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 16:35:52 -0400
Received: from grand-central-station.mit.edu (GRAND-CENTRAL-STATION.MIT.EDU [18.7.21.82])
	by south-station-annex.mit.edu (8.13.6/8.9.2) with ESMTP id n46KJLvw025399;
	Wed, 6 May 2009 16:19:21 -0400 (EDT)
Received: from outgoing-legacy.mit.edu (OUTGOING-LEGACY.MIT.EDU [18.7.22.104])
	by grand-central-station.mit.edu (8.13.6/8.9.2) with ESMTP id n46KJ6bX018862;
	Wed, 6 May 2009 16:19:06 -0400 (EDT)
Received: from localhost.localdomain (75-147-59-54-NewEngland.hfc.comcastbusiness.net [75.147.59.54])
	)
	by outgoing-legacy.mit.edu (8.13.6/8.12.4) with ESMTP id n46KJ10v003118;
	Wed, 6 May 2009 16:19:05 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc4.225.g060aa4
In-Reply-To: <1241641133-6974-1-git-send-email-alexmv@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Score: -2.464
X-Spam-Flag: NO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118379>

Report the maximum found revision in the range, instead of the minimum
changed revision.

Signed-off-by: Alex Vandiver <alexmv@mit.edu>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 5836dde..eebcf0f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4471,7 +4471,7 @@ sub gs_fetch_loop_common {
 				my $ok;
 				$self->get_log([$longest_path], $min, $hi,
 				               0, 1, 1, sub {
-				               $ok ||= $_[1];
+				               $ok = $_[1];
 				               $revs{$_[1]} = _cb(@_) });
 				if ($ok) {
 					print STDERR "r$min .. r$ok OK\n";
-- 
1.6.3.rc4.225.g060aa4
