From: Mark A Rada <marada@uwaterloo.ca>
Subject: [PATCH] git-instaweb: fix mod_perl detection for apache2
Date: Sat, 8 Aug 2009 18:24:02 -0400
Message-ID: <4C22ECF8-8FBE-4E45-A7CF-EA1203B49AA7@mailservices.uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 00:24:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZuKm-0000w1-Al
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 00:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbZHHWYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 18:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbZHHWYG
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 18:24:06 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:57400 "EHLO
	minos.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752133AbZHHWYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 18:24:05 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by minos.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n78MO2eg005812
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sat, 8 Aug 2009 18:24:05 -0400
X-Mailer: Apple Mail (2.936)
X-UUID: 7e3fc6e4-cabe-4ebe-b645-f7ca0d0fc13a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125309>

The script was looking for something that matched the '^our $gitbin'
regex, which no longer exists in gitweb.cgi.

Now it looks for 'MOD_PERL', which should be on the line that checks
to see if the script is running in a mod_perl environment.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
  git-instaweb.sh |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 32f6496..5f5cac7 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -278,7 +278,7 @@ EOF

  	# check to see if Dennis Stosberg's mod_perl compatibility patch
  	# (<20060621130708.Gcbc6e5c@leonov.stosberg.net>) has been applied
-	if test -f "$module_path/mod_perl.so" && grep '^our $gitbin' \
+	if test -f "$module_path/mod_perl.so" && grep 'MOD_PERL' \
  				"$GIT_DIR/gitweb/gitweb.cgi" >/dev/null
  	then
  		# favor mod_perl if available
-- 
1.6.4
