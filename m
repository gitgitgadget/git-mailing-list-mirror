Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD04C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiCDSdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiCDSdK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:33:10 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A901D3AF4
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:32:22 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c192so5506691wma.4
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2IQFsvBVCf5hqCcI1bLBH7Knhiqd3lfH3LR7KkxHzHE=;
        b=hBRTEuGdZupGMKuINi3s21hr+1ZdFo3ezbigHMjOBX6karxPG+f/zW8WbtzpGPxWQx
         mgl3ClPlU+7tZ4u18pnD3SvcL6lIwqQ51n1mvdB8xNuv1WRiqs9ZmSwy7JPwusgBB3z2
         /XTX3Wx0nhy1kK04dffqSHVL8r3O2fPEot+pARbNhBxM1W9eOScaYe2Gql+vdmRP0w63
         cZCcjiupUMjc242c/529ZLBFW2JQQTGu5odFwKq62XVLpOgOKZjPhIoj77YuS91Jowxh
         Ccz1FrB6AECl047Q9Wh7Kx3R+PienjATfN4ttIhOeRABGEFOwfnXe2A0DW+NoQfbcIvs
         7sJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2IQFsvBVCf5hqCcI1bLBH7Knhiqd3lfH3LR7KkxHzHE=;
        b=ywhoEepySpjpBeW5aHuGz4oFYK4kPM1J1xeXwu0AE7CY6HhIhRUY6p4p6umlr1vKxx
         ZxK5PCrOEKeLXEAAV32i5GlXAlZETkBUc0dllsDGCIQ2aOBZze01ucR3t9wnV2DjFfFe
         Hb38Ize4fqnHc4kcl+zYDdsubjbRwtayJicQBvcffBx5XMwS1RFEJeP7dQ4MOsgVgDC1
         /CWQOgInqf0SMPbUcNbVsNyT5PG/45GavK8ZMKkOE/K62D8ZpAQxNGhYCstsp6Wp7L1T
         Zzfmtb2JEqWVNj/Gm1QS6EhdOpZEeWMgwFRnfy1Qz+LaSagv8xc6HWwdm/3Sc4kIHapp
         56BA==
X-Gm-Message-State: AOAM533NJQcj8qI58i2s9s+nblzqyz8xqq7mCQBORGSQkmnBALWwZHrU
        a42VkYIiISV4bIErIAlnVonODEPVinnbXg==
X-Google-Smtp-Source: ABdhPJy5JkVzjBqADvnPHIf/+iEoz/NO49nUh/TR6QD2x/+4WjHAeu1cm60xtRcqfDB/cIutOzfUfg==
X-Received: by 2002:a05:600c:1988:b0:37c:505:d45c with SMTP id t8-20020a05600c198800b0037c0505d45cmr8590637wmq.107.1646418740714;
        Fri, 04 Mar 2022 10:32:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm10573990wmg.7.2022.03.04.10.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:32:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/14] index-pack: fix memory leaks
Date:   Fri,  4 Mar 2022 19:32:04 +0100
Message-Id: <patch-v2-01.14-f46af9ad13f-20220304T182902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1248.gb68c9165ad8
In-Reply-To: <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix various memory leaks in "git index-pack", due to how tightly
coupled this command is with the revision walking this doesn't make
any new tests pass.

But e.g. this now passes, and had several failures before, i.e. we
still have failures in tests 3, 5 etc., which are being skipped here.

    ./t5300-pack-object.sh --run=1-2,4,6-27,30-42

It is a bit odd that we'll free "opts.anomaly", since the "opts" is a
"struct pack_idx_option" declared in pack.h. In pack-write.c there's a
reset_pack_idx_option(), but it only wipes the contents, but doesn't
free() anything.

Doing this here in cmd_index_pack() is correct because while the
struct is declared in pack.h, this code in builtin/index-pack.c (in
read_v2_anomalous_offsets()) is what allocates the "opts.anomaly", so
we should also free it here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/index-pack.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3c2e6aee3cc..5fe1adb3681 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1109,6 +1109,7 @@ static void *threaded_second_pass(void *data)
 			list_add(&child->list, &work_head);
 			base_cache_used += child->size;
 			prune_base_data(NULL);
+			free_base_data(child);
 		} else {
 			/*
 			 * This child does not have its own children. It may be
@@ -1131,6 +1132,7 @@ static void *threaded_second_pass(void *data)
 
 				p = next_p;
 			}
+			FREE_AND_NULL(child);
 		}
 		work_unlock();
 	}
@@ -1424,6 +1426,7 @@ static void fix_unresolved_deltas(struct hashfile *f)
 		 * object).
 		 */
 		append_obj_to_pack(f, d->oid.hash, data, size, type);
+		free(data);
 		threaded_second_pass(NULL);
 
 		display_progress(progress, nr_resolved_deltas);
@@ -1703,6 +1706,7 @@ static void show_pack_info(int stat_only)
 			  i + 1,
 			  chain_histogram[i]);
 	}
+	free(chain_histogram);
 }
 
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
@@ -1932,6 +1936,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (do_fsck_object && fsck_finish(&fsck_options))
 		die(_("fsck error in pack objects"));
 
+	free(opts.anomaly);
 	free(objects);
 	strbuf_release(&index_name_buf);
 	strbuf_release(&rev_index_name_buf);
-- 
2.35.1.1248.gb68c9165ad8

