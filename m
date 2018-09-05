Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78D811F404
	for <e@80x24.org>; Wed,  5 Sep 2018 14:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeIETRK (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 15:17:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36917 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 15:17:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id f1-v6so3415388plt.4
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 07:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Os3k6YEGI9mtaZNVL6yQ32jNpPU0T1a6O92GxHeQ6tc=;
        b=c2eXVtKAi2rH0DrbEffHwgpl4mOl6Xk17/mfI5ZaytYK6LqpW98d4SAIwgddA6xLPH
         7O+s336lWRFlMv9nvgs6FG0UxPZT3HKU4z4okEYqv4Re0gMfLFSyKOG/nvrKeDqVccnN
         Hux2QaQYLa2wy9uSj900WMYauJ+QfbmAH7Mf0DqFsMRtTYLAeU586d4nk8g4uHVpBaRp
         jbW19zNZLdAuklSuLMV1Ifpoojb2MkROeO5kgvYkGnOyMeK9TBNO2Q6klJC2s08vkncr
         3CaZIm7jmL6Ugv9G1F0zL1M1fdTomYPgFJ+wkWDuz9vJnT+wAc5ZsmKkq1P9+rjStkG1
         7gYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Os3k6YEGI9mtaZNVL6yQ32jNpPU0T1a6O92GxHeQ6tc=;
        b=J2xIWIID/CNDn1IwRirfhrzhLX5H9buruDM9yANiBllFsK+VnNhNrHp818kJpKnIW2
         gmXmrzCkXDT4Ki0K3HzUMlUxCywHveBW3iMZiVNjJzCF6BA1sGHvSoiZrucZEJgfrBDS
         0aBbTbY2o8PI3BOIG+a9LpquMy+4Jrzyrpa3MRKxke9j29thJCoNWeMwsjUsVqKZ3Agh
         MWSorgoBx5yoz8XlHoDZC2qA6+WhSaIyqoGoVGEMohkauAu9eUPC42KYQoxLT0SQxs0U
         pnYw3KCMV6w+4Z5/UpyHqk350Smb7txloJyWVNF8ozvikik/uyLbLZwWmBaaNrAg506I
         ZJLw==
X-Gm-Message-State: APzg51Dr/cUoelTbOkOpdua6HDr0Nf0ye2SiWhypX6OnIrav2M3NAKR8
        zlTvbIJoN7E3mLlxHjxj9x5GOogv
X-Google-Smtp-Source: ANB0Vda0fUpAHyTMoCOD7I3YpRApPtDuQLRJ+KRhLjqilycZYTjPEgNY4BRiOjPZJoEFlTmFDMHz+A==
X-Received: by 2002:a17:902:a983:: with SMTP id bh3-v6mr38751654plb.245.1536158798200;
        Wed, 05 Sep 2018 07:46:38 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id i20-v6sm3204241pfj.82.2018.09.05.07.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:46:37 -0700 (PDT)
Date:   Wed, 05 Sep 2018 07:46:37 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Sep 2018 14:46:22 GMT
Message-Id: <37ee24c82bf88611808ec3bb1c36eef439c809db.1536158789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 04/11] multi-pack-index: verify packname order
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

The final check we make while loading a multi-pack-index is that
the packfile names are in lexicographical order. Make this error
be a die() instead.

In order to test this condition, we need multiple packfiles.
Earlier in t5319-multi-pack-index.sh, we tested the interaction with
'git repack' but this limits us to one packfile in our object dir.
Move these repack tests until after the 'verify' tests.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      |  6 ++----
 t/t5319-multi-pack-index.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/midx.c b/midx.c
index 8b054b39ab..e655a15aed 100644
--- a/midx.c
+++ b/midx.c
@@ -157,12 +157,10 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 
 		cur_pack_name += strlen(cur_pack_name) + 1;
 
-		if (i && strcmp(m->pack_names[i], m->pack_names[i - 1]) <= 0) {
-			error(_("multi-pack-index pack names out of order: '%s' before '%s'"),
+		if (i && strcmp(m->pack_names[i], m->pack_names[i - 1]) <= 0)
+			die(_("multi-pack-index pack names out of order: '%s' before '%s'"),
 			      m->pack_names[i - 1],
 			      m->pack_names[i]);
-			goto cleanup_fail;
-		}
 	}
 
 	return m;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 5c9c499aa6..4a8f231d93 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -181,6 +181,11 @@ MIDX_BYTE_CHUNK_COUNT=6
 MIDX_HEADER_SIZE=12
 MIDX_BYTE_CHUNK_ID=$MIDX_HEADER_SIZE
 MIDX_BYTE_CHUNK_OFFSET=$(($MIDX_HEADER_SIZE + 4))
+MIDX_NUM_CHUNKS=5
+MIDX_CHUNK_LOOKUP_WIDTH=12
+MIDX_OFFSET_PACKNAMES=$(($MIDX_HEADER_SIZE + \
+			 $MIDX_NUM_CHUNKS * $MIDX_CHUNK_LOOKUP_WIDTH))
+MIDX_BYTE_PACKNAME_ORDER=$(($MIDX_OFFSET_PACKNAMES + 2))
 
 test_expect_success 'verify bad version' '
 	corrupt_midx_and_verify $MIDX_BYTE_VERSION "\00" $objdir \
@@ -212,6 +217,11 @@ test_expect_success 'verify invalid chunk offset' '
 		"invalid chunk offset (too large)"
 '
 
+test_expect_success 'verify packnames out of order' '
+	corrupt_midx_and_verify $MIDX_BYTE_PACKNAME_ORDER "z" $objdir \
+		"pack names out of order"
+'
+
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
 	git repack -adf &&
-- 
gitgitgadget

