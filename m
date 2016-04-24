From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 80/83] run-command: make dup_devnull() non static
Date: Sun, 24 Apr 2016 15:39:46 +0200
Message-ID: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:40:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKGg-0001ou-RE
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbcDXNkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:40:05 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36660 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbcDXNkD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:40:03 -0400
Received: by mail-wm0-f49.google.com with SMTP id v188so69639196wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DSdqLdEprw6QaKwnQjzlDR2RnzWVhA4GzCDXMBDiH2w=;
        b=UNItJvarHfa8DxISnCv+OHtQ7baEsRy8A3wsMjf2Ngvr5h/Tytdl5vEVgdXKtfDD3h
         rEApMVPQDmgsI39uwp37aPiget6C+h1pHvMaczMpa+HqbSjqhEloSNeY6a7Mf19dzzAu
         CASl0N47CSVc7yhBvKify3PyKD2NUS5wvapAIoZAh1jEUvXSoQjhvZM+Knr7s1tvQw//
         nHnDrFsHXTFHVNhCJi1aTRqFpw36gse+ITR6NiecADeaK3QP8uIeKMLKhzS7w2ZS6M2T
         m1YYY1+waK+utq1WL6aUbUO4PbtjTRoYHzEuohfgYN2BMCHYPv1cjRV/RmldK/4Y+qZ0
         PbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DSdqLdEprw6QaKwnQjzlDR2RnzWVhA4GzCDXMBDiH2w=;
        b=HMI3nBrSwEY1N+53ki9Dq8I5Nd59qFozPahRjSjjQklEeozT59GrwgAxGe8+0Q5juE
         6cD93ySeg/kINLbK986El2E0W712hVNwDwIZRR6CM2M6M0orGS6xG9e4k1t+EqI+E4H8
         p4v5wPN348GVysCv5IVaSsAuKwN9y4YeQgYRu6+S7wNoxg2NodWpkVMMk/wlsgv15YlD
         AvYHarEelUFS6LD7BIm3FKpAB241rm09Oj6wa0AFUwX1Kvz6YU9HlHHi9mksVbEL8J54
         ecMQe66uAinI8NGFyDScaJtg8Rro4ZuoppqY4hxPe9MWgUZoTvU2+/53q4Ww0clFGEh1
         0Kfw==
X-Gm-Message-State: AOPr4FVLclrYxEgUu6ujaG0vZYvAPJfW3Fu7AYAxSyfj3A+mMMjKbmSWlDgps3OHDRzjug==
X-Received: by 10.194.38.67 with SMTP id e3mr3915822wjk.127.1461505202447;
        Sun, 24 Apr 2016 06:40:02 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id by7sm18530771wjc.18.2016.04.24.06.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:40:01 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292402>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 run-command.c | 2 +-
 run-command.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 8c7115a..29d2bda 100644
--- a/run-command.c
+++ b/run-command.c
@@ -85,7 +85,7 @@ static inline void close_pair(int fd[2])
 }
 
 #ifndef GIT_WINDOWS_NATIVE
-static inline void dup_devnull(int to)
+void dup_devnull(int to)
 {
 	int fd = open("/dev/null", O_RDWR);
 	if (fd < 0)
diff --git a/run-command.h b/run-command.h
index de1727e..3aa244a 100644
--- a/run-command.h
+++ b/run-command.h
@@ -200,4 +200,10 @@ int run_processes_parallel(int n,
 			   task_finished_fn,
 			   void *pp_cb);
 
+/**
+ * Misc helper functions
+ */
+
+void dup_devnull(int to);
+
 #endif
-- 
2.8.1.300.g5fed0c0
