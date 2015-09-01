From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v15 01/13] ref-filter: move `struct atom_value` to ref-filter.c
Date: Tue,  1 Sep 2015 23:56:22 +0530
Message-ID: <1441131994-13508-2-git-send-email-Karthik.188@gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 20:26:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWqGU-00073k-Va
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 20:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353AbbIAS0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 14:26:34 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33185 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242AbbIAS0d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 14:26:33 -0400
Received: by padan5 with SMTP id an5so3828180pad.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 11:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SKYv6oVOmXdHHtStYTG9549UPn717gy1v2MQT9ferP4=;
        b=zH59zrNjTFghgqtPOSDlCMMvyxyoenQ2fxB9pefwIb8WSR5DeIHS8bypS7WKeXvtXT
         y+FgiWPU9pOz21mezjq7XhLY5jYCqnBSCjVjGZ4Sl0fwVYbfGUtob59od6ov7SeI7Bzo
         DG+rP6gZu/uYAlI/QFbwpK62VOP/VixcukHBCUDpCozZtPWM9kx1Nj8YUu6Ncw44zU4n
         5prMUVwXtPNzC6C0d3o5YRbOqA2fYuA367Mn4Nk68qVc0ejj8+ymspspSG+644luGt/V
         bhvJqJbA7Gw/q6iMhlcITIxUuMaqbHAj31RHE5V1v+fAPifkjoyNsXxkrY4w1ozNvY9a
         uEdg==
X-Received: by 10.69.26.196 with SMTP id ja4mr47740516pbd.121.1441131993047;
        Tue, 01 Sep 2015 11:26:33 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id uk6sm19091682pac.27.2015.09.01.11.26.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Sep 2015 11:26:32 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277011>

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
