From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v14 01/13] ref-filter: move `struct atom_value` to ref-filter.c
Date: Sat, 29 Aug 2015 19:42:05 +0530
Message-ID: <1440857537-13968-2-git-send-email-Karthik.188@gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 29 16:12:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVgrj-0003Ts-90
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 16:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbbH2OMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 10:12:16 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32872 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbbH2OMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 10:12:15 -0400
Received: by pacgr6 with SMTP id gr6so4977195pac.0
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 07:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SKYv6oVOmXdHHtStYTG9549UPn717gy1v2MQT9ferP4=;
        b=pbBmiX0GxxYTsXziALV6Zti3mWtsYmKPR0jvs0JYhmnQ/fbmexvpASO7CvyuizwsXD
         5KTg/zBwYTcQMknaIApiwFWVuSTUVrQnRUanQolMJSI8aoW/Pvb95UhQJKFkaT4krnOd
         bOf/RxVbuc86kzLkp8GSDoCg3tKgDzYBvcjt7U1eh6Ftmkg47hj7/5eiXBZh7tHlKNZC
         t+gUKKIbkMA/gnI1nTY/1WqhY9TfBZ4gZsCGquM6e+IqiplJVH/lDQrzAaJ5xnl6a+P/
         5FHcfgbGW+BLD7hmiic93Y7A8NnF176cIjoCQQMKAqG8hvg1ein+H7XWqXN76GhaGg6y
         x9Aw==
X-Received: by 10.68.136.234 with SMTP id qd10mr23627187pbb.162.1440857534896;
        Sat, 29 Aug 2015 07:12:14 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id hy5sm8876807pac.22.2015.08.29.07.12.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Aug 2015 07:12:13 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276777>

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
