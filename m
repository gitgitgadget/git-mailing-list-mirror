From: Sven Verdoolaege <skimo@liacs.nl>
Subject: [PATCH] gitweb: reset input record separator in parse_commit even on error
Date: Sat, 9 Sep 2006 17:12:36 +0200
Message-ID: <20060909151236.GA25518@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 17:12:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM4Vj-0000e6-4o
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 17:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWIIPMo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 11:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWIIPMo
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 11:12:44 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:29857 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S932252AbWIIPMn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 11:12:43 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id k89FCbIZ031205;
	Sat, 9 Sep 2006 17:12:42 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 064393C734; Sat,  9 Sep 2006 17:12:36 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26756>

---
This probably never happens, but just in case...

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7afdf33..60dd598 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -897,8 +897,8 @@ sub parse_commit {
 		my $fd = git_pipe("rev-list", "--header", "--parents", "--max-count=1", $commit_id)
 			or return;
 		@commit_lines = split '\n', <$fd>;
-		close $fd or return;
 		$/ = "\n";
+		close $fd or return;
 		pop @commit_lines;
 	}
 	my $header = shift @commit_lines;
-- 
0.99.8c.g64e8-dirty
