Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C49E71F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeCWRXI (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:23:08 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43203 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbeCWRVu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:21:50 -0400
Received: by mail-lf0-f65.google.com with SMTP id v207-v6so19393430lfa.10
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=He/Q+10Sr4R5Cns+wVApOC30DqvF3k9I6J3delUVj/c=;
        b=NgHi0GpwY4RxXK0OmMbpwhkpkvOJ2+9iYHeSYOzIv22AysmrbGHWIHw7ZLnWPkpEhz
         GlW7yZ3YzIhgSlIK5B9J97fcOpS6QOZIoNlFUrTexvQIaskinUkg0fSyG207ovaxDAJA
         gmtdvfpEck2hg7jvtKZ98HkuxasPVfjbaweZ9qcOQMObbc26pkB0V2Im4gmzQ7IzUTMo
         kEdnS0Cs+IO2d7roP8CmV/yL9Ezf5C10lUivFvw3NGXCbMcfOuH34Glk3CTzhN07HyWG
         U90Sjlm5OtFngkONMFUHf6tA/gPNM1dcX88QzE2yR99Atd2chJP++eFg6crBj7ud+v/7
         3DIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=He/Q+10Sr4R5Cns+wVApOC30DqvF3k9I6J3delUVj/c=;
        b=OITGQFwW/X5Mgi7/UNCaguJdlwxzKjBvt5nC+VHc5NQhnPM0rmoMjPEDTivhfwLLDl
         6NAGYoVxRMeCgGvDG4NSgNfSmeD64Rx2jk84N7C7gh9/j3YDadFXtrBVVdOTM4GxCCWW
         49MIPNPa/ovCQJjnX5LJmDHHvX5BvR+pwGgNyXyj7pvQVN4wRYF5Ec2aPSm1JTKfw5Zb
         en94ujBp47HbL4GtPGALCxSbahfdtDQ8VQ8IQxKjaJPSBHfZZq8RAc1tje4quMh5Na3Z
         hM0rjkM2s3aK7i44BLomqNt0J+RrfaojG5qExH1m114j/AD38vu5YD+6dK9iysLayMsV
         I4lg==
X-Gm-Message-State: AElRT7GD4NNUgpMAnRthrENBXSi1fSLUY0+UDwwJPKisV7iftAyjt5hO
        Xrb0l27MBud/3YviQwfXnP+BOQ==
X-Google-Smtp-Source: AG47ELsEj5K7TkE7iQQMtUFxcHcI2QIEkS/hUbRWlWGpnXEdhVIXBQrwHSeIBXmEu3EAgTYKjXqRJQ==
X-Received: by 2002:a19:4acc:: with SMTP id x195-v6mr21224588lfa.46.1521825709188;
        Fri, 23 Mar 2018 10:21:49 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:21:48 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/27] pack: move prepare_packed_git_run_once to object store
Date:   Fri, 23 Mar 2018 18:21:01 +0100
Message-Id: <20180323172121.17725-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Each repository's object store can be initialized independently, so
they must not share a run_once variable.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 object-store.h | 6 ++++++
 packfile.c     | 7 +++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index c687ab7587..6a07a14d63 100644
--- a/object-store.h
+++ b/object-store.h
@@ -98,6 +98,12 @@ struct raw_object_store {
 	struct packed_git *packed_git;
 	/* A most-recently-used ordered version of the packed_git list. */
 	struct list_head packed_git_mru;
+
+	/*
+	 * Whether packed_git has already been populated with this repository's
+	 * packs.
+	 */
+	unsigned packed_git_initialized : 1;
 };
 
 struct raw_object_store *raw_object_store_new(void);
diff --git a/packfile.c b/packfile.c
index f2dc084745..2a053711cf 100644
--- a/packfile.c
+++ b/packfile.c
@@ -884,12 +884,11 @@ static void prepare_packed_git_mru(void)
 		list_add_tail(&p->mru, &the_repository->objects->packed_git_mru);
 }
 
-static int prepare_packed_git_run_once = 0;
 void prepare_packed_git(void)
 {
 	struct alternate_object_database *alt;
 
-	if (prepare_packed_git_run_once)
+	if (the_repository->objects->packed_git_initialized)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
 	prepare_alt_odb();
@@ -897,13 +896,13 @@ void prepare_packed_git(void)
 		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
 	prepare_packed_git_mru();
-	prepare_packed_git_run_once = 1;
+	the_repository->objects->packed_git_initialized = 1;
 }
 
 void reprepare_packed_git(void)
 {
 	approximate_object_count_valid = 0;
-	prepare_packed_git_run_once = 0;
+	the_repository->objects->packed_git_initialized = 0;
 	prepare_packed_git();
 }
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

