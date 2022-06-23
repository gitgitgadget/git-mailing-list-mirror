Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12470C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 09:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiFWJiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 05:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiFWJin (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 05:38:43 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B225847564
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 02:38:41 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id f16so16927948pjj.1
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 02:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YOHukVFF39wDZrF3+KcN8ZWwCCrLOo9vytImpp4PSD8=;
        b=ppPumSf8v82wCxXoEnknA7iUZU6DDNkhgmnJ6sDf3WFUghMo+EqqBBFLLjBhkQGJZa
         pwIpJ3BTuaJWb5DmtR+UKHxdoL0dHMoWzqkGIhrA0VBqkESBWi15NmqAzH2udgsutHKt
         3+2sTRszzf3Tn9Wn/t7IA4Vp8Ch+ds8x/4/NAPbTQ/rlbP71/vbfiJcgdrUfGoexjVxO
         Ev5ffNvginTHOO/SD0CtNx8clDFbrw4f1hJu9iPsB6iFPHr6XVmIFegaMPCGJUB4oPM9
         Mzquqztt6Eex8j0iEG0mfN/pgC8jJm+r2rCD1UhblGzBBaH+01P3sv9m6Yfc1Vqkajh7
         7b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YOHukVFF39wDZrF3+KcN8ZWwCCrLOo9vytImpp4PSD8=;
        b=cx2eqToDuoSsHZ+EeG7pOy/IgK9QCq+2hiIS/OPs2pPr9jJP/T7i0xEalHAMOoC8Y6
         z99OSCpAfFzB0FH4AZcdqT52vXiqNBjmzhmJ6YRPAivQKnv+klkOU9ybuyvZIYt6l9Fn
         6OvgrHsQSidNo3BDxZF6x5cbgEOy4BltBGP2kAdlAp+BVTrab8Mc2Beqkcy1vfFsbFrm
         EiAgbWls4vkXgfvErsikKol5p7698LdydYZQBxDOSN1fLoqYOSoMW7qkT9T8IXeyrp0H
         IeF5xIg4X4tAjsEI72Ug/2YM6cI+CmGz2Fmvo/oTusn9An3Zvz17mK4fIEUnPTT41DLC
         u35g==
X-Gm-Message-State: AJIora+nbQstb0oYpE3BzKZVV0U/SHTu575X5zTVkrJzKbnn4kzbIJXQ
        JLMyCw8Kg5Hca/r9ZU2b304=
X-Google-Smtp-Source: AGRyM1sxx7KAw6Kq/7P/IPWHMA8iQOfD1wz8vNSURvceD6ExVRcgn1uRRRqVzj53Y4zAkgOI1BwQ3Q==
X-Received: by 2002:a17:90b:1644:b0:1ec:e6d4:7931 with SMTP id il4-20020a17090b164400b001ece6d47931mr3122570pjb.105.1655977121023;
        Thu, 23 Jun 2022 02:38:41 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.38])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709027ed600b00163daef3dc2sm2133264plb.84.2022.06.23.02.38.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 02:38:40 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@jeffhostetler.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 5/5] bitmap: add trace2 outputs during open "bitmap" file
Date:   Thu, 23 Jun 2022 17:38:36 +0800
Message-Id: <20220623093836.113288-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.1463.gf770e9f396.dirty
In-Reply-To: <78966fb1-d5be-2fb5-0f68-0fce0b93d249@jeffhostetler.com>
References: <78966fb1-d5be-2fb5-0f68-0fce0b93d249@jeffhostetler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 22 Jun 2022 08:51:18 -0400, Jeff Hostetler wrote:

> We should not be doing.  This would dump every repo-related
> boolean value on every command.

Yes. in v4 patch I use a new arg in repo_cfg_bool to decide
whether to trace or not, but after the above you mentioned, I
think it's still not a correct solution in my v4.

> I already have a GIT_TRACE2_CONFIG_PARAMS and trace2.configparams
> that will dump "interesting" config values to the trace2 log.
> Just set one of them to a list of regex's.  Look at the comment above
> trace2_cmd_list_config() in trace2.h for details.

That's fresh for me, thanks for telling me that.

I remove the changes of "repo_config_bool" from my v4 patch
then I try to know about "GIT_TRACE2_CONFIG_PARAMS" and
"trace2.configparams". Thereby, when I:

Execute "GIT_TRACE2_PERF=1 GIT_TRACE2_CONFIG_PARAMS=core.multipackIndex git rev-list  --test-bitmap HEAD"

15:21:38.812782 git.c:461                    | d0 | main                     | def_param    |     |           |           |              | core.multipackindex:false
15:21:38.812797 git.c:461                    | d0 | main                     | def_param    |     |           |           |              | core.multipackindex:false

I checked my configs, I found if there exists multiple level configs.
it'll print multiple times. Like If I config all the global, system
and local on "core.multipackIndex=false" , the output will be:

15:41:50.614108 git.c:462                    | d0 | main                     | def_param    |     |           |           |              | core.multipackindex:false
15:41:50.614123 git.c:462                    | d0 | main                     | def_param    |     |           |           |              | core.multipackindex:false
15:41:50.614136 git.c:462                    | d0 | main                     | def_param    |     |           |           |              | core.multipackindex:false

