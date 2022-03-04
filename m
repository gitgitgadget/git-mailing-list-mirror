Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B64C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiCDSdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241725AbiCDSdj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:33:39 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6754348A
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:32:35 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t11so13931605wrm.5
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=biscRxfKROGZ9fv2uYs71e8IjrSP/5N6J9T2ZXtbHYk=;
        b=VpnXAOgGorkEscx/bhxnPdOYNqSgcsZNIN8bbxvEua5cZ41gC+lz9mqRk6B4MkA4cQ
         VBrYSQL8PsTcGMvN1t3QEBTyVtqLwf9G/iJ5waxhjN9Jwb4bXXpAoX0xP/kqAz8zw22G
         Uf4DdrVcaug3MF/rZ9aGlR3oJZco0CEQfy6BTWabPNkxcYIh1SID2Y6JMCalxBXC1YuJ
         MP3mGq2fgqy8p+2GUx1O0m/a/tcTw+qqcW0qfRjZrgfC4pq5ujdU+cB4VSqgIRoeLBEN
         neuSgdM32yDY7t0Otq99E6VHEjoRuLDI18AFg7n/sybaKYxbdZr2cC9Jbwe0FlghBpcY
         14ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=biscRxfKROGZ9fv2uYs71e8IjrSP/5N6J9T2ZXtbHYk=;
        b=z7iWk1nZ/Trc8Ms6DaXbIDMLExUzuPWlvygwhFXJ/O9u9b92RZHOzu/O8iI4keFUNU
         jqAQ8z1X9NwZ4ftbJ6NM46h4l4OkELuj/2aJE6wcM4pRhmeWrN4sSw2Axf7E7HtgtyRn
         H3icy5RFTL0Xr9GHTdNw9+ut6qRCpFsl7h5Oll03u0UbYmn2t4drEPONkbGF0pWsvndL
         Ztcc2XAQYkL/Bdn6+ZNe/MVGJO7H3nw0EfuVHLQ7hpBIBNM0Z61ilj3edEzKrE8yanhg
         TPogFDcV5spdOB/rWe8QMJUhgXc4d9RdSjH+vIQtut1pBERqVvTDEY78OK5bOVogsGs8
         ZVJg==
X-Gm-Message-State: AOAM531mn/GSf40LT+/ghhc+4zZGM7Gv5XCmPMpiFZwEmrn1pRqsdBRy
        HX1M7Q1Uw1adDPijpRVziVd9cC4dHlj45A==
X-Google-Smtp-Source: ABdhPJzxwnP+5mqxisliyaph81Te4p/54qfeGTFRGlQNoSMb/22CMSczj3ARdIRug8qbDtRy4BuHuw==
X-Received: by 2002:adf:e98c:0:b0:1f0:2f5c:2e9 with SMTP id h12-20020adfe98c000000b001f02f5c02e9mr40952wrm.356.1646418753660;
        Fri, 04 Mar 2022 10:32:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm10573990wmg.7.2022.03.04.10.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:32:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/14] range-diff: plug memory leak in common invocation
Date:   Fri,  4 Mar 2022 19:32:15 +0100
Message-Id: <patch-v2-12.14-148382d9529-20220304T182902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1248.gb68c9165ad8
In-Reply-To: <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a public release_patch() version of the private free_patch()
function added in 13b5af22f39 (apply: move libified code from
builtin/apply.c to apply.{c,h}, 2016-04-22). Unlike the existing
function this one doesn't free() the "struct patch" itself, so we can
use it for variables on the stack.

Use it in range-diff.c to fix a memory leak in common range-diff
invocations, e.g.:

    git -P range-diff origin/master origin/next origin/seen

Would emit several errors when compiled with SANITIZE=leak, but now
runs cleanly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 apply.c      | 7 ++++++-
 apply.h      | 2 ++
 range-diff.c | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 0912307bd91..01f91816428 100644
--- a/apply.c
+++ b/apply.c
@@ -219,13 +219,18 @@ static void free_fragment_list(struct fragment *list)
 	}
 }
 
-static void free_patch(struct patch *patch)
+void release_patch(struct patch *patch)
 {
 	free_fragment_list(patch->fragments);
 	free(patch->def_name);
 	free(patch->old_name);
 	free(patch->new_name);
 	free(patch->result);
+}
+
+static void free_patch(struct patch *patch)
+{
+	release_patch(patch);
 	free(patch);
 }
 
diff --git a/apply.h b/apply.h
index 4052da50c06..b9f18ce87d1 100644
--- a/apply.h
+++ b/apply.h
@@ -173,6 +173,8 @@ int parse_git_diff_header(struct strbuf *root,
 			  unsigned int size,
 			  struct patch *patch);
 
+void release_patch(struct patch *patch);
+
 /*
  * Some aspects of the apply behavior are controlled by the following
  * bits in the "options" parameter passed to apply_all_patches().
diff --git a/range-diff.c b/range-diff.c
index 30a4de5c2d8..b2a2961f521 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -165,6 +165,7 @@ static int read_patches(const char *range, struct string_list *list,
 					    patch.old_mode, patch.new_mode);
 
 			strbuf_addstr(&buf, " ##");
+			release_patch(&patch);
 		} else if (in_header) {
 			if (starts_with(line, "Author: ")) {
 				strbuf_addstr(&buf, " ## Metadata ##\n");
-- 
2.35.1.1248.gb68c9165ad8

