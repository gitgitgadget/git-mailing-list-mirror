From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH ef/msys-imap] mingw: use BLK_SHA1 again
Date: Thu, 22 Oct 2009 20:26:29 +0200
Message-ID: <200910222026.29885.j6t@kdbg.org>
References: <1256144691-2908-1-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.0910221942150.1263@felix-maschine> <200910222011.02737.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com,
	"Erik Faye-Lund" <kusmabite@googlemail.com>, git@vger.kernel.org,
	"Erik Faye-Lund" <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Marius Storm-Olsen" <mstormo@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 22 20:26:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N12Mn-000302-71
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 20:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321AbZJVS0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 14:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756180AbZJVS0T
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 14:26:19 -0400
Received: from [93.83.142.38] ([93.83.142.38]:54690 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756102AbZJVS0S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 14:26:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id F188119F5F7;
	Thu, 22 Oct 2009 20:26:29 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <200910222011.02737.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131037>

Since NO_OPENSSL is no longer defined on Windows, BLK_SHA1 is not defined
anymore implicitly. Define it explicitly.

As a nice side-effect, we no longer link against libcrypto.dll, which has
non-trivial startup costs because it depends on 6 otherwise unneeded
DLLs.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
On Donnerstag, 22. Oktober 2009, Johannes Sixt wrote:
> ... and I have one more patch to be applied on top of the series.

Here it is. I haven't tested the MSVC aspect of the patch. I would
appreciate feedback in this regard.

-- Hannes

 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 5403fad..f666d2f 100644
--- a/Makefile
+++ b/Makefile
@@ -911,6 +911,7 @@ ifdef MSVC
 	NO_REGEX = YesPlease
 	NO_CURL = YesPlease
 	NO_PTHREADS = YesPlease
+	BLK_SHA1 = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
@@ -960,6 +961,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
+	BLK_SHA1 = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o
-- 
1.6.5.rc3.70.gfc1aa
