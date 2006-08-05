From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 9/9] gitweb: Inline $rss_link
Date: Sat, 05 Aug 2006 13:18:58 +0200
Organization: At home
Message-ID: <eb1upn$8ti$5@sea.gmane.org>
References: <200608050036.06490.jnareb@gmail.com> <200608050038.20534.jnareb@gmail.com> <7vu04sghr0.fsf@assigned-by-dhcp.cox.net> <eb0oiu$sj1$1@sea.gmane.org> <44d47813.36251c31.2553.3cf7@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 05 13:20:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9KCZ-0003Bz-Uj
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 13:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161600AbWHELUN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 07:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161598AbWHELUM
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 07:20:12 -0400
Received: from main.gmane.org ([80.91.229.2]:60314 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161606AbWHELUL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 07:20:11 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1G9KCI-0003AL-44
	for git@vger.kernel.org; Sat, 05 Aug 2006 13:20:02 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 13:20:02 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 13:20:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24905>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Does anyone set $rss_link variable?

 gitweb/gitweb.perl |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2e1a2ba..57f7198 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -21,7 +21,6 @@ our $cgi = new CGI;
 our $version = "++GIT_VERSION++";
 our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
-our $rss_link = "";
 
 # core git executable to use
 # this can just be "git" if your webserver has a sensible PATH
@@ -97,8 +96,6 @@ if (defined $project && $project) {
        if (!(-e "$projectroot/$project/HEAD")) {
                die_error(undef, "No such project");
        }
-       $rss_link = "<link rel=\"alternate\" title=\"" . esc_param($project) . " log\" href=\"" .
-                   "$my_uri?" . esc_param("p=$project;a=rss") . "\" type=\"application/rss+xml\"/>";
        $ENV{'GIT_DIR'} = "$projectroot/$project";
 } else {
        git_project_list();
@@ -862,11 +859,13 @@ sub git_header_html {
 <meta name="robots" content="index, nofollow"/>
 <title>$title</title>
 <link rel="stylesheet" type="text/css" href="$stylesheet"/>
-$rss_link
-</head>
-<body>
 EOF
-       print "<div class=\"page_header\">\n" .
+       print "<link rel=\"alternate\" title=\"" . esc_param($project) . " log\" href=\"" .
+             "$my_uri?" . esc_param("p=$project;a=rss") . "\" type=\"application/rss+xml\"/>\n" .
+             "</head>\n";
+
+       print "<body>\n" .
+             "<div class=\"page_header\">\n" .
              "<a href=\"http://www.kernel.org/pub/software/scm/git/docs/\" title=\"git documentation\">" .
              "<img src=\"$logo\" width=\"72\" height=\"27\" alt=\"git\" style=\"float:right; border-width:0px;\"/>" .
              "</a>\n";
-- 
1.4.1.1
