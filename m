From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 4/7] Git.pm: Fix Git->repository("/somewhere/totally/elsewhere")
Date: Sun, 25 Jun 2006 03:54:28 +0200
Message-ID: <20060625015428.29906.66270.stgit@machine.or.cz>
References: <20060625015421.29906.50002.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 25 03:54:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJpZ-00069P-HG
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWFYBya (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWFYBya
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:54:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:682 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751351AbWFYBy3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:54:29 -0400
Received: (qmail 29956 invoked from network); 25 Jun 2006 03:54:28 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 25 Jun 2006 03:54:28 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060625015421.29906.50002.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22573>

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/Git.pm |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index eea6c07..1c3a2ec 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -178,7 +178,8 @@ sub repository {
 		};
 
 		if ($dir) {
-			$opts{Repository} = abs_path($dir);
+			$dir =~ m#^/# or $dir = $opts{Directory} . '/' . $dir;
+			$opts{Repository} = $dir;
 
 			# If --git-dir went ok, this shouldn't die either.
 			my $prefix = $search->command_oneline('rev-parse', '--show-prefix');
