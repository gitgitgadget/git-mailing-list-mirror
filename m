From: Stefan Sperling <stsp@stsp.name>
Subject: [PATCH] Include headers for getrlimit() in sha1_file.c
Date: Wed, 16 Mar 2011 11:37:59 +0100
Message-ID: <1300271879-2050-1-git-send-email-stsp@stsp.name>
Cc: Stefan Sperling <stsp@stsp.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 11:39:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzo86-0002Fr-B6
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 11:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602Ab1CPKih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 06:38:37 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58550 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521Ab1CPKic (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 06:38:32 -0400
X-Envelope-From: stsp@stsp.name
Received: from jack.stsp.name (jack.stsp.name [217.197.84.35])
	(authenticated bits=128)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p2GAcS2h000965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 16 Mar 2011 11:38:30 +0100
Received: from jack.stsp.name (stsp@localhost [127.0.0.1])
	by jack.stsp.name (8.14.3/8.14.3) with ESMTP id p2GAcSMq005197;
	Wed, 16 Mar 2011 11:38:28 +0100 (CET)
Received: (from stsp@localhost)
	by jack.stsp.name (8.14.3/8.14.3/Submit) id p2GAcRZV029182;
	Wed, 16 Mar 2011 11:38:27 +0100 (CET)
X-Mailer: git-send-email 1.7.3.5
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169132>

Fixes compilation error on OpenBSD:
sha1_file.c: In function 'open_packed_git_1':
sha1_file.c:718: error: storage size of 'lim' isn't known
sha1_file.c:721: warning: implicit declaration of function 'getrlimit'
sha1_file.c:721: error: 'RLIMIT_NOFILE' undeclared (first use in this function)
sha1_file.c:718: warning: unused variable 'lim'

Signed-off-by: Stefan Sperling <stsp@stsp.name>
---
 sha1_file.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index b4fcca8..f969b10 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -18,6 +18,10 @@
 #include "pack-revindex.h"
 #include "sha1-lookup.h"
 
+#include <sys/types.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
 #define O_NOATIME 01000000
-- 
1.7.3.5
