From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 15/19] Avoid absolute path in t0008
Date: Tue, 26 Jan 2016 15:35:26 +0100 (CET)
Message-ID: <1d1dd22a4441f31b88531493001a5042710bf106.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:35:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4ii-0004vz-3w
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966134AbcAZOfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:35:44 -0500
Received: from mout.gmx.net ([212.227.15.19]:50706 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966116AbcAZOfj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:35:39 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MTSKd-1aV3Gq1dv5-00SSAR; Tue, 26 Jan 2016 15:35:27
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:JOswfrLJL8hBuIJihAQdCgcnlGm8YTMJKYH+MmfJwinNDBdJvgH
 eAjkxaiv46h4xy1MMGi2ArjtOLIyowa/XtT8phhuelbtfbTnLQ04o616x6IeiqRpLRbxUUF
 +N71lcg04Aj/piG987e65MkaNQJy063IbBYjuj//RqDKDI7uUWQrcK3mrBA669CJXnstWbc
 Ep9M/mlOp5+SwHUoZayUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qlpdVtiXq4Q=:XgqNE0q3ALZqHNxFMyJBoF
 LGkOniJ4BdVQkdOP8um3Z40eL/d3f9dSihHuIIyHCjTgWBPe/DpxOr5ZXGdJhGeHYfU6nSVTX
 r6Bb2NgSGcgXZ1cgdZV7niPbFA8i6axRID8g6ZBteol8P6wULDPLaMq8aJYMUEiNql2nC6fbT
 04huABMYeP0FhVxr1focl8omOOLBT4r+VaxPzTPOR+fBYcdS0MOT+rHKUuBNByphqXKI2KXQv
 EFXT1Pmn5p0Nc0/Z0TFjz5pPRMH6eESYrBBMs7Jz/0J9pKMhT6uytJivuc3CFCWm/xT/VccVR
 VCKm10jMLSbIOEO4mCwrFR7d2cIGqj4UE8CLbaYZ+Ku6QIbS6Ftuf6MWD12LBfc2gucW9sYkU
 gEGB8sM3zmU0iKzfihcAx+6BSrE/p7DOXi27gzJ1Cii/mpr3sQNDIG9JcpHm7s2tE/4jdq0xE
 z4JZYARhlyd+o/bR28nox0lnhpPNjwrTSfRCLmYAfebl9VTK0XWo+77IX+ts7p1ftyL+LHF/u
 NXk9bHIxDRFomiggTV/8PQLMC1fXRVNDfGMsSJkPUuMmC97pf5tRKvNvfXAev7HcWhvDKVCJ0
 NRC55bO9slCZngbPRakE0DAB4WpPDnM9VoYSEj3XQOiQ3d44YB+JykHkP9Hb0fIt8RwOsBrky
 9y83F9SzLiuGYQ0OzW7X5nT+IuRutS1K9+C02ivtfRhkoq/oU+pTs3rmvMBiJCKpm++sBiEFY
 sl0XTHSZRAoE2u+xXSotVArqn04IZc3NwzBijJIheRn2cywKt4GLa6fjSSzGxgEpHoPUF6eh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284825>

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
