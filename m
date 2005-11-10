From: Frank Sorenson <frank@tuxrocks.com>
Subject: [PATCH] cg-log: add --no-merges option to be passed to git-rev-list
Date: Thu, 10 Nov 2005 13:46:30 -0700
Message-ID: <4373B1A6.8000706@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 10 21:49:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaJKo-0006wu-9n
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 21:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVKJUqq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 15:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVKJUqq
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 15:46:46 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:1033 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S932100AbVKJUql (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 15:46:41 -0500
Received: from [192.168.30.20] (obelix.cs.byu.edu [128.187.81.137])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id jAAKkUUn006606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Nov 2005 13:46:32 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
X-Enigmail-Version: 0.92.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11526>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch allows cg-log to ignore merges.

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

 cg-log |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/cg-log b/cg-log
index 7d955e3..2cebf04 100755
- --- a/cg-log
+++ b/cg-log
@@ -58,6 +58,9 @@
 #	by their author. This is also known as a "shortlog", suitable
 #	e.g. for contribution summaries of announcements.
 #
+# --no-merges::
+#	Don't display merges in the log.
+#
 # -uUSERNAME::
 #	List only commits where author or committer contains 'USERNAME'.
 #	The search for 'USERNAME' is case-insensitive.
@@ -255,6 +258,7 @@ user=
 mergebase=
 date_from=
 date_to=
+no_merges=

 while optparse; do
 	if optparse -c; then
@@ -300,6 +304,8 @@ while optparse; do
 		summary=1
 	elif optparse --summary; then
 		shortlog=1
+	elif optparse --no-merges; then
+		no_merges="--no-merges"
 	else
 		optfail
 	fi
@@ -315,9 +321,9 @@ if [ "$mergebase" ]; then
 fi

 if [ "$shortlog" ]; then
- -	revls="git-rev-list --pretty=short $date_from $date_to"
+	revls="git-rev-list --pretty=short $no_merges $date_from $date_to"
 else
- -	revls="git-rev-list --pretty=raw $date_from $date_to"
+	revls="git-rev-list --pretty=raw $no_merges $date_from $date_to"
 fi
 revls="$revls $date_from $date_to"


Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDc7GmaI0dwg4A47wRAosOAJ4k7ObTH9dc0me1SEGZFib0KsceqQCdHxX8
w7WXZzCR5dLKgyA0LV49YFU=
=6kA3
-----END PGP SIGNATURE-----
