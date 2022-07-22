Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7AFC43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 08:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiGVIUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 04:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbiGVITs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 04:19:48 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C9B9E2A6
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 01:19:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g12so3908656pfb.3
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 01:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RjlArnORTzLu2tZdWlkVXjtNTFr9wJcfwBVzeUSmAQQ=;
        b=SqtkjRvmejICqyXBzDU8QLxOTB53y72e96tlww6srPRDFsIb0O0ufwRF1Ymct3Di1V
         jxJVBpPlvzoiFU/vCAVA6mSI9z0gC+tgkFbTEhl4vse42qJpMQRR+EI/uTsbENQiF9WQ
         xQtTQTTvCerKjEjHR4IxbOoozGIiakkDq34nSbBDWiIL8NkCe7/fUtI7tqrqnaGq1DjU
         YGCN4hWBfLNHbyHcm7BQ9Mwob0NGLkV+F5mrzC1mdpKGl+QPJf61pmgSOa5dyDZOhKq4
         JGpAsWmNKTbHWbedcVA6KDsKuhLYNilC0gfYLZrdZFGeS3UZezLzjkx8sLVUN5bSQ4FH
         rJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RjlArnORTzLu2tZdWlkVXjtNTFr9wJcfwBVzeUSmAQQ=;
        b=guzxDA7zq0oOznTMLhDWxZ+1/pcyWLI6RqDy6T0xkj8zaW7kTMzqinUMLlLB3qItVj
         aLrbU4RTPdWFirzHNZz/lzD5V1LCUNWMemSAxTIZ4loR+3oUMfNsw/ZUziFK1BMGXCBC
         r6a7QSAaqBrmUC2LoRCBCs401h/FQUKDTcDN8pDiX9i50KXigf6K2kNT81MUExTb5Aw0
         KiWF5XPb5kMtQANFAW2YlVpCfrVl3ySJIdWBHSxMnnDdGfmqT2J2UF5btLuhBiPJisoB
         K4Vgm2tZYVHuTxG1d0/H29Or3GSOp9+oUhhJWaLIVRMnhmu+obpa5ix8K4za787+/36I
         kvQA==
X-Gm-Message-State: AJIora9mQY7hHo5zMh244qyKvxQhQrBjwn4613tFpTvDMFahr+28Nrsm
        r5vi+1qjRuOY76xLt6XAKGI=
X-Google-Smtp-Source: AGRyM1vpW19i2hYPj8+50SnX/v22gXKVScYvSnhjDCIHdOYuZcONj65STpnLpNxEv7Ld/D+xgx0Eeg==
X-Received: by 2002:aa7:9afa:0:b0:528:bbf7:e444 with SMTP id y26-20020aa79afa000000b00528bbf7e444mr2321054pfp.71.1658477983957;
        Fri, 22 Jul 2022 01:19:43 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id q9-20020aa78429000000b00528d580cb45sm3188734pfn.127.2022.07.22.01.19.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jul 2022 01:19:43 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@jeffhostetler.com, git@vger.kernel.org,
        gitster@pobox.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v1 2/2] tr2: shows scope unconditionally in addition to key-value pair
Date:   Fri, 22 Jul 2022 16:19:32 +0800
Message-Id: <78575cca0b3ef4acb1bb42a00ccd3104f3fa4cea.1658472474.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.37.1.1.g8cbb44ffc4.dirty
In-Reply-To: <cover.1658472474.git.dyroneteng@gmail.com>
References: <cover.1658472474.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

When we specify GIT_TRACE2_CONFIG_PARAMS or trace2.configparams,
trace2 will prints "interesting" config values to log. Sometimes,
when a config set in multiple scope files, the following output
looks like (the irrelevant fields are omitted here as "..."):

...| def_param    |  ...  | core.multipackindex:false
...| def_param    |  ...  | core.multipackindex:false
...| def_param    |  ...  | core.multipackindex:false

As the log shows, even each config in different scope is dumped, but
we don't know which scope it comes from. Therefore, it's better to
add the scope names as well to make them be more recognizable. For
example, when execute:

    $ GIT_TRACE2_PERF=1 \
    > GIT_TRACE2_CONFIG_PARAMS=core.multipackIndex \
    > git rev-list --test-bitmap HEAD"

The following is the ouput (the irrelevant fields are omitted here
as "..."):

Format normal:
... git.c:461 ... def_param scope:system core.multipackindex=false
... git.c:461 ... def_param scope:global core.multipackindex=false
... git.c:461 ... def_param scope:local core.multipackindex=false

Format perf:

... | def_param    | ... | scope:system | core.multipackindex:false
... | def_param    | ... | scope:global | core.multipackindex:false
... | def_param    | ... | scope:local  | core.multipackindex:false

