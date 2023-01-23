Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B63FC05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 15:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjAWPWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjAWPW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 10:22:27 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15D6D535
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:02 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so4515676wmq.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6cSfUKeOq20ZqZT1MVsgnW3c3FiqM7zn3svGaN2eUQ=;
        b=leWw4e8N9YnjdXSj3HFeuB+wU+RjNJEWZukTBvagwOqBcpWB4z5xjYAOTOsOAMnaPK
         BPm6u69EZGnXnVx+/DNyX4RlEcpnJ1Z1+8BQQGH4GO0U/IcSW3a+o0RP7BwsdAcLIjaF
         WyLYU4M/tLnqHDZkt9Xi7tYS1ZIhrqnbcDNo44jzlnrQM+h9WMsqnYs+4c4ilgWOI6L7
         VCyAYFvVLnqwO0Z2zgcvEXnlKG9S9NlHr9iXxKkifb8qUXrbD9V7aEKiL+fj4JcKQRyw
         meyq/2cAviAjYE4TbzbmkfLw5Q+KpAHXyzmOAu7+Kco1duYnRmblwa7EUly/GMpliuy5
         D8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6cSfUKeOq20ZqZT1MVsgnW3c3FiqM7zn3svGaN2eUQ=;
        b=xCDgrkEPxJlodSF2vkN3yktYWQQCZZySnrBvrfpCOb1pe0ZAPzNQDEtLxQc6Dvk9Vj
         DYPcVe0s7Q4Nh2Pl4KGxh9AiX0zOuat7xRfxxO2lB5uj5ic+itukPraLQAlsl34OcAwQ
         mdH+rIB+MYOVmu3+KFRQt7hUztBij2kN+maG7yo5YbKOUS0lR9iaorGhs2oUCBYGVqIl
         F5UtKn4lkp6gCa7ex/GhvZ0M4Rjr92+9UCo1xtep2C4e9rGjunA4idbb3DlZX3DczoJV
         9ZErUSnHQiy6qC53sx2ADj8rVZH4pIHPEQExB50DHIGz7bouVRr53iipxdAfBkgHKCsL
         nYIQ==
X-Gm-Message-State: AFqh2koKp6jpD6E9V2yQT2Zz4fn6YNV3fn46ACihu6+RgSw0F4ZWgrPu
        XqtQnXAExxBQVihOkKyuRwD9EkQ1j88=
X-Google-Smtp-Source: AMrXdXs+09w8p2+dkgjYlNiyV2Etzy6aNFcuME/NsPntk32OlFzO1lo1cl3aR4bKr2qEY3U6UOjtBg==
X-Received: by 2002:a05:600c:1d12:b0:3da:ff82:f627 with SMTP id l18-20020a05600c1d1200b003daff82f627mr25341769wms.25.1674487315953;
        Mon, 23 Jan 2023 07:21:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003cfd4e6400csm11402131wmq.19.2023.01.23.07.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:21:55 -0800 (PST)
Message-Id: <12efa228d04c9379ec0598c974045ed851b068d9.1674487310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Jan 2023 15:21:44 +0000
Subject: [PATCH v2 04/10] bundle-uri: parse bundle.<id>.creationToken values
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
index 0d64b1d84ba..f46ab5c1743 100644
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

