From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 11/13] refs.c: don't expose the internal struct ref_lock in the header file
Date: Thu,  4 Dec 2014 00:29:21 -0800
Message-ID: <1417681763-32334-12-git-send-email-sbeller@google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 04 09:30:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwRne-0005tv-74
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 09:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbaLDIaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 03:30:02 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:59918 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbaLDI3s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 03:29:48 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so15490928ier.0
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 00:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gw1vCzAeBLufBWmtfJdhqyj2xKY+mr6blMXXLe70GaI=;
        b=K0B9/VD/FZxoardCz00+srZKhCkRp0kMQ14LMONtaAI9L8IAHTmYEbAPLP7GpWauJf
         oHPFB67MSHuEr0ZlQe2kgIedBX4TvOt0ouu5I8EzD4IBo5DOltNa1gjQKFLSN/MlPIb8
         R55j9xDl6sOnneysHHBVzLS/y3VZGLLX7ugxHgGj5sRwLxyRQg/3+g+wZxEfs1k70wA6
         UoCuz9iI93zRdBnkgsIQjmUN6wGUQLk5tVT+7pfDohdXu/R/turLtAyeNfTQuG1mYtW6
         3qeZkfnkvDuTjn3I10CB96o6hXMXIo/QhpHH96t6uH+YLB6nnpSFd83nIvg7+Vd1lioq
         V6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gw1vCzAeBLufBWmtfJdhqyj2xKY+mr6blMXXLe70GaI=;
        b=kNMrQrB/M9tFBvOt1Y7amHpo/xh9Wtnzp3ERXTMKk9XlkImr5OpaM2C9ozkMXtsnzd
         Bdqb9KAqJYomdLTHFjOBGjYNCDtngrbf4j9HHnbsjV8GktKzOLRT8jhmHzHvnwKZnhB1
         wZp6ytQJOrDqsCRZwzudPruWPkmeKUyozBl4WTwMCy8TMbwaR72JDcw5kVJbkmA2CsN+
         nXxwIUmRwAtexxF5Zvx0ofbO1Dl1DuCmorfQbT/cm6sNSh3HxVZ6q5SNLjnvmPPzOfO8
         TEF3Gj+cWsq4sLtDhpz+LUH1vHVkJWb0TWGVxfJinDuT9yhLzterRyAKUK5wA0xMGi6T
         Eo6A==
X-Gm-Message-State: ALoCoQkrNzFgVWuHOo2ZZjqaBPy48svSAl3vk9g0p6Z0eP9R2JGK+XnBhW9BnWk0xAv2J9XBS9dI
X-Received: by 10.50.73.231 with SMTP id o7mr336473igv.15.1417681787559;
        Thu, 04 Dec 2014 00:29:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5d2c:9a2d:3064:bc4])
        by mx.google.com with ESMTPSA id 6sm8161677igk.11.2014.12.04.00.29.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 00:29:47 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417681763-32334-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260742>

Now the struct ref_lock is used completely internally, so let's
remove it from the header file.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    This patch is brand new in this series,
    so digest it while it's hot!

 refs.c | 9 +++++++++
 refs.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 796b7cc..b54b5b3 100644
--- a/refs.c
+++ b/refs.c
@@ -6,6 +6,15 @@
 #include "dir.h"
 #include "string-list.h"
 
+struct ref_lock {
+	char *ref_name;
+	char *orig_ref_name;
+	struct lock_file *lk;
+	unsigned char old_sha1[20];
+	int lock_fd;
+	int force_write;
+};
+
 /*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
diff --git a/refs.h b/refs.h
index 166aab8..cfc8d90 100644
--- a/refs.h
+++ b/refs.h
@@ -1,15 +1,6 @@
 #ifndef REFS_H
 #define REFS_H
 
-struct ref_lock {
-	char *ref_name;
-	char *orig_ref_name;
-	struct lock_file *lk;
-	unsigned char old_sha1[20];
-	int lock_fd;
-	int force_write;
-};
-
 /*
  * A transaction represents a collection of ref updates
  * that should succeed or fail together.
-- 
2.2.0
