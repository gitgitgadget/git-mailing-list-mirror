From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 7/7] gitweb: Always link to plain version of the blob in git_blob.
Date: Sat, 26 Aug 2006 19:14:26 +0200
Message-ID: <1156612467711-git-send-email-jnareb@gmail.com>
References: <1156612392716-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 26 19:14:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH1jy-0003zu-Om
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 19:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422861AbWHZROf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 13:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422879AbWHZROf
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 13:14:35 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:33414 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1422861AbWHZROd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 13:14:33 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7QHDGqR004457
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 Aug 2006 19:13:16 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7QHESeh032759;
	Sat, 26 Aug 2006 19:14:28 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7QHERix032758;
	Sat, 26 Aug 2006 19:14:27 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <1156612392716-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26054>

Link to plain version of the blob. even if no valid hash_base is given
in "blob" view (in git_blob).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f6175bb..02d327c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2461,8 +2461,13 @@ sub git_blob {
 		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	} else {
+		$formats_nav .=
+			$cgi->a({-href => href(action=>"blob_plain",
+			                       hash=>$hash, file_name=>$file_name)},
+			        "plain") .
+
 		print "<div class=\"page_nav\">\n" .
-		      "<br/><br/></div>\n" .
+		      "<br/>$formats_nav<br/></div>\n" .
 		      "<div class=\"title\">$hash</div>\n";
 	}
 	git_print_page_path($file_name, "blob", $hash_base);
-- 
1.4.1.1
