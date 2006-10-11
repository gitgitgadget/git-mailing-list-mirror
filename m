From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Fix search form when PATH_INFO is enabled
Date: Wed, 11 Oct 2006 22:31:15 +0200
Message-ID: <20061011203115.28629.20993.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 11 22:34:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXkjZ-0003ww-4t
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 22:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161243AbWJKUbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 16:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161244AbWJKUbR
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 16:31:17 -0400
Received: from rover.dkm.cz ([62.24.64.27]:51404 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S1161243AbWJKUbQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 16:31:16 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 561808B4B8;
	Wed, 11 Oct 2006 22:31:15 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28744>

Currently that was broken. Ideal fix would make the search form use
PATH_INFO too, but it's just one insignificant place so it's no big deal if
we don't for now... This at least makes it work.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d165fdc..18c0d52 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -445,6 +445,9 @@ sub href(%) {
 	my %params = @_;
 	my $href = $my_uri;
 
+	# XXX: Warning: If you touch this, check the search form for updating,
+	# too.
+
 	my @mapping = (
 		project => "p",
 		action => "a",
@@ -1553,6 +1556,7 @@ #provides backwards capability for those
 		}
 		$cgi->param("a", "search");
 		$cgi->param("h", $search_hash);
+		$cgi->param("p", $project);
 		print $cgi->startform(-method => "get", -action => $my_uri) .
 		      "<div class=\"search\">\n" .
 		      $cgi->hidden(-name => "p") . "\n" .
