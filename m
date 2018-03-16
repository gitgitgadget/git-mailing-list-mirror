Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FD511F404
	for <e@80x24.org>; Fri, 16 Mar 2018 19:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbeCPT2S (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 15:28:18 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33554 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753085AbeCPT2P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 15:28:15 -0400
Received: by mail-lf0-f67.google.com with SMTP id x205-v6so16968369lfa.0
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PE+NKz/nQ96B5qPsWKsdIqCDqIDhEaxdBFcqjkGIxXE=;
        b=fkXv1gejGCpUOtp2EVoIF15Bsdm6i2SKZCDV1rnz2kjezUqnZ6Wc7ELptXZoZGdl4+
         lvlnubJ07y27rbaD18SnwS/0CvviPGs0mTHizCvtMKsvU/tZydQ02WTEm8xuUT+6ESlY
         cNKUKNR9dNwRR+07+cJLE9KtE5svy2ds9l83PS+3OYpCJBKL5wWjxZ1Dw56L2ccj5MEA
         +/tXT0mI+YLTlFZPrxHuBPc1wgUfiCkAvmzIMecofoYu1AWwtFeyaPj6AJpCLPSud6xd
         2FuUkzzlr9XOIPCDzxXEG6/t4RHpvHWDl3kIXuM/tdpy4P8BLViLel/gym8Pqs5mI3+F
         hneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PE+NKz/nQ96B5qPsWKsdIqCDqIDhEaxdBFcqjkGIxXE=;
        b=SsAGqe8MEM23QCSmaJGh7OJocbGZvot4d7YC4VwekQajKmQa3TfM+pvJ0vkQ3wg+xu
         xE4Hqgn/KKdN/VNpXurhZc2QcWlpce29tS58umZ9Q6CZeRcoSV0D8V19OaP/v/vBbyMe
         srlZXFJSndhqKSxNzZsgRqnzlQy1uyKnuWgwn2als6gwCGnclwELLt8Xk+ayjMzQ4QxO
         ZNDYJUf5/MaYHxbuvHBEuqp+dmwsG3G8KjzVYGa/DZAfgi13QqEfVSvVRDvVa6MZAcmj
         85MjN0reokiJy89GeaF3Q/O8awnneNL3tYNLyU2WK873Pv2xSanGZyb1J4gsDng07kCI
         p6Mg==
X-Gm-Message-State: AElRT7Ex/GAFeesZAUIde374k0/wZsn/L7huteJpmkaatN6MDuIQT9HZ
        u9d10/I5UU3qHJRGd0B3GjQ=
X-Google-Smtp-Source: AG47ELsx2xa9pquA7Ri4UaaOeDK+UEenQyri9JIDl3RyJ5EyaXNHMcUbHke4ocz2wsQlJnvmhAxHZw==
X-Received: by 10.46.133.15 with SMTP id j15mr2285370lji.58.1521228494517;
        Fri, 16 Mar 2018 12:28:14 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h8sm1766085lja.41.2018.03.16.12.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 12:28:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 7/7] pack-objects: display progress in get_object_details()
Date:   Fri, 16 Mar 2018 20:27:45 +0100
Message-Id: <20180316192745.19557-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180316192745.19557-1-pclouds@gmail.com>
References: <20180306104158.6541-1-pclouds@gmail.com>
 <20180316192745.19557-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This code is mostly about reading object headers, which is cheap. But
when the number of objects is very large (e.g. 6.5M on linux-2.6.git)
and the system is under memory pressure, this could take some time (86
seconds on my system).

Show something during this time to let the user know pack-objects is
still going strong.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f74e9117f7..ac8f29dd52 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1715,6 +1715,10 @@ static void get_object_details(void)
 	uint32_t i;
 	struct object_entry **sorted_by_offset;
 
+	if (progress)
+		progress_state = start_progress(_("Getting object details"),
+						to_pack.nr_objects);
+
 	sorted_by_offset = xcalloc(to_pack.nr_objects, sizeof(struct object_entry *));
 	for (i = 0; i < to_pack.nr_objects; i++)
 		sorted_by_offset[i] = to_pack.objects + i;
@@ -1725,7 +1729,9 @@ static void get_object_details(void)
 		check_object(entry);
 		if (big_file_threshold < entry->size)
 			entry->no_try_delta = 1;
+		display_progress(progress_state, i + 1);
 	}
+	stop_progress(&progress_state);
 
 	/*
 	 * This must happen in a second pass, since we rely on the delta
-- 
2.16.2.903.gd04caf5039

