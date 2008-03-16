From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] git-cvsserver: handle change type T
Date: Sun, 16 Mar 2008 20:00:21 +0100
Message-ID: <E1Jay7s-0000dO-IX@fencepost.gnu.org>
Cc: beuc@gnu.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 20:03:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jay8Y-0006yn-Rh
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 20:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbYCPTCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 15:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbYCPTCf
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 15:02:35 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:51441 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbYCPTCe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 15:02:34 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1Jay7s-0000dO-IX; Sun, 16 Mar 2008 15:02:32 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77373>

git-cvsserver does not support changes of type T (file type change,
e.g. symlink->real file).  This patch treats them the same as changes
of type M.
---
 git-cvsserver.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index afe3d0b..1b6b20e 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2633,7 +2633,7 @@ sub update
                     };
                     $self->insert_rev($name, $head->{$name}{revision}, $hash, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
                 }
-                elsif ( $change eq "M" )
+                elsif ( $change eq "M" || $change eq "T" )
                 {
                     #$log->debug("MODIFIED $name");
                     $head->{$name} = {
-- 
1.5.3.4.910.gc5122-dirty
