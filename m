From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Fix @git_base_url_list usage
Date: Wed, 20 Sep 2006 02:09:46 +0200
Message-ID: <20060920000946.GC13132@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=fixed
X-From: git-owner@vger.kernel.org Wed Sep 20 02:10:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPpex-0001Zt-3m
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 02:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbWITAJs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 20:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWITAJs
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 20:09:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26265 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750699AbWITAJr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 20:09:47 -0400
Received: (qmail 825 invoked by uid 2001); 20 Sep 2006 02:09:46 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27317>

As it is now, that array was never used because the customurl accessor was
broken and ''unless @url_list'' never happenned.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2d0d56f..1b029ac 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -731,7 +731,7 @@ sub git_get_project_description {
 sub git_get_project_url_list {
 	my $path = shift;
 
-	open my $fd, "$projectroot/$path/cloneurl" or return undef;
+	open my $fd, "$projectroot/$path/cloneurl" or return wantarray ? () : undef;
 	my @git_project_url_list = map { chomp; $_ } <$fd>;
 	close $fd;
 
