Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B665C19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 12:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbiHBMaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237080AbiHBM3y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 08:29:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7966B5141F
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 05:29:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i128-20020a1c3b86000000b003a3a22178beso185281wma.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 05:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jl2nmWB2vij0+IeKB6NR48HqFK+MmtvvABQqvCCowmU=;
        b=TekfyOPvtK1RvTQ0wJ2Oy2eHdNQCU/pbdhRjz+r03BFzmrFgMjjkJjyLcXI20PaFSm
         94tC07h7lNynJmcG9aLQqsvipXg59628Ub0zVIpS5kOu1obcQ+AkGk/igQxpRtnt7Kvm
         u5V5E3H7ZBtHrCzNK2U7fVQHiyMMps0fo1iqNAhKLNhCZgP8vEQYl/yPgSK18PlhnQcU
         JDKy/PJ8Ic2gVXAP11d++ov8L+WKQZGdv6KLdTMTYfzZZ9igmN99WeOLDNliau5FOGZE
         +saayroVpnZodL8g/kHetDP34mtOaVFn8WRZtMmjcLf+UzVUxxZVsxtNcyxHIDtfAwR2
         J10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jl2nmWB2vij0+IeKB6NR48HqFK+MmtvvABQqvCCowmU=;
        b=TNL4jTdQYRGfCYXDas5utXLQXQDnUEdD/CaOagWwTXaDOCW/DqMwp+KnWw1eXAEs14
         8dAZp/cECz4xtAcm+aA6JkxgB+JRH0E3M8P2++tljT/IYEjuWXcU+BrHuNiQuLcM7I/0
         NHRIuw6xlj8k2ihir4/GmQo0YnZAujpLbi2Ewu3sQMlbFy19DAVXaDAMPxGQESblfAK9
         EOWJ5z02TwKeS/GuNxQt3whlC23FUjy1Q9aEjT5E+7EogWPp2XQpThtkkDZXlOvQ+J1A
         6C9sTgQUVxcFei0k9XvZWV/gu0/MpcYg1sm7DXk56sCn54J61/miLqYyMCE1+WgofQMn
         1tJQ==
X-Gm-Message-State: AJIora/xgfQsrwSNOXYpgOnoWEnS1QbKrnqRb9IJCBlgHeikBgbjfCwx
        71RmgucWqN5ck9nx38ASgF8a5hB1CKg=
X-Google-Smtp-Source: AGRyM1vP53EMbMaaMtzegTYN6qv6krxIynXjDsYhAGhaDXGM1NfosWaMIFJ5nZ0m9hkiKKIEmdTXOQ==
X-Received: by 2002:a05:600c:1001:b0:3a3:a221:78ab with SMTP id c1-20020a05600c100100b003a3a22178abmr14259437wmc.164.1659443390546;
        Tue, 02 Aug 2022 05:29:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd15-20020a05600c1f0f00b003a1980d55c4sm23495557wmb.47.2022.08.02.05.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 05:29:50 -0700 (PDT)
Message-Id: <e4f2dcc7a45388663aeac786e5abdcf2164cfe62.1659443384.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
        <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Aug 2022 12:29:43 +0000
Subject: [PATCH v2 4/5] bundle-uri: add support for http(s):// and file://
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
index b35babc36aa..930e995d194 100644
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
+	strvec_pushl(&cp.args, "git-remote-https", "origin", uri, NULL);
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
+	if (istarts_with(uri, "https:") ||
+	    istarts_with(uri, "http:"))
+		return download_https_uri_to_file(filename, uri);
+
+	if (!skip_prefix(uri, "file://", &out))
+		out = uri;
+
+	/* Copy as a file */
+	return copy_file(filename, out, 0);
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

