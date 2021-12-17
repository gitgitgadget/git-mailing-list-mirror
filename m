Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE5EC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 11:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhLQL2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 06:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbhLQL2n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 06:28:43 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD17AC061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 03:28:43 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so5446210pja.1
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 03:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KNgYidx8vEvIkoF0u7cbJgVUsBPtfO50cr098Upx8nk=;
        b=nDt/BsUirN11JYmJ79MLsUxshumXHzE60osLyU54TPMafJVz1W73Wrcu5KrT1FZC7A
         kHSmXD5AtWf0FCJtx2D4myBgM9+Mj1N7vvdS2F5DXaiWgu+Smd4kYroF+kFxdHbq1Top
         z/7FpVZ6VtRNvmeIawomAcuByNqSua7K7Lfls5fFbCMfE3LL2mia85RAt3J67/wVWa3e
         zOP7rI0Z8JJjiAHs3UhEaXJiucB6LI4dQ2RoFY5NvuzrYm1ZMbIaIbLGiiPAZy/Wf+/x
         IUANQOU1AfUAtX/LOP7tIsnG9cmYCSU8TZMcCyPqMcKI5f89DLp4jXLMYajnHpQmyr/P
         meFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNgYidx8vEvIkoF0u7cbJgVUsBPtfO50cr098Upx8nk=;
        b=UzaWYov9sA0Wm1DOaKbCRf87Zs6JlaO8oFn1aExbOvZdF89+eW+CaJXab+a+SW38Ks
         zAKsCZKxRTK59ulA1QSYtqav+aUhAVCmrjq0OGbbjmXY2xFVbArzzyW1GLeff4L/tSHH
         10XzT52rEMeuFBMAvzm3C8N1RjhlADTJNR/JsWeU+O6drz89g9mT7SPUevRnf9Ggmv8O
         R/su3K9AZk5Jny2KINF8AGyDPSflFLGEOfUmznLKY3EEH+xxM7ww0dmBkgTwdzEG3s3W
         2Kxw4gk33Qsxt2txuA/ZcJA3+fk8CkCZKOGgnNxlAuaOULP/tt9K0mTGRUuyYFjmbndK
         Cirw==
X-Gm-Message-State: AOAM531qPhViH7BzuJAbUbu8fkBkSzEtHCMzy4QnJMvL69zKa29rI8YZ
        n4W4iWTOPJx3eWO2Z8t2zIk=
X-Google-Smtp-Source: ABdhPJx02r46pkepO96LhTb5pcp8K5jFO5Nh/0ynFZpyA3JV52Saxo+BaXfIrcf7lKdqgZJnVfY1rg==
X-Received: by 2002:a17:902:ce92:b0:148:dbf5:1934 with SMTP id f18-20020a170902ce9200b00148dbf51934mr2409804plg.147.1639740523282;
        Fri, 17 Dec 2021 03:28:43 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.97])
        by smtp.gmail.com with ESMTPSA id f10sm5194673pge.33.2021.12.17.03.28.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Dec 2021 03:28:42 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v6 2/6] object-file.c: refactor object header generation into a function
Date:   Fri, 17 Dec 2021 19:26:25 +0800
Message-Id: <20211217112629.12334-3-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.1.52.gfcc2252aea.agit.6.5.6
In-Reply-To: <20211210103435.83656-1-chiyutianyi@gmail.com>
References: <20211210103435.83656-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

There are 3 places where "xsnprintf" is used to generate the object
header, and I originally planned to add a fourth in the latter patch.

According to Ævar Arnfjörð Bjarmason’s suggestion, although it's just
one line, it's also code that's very central to git, so reafactor them
into a function which will help later readability.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/object-file.c b/object-file.c
index 32acf1dad6..95fcd5435d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1006,6 +1006,14 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
+static inline int generate_object_header(char *buf, int bufsz,
+					 const char *type_name,
+					 unsigned long size)
+{
+	return xsnprintf(buf, bufsz, "%s %"PRIuMAX, type_name,
+			 (uintmax_t)size) + 1;
+}
+
 /*
  * With an in-core object data in "map", rehash it to make sure the
  * object name actually matches "oid" to detect object corruption.
@@ -1034,7 +1042,7 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 		return -1;
 
 	/* Generate the header */
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(obj_type), (uintmax_t)size) + 1;
+	hdrlen = generate_object_header(hdr, sizeof(hdr), type_name(obj_type), size);
 
 	/* Sha1.. */
 	r->hash_algo->init_fn(&c);
@@ -1734,7 +1742,7 @@ static void write_object_file_prepare(const struct git_hash_algo *algo,
 	git_hash_ctx c;
 
 	/* Generate the header */
-	*hdrlen = xsnprintf(hdr, *hdrlen, "%s %"PRIuMAX , type, (uintmax_t)len)+1;
+	*hdrlen = generate_object_header(hdr, *hdrlen, type, len);
 
 	/* Sha1.. */
 	algo->init_fn(&c);
@@ -2013,7 +2021,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	buf = read_object(the_repository, oid, &type, &len);
 	if (!buf)
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
-	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
+	hdrlen = generate_object_header(hdr, sizeof(hdr), type_name(type), len);
 	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
 	free(buf);
 
-- 
2.34.1.52.gfcc2252aea.agit.6.5.6

