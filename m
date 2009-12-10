From: "John 'Warthog9' Hawley" <warthog9@kernel.org>
Subject: [PATCH 3/6] GITWEB - Add git:// link to summary pages
Date: Thu, 10 Dec 2009 23:45:40 +0000
Message-ID: <1260488743-25855-4-git-send-email-warthog9@kernel.org>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
 <1260488743-25855-2-git-send-email-warthog9@kernel.org>
 <1260488743-25855-3-git-send-email-warthog9@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.6.5.2"
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 11 00:47:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIsj4-0005nb-Da
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 00:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757663AbZLJXrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 18:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757543AbZLJXrD
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 18:47:03 -0500
Received: from hera.kernel.org ([140.211.167.34]:39934 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757287AbZLJXq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 18:46:59 -0500
Received: from hera.kernel.org (localhost [127.0.0.1])
	by hera.kernel.org (8.14.3/8.14.3) with ESMTP id nBANjudb025992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Dec 2009 23:45:56 GMT
Received: (from warthog9@localhost)
	by hera.kernel.org (8.14.3/8.14.2/Submit) id nBANjuuc025991;
	Thu, 10 Dec 2009 23:45:56 GMT
X-Mailer: git-send-email 1.6.5.5
In-Reply-To: <1260488743-25855-3-git-send-email-warthog9@kernel.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=AWL,BAYES_00,
	UNPARSEABLE_RELAY autolearn=ham version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135054>

From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

This is a multi-part message in MIME format.
--------------1.6.5.2
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This adds a git:// link to the summary pages should a common
$gitlinkurl be defined (default is nothing defined, thus nothing
shown)

This does make the assumption that the git trees share a common
path, and nothing to date is known to actually make use of the link

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/gitweb.perl |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)


--------------1.6.5.2
Content-Type: text/x-patch; name="0003-GITWEB-Add-git-link-to-summary-pages.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0003-GITWEB-Add-git-link-to-summary-pages.patch"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d84f4c0..7ad096c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -224,6 +224,10 @@ our %avatar_size = (
 # This is here to allow for missmatch git & gitweb versions
 our $missmatch_git = '';
 
+#This is here to deal with an extra link on the summary pages - if it's left blank
+# this link will not be shwon.  If it's set, this will be prepended to the repo and used
+our $gitlinkurl = '';
+
 # Used to set the maximum load that we will still respond to gitweb queries.
 # if we exceed this than we do the processing to figure out if there's a mirror
 # and redirect to it, or to just return 503 server busy
@@ -4454,6 +4458,10 @@ sub git_project_list_body {
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree") .
 		      ($pr->{'forks'} ? " | " . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '') .
+     		if( $gitlinkurl ne '' ){
+			print " | ". $cgi->a({-href => "git://$gitlinkurl/".esc_html($pr->{'path'})}, "git");
+		}
+		print "".
 		      "</td>\n" .
 		      "</tr>\n";
 	}

--------------1.6.5.2--
