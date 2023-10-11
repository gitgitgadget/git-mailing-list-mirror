Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F63CCD6E57
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 16:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346957AbjJKQEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 12:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjJKQEI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 12:04:08 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BB58F
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 09:04:05 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-405497850dbso288255e9.0
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 09:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697040244; x=1697645044; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aS9G/Ss3F9QSQZ7b0zS0RQ6QGYBIc17SeUz3M3v3TFk=;
        b=HkCV1X2Ici0mxGpIIcr4NVqo9np6gaRqPPUcznXUVIoO9JVwVvP7M8VP+Cq0+OvFEU
         ASMOdU1FvNnfIhvHSk8GWpzxJINUdyy0ejFSzhi4HRIVh7cWlaLMYiTRFf4xEUbC3h7e
         aOY1ZJxFwD5coBYO03JIuUr3EcwFwZ4HysEV8PryMSvFEkjX/y+y9hd+5uKQ+/r+ghNu
         kuBivkGFKdu3LDMgPAcKDyQ02fYlycfja3d4wHMNPtYn3n29KgyzqX6MyRxsQX1WLxoI
         PzZF3WepZ/yIEHyIKEBf1tL2ZgkAEkRpJ4vzyZd5XLy+1lecUDrAhgL2Z/YHUnKpmbSa
         R6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697040244; x=1697645044;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aS9G/Ss3F9QSQZ7b0zS0RQ6QGYBIc17SeUz3M3v3TFk=;
        b=bWuxMW9MpMf5FF0AKHeLHSwolf01uPgw5FVHEjgEdsM0+aXPhPa4d+Uh7bqnHaDSQs
         kW5phUZitqG+EV8RH3m8HcX0ZqeVs8T3XXZyq/K1fBgM48F8Tb42iGuICinfyrS3FU0s
         5w2Y/zG63S8IloxozsPsSaSEV7uejX4Ez5tTVF9DpC481GfDyeKv2bu0UUNo172VCl5V
         Hy2M7GaOt8v9dDQsH0pvdnLRF63h8l2Op3OlVDD7HnHbfmhpfbyt3eQB44XN8tou+ArX
         mb0cKRljl3+F5pmRMWky54Poks4Vd32+KKuJI88D+61QF0/2Kfi7uXCl2qbj0ZZ0+FLY
         os7A==
X-Gm-Message-State: AOJu0YyZ/edBEi6g2ZRvYXUEXEH4HrS1DTrNkI4JgN+cvi7+oOIxRv3b
        WsSRkxuxI+aZ4GOaYu6BPIpKiDP/xJ4=
X-Google-Smtp-Source: AGHT+IGHb9RflIcID/aNroOV9rdrLfZHnWQqwApQ4fj4EM2y0sX6R7HJUuHtLlFNNXNlAmrCzfjZfg==
X-Received: by 2002:adf:f40c:0:b0:321:4d1c:425f with SMTP id g12-20020adff40c000000b003214d1c425fmr18512461wro.47.1697040243855;
        Wed, 11 Oct 2023 09:04:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h12-20020adff18c000000b003232380ffd7sm15916792wro.102.2023.10.11.09.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 09:04:03 -0700 (PDT)
Message-ID: <pull.1598.git.1697040242703.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Oct 2023 16:04:02 +0000
Subject: [PATCH] upload-pack: add tracing for fetches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Robert Coup <robert@coup.net.nz>, Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Information on how users are accessing hosted repositories can be
helpful to server operators. For example, being able to broadly
differentiate between fetches and initial clones; the use of shallow
repository features; or partial clone filters.

a29263c (fetch-pack: add tracing for negotiation rounds, 2022-08-02)
added some information on have counts to fetch-pack itself to help
diagnose negotiation; but from a git-upload-pack (server) perspective,
there's no means of accessing such information without using
GIT_TRACE_PACKET to examine the protocol packets.

Improve this by emitting a Trace2 JSON event from upload-pack with
summary information on the contents of a fetch request.

* haves, wants, and want-ref counts can help determine (broadly) between
  fetches and clones, and the use of single-branch, etc.
* shallow clone depth, tip counts, and deepening options.
* any partial clone filter type.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
    upload-pack: add tracing for fetches

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1598%2Frcoup%2Frc-upload-pack-trace-info-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1598/rcoup/rc-upload-pack-trace-info-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1598

 t/t5500-fetch-pack.sh | 38 +++++++++++++++++++++++++++-----------
 upload-pack.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index d18f2823d86..bb15ac34f77 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -132,13 +132,18 @@ test_expect_success 'single branch object count' '
 '
 
 test_expect_success 'single given branch clone' '
-	git clone --single-branch --branch A "file://$(pwd)/." branch-a &&
-	test_must_fail git --git-dir=branch-a/.git rev-parse origin/B
+	GIT_TRACE2_EVENT="$(pwd)/branch-a/trace2_event" \
+		git clone --single-branch --branch A "file://$(pwd)/." branch-a &&
+	test_must_fail git --git-dir=branch-a/.git rev-parse origin/B &&
+	grep \"fetch-info\".*\"haves\":0 branch-a/trace2_event &&
+	grep \"fetch-info\".*\"wants\":1 branch-a/trace2_event
 '
 
 test_expect_success 'clone shallow depth 1' '
