Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86346CCA479
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 12:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiGUMBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 08:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiGUMBO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 08:01:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429514AD5D
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:01:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so3160861wmb.3
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3qyb+AtrK3Eva+W7zLlhyEbDngFfaUwxUJXE3nrWws=;
        b=Z1MlR0cQQbcFZRNV1L04aCV3yTMVgNqrFqd8V8aiDLvus85+hcsLu4+wZWKpSH7Oc2
         KJdUVXR77RNLVypNUVxQaL04wL5vEi35TapOWgmowChLE/oIIRY0Nj7JkWGGcJbHi8xd
         egQm4uhBbwVMvIb2byHsw11UF9z4P3gZEsuuTkQRrIYRBP4vtuD29qbxalXDThfKeXEG
         WBS2LNdpd8Un4VSvQPfZ7JLEp3ci9Ih/eBb2Gg2tSQQmR6ijhIzwwxx2OztEtyCLuQAx
         op5zof3mXjvAX7OeTK8DlhWzgKQhGRW6wXbB0LKaTZqUgGitGagk03QQFFh5H1TWVMBB
         DRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3qyb+AtrK3Eva+W7zLlhyEbDngFfaUwxUJXE3nrWws=;
        b=1uhLgLyQZ2BhNwhOeYcUrHUnzw7KH5CzMlzROXuQ3+rxXM7ogyUA9jgToOAy2M95AP
         5Yf4nxoZKKK01jBVHu6J0AfrKal+VReG/wcNFjkSP/D2lWsnRl7qa+zEXDbHNtC7WRHp
         C7eu7z9h5BZYSVgzMh9PyuZgbz6rXAHm+iQqYwTkzDjSIOL6sSBWbRKegZVhG1SsnDDK
         MMmJptNZoGiVDw1plADNT9t/TXRunpvwtox63GqkSKnZOcocLVA4DVBOaIUENL2PxblS
         ylt3LznXqb+BJ8SXbBJl7xxHzfSEqu2/vpjk3MfrW9zKWs1GTk0Z+Uf2Hll8iOjxtMdo
         PZvg==
X-Gm-Message-State: AJIora+5OCd3s42+M2hGm39fykDvHlNsxUYbff76N5P+vm+D2muTRcYj
        rGmVdwLZBF7OB4WP5vyr+qZveh5RBLCPxg==
X-Google-Smtp-Source: AGRyM1vBm1tq61Dm2SXB0y7IdFxa4OQbxCuDn29NIJNKxGHxbbd7XpglOEorgFe8ODe9WE1G0SBwMA==
X-Received: by 2002:a7b:cb58:0:b0:3a2:aefb:a4b with SMTP id v24-20020a7bcb58000000b003a2aefb0a4bmr8671186wmj.84.1658404871442;
        Thu, 21 Jul 2022 05:01:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c420300b003a3200bc788sm5226069wmh.33.2022.07.21.05.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 05:01:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/6] cocci: apply string_list.cocci with --disable-worth-trying-opt
Date:   Thu, 21 Jul 2022 14:00:49 +0200
Message-Id: <patch-v2-2.6-33e551a2f4c-20220721T111808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-v2-0.6-00000000000-20220721T111808Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220721T063543Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20220721T111808Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the new string-list.cocci added in the preceding commit with
--disable-worth-trying-opt. For optimization purposes we run spatch in
a mode where even though we run it with --all-includes we'll miss some
changes because we don't use --disable-worth-trying-opt.

This is because without that option it'll take a look at
notes-utils.c, and conclude that it doesn't need to process
it (irrelevant output excluded with "[...]"):

	$ spatch --sp-file contrib/coccinelle/string-list.cocci --patch . notes-utils.c
	[...]
	(ONCE) Expected tokens string_list strdup_strings CALLOC_ARRAY
	Skipping: notes-utils.c

This is just one of the known (and probably some unknown) issues where
our "make coccicheck" fails to include changes for whatever
reason. That should be fixed more generally, but let's just fix this
manually for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 notes-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/notes-utils.c b/notes-utils.c
index d7d18e30f5a..73559d24ec8 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -129,8 +129,8 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
 	c->cmd = cmd;
 	c->enabled = 1;
 	c->combine = combine_notes_concatenate;
-	CALLOC_ARRAY(c->refs, 1);
-	c->refs->strdup_strings = 1;
+	ALLOC_ARRAY(c->refs, 1);
+	string_list_init_dup(c->refs);
 	c->refs_from_env = 0;
 	c->mode_from_env = 0;
 	if (rewrite_mode_env) {
-- 
2.37.1.1095.g64a1e8362fd

