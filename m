Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F567C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 13:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiGUN2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiGUN2E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 09:28:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3F77539F
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 06:28:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z3so1828857plb.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 06:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zh/fxE2huoURY/N4uIVhnv214EIBsTv6+fIvpkctvEc=;
        b=pMU3hD1txERiuE6sO2O+/X/rgsHQm6L4ETrM9hGDEOPPqgIGhZWBVYpj4O9S0ZZnSy
         VQ+Rj41UGw/5YTJ4mLA6uNXup37NSIgPYPZo1gKCqhpgN5vUnhFmJRtdKduAX7GXGCyz
         5d9gnepHJXSkEIPiOb7f10VD0TAbrEW40/D2vYkGbp+E8Azv9laZjXtCYAFDM4lV2SyW
         Urar5uAsgYIHlTeriNL06VRGL1Xl1+gg/aywlCBX39hXPQCuczeV+pOrwO39pxPnCLGD
         T/l4XYzKHlD1aOBpFrzx7wCBgCeGrlMStt0XXgHohiHb/ZeLjIBvwDRnPwbQH7knT6L2
         DOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zh/fxE2huoURY/N4uIVhnv214EIBsTv6+fIvpkctvEc=;
        b=dKYZIG5Jkbq9KwAcS+ucndu/+SUUIGyCJIJ0fRWCB/tmuR8Q8JCZOOF+1JPpp2jYRe
         R7xnjiFUtYUdUVtBobDdzlX0kFtQlVVh/8/ONc5/wb0hDtMMWRfW2NgBgqGIdxTeCPt/
         Tdcl9npIoykx3P0PdD4q1Vz3Eah3avIVEnUGsQdRScvVTbHdLWEQGdGnCpnbwwA5sjd8
         29A55kRoCMRJyo5m8L9wI69QcHUWeR5zm5zTk7EUskL55P28RIZdemkwhWRcrtGytwcd
         OEcsx/eHkRLeFLFo8DTLoCFmV10FpbfVQFBncMJSgHo9IIWZHGNWvg5UEAWsN688DzUm
         kqGg==
X-Gm-Message-State: AJIora9uYjtg4TE1jpDx16wnBknI8U2Un3d02VIYaG7BXtPXDVTdptMs
        8u7799kL7YpvO/5KvzZ8pVWIfFjSYho=
X-Google-Smtp-Source: AGRyM1tTT+HYMFirYx+rziNfCTpFBogQCdC2oWK5FLmI1Tf8wUZDSPLQxnuxoks8q3wCnknPQ3VPTA==
X-Received: by 2002:a17:90b:17c9:b0:1f0:5678:5142 with SMTP id me9-20020a17090b17c900b001f056785142mr11577959pjb.205.1658410081784;
        Thu, 21 Jul 2022 06:28:01 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id q13-20020a65684d000000b00419cde333eesm1467326pgt.64.2022.07.21.06.27.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jul 2022 06:28:01 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, --cc=avarab@gmail.com, git@jeffhostetler.com,
        tenglong.tl@alibaba-inc.com, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 2/2] tr2: shows scope unconditionally in addition to key-value pair
Date:   Thu, 21 Jul 2022 21:27:48 +0800
Message-Id: <20220721132748.37848-3-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.1.1.g8cbb44ffc4.dirty
In-Reply-To: <20220721132748.37848-1-tenglong.tl@alibaba-inc.com>
References: <20220721132748.37848-1-tenglong.tl@alibaba-inc.com>
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
 Documentation/technical/api-trace2.txt | 20 +++++++++++++++-----
 trace2/tr2_tgt_event.c                 |  3 +++
 trace2/tr2_tgt_normal.c                |  5 ++++-
 trace2/tr2_tgt_perf.c                  |  9 +++++++--
 4 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index dcd0429037..229f31ab31 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -717,6 +717,7 @@ The "exec_id" field is a command-unique id and is only useful if the
 {
 	"event":"def_param",
 	...
+	scope: <a string that 'git config --show-scope' would return>
 	"param":"core.abbrev",
 	"value":"7"
 }
@@ -1213,10 +1214,17 @@ Print Configs::
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
@@ -1232,11 +1240,13 @@ $ cat ~/log.perf
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

