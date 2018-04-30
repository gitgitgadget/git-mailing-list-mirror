Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A354C215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 22:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeD3WH4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 18:07:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52888 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753683AbeD3WHy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 18:07:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id m70so15149521wma.2
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 15:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZRLkWXXj7cNdpjRJ0bpMV+6Vlbjdqtn1vZStVw4DIzs=;
        b=uJoVXlecZlQCJyHQ17isqmDJXUl1lyh3W4qeGwugvrhn6/YbnsRJK5D6ydoZ/YaUxa
         1Ddy1ker4O58EmkpiYGd/dtP6aecdfTId331WO3Vag6NHy566cGgBXTr1QV6exOQwCRl
         tAI80NZcVHFvh2HvGSVBKL4irydEMUCCWy3Qy6sd7zHiw+jDAsKbqSpsGwhw4tmrLcv6
         5AIBJ/HpNN9kWCc4tp2adjVxEK2/vN2Zq+ivGlxU4ZAdO22561+uKWXIbQ/n7xLK6uQf
         yOFLRz0aGzCk+ygyQQJuodBbsbJkMxQc+E6aYJqphGspxTTQ52fvlr49gzqh4znCwvbe
         F/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRLkWXXj7cNdpjRJ0bpMV+6Vlbjdqtn1vZStVw4DIzs=;
        b=VLZjwQvlLbeHvfyvpcyS1pR8Fcjw9yMdfT8iEM6eOO03jcZwfLFS5RjtLVgylh7vmD
         xw20+qOk31MD1FUno3kZcqGLCOjWBN3pMMLF5Q6koCxgDxB23pOOMyCUDGjQ5YZXXEeP
         AM9fD2zxfuVS7j4felP8GvBBhAjNR1O93ps+yIcc4Yxkbkk23mN7JeuD1zTHHdtNqGEx
         YCERzHx1L7IHS7DARsG0xL86BKTdFyp6SqgS3RKreP5+83Wmr1OukrxPSUkyRqxtIWTS
         wwQQaQbVLEx66HQ3DiUXEwrxsHyC2GNw6/+8TylZ7hWFCMTtrPBHE56RzZ+ozD4Qa/l4
         o6Dg==
X-Gm-Message-State: ALQs6tBeXwfEA+1LpODsjfcWDx5h8b3UQvwg1xMkkDRpfxlFtSl6jh97
        dJNBATOFaRBrJBgevhVU4w/JErfE
X-Google-Smtp-Source: AB8JxZqX19b7/9Xqy9ZBemeOrVDD6M7d1mRPdOiXjwlEJHVqdBdzKc+1ScmsKgriDqcZGA5T6huh5w==
X-Received: by 10.28.48.70 with SMTP id w67mr8089320wmw.47.1525126073121;
        Mon, 30 Apr 2018 15:07:53 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l53-v6sm24014633wrc.80.2018.04.30.15.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 15:07:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/9] sha1-name.c: move around the collect_ambiguous() function
Date:   Mon, 30 Apr 2018 22:07:28 +0000
Message-Id: <20180430220734.30133-4-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent change will make use of this static function in the
get_short_oid() function, which is defined above where the
collect_ambiguous() function is now, which would result in a
compilation error due to a forward declaration.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-name.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index cd3b133aae..9d7bbd3e96 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -372,6 +372,12 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	return 0;
 }
 
+static int collect_ambiguous(const struct object_id *oid, void *data)
+{
+	oid_array_append(data, oid);
+	return 0;
+}
+
 static int get_short_oid(const char *name, int len, struct object_id *oid,
 			  unsigned flags)
 {
@@ -421,12 +427,6 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 	return status;
 }
 
-static int collect_ambiguous(const struct object_id *oid, void *data)
-{
-	oid_array_append(data, oid);
-	return 0;
-}
-
 int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
 {
 	struct oid_array collect = OID_ARRAY_INIT;
-- 
2.17.0.290.gded63e768a

