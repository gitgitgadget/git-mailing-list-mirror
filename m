From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Move gitweb style to gitweb.css
Date: Sun, 18 Jun 2006 06:32:40 +0200
Organization: At home
Message-ID: <e72l0s$6d0$1@sea.gmane.org>
References: <200606171123.56643.jnareb@gmail.com> <7vhd2j5hi2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Jun 18 06:32:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Froxu-0006Zf-Bq
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 06:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWFREcp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 00:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWFREcp
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 00:32:45 -0400
Received: from main.gmane.org ([80.91.229.2]:23008 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932084AbWFREco (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 00:32:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Froxk-0006YO-Mw
	for git@vger.kernel.org; Sun, 18 Jun 2006 06:32:40 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 06:32:40 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 06:32:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22050>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Move gitweb style from embedded <style> element in gitweb/gitweb.cgi
>> to external CSS file gitweb/gitweb.css.
>>
>> ---
>> External CSS file can be downloaded only once and cached.
> 
> That's good, but I'm wondering if you dropped this deliberately
> or it was just an accident.
> 
>> -body {
>> -    font-family: sans-serif; font-size: 12px; border:solid #d9d8d1; border-width:1px;
>> -    margin:10px; background-color:#ffffff; color:#000000;
>> -}

Ooops. Amended commit follows.

Note: this patch is of temporary use, as I plan to merge xmms2 additions 
to gitweb, which include separate CSS file too.

-- >8 --
From nobody Mon Sep 17 00:00:00 2001
From: Jakub Narebski <jnareb@gmail.com>
Date: Sat Jun 17 11:15:18 2006 +0200
Subject: [PATCH] Move gitweb style to gitweb.css

Move gitweb style from embedded <style> element in gitweb/gitweb.cgi
to external CSS file gitweb/gitweb.css. Introduced new configuration
variable $stylesheet.

---

 gitweb/gitweb.cgi |   64 +++--------------------------------------------------
 gitweb/gitweb.css |   58 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 60 deletions(-)
 create mode 100644 gitweb/gitweb.css

42b89d8cbc6bdfed33df7bdadf45a3254cf8f1ae
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index ea21fbe..9d902b7 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -38,6 +38,9 @@ my $home_link =               $my_uri;
 # html text to include at home page
 my $home_text =                "indextext.html";
 
+# URI of default stylesheet
+my $stylesheet =       "gitweb.css";
+
 # source of projects list
 #my $projects_list =   $projectroot;
 my $projects_list =    "index/index.aux";
@@ -257,68 +260,9 @@ sub git_header_html {
 <head>
 <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
 <meta name="robots" content="index, nofollow"/>
+<link rel="stylesheet" href="$stylesheet"/> 
 <title>$title</title>
 $rss_link
-<style type="text/css">
-body {
-       font-family: sans-serif; font-size: 12px; border:solid #d9d8d1; border-width:1px;
-       margin:10px; background-color:#ffffff; color:#000000;
-}
-a { color:#0000cc; }
-a:hover, a:visited, a:active { color:#880000; }
-div.page_header { height:25px; padding:8px; font-size:18px; font-weight:bold; background-color:#d9d8d1; }
-div.page_header a:visited, a.header { color:#0000cc; }
-div.page_header a:hover { color:#880000; }
-div.page_nav { padding:8px; }
-div.page_nav a:visited { color:#0000cc; }
-div.page_path { padding:8px; border:solid #d9d8d1; border-width:0px 0px 1px}
-div.page_footer { height:17px; padding:4px 8px; background-color: #d9d8d1; }
-div.page_footer_text { float:left; color:#555555; font-style:italic; }
-div.page_body { padding:8px; }
-div.title, a.title {
-       display:block; padding:6px 8px;
-       font-weight:bold; background-color:#edece6; text-decoration:none; color:#000000;
-}
-a.title:hover { background-color: #d9d8d1; }
-div.title_text { padding:6px 0px; border: solid #d9d8d1; border-width:0px 0px 1px; }
-div.log_body { padding:8px 8px 8px 150px; }
-span.age { position:relative; float:left; width:142px; font-style:italic; }
-div.log_link {
-       padding:0px 8px;
-       font-size:10px; font-family:sans-serif; font-style:normal;
-       position:relative; float:left; width:136px;
-}
-div.list_head { padding:6px 8px 4px; border:solid #d9d8d1; border-width:1px 0px 0px; font-style:italic; }
-a.list { text-decoration:none; color:#000000; }
-a.list:hover { text-decoration:underline; color:#880000; }
-a.text { text-decoration:none; color:#0000cc; }
-a.text:visited { text-decoration:none; color:#880000; }
-a.text:hover { text-decoration:underline; color:#880000; }
-table { padding:8px 4px; }
-th { padding:2px 5px; font-size:12px; text-align:left; }
-tr.light:hover { background-color:#edece6; }
-tr.dark { background-color:#f6f6f0; }
-tr.dark:hover { background-color:#edece6; }
-td { padding:2px 5px; font-size:12px; vertical-align:top; }
-td.link { padding:2px 5px; font-family:sans-serif; font-size:10px; }
-div.pre { font-family:monospace; font-size:12px; white-space:pre; }
-div.diff_info { font-family:monospace; color:#000099; background-color:#edece6; font-style:italic; }
-div.index_include { border:solid #d9d8d1; border-width:0px 0px 1px; padding:12px 8px; }
-div.search { margin:4px 8px; position:absolute; top:56px; right:12px }
-a.linenr { color:#999999; text-decoration:none }
-a.rss_logo {
-       float:right; padding:3px 0px; width:35px; line-height:10px;
-       border:1px solid; border-color:#fcc7a5 #7d3302 #3e1a01 #ff954e;
-       color:#ffffff; background-color:#ff6600;
-       font-weight:bold; font-family:sans-serif; font-size:10px;
-       text-align:center; text-decoration:none;
-}
-a.rss_logo:hover { background-color:#ee5500; }
-span.tag {
-       padding:0px 4px; font-size:10px; font-weight:normal;
-       background-color:#ffffaa; border:1px solid; border-color:#ffffcc #ffee00 #ffee00 #ffffcc;
-}
-</style>
 </head>
 <body>
 EOF
diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
new file mode 100644
index 0000000..5900916
--- /dev/null
+++ b/gitweb/gitweb.css
@@ -0,0 +1,58 @@
+body {
+       font-family: sans-serif; font-size: 12px; border:solid #d9d8d1; border-width:1px;
+       margin:10px; background-color:#ffffff; color:#000000;
+}
+a { color:#0000cc; }
+a:hover, a:visited, a:active { color:#880000; }
+div.page_header { height:25px; padding:8px; font-size:18px; font-weight:bold; background-color:#d9d8d1; }
+div.page_header a:visited, a.header { color:#0000cc; }
+div.page_header a:hover { color:#880000; }
+div.page_nav { padding:8px; }
+div.page_nav a:visited { color:#0000cc; }
+div.page_path { padding:8px; border:solid #d9d8d1; border-width:0px 0px 1px}
+div.page_footer { height:17px; padding:4px 8px; background-color: #d9d8d1; }
+div.page_footer_text { float:left; color:#555555; font-style:italic; }
+div.page_body { padding:8px; }
+div.title, a.title {
+       display:block; padding:6px 8px;
+       font-weight:bold; background-color:#edece6; text-decoration:none; color:#000000;
+}
+a.title:hover { background-color: #d9d8d1; }
+div.title_text { padding:6px 0px; border: solid #d9d8d1; border-width:0px 0px 1px; }
+div.log_body { padding:8px 8px 8px 150px; }
+span.age { position:relative; float:left; width:142px; font-style:italic; }
+div.log_link {
+       padding:0px 8px;
+       font-size:10px; font-family:sans-serif; font-style:normal;
+       position:relative; float:left; width:136px;
+}
+div.list_head { padding:6px 8px 4px; border:solid #d9d8d1; border-width:1px 0px 0px; font-style:italic; }
+a.list { text-decoration:none; color:#000000; }
+a.list:hover { text-decoration:underline; color:#880000; }
+a.text { text-decoration:none; color:#0000cc; }
+a.text:visited { text-decoration:none; color:#880000; }
+a.text:hover { text-decoration:underline; color:#880000; }
+table { padding:8px 4px; }
+th { padding:2px 5px; font-size:12px; text-align:left; }
+tr.light:hover { background-color:#edece6; }
+tr.dark { background-color:#f6f6f0; }
+tr.dark:hover { background-color:#edece6; }
+td { padding:2px 5px; font-size:12px; vertical-align:top; }
+td.link { padding:2px 5px; font-family:sans-serif; font-size:10px; }
+div.pre { font-family:monospace; font-size:12px; white-space:pre; }
+div.diff_info { font-family:monospace; color:#000099; background-color:#edece6; font-style:italic; }
+div.index_include { border:solid #d9d8d1; border-width:0px 0px 1px; padding:12px 8px; }
+div.search { margin:4px 8px; position:absolute; top:56px; right:12px }
+a.linenr { color:#999999; text-decoration:none }
+a.rss_logo {
+       float:right; padding:3px 0px; width:35px; line-height:10px;
+       border:1px solid; border-color:#fcc7a5 #7d3302 #3e1a01 #ff954e;
+       color:#ffffff; background-color:#ff6600;
+       font-weight:bold; font-family:sans-serif; font-size:10px;
+       text-align:center; text-decoration:none;
+}
+a.rss_logo:hover { background-color:#ee5500; }
+span.tag {
+       padding:0px 4px; font-size:10px; font-weight:normal;
+       background-color:#ffffaa; border:1px solid; border-color:#ffffcc #ffee00 #ffee00 #ffffcc;
+}
-- 
1.3.0
