From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] svn: (cleanup) use predefined constant for rev_map_fmt
Date: Wed, 12 Aug 2009 22:34:23 -0700
Message-ID: <20090813053423.GB24694@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 07:37:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbT02-0000Ku-6F
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 07:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbZHMFeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 01:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbZHMFeX
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 01:34:23 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45517 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696AbZHMFeX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 01:34:23 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 61BD61F7E2;
	Thu, 13 Aug 2009 05:34:24 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125784>

This makes life easier in case we ever need to change the
internal format of the rev_maps.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 also pushed out to git://yhbt.net/git-svn

 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a2934e8..1da9f07 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3277,7 +3277,7 @@ sub _rev_map_get {
 		my $i = int(($l/24 + $u/24) / 2) * 24;
 		sysseek($fh, $i, SEEK_SET) or croak "seek: $!";
 		sysread($fh, my $buf, 24) == 24 or croak "read: $!";
-		my ($r, $c) = unpack('NH40', $buf);
+		my ($r, $c) = unpack(rev_map_fmt, $buf);
 
 		if ($r < $rev) {
 			$l = $i + 24;
-- 
Eric Wong
