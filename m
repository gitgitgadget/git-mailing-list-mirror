Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF11EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 13:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjF2NXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 09:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjF2NXR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 09:23:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170FF30C4
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 06:23:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so739504f8f.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688044994; x=1690636994;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dqow5Rj+lUmHA0rkQnFnECqRQpI3+s3NCSqPH9Hhe/o=;
        b=VAQYbUVomtalVzCUbP2pJ4fJPzsV24hllDp6oRGXUxDD05EVXSattIfOH8d/JwNdkR
         XwAyFfOzmdN/ZMjKKtPwrconkfZuh10DwilTSr2Q9PNFZb8TV2dq5x1EU5e3YODdpViW
         id36aecu37AvRLYdxtK3tVMFTPvFjRqHWaqG6IjSRssmVeE+CA8iHzyfLT2CoEkg7CZR
         qy9KUu3mgb604y/ZpEQ+IqvSLCzPgdtjHYmCxc5eHMHGTcN9KB4kwmM1qw+MEj7Ahi+n
         wURRedBcQwN/idp6FoBx8uHOT3IaeifGYWFUa+lVUU1bJ3IuM4ls0gmuCDtvWnoc0QPu
         r4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688044994; x=1690636994;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dqow5Rj+lUmHA0rkQnFnECqRQpI3+s3NCSqPH9Hhe/o=;
        b=YDG/dOiS6oZERdAxKljTAWa8KcaSz0oMjdpSAq01IkdUi2BKGwAa/hbR7iC62Mmno1
         8KXLLWqCQ/kZfEtzL8j03wwQtNlriwHSdSnXG/NFBsRTcoCGN0ajm+HtH8walrVfvE8s
         5rbAFTQoeWUqMtw1lBB2LDKXySW7oCnWMlOOywH0IKB+sABrvgx9zBhGpHxuGQdKVgTA
         Yx3u7s47xmU2NZdJE7XqYHMIGlPy0ByJldDRvxbeVLnGbLny97aecpCoIDufaiWzxc3U
         k0fWCAIHbd8/C4qdifG/EhVJ+JL22GHw0vGgSkU355zFv3wqCNSgzXLjtaPRgRmMYI+l
         9X7Q==
X-Gm-Message-State: AC+VfDyNTt/6U3PapYyYrdBb4jG1guG67Unegsu8/+2tiY4UjwBp50E+
        jQYBdd3/lZW7sTnBoAmAJugCOnpn5wg=
X-Google-Smtp-Source: ACHHUZ50xambgVByZLZWRGBTggjCULIHWtQGor8GkdRvC7ANuaq0PPm+v3Ni/a/cGyooRFTCiTkBnw==
X-Received: by 2002:a05:6000:85:b0:314:dc0:2fca with SMTP id m5-20020a056000008500b003140dc02fcamr3122486wrx.29.1688044994142;
        Thu, 29 Jun 2023 06:23:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15-20020adffb4f000000b00313e4d02be8sm14950339wrs.55.2023.06.29.06.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 06:23:13 -0700 (PDT)
Message-Id: <81118ce106222993ef17586fb0f249d8319f3b90.1688044991.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1554.git.1688044991.gitgitgadget@gmail.com>
References: <pull.1554.git.1688044991.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jun 2023 13:23:09 +0000
Subject: [PATCH 2/3] split-index: accept that a base index can be empty
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are about to fix an ancient bug where `do_read_index()` pretended
that the index was not initialized when there are no index entries.

Before the `index_state` structure gained the `initialized` flag in
913e0e99b6a (unpack_trees(): protect the handcrafted in-core index from
read_cache(), 2008-08-23), that was the best we could do (even if it was
incorrect: it is totally possible to read a Git index file that contains
no index entries).

This pattern was repeated also in 998330ac2e7 (read-cache: look for
shared index files next to the index, too, 2021-08-26), which we fix
here by _not_ mistaking an empty base index for a missing
`sharedindex.*` file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 read-cache.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index b10caa9831c..e15a472f54f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2455,12 +2455,14 @@ int read_index_from(struct index_state *istate, const char *path,
 
 	base_oid_hex = oid_to_hex(&split_index->base_oid);
 	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
-	trace2_region_enter_printf("index", "shared/do_read_index",
-				   the_repository, "%s", base_path);
-	ret = do_read_index(split_index->base, base_path, 0);
-	trace2_region_leave_printf("index", "shared/do_read_index",
-				   the_repository, "%s", base_path);
-	if (!ret) {
+	if (file_exists(base_path)) {
+		trace2_region_enter_printf("index", "shared/do_read_index",
+					the_repository, "%s", base_path);
+
+		ret = do_read_index(split_index->base, base_path, 0);
+		trace2_region_leave_printf("index", "shared/do_read_index",
+					the_repository, "%s", base_path);
+	} else {
 		char *path_copy = xstrdup(path);
 		char *base_path2 = xstrfmt("%s/sharedindex.%s",
 					   dirname(path_copy), base_oid_hex);
-- 
gitgitgadget

