Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A83C4332F
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB9D610E5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhJ1WyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 18:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhJ1WyL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 18:54:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29917C061745
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 15:51:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m42so7205976wms.2
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 15:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BhbCaUpOAvUzWndZhw4WVCL0/92iUxY65m1Cl1Y3/gg=;
        b=Ds5ocXAmoFDeK9Y8bkD4kdVo3YF3HXU9iKwdUzx8fy7j5jGo5wdc9HcNKVGTbQBzxT
         rHaoi7N3TjGObcCJkHUGPwNUC6Tyww/ldOZHZ9pjNpJaJrj+ctj7oz2YZI7WIHaQ4V4Y
         KOHl1vxkiDn7ejYMO3lQluY5ckkCdzfVYuqbrjqKR+Tx36PqUZXOA1aM2DQYAPBo3ejO
         GLKXjghqQnQlcnud9odl9B/eIlyhqZybahwl+57rWPBCNU6fzOrgK38z5rfmq4FoF3eo
         SD13mY616OAJ/8W3iHFEhjbCoiWxfINaug4JP2wzpUxSnk7x52smkBzBfvxteVcNRe1N
         skOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BhbCaUpOAvUzWndZhw4WVCL0/92iUxY65m1Cl1Y3/gg=;
        b=TXmJbHPF4wzFOJFwCbc+v6vWPyipQXVTvF1zd+8KKYRAa74QE8uhNQHtUmjFz9HZJw
         o//ophHtijp49rQeNPWedp59vaYjTBtv4Rp/zXc0z8GY+XrtKHtI82tQ5FCuckBxD5H5
         JLUBOP+EDeh3C40qRx4x3hZxiRCYvGTQubQ1eHUimZBdGw2cCk5dliHm2FxMTHVTXM8Q
         aVmZfdWxet61yTyn59FnBR8txhXHjfTRa5n+pc5+alJLwsbOaQ48pOypLumv/hSz01Bj
         9tMkxUp7I0VfPyO/j/nejKYMOC7dzgLjNs92WK2qnAcpS6WMOYUrrim7J/C/9Vhy5cE0
         EoGQ==
X-Gm-Message-State: AOAM533gd2+VFvlXTngh41qKHg/mb0LIa0r6+98nSR4nykj3z+5PXTZz
        0w/vpem2eTKKV0jbC/kPvDLTe6UPPv8=
X-Google-Smtp-Source: ABdhPJzHAJYxn5YYVcX/71wyGGG7VeKwMPbU6+ggHT3RTKEPKB9Z4RN3nntaSyfcmS/qc/x5N5Z6rg==
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr7316087wmg.39.1635461502801;
        Thu, 28 Oct 2021 15:51:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h17sm2489046wrp.34.2021.10.28.15.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 15:51:42 -0700 (PDT)
Message-Id: <6912a690197ee292c7f11fa199ed52e7a9760145.1635461500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v5.git.1635461500.gitgitgadget@gmail.com>
References: <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com>
        <pull.1052.v5.git.1635461500.gitgitgadget@gmail.com>
From:   "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 22:51:40 +0000
Subject: [PATCH v5 2/2] http-fetch: redact url on die() message
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
