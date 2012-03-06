From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH 2/2] Disambiguate PREFIX define in sideband.c
Date: Tue,  6 Mar 2012 09:54:37 +0100
Message-ID: <1331024077-5736-2-git-send-email-user@vincent-VirtualBox>
References: <1331024077-5736-1-git-send-email-user@vincent-VirtualBox>
Mime-Version: 1.0
Cc: gitster@pobox.com, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 09:55:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4qB2-0007mT-9M
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 09:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758846Ab2CFIzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 03:55:08 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:35724 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758844Ab2CFIzH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 03:55:07 -0500
Received: by eekc41 with SMTP id c41so1798766eek.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 00:55:06 -0800 (PST)
Received-SPF: pass (google.com: domain of  designates 10.14.184.194 as permitted sender) client-ip=10.14.184.194;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of  designates 10.14.184.194 as permitted sender) smtp.mail=
Received: from mr.google.com ([10.14.184.194])
        by 10.14.184.194 with SMTP id s42mr12749830eem.54.1331024106539 (num_hops = 1);
        Tue, 06 Mar 2012 00:55:06 -0800 (PST)
Received: by 10.14.184.194 with SMTP id s42mr9692935eem.54.1331024106422;
        Tue, 06 Mar 2012 00:55:06 -0800 (PST)
Received: from localhost.localdomain (wlan-145-94-169-074.wlan.tudelft.nl. [145.94.169.74])
        by mx.google.com with ESMTPS id y11sm10939264eem.3.2012.03.06.00.55.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 00:55:06 -0800 (PST)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1331024077-5736-1-git-send-email-user@vincent-VirtualBox>
X-Gm-Message-State: ALoCoQlhA1rur73Zt1zormwcuHU2Tit0OBCtvZ/w/T91Hy5RTYu0E9eZTLE5hueq9BKTea3S99ex
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192317>

From: Vincent van Ravesteijn <vfr@lyx.org>

PREFIX is already used as the prefix for the system path in system_path(..)
in exec_cmd.c. If PREFIX has been set, this patch prevents a warning that
PREFIX is being redefined.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 sideband.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sideband.c b/sideband.c
index d5ffa1c..7c38fcb 100644
--- a/sideband.c
+++ b/sideband.c
@@ -12,7 +12,7 @@
  * the remote died unexpectedly.  A flush() concludes the stream.
  */
 
-#define PREFIX "remote:"
+#define SIDEBAND_PREFIX "remote:"
 
 #define ANSI_SUFFIX "\033[K"
 #define DUMB_SUFFIX "        "
@@ -21,13 +21,13 @@
 
 int recv_sideband(const char *me, int in_stream, int out)
 {
-	unsigned pf = strlen(PREFIX);
+	unsigned pf = strlen(SIDEBAND_PREFIX);
 	unsigned sf;
 	char buf[LARGE_PACKET_MAX + 2*FIX_SIZE];
 	char *suffix, *term;
 	int skip_pf = 0;
 
-	memcpy(buf, PREFIX, pf);
+	memcpy(buf, SIDEBAND_PREFIX, pf);
 	term = getenv("TERM");
 	if (term && strcmp(term, "dumb"))
 		suffix = ANSI_SUFFIX;
-- 
1.7.5.4
