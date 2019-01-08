Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 077FA1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 02:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfAHCsI (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 21:48:08 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:43546 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbfAHCsH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 21:48:07 -0500
Received: by mail-qk1-f202.google.com with SMTP id z126so2020720qka.10
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 18:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WkPbmKE4EqFhKWYosAbesHk6+aKw8BGy9ySnI9h5PBA=;
        b=TwKPJSNqxFaeuEh37lvd+S234eyb7DLS7lDelG7ILE/cPZETlwhy+XdAAc+1xZWGN0
         K59ATS9nvTMNfEqp1zl7RA7cV32VWUc4OyU1soA0F6lhMspbRoqFWAqXY8xx/r7wdGUm
         +rA9Aju9DQ36Y3n1pINKyDgHStB98uNW4qT2S+8UGFhosij5r2w5DbygTquetZ7kAqaL
         gylgj326N+6QOzJrrCi9TFpiaiibDYIbAuh13XYOjsf+XTX1BR8FbEwIz1DqTCcmPpv4
         xHcsxXRRBPat/WiSi6WYdsfNTiuK1fq44VLXiuBnhx+V8lqlJGGmi5OZTDYxmlHzCqtY
         XVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WkPbmKE4EqFhKWYosAbesHk6+aKw8BGy9ySnI9h5PBA=;
        b=md06kb3sdn2JTMx3VtJ1BBc9X6qrEENs/4VGhViAYAcPIgnzmD9Z98nJYkRNu3Q/kD
         Y8uqcxTh/VbMwve09H/CartNLJNWwj0FyhrQLdjUkzy0A6LO37byzJgcXhddaKtiSLw1
         hCLaTYBXhuacRDyk8oMJpqeHiXgJvrIzOtbLcBqtgApIZbWtEAThLamTrqfK3lN9JYDG
         3OA+4zPCFqnZ2mKPygYKMVaVjUa119EVOXbzeyGS9lz1WA7tFvAMCvMIP1vrJ0A1NtBz
         sSgcnJLosdwCH+sONGbA1TsYjm2bd5jsPTQqsS9IW0/Wayx1TyoS8Z+e7Vbo6BhQd+V6
         qOng==
X-Gm-Message-State: AJcUukd6pVvRDu10nImniDiJk9zI98mNmkl0n+emffFIIpgR38PyDKsG
        C5DqWbDKMKwcjGaJ5mQkYH3P4h96HleJVX3NHEs=
X-Google-Smtp-Source: ALg8bN7xOweOBngINfY2qPa3v+DhyYIaMjgiyJpvapsC8Hs8lr1rgIXByg0ZHCpx+wpVGZEk5SDvgBM7SLVQNaptH5o=
X-Received: by 2002:a0c:b650:: with SMTP id q16mr7167qvf.22.1546915686750;
 Mon, 07 Jan 2019 18:48:06 -0800 (PST)
Date:   Mon,  7 Jan 2019 18:47:40 -0800
In-Reply-To: <20190108024741.62176-1-masayasuzuki@google.com>
Message-Id: <20190108024741.62176-5-masayasuzuki@google.com>
Mime-Version: 1.0
References: <20181229194447.157763-1-masayasuzuki@google.com> <20190108024741.62176-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v3 4/5] remote-curl: unset CURLOPT_FAILONERROR
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By not setting CURLOPT_FAILONERROR, curl parses the HTTP response
headers even if the response is an error. This makes GIT_CURL_VERBOSE to
show the HTTP headers, which is useful for debugging.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
 remote-curl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/remote-curl.c b/remote-curl.c
index d4673b6e8c..91b39ca098 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -547,6 +547,7 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 
 struct rpc_in_data {
 	struct rpc_state *rpc;
+	struct active_request_slot *slot;
 };
 
 /*
@@ -558,6 +559,13 @@ static size_t rpc_in(char *ptr, size_t eltsize,
 {
 	size_t size = eltsize * nmemb;
 	struct rpc_in_data *data = buffer_;
+	long response_code;
+
+	if (curl_easy_getinfo(data->slot->curl, CURLINFO_RESPONSE_CODE,
+			      &response_code) != CURLE_OK)
+		return size;
+	if (response_code >= 300)
+		return size;
 	if (size)
 		data->rpc->any_written = 1;
 	write_or_die(data->rpc->in, ptr, size);
@@ -774,7 +782,9 @@ static int post_rpc(struct rpc_state *rpc)
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
 	rpc_in_data.rpc = rpc;
+	rpc_in_data.slot = slot;
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &rpc_in_data);
+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
 
 
 	rpc->any_written = 0;
-- 
2.20.1.97.g81188d93c3-goog

