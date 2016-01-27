From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 15/20] Avoid absolute path in t0008
Date: Wed, 27 Jan 2016 17:20:03 +0100 (CET)
Message-ID: <76f9af37dd63413fad5b47635a6bd82c2f7e9011.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:20:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSpp-00034K-DT
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933970AbcA0QUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:20:38 -0500
Received: from mout.gmx.net ([212.227.17.20]:63886 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933634AbcA0QUc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:20:32 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MP1PX-1aUng30qLn-006KbG; Wed, 27 Jan 2016 17:20:04
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ubaK+omBf9pSbFT2EDUnRVYmYOYr2lBWyAqX4G4pgSpO5VzasBl
 D0D9U0TBTWsjd5tFmg4fecNHERvNEl68xp41NQanDKPXCdrkqRrXQ6G0i1JMR31PHc25O8N
 Dy8xc7ICkw1cTMC2TNAl/UkxaT+KU0ZZcOAsCwLb0CFbK7n8IEzuzGQDHLHBPWNvX4MqQ4b
 r9t5LbwqT80doI1y16YXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oJFM17o0zp4=:2af3KoZ+NJrsQQmRnSizTr
 rFHz3NdRwLuAmhOxFwIJlIaeuB+por+hP8hBsCfWFQLV+IGWK98b8vghns5HTrhSaHyhKpxXp
 Z1cIAHMvt9cwsb3dwTF2Dgj578AX+Z6RkOHsdhZ1z+GicnyDOgNtms08zeNhOcZsHDvOuhPUe
 fzpjpJVOYE8odlRh5dWInjOHrJSkin6L25oWXST8AMwNHpCaV71s9V8b4Jb/7k0ApznS+t6Rs
 oStfPs6xyTFqSEUr+C4cBPx3dTii0P9GaclhHSywPyUcRsPJvnAqZExj89UM8RifWJCri6Plv
 v8ashvyGmKtusI2MfseyDxDvTeTYySxipbd+qiIHnFMa9XoN9bQb0+cisOaHCcDr4BwAKjL8b
 +VPupH1HLLC7RbO2e+dLxrVbe4I96jt8DZq2uJNA4/IXk8+0y2zeilTmLf216pbBT79k6n2g+
 jwIuuZTskA86SXWt79OBXf0IesxjNLwiwxOawL2bTweFaV7sDQG6EZ0B9Z5xheDx7QPSCygmT
 3P2bujTVOsh7v6jV1Cb6Z7imwfTt+SdRppRbxr2EvtK+Rm49qNgp8g48k5/C4GdqEo2RdKeJp
 9SNsveacYRcFxeqK+LmzS581ov4yfp7XslbhKIumuPZRcRO8UIC0fzpE9OoC/6mET4V/g8Oq6
 EDhLAVdEDrlS3ekudMe9Ztas6X6j7EL4oFaobxnAi79kIwnJmQLjDcCziWhMUeLGZG/0J+54y
 b8v6BCR+noDBW7dV49ldZQOydnYMu2idZY321rNm4AgHZO36deRTx9c/zyzb+csL7TUdi69Y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284937>

From: Pat Thoyts <patthoyts@users.sourceforge.net>

The colon is used by check-ignore to separate paths from other output
values. If we use an absolute path, however, on Windows it will be
converted into a Windows path that very much contains a colon.

It is actually not at all necessary to make the path of the global
excludes absolute, so let's just not even do that.

Based on suggestions by Karsten Blees and Junio Hamano.

Suggested-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0008-ignores.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 4ef5ed4..89544dd 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -5,7 +5,7 @@ test_description=check-ignore
 . ./test-lib.sh
 
 init_vars () {
-	global_excludes="$(pwd)/global-excludes"
+	global_excludes="global-excludes"
 }
 
 enable_global_excludes () {
-- 
2.7.0.windows.1.7.g55a05c8
