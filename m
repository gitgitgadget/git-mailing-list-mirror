From: Benoit Sigoure <tsunanet@gmail.com>
Subject: [PATCH] Undefine strlcpy if needed.
Date: Sat, 23 Aug 2014 21:35:30 -0700
Message-ID: <1408854930-14322-1-git-send-email-tsunanet@gmail.com>
References: <1408854741-13956-1-git-send-email-tsunanet@gmail.com>
Cc: Benoit Sigoure <tsunanet@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 06:36:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLPXx-0008J0-Vc
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 06:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbaHXEgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 00:36:50 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36597 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbaHXEgt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 00:36:49 -0400
Received: by mail-qg0-f46.google.com with SMTP id z60so8283718qgd.5
        for <git@vger.kernel.org>; Sat, 23 Aug 2014 21:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TExsUUso0IW2OVNSbMVhObHUDRV3xy4qN/cHr5AZr+E=;
        b=dypduuH1eIZP1mckUgtTb4NSSWuEtdHLsgU/T/UrbjG+/9OGV3dxBdgcfXbP15hABq
         JKnDsipixR/ptGgvVqKKjNDqimjMHQ83kI6L+d+U8nWwujvC4u9C6gJXD/FzDyjrRzws
         mm6x0BW/igd6tQz21npU20iYDhiybOs2dWUjVoJTQAt/zH3xafZ1EWprd1MmEnSCsJ1c
         OgXiUruD0gzetUW8OaVib/ZeAKREY/5grohqzt4Y/KykF5Hyjl1HwQMxDlpNALkLCn7H
         ngMXsnsoRW47n0SW9N0GVS6Nv2LXVRAVG9VwrdQHCWE7ulif1+UJkqFUrJpoDRHwzxDx
         UAyg==
X-Received: by 10.140.25.11 with SMTP id 11mr21740792qgs.9.1408855009214;
        Sat, 23 Aug 2014 21:36:49 -0700 (PDT)
Received: from magrathea.tsunanet.net (magrathea.tsunanet.net. [142.4.212.106])
        by mx.google.com with ESMTPSA id u6sm70281323qap.24.2014.08.23.21.36.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Aug 2014 21:36:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1408854741-13956-1-git-send-email-tsunanet@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255778>

On OS X, strlcpy is already #define'd, which causes warnings
in all the files that include `git-compat-util.h'.  Note that
this only occurs when building without running ./configure.

Signed-off-by: Benoit Sigoure <tsunanet@gmail.com>
---

Resending with the SOB line I forgot.

 git-compat-util.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index f587749..8c001e2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -495,6 +495,9 @@ extern char *gitstrcasestr(const char *haystack, const char *needle);
 #endif
 
 #ifdef NO_STRLCPY
+#ifdef strlcpy
+#undef strlcpy
+#endif
 #define strlcpy gitstrlcpy
 extern size_t gitstrlcpy(char *, const char *, size_t);
 #endif
-- 
1.9.2.460.gfb82504
