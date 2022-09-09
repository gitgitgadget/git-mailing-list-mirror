Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC80BECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 14:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiIIOeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 10:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiIIOdq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 10:33:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3886F10D8
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 07:33:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso1464188wmr.3
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 07:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=gEIVtXhI5F+5BWXtEe8SSzTdoZuIerEF4hKNmUJrZs0=;
        b=ma8wzQ5RQXrs030C//kd9KQ9zn36dWIfDXzWJStJiMQ1kY46B8dlHo6iTXGdeUMJrg
         apgWnkvq6tTyEl1Axyd+g8Or+bMlba8GQgSFvIKCI8CUHMXbbhGcmLFRrrAA0HCcuvUD
         /SkcQvYkbjFEcUS8muQPSmLBJeYeTlruS/h/GSPwVXxHZ9KXcqhCGo0g+XBoPJghTFuL
         iL7S4cHYWZnA7ZOJpPsLR2J2cCKuq4tQuCaGtwWlPagFjkR1OFw+moLOZyYxGdTY2QMk
         FtrA1L6TCogT7cI4EufwHYOxFSPxwgFBfYd9Jx2i8V4tS6HtXL+Eo4Wr5NR7vrV3oYoA
         VPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gEIVtXhI5F+5BWXtEe8SSzTdoZuIerEF4hKNmUJrZs0=;
        b=KrvGxLAX5EdYraaicNZFYhDO7E+69vWjvDqSA7naEwgKyyFYkGO7Cf7ekfSRAuXd8t
         d18I80KU8vTx4scWvvUOQbErwJM77+e0v4igSmUR75QPAY4rt2UaSWbi8FK+lUZkT73v
         L6++sihcZUm47wMr7lQGFoKkHbvriYMvahUcox3S0i/EvfBm0yPC43Bq9dR4IFm/SyGy
         K1wF/q+F1gVBG7L9D72lwp+UUukyU1eERKz++66J76iqSmKLnplaCbEHbj9HEiEpS0Vt
         kOvMgybIKIdDhC0afyUFyUlM+JNSUOoj/W1pvG1nPOB9MuJa6l/4mOCovRb6LA/VK7CC
         xLXA==
X-Gm-Message-State: ACgBeo0k1Ys3jO937I1fFw+oLXrIUZd1VacqHimdh0hmRJyWx1gk3DuU
        6d2+pwZGJzwM09TgHZozXstXTuoaE3M=
X-Google-Smtp-Source: AA6agR7/0kDVIHdEHFM/BcFQFkJAu8hudnSncR2AoaK83ae1Po/KYznRLlHllP8p25kYEs62D2aQKw==
X-Received: by 2002:a1c:4c11:0:b0:3a5:4d01:54be with SMTP id z17-20020a1c4c11000000b003a54d0154bemr5930221wmf.32.1662734024069;
        Fri, 09 Sep 2022 07:33:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b002285f73f11dsm818450wrq.81.2022.09.09.07.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:33:43 -0700 (PDT)
Message-Id: <4df3f83402908d88ef0bf491c1cc2a745f6660e5.1662734015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
        <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 14:33:31 +0000
Subject: [PATCH v2 5/9] bundle-uri: create "key=value" line parsing
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

When advertising a bundle list over Git's protocol v2, we will use
packet lines. Each line will be of the form "key=value" representing a
bundle list. Connect the API necessary for Git's transport to the
key-value pair parsing created in the previous change.

We are not currently implementing this protocol v2 functionality, but
instead preparing to expose this parsing to be unit-testable.

Co-authored-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 27 ++++++++++++++++++++++++++-
 bundle-uri.h | 12 ++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 4ccd14c8936..d4eb1ec7d4d 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -71,7 +71,6 @@ int for_all_bundles_in_list(struct bundle_list *list,
  * Returns 0 if the key-value pair is understood. Returns 1 if the key
  * is not understood or the value is malformed.
  */
-MAYBE_UNUSED
 static int bundle_list_update(const char *key, const char *value,
 			      struct bundle_list *list)
 {
@@ -308,3 +307,29 @@ cleanup:
 	free(filename);
 	return result;
 }
+
+/**
+ * General API for {transport,connect}.c etc.
+ */
+int bundle_uri_parse_line(struct bundle_list *list, const char *line)
+{
+	int result;
+	const char *equals;
+	struct strbuf key = STRBUF_INIT;
+
+	if (!strlen(line))
+		return error(_("bundle-uri: got an empty line"));
+
+	equals = strchr(line, '=');
+
+	if (!equals)
+		return error(_("bundle-uri: line is not of the form 'key=value'"));
+	if (line == equals || !*(equals + 1))
+		return error(_("bundle-uri: line has empty key or value"));
+
+	strbuf_add(&key, line, equals - line);
+	result = bundle_list_update(key.buf, equals + 1, list);
+	strbuf_release(&key);
+
+	return result;
+}
diff --git a/bundle-uri.h b/bundle-uri.h
index ff7e3fd3fb2..90583461929 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -67,4 +67,16 @@ int for_all_bundles_in_list(struct bundle_list *list,
  */
 int fetch_bundle_uri(struct repository *r, const char *uri);
 
+/**
+ * General API for {transport,connect}.c etc.
+ */
+
+/**
+ * Parse a "key=value" packet line from the bundle-uri verb.
+ *
+ * Returns 0 on success and non-zero on error.
+ */
+int bundle_uri_parse_line(struct bundle_list *list,
+			  const char *line);
+
 #endif
-- 
gitgitgadget

