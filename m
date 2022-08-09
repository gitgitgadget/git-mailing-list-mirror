Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9C0C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 13:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243597AbiHINMI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbiHINLz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 09:11:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8358F13E09
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 06:11:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q30so14242005wra.11
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 06:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=WmhVshfIHI4m+KlW9sjE4s6pqYnZRfj0Q+oz5Lz/vdU=;
        b=B2PB2nIVCtyHChP3gF1zt0rxBtKx5fg9ewebx1J1Q1moFNuwRabV/dK6CctylJgL3F
         zqFtkFxu/2yZG3kSFEDKj8Revx9QCiZZOVPHMUAx2oT/nN0FWIcrirlNMlLmZLhP9OKH
         iK3l9KPtxb/T915mJffStvBCzlmMpnYccYRuFbhgs3XUVJSr3PhJ2zgI7bEHZbJTRxwy
         33S4ETPNrUws76DikQ9LJC5aJn4ajMQM2PDfOhv1YxR00+jE3t7crkonbJ7RIdfph6Me
         Jc2j7H5gkgkwCgtsQ/CbB5JVtfuuP2sUxsAE4FnPAkHSGCpo1W68a9Y6iYERGKVAo4Mb
         m8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=WmhVshfIHI4m+KlW9sjE4s6pqYnZRfj0Q+oz5Lz/vdU=;
        b=7O5E8w8hgdDNnIlA0uu/A6H6EnVDSvb44632yZywMX2vpug6XEw+Ye/sp6SwJu5mJ3
         8F76KP3ZmJ+Vvjg3HMgddtUNJ0X+2xt3tNMLWluSAN6L/ek/MatTDumZIluavz8n1kg7
         iFJkx3j4SobuAUBFijxPikmDeWxcXha+5cNArxPRuuIvcGDfGDx7bqe4yzl90Ug7INSO
         HFKpII+Odq9hE8TYyz8k1D9rmH0M31ayu1Md3P/BVXxvkh3nuh+IuzdGCMsFNgEqId6+
         69yTrexJ0cToM2bWYfYzl/feDWTOjyMOw/dIohn+1t4/X4bl/C3LXAnk6cA9u63o/TET
         jWlA==
X-Gm-Message-State: ACgBeo2nLqvMBjX2unE9Wv1grEfTodJpADSdfS0m1RDkz24z1/eoPwHT
        SoreEPxC3n0EigiUcyLAeEwRHpfyc4s=
X-Google-Smtp-Source: AA6agR7l5gsUrJp8P3m++6khtb3lzQm/4XP7B1kAik7Jbl4SRkNtDsFHetcQqeb7yVK3Ty88mYyDqw==
X-Received: by 2002:adf:f286:0:b0:21e:f0dc:3df0 with SMTP id k6-20020adff286000000b0021ef0dc3df0mr14535376wro.377.1660050712427;
        Tue, 09 Aug 2022 06:11:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c34d400b003a545ff43c5sm5032547wmq.45.2022.08.09.06.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 06:11:51 -0700 (PDT)
Message-Id: <66a1ce4045192d153d5ac66cc248ac569cac8cf6.1660050704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1300.v3.git.1660050703.gitgitgadget@gmail.com>
References: <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
        <pull.1300.v3.git.1660050703.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Aug 2022 13:11:42 +0000
Subject: [PATCH v3 4/5] bundle-uri: add support for http(s):// and file://
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change created the 'git clone --bundle-uri=<uri>' option.
Currently, <uri> must be a filename.

Update copy_uri_to_file() to first inspect the URI for an HTTP(S) prefix
and use git-remote-https as the way to download the data at that URI.
Otherwise, check to see if file:// is present and modify the prefix
accordingly.

Reviewed-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                | 70 +++++++++++++++++++++++++++++++++++--
 t/t5558-clone-bundle-uri.sh | 45 ++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index b35babc36aa..4a8cc74ed05 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -23,10 +23,74 @@ static int find_temp_filename(struct strbuf *name)
 	return 0;
 }
 
