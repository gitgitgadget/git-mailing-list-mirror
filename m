From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v17 01/14] ref-filter: move `struct atom_value` to ref-filter.c
Date: Thu, 10 Sep 2015 21:18:17 +0530
Message-ID: <1441900110-4015-2-git-send-email-Karthik.188@gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 17:48:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za45S-0004vt-8s
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 17:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbbIJPs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 11:48:29 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35418 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbbIJPs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 11:48:27 -0400
Received: by pacfv12 with SMTP id fv12so47324252pac.2
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 08:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nDd8KEB87YZyxrBrsgZKDPPLrEBxl9KKO1jFs2w9IJc=;
        b=rUrFA+EzRh7plpt8YGnlLJT1qlbB9FljrXceWaANtxVMHYHbVCT2Y/t+ePyV1ymsjY
         6TK2muEwx77P8NYDCNYlDL6kxHtKreEIjvVWdlSYmiWJPA2FUiRw912VFMX1vkxOmTzn
         jEqoacLNYDZ/AwNnycYCdIVT/r7nGK0g5tT1v4gAKAVr09nV1MSRmhdJZRvK5gqILo39
         0UyBrEGSEClxH7Q/M7iG2hV8C7hzDlsHOf6k2+enHyCKdARoNV/RaTam8y6KVt3ksTJf
         1P2q8YIPTafeVK/3lWO+tP15unbMOdu73S3uo1CLfsKA6P9H10D8nFiXvXIsHiQsCrjv
         zqaA==
X-Received: by 10.68.194.170 with SMTP id hx10mr85107204pbc.64.1441900106694;
        Thu, 10 Sep 2015 08:48:26 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ts1sm12738918pbc.74.2015.09.10.08.48.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Sep 2015 08:48:25 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277582>

Since atom_value is only required for the internal working of
ref-filter it doesn't belong in the public header.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 5 +++++
 ref-filter.h | 5 +----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 46963a5..e53c77e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -55,6 +55,11 @@ static struct {
 	{ "color" },
 };
 
+struct atom_value {
+	const char *s;
+	unsigned long ul; /* used for sorting when not FIELD_STR */
+};
+
 /*
  * An atom is a valid field atom listed above, possibly prefixed with
  * a "*" to denote deref_tag().
diff --git a/ref-filter.h b/ref-filter.h
index 6bf27d8..45026d0 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -16,10 +16,7 @@
 #define FILTER_REFS_INCLUDE_BROKEN 0x1
 #define FILTER_REFS_ALL 0x2
 
-struct atom_value {
-	const char *s;
-	unsigned long ul; /* used for sorting when not FIELD_STR */
-};
+struct atom_value;
 
 struct ref_sorting {
 	struct ref_sorting *next;
-- 
2.5.1
