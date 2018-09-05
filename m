Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37BD61F404
	for <e@80x24.org>; Wed,  5 Sep 2018 14:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeIETRM (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 15:17:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36920 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETRM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 15:17:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id f1-v6so3415449plt.4
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xkKKTutPSk5syQnfO1lGp99mQtDmiaSZ8IfI04LzuhA=;
        b=tyYo7YqiUltRPZTyOiHm0ixeGrtinoDojWYrO3CrET77qBikhVCLU4kywT2FhdTKm5
         7LCvtbU+/Cwf5fxh2wcTEd48KtnEgjUTsKfnqfR5KbhL3IqD892hARlpvhP47tSZNR6l
         kDE1rpSW0IVqsrp8DrB1e9/TRGZcnO7Bm9+sZTgK1m3ZHZxLzWQZkzEQqgdH8LxlNW+V
         rA+vHasHyuHH26IMEFOWk4/dHeCVTpmqZeBKr/JMhANKIBFYQ6I/CQkljEEnXuJbgChS
         JPRR0Pb+tERKVd90CC5ohLEDWajj4HTnWgYKN/rzu51phG13X8fs1M3A2/ThW6BNy324
         ibLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xkKKTutPSk5syQnfO1lGp99mQtDmiaSZ8IfI04LzuhA=;
        b=CqVRlfN3CrKv0BPtfptj+GxUZSrBwr97LPQTjc3AXgD55QUiA+og3+ni1j4m9/8pE7
         EshHh2cX52Hljgat36zVAETYRikUZh4NKYvm+fmV4xBfL3XZy5nLWspQ+N90PpyOEfDC
         ZOpqQXFylbhlp3k6csVBqAs7ZtW9Y5DxJQtQd49CNuMjE/O2Lk1v0tswvkL5ca1pZhVm
         iMbZG00nJIFIkOUuTwCUst9et6QfIcCBP7DfPyt4T9uzO55mOG+ivPvRX8vVi5J3lp6B
         xi3Y28w9b1Mf73ePk88PR901aHC6KfhV6C3ePf3RZdNYZnnhjZtZuJoLfS3rdEAZ0A97
         phiw==
X-Gm-Message-State: APzg51D2wJBivV0fx+Ube/bSBjfLvLuKhrczfs+SVW+ups11rXPjSoNm
        +4XIgZm7aIsxYjS6eGn2WyeoaFgs
X-Google-Smtp-Source: ANB0VdZ6MYcnmDA5+cfPJjKCTn757apfvr6NhdXQMR9VB8Fd2SyE20p8SmJ8J6i0JUTRzLGHSO46Yw==
X-Received: by 2002:a17:902:a983:: with SMTP id bh3-v6mr38751869plb.245.1536158800946;
        Wed, 05 Sep 2018 07:46:40 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id s16-v6sm2980367pfm.114.2018.09.05.07.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:46:40 -0700 (PDT)
Date:   Wed, 05 Sep 2018 07:46:40 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Sep 2018 14:46:24 GMT
Message-Id: <58e5c094682fb34e19860eacac788923cf3b5fdb.1536158789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 06/11] multi-pack-index: verify oid fanout order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 9 +++++++++
 t/t5319-multi-pack-index.sh | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/midx.c b/midx.c
index a02b19efc1..dfd26b4d74 100644
--- a/midx.c
+++ b/midx.c
@@ -950,5 +950,14 @@ int verify_midx_file(const char *object_dir)
 			midx_report("failed to load pack in position %d", i);
 	}
 
+	for (i = 0; i < 255; i++) {
+		uint32_t oid_fanout1 = ntohl(m->chunk_oid_fanout[i]);
+		uint32_t oid_fanout2 = ntohl(m->chunk_oid_fanout[i + 1]);
+
+		if (oid_fanout1 > oid_fanout2)
+			midx_report(_("oid fanout out of order: fanout[%d] = %"PRIx32" > %"PRIx32" = fanout[%d]"),
+				    i, oid_fanout1, oid_fanout2, i + 1);
+	}
+
 	return verify_midx_error;
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 52b7f7905b..95ac7a6edd 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -186,6 +186,9 @@ MIDX_CHUNK_LOOKUP_WIDTH=12
 MIDX_OFFSET_PACKNAMES=$(($MIDX_HEADER_SIZE + \
 			 $MIDX_NUM_CHUNKS * $MIDX_CHUNK_LOOKUP_WIDTH))
 MIDX_BYTE_PACKNAME_ORDER=$(($MIDX_OFFSET_PACKNAMES + 2))
+MIDX_OFFSET_OID_FANOUT=$(($MIDX_OFFSET_PACKNAMES + 652))
+MIDX_OID_FANOUT_WIDTH=4
+MIDX_BYTE_OID_FANOUT_ORDER=$((MIDX_OFFSET_OID_FANOUT + 250 * $MIDX_OID_FANOUT_WIDTH + 1))
 
 test_expect_success 'verify bad version' '
 	corrupt_midx_and_verify $MIDX_BYTE_VERSION "\00" $objdir \
@@ -227,6 +230,11 @@ test_expect_success 'verify packnames out of order' '
 		"failed to load pack"
 '
 
+test_expect_success 'verify oid fanout out of order' '
+	corrupt_midx_and_verify $MIDX_BYTE_OID_FANOUT_ORDER "\01" $objdir \
+		"oid fanout out of order"
+'
+
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
 	git repack -adf &&
-- 
gitgitgadget