-	git clone --no-single-branch --depth 1 "file://$(pwd)/." shallow0 &&
-	test "$(git --git-dir=shallow0/.git rev-list --count HEAD)" = 1
+	GIT_TRACE2_EVENT="$(pwd)/shallow0/trace2_event" \
+		git clone --no-single-branch --depth 1 "file://$(pwd)/." shallow0 &&
+	test "$(git --git-dir=shallow0/.git rev-list --count HEAD)" = 1 &&
+	grep \"fetch-info\".*\"depth\":1 shallow0/trace2_event
 '
 
 test_expect_success 'clone shallow depth 1 with fsck' '
@@ -235,7 +240,10 @@ test_expect_success 'add two more (part 2)' '
 test_expect_success 'deepening pull in shallow repo' '
 	(
 		cd shallow &&
-		git pull --depth 4 .. B
+		GIT_TRACE2_EVENT="$(pwd)/trace2_event" \
+			git pull --depth 4 .. B &&
+		grep \"fetch-info\".*\"depth\":4 trace2_event &&
+		grep \"fetch-info\".*\"shallows\":2 trace2_event
 	)
 '
 
@@ -306,9 +314,12 @@ test_expect_success 'fetch --depth --no-shallow' '
 test_expect_success 'turn shallow to complete repository' '
 	(
 		cd shallow &&
-		git fetch --unshallow &&
+		GIT_TRACE2_EVENT="$(pwd)/trace2_event" \
+			git fetch --unshallow &&
 		! test -f .git/shallow &&
-		git fsck --full
+		git fsck --full &&
+		grep \"fetch-info\".*\"shallows\":2 trace2_event &&
+		grep \"fetch-info\".*\"depth\":2147483647 trace2_event
 	)
 '
 
@@ -826,13 +837,15 @@ test_expect_success 'clone shallow since ...' '
 '
 
 test_expect_success 'fetch shallow since ...' '
-	git -C shallow11 fetch --shallow-since "200000000 +0700" origin &&
+	GIT_TRACE2_EVENT=$(pwd)/shallow11/trace2_event \
+		git -C shallow11 fetch --shallow-since "200000000 +0700" origin &&
 	git -C shallow11 log --pretty=tformat:%s origin/main >actual &&
 	cat >expected <<-\EOF &&
 	three
 	two
 	EOF
-	test_cmp expected actual
+	test_cmp expected actual &&
+	grep \"fetch-info\".*\"deepen-since\":true shallow11/trace2_event
 '
 
 test_expect_success 'clone shallow since selects no commits' '
@@ -987,13 +1000,16 @@ test_expect_success 'filtering by size' '
 	test_config -C server uploadpack.allowfilter 1 &&
 
 	test_create_repo client &&
-	git -C client fetch-pack --filter=blob:limit=0 ../server HEAD &&
+	GIT_TRACE2_EVENT=$(pwd)/client/trace2_event \
+		git -C client fetch-pack --filter=blob:limit=0 ../server HEAD &&
 
 	# Ensure that object is not inadvertently fetched
 	commit=$(git -C server rev-parse HEAD) &&
 	blob=$(git hash-object server/one.t) &&
 	git -C client rev-list --objects --missing=allow-any "$commit" >oids &&
-	! grep "$blob" oids
+	! grep "$blob" oids &&
+
+	grep \"fetch-info\".*\"filter\":\"blob:limit\" client/trace2_event
 '
 
 test_expect_success 'filtering by size has no effect if support for it is not advertised' '
diff --git a/upload-pack.c b/upload-pack.c
index 83f3d2651ab..165c1c6350a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -33,6 +33,7 @@
 #include "commit-reach.h"
 #include "shallow.h"
 #include "write-or-die.h"
+#include "json-writer.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -1552,6 +1553,32 @@ static int parse_have(const char *line, struct oid_array *haves)
 	return 0;
 }
 
+static void trace2_fetch_info(struct upload_pack_data *data)
+{
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	{
+		jw_object_intmax(&jw, "haves", data->haves.nr);
+		jw_object_intmax(&jw, "wants", data->want_obj.nr);
+		jw_object_intmax(&jw, "want-refs", data->wanted_refs.nr);
+		jw_object_intmax(&jw, "depth", data->depth);
+		jw_object_intmax(&jw, "shallows", data->shallows.nr);
+		jw_object_bool(&jw, "deepen-since", data->deepen_since);
+		jw_object_intmax(&jw, "deepen-not", data->deepen_not.nr);
+		jw_object_bool(&jw, "deepen-relative", data->deepen_relative);
+		if (data->filter_options.choice)
+			jw_object_string(&jw, "filter", list_object_filter_config_name(data->filter_options.choice));
+		else
+			jw_object_null(&jw, "filter");
+	}
+	jw_end(&jw);
+
+	trace2_data_json("upload-pack", the_repository, "fetch-info", &jw);
+
+	jw_release(&jw);
+}
+
 static void process_args(struct packet_reader *request,
 			 struct upload_pack_data *data)
 {
@@ -1640,6 +1667,8 @@ static void process_args(struct packet_reader *request,
 
 	if (request->status != PACKET_READ_FLUSH)
 		die(_("expected flush after fetch arguments"));
+
+	trace2_fetch_info(data);
 }
 
 static int process_haves(struct upload_pack_data *data, struct oid_array *common)

base-commit: aab89be2eb6ca51eefeb8c8066f673f447058856
-- 
gitgitgadget
