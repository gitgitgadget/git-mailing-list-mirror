From: "martin f. krafft" <madduck@debian.org>
Subject: [TopGit PATCH] Check for cmddir earlier
Date: Wed, 19 Nov 2008 17:03:42 +0100
Message-ID: <1227110623-4474-4-git-send-email-madduck@debian.org>
References: <1227110623-4474-1-git-send-email-madduck@debian.org>
 <1227110623-4474-2-git-send-email-madduck@debian.org>
 <1227110623-4474-3-git-send-email-madduck@debian.org>
Cc: "martin f. krafft" <madduck@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 17:06:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2pYt-0004Ic-91
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 17:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbYKSQEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 11:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbYKSQEG
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 11:04:06 -0500
Received: from clegg.madduck.net ([193.242.105.96]:47995 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbYKSQD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 11:03:59 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 73DDD1D40B0;
	Wed, 19 Nov 2008 17:03:47 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 1169A9F34E;
	Wed, 19 Nov 2008 17:03:44 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id B077345F6; Wed, 19 Nov 2008 17:03:43 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1227110623-4474-3-git-send-email-madduck@debian.org>
X-Virus-Scanned: ClamAV 0.94.1/8650/Wed Nov 19 05:59:50 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101357>

Without cmddir, tg is basically useless, even do_help() needs it, so
check it first and die hard if not found

Signed-off-by: martin f. krafft <madduck@debian.org>
---
 tg.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tg.sh b/tg.sh
index ea22544..f3d1323 100644
--- a/tg.sh
+++ b/tg.sh
@@ -237,6 +237,9 @@ do_help()
 
 ## Startup
 
+[ -d "@cmddir@" ] ||
+	die "No command directory: '@cmddir@'"
+
 args_saved="$@"
 while [ -n "$1" ]; do
 	case "$1" in
@@ -263,9 +266,6 @@ tg="tg"
 setup_ours
 setup_hook "pre-commit"
 
-[ -d "@cmddir@" ] ||
-	die "No command directory: '@cmddir@'"
-
 ## Dispatch
 
 # We were sourced from another script for our utility functions;
-- 
1.6.0.2
