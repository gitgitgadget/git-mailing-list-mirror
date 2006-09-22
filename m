From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Fix @git_base_url_list usage
Date: Sat, 23 Sep 2006 01:15:18 +0200
Message-ID: <20060922231518.32050.73077.stgit@rover>
References: <20060920004935.GJ8259@pasky.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 23 01:15:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQuEu-0002m9-Qj
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 01:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWIVXPV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 19:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWIVXPU
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 19:15:20 -0400
Received: from rover.dkm.cz ([62.24.64.27]:23695 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S964910AbWIVXPT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 19:15:19 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 68E9F8B855;
	Sat, 23 Sep 2006 01:15:18 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060920004935.GJ8259@pasky.or.cz>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27542>

As it is now, that array was never used because the customurl accessor was
broken and ''unless @url_list'' never happenned.
---

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f7e7d10..a357604 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -752,7 +752,7 @@ sub git_get_project_description {
 sub git_get_project_url_list {
 	my $path = shift;
 
-	open my $fd, "$projectroot/$path/cloneurl" or return undef;
+	open my $fd, "$projectroot/$path/cloneurl" or return;
 	my @git_project_url_list = map { chomp; $_ } <$fd>;
 	close $fd;
 
