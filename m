Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D332C63797
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 20:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjAFUh1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjAFUg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 15:36:56 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A83DE94
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 12:36:51 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m7so2347746wrn.10
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 12:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3T+9TVREv97UwoXxvWPBKg6hHmW4nnXAkVNq9siomo=;
        b=aN4bMMjkTxu0H7iuHYrnbTgrEUSoX/lFNCVdJVh9YmPoUNpDTTKZW61EA9b73IQW2u
         r9BxZ8upGM3q3nq1NUEsnnC3ERpjhdGCS+UaTFsYE0aRo3BoZTqzKeR6ACab4uA1tXej
         zbtYShgSY2cBMHS6ud3mXpZ3LFQ/fLEJtd9sYNg4BA3qqXTEdJNZWEJT7Xn/mf7JvqWs
         MJFf2QDKlsm/rfovkthDCS6ydqQVc6ICfXeQrz0+3O0Z9qTOkJMOwNBLKqUFsCjoDJxR
         STAkEjqEiefAyNFWT24tusLqpBp1ywjq4rc1W21LYatTkWy0pdfem6NjSINRwYJcBCXx
         fV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3T+9TVREv97UwoXxvWPBKg6hHmW4nnXAkVNq9siomo=;
        b=tspv1ZeHz3OB0Lvp4vB0CV/ejCJ8ifMUnndr48/cpyouKbFPr6A2W0rIA/FUvdYpLW
         ewUKZa5+69/uIzzG+oUodDoq9bO3j2T4cbU/VvfGa1km96fkwU1PaQaWUjv8IkwVlc1V
         LQZ8DW4I62st82hRxBum16s6XDxD6zN4Ut3NK00mPMK+tm0i/JFqOGuiZf73jJsRFVqQ
         tcSAh8K2IwQ9cC7ASuQqE7kQzHMAz8yH3Mndd2JWwLNu5VoL2noBy+YW8zasuYKGQst9
         b4BpMQBgxt00L6Hs3LsTkZwqT1LFXsu25n8zDbE1TXiuWWQgv1r6y8FoaMK5Uc/lzzSR
         p49w==
X-Gm-Message-State: AFqh2krQ9DE+pTqrEfMOMejBYr2dTyWGnaVq3wA9tGrGEDuJXNGCIite
        D0l8POxLZ02x9SKgbpr60XWKGwwKvzc=
X-Google-Smtp-Source: AMrXdXsbPWEd89bHOUe5th2ddTDI8FhLImDhJT45oYIuR4wzY8Ygtw4wxLsXyoMPL/MA039btQdLaw==
X-Received: by 2002:a5d:4842:0:b0:2bb:62bf:f5d1 with SMTP id n2-20020a5d4842000000b002bb62bff5d1mr168989wrs.29.1673037409604;
        Fri, 06 Jan 2023 12:36:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b0027323b19ecesm2084493wrt.16.2023.01.06.12.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:36:49 -0800 (PST)
Message-Id: <a1808f0b10cfb519613bc292e30b884962a83275.1673037405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Jan 2023 20:36:40 +0000
Subject: [PATCH 3/8] bundle-uri: parse bundle.<id>.creationToken values
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
index 56c94595c2a..63e2cc21057 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -80,6 +80,9 @@ static int summarize_bundle(struct remote_bundle_info *info, void *data)
 	FILE *fp = data;
 	fprintf(fp, "[bundle \"%s\"]\n", info->id);
 	fprintf(fp, "\turi = %s\n", info->uri);
+
+	if (info->creationToken)
+		fprintf(fp, "\tcreationToken = %"PRIu64"\n", info->creationToken);
 	return 0;
 }
 
@@ -190,6 +193,13 @@ static int bundle_list_update(const char *key, const char *value,
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
index ad82174112d..1cae418211b 100644
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

