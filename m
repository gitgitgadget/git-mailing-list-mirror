From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 04/14] lib-git-svn.sh: Add check for missing mod_dav_svn module
Date: Tue, 14 Dec 2010 18:23:54 +0000
Message-ID: <4D07B63A.2020501@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, normalperson@yhbt.net,
	avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 19:45:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSZsf-0004kc-DO
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 19:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757842Ab0LNSpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 13:45:36 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:52520 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757789Ab0LNSpe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 13:45:34 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PSZsT-0006ob-Wt; Tue, 14 Dec 2010 18:45:33 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163665>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/lib-git-svn.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 919d45a..154f3d3 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -101,6 +101,11 @@ start_httpd () {
 		echo >&2 'SVN_HTTPD_PORT is not defined!'
 		return
 	fi
+	if test ! -e "$SVN_HTTPD_MODULE_PATH/mod_dav_svn.so"
+	then
+		echo >&2 'Apache module "mod_dav_svn.so" not found'
+		return 1
+	fi
 	if test -z "$repo_base_path"
 	then
 		repo_base_path=svn
@@ -128,6 +133,7 @@ EOF
 
 stop_httpd () {
 	test -z "$SVN_HTTPD_PORT" && return
+	test ! -e "$GIT_DIR/httpd.conf" && return
 	"$SVN_HTTPD_PATH" -f "$GIT_DIR"/httpd.conf -k stop
 }
 
-- 
1.7.3
