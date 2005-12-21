From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] gqit: enable compiler warnings
Date: Tue, 20 Dec 2005 21:11:08 -0500
Message-ID: <1135131068.1183.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 21 03:12:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EotRj-0006Fm-W9
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 03:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVLUCLN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Dec 2005 21:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVLUCLM
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 21:11:12 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:43703 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932253AbVLUCLM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2005 21:11:12 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EotPi-0002Gq-CM
	for git@vger.kernel.org; Tue, 20 Dec 2005 21:09:10 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EotRc-0000Ji-6s; Tue, 20 Dec 2005 21:11:08 -0500
To: Marco Costalba <mcostalba@gmail.com>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13859>

The "-O2" flag should be separated from the threading support.  Besides,
it belongs to CCFLAGS (compile flags common to C and C++), not to
CPPFLAGS (preprocessor flags).  While at that, enable all warnings by
-Wall, except those about non-virtual destructors, which are "inherited"
from Qt.  Portability is not affected since -O2 was already
gcc-specific.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/SConstruct b/SConstruct
index 55fd206..b0b5d0f 100644
--- a/SConstruct
+++ b/SConstruct
@@ -27,8 +27,10 @@ env['ENV']['HOME'] = os.environ['HOME'] 
 
 installDir = env['HOME']+'/bin'
 
+env.Append( CCFLAGS = ['-O2', '-Wall' ,'-Wno-non-virtual-dtor'] )
+
 ## Uncomment the following if you need threading support threading
-env.Append( CPPFLAGS = ['-O2', '-DQT_THREAD_SUPPORT', '-D_REENTRANT', '-I/usr/include/qt3'] )
+env.Append( CPPFLAGS = ['-DQT_THREAD_SUPPORT', '-D_REENTRANT', '-I/usr/include/qt3'] )
 if os.uname()[0] == "FreeBSD":
 	env.Append(LINKFLAGS=["-pthread"])
 


-- 
Regards,
Pavel Roskin
