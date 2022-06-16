Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EBBC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 13:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376971AbiFPNOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376938AbiFPNN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 09:13:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FD9369EE
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:13:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso2807677wms.3
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZPl6Zq2JI8wNCS5ZExHetDtnJijrCm3i3KuNoQFRYMM=;
        b=UJE/+dSx6veaIQoOpSA5Oq0m002Kav7oujFMJVZwu5Kq17qIjE0RgKl5xpMl7sZ1l0
         geWorQn6Azp1cTe5m2O700P66CRGuuK+L29bkkceag0yvl4o26vCRc9ujlSjPxrPn9Xw
         oCkKmmGIu1rkPtq+zj9avw234qDINUUVsB5uVdvhrPuRrZvm1cKgIb3Fi6Rq127AfYLd
         PE5wYRHLImZem0HLRoQs8MxwCg0alagyJJKwbnVmYoysgpnVa07O850rSsQRVti8OtjF
         IuaQ5JkHTYf3IegF5/TKUCNnzOcg8Gftulz4TTkV6rXH1GsYZrXqIezeAJHVpMkB3lWT
         Gkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZPl6Zq2JI8wNCS5ZExHetDtnJijrCm3i3KuNoQFRYMM=;
        b=Wc3MivBJkoK9mUPYOY6KU/uxRP4zM+Z4j/JLSXN6804ApB+zhN9YTSwB5ML8u8m47b
         Z8vgYbwxyNzyuKoGl+LSIl/yxtHkxUOU7yS1pb72r8zb3RK3eUYZFS/pOh81zWCm/Nat
         FnG10qRvhJGNoopw2EH1opbdnlqYWfLG5L0tolzes4Q2rCds99ZMy6Lwz5KR7x2lZuDa
         fDYH/bmyQzgKgM3n0xIQDkcyNi+7pUat3ays2jN0T9iukhtDPIQ43Xj1KxuT4kuIUl4o
         cr40PRjnsAlz6NA5uU9FbXilDhs+ci+WLpE8xBmW6balpfncHw2SwO2qwnyO8I3Ws3v9
         zVXQ==
X-Gm-Message-State: AOAM530gxbpnSOBT5+SR1BkYDrY7iLPWHmgLPbIplh8cG76M+B2laiJ7
        AxlSk7eZrl8fyEf6uSkw7oBeVXIvUBHqOA==
X-Google-Smtp-Source: ABdhPJx/e/xVLDF5wv/LeJ9tlGumVW8yVQCNoHkKCdb25kTEpbkQVDDj3+cZcesIbzhyD7kNjD+Gjw==
X-Received: by 2002:a05:600c:1e1c:b0:39c:65a1:7c3a with SMTP id ay28-20020a05600c1e1c00b0039c65a17c3amr15762921wmb.6.1655385235120;
        Thu, 16 Jun 2022 06:13:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r66-20020a1c2b45000000b0039c97cc82fbsm5912829wmr.15.2022.06.16.06.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:13:54 -0700 (PDT)
Message-Id: <b956a371c7083985eb7ceedc2b9c8fc65a0d43dc.1655385230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v2.git.1655385230.gitgitgadget@gmail.com>
References: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
        <pull.1261.v2.git.1655385230.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jun 2022 13:13:49 +0000
Subject: [PATCH v2 3/4] pack-write: drop always-NULL parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

write_mtimes_file() takes an mtimes parameter as its first option, but
the only caller passes a NULL constant. Drop this parameter to simplify
logic. This can be reverted if that parameter is needed in the future.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 pack-write.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 23c0342018f..00787e306db 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -310,26 +310,21 @@ static void write_mtimes_trailer(struct hashfile *f, const unsigned char *hash)
 	hashwrite(f, hash, the_hash_algo->rawsz);
 }
 
-static const char *write_mtimes_file(const char *mtimes_name,
-				     struct packing_data *to_pack,
+static const char *write_mtimes_file(struct packing_data *to_pack,
 				     struct pack_idx_entry **objects,
 				     uint32_t nr_objects,
 				     const unsigned char *hash)
 {
+	struct strbuf tmp_file = STRBUF_INIT;
+	const char *mtimes_name;
 	struct hashfile *f;
 	int fd;
 
 	if (!to_pack)
 		BUG("cannot call write_mtimes_file with NULL packing_data");
 
-	if (!mtimes_name) {
-		struct strbuf tmp_file = STRBUF_INIT;
-		fd = odb_mkstemp(&tmp_file, "pack/tmp_mtimes_XXXXXX");
-		mtimes_name = strbuf_detach(&tmp_file, NULL);
-	} else {
-		unlink(mtimes_name);
-		fd = xopen(mtimes_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
-	}
+	fd = odb_mkstemp(&tmp_file, "pack/tmp_mtimes_XXXXXX");
+	mtimes_name = strbuf_detach(&tmp_file, NULL);
 	f = hashfd(fd, mtimes_name);
 
 	write_mtimes_header(f);
@@ -561,7 +556,7 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 				      pack_idx_opts->flags);
 
 	if (pack_idx_opts->flags & WRITE_MTIMES) {
-		mtimes_tmp_name = write_mtimes_file(NULL, to_pack, written_list,
+		mtimes_tmp_name = write_mtimes_file(to_pack, written_list,
 						    nr_written,
 						    hash);
 	}
-- 
gitgitgadget

