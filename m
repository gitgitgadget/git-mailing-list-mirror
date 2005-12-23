From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] qgit: allow overriding CCFLAGS
Date: Fri, 23 Dec 2005 18:23:46 -0500
Message-ID: <1135380226.18431.21.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 24 00:24:03 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpwGT-0007bF-63
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 00:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbVLWXXy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Dec 2005 18:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161132AbVLWXXy
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Dec 2005 18:23:54 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:8075 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1161129AbVLWXXx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2005 18:23:53 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EpwG8-0000jB-JT
	for git@vger.kernel.org; Fri, 23 Dec 2005 18:23:36 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EpwGI-00056m-9f; Fri, 23 Dec 2005 18:23:46 -0500
To: Marco Costalba <mcostalba@yahoo.it>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13998>

This patch allows overriding CCFLAGS by setting an environment variable
or an argument to make.

Signed-off-by: Pavel Roskin <proski@gnu.org>

---
If anyone knows Python and scons well, it would be great to have a more
generic solution that would use both environment and scons (not make)
command line to override several variables that users may want to
override, in particular CXX and installDir.  I cannot believe I'll need
any non-trivial coding to do something as common as this.

diff --git a/SConstruct b/SConstruct
index b0b5d0f..8ed151b 100644
--- a/SConstruct
+++ b/SConstruct
@@ -27,7 +27,7 @@ env['ENV']['HOME'] = os.environ['HOME'] 
 
 installDir = env['HOME']+'/bin'
 
-env.Append( CCFLAGS = ['-O2', '-Wall' ,'-Wno-non-virtual-dtor'] )
+env.Append( CCFLAGS = os.environ.get('CCFLAGS', ['-O2', '-Wall', '-Wno-non-virtual-dtor']) )
 
 ## Uncomment the following if you need threading support threading
 env.Append( CPPFLAGS = ['-DQT_THREAD_SUPPORT', '-D_REENTRANT', '-I/usr/include/qt3'] )


-- 
Regards,
Pavel Roskin
