From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 42/44] run-command: make dup_devnull() static again
Date: Fri, 10 Jun 2016 22:11:16 +0200
Message-ID: <20160610201118.13813-43-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSnc-0003vF-O8
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbcFJUMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33788 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702AbcFJUMt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id r5so1071858wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dSGBqkrGd5gLS0igYdnEr1l1dEhYw/n6vcTmH+ODMKg=;
        b=SCJCpmBfArRQd0H3H2bu55RVcDzVxRZ/KkjbRzL5MVOdy8t8IwJCrVaeXPfphUa0n/
         +EIb+kMtsq9dsAFDco1A7TqDdlmyP5I8yBiKSdeKRR1ylnlPJO43ncTARjP5wd3JHVV6
         qJxfrr7B1ZxU24EjPNlyaAoRpaV6HIE7WGjwWCMPgJx20tNECgM8LumRL0NgGegu/d7A
         AA7tRVxxApdfZVYJPOin9co6F/0tk8raLLfmex5IoE6NVaqrTMkRJJBYAi7wAxqZXz65
         5/PesmR//cchncLreAeV4lHQO1SpQRw8R2xVyvL1CpflY/MGoct0i1F6Dn/zsHgaQT/y
         4idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dSGBqkrGd5gLS0igYdnEr1l1dEhYw/n6vcTmH+ODMKg=;
        b=mUoTpN/g5keBCtk6yb4VqSBm77pbF8D21aUmTOwoRjI0eRhH7lJovxz1/MbbfbEfsT
         X1Z44X4a8kXz4CUfIT/CeVYQLks53wQlt+YNyAQR9JTDgav/MwK6YB+L0vxjUefzvzrJ
         ot68YWRJMdGcxrrF0M9oxC3pMiZUtqhkdYJBy9al2U9OjPjZTTF3O36xBpSFEYkWjJXy
         weJLzG3aCqnI7YvUWapJfrbKbe/Re46FVBzbju86X+2O1T98XFjsd7XOfyVuFzAUQy0K
         sIPWXBZHK0Spo9TYnjSD6Ee9tBLhIObHWEfIq7r/TDe1WS+zeJCJlDQDPucGIqCEV/G/
         B/Eg==
X-Gm-Message-State: ALyK8tJ8cGZQ5u3FOvulp74NXd5ZonKGxQ3f3sbPVXyTGnPuwCm0xfceHvUwYjEER+DKrA==
X-Received: by 10.194.171.7 with SMTP id aq7mr3560655wjc.8.1465589568188;
        Fri, 10 Jun 2016 13:12:48 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:47 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297051>

As there is no caller of dup_devnull() outside run-command.c any more,
let's make dup_devnull() static again.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 run-command.c | 2 +-
 run-command.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/run-command.c b/run-command.c
index d8ed88c..c09d6b0 100644
--- a/run-command.c
+++ b/run-command.c
@@ -85,7 +85,7 @@ static inline void close_pair(int fd[2])
 }
 
 #ifndef GIT_WINDOWS_NATIVE
-void dup_devnull(int to)
+static void dup_devnull(int to)
 {
 	int fd = open("/dev/null", O_RDWR);
 	if (fd < 0)
diff --git a/run-command.h b/run-command.h
index e05ce7d..11f76b0 100644
--- a/run-command.h
+++ b/run-command.h
@@ -201,10 +201,4 @@ int run_processes_parallel(int n,
 			   task_finished_fn,
 			   void *pp_cb);
 
-/**
- * Misc helper functions
- */
-
-void dup_devnull(int to);
-
 #endif
-- 
2.9.0.rc2.362.g3cd93d0
