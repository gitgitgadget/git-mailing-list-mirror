From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: [PATCH 2/2] Ignore trailing slash in mkdir() on platforms that can't deal with this
Date: Fri, 24 Aug 2012 12:32:12 +0200
Message-ID: <003201cd81e3$b9c1af50$2d450df0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 12:32:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4rBn-0004Ov-FG
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 12:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757709Ab2HXKcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 06:32:25 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:65033 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab2HXKcX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 06:32:23 -0400
Received: from DualCore (dsdf-4db5d8d2.pool.mediaWays.net [77.181.216.210])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MWxmu-1T86qY0n2q-00W1HR; Fri, 24 Aug 2012 12:32:22 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2B45ptu3opA/oRTeKMkcMRoPVevw==
Content-Language: de
X-Provags-ID: V02:K0:kqhmhqu1sNbemYKjnTr229VCSBhkdiK2aAofL/qHqBB
 76Ie79d5R1n2xdSv4zJUmwp3Da+bJxBKKae0k6nXn15036tkkW
 ZeTsG+Aci4pkoon7VSms8+vMdhBganUjaGgjNjCN+4Jbr+p64k
 T/fT4cRTMScS6+yYW/gS50CmROXvK4FLoO0poqVPWjTpYvusam
 KgfRbQKcQOwVqZ3DkkmHIiVD43XtXfXKRYTHB9n0nWH6k1X4bB
 3KFE/bRxp0n58lYLKLss8T3+IQL9hglXfHTDE/vm6Xt/TLFEa4
 2ULsfaX3vONthYRPdY5P/CGDhlEAtmB9Q1vtZudJ9pcDW8xj8Y
 qwIOf9Uf0ga51ZjC0mmbZJtFyTuLcXIwN5YPGOs0XtyQe2Kkok
 rbZ5UUTjkZ0TQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204201>


Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 git-compat-util.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 35b095e..34f040f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -162,6 +162,11 @@
 #define probe_utf8_pathname_composition(a,b)
 #endif
 
+#ifdef MKDIR_WO_TRAILING_SLASH
+#define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
+extern int compat_mkdir_wo_trailing_slash(const char*, mode_t);
+#endif
+
 #ifndef NO_LIBGEN_H
 #include <libgen.h>
 #else
-- 
1.7.12
