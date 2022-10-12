Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949C2C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 12:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJLMxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 08:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJLMww (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 08:52:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAFBC45A6
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:49 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so1148502wmq.4
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnuvRU/s4CwFnk6H9aTDmG6Z/zW4bmJU9S4El1WdLLY=;
        b=pd/SrKg+4mfOrC38oQqQp+0AfPY30nu4ANHJ+55mAxwjT0rJzxlULSANKslo2zwcKg
         4t9ngpESbyquHmSVbi8bRh42iT1+q4QZBXwKcSI+Ad7WwFbKpu+MMO5vaZRMH5PfL+TZ
         PSLnE4779iPJFBNtAy6LDECsbeuvtkAjBkAembAq7YXhR7ipmf0Y8Tc16WPUYkqoGTtE
         FX5n7DuwWWGStKrt8v/Ut86rcaQWzpWyq3/0ib5wyS/KPRsRd6fgk6bLdp8zHK8TGbf5
         p4l1cjVlG+Lk5ikqR7wd49W3M5lhXshxlsPeYrk4ofM3bOPJ9mdTIYO7m4c227WyDv4W
         lyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnuvRU/s4CwFnk6H9aTDmG6Z/zW4bmJU9S4El1WdLLY=;
        b=gGsGnGPQWE4uf4vav87zG+BTazIAfoUcHzrP05UZGP+Fr7EeqZ/l8h4ktMzRhnHRFM
         wMQ4Q6KsDJmQ4J9AsBkvQRRwUz2HjGcRNubW7gH1I+d7RU4sVWs2ZFbLTg1K54u2qVUV
         vbgi4DlaOekK0PANNpeNO/cVZJ7X8rAI09tCbQ4CjplLSyqdJLK67J93oJO8eJuhoClq
         kAfWzxVjF8ge7SEiuvIrSeuX0Ib8Ol9oqlejdSx9WMYepBq4DMSlzVXtmUaOaynr3IXO
         3SScRgrYue2CwfEneoQOQHUIoM14pWOjpmTYe4FIYGunAN66JFOnYu9+u/kCsvAG58nj
         OP2A==
X-Gm-Message-State: ACrzQf3K4whvYbvca9WKRpGIm0vMRgzzRVmTjm4K54lxPivToZSB/joA
        dqFMz97YNQp3FTwA5bw5/hZiOeeWq0o=
X-Google-Smtp-Source: AMsMyM5eAbZ2J5BqQATVwnTgZjVrmBU5vzjOy4TXYMpOLe14BqV39AsKOCFq4pJ4LbCcfTTjGAgnBg==
X-Received: by 2002:a05:600c:474c:b0:3c6:c790:1f95 with SMTP id w12-20020a05600c474c00b003c6c7901f95mr2716200wmo.18.1665579167329;
        Wed, 12 Oct 2022 05:52:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020adfce02000000b0022a3a887ceasm13633120wrn.49.2022.10.12.05.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 05:52:46 -0700 (PDT)
Message-Id: <cd915d57f3bced015dc154572612d4dd221d1618.1665579160.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
References: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
        <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 12:52:31 +0000
Subject: [PATCH v5 04/12] bundle-uri: create "key=value" line parsing
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
index 0bc59dd9c34..372e6fac5cf 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -71,7 +71,6 @@ int for_all_bundles_in_list(struct bundle_list *list,
  * Returns 0 if the key-value pair is understood. Returns -1 if the key
  * is not understood or the value is malformed.
  */
-MAYBE_UNUSED
 static int bundle_list_update(const char *key, const char *value,
 			      struct bundle_list *list)
 {
@@ -306,3 +305,29 @@ cleanup:
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

