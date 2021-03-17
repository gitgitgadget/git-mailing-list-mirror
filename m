Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFFEC433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2499C64F09
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhCQTDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 15:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhCQTDR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 15:03:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBB8C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 12:03:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id 61so2935634wrm.12
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=D7MJywA/hE9WubOaGzvIC0UthKf3wMZhvuNzhGQPb70=;
        b=XuwdhAS49mSycxFma9AaAFwJfjiGfNAdnvFv4cPmVuWESCJMjxyDT8+ne3il18UsIn
         smhukxQ6a/j751AxNVy/OU+iqzRlabWcruBZDmFelrHfNPORh4OhdG7he4eG/BN2GmAd
         73F46VJnR7EP9uCpzX3kaC7ogSIiZeBMsWmOmv2sSCcQKUPtgS8y08uQLmPnu8p+fzdF
         EUxL0V3gL/kuxlXfk1olCeZLHBJPCivdEEnMUOJ1/yk0RSuKIAxt92t5nPpL5YYnUmZ8
         s38owMAoH9RU/TJ9lvtlzlUDGkM4YLTHTYKk9LKxX4VA8st9REDl0OpXTuf65r99vpIy
         ExVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D7MJywA/hE9WubOaGzvIC0UthKf3wMZhvuNzhGQPb70=;
        b=C8yo4k2bccO0UxRifmmHKjR0hzmgrqInMyK2skdbQ0fAW9MQqebVTcXvNsxSrSz4+8
         dYuSHL0zN4rRCKYuagErfVXFF2XWEZdiQ6xLOAg0C5Y2Ch1aLKuQi3MLsOzMyoMl5XAi
         P0P/epK04gIRLVwoFSeQREyC0Gw42WZq13H9Sut4ymHszzEpjHZZMYc+zA6pKZpp5GCp
         S9nVgT0KoCllV95CT+ZWhTD+S8GfSfJa70k6Dzijj6zbWoWUyeKuJpYOmQlPysibZ2f9
         1BpITQdnizNizxS54vc2lhxrrno2e6Y7RziosY92Psf3qNuGs+y3zHE+4EdwfutKUuq1
         DDcA==
X-Gm-Message-State: AOAM531OxXzu7FqyO9EkljZPcJzhPoOt/PBir3fsZ49/IXMsskr7qwwm
        ru1sviicxyDorwo34pWFZDC7vOH6dJI=
X-Google-Smtp-Source: ABdhPJwXxUNRb2R3eWyn93fovmVTQtWZpxSFIpSP1shL2cWn3Lc129mZBASxA/bucz0j73c3H+eh0w==
X-Received: by 2002:a05:6000:1ce:: with SMTP id t14mr4636784wrx.85.1616007795459;
        Wed, 17 Mar 2021 12:03:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w11sm27979059wrv.88.2021.03.17.12.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 12:03:15 -0700 (PDT)
Message-Id: <pull.907.git.1616007794513.gitgitgadget@gmail.com>
From:   "Albert Cui via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 19:03:13 +0000
Subject: [PATCH] fetch: show progress for packfile uri downloads
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Albert Cui <albertqcui@gmail.com>,
        Albert Cui <albertqcui@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Albert Cui <albertqcui@gmail.com>

Git appears to hang when downloading packfiles as this part of the
fetch is silent, causing user confusion. This change implements
progress for the number of packfiles downloaded; a progress display
for bytes would involve deeper changes at the http-fetch layer
instead of fetch-pack, the caller.

Signed-off-by: Albert Cui <albertqcui@gmail.com>
---
    fetch: show progress for packfile uri downloads
    
    Git appears to hang when downloading packfiles as this part of the fetch
    is silent, causing user confusion. This change implements progress for
    the number of packfiles downloaded; a progress display for bytes would
    involve deeper changes at the http-fetch layer instead of fetch-pack,
    the caller.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-907%2Falbertcui%2Fprogress-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-907/albertcui/progress-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/907

 fetch-pack.c           | 8 ++++++++
 t/t5702-protocol-v2.sh | 5 ++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 6a61a464283e..5646d151293d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -23,6 +23,7 @@
 #include "fetch-negotiator.h"
 #include "fsck.h"
 #include "shallow.h"
+#include "progress.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -1585,6 +1586,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct fetch_negotiator *negotiator;
 	int seen_ack = 0;
 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
+	struct progress *packfile_uri_progress;
 	int i;
 	struct strvec index_pack_args = STRVEC_INIT;
 	struct oidset gitmodules_oids = OIDSET_INIT;
@@ -1689,6 +1691,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		}
 	}
 
+	packfile_uri_progress = start_progress(_("Downloading packs"), packfile_uris.nr);
+
 	for (i = 0; i < packfile_uris.nr; i++) {
 		int j;
 		struct child_process cmd = CHILD_PROCESS_INIT;
@@ -1696,6 +1700,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		const char *uri = packfile_uris.items[i].string +
 			the_hash_algo->hexsz + 1;
 
+		display_progress(packfile_uri_progress, i+1);
 		strvec_push(&cmd.args, "http-fetch");
 		strvec_pushf(&cmd.args, "--packfile=%.*s",
 			     (int) the_hash_algo->hexsz,
@@ -1739,6 +1744,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 						 get_object_directory(),
 						 packname));
 	}
+
+	stop_progress(&packfile_uri_progress);
+
 	string_list_clear(&packfile_uris, 0);
 	strvec_clear(&index_pack_args);
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 2e1243ca40b0..8964a4003678 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -851,7 +851,8 @@ test_expect_success 'part of packfile response provided as URI' '
 	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
 	git -c protocol.version=2 \
 		-c fetch.uriprotocols=http,https \
-		clone "$HTTPD_URL/smart/http_parent" http_child &&
+		clone "$HTTPD_URL/smart/http_parent" http_child \
+		--progress 2>progress &&
 
 	# Ensure that my-blob and other-blob are in separate packfiles.
 	for idx in http_child/.git/objects/pack/*.idx
@@ -875,6 +876,8 @@ test_expect_success 'part of packfile response provided as URI' '
 	test -f hfound &&
 	test -f h2found &&
 
+	test_i18ngrep "Downloading packs" progress &&
+
 	# Ensure that there are exactly 3 packfiles with associated .idx
 	ls http_child/.git/objects/pack/*.pack \
 	    http_child/.git/objects/pack/*.idx >filelist &&

base-commit: a5828ae6b52137b913b978e16cd2334482eb4c1f
-- 
gitgitgadget
