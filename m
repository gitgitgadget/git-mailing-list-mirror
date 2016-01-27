From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 02/20] mingw: do not trust MSYS2's MinGW gettext.sh
Date: Wed, 27 Jan 2016 17:19:12 +0100 (CET)
Message-ID: <a5d26716b9bfe9bb6c2be389b398b004bcdd0bb4.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:19:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSoX-0001uY-PM
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933567AbcA0QTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:19:21 -0500
Received: from mout.gmx.net ([212.227.15.18]:60530 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932256AbcA0QTT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:19:19 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lu874-1ZzT9T2wT8-011UJU; Wed, 27 Jan 2016 17:19:13
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:72ncqcZm1P7HscqH4dZdvStNunWESU51iCTIiIuzUqpBRK/oZaL
 +1tbroI7hVT3Q2piFsho8zTuIjp1ODrn6OvyVMMzEnSMVkpt4E/pbHUf/fhu7oMibwSSuO9
 Usbbnk/jsa50B0I0DBWy3jq0e1nn0L6u1M6k+qMUSGqL/ibY0fPw98XiSV7cGMmNmjrd2VN
 p3HpJTq7YNZnG476qH49w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QGa3eQUty7g=:P4YFRmz6422wSfuZy8cnog
 htwB+95V/uXqqappsJYlXDy/olmsTRYPpWZO2nHTpOwqtNF+SOXmWoJhEqfQ+nEKWo31k/E/Y
 FhoTOethuD5g2ecAUuWQnbmMMnsY0g+hpKQyGg3u7AIWbgUSRhQq6UISpofuTHn2PvTGeF0PO
 cKrCi9L4TjqcGRkFrEBO+1e1Y586ODFEOrIvq01Eg/0K/guyTneFA/LIouOTcvCAbqdchlFYD
 sM1UGj/wnlXHYtbY/KXc4ZHVR4FGOeCWvzYQVlwe6PagJJICJoFT/d5HIoqWzOyZTuHWycica
 Kta9Cs/mWje04XKiWHy8ZHFEiM3B9SLNBVPWzOkh4z/eWeotrIg26CnamJEZewccJDWX4P2x0
 4+21C8G5ClBYgLKDiRKj3iFQkXGmklnD31NIYj6pRi3yMdkgL7eydHdGqM4uJ0lSWU6I1bR7+
 tl3Pn1NVUYnrfAMcvMVHMOcc+X5tZ0NgY+MtBR4ma3okm+Nt/TuLW2C/eXI3sTY89JTdWy5iN
 IYFacJKH//wvSUWCHgTHvBjTEbWfWG82eJ8KyJSjNc53kDOflTkquQhCSe2EHJvQxFAQYWNis
 DxkCWREmhk/P4uvXK/X4KqgI4Wj+d01XV29CYw8Z5d9Ylsdvo97tPkNZxVjyZuqt/S+e1r8kl
 X30p09kkRAPcjauUQ9WE7X4VbFHwrX9OIImHBu53fthZyKxAqCf5WYvR/UK7rX/O6+NkP/Ro7
 504TuU3a8YdsPA3FtLtLsFwLOixr18fp0n9y1ip1fcV9vYowJbAFcNr1ptv6q3ZqWwaJ/Qfo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284922>

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
