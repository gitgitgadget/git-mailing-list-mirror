Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24D7C636D3
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 13:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjAaN3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 08:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjAaN32 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 08:29:28 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62374860E
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:27 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h16so14177526wrz.12
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcHUJaW0aTZ2AIHKKulh/nhnLboMi0P+NYDOF2ZdK3U=;
        b=axqCTIKx4r1hfgSOVARWzhtZ7TlP8r70y9ZJA8mV6aImkgv9kUkfBYfYp+q7eKJVzM
         DgvghoFFKdDfVhUjw59bpQS/lC81YGqL3EsjbABO/GnnyZRCz0AMfE0X7Pag/sFh1hhf
         VT1FdDrwGC7zNtlbsXwmgDBAx2zYYm7jVDsH8CRmyJqv2AHtpLcC8m1m5TN5UdRYbOHm
         AQbx97/JwmtB8ZmbkDbJM24WcKiKr43ZnKJxTYSTh8qZYkTmeuHi+JCxS5AE8q8zVbaI
         Cjxj41f+gDTfhb7h0KLZLzaBAH6B47juBHcHSBCrgIrdRG5AZLFgrmmtTPH3UvXuYuWw
         KDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcHUJaW0aTZ2AIHKKulh/nhnLboMi0P+NYDOF2ZdK3U=;
        b=U95fZQbZ5abbS8JeXm2z/TmP+TKx9/kekalt/QSdU4e8ZuXKLTk71/j6WEIJ02i3Tj
         v5Ny5T8lhUR+MALPhQf3eeV4EgOGyX0vlUHNEjR221TcBySEohFLI+y45f2IlX0L3chH
         L0+wHtSoGvIejc+eUZUNDzcckfDoE+/uHObltsbkbIL7d4KVJiK9RGMfIjQocJF0lnaW
         6R99CIyYiV1Y9+KUMLQuXkLVghJKqnfRvjMKg4QTAxdD+kvQ7tQIo+gg9kYbcK4ziuSK
         BDGQQbeOaEDHYDQvALcWXAz9l/cO4eNNsAnvg6P7yRlD24rCtwKA3Y0aRZDI5rhHEs1N
         MvKA==
X-Gm-Message-State: AFqh2koTtHjlxiwUApQ/zfTPRK8Jo9CU4Jv9dxId/e1U32WeRIC2BZ5a
        ptSuEd6nG/JF0O4zD/pQk5LRKk1KAkg=
X-Google-Smtp-Source: AMrXdXsGChAKGWlfhKFdXkSDWh0Z3HISfQs9mAIkkpAtvHRjedFA/KP/UoVx6sRqopr4be/qOG6sBQ==
X-Received: by 2002:adf:e782:0:b0:2be:5ca0:a7f9 with SMTP id n2-20020adfe782000000b002be5ca0a7f9mr35186217wrm.33.1675171765976;
        Tue, 31 Jan 2023 05:29:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d50c6000000b002bfc24e1c55sm14795352wrt.78.2023.01.31.05.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:29:25 -0800 (PST)
Message-Id: <ff629bc119b466dcd827f758b3d892fefd6a9703.1675171760.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
References: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Jan 2023 13:29:13 +0000
Subject: [PATCH v3 05/11] bundle-uri: parse bundle.<id>.creationToken values
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change taught Git to parse the bundle.heuristic value,
especially when its value is "creationToken". Now, teach Git to parse
the bundle.<id>.creationToken values on each bundle in a bundle list.

Before implementing any logic based on creationToken values for the
creationToken heuristic, parse and print these values for testing
purposes.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                | 10 ++++++++++
 bundle-uri.h                |  6 ++++++
 t/t5750-bundle-uri-parse.sh | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/bundle-uri.c b/bundle-uri.c
index 36ec542718d..d4277b2e3a7 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -83,6 +83,9 @@ static int summarize_bundle(struct remote_bundle_info *info, void *data)
 	FILE *fp = data;
 	fprintf(fp, "[bundle \"%s\"]\n", info->id);
 	fprintf(fp, "\turi = %s\n", info->uri);
+
+	if (info->creationToken)
+		fprintf(fp, "\tcreationToken = %"PRIu64"\n", info->creationToken);
 	return 0;
 }
 
@@ -203,6 +206,13 @@ static int bundle_list_update(const char *key, const char *value,
 		return 0;
 	}
 
+	if (!strcmp(subkey, "creationtoken")) {
+		if (sscanf(value, "%"PRIu64, &bundle->creationToken) != 1)
+			warning(_("could not parse bundle list key %s with value '%s'"),
+				"creationToken", value);
+		return 0;
+	}
+
 	/*
 	 * At this point, we ignore any information that we don't
 	 * understand, assuming it to be hints for a heuristic the client
diff --git a/bundle-uri.h b/bundle-uri.h
index 2e44a50a90b..ef32840bfa6 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -42,6 +42,12 @@ struct remote_bundle_info {
 	 * this boolean is true.
 	 */
 	unsigned unbundled:1;
+
+	/**
+	 * If the bundle is part of a list with the creationToken
+	 * heuristic, then we use this member for sorting the bundles.
+	 */
+	uint64_t creationToken;
 };
 
 #define REMOTE_BUNDLE_INFO_INIT { 0 }
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index 6fc92a9c0d4..81bdf58b944 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -258,10 +258,13 @@ test_expect_success 'parse config format: creationToken heuristic' '
 		heuristic = creationToken
 	[bundle "one"]
 		uri = http://example.com/bundle.bdl
+		creationToken = 123456
 	[bundle "two"]
 		uri = https://example.com/bundle.bdl
+		creationToken = 12345678901234567890
 	[bundle "three"]
 		uri = file:///usr/share/git/bundle.bdl
+		creationToken = 1
 	EOF
 
 	test-tool bundle-uri parse-config expect >actual 2>err &&
@@ -269,4 +272,19 @@ test_expect_success 'parse config format: creationToken heuristic' '
 	test_cmp_config_output expect actual
 '
 
+test_expect_success 'parse config format edge cases: creationToken heuristic' '
+	cat >expect <<-\EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+	[bundle "one"]
+		uri = http://example.com/bundle.bdl
+		creationToken = bogus
+	EOF
+
+	test-tool bundle-uri parse-config expect >actual 2>err &&
+	grep "could not parse bundle list key creationToken with value '\''bogus'\''" err
+'
+
 test_done
-- 
gitgitgadget

