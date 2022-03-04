Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0475C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbiCDSdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241730AbiCDSdj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:33:39 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABE949912
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:32:36 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so7704734wmj.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cayrol9sUQQWr8TuL5vBd4wrgyOhpaWRL7CIrzAwQKc=;
        b=ej8nwsy4225Rf5wuXQarFTCqKVMYAb8zhqOl/cf7jsgHyj5szEvOTONjjm4thiJkzI
         FtZkBoXotfDq0V8e07+H5QOCtnUJeAjEQvf/G6cLeHilAcx4YeK9zJmc7ydQWeXUMxKz
         0T1ynuvblTi+2Eb1xTNI4RFFi9Tn6Ni9iB5zZgyIH0DfZzc+h139gk0GK+jSKj4XtuRM
         FUZYkEWoRAjPjKDxGQ95QDPGzeeGhhHiR6DhYkEKRzDYAnxj6rCCKMtj+7HsuzEAIjMU
         7e4Tz0KiNaInRVQ8NDNiyXP82r/9nypLOEgY9qXFpxVi6fW3qiJGBmV04rYo1Dgt6GyG
         hupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cayrol9sUQQWr8TuL5vBd4wrgyOhpaWRL7CIrzAwQKc=;
        b=hMZxB269VvXICZk6k6CkwfdxfoB9TfQL6rJVs6LVpwSmCdye0v22Z8XvOlVL7+vfs1
         SVeAv7icpNDj7wBiqwjoQPH44lvSlDvK2TDhWGuiNHIQHFQ7ZnIX8icKduPemjK+hvI7
         9UWinih7KTx3YUNS39+CRlfKrMn29FYFTDUbvt0YVYI/+a3MfPOor7Ltr5h/sekxDidp
         qiJZWTrh8RGOpJNHGGSfHkRpLUeRMXinZv4ayK4uV9+RHVRmiLbSUn7lZLjCtdjrpQxz
         sMffzCNIOlP3XnN0yN9+mlsbZKZUS31C6s3KaX4vde4aCYovwAmqi9enzbYgshyU/HV6
         u70Q==
X-Gm-Message-State: AOAM532a8T0SkCIlp+Uzy2du1II0Zva3m98eXR+kAxZ877azQ8dyzrC7
        3ag+kuNQYu0ODyvH/Mb+vASvfnq6aYfENQ==
X-Google-Smtp-Source: ABdhPJzyEvgn/4diNHhiq5BWXdR7baoJyJgALeuyNpArNN6sPcH6vDnx/C3mfM8ll1QZdUjde5x4og==
X-Received: by 2002:a05:600c:1d13:b0:389:7a40:56e2 with SMTP id l19-20020a05600c1d1300b003897a4056e2mr4005557wms.69.1646418754568;
        Fri, 04 Mar 2022 10:32:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm10573990wmg.7.2022.03.04.10.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:32:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/14] range-diff: plug memory leak in read_patches()
Date:   Fri,  4 Mar 2022 19:32:16 +0100
Message-Id: <patch-v2-13.14-c6e61b85491-20220304T182902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1248.gb68c9165ad8
In-Reply-To: <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend code added in d9c66f0b5bf (range-diff: first rudimentary
implementation, 2018-08-13) to use a "goto cleanup" pattern. This
makes for less code, and frees memory that we'd previously leak.

The reason for changing free(util) to FREE_AND_NULL(util) is because
at the end of the function we append the contents of "util" to a
"struct string_list" if it's non-NULL.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 range-diff.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index b2a2961f521..b72eb9fdbee 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -40,6 +40,7 @@ static int read_patches(const char *range, struct string_list *list,
 	char *line, *current_filename = NULL;
 	ssize_t len;
 	size_t size;
+	int ret = -1;
 
 	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
 		     "--reverse", "--date-order", "--decorate=no",
@@ -68,10 +69,10 @@ static int read_patches(const char *range, struct string_list *list,
 	if (strbuf_read(&contents, cp.out, 0) < 0) {
 		error_errno(_("could not read `log` output"));
 		finish_command(&cp);
-		return -1;
+		goto cleanup;
 	}
 	if (finish_command(&cp))
-		return -1;
+		goto cleanup;
 
 	line = contents.buf;
 	size = contents.len;
@@ -95,12 +96,9 @@ static int read_patches(const char *range, struct string_list *list,
 			CALLOC_ARRAY(util, 1);
 			if (get_oid(p, &util->oid)) {
 				error(_("could not parse commit '%s'"), p);
-				free(util);
-				free(current_filename);
+				FREE_AND_NULL(util);
 				string_list_clear(list, 1);
-				strbuf_release(&buf);
-				strbuf_release(&contents);
-				return -1;
+				goto cleanup;
 			}
 			util->matching = -1;
 			in_header = 1;
@@ -111,11 +109,8 @@ static int read_patches(const char *range, struct string_list *list,
 			error(_("could not parse first line of `log` output: "
 				"did not start with 'commit ': '%s'"),
 			      line);
-			free(current_filename);
 			string_list_clear(list, 1);
-			strbuf_release(&buf);
-			strbuf_release(&contents);
-			return -1;
+			goto cleanup;
 		}
 
 		if (starts_with(line, "diff --git")) {
@@ -136,12 +131,9 @@ static int read_patches(const char *range, struct string_list *list,
 			if (len < 0) {
 				error(_("could not parse git header '%.*s'"),
 				      orig_len, line);
-				free(util);
-				free(current_filename);
+				FREE_AND_NULL(util);
 				string_list_clear(list, 1);
-				strbuf_release(&buf);
-				strbuf_release(&contents);
-				return -1;
+				goto cleanup;
 			}
 			strbuf_addstr(&buf, " ## ");
 			if (patch.is_new > 0)
@@ -219,6 +211,9 @@ static int read_patches(const char *range, struct string_list *list,
 		strbuf_addch(&buf, '\n');
 		util->diffsize++;
 	}
+
+	ret = 0;
+cleanup:
 	strbuf_release(&contents);
 
 	if (util)
@@ -226,7 +221,7 @@ static int read_patches(const char *range, struct string_list *list,
 	strbuf_release(&buf);
 	free(current_filename);
 
-	return 0;
+	return ret;
 }
 
 static int patch_util_cmp(const void *dummy, const struct patch_util *a,
-- 
2.35.1.1248.gb68c9165ad8

