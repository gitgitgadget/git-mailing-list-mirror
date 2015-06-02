From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/2] configure: add getdelim() check
Date: Tue,  2 Jun 2015 17:15:44 -0400
Message-ID: <1433279744-23379-3-git-send-email-sunshine@sunshineco.com>
References: <1433279744-23379-1-git-send-email-sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 23:16:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YztXu-0007zy-9a
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 23:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbbFBVQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 17:16:17 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36144 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbbFBVQF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 17:16:05 -0400
Received: by ieclw1 with SMTP id lw1so47911191iec.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 14:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GR/PtWMeoM34Mgw7WVkM7qRSZjo+mmCk+z246KzQGlk=;
        b=YB8kpQLP5SgmEkZ0Tei6Gcfbzg4XPxTLIV5dOtz249WHkevk4TXnRGTZ0utFIiPBDl
         4KCkRFFD+ajIhlgEw8zkWIj5bTUUkRI63YDC6Jhe3xW8q4kQvlP7mguU+fVPIu9nwvcQ
         2Z+CHWnbT5RsRx6ryAOf3dWJDZT9ydJ0vaoWA2MjHe6LunFN3A61X9ThUBM4uvyhwRhh
         ZbnXjJalc0Yp60G8/V9E+F31ZQn/jIGquTGksKdkhspWaMsl72xY9KobaiQVVS/tHRE/
         5NbMMRgLo24Y2XqrN7v3G1qMIprnvP7YsUNadzAhVKurVeMuD8LXHboHgJI9gMiEWw/F
         +MuQ==
X-Received: by 10.107.138.31 with SMTP id m31mr36301025iod.75.1433279764615;
        Tue, 02 Jun 2015 14:16:04 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id h128sm13302227ioh.38.2015.06.02.14.16.03
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 14:16:04 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.674.gb037150
In-Reply-To: <1433279744-23379-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270598>

As an optimization, strbuf will take advantage of getdelim() if
available, so add a configure check which defines HAVE_GETDELIM if
found.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 configure.ac | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configure.ac b/configure.ac
index bbdde85..14012fa 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1041,6 +1041,12 @@ GIT_CHECK_FUNC(initgroups,
 [NO_INITGROUPS=YesPlease])
 GIT_CONF_SUBST([NO_INITGROUPS])
 #
+# Define HAVE_GETDELIM if you have getdelim in the C library.
+GIT_CHECK_FUNC(getdelim,
+[HAVE_GETDELIM=YesPlease],
+[HAVE_GETDELIM=])
+GIT_CONF_SUBST([HAVE_GETDELIM])
+#
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
-- 
2.4.2.598.gb4379f4
