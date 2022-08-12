Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6883EC25B0D
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 02:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiHLC5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 22:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiHLC5D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 22:57:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC687A0306
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 19:57:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gp7so4924010pjb.4
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 19:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7NgRuQ1f7+P7ezMKayA8q1Lu/BISaBKoCuLZEa0ZNoM=;
        b=mLfZm5+9p/Lztpx8lrnPwmH9m9IsVO+gIg3LVtPsSX04baxACgV9SslN9Fln7ImVEk
         kAOesyphojM4VCJmZV/VboJ00fIdq1ayeYqiBBA26IM2qM85yGjmiqxPEcEhktgBGeQX
         rrvBslZIwFZ9OkzeYTjLGF0r2KPscY3O44PZHYBS6Xn6uEZd919CCrQvG9N19iOxsXuC
         3rhpXeNI/kYGldHGXfUax4nKKwWIt8rI0tEqKfAHBBJ74HCmNj5GsU4Ed9aj4sh/3Ce0
         pz04E8ZgDOeicJDs6LQuy0PC52ny16ewuaTf1fmt6SfDiw1faHWEHUnf/rEbeWpvPlVi
         Y+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7NgRuQ1f7+P7ezMKayA8q1Lu/BISaBKoCuLZEa0ZNoM=;
        b=NyRjcm+YQjq0NTzVSGl4gujmDclXC7hFOcNRTKBNUYmSsUMWUBYoj7HQh9eoo+bkl1
         j0OzouZKXa/KgXhlVfaNhPrMzxhip5sxc1t11igDVSa7PzBOjy+avgFAcYY2Fc6y8OUg
         SJcKcY3lvaxhN9+yWAV0imedE00b3/ip2q/GSTwS7UAcltAG1lZ7W6Mjes7kv758g5c0
         ypEyZggNClcMVbJ1aqoCibX+gheYOJSWh5m3T6dzLWPqZqeInVJdOJJQEboQGSLOo96U
         1SArqLRhpOZP4YgAA5VST99eJYFmgYhplARyRUU3rffrVFCaEGqY9sAeU/z1rfm+/WOa
         5xmg==
X-Gm-Message-State: ACgBeo3LGKRQNiR7yY+fOGF26yeOZpPAs5UV7+mxNHT2B5aRalaKqQCv
        ykyEkGUH4CTtCyxBy7Vzq8k=
X-Google-Smtp-Source: AA6agR5oNChYqKNIcAc5KuYuVDEgcmDXqwNGLWCwbOGIo7ltlvIOL7b/Lq/Iz6q9xYgDVbGYXRUlmw==
X-Received: by 2002:a17:90b:3511:b0:1f4:e0cd:1e04 with SMTP id ls17-20020a17090b351100b001f4e0cd1e04mr11881400pjb.154.1660273022326;
        Thu, 11 Aug 2022 19:57:02 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.100])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902a50100b0016f0c2ea14csm390631plq.275.2022.08.11.19.56.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Aug 2022 19:57:01 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@jeffhostetler.com, git@vger.kernel.org,
        gitster@pobox.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v2 2/2] tr2: shows scope unconditionally in addition to key-value pair
Date:   Fri, 12 Aug 2022 10:56:46 +0800
Message-Id: <9856058df68d61557b11dc2fc7179acae24f5d8e.1660272404.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.37.1.1.g8cbb44ffc4.dirty
In-Reply-To: <cover.1660272404.git.dyroneteng@gmail.com>
References: <cover.1660272404.git.dyroneteng@gmail.com>
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
 Documentation/technical/api-trace2.txt | 17 +++++++++++++----
 trace2/tr2_tgt_event.c                 |  3 +++
 trace2/tr2_tgt_normal.c                |  5 ++++-
 trace2/tr2_tgt_perf.c                  |  9 +++++++--
 4 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 38d0878d85..2afa28bb5a 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -717,6 +717,7 @@ The "exec_id" field is a command-unique id and is only useful if the
 {
 	"event":"def_param",
 	...
+	"scope":"global",
 	"param":"core.abbrev",
 	"value":"7"
 }
@@ -1216,7 +1217,13 @@ We can optionally emit configuration events, see
 it.
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
@@ -1232,11 +1239,13 @@ $ cat ~/log.perf
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

