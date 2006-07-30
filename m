From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 14] gitweb: Remove $project from git_get_paging_nav arguments
Date: Sun, 30 Jul 2006 20:31:00 +0200
Message-ID: <200607302031.01937.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 30 20:31:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7G4T-0003M0-TU
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 20:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWG3SbA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 14:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWG3SbA
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 14:31:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:7050 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932417AbWG3Sa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 14:30:59 -0400
Received: by ug-out-1314.google.com with SMTP id m3so428490ugc
        for <git@vger.kernel.org>; Sun, 30 Jul 2006 11:30:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TbUSsDxeHL4uqhpEmcPn7o5Sm3gXourUISkQE2ra45Sh4bxiHx+yKTFigERb4P4EJqxdR9QhA2cajkcYNfyr6kMGxs00DTIqEGUC6SogtTdKTLeFNPyBY+D//fOnFynGXxpzcmk9HaW0VgggYdOKMRaZUvXT+KW6csqYLLyDV0g=
Received: by 10.66.224.3 with SMTP id w3mr1730244ugg;
        Sun, 30 Jul 2006 11:30:57 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id j1sm4343651ugf.2006.07.30.11.30.56;
        Sun, 30 Jul 2006 11:30:57 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24469>

Remove $project from arguments passed to git_get_paging_nav
subroutine: it did not depend only on arguments, using $my_uri global
variable (and now $project global variable).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.cgi |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 1befa7d..bfb01de 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -421,7 +421,7 @@ sub git_page_nav {
 }
 
 sub git_get_paging_nav {
-	my ($project, $action, $hash, $head, $page, $nrevs) = @_;
+	my ($action, $hash, $head, $page, $nrevs) = @_;
 	my $paging_nav;
 
 
@@ -1903,7 +1903,7 @@ sub git_log {
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
 
-	my $paging_nav = git_get_paging_nav($project, 'log', $hash, $head, $page, $#revlist);
+	my $paging_nav = git_get_paging_nav('log', $hash, $head, $page, $#revlist);
 
 	git_header_html();
 	git_page_nav('log','', $hash,undef,undef, $paging_nav);
@@ -2566,7 +2566,7 @@ sub git_shortlog {
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
 
-	my $paging_nav = git_get_paging_nav($project, 'shortlog', $hash, $head, $page, $#revlist);
+	my $paging_nav = git_get_paging_nav('shortlog', $hash, $head, $page, $#revlist);
 
 	git_header_html();
 	git_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
-- 
1.4.0
