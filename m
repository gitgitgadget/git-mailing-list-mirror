From: Roman Kagan <rkagan@mail.ru>
Subject: [PATCH 3/3] git-svn: drop redundant blocking of SIGPIPE
Date: Mon, 23 Apr 2012 20:26:56 +0400
Message-ID: <dad745568f79055298e3c12942f5bab22d0103fd.1335198921.git.rkagan@mail.ru>
References: <cover.1335198921.git.rkagan@mail.ru>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 18:39:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMMIX-0005T2-NF
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 18:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab2DWQjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 12:39:24 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:24896 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752315Ab2DWQjY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 12:39:24 -0400
Received: from localhost ([10.30.3.95])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id q3NGd0gb010659;
	Mon, 23 Apr 2012 20:39:01 +0400 (MSK)
In-Reply-To: <cover.1335198921.git.rkagan@mail.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196144>

Now that SIGPIPE is ignored there's no point blocking it.

Signed-off-by: Roman Kagan <rkagan@mail.ru>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index aa14564..f8e9ef0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4070,7 +4070,7 @@ sub rev_map_set {
 	if ($update_ref) {
 		$sigmask = POSIX::SigSet->new();
 		my $signew = POSIX::SigSet->new(SIGINT, SIGHUP, SIGTERM,
-			SIGALRM, SIGPIPE, SIGUSR1, SIGUSR2);
+			SIGALRM, SIGUSR1, SIGUSR2);
 		sigprocmask(SIG_BLOCK, $signew, $sigmask) or
 			croak "Can't block signals: $!";
 	}
-- 
1.7.7.6
