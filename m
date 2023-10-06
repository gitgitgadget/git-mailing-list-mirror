Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7258DE81E1B
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 18:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjJFSJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 14:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjJFSJe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 14:09:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748B5C2
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 11:09:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso2339761f8f.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696615770; x=1697220570; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIQEOaYety1yDxIvVs/Y9j7BwEA2WP62NvKN7YyytUs=;
        b=d+q6hRGBBwHINJ7bDuki/Gyya2WwfAazJbrdGY5SsbX1mQys5NjysguEDESrxl8s22
         yw1yRYljhErEvvTKv+a2P8k1nVJCmbxSt6QxiLimFqFIqFp0qXKwbeSDMLjgBl3UGORi
         TXqHlWpgfmzdS8wq5uQv1NV6/MJnDYSc02uip4KA1uPKSxFXw1F00jlKQW+hXOCNXKoM
         /2DZQXVznEx2eoeXmwr7Uq/zcZbf03TV1SpxqVzHOxh9K8Do2uHG0bPQoZSaZvOf1tsV
         SDRtuLPu+e9S1zvHSLEsBCfajhzd9y+YKLxYjpymVGexSVUSfVr002X7AnFifPaSjcc3
         LlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696615770; x=1697220570;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIQEOaYety1yDxIvVs/Y9j7BwEA2WP62NvKN7YyytUs=;
        b=ATFX4DHY4MQhaCYp/WtaIxg+Na5XH0MzVHHb1KhIKGWX6HN6Ac0y4abng5VSjVFtm/
         +3GMbWVREdqyMN3ONHxUw4w41iNSNrxcdTmrKQJCCd2qNyVngUMr4gahMVqK/ouiEp6+
         0ly9qguiS3z9N1PZF4isBYGcQ/dKYCfzMEZFl+dEVsPThlpNUSwHP0YrAC3/33vTGAYQ
         1h1BtRsI/PkEHgKEusKjY7eHwygoqqQE7U3b/J9WUs7whn+73Mgde425wOyxGVkDMoSi
         kHBrYWByn3C9QQVtOoT0VHN4iQsFh4FSb3O9QBPpgHuNys10p0fnF/kcUfALcfHJrg8/
         odXQ==
X-Gm-Message-State: AOJu0YyfrXrG5xDjVLbXu23f6gua+JS4IOUssjaEWoSDcaeabzPVG+Gt
        SotqGjwwYQSIuGIY5oNJF8TP7ar2sKI=
X-Google-Smtp-Source: AGHT+IESapKOBt7oit3QpH9NMSQPiUPseX7gVtPeUAHQfL2yUbH7zFjVlmOhgT9uzJpi8Texhvj4pw==
X-Received: by 2002:a5d:6687:0:b0:324:8239:2872 with SMTP id l7-20020a5d6687000000b0032482392872mr7858546wru.71.1696615770655;
        Fri, 06 Oct 2023 11:09:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m8-20020a056000180800b00321773bb933sm2142964wrh.77.2023.10.06.11.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:09:30 -0700 (PDT)
Message-ID: <59276a5b3fd1fd3b25db73e096cf0e834af2d4f9.1696615769.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Oct 2023 18:09:26 +0000
Subject: [PATCH 1/4] ref-cache.c: fix prefix matching in ref iteration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update 'cache_ref_iterator_advance' to skip over refs that are not matched
by the given prefix.

Currently, a ref entry is considered "matched" if the entry name is fully
contained within the prefix:

* prefix: "refs/heads/v1"
* entry: "refs/heads/v1.0"

OR if the prefix is fully contained in the entry name:

* prefix: "refs/heads/v1.0"
* entry: "refs/heads/v1"

The first case is always correct, but the second is only correct if the ref
cache entry is a directory, for example:

* prefix: "refs/heads/example"
* entry: "refs/heads/"

Modify the logic in 'cache_ref_iterator_advance' to reflect these
expectations:

1. If 'overlaps_prefix' returns 'PREFIX_EXCLUDES_DIR', then the prefix and
   ref cache entry do not overlap at all. Skip this entry.
2. If 'overlaps_prefix' returns 'PREFIX_WITHIN_DIR', then the prefix matches
   inside this entry if it is a directory. Skip if the entry is not a
   directory, otherwise iterate over it.
3. Otherwise, 'overlaps_prefix' returned 'PREFIX_CONTAINS_DIR', indicating
   that the cache entry (directory or not) is fully contained by or equal to
   the prefix. Iterate over this entry.

Note that condition 2 relies on the names of directory entries having the
appropriate trailing slash. The existing function documentation of
'create_dir_entry' explicitly calls out the trailing slash requirement, so
this is a safe assumption to make.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 refs/ref-cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 2294c4564fb..6e3b725245c 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -412,7 +412,8 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 		if (level->prefix_state == PREFIX_WITHIN_DIR) {
 			entry_prefix_state = overlaps_prefix(entry->name, iter->prefix);
-			if (entry_prefix_state == PREFIX_EXCLUDES_DIR)
+			if (entry_prefix_state == PREFIX_EXCLUDES_DIR ||
+			    (entry_prefix_state == PREFIX_WITHIN_DIR && !(entry->flag & REF_DIR)))
 				continue;
 		} else {
 			entry_prefix_state = level->prefix_state;
-- 
gitgitgadget

