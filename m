Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECDBC4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 12:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiKUMQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 07:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKUMQd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 07:16:33 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FE42A40D
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:16:31 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k7so10402870pll.6
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeIp9rOuzyEvaEOlgJyUIxVO/oBQ4AwQnwPJufw69tA=;
        b=IULMuHiECMQVBE2IYw3F52K/r9Yk3THSUp37HigaSbX8yUE9nYJI7QJWp9hRT8qvL6
         6lafetDnZqhqDV6yX+wb2xgHrRjFKnVD7MXMvlhzIiRLeomoX1OB9/HHgiWmCH1UI3Bp
         G8TPhRLvXXq6n2gqdOYcd1g5hkSk9kNf2UOs/BFmOUO+I94gFaBSRFzyl7xQJMS/YCaQ
         IlBhpvuVfLVN8H2fwHKWwjaXuPdat1oxT3c1fusAJQq+I3QuwOD4ZfhOR2iU4pgEqTVe
         HX3JgUD27JSkuxZs+U6bNoW+7W5UGOuTQFRGmv340tst5YRLNDipzo7bpjDsxNX/1br2
         yWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeIp9rOuzyEvaEOlgJyUIxVO/oBQ4AwQnwPJufw69tA=;
        b=FsawQHg8F9r3VRetKP41tzbvpn5/hUsOZIKD/P8vVQmZxOD8pKkaB9KKOr3iXiqwRu
         ufOZQXqGDHAgO98bAayyDAhrYPz+UQFxsEB4vbpaE4Xyc1cUhZu32zxVIhnadaVqPTmx
         C3/XzPmB4zJKXZH3Ub7iqUcDHJsB3fP0rEWgJd0lcCg6V9BUrnheJWZYIiYBpOKIsFex
         0JL+IAjGHtkXe7VgpkCETDXZ8pYQ5xC2OdjdLzDGq/3DkFtWAQAB59P1um1JhgX5qZ5+
         3bTSxrQjoMTUlP6/cGDKYxCg0m16LmkVqziMfgt+ONuFb3yrruZApDuVPQkqGmhh+uod
         JNTw==
X-Gm-Message-State: ANoB5pntMI/K0RoJcqhbfieaSQFXuAphKI6KnZnMrUolF+PQh0DD/HCF
        r9f/qJbhw5Aqijq2pv6cvCA=
X-Google-Smtp-Source: AA0mqf7nfYbVAEqKq/NGLY4SZJXhWZ/bd4grR8jlnuC5Ic5MVflIVPJ8cTIybkDg0/ng0FG9jpktrA==
X-Received: by 2002:a17:90a:c903:b0:212:fb7e:54c7 with SMTP id v3-20020a17090ac90300b00212fb7e54c7mr20073860pjt.124.1669032991299;
        Mon, 21 Nov 2022 04:16:31 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.53])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903110d00b00176b63535adsm9630098plh.260.2022.11.21.04.16.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Nov 2022 04:16:29 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, XingXin <moweng.xx@antgroup.com>
Subject: [PATCH v4 2/4] pack-bitmap.c: avoid exposing absolute paths
Date:   Mon, 21 Nov 2022 20:16:13 +0800
Message-Id: <9d5a491887b57bbcc30010aa7efb63e316c6d190.1669032426.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.383.g9d5a491887b
In-Reply-To: <cover.1669032425.git.dyroneteng@gmail.com>
References: <cover.1669032425.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

In "open_midx_bitmap_1()" and "open_pack_bitmap_1()", when we find that
there are multiple bitmaps, we will only open the first one and then
leave warnings about the remaining pack information, the information
will contain the absolute path of the repository, for example in a
alternates usage scenario. So let's hide this kind of potentially
sensitive information in this commit.

Found-by: XingXin <moweng.xx@antgroup.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c           | 10 ++++++----
 t/t5310-pack-bitmaps.sh |  5 +++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 982e286bac..aaa2d9a104 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -354,8 +354,8 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	if (bitmap_git->pack || bitmap_git->midx) {
 		struct strbuf buf = STRBUF_INIT;
 		get_midx_filename(&buf, midx->object_dir);
-		/* ignore extra bitmap file; we can only handle one */
-		warning(_("ignoring extra bitmap file: '%s'"), buf.buf);
+		trace2_data_string("bitmap", the_repository,
+				   "ignoring extra midx bitmap file", buf.buf);
 		close(fd);
 		strbuf_release(&buf);
 		return -1;
@@ -429,8 +429,8 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	}
 
 	if (bitmap_git->pack || bitmap_git->midx) {
-		/* ignore extra bitmap file; we can only handle one */
-		warning(_("ignoring extra bitmap file: '%s'"), packfile->pack_name);
+		trace2_data_string("bitmap", the_repository,
+				   "ignoring extra bitmap file", packfile->pack_name);
 		close(fd);
 		return -1;
 	}
@@ -455,6 +455,8 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		return -1;
 	}
 
+	trace2_data_string("bitmap", the_repository, "opened bitmap file",
+			   packfile->pack_name);
 	return 0;
 }
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 6d693eef82..7d8dee41b0 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -428,8 +428,9 @@ test_bitmap_cases () {
 			test_line_count = 2 packs &&
 			test_line_count = 2 bitmaps &&
 
-			git rev-list --use-bitmap-index HEAD 2>err &&
-			grep "ignoring extra bitmap file" err
+			GIT_TRACE2_EVENT=$(pwd)/trace2.txt git rev-list --use-bitmap-index HEAD &&
+			grep "opened bitmap" trace2.txt &&
+			grep "ignoring extra bitmap" trace2.txt
 		)
 	'
 }
-- 
2.38.1.383.g9d5a491887b

