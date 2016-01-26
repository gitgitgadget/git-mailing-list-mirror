From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 02/19] mingw: do not trust MSYS2's MinGW gettext.sh
Date: Tue, 26 Jan 2016 15:34:30 +0100 (CET)
Message-ID: <0511c0a72bddbdc6263ecd6fba2a8be23f59ff22.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:36:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4jL-0005Hb-Md
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966093AbcAZOgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:36:22 -0500
Received: from mout.gmx.net ([212.227.15.15]:60437 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966161AbcAZOeg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:34:36 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LikE1-1ZpZlF0kFp-00cv2Z; Tue, 26 Jan 2016 15:34:32
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:erJDbxz/+ZLUdVTzrApqgOtQ2rfPVRCMxr9pa4hkaHLOGYYBE/Z
 AAlbQYX2lDkv2g4Zfe91PIRbVWu/1dQigRdGI0r4ZL3S+w9L3Pn0isIHOccUrxzEOqKz+da
 MHbg+PiZuHzPVzba9gvRHJG3zjifsQJBIXPD46H1YE7ch1116T+SyV9+8qY7jd4y/dtz8Ua
 wOXPH8WjK+3Ob1AdWpRgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FYuuUNBcYP8=:8q6Ak51pR7OFn5sCgCzKv7
 HgJMsWb6mLLcynx9SKTtKsOcpzhHId+6iF21b7v8Ofv+6WrAd+72fXl0IABtDbWcXaXUCg4f/
 BiF3Rc3NiZmihuFPqKQaFvA4qK0lu4/1naRfzTpjIJ7jtyGzd+W5cPuK75HnIclhtTWBAewYP
 tPDOnDR8qCO0j5Eu4IOwNsuag3vCxkUMTqLnc/M2Cv9FIUnhdraGG+wOxALnlw66JwjfMRV8R
 gzZS80seFZR5oZRmKEOc9gIQNEWLtOU3f6OzkvYkwIMMeGlc3vb/isBeIkmjnnYxvzjxJMJNf
 BGHgCQhGUsrZ9pVSv26Dd2Hs/FPqSvbiA0lIdmd+lUmGZK9ulkKKckrZPIvteur/2nKaOuhGn
 MbDSWHscJVP+VFGaYWatZaOO4gHMiAy8kxrZpDWoDcq+OhEXz3U3Bv9bgPeo9TGWupEvlX8Dg
 TjLCd285bqx130J74FFB7qODtpTb7jaB1yP9OZoEtT1/evaLcuuEm5Ti7vA/T9Z8VO8IwF/KR
 Tt/YfxyLEpEIZQAGoPwAAdGS/oEbBMUK5eoOXRP4m/SivhM5ZqS/qUqQRpYb+NIAJte0UOQHE
 EVC8owdhS+J9bs00Z9hJd0ck1pCeSTO8f/lT3nXkHBaavL6UkBUbiAUfAxtJpat90B7R/oy0a
 UR6zc1+jd7yap/ZF7b7vCilX9bgtwtPbXrRCOsNvSf50MCqH+QlQsfhbTiit67bO3mwYGNT4e
 3EIqdNI7C+Sng2vSapL1K9T1B1ZRIIWiiv/e2P5ZKXFFyKwkAJib9TkkVjz4cMXTbW4P6FuO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284832>

It does not quite work because it produces DOS line endings which the
shell does not like at all.

This lets t0200-gettext-basic.sh, t0204-gettext-reencode-sanity.sh,
t3406-rebase-message.sh, t3903-stash.sh, t7400-submodule-basic.sh,
t7401-submodule-summary.sh, t7406-submodule-update.sh and
t7407-submodule-foreach.sh pass in Git for Windows' SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 6b25661..d6f7980 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -561,6 +561,7 @@ else
 		INTERNAL_QSORT = YesPlease
 		HAVE_LIBCHARSET_H = YesPlease
 		NO_GETTEXT =
+		USE_GETTEXT_SCHEME = fallthrough
 		USE_LIBPCRE= YesPlease
 		NO_CURL =
 		USE_NED_ALLOCATOR = YesPlease
-- 
2.7.0.windows.1.7.g55a05c8
