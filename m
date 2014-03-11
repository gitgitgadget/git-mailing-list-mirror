From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] sh-i18n--envsubst: retire unused string_list_member()
Date: Tue, 11 Mar 2014 18:46:44 -0400
Message-ID: <1394578004-18638-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 23:47:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNVS8-00068O-NG
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 23:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866AbaCKWrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 18:47:12 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:61404 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526AbaCKWrL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 18:47:11 -0400
Received: by mail-ie0-f178.google.com with SMTP id lx4so9855737iec.9
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 15:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=uufdC+WbZIjX/cYBviGM2QQf8xF66WP3WJ7pkiEu4ic=;
        b=GAMNmMCBwHRQJQ1Hd4PTffDwiGlQuXISl3cpV5DqF5MVIqvzyBsYT/740ieze0pi0p
         8RzYAVKISPwXXseEeYPeWWdwo9XoTUuI06r55jgqGCW6yA/SMhJ/BdWXArC/kKHSTr3Q
         a4bI/OtpBg8OREZub68S9cy5+qZHwXam03M0zEQuNpgjfaZfa/xlmcnYgMmMAb4ec4jm
         FmKfjAO6yFHAaAKDrXx5AjJKofk8Pt1J6FPIm7vGXYyJ1bgTU34scqHlEQZx2i5rSTe+
         D54SC32sEz/NaT0YBLvFK6ppVWAuFy7v4H93zwiCU+RhpmahdG6o/lWXGU62Anqm0WhP
         iIJg==
X-Received: by 10.50.61.180 with SMTP id q20mr8962953igr.38.1394578030665;
        Tue, 11 Mar 2014 15:47:10 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id u1sm51891001igm.8.2014.03.11.15.47.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Mar 2014 15:47:08 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.282.g01e9d92
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243909>

This static function has no callers, nor has it had any since its
introduction in ba67aaf2d05d (git-sh-i18n--envsubst: our own envsubst(1)
for eval_gettext(), 2011-05-14). Remove it.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

The latest Apple developer tools (just released) has -Wunused-function
enabled by default, thus it complains about this anomaly.

 sh-i18n--envsubst.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index 5ddd688..855d28c 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -237,18 +237,6 @@ string_list_sort (string_list_ty *slp)
     qsort (slp->item, slp->nitems, sizeof (slp->item[0]), cmp_string);
 }
 
-/* Test whether a string list contains a given string.  */
-static inline int
-string_list_member (const string_list_ty *slp, const char *s)
-{
-  size_t j;
-
-  for (j = 0; j < slp->nitems; ++j)
-    if (strcmp (slp->item[j], s) == 0)
-      return 1;
-  return 0;
-}
-
 /* Test whether a sorted string list contains a given string.  */
 static int
 sorted_string_list_member (const string_list_ty *slp, const char *s)
-- 
1.9.0.282.g01e9d92
