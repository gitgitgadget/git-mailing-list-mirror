Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490611F453
	for <e@80x24.org>; Wed,  6 Feb 2019 00:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfBFAVs (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 19:21:48 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:53018 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfBFAVq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 19:21:46 -0500
Received: by mail-pl1-f202.google.com with SMTP id 71so3603348plf.19
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 16:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G2xvV8tnV/PToPTaS5y6rVnMuq8BqsEGObq/fCfkyxc=;
        b=crdaJsF45aBbyv8rvfzLuaPvoXlgz8A/tFWaA+/5rbDPhuOgZS9U2kYMgrOQ2iI9Ds
         jFC81Bdf319h5v1iwY41Sj/D5d2gGL5PpJHiBSTTAVO4PpAky5Yc8MmIUU3Hfs3FcYZG
         /RP6ylctmDPZZvHU5fEe0HVEQ84eEplkQSiHGjVkqNmQZQvFKsocz35YblVqjyAAnjir
         R1nnBW7fQ7vIKLrcp0NzwrHVFrqfyJcJd65m3CEaCBwnj3D5MMgv+ZlAdTRUf+qwSvjO
         fROL1x6XJfCXnGrnvERQNp5NrKzxPxTgKV6N8fF3sizevtV1flz5H/h3RAC+7JXYzzYi
         y69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G2xvV8tnV/PToPTaS5y6rVnMuq8BqsEGObq/fCfkyxc=;
        b=NS+OQxx+hwzG8c2opqRbNESQT7JZ4MaUle0XmbD4bhm+MZeQxs3Z0h2newEIorqJTO
         EDATRSNcMZCP6xDd9Pap/CYXp/+cgWjbHYnLSmoUMhiws1GUvwysD96Y4R9ufzZVxQjw
         TRIGIO0M2Yt3l2/WGxm0anLpUp7a1ardGOSrjrnAb1Sx86MrKLEnLDF2DRL+b9+xzebM
         DoghrgBbSz9Pwmfx5chQm+iLBiqpupo8yW/gd3jUvxF8THBS8UhH4GCu1Guj/c6tJbIZ
         tYBZ2i5Wrat93cBQD7XcOodkup91hkq4KMjLtqTK+8fpGkofvj1vb7vJZnYOTnDVrs4y
         Txhg==
X-Gm-Message-State: AHQUAuZWiLewA15I1vLDvFExHdQFhe9ZaaUhh9ourQKSHLMgwHv0dRSx
        Z6FBiXhIwS2ZurR75hhvl+D0KIIgYYeT6CUo6RLHLfOiDDPlb/3XE/IjOeodlnTxuGCR9ctBnd0
        PGwU9CG9BeXV3AD3rU3cwizPbbF+FQxVkmtQNdYGI8Nhixbm01nPEiZ/32yidpo3NvTgEWH0JSZ
        IG
X-Google-Smtp-Source: AHgI3IYZdwN7SR/P5M9FD6LGD49dzzqGil38rXb2SuEQCWCk4awQwmn1V3H5s/JM2V9VNOu78ohkG3sa6y4ATMwk8Avx
X-Received: by 2002:a63:a4b:: with SMTP id z11mr2887545pgk.14.1549412506285;
 Tue, 05 Feb 2019 16:21:46 -0800 (PST)
Date:   Tue,  5 Feb 2019 16:21:22 -0800
In-Reply-To: <cover.1549411880.git.jonathantanmy@google.com>
Message-Id: <8d5ff2fc224e2ce7981bcae492de02a622889208.1549411880.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1549411880.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 8/8] remote-curl: in v2, fill credentials if needed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In post_rpc(), remote-curl calls credential_fill() if HTTP_REAUTH is
returned, but this is not true in proxy_request(). Do this in
proxy_request() too.

When t5551 is run using GIT_TEST_PROTOCOL_VERSION=2, one of the tests
that used to fail now pass.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 remote-curl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 293bcdb95b..437a8e76d8 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1295,7 +1295,9 @@ static size_t proxy_out(char *buffer, size_t eltsize,
 static int proxy_request(struct proxy_state *p)
 {
 	struct active_request_slot *slot;
+	int err;
 
+retry:
 	slot = get_active_slot();
 
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
@@ -1312,7 +1314,12 @@ static int proxy_request(struct proxy_state *p)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, proxy_out);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, p);
 
-	if (run_slot(slot, NULL) != HTTP_OK)
+	err = run_slot(slot, NULL);
+	if (err == HTTP_REAUTH) {
+		credential_fill(&http_auth);
+		goto retry;
+	}
+	if (err != HTTP_OK)
 		return -1;
 
 	return 0;
-- 
2.19.0.271.gfe8321ec05.dirty