And if I modified the local scope of core.multipackIndex to "true",
the output will be:

15:45:39.200172 git.c:462                    | d0 | main                     | def_param    |     |           |           |              | core.multipackindex:false
15:45:39.200186 git.c:462                    | d0 | main                     | def_param    |     |           |           |              | core.multipackindex:false
15:45:39.200200 git.c:462                    | d0 | main                     | def_param    |     |           |           |              | core.multipackindex:true

I'm not sure it's an intentional design or here should be only
print the final value that takes effect or should print all the
values if config multiple scopes on the same config.

Hence, I made a temporary patch below to try to add some
identifying information to know why we output these lines, like:


diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index c5c8cfbbaa..37a3163be1 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -479,9 +479,12 @@ static void fn_param_fl(const char *file, int line, const char *param,
 {
        const char *event_name = "def_param";
        struct json_writer jw = JSON_WRITER_INIT;
+       enum config_scope scope = current_config_scope();
+       const char *scope_name = config_scope_name(scope);
 
commit a089800b9dbc93a5dff9a46da7e66111e6e4343e (HEAD -> master, dyrone/master, dyrone/HEAD)
Author: Teng Long <dyroneteng@gmail.com>
Date:   Thu Jun 23 17:24:15 2022 +0800

    tr2: append scope info when same configs exist in multiple scopes
    
    Signed-off-by: Teng Long <dyroneteng@gmail.com>

diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index c5c8cfbbaa..37a3163be1 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -479,9 +479,12 @@ static void fn_param_fl(const char *file, int line, const char *param,
 {
        const char *event_name = "def_param";
        struct json_writer jw = JSON_WRITER_INIT;
+       enum config_scope scope = current_config_scope();
+       const char *scope_name = config_scope_name(scope);
 
        struct json_writer jw = JSON_WRITER_INIT;
+       enum config_scope scope = current_config_scope();
+       const char *scope_name = config_scope_name(scope);
 
        jw_object_begin(&jw, 0);
        event_fmt_prepare(event_name, file, line, NULL, &jw);
+       jw_object_string(&jw, "scope", scope_name);
        jw_object_string(&jw, "param", param);
        jw_object_string(&jw, "value", value);
        jw_end(&jw);
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index c42fbade7f..e1b036a60c 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -298,8 +298,10 @@ static void fn_param_fl(const char *file, int line, const char *param,
                        const char *value)
 {
        struct strbuf buf_payload = STRBUF_INIT;
+       enum config_scope scope = current_config_scope();
+       const char *scope_name = config_scope_name(scope);
 
-       strbuf_addf(&buf_payload, "def_param %s=%s", param, value);
+       strbuf_addf(&buf_payload, "def_param scope:%s %s=%s", scope_name, param, value);
        normal_io_write_fl(file, line, &buf_payload);
        strbuf_release(&buf_payload);
 }
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index a1eff8bea3..c21bf8e651 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -441,10 +441,12 @@ static void fn_param_fl(const char *file, int line, const char *param,
 {
        const char *event_name = "def_param";
        struct strbuf buf_payload = STRBUF_INIT;
+       enum config_scope scope = current_config_scope();
+       const char *scope_name = config_scope_name(scope);
 
        strbuf_addf(&buf_payload, "%s:%s", param, value);
 
-       perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,


----
The partial tr2 log looks like:

PERF:
17:00:35.933094 git.c:462                    | d0 | main                     | def_param    |     |           |           | system       | core.multipackindex:false
17:00:35.933110 git.c:462                    | d0 | main                     | def_param    |     |           |           | global       | core.multipackindex:false
17:00:35.933128 git.c:462                    | d0 | main                     | def_param    |     |           |           | local        | core.multipackindex:true

NORMAL:
17:14:32.905359 git.c:462                         def_param scope:system core.multipackindex=false
17:14:32.905370 git.c:462                         def_param scope:global core.multipackindex=false
17:14:32.905383 git.c:462                         def_param scope:local core.multipackindex=true

EVENT:
{"event":"def_param","sid":"20220623T092115.703660Z-H82fddc29-P0001812a","thread":"main","time":"2022-06-23T09:21:15.703920Z","file":"git.c","line":462,"scope":"system","param":"core.multipackindex","value":"false"}
{"event":"def_param","sid":"20220623T092115.703660Z-H82fddc29-P0001812a","thread":"main","time":"2022-06-23T09:21:15.703936Z","file":"git.c","line":462,"scope":"global","param":"core.multipackindex","value":"false"}
{"event":"def_param","sid":"20220623T092115.703660Z-H82fddc29-P0001812a","thread":"main","time":"2022-06-23T09:21:15.703952Z","file":"git.c","line":462,"scope":"local","param":"core.multipackindex","value":"true"}


> We also have GIT_TRACE2_ENV_VARS and trace2.envvars that will dump
> the values of "interesting" env vars.

> You can use these in your testing to log the config and env var
> values that you are interested in.

Wow, cool as GIT_TRACE2_CONFIG_PARAMS and trace2.configparams
you mentioned before. 

Thanks.
