From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] GIT-VERSION-GEN: Use git project-version.
Date: Sat, 05 Aug 2006 00:01:21 +0200
Message-ID: <87vep840um.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 05 00:01:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G97jT-0000Rw-Eb
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 00:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161512AbWHDWBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 18:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161513AbWHDWBY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 18:01:24 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:36048 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1161512AbWHDWBX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 18:01:23 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k74L1TB10856
	for <git@vger.kernel.org>; Fri, 4 Aug 2006 23:01:30 +0200
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24849>


---
Hi *,

There are two little behaviour changes:

1.- the -dirty suffix is converted to .dirty
2.- the version from the file version does not get the -dirty suffix.

 GIT-VERSION-GEN |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 1ce217d..99e35e1 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -3,9 +3,9 @@ #!/bin/sh
 GVF=GIT-VERSION-FILE
 DEF_VER=v1.4.2.GIT
 
-# First try git-describe, then see if there is a version file
+# First try git-project-version, then see if there is a version file
 # (included in release tarballs), then default
-if VN=$(git describe --abbrev=4 HEAD 2>/dev/null); then
+if VN=$(git project-version); then
 	VN=$(echo "$VN" | sed -e 's/-/./g');
 elif test -f version
 then
@@ -16,14 +16,6 @@ fi
 
 VN=$(expr "$VN" : v*'\(.*\)')
 
-dirty=$(sh -c 'git diff-index --name-only HEAD' 2>/dev/null) || dirty=
-case "$dirty" in
-'')
-	;;
-*)
-	VN="$VN-dirty" ;;
-esac
-
 if test -r $GVF
 then
 	VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)
-- 
1.4.2.rc3.g3f0a-dirty
