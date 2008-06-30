From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 4/7] git-daemon(1): don't assume git-daemon is in /usr/bin
Date: Mon, 30 Jun 2008 17:15:57 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0806301711210.7190@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jon Loeliger <jdl@jdl.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 00:17:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDRgd-0006yG-II
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762841AbYF3WQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 18:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762544AbYF3WQY
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:16:24 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:47692 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789AbYF3WQY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:16:24 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m5UMFwMx024468;
	Mon, 30 Jun 2008 17:15:58 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m5UMFwWR008048;
	Mon, 30 Jun 2008 17:15:58 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86947>

In the example inetd.conf lines in git-daemon(1), it was
assumed that `git-daemon` resides in the user's /usr/bin.
With this patch, we only assume `git` is in /usr/bin.

The stronger assumption fails in the default installation
nowadays.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/git-daemon.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 344f24e..b71eb94 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -206,8 +206,8 @@ git-daemon as inetd server::
 	/etc/inetd all on one line:
 +
 ------------------------------------------------
-	git stream tcp nowait nobody  /usr/bin/git-daemon
-		git-daemon --inetd --verbose --export-all
+	git stream tcp nowait nobody  /usr/bin/git
+		git daemon --inetd --verbose --export-all
 		/pub/foo /pub/bar
 ------------------------------------------------
 
@@ -219,8 +219,8 @@ git-daemon as inetd server for virtual hosts::
 	`/etc/inetd` all on one line:
 +
 ------------------------------------------------
-	git stream tcp nowait nobody /usr/bin/git-daemon
-		git-daemon --inetd --verbose --export-all
+	git stream tcp nowait nobody /usr/bin/git
+		git daemon --inetd --verbose --export-all
 		--interpolated-path=/pub/%H%D
 		/pub/www.example.org/software
 		/pub/www.example.com/software
@@ -241,7 +241,7 @@ git-daemon as regular daemon for virtual hosts::
 	their IP addresses, start the daemon like this:
 +
 ------------------------------------------------
-	git-daemon --verbose --export-all
+	git daemon --verbose --export-all
 		--interpolated-path=/pub/%IP/%D
 		/pub/192.168.1.200/software
 		/pub/10.10.220.23/software
-- 
1.5.5.GIT
