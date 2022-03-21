Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49089C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 07:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344924AbiCUHfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344925AbiCUHfG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 03:35:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFE1186FD
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:33:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o68-20020a17090a0a4a00b001c686a48263so7017044pjo.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8KvgDMkGTVIZ7rFKOZDIQPb1H6uqVbE3nFPXjxkaEU=;
        b=m77zGxGb6OCd8xveQtQzfkQ6RdbyHhRdFQykTtDN/yDtYXAHFg9Ca+PvPKoaKBl0kS
         xrcQYwliE8r4skJ7+m2NXek0bjGP6Ue/JeHan+fLT/08IJUYZyP0Vl/R7nZDC+KmLPsV
         egqLeXrxqDeFci22oRUZoJx89qUgBWYzwPwn7/MoKcA/oDintydFA7MLgJM2ygeBYwai
         wLhvqNZB3g369THtOyhol05q5CuFQjtmg0to3x4iH/7MLdOirb28C+PQm4PS4rWpCmzX
         57f7QUBg/yoVJdOJYj9p+u4emoeuTh31LSiA/Awu4eL9H2J8RccEg/Y5Yvd1czHXHTP4
         9Eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8KvgDMkGTVIZ7rFKOZDIQPb1H6uqVbE3nFPXjxkaEU=;
        b=pEFRLZKgBjUq9cv+xSyI9oW/zP0l92lVLwDZBho5xwB4xnq6I2uLJh/Z1VBv5Xazwv
         9kOUXIgUusvDK4BLkHatvSkUMYcuNL2pw1KdlTMhp2U6arXlHfFB4LG4TuQxmYpm29V9
         aGWOXsVHww9621eJGFE/dxN0Daf40AURpJTSdaEbc75ulnoWgwdlGGpM+k+cc38LoYr0
         LnTVZGnKfTmzyqSNOkFngNwhn3EpU++V1yMabnhY8j9wKlp9y1NE2yHpDWolBJYYnmdr
         j77TMM1QQ2UbaKgEOVguzgMDbJkz6jwV3cYQ8q+oeLjKBVdqhuU6sP35bXwLqI2t/Jbk
         6iEQ==
X-Gm-Message-State: AOAM5301sMUZvUEcwTQaJsw+SJuT3g12ktBVsaiw4ZqMAFrIYd8Bh9II
        9erOnxOtql0RttLBzvT2Weo=
X-Google-Smtp-Source: ABdhPJxEqlgdN6AB0+FtT7HSOxfWk0lv2/VsBGrkL5lD0qAQOtb+7hua3j2PKnUdPErghg/LvG6xWQ==
X-Received: by 2002:a17:903:1ce:b0:150:2117:16b3 with SMTP id e14-20020a17090301ce00b00150211716b3mr11696511plh.26.1647848020212;
        Mon, 21 Mar 2022 00:33:40 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.46])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm18914422pju.8.2022.03.21.00.33.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:33:39 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v13 01/16] ls-tree: remove commented-out code
Date:   Mon, 21 Mar 2022 15:33:15 +0800
Message-Id: <2fcff7e0d40255e0be9496647787352dd0aeb784.1647846935.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.406.g2e0e55130e
In-Reply-To: <cover.1647846935.git.dyroneteng@gmail.com>
References: <cover.1647846935.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Remove code added in f35a6d3bce7 (Teach core object handling functions
about gitlinks, 2007-04-09), later patched in 7d0b18a4da1 (Add output
flushing before fork(), 2008-08-04), and then finally ending up in its
current form in d3bee161fef (tree.c: allow read_tree_recursive() to
traverse gitlink entries, 2009-01-25). All while being commented-out!

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3a442631c7..5f7c84950c 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -69,15 +69,6 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	const char *type = blob_type;
 
 	if (S_ISGITLINK(mode)) {
-		/*
-		 * Maybe we want to have some recursive version here?
-		 *
-		 * Something similar to this incomplete example:
-		 *
-		if (show_subprojects(base, baselen, pathname))
-			retval = READ_TREE_RECURSIVE;
-		 *
-		 */
 		type = commit_type;
 	} else if (S_ISDIR(mode)) {
 		if (show_recursive(base->buf, base->len, pathname)) {
-- 
2.34.1.406.g2e0e55130e

