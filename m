From: Jakub Narebski <jnareb@gmail.com>
Subject: PATCH 1/4] gitweb: Add GIT favicon, assuming image/png type
Date: Mon, 4 Sep 2006 18:13:48 +0200
Message-ID: <200609041813.49103.jnareb@gmail.com>
References: <200609041810.09838.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 04 18:41:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKHVr-0003Qf-Pn
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 18:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWIDQl3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 12:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWIDQl3
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 12:41:29 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:6629 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751474AbWIDQg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 12:36:56 -0400
Received: by nz-out-0102.google.com with SMTP id n1so855128nzf
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 09:36:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=N3vq3Q3n7/+j8Z7xceitoVDF1JfOJeeeKxnZ8yyOgiHa7I0+41UeT00GZcPcqDgRAaW0lfeSyOTjhsiMq88qMDrMu55sI5ZmiBwq61j4k3fiPszb/owVBj8g+p2zGQUK3uQ2gLv5akOT0Mom2xOXikNCvyvJVKkHHFrG937em8c=
Received: by 10.65.43.17 with SMTP id v17mr5782665qbj;
        Mon, 04 Sep 2006 09:36:56 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id c5sm3859928qbc.2006.09.04.09.36.55;
        Mon, 04 Sep 2006 09:36:56 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609041810.09838.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26425>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is my first post with binary patch. I'd rather not send file
git-favicon.png as an attachement due to filtering.

You can see (and download) the favicon istelf at
  http://git.or.cz/gitwiki/GitRelatedLogos
(the first favicon).

 Makefile               |    2 ++
 gitweb/git-favicon.png |  Bin
 gitweb/gitweb.perl     |    5 +++++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 199fbe8..f3b762d 100644
--- a/Makefile
+++ b/Makefile
@@ -137,6 +137,7 @@ GITWEB_LIST =
 GITWEB_HOMETEXT = indextext.html
 GITWEB_CSS = gitweb.css
 GITWEB_LOGO = git-logo.png
+GITWEB_FAVICON = git-favicon.png
 
 export prefix bindir gitexecdir template_dir GIT_PYTHON_DIR
 
@@ -674,6 +675,7 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GITWEB_HOMETEXT++|$(GITWEB_HOMETEXT)|g' \
 	    -e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
 	    -e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \
+	    -e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
 	    $< >$@+
 	chmod +x $@+
 	mv $@+ $@
diff --git a/gitweb/git-favicon.png b/gitweb/git-favicon.png
new file mode 100644
index 0000000..de637c0
Binary files /dev/null and b/gitweb/git-favicon.png differ
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7961945..bebaa0f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -48,6 +48,8 @@ # URI of default stylesheet
 our $stylesheet = "++GITWEB_CSS++";
 # URI of GIT logo
 our $logo = "++GITWEB_LOGO++";
+# URI of GIT favicon, assumed to be image/png type
+our $favicon = "++GITWEB_FAVICON++";
 
 # source of projects list
 our $projects_list = "++GITWEB_LIST++";
@@ -1192,6 +1194,9 @@ EOF
 		       'href="%s" type="application/rss+xml"/>'."\n",
 		       esc_param($project), href(action=>"rss"));
 	}
+	if (defined $favicon) {
+		print qq(<link rel="shortcut icon" href="$favicon" type="image/png"/>\n);
+	}
 
 	print "</head>\n" .
 	      "<body>\n" .
-- 
1.4.1.1
