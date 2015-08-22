From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v13 01/12] ref-filter: move `struct atom_value` to ref-filter.c
Date: Sat, 22 Aug 2015 09:09:37 +0530
Message-ID: <1440214788-1309-2-git-send-email-Karthik.188@gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 05:39:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSzev-0002CT-Og
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 05:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971AbbHVDju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 23:39:50 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34528 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbbHVDjt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 23:39:49 -0400
Received: by padfo6 with SMTP id fo6so19590108pad.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 20:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SKYv6oVOmXdHHtStYTG9549UPn717gy1v2MQT9ferP4=;
        b=vEiQyMwq1TLHq8ytFXD+pgnUI2SG9tBOUmeztUqQy/00q/QFFB7wVZn8lvUW3MKX33
         Eem3121Szxe1qx/nLi6ycdoVJDIqPCDsuMnDVAPV/BES1fjvyHmNsi7IvVBvGWNA3KHO
         jVS6rzwlke7/55ULJHcJwQ741vmCXmUb1R9LGeYb+rCquU/yOMozVpZb0lUo0cPULcqP
         NEXnrPWdO/O0pxlcjhzm9JzbISNhrYnm1QP0XCFPyXJqEi52Nh2/l8NYH67r4OI831Rn
         6ac3vMACNNs5u4LKMXb/FpokorSXxOdiuYS9IFfqeBJr0NnV50JAphu86ORFKyZyqEMd
         iDuw==
X-Received: by 10.66.164.130 with SMTP id yq2mr24288725pab.67.1440214788090;
        Fri, 21 Aug 2015 20:39:48 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id e4sm9393515pdd.45.2015.08.21.20.39.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Aug 2015 20:39:47 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276364>

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
2.5.0
