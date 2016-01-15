From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/4] mingw: avoid redefining S_* constants
Date: Fri, 15 Jan 2016 14:24:29 +0100 (CET)
Message-ID: <0049b80c17e14722a217d208e0400975c4d0a024.1452864241.git.johannes.schindelin@gmx.de>
References: <cover.1452864241.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 14:25:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK4Mw-0003ar-3l
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 14:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbcAONYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 08:24:36 -0500
Received: from mout.gmx.net ([212.227.15.15]:59161 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161062AbcAONYf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 08:24:35 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LcBBl-1ZusV11JI5-00jVph; Fri, 15 Jan 2016 14:24:30
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452864241.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:OivT+QHKHxlp4KCHB+xVVdjbDDnxSGcfe8KjqaFAeJ3q88itcLv
 pFrCGy9H+EeYDpmH8Ot/d0vEPJFPnIQFhu0+mu+o956+3Kvq/iiy1ZQO7FDR9cbYKkFUP/n
 6Yt0T609g0AAUSGhBjNMnHPql1SaIUhH3s5ZfvVfWAmjH1opJTEdUp8uuhYoE90znfDno8U
 BzMO4iMIHdEg5IyKLCsRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N8c5t9xPWTA=:LYZT56B3GJ4uRm+mquyr0N
 IR8v3VlwxiA2k5ysY3GvSPby4DjmzVjnueCMN6Yi4pMIl6xgWPHrquwKLW4/mmpmG97Iwn/jH
 BYsXqm+3x02EbaCmtdktz+D6tkXi/4OrEgnot8tj+ecvoqfEebdyp4ndH5iPgBNCI+5cCjrzu
 YcGnO9m3jAgtlJMg4ty7hKR1ticf734AWTLnq25xS0hRlK0UooqIjYwd4kc6Ytt9INeu6f94d
 Dm7AnuCkoPIt3Ofvj0vwNsmO5urpkDSurckTDQPN9pO55XTYhQQeY0CUdDsgVvFMZFKIYMEcf
 XT2UmyP4aCxgYeYJW8nSvw64XW1QNqdJ9rxBgFXdxMjFFZnSejHoQ7V5OhLsNhO2ydvLpt/J6
 b3yiRj/VXelWWP7028UUJ/4tpy1oRJnldCKfnWiXUT81rTEcDvZumgXTFw1h9U7vW1pjECt/Z
 hVuuNsCid/bP0RA600IDF+3gR8baEQaprdDJ6LfR3IA0BUbrVQEKwXZbXD5izJrhOUtNuxGDg
 p0YwU4G0Ak53prQe+DwWjF1cmgmxLKGInTn64ptyjI/Elxq/0wGD6gDBkrwJYSgnLp27tyISP
 Shzeapb/+w6s2nIW5C2JziB5sZ99iJVSgvJTO3ZFv4zm0uDDRRtnDeeafnjyBykPEJkxvK7Yp
 QbrGJQ39KAC0GUvCeYRZBZzssxqvF8aT7MUACuDaSp1xW16ZJ1DEkj6e60QzjcCRYZlJaFIbP
 SKO9St3YRKwUh/IWZB5se9gUa1CxGODmiX7dm0+HdBMUMbIY0yxybv8lEPCOYOpMIWZib1DV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284167>

When compiling with MSys2's compiler, these constants are already defined.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index b3e5044..3a404ff 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -14,14 +14,18 @@ typedef int socklen_t;
 #define S_ISLNK(x) (((x) & S_IFMT) == S_IFLNK)
 #define S_ISSOCK(x) 0
 
+#ifndef S_IRWXG
 #define S_IRGRP 0
 #define S_IWGRP 0
 #define S_IXGRP 0
 #define S_IRWXG (S_IRGRP | S_IWGRP | S_IXGRP)
+#endif
+#ifndef S_IRWXO
 #define S_IROTH 0
 #define S_IWOTH 0
 #define S_IXOTH 0
 #define S_IRWXO (S_IROTH | S_IWOTH | S_IXOTH)
+#endif
 
 #define S_ISUID 0004000
 #define S_ISGID 0002000
-- 
2.7.0.windows.1.7.g55a05c8
