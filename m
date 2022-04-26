Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93B5C433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 11:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245555AbiDZLEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 07:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbiDZLEo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 07:04:44 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5745C28E10
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 04:01:37 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x18so24967995wrc.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 04:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+zh+/WNeDRtegZ8/P8+MWDXKbYNnak86xfOYbhGgsUM=;
        b=pnELhgRpTGtJaCygQoFt6XKjsanx17SAIx2OoVDZBqeXcSYif3zQdd7aWBmMSDklD7
         fzs21JKb+YtqKs5dWf4YZXrFebNQ9DJhs2H1+CIqEWwccDPyhDA7iuvFQ0gkcRPXziFM
         h55iMzi7ZdypZnF40Izg2Fm9YcqabJnP6SxSrJpkDgZ6hwr0bIrjWrQg1uh7v+2bAmuV
         mCxdskizERUkGRsLIC4FofZJphYJW0i9oCzFpy00ILEmI7UGQ3ORoKwYat4PyNPeUwpV
         QV7redzpHR693p4ymBbADqRf83aaMNTsP6CG536mSpkzqz8kkLj5dg095jwnUSCfh/Ax
         CGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+zh+/WNeDRtegZ8/P8+MWDXKbYNnak86xfOYbhGgsUM=;
        b=MTmsQ+X1I3gaJZvw21QOEz7OBTqKn5ZUJwtWLokqBOTcrhMkVMQAiawR/+98Py1n+s
         EF1K8Q8BFvhqwxf0zozioGBQJX0CrvtXOeikroyq3Xg5vqUy6oECIhX8kG3nGttEj4lb
         /7U8bitLJWZ87E28cwOxOFwB8cvxpNNqPl1hWzLmvBalU/IQ4VuTFmnDbXwmhqRlY5uB
         5pKDC26Y4J7pC6B2xPq4sj+zabJyPBdAp3jRfpOzAY3A9uRmRx4g06a/M9LGeFTwXdxr
         7HiYKa0Gqyc18EkmmiDlVgqRDJVkLzg6RPpEbYGQGBB/maSgAzes2gzVWVrlVt9xJ7fp
         LPhw==
X-Gm-Message-State: AOAM533h2biuldMHKIuU8OqEsz6B1IefNh7eIn1vSmJMB/ou3Aav0EZI
        7zm4amRoXgOrQeaF+GeLhPnk18Hw6cQ=
X-Google-Smtp-Source: ABdhPJxg5abbX6AlvU1rDnDM31b0RKB3Np6VbRrFuciTvsPmYp/GcZrMXc+PmMYbMzf8DHwBW03JzA==
X-Received: by 2002:a5d:610b:0:b0:20a:e00b:5e46 with SMTP id v11-20020a5d610b000000b0020ae00b5e46mr5249381wrt.293.1650970895424;
        Tue, 26 Apr 2022 04:01:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6-20020a1c2506000000b0038e6fe8e8d8sm13589050wml.5.2022.04.26.04.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 04:01:34 -0700 (PDT)
Message-Id: <pull.1225.git.1650970894143.gitgitgadget@gmail.com>
From:   "Drew Green via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Apr 2022 11:01:34 +0000
Subject: [PATCH] Added Curl Option to Override Request Method
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Drew Green <agreenbhm@gmail.com>, agreenbhm <agreenbhm@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: agreenbhm <agreenbhm@gmail.com>

Added support for environment variable "CURLOPT_CUSTOMREQUEST"
to allow setting the curl option to override the default request
method used by HTTP Git operations.  Primary reason for this is to
allow support for cloning repositories where only GET requests
are allowed but not POSTs.  When cloning a repo first a GET is
made to the server and then a POST is made to the "git-upload-pack"
endpoint.  In some corporate environments with strong controls
only GET requests are allowed to known repository hosts (such
as GitHub) to prevent data leakage by sending data.  Using this
new environmental variable, a user can set
"CURLOPT_CUSTOMREQUEST=GET" which will change the second request
from a POST to a GET, bypassing web proxy restrictions on the type
of requests allowed.  Tested with GitHub, changing the request
from POST to GET still results in the expected behavior of the
repo successfully being cloned.

Signed-off-by: agreenbhm <agreenbhm@gmail.com>
---
    Added Curl Option to Override Request Method
    
    Added support for environment variable "CURLOPT_CUSTOMREQUEST" to allow
    setting the curl option to override the default request method used by
    HTTP Git operations. Primary reason for this is to allow support for
    cloning repositories where only GET requests are allowed but not POSTs.
    When cloning a repo first a GET is made to the server and then a POST is
    made to the "git-upload-pack" endpoint. In some corporate environments
    with strong controls only GET requests are allowed to known repository
    hosts (such as GitHub) to prevent data leakage by sending data. Using
    this new environmental variable, a user can set
    "CURLOPT_CUSTOMREQUEST=GET" which will change the second request from a
    POST to a GET, bypassing web proxy restrictions on the type of requests
    allowed. Tested with GitHub, changing the request from POST to GET still
    results in the expected behavior of the repo successfully being cloned.
    
    Signed-off-by: agreenbhm agreenbhm@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1225%2Fagreenbhm%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1225/agreenbhm/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1225

 http.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http.c b/http.c
index 229da4d1488..2ca13b848a5 100644
--- a/http.c
+++ b/http.c
@@ -1235,6 +1235,8 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
 	if (http_auth.password || curl_empty_auth_enabled())
 		init_curl_http_auth(slot->curl);
+	if(getenv("CURLOPT_CUSTOMREQUEST"))
+		curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, getenv("CURLOPT_CUSTOMREQUEST"));
 
 	return slot;
 }

base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
-- 
gitgitgadget
