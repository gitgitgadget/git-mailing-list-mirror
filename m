Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEDFC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 322A461039
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhJ2Spc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhJ2Sp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 14:45:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EB8C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 11:42:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d3so17799760wrh.8
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 11:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BhbCaUpOAvUzWndZhw4WVCL0/92iUxY65m1Cl1Y3/gg=;
        b=PEvehcDV31CEc/bgNBmr2zNOxKaiC91zvDG8m14KHTABWvt453OZk+1wFCBHGtWj5e
         XIvlYiOR/1IJISLnpXYOrZ7JzB+XjlmydSSdMMbNfjPql446sFvJo63x+lCF8RRlvWEL
         KLm08YazhmEXk9GVhPGRYKrjex3hEgDL0eQ5y5Og8VRrgyHcfhqZkfpV6rqm567UfTQl
         OV8SMVbvoQIKPBWY26jVEgFc6gdjizQubvaj+Yn/b1o5SKXXa677YdQBc6lPh5XmimQG
         PusQq9rvZ9V4kYS+MU8I6jxFHCbddWwo1IOhV4cEPft/a4RHeK/q9kBHZvW7JzDOB1J5
         mj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BhbCaUpOAvUzWndZhw4WVCL0/92iUxY65m1Cl1Y3/gg=;
        b=pSejSu/lBjNdM0DxDuijNv3/CPGA7h10r/0IVECfyo9a61pGm17ra9GhlOSyJ0CCzm
         /FgSeks+HMMg9ngWylaW8Z4FtINnwwMgTc9I7IJ56mwW8L4YYuR54tRZ0yK1GPK8vALO
         /4dE+DlZXOLwIjfrcE4XL5J8WhCSN2h5xrjUQTH+sbWwLIhSxaI0ibrv37eWnE3mrsGS
         nHH+2ftX5PT8IGnTBTDMYY1zbQpRBQhSjK5EYixMNDubEKKKruWEs8Q8KMe1nglWAAkB
         sMqoPkFhEQtiB7aZVauP6w9Li/jhQPOXYI7GrqYlcgK4FvD6PQIuSBUh2epHJ2D87gTA
         n9Nw==
X-Gm-Message-State: AOAM532B4ouxSIjI+AOTeHfF+ZDHTyVDVvJmSyV2u1BQ1WU0Yzi2gzrz
        PTmklBHBj9DbyYuFgeBfoOR+oMn793k=
X-Google-Smtp-Source: ABdhPJz5Z/l6fJeL/Un7CmrSbmB/fSUAWqg6quFOqU5YSSxqT66Qrtw6L8rNUrANJARHkrA6RMbdIA==
X-Received: by 2002:adf:d20e:: with SMTP id j14mr8716015wrh.220.1635532977424;
        Fri, 29 Oct 2021 11:42:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13sm2193103wrx.82.2021.10.29.11.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 11:42:57 -0700 (PDT)
Message-Id: <38859ae7b7de0f6406180a0427b9ce07fe3b9aa3.1635532975.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v6.git.1635532975.gitgitgadget@gmail.com>
References: <pull.1052.v5.git.1635461500.gitgitgadget@gmail.com>
        <pull.1052.v6.git.1635532975.gitgitgadget@gmail.com>
From:   "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 18:42:55 +0000
Subject: [PATCH v6 2/2] http-fetch: redact url on die() message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
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