-static int copy_uri_to_file(const char *file, const char *uri)
+static int download_https_uri_to_file(const char *file, const char *uri)
 {
-	/* File-based URIs only for now. */
-	return copy_file(file, uri, 0);
+	int result = 0;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	FILE *child_in = NULL, *child_out = NULL;
+	struct strbuf line = STRBUF_INIT;
+	int found_get = 0;
+
+	strvec_pushl(&cp.args, "git-remote-https", uri, NULL);
+	cp.in = -1;
+	cp.out = -1;
+
+	if (start_command(&cp))
+		return 1;
+
+	child_in = fdopen(cp.in, "w");
+	if (!child_in) {
+		result = 1;
+		goto cleanup;
+	}
+
+	child_out = fdopen(cp.out, "r");
+	if (!child_out) {
+		result = 1;
+		goto cleanup;
+	}
+
+	fprintf(child_in, "capabilities\n");
+	fflush(child_in);
+
+	while (!strbuf_getline(&line, child_out)) {
+		if (!line.len)
+			break;
+		if (!strcmp(line.buf, "get"))
+			found_get = 1;
+	}
+	strbuf_release(&line);
+
+	if (!found_get) {
+		result = error(_("insufficient capabilities"));
+		goto cleanup;
+	}
+
+	fprintf(child_in, "get %s %s\n\n", uri, file);
+
+cleanup:
+	if (child_in)
+		fclose(child_in);
+	if (finish_command(&cp))
+		return 1;
+	if (child_out)
+		fclose(child_out);
+	return result;
+}
+
+static int copy_uri_to_file(const char *filename, const char *uri)
+{
+	const char *out;
+
+	if (starts_with(uri, "https:") ||
+	    starts_with(uri, "http:"))
+		return download_https_uri_to_file(filename, uri);
+
+	if (skip_prefix(uri, "file://", &out))
+		uri = out;
+
+	/* Copy as a file */
+	return copy_file(filename, uri, 0);
 }
 
 static int unbundle_from_file(struct repository *r, const char *file)
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index f709bcb729c..ad666a2d28a 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -33,4 +33,49 @@ test_expect_success 'clone with path bundle' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clone with file:// bundle' '
+	git clone --bundle-uri="file://$(pwd)/clone-from/B.bundle" \
+		clone-from clone-file &&
+	git -C clone-file rev-parse refs/bundles/topic >actual &&
+	git -C clone-from rev-parse topic >expect &&
+	test_cmp expect actual
+'
+
+#########################################################################
+# HTTP tests begin here
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'fail to fetch from non-existent HTTP URL' '
+	test_when_finished rm -rf test &&
+	git clone --bundle-uri="$HTTPD_URL/does-not-exist" . test 2>err &&
+	grep "failed to download bundle from URI" err
+'
+
+test_expect_success 'fail to fetch from non-bundle HTTP URL' '
+	test_when_finished rm -rf test &&
+	echo bogus >"$HTTPD_DOCUMENT_ROOT_PATH/bogus" &&
+	git clone --bundle-uri="$HTTPD_URL/bogus" . test 2>err &&
+	grep "is not a bundle" err
+'
+
+test_expect_success 'clone HTTP bundle' '
+	cp clone-from/B.bundle "$HTTPD_DOCUMENT_ROOT_PATH/B.bundle" &&
+
+	git clone --no-local --mirror clone-from \
+		"$HTTPD_DOCUMENT_ROOT_PATH/fetch.git" &&
+
+	git clone --bundle-uri="$HTTPD_URL/B.bundle" \
+		"$HTTPD_URL/smart/fetch.git" clone-http &&
+	git -C clone-http rev-parse refs/bundles/topic >actual &&
+	git -C clone-from rev-parse topic >expect &&
+	test_cmp expect actual &&
+
+	test_config -C clone-http log.excludedecoration refs/bundle/
+'
+
+# Do not add tests here unless they use the HTTP server, as they will
+# not run unless the HTTP dependencies exist.
+
 test_done
-- 
gitgitgadget

