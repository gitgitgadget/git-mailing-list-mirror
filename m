Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95977C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 23:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D38261246
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 23:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbhKJXyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 18:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbhKJXyW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 18:54:22 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D7CC061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 15:51:33 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d3so6772996wrh.8
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 15:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BhbCaUpOAvUzWndZhw4WVCL0/92iUxY65m1Cl1Y3/gg=;
        b=Imo9CgH7AlscUEIZFwblXRVztEwrr/XRSQMpvPq1qBVrYKc0ciQHeWtp3i+jf/AMWF
         62oZPJkz3PbNvpPwZkQn7RAyrTAJ6kbOE24GbOpsV9lC4zMhCl9wsZDkJSS0YcxUh5/1
         YDRxeggnKsSBBbk5MYSgD087YhtdnYRQHJ4idJUlRynFAGDba1LfnpoD0QvLj3MGm5PX
         7YLEVv20XLZS/YrgY60a0QVa99EM7WbqIP1S03Y2hQWnCcPKidOxVV5KQH9b+p3soLmO
         1ECpXaMSrIiQNF8DXmDf9SPcoFqTleUPbiIiMOHi5wsXj6nqNH4VkvAn2yJ/0/s6KIVZ
         hJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BhbCaUpOAvUzWndZhw4WVCL0/92iUxY65m1Cl1Y3/gg=;
        b=bbEjYCMxhkOhns2esvXeozLv96Cb1go8Yu/G9fq8oVVo7HADdXr45E9aymYeRq+ZdL
         nBXYZ04N+xPLijilYZ2uHA+MaYDvQtzJ0vtzamgWSQeOvK0qT8nodHjh27TG3PfB1pg6
         chDya6MmcNBUJyrIX2Ac0a2REHDkOtxhXGs9YPGO0Jl3EUL9pbt8uA4sV9DIKcODXta3
         NbFCj3PzSyNykT7XtpcdtHDFx9Wj45Jw2mboT6SnnoYbTTuE+D/b2p/sz81eHTTqS0+N
         9PvjZWLWbJZW9e0pWW23C3px2+oudIQLNL0R3IPUeu5xJkeeQFgBPx/r7cCzgegIOIDz
         Y0lw==
X-Gm-Message-State: AOAM532DiVMuTWXp+Q+mhF4gZexOkKPRqhcpuYMFGBoLDlcIoZHux7Ea
        ooJJUbfE41MjJMaAAmPz0EvoBLJAA94=
X-Google-Smtp-Source: ABdhPJyF5h35DOr/8MfTzTm3JoKS8IEr43CMXzkHkX+mtZsVwzp04BPuwoxFcpu0YjQt4YRnrxIPog==
X-Received: by 2002:adf:e38d:: with SMTP id e13mr3654250wrm.402.1636588292179;
        Wed, 10 Nov 2021 15:51:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8sm1167612wrn.91.2021.11.10.15.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 15:51:31 -0800 (PST)
Message-Id: <3b210735bc86810c203bd6f16a503662a6239920.1636588289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v7.git.1636588289.gitgitgadget@gmail.com>
References: <pull.1052.v6.git.1635532975.gitgitgadget@gmail.com>
        <pull.1052.v7.git.1636588289.gitgitgadget@gmail.com>
From:   "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Nov 2021 23:51:29 +0000
Subject: [PATCH v7 2/2] http-fetch: redact url on die() message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Ivan Frade <ifrade@google.com>, Ivan Frade <ifrade@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ivan Frade <ifrade@google.com>

http-fetch prints the URL after failing to fetch it. This can be
confusing to users (they cannot really do anything with it), and they
can share by accident a sensitive URL (e.g. with credentials) while
looking for help.

Redact the URL unless the GIT_TRACE_REDACT variable is set to false. This
mimics the redaction of other sensitive information in git, like the
Authorization header in HTTP.

Fix also capitalization of previous die() message (must start in
lowercase).

Signed-off-by: Ivan Frade <ifrade@google.com>
---
 http-fetch.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index fa642462a9e..c7c7d391ac5 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -4,6 +4,7 @@
 #include "http.h"
 #include "walker.h"
 #include "strvec.h"
+#include "urlmatch.h"
 
 static const char http_fetch_usage[] = "git http-fetch "
 "[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin | --packfile=hash | commit-id] url";
@@ -63,8 +64,17 @@ static void fetch_single_packfile(struct object_id *packfile_hash,
 	if (start_active_slot(preq->slot)) {
 		run_active_slot(preq->slot);
 		if (results.curl_result != CURLE_OK) {
-			die("Unable to get pack file %s\n%s", preq->url,
-			    curl_errorstr);
+			struct url_info url;
+			char *nurl = url_normalize(preq->url, &url);
+			if (!nurl || !git_env_bool("GIT_TRACE_REDACT", 1)) {
+				die("unable to get pack file '%s'\n%s", preq->url,
+				    curl_errorstr);
+			} else {
+				die("failed to get '%.*s' url from '%.*s' "
+				    "(full URL redacted due to GIT_TRACE_REDACT setting)\n%s",
+				    (int)url.scheme_len, url.url,
+				    (int)url.host_len, &url.url[url.host_off], curl_errorstr);
+			}
 		}
 	} else {
 		die("Unable to start request");
-- 
gitgitgadget
