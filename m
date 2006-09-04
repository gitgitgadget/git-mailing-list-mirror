From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/5] autoconf: Check for subprocess.py
Date: Tue, 5 Sep 2006 00:57:45 +0200
Message-ID: <200609050057.46030.jnareb@gmail.com>
References: <200609050054.24279.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 05 00:58:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKNOv-0007fJ-1C
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 00:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWIDW6h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 18:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWIDW6h
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 18:58:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:36119 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751419AbWIDW6d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 18:58:33 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1112904nfa
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 15:58:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FflA0EznkZzNWiWHF23GTh3kszxs5rU/BVVsXrD1e3xam5t8l459KPYKS6zg4gkhjDJyRHlhqkAa6SSErZZEIcT7MtBo/WxcHLHwH0QOirAqRC5ZWbhWVJ2d/Wuwgqlecndb8rHcdCp3bdN9CqckNrN5COPiF22hHL7szxaPdtw=
Received: by 10.49.75.2 with SMTP id c2mr7124433nfl;
        Mon, 04 Sep 2006 15:58:32 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id l38sm10135925nfc.2006.09.04.15.58.31;
        Mon, 04 Sep 2006 15:58:32 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609050054.24279.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26445>

Add custom test for checking if Python comes with subprocess.py, or
should we use our own subprocess.py by defining WITH_OWN_SUBPROCESS_PY.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Taken from Makefile.

Perhaps we would get rid of Python dependency soon.

 configure.ac |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 799321e..67a7aa9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -268,6 +268,16 @@ # Define NO_SYMLINK_HEAD if you never wa
 # Enable it on Windows.  By default, symrefs are still used.
 #
 # Define WITH_OWN_SUBPROCESS_PY if you want to use with python 2.3.
+AC_CACHE_CHECK(for subprocess.py,
+ ac_cv_python_has_subprocess_py,
+[if $PYTHON_PATH -c 'import subprocess' 2>/dev/null; then
+	ac_cv_python_has_subprocess_py=yes
+else
+	ac_cv_python_has_subprocess_py=no
+fi])
+if test $ac_cv_python_has_subprocess_py != yes; then
+	GIT_CONF_APPEND_LINE([WITH_OWN_SUBPROCESS_PY=YesPlease])
+fi
 #
 # Define NO_ACCURATE_DIFF if your diff program at least sometimes misses
 # a missing newline at the end of the file.
-- 
1.4.1.1
