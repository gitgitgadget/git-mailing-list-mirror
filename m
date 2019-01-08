Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,UNWANTED_LANGUAGE_BODY,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78FB01F803
	for <e@80x24.org>; Tue,  8 Jan 2019 02:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfAHCsF (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 21:48:05 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:52675 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbfAHCsF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 21:48:05 -0500
Received: by mail-qt1-f202.google.com with SMTP id w15so2178754qtk.19
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 18:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TT45UDm9g2rUYvv+kMOZm9eoLtFQ5YsQseNzc46jSto=;
        b=OUkn6wwP1HP2QEKZCQYFKkMCuLmHMrztlh8wS1V+ylpCvEzf5ptpxJNgleBGW/XAoi
         SElzRHnIhan4ovVjaAg2D0Do5Mqu6e2G/zlh1cSY5MThDwsTcewRmeWYwgjizz9wB97B
         zGQf5lJrsRjvZXV43ps0k6HXkIvZLWWLAFryMQFYoEqlgkqJslf17X6DIxb25ZkDc2w+
         O+G2OV6pC85jKYMhXwJ4VFdj8KU4zeeATr+UpZSQdJquozBRWvy49zy4vun6x/7bucgy
         /Z5BQU9XNIcFnljJYvv7V58kIsdzipycsNwCmia1fb9YoFZSVEZutA+WpPffk6e577Ei
         ArnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TT45UDm9g2rUYvv+kMOZm9eoLtFQ5YsQseNzc46jSto=;
        b=e+WtBj731NwvHciN39VTTrZruRew2V2HQmqq1iYUIxcAanytVuzSdZOtNvwCUXUuSO
         y9xVDqNZHZUSF6UmxZgmIH/4hqzxNK+qyW2Qt7YejVUbRNp35Fltl2+r0B3yQyCGA2Ny
         T5+Jf5Sf6r7m3RotqCPpRgIkNZx/WFY0EAFyojhhvVxC5iZaEfvRnM0h1yxllAdM5Lqj
         3oBzY6lBkJa1lF49b76E4jN9w3Ihxs6moEElwk0Ez+zudSsouu2ke4a4cCTGbxY4zZe/
         vKJgQgoizSSu9s4FTbchJzvSNZt3tBvXjVmt9ZkyX8w3m1S/0jKBOxTibCZTD3G077DG
         frfg==
X-Gm-Message-State: AJcUukfQakjlRb4xO/D0xTvM9eLrAi6vrLP31w9e+hJ8D+7MjLPLZm06
        eBf8CXayxBbic2VrO13sfWVYdG/q9DgXu93pp3Q=
X-Google-Smtp-Source: ALg8bN57XtVG5wwPDJS5eOHADnmTAxqqWVOWh48/0fFE7zwTSSJJPpQ1wltCdUlQIsaSe7DlfPJJTol4mrGlT8ximoU=
X-Received: by 2002:a37:d4d4:: with SMTP id s81mr3925qks.34.1546915684031;
 Mon, 07 Jan 2019 18:48:04 -0800 (PST)
Date:   Mon,  7 Jan 2019 18:47:39 -0800
In-Reply-To: <20190108024741.62176-1-masayasuzuki@google.com>
Message-Id: <20190108024741.62176-4-masayasuzuki@google.com>
Mime-Version: 1.0
References: <20181229194447.157763-1-masayasuzuki@google.com> <20190108024741.62176-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v3 3/5] remote-curl: define struct for CURLOPT_WRITEFUNCTION
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to pass more values for rpc_in, define a struct and pass it as
an additional value.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
 remote-curl.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index d8eda2380a..d4673b6e8c 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -545,14 +545,22 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 }
 #endif
 
+struct rpc_in_data {
+	struct rpc_state *rpc;
+};
+
+/*
+ * A callback for CURLOPT_WRITEFUNCTION. The return value is the bytes consumed
+ * from ptr.
+ */
 static size_t rpc_in(char *ptr, size_t eltsize,
 		size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
-	struct rpc_state *rpc = buffer_;
+	struct rpc_in_data *data = buffer_;
 	if (size)
-		rpc->any_written = 1;
-	write_or_die(rpc->in, ptr, size);
+		data->rpc->any_written = 1;
+	write_or_die(data->rpc->in, ptr, size);
 	return size;
 }
 
@@ -632,6 +640,7 @@ static int post_rpc(struct rpc_state *rpc)
 	size_t gzip_size = 0;
 	int err, large_request = 0;
 	int needs_100_continue = 0;
+	struct rpc_in_data rpc_in_data;
 
 	/* Try to load the entire request, if we can fit it into the
 	 * allocated buffer space we can use HTTP/1.0 and avoid the
@@ -764,7 +773,8 @@ static int post_rpc(struct rpc_state *rpc)
 
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
+	rpc_in_data.rpc = rpc;
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &rpc_in_data);
 
 
 	rpc->any_written = 0;
-- 
2.20.1.97.g81188d93c3-goog

