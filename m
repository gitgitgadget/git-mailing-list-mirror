From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 12/19] mingw: do not use symlinks with SVN in t9100
Date: Sun, 24 Jan 2016 16:45:04 +0100 (CET)
Message-ID: <f016fde3118f5028b7e589f36bc9c916464a9de9.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Karsten Blees <blees@dcon.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:45:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMqp-0001Is-9v
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbcAXPpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:45:11 -0500
Received: from mout.gmx.net ([212.227.15.15]:53410 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717AbcAXPpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:45:09 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LdIBN-1ZfTKC2v7R-00iRin; Sun, 24 Jan 2016 16:45:05
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:4Yw7xdcn3hBUBx8g+P1hwzkJcxdFeBIBBxOIepMdikkEzJdJCS9
 riChVShPzG/X5SW0qGOAJN1HPmSEt83yofsTaRcbE0oOVsN3UKT9fdHZpE7ODta3PsSlJgY
 n3mi4ekXkcZxdimIMA16b+vap/NAgEUUV9g27/AGPGujC4m9eGCcFAj28SLlE0YjrvbqBtA
 MKDnf2W+082xLIc0Tradw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UGtf3w+sHk0=:gyVc6kPyTL44v+L72ivGd4
 xqhGBY7JwqR2r5RVjwsx38WVHyQSyLP6YFTT34+4Bvx2nMD5s5PvAjivjymVyu8jQvrt1OMwl
 hWLH6x73NZKrdt85RiLWTtuF4SD12KJcgZBYmphHYVAJGf2h3MCWjf1tgBESlrM6LTxzX1JdH
 Q8kpytKqmYtEXLMCQ2IPED4AoDDJP3QhMtqLeR3cmxQkRarauAErTPLrDZe3uNXevJEdBHWLx
 QQ0I0zAFWPTOgCUs/kEtuI10YhyKi/ixubPZUTnXFtIiYdBYft996KLt/bSIWqalL8PzRTejP
 yGhJqIqv7CYqqACrMilIuYF/QGdn8ep7YNZOQbv6N3cSJUzPBgHueXGDwaeFRnhxieP/5JOKM
 6QRi9KJ/SOnUorlIWI+dzrWMd/pu8/Z6d+F/s2jLS0QgF/wWcQrOy24/AsZFyPdcFfSVYv3Np
 RkTBGLHhki2wCDPZNLL/87XLSmnG5k6a1gfq4Iob6x5GQbqcpmlMzAQXf10Z0Nyqfut2JzVHq
 2DuPjO8SkF0anUOQt6YeaZLJTuVj4t4K+RW3GvXzXFK3C0FBI9xJPNQRa64B3WBHk2lMCCBWq
 6TOwrxy7WazvEHcW+d7jOIgGevr5WBByDySOm/Cfh9vPRE/+NPJbl2R0gRKydNhs27K6997SO
 F7fg4O+6vZULOPYsld5odcuB3KSr2N1zZhfe5OnFyMLDsPAvT+xBI32HLFTGBJ+6ncl3PwwNP
 TGT5r7TYcgcDWJxcwQZuLyKWNdUrj0EUIz8VKR9W4l7+ioxdeWTA5ePl4XAMZwfxVP+au0Xi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284675>

From: Karsten Blees <blees@dcon.de>

The SVN library does not seem to support symlinks, even if symlinks are
enabled in MSYS2 and Git. Use 'cp' instead of 'ln -s'.

This partially fixes t/t9100-git-svn-basic.sh

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9100-git-svn-basic.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 258d9b8..dbb440b 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -25,7 +25,14 @@ test_expect_success \
 	(
 		cd import &&
 		echo foo >foo &&
-		ln -s foo foo.link
+		if test_have_prereq !MINGW
+		then
+			ln -s foo foo.link
+		else
+			# MSYS libsvn does not support symlinks, so always use cp, even if
+			# ln -s actually works
+			cp foo foo.link
+		fi
 		mkdir -p dir/a/b/c/d/e &&
 		echo "deep dir" >dir/a/b/c/d/e/file &&
 		mkdir bar &&
-- 
2.7.0.windows.1.7.g55a05c8
