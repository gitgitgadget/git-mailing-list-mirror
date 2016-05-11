From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 93/94] run-command: make dup_devnull() static again
Date: Wed, 11 May 2016 15:17:44 +0200
Message-ID: <20160511131745.2914-94-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:21:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U5D-00056i-4b
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbcEKNVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36286 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419AbcEKNVl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id w143so9359131wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ffXKmEt8LB2qcyOdD2MrgDhlLCJGlaG5CZ8ESu07xmA=;
        b=khnI12SoNyvkberPJqCFDT2J6ihb1c4LOhREZjhm6NVi9OZrsgDD++IPbby89NUA2f
         kptsqMnDnwd6QX/eeD6PjyYkTrnNr2YcfIAn5DkkN9cuAJXfpLn1imTX7FfIsKAgVFMN
         ATCs6v4M6MtRB4GHFViZfrQ6D/zDTfHqSzh6+mbEsQnNBMRoZcdJGXivL8Pv3Hh5mEvU
         KT8ouYcVocBXj4AdRTrUML/mllU2ThdAVyR9dEtLxJibdZQR2ZvgDAWn1L0GvVJX7sDd
         EVg81gbY3t7ztpDj5P0qVGP+3HqNafzFpZeuZRKNetVAwXz+60gjKl1h44VrcM52yGMy
         pPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ffXKmEt8LB2qcyOdD2MrgDhlLCJGlaG5CZ8ESu07xmA=;
        b=nCKOlrZk278xfXhv3vErEcsku2eK0xEt1VWhvy6fRzyIuNKfJFbMOQo11YliOZ39RW
         7FoB+LPvWvsRUzXZESTPR67Y5QKjT5ExnDri2lchjs6Onb23I4p8Yatleddk509NZQXF
         h/gZzYnHt1VNkGELHJjy3ee8f/LnC9BrfrSsz4J0tRvGc0c1Roiq72cpPRLKTepQGwbK
         0vwqO3M4XDe0KL5tTz0Q0wNyh3zCd+e01FvOHmDDsi9s0/ouBisBU7BJbWjd0LI3LWZy
         YHhVeUByYM0umpnsQgLoFlks5Em7++UMnZ1v0XStfXsjkQFGDlQKsWP8QjY4954una4Y
         wkkw==
X-Gm-Message-State: AOPr4FWzQ9Yw1BRIsK/ZR9UWUiM9LQEatTKR7ZXQpyrOsWlI3wAQfkAluRl+gtgwPTpH7Q==
X-Received: by 10.194.77.42 with SMTP id p10mr3736322wjw.111.1462972900302;
        Wed, 11 May 2016 06:21:40 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.21.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:39 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294302>

As there is no caller of dup_devnull() outside run-command.c any more,
let's make dup_devnull() static again.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 run-command.c | 2 +-
 run-command.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/run-command.c b/run-command.c
index 5d1cedf..e524e34 100644
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
2.8.2.490.g3dabe57
