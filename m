Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74E781F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeICWbd (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:31:33 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:44874 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbeICWbd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:31:33 -0400
Received: by mail-lf1-f48.google.com with SMTP id g6-v6so1003748lfb.11
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6q7CG3imODW/U8g9sFno2NA4F0oi0KNaWxR4Y0lHIcI=;
        b=DNhp/j9cRqIse6SPOkyYDe92Ek9+5BZvq2EVP0U4th+w5/+Fod83dNqsaFDvaZ6M/a
         z9J2vKcb6hUP1/glenSWtU5nNNsykaWnblY7w/9rjAvepgvdP5BP1hDXG33mxno66l8R
         YNf8YMTVncFD/tVbNlu6UvNo/M07Nd5nshIuf4BVNd2teYgHSAGi/+mXQHNvLwB8OBmP
         hD5VAwyOThd6UEQRRTF4nWmvuB/Wh+GBU32tF6L/nAu8Mw2vRL4DbohBqV3+dn5a6YRG
         1ASKXLb+WopaEG/KYMJSthA5b+sYsdnqOTCr2aaVTKM6eYkxxPY17LBJc/T1FTc5I1mm
         b31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6q7CG3imODW/U8g9sFno2NA4F0oi0KNaWxR4Y0lHIcI=;
        b=Y2HrHh1uSMtIT2wLzJqQo/1mOiiBBT2OYWDWHKLjGj7baCrJhXDH71VWyhZ9wi5RQ3
         GVG987xfvsG+ZOVi7PgsN9KTyorEpGVzacB2b9DYY8ixidpuLlE9UvDHE2c5CU5z06VR
         aiLm3jIfhKHDOoV8vgQ+3oMPU41pH/fA7UyVfBzu6YXpuV/oTEWbbOjzd0WlGU6An5wx
         Hzf0VnuwMGzCSVXYWrQRVfutUeWDObxcLn/WHGdvxdFxBhPzeiTOX1GcS+PW2Iwgnlxd
         STC8TtE9QtlE48GqQDeAaaydAmzqGDCW6PXTyzg8XAb1jlKBa92Es8MzQjhVTUP5cQKa
         ptWw==
X-Gm-Message-State: APzg51CMCUVnl5oLUp71nPeT+wT5uEhR0mOHJ5W5uiYsvIUZfdmBpvuO
        9MdPn1FwZkAwoFSYwsUzY6I=
X-Google-Smtp-Source: ANB0Vda75fXe3XqR/nnsXJEnAQh9nzravy1eWQsdGirjst/qO/Sv7KT3TFUtvkPP4WeUfNXB4JJXEA==
X-Received: by 2002:a19:6b0b:: with SMTP id d11-v6mr15820064lfa.99.1535998212296;
        Mon, 03 Sep 2018 11:10:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x20-v6sm3706062lfi.8.2018.09.03.11.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:10:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 01/24] archive.c: remove implicit dependency the_repository
Date:   Mon,  3 Sep 2018 20:09:09 +0200
Message-Id: <20180903180932.32260-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180903180932.32260-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new "repo" field in archive_args has been added since b612ee202a
(archive.c: avoid access to the_index - 2018-08-13). Use it instead of
hard coding the_repository.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/archive.c b/archive.c
index 0a07b140fe..994495af05 100644
--- a/archive.c
+++ b/archive.c
@@ -391,7 +391,7 @@ static void parse_treeish_arg(const char **argv,
 	if (get_oid(name, &oid))
 		die("Not a valid object name");
 
-	commit = lookup_commit_reference_gently(the_repository, &oid, 1);
+	commit = lookup_commit_reference_gently(ar_args->repo, &oid, 1);
 	if (commit) {
 		commit_sha1 = commit->object.oid.hash;
 		archive_time = commit->date;
-- 
2.19.0.rc0.337.ge906d732e7

