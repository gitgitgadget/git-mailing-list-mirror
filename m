Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E14A9208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 15:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeG2RHB (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 13:07:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41989 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeG2RHA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 13:07:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id f1-v6so8312075ljc.9
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=58V7BUNPvVxVshGdg6jHU9EF6b4y61bcDLWlA7sjQhQ=;
        b=pqnqaB31AWuDSWIU4T3LXOBQrUqv9+V/S4EpXZqd/HTXUcPkX6DaN1rrI71tihXIPN
         u/Zor4doS5PopuPjZaakXZv+x9HrPSCpU7Ll86JS4kOggRJEZMlFEVqNBiRSUm1F7o8w
         aJXpteRYhv01nzNGexUSAhca+HZuDjYAZfSkXVIrJFHQ2bAx7LvwYu+Mry7Q7D8Wzqdc
         6aH11g6azj70rKnXZ384GO+YZ0LnhinqiRwDgMH5s6PeUZYcL4yl/wEfRMPzCKIBxKxc
         yX7E0fNwCa0Ckws5hfMg2sUpSnx9lbnnk+RIk7HeyO0KS4WVxu82NPf2ep40UY/qa+Mk
         ZMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=58V7BUNPvVxVshGdg6jHU9EF6b4y61bcDLWlA7sjQhQ=;
        b=OGheNUiu7nHB3wRmsnggRGo6SI+yOsq5PeMaMNX4eoDEyPlUxxg49EJuq4RPzFCgij
         SNHmpCpmxUZ7yu4A7eNSrA2k00jtiEk6QIoZlG0dTY18n+YgdoyH9h/ry1gdynzYRUyA
         Syf9EVgopJhl6RSYUceZA5ZAnljIhut+uO79YTqOGexWl9dIE/sR6AJImn+UoyoUzaxX
         1irBuj8AO/hL/v9HQxYXDn/VgHPdpIKtOD/gvw/KZq4CZyP95qkcLVcN71hxwCSHI9Ji
         YEkXYXeCkrRcV+HF1+4vbqRm9H6A+CatJONjJKJ0uQVSR3u8vgA3xgtMc3VFdPEPAXkY
         YKvg==
X-Gm-Message-State: AOUpUlHO/CRsGtBOfg5/vIPgwbStDOvE9ZCavtVoLldYWTDxFIeitYJC
        0tAj8dzy/y9odZ1Ewv/1LHboF3WZ
X-Google-Smtp-Source: AAOMgpdN05IWq2YiyyqfuOOXydkVBWZ3CSv3NmarQNnEuu7FgjXAlH7mXgzpdHf7QDwzCdehG4oStw==
X-Received: by 2002:a2e:9c4d:: with SMTP id t13-v6mr9901930ljj.153.1532878569481;
        Sun, 29 Jul 2018 08:36:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x65-v6sm1231294lfb.60.2018.07.29.08.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 08:36:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] pack-objects: document about thread synchronization
Date:   Sun, 29 Jul 2018 17:36:05 +0200
Message-Id: <20180729153605.27298-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These extra comments should be make it easier to understand how to use
locks in pack-objects delta search code. For reference, see

8ecce684a3 (basic threaded delta search - 2007-09-06)
384b32c09b (pack-objects: fix threaded load balancing - 2007-12-08)
50f22ada52 (threaded pack-objects: Use condition... - 2007-12-16)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ebc8cefb53..6270f74c0b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1852,18 +1852,30 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
 
 #ifndef NO_PTHREADS
 
+/* Protect access to object database */
 static pthread_mutex_t read_mutex;
 #define read_lock()		pthread_mutex_lock(&read_mutex)
 #define read_unlock()		pthread_mutex_unlock(&read_mutex)
 
+/* Protect delta_cache_size */
 static pthread_mutex_t cache_mutex;
 #define cache_lock()		pthread_mutex_lock(&cache_mutex)
 #define cache_unlock()		pthread_mutex_unlock(&cache_mutex)
 
+/*
+ * Protect object list partitioning (e.g. struct thread_param) and
+ * progress_state
+ */
 static pthread_mutex_t progress_mutex;
 #define progress_lock()		pthread_mutex_lock(&progress_mutex)
 #define progress_unlock()	pthread_mutex_unlock(&progress_mutex)
 
+/*
+ * Access to struct object_entry is unprotected since each thread owns
+ * a portion of the main object list. Just don't access object entries
+ * ahead in the list because they can be stolen and would need
+ * progress_mutex for protection.
+ */
 #else
 
 #define read_lock()		(void)0
@@ -2245,12 +2257,19 @@ static void try_to_free_from_threads(size_t size)
 static try_to_free_t old_try_to_free_routine;
 
 /*
+ * The main object list is split into smaller lists, each is handed to
+ * one worker.
+ *
  * The main thread waits on the condition that (at least) one of the workers
  * has stopped working (which is indicated in the .working member of
  * struct thread_params).
+ *
  * When a work thread has completed its work, it sets .working to 0 and
  * signals the main thread and waits on the condition that .data_ready
  * becomes 1.
+ *
+ * The main thread steals half of the work from the worker that has
+ * most work left to hand it to the idle worker.
  */
 
 struct thread_params {
-- 
2.18.0.656.gda699b98b3

