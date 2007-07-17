From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] git-gui: Handle git versions of the form n.n.n.GIT
Date: Tue, 17 Jul 2007 22:14:06 +0100
Message-ID: <20070717212103.11950.10363.julian@quantumfyre.co.uk>
References: <Pine.LNX.4.64.0707171244080.13359@reaper.quantumfyre.co.uk>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 17 23:26:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAuYi-0003s9-Gy
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 23:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756935AbXGQVZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 17:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756441AbXGQVZr
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 17:25:47 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:46306 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756935AbXGQVZq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 17:25:46 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 1DEE5C6119
	for <git@vger.kernel.org>; Tue, 17 Jul 2007 22:25:45 +0100 (BST)
Received: (qmail 17148 invoked by uid 103); 17 Jul 2007 22:25:42 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3630. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.024736 secs); 17 Jul 2007 21:25:42 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 17 Jul 2007 22:25:42 +0100
X-git-sha1: 92de1db14a8132a48ad904eff1d2db35ad0dc293 
X-Mailer: git-mail-commits v0.1
In-Reply-To: <Pine.LNX.4.64.0707171244080.13359@reaper.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52802>

The git-gui version check doesn't handle versions of the form
n.n.n.GIT which you can get by installing from an tarball produced by
git-archive.

Without this change you get an error of the form:
'Error in startup script: expected version number but got "1.5.3.GIT"'

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

> I have a machine on which git was installed from a tarball created by 
> running git-archive on master (so a 1.5.3ish version).
> 
> When I try running git-gui I get an error message:
> 
> 'Error in startup script: expected version number but got "1.5.3.GIT"'
> 
> followed by what I assume is a code snippet where it failed (I wouldn't 
> know tcl if it hit me with a large brick).
> 
> Is this expected? driver error? or maybe a bug?

Well, whichever it is, this seems to fix it for me ... with the proviso that I
still no nothing about tcl.  I am also not sure if it is correct to do the
patch against the git repo?

 git-gui/git-gui.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 2077261..f8b1f10 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -546,6 +546,7 @@ if {![regsub {^git version } $_git_version {} _git_version]} {
 }
 regsub {\.[0-9]+\.g[0-9a-f]+$} $_git_version {} _git_version
 regsub {\.rc[0-9]+$} $_git_version {} _git_version
+regsub {\.GIT$} $_git_version {} _git_version
 
 proc git-version {args} {
 	global _git_version
-- 
1.5.2.2
