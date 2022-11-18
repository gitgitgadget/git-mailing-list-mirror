Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CBAC433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbiKRLbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbiKRLbL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:31:11 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E88657D5
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:10 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ft34so12222496ejc.12
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsN24FiGThVCiFLj1F8wmsGzQQXOIrBT8Rv0AjlwYq0=;
        b=J3Cld798+n7yaHqmQRtnbn2C1/rul4qiFpusPJ5R036yvI2bzczGv/pOqHTcYZpfon
         mMDTTRa+alEcZ8UBxtCYVFykEQNTtPnHqcz9qoFt8fmnOMwz52sYZ7ESmjqMq+DmLQxJ
         ki1Z/XIzFa9BSmzjOLM694t26Pl84olSZFZNG8Q520L4gyEPVN5JUnA5L1PuXN+ti3h3
         WyT811hb4n4Moigpdl0BQYq35g6f22FunXgtmHa5Xw7QT1m23ih+XBerFcuEdNdxvXlC
         vcap5Bm70x4AxCRhM/CahhouZTlvl3bf05TaqIxdQ8T1nURPsoz/0BlVbOvPQva3/FQv
         sZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsN24FiGThVCiFLj1F8wmsGzQQXOIrBT8Rv0AjlwYq0=;
        b=sycHiU6akAPWRECT54xNtP+INTeIzpDc8bJZbxw2HJwZ0gxLeqqwAfQtvOpzTRrRj3
         VnjlVFDq0kuQduwdkEXCfYAFh2wSFDdz2U9jPCF3nDPbjHMntcXnG9WhK0ZJvplmpiOY
         9Sr05URQ3CvEdEDvnV+BkFwDXZ9YMIIIJ5x/QCKg985cqYn5UrWvS5h7F6JOnkk0ZqtU
         +tFgIjWCLaLfh0JsknZfeRLTT1NQ/K8B99c/ljzz/6SRacDtZNKE2P+/RGyzbZwtfk9b
         IrzeY/KI3tmfuycJBd62NhKuW3n7jeWoiy+aeDA6ln2CqzlEibQcyYpAgWnVS3XxJqyK
         dpfA==
X-Gm-Message-State: ANoB5plVNnOr0xk9PYdSH6MJNZEwmys/5oBo5buk9aZSQrV8YV6LYjsz
        vMQ4x1rrCsx2nZLIrzklkcRTFAtM+nt4Iw==
X-Google-Smtp-Source: AA0mqf6mAbpwvnImiP4sPbv0OaVy9xhk1NYyxsK+jgzFAzOYMWspsb9QmnQ3OtAJm0xxhIgY1Ghw4w==
X-Received: by 2002:a17:906:2614:b0:7ad:934e:95d3 with SMTP id h20-20020a170906261400b007ad934e95d3mr5598075ejc.393.1668771069124;
        Fri, 18 Nov 2022 03:31:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id cw24-20020a056402229800b0046730154ccbsm1713302edb.42.2022.11.18.03.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:31:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/12] cache.h: remove unused "the_index" compat macros
Date:   Fri, 18 Nov 2022 12:30:55 +0100
Message-Id: <patch-01.12-760b4ddf06a-20221118T112205Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "active_alloc" macro added in 228e94f9357 (Move index-related
variables into a structure., 2007-04-01) has not been used since
4aab5b46f44 (Make read-cache.c "the_index" free., 2007-04-01). Let's
remove it.

The rest of these are likewise unused, so let's not keep them
around. E.g. 12cd0bf9b02 (dir: stop using the index compatibility
macros, 2017-05-05) is the last use of "cache_dir_exists".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/cache.h b/cache.h
index 26ed03bd6de..29bb0ad2b41 100644
--- a/cache.h
+++ b/cache.h
@@ -438,7 +438,6 @@ extern struct index_state the_index;
 
 #define active_cache (the_index.cache)
 #define active_nr (the_index.cache_nr)
-#define active_alloc (the_index.cache_alloc)
 #define active_cache_changed (the_index.cache_changed)
 #define active_cache_tree (the_index.cache_tree)
 
@@ -452,7 +451,6 @@ extern struct index_state the_index;
 #define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
 #define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), (option))
 #define rename_cache_entry_at(pos, new_name) rename_index_entry_at(&the_index, (pos), (new_name))
-#define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
 #define add_to_cache(path, st, flags) add_to_index(&the_index, (path), (st), (flags))
 #define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
@@ -461,13 +459,10 @@ extern struct index_state the_index;
 #define refresh_and_write_cache(refresh_flags, write_flags, gentle) repo_refresh_and_write_index(the_repository, (refresh_flags), (write_flags), (gentle), NULL, NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
-#define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
 #define cache_file_exists(name, namelen, igncase) index_file_exists(&the_index, (name), (namelen), (igncase))
 #define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
 #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
 #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
-#define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
-#define read_blob_data_from_cache(path, sz) read_blob_data_from_index(&the_index, (path), (sz))
 #define hold_locked_index(lock_file, flags) repo_hold_locked_index(the_repository, (lock_file), (flags))
 #endif
 
-- 
2.38.0.1511.gcdcff1f1dc2

