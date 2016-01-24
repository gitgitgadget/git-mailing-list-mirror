From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 01/19] mingw: let's use gettext with MSYS2
Date: Sun, 24 Jan 2016 16:43:13 +0100 (CET)
Message-ID: <7162dcb55e6a317cba840ef1176d09d99fc37f6b.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:44:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMpc-0000ZT-HO
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbcAXPny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:43:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:63670 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450AbcAXPnW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:43:22 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lr46Z-1ZtEzg2V8t-00eadn; Sun, 24 Jan 2016 16:43:15
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:7HJu5yi7oRD7Ed3A+vJues/+SR3niuPdwxStsEi1vwhVlPeG+Od
 cyZcWZwfbvN9S0w3/hJ5Z8rj0GASMEF3kBdwyFI2/wOhve/fAQ5jCu7eG1XXr72YOWxRNev
 mm0uuQe0/UYRWDPRhAWSXNN1lUXGlAJZ02Ah//zDdHvMNV+Q8byZY+WWHp291/vA8Iuh6aC
 lD2HfnfnF9JWkAb9Fg3Zw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0ZjijBNBqT8=:FdkE23atiosjG/2xW6r161
 7sttQT1Dj9jmKr0mAIZXRBkeaL7TSSlKpXtHZp2JUnXKtKAkYwG2FI12ZZSlY+SOwnOdGqLqj
 kLxQ9Uy7qHLlJt68qTVu+vbDIX97fDGnZmGxf3/YsuoKXQBRvz+Uk9uqLk5pEy0mzQw1tq8us
 xVEey+N04zVY72nZYwGMkBmyB8FMHmg7sDXdtPIwCgFIyPo5gIpnKWMJjMJX75n5oY87boUBd
 skGY1NxS+IeimjKdV9JurhmYbY1hzDnX0as53VABbrjA6WShwJYbVZMiyHw7zTEfo1vUNG57k
 fmO3WOqe6unTKfEtpRRY9vRN70CFZdeq+Mpk3JTxnYSf4UxXCe8BfMFMdpnFapDvencQFZcnS
 W/TL2pdgNCdLQKgjeJTINhsjbZDaNp4PztnpEJvdHNCly/kMWbM81UTXG4yjbqHF9TkKxVGm3
 nRxuEpnP00exzaB8/AsIYGWheWi4xC3TqB/iHT+OFEuseTYzv2ZlQS4Nh+3Kc17tcaCRZ6bJj
 v2FK86rzWxsI3+GHJCydJVqyH/0F74fwyfHGcOHP0s0tgoBIeD7L8j1bkhZFI+08gxnOXlRTI
 pOpSpXq5eM+6HO0iDQ87cTQkT6RPw6EJWzirjBmvQQRhwi/fRFcICo7rfFrU1iXk1D9QkVgoL
 uvKTfzm2L5BjH+LcNO4Bi95Q9pXVOrIuUMqt3NPpGP11WVJLpuQGItxrl50wdBUmq1e1SDZKF
 o8eOiG2P0Ge3yJOZWYcUVza8gWsrE+nB4u69sNrtMBwG0sF9FvnsPCSlftFz2UcTcHmd0271 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284667>

This solves two problems:

- we now have proper localisation even on Windows

- we sidestep the infamous "BUG: your vsnprintf is broken (returned -1)"
  message when running "git init" (which otherwise prevents the entire
  test suite from running)

The latter issue is rather crucial, as *no* test passes in Git for
Windows without this fix.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 4b2e1b8..6b25661 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -560,7 +560,7 @@ else
 		NO_R_TO_GCC_LINKER = YesPlease
 		INTERNAL_QSORT = YesPlease
 		HAVE_LIBCHARSET_H = YesPlease
-		NO_GETTEXT = YesPlease
+		NO_GETTEXT =
 		USE_LIBPCRE= YesPlease
 		NO_CURL =
 		USE_NED_ALLOCATOR = YesPlease
-- 
2.7.0.windows.1.7.g55a05c8
