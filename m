From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/3] gitweb: Use light/dark class also in 'blame' view
Date: Mon, 13 Jul 2009 00:08:45 +0200
Message-ID: <200907130008.46168.jnareb@gmail.com>
References: <200907102354.43232.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 13 00:09:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ7ED-0002jb-2z
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 00:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbZGLWIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 18:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbZGLWIx
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 18:08:53 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:43926 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbZGLWIw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 18:08:52 -0400
Received: by mail-ew0-f226.google.com with SMTP id 26so2195008ewy.37
        for <git@vger.kernel.org>; Sun, 12 Jul 2009 15:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=tjmhaaStNYJUpbs4iB4s7F+QXsfkvEIa5tg+/531Xj0=;
        b=rtMdmzN23xP4eqTF/wQfLeEeTADxrQp9jNyedKIXli7zlx9rsiPdwk9j+ZiuBM0fil
         sAjgertzg/6BgFYVfloyalOq0hVdh+WanUtXf19vazovnWYPi4IDCAF51vSHRvBf3stu
         3/Wjgz4jSDlLZzW3oInqvamecLQZRwEqVVSg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=uUpIyln0LZEFrHiz2O7mzbJaKZe4+w8ahceXgZU0lznVGve+qQe7PYqrxBznxrkciL
         xuGWlxIiiv8jqBMIPO0gAE4sqzNeSp95glCk09N03g6Bhytt1bEzkRJs5Jlm5Mk7vw2f
         Ff0B7RrV/PpiomdJDFZc1AO25lG0toRynMks8=
Received: by 10.210.130.13 with SMTP id c13mr29865ebd.36.1247436531750;
        Sun, 12 Jul 2009 15:08:51 -0700 (PDT)
Received: from ?192.168.1.13? (abwk125.neoplus.adsl.tpnet.pl [83.8.234.125])
        by mx.google.com with ESMTPS id 5sm8211534eyh.50.2009.07.12.15.08.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Jul 2009 15:08:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200907102354.43232.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123165>

Instead of using "light2" and "dark2" for class names in 'blame' view
(in place of "light" and "dark" classes in other places) to avoid
changing style on hover in 'blame' view while doing it for other views
(like 'shortlog'), use more advanced CSS, relying on the fact that
more specific selector wins.

While at it add a few comments to gitweb CSS file, and consolidate
some repeated info.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is an RFC because 

1. I am not sure if I did it correctly.  I had to fiddle a bit with CSS
(using "table.blame .light:hover" in place of "table.blame tr.light:hover")
to get the same behaviour (well, the same as far as I have checked it).

2. Commit message could use improvements (single sentence, blergh).

 gitweb/gitweb.css  |   16 +++++++++-------
 gitweb/gitweb.perl |    2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 5e2f629..4e4f8aa 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -226,22 +226,24 @@ th {
 	text-align: left;
 }
 
-tr.light:hover {
-	background-color: #edece6;
-}
-
-tr.dark {
-	background-color: #f6f6f0;
+/* do not change row style on hover for 'blame' view */
+tr.light,
+table.blame .light:hover {
+	background-color: #ffffff;
 }
 
-tr.dark2 {
+tr.dark,
+table.blame .dark:hover {
 	background-color: #f6f6f0;
 }
 
+/* currently both use the same, but it can change */
+tr.light:hover,
 tr.dark:hover {
 	background-color: #edece6;
 }
 
+/* boundary commits in 'blame' view */
 tr.boundary td.sha1 {
 	font-weight: bold;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5336c92..bb7a5a9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4811,7 +4811,7 @@ sub git_blame {
 	git_print_page_path($file_name, $ftype, $hash_base);
 
 	# page body
-	my @rev_color = qw(light2 dark2);
+	my @rev_color = qw(light dark);
 	my $num_colors = scalar(@rev_color);
 	my $current_color = 0;
 	my %metainfo = ();
-- 
1.6.3.3