Format event:

{"event":"def_param", ... ,"scope":"system","param":"core.multipackindex","value":"false"}
{"event":"def_param", ... ,"scope":"global","param":"core.multipackindex","value":"false"}
{"event":"def_param", ... ,"scope":"local","param":"core.multipackindex","value":"false"}

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/technical/api-trace2.txt | 19 ++++++++++++++-----
 trace2/tr2_tgt_event.c                 |  3 +++
 trace2/tr2_tgt_normal.c                |  5 ++++-
 trace2/tr2_tgt_perf.c                  |  9 +++++++--
 4 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index ddc0bfb9c9..534cfa98fa 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -1214,10 +1214,17 @@ Print Configs::
 +
 The environment variable `GIT_TRACE2_CONFIG_PARAMS` and configuration
 `trace2.configparams` can be used to output config values which you care
-about(see linkgit:git-config[1). For example:
+about(see linkgit:git-config[1). For example assume that we want to config
+different `color.ui` values in multiple scopes, such as:
 +
 ----------------
-$ git config color.ui auto
+$ git config --system color.ui never
+$ git config --global color.ui always
+$ git config --local color.ui auto
+$ git config --list --show-scope | grep 'color.ui'
+system  color.ui=never
+global  color.ui=always
+local   color.ui=auto
 ----------------
 +
 Then, mark the config `color.ui` as "interesting" config with
@@ -1233,11 +1240,13 @@ $ cat ~/log.perf
 d0 | main                     | version      |     |           |           |              | ...
 d0 | main                     | start        |     |  0.001642 |           |              | /usr/local/bin/git version
 d0 | main                     | cmd_name     |     |           |           |              | version (version)
-d0 | main                     | def_param    |     |           |           |              | color.ui:auto
+d0 | main                     | def_param    |     |           |           | scope:system | color.ui:never
+d0 | main                     | def_param    |     |           |           | scope:global | color.ui:always
+d0 | main                     | def_param    |     |           |           | scope:local  | color.ui:auto
 d0 | main                     | data         | r0  |  0.002100 |  0.002100 | fsync        | fsync/writeout-only:0
 d0 | main                     | data         | r0  |  0.002126 |  0.002126 | fsync        | fsync/hardware-flush:0
-d0 | main                     | exit         |     |  0.002142 |           |              | code:0
-d0 | main                     | atexit       |     |  0.002161 |           |              | code:0
+d0 | main                     | exit         |     |  0.000470 |           |              | code:0
+d0 | main                     | atexit       |     |  0.000477 |           |              | code:0
 ----------------
 == Future Work
 
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index c5c8cfbbaa..37a3163be1 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -479,9 +479,12 @@ static void fn_param_fl(const char *file, int line, const char *param,
 {
 	const char *event_name = "def_param";
 	struct json_writer jw = JSON_WRITER_INIT;
+	enum config_scope scope = current_config_scope();
+	const char *scope_name = config_scope_name(scope);
 
 	jw_object_begin(&jw, 0);
 	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_string(&jw, "scope", scope_name);
 	jw_object_string(&jw, "param", param);
 	jw_object_string(&jw, "value", value);
 	jw_end(&jw);
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index c42fbade7f..69f8033077 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -298,8 +298,11 @@ static void fn_param_fl(const char *file, int line, const char *param,
 			const char *value)
 {
 	struct strbuf buf_payload = STRBUF_INIT;
+	enum config_scope scope = current_config_scope();
+	const char *scope_name = config_scope_name(scope);
 
-	strbuf_addf(&buf_payload, "def_param %s=%s", param, value);
+	strbuf_addf(&buf_payload, "def_param scope:%s %s=%s", scope_name, param,
+		    value);
 	normal_io_write_fl(file, line, &buf_payload);
 	strbuf_release(&buf_payload);
 }
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index a1eff8bea3..8cb792488c 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -441,12 +441,17 @@ static void fn_param_fl(const char *file, int line, const char *param,
 {
 	const char *event_name = "def_param";
 	struct strbuf buf_payload = STRBUF_INIT;
+	struct strbuf scope_payload = STRBUF_INIT;
+	enum config_scope scope = current_config_scope();
+	const char *scope_name = config_scope_name(scope);
 
 	strbuf_addf(&buf_payload, "%s:%s", param, value);
+	strbuf_addf(&scope_payload, "%s:%s", "scope", scope_name);
 
-	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
-			 &buf_payload);
+	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL,
+			 scope_payload.buf, &buf_payload);
 	strbuf_release(&buf_payload);
+	strbuf_release(&scope_payload);
 }
 
 static void fn_repo_fl(const char *file, int line,
-- 
2.37.1.1.g8cbb44ffc4.dirty

