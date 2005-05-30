From: Jochen Roemling <jochen@roemling.net>
Subject: [gitweb PATCH] Kill warnings in Webserver Error Log
Date: Mon, 30 May 2005 21:34:44 +0200
Message-ID: <429B6AD4.9010107@roemling.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 21:37:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dcq38-0005NO-P9
	for gcvg-git@gmane.org; Mon, 30 May 2005 21:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVE3Th0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 15:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVE3TfX
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 15:35:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:1505 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261717AbVE3Ter (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 15:34:47 -0400
Received: from p54AAE721.dip.t-dialin.net [84.170.231.33] (helo=[10.3.24.50])
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0ML2Dk-1Dcq253XF7-0005io; Mon, 30 May 2005 21:34:41 +0200
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Kay Sievers <kay.sievers@vrfy.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:35bace2e8eeec41a1b9500b782c09cc4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The following patch kills two warnings in the Web Server Error Log:

[Mon May 30 21:24:15 2005] gitweb.cgi: "my" variable %co masks earlier 
declaration in same scope at /home/www/html/tools/cgi-bin/gitweb.cgi 
line 1658.
[Mon May 30 21:25:46 2005] gitweb.cgi: "my" variable %co masks earlier 
declaration in same scope at /home/www/html/tools/cgi-bin/gitweb.cgi 
line 1615.

There might be a patch offset of few lines because I deleted my local 
gitweb settings from the patch.

Signed-off-by: Jochen Roemling <jochen@roemling.net>

--- /cgi-bin/gitweb.cgi.2	2005-05-29 17:23:10.000000000 +0200
+++ cgi-bin/gitweb.cgi	2005-05-30 21:26:44.000000000 +0200
@@ -1616,7 +1618,7 @@
  		}
  		my @commit_lines = split "\n", $commit_text;
  		my $commit = shift @commit_lines;
-		my %co = git_read_commit($commit, \@commit_lines);
+		%co = git_read_commit($commit, \@commit_lines);
  		if (!%co) {
  			next;
  		}
@@ -1653,7 +1655,6 @@
  	$/ = "\n";
  	open $fd, "-|", "$gitbin/git-rev-list $hash | $gitbin/git-diff-tree 
-r --stdin -S$searchtext";
  	$alternate = 0;
-	my %co;
  	my @files;
  	while (my $line = <$fd>) {
  		if (%co && $line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) 
([0-9a-fA-F]{40}) (.)\t(.*)$/) {
