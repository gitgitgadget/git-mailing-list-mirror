From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v11 01/13] ref-filter: move `struct atom_value` to ref-filter.c
Date: Sat, 15 Aug 2015 23:30:31 +0530
Message-ID: <1439661643-16094-2-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 15 20:00:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQflH-0001Hw-VO
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 20:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbbHOSAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 14:00:43 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36188 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbbHOSAl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 14:00:41 -0400
Received: by pdbmi9 with SMTP id mi9so609630pdb.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SKYv6oVOmXdHHtStYTG9549UPn717gy1v2MQT9ferP4=;
        b=eVt4aMCfRlIZhLEzv+J9XfapMdnDAFW79o6FwYrD3E8VV+F1gc/nIjaSEeh9cpW4fy
         Um40FuOS+bQQsX8+YdREIAmlh1dchb3XMc1SIRP8tiMwa4mD9fzOoYtkuM4yJ0uzeZuk
         zYTCN2/2hybFkjRtVgFrFpFWadRFa2LPsj7DO+qZj5/btU7ayhbeODniQd/KvYvGEd0N
         /262t7aRC4gZA1KxE6pm7g9ZsX4ZlVJOYnqHdXmlNrCQ7u7V1c9unxJlxXk3LmZ+Yr+j
         z73b42+68NqcmMxUUfsD9NLYmcCz1W4i6W1oDRtMEsZ4Hdj8LNQyVKIqHnptVPwXzEYo
         Fo7Q==
X-Received: by 10.70.109.165 with SMTP id ht5mr30357088pdb.137.1439661641047;
        Sat, 15 Aug 2015 11:00:41 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id pe3sm9424144pdb.55.2015.08.15.11.00.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Aug 2015 11:00:40 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275994>

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
