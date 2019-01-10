Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,UNWANTED_LANGUAGE_BODY,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A07251F803
	for <e@80x24.org>; Thu, 10 Jan 2019 19:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfAJTea (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 14:34:30 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:40222 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbfAJTe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 14:34:29 -0500
Received: by mail-vk1-f202.google.com with SMTP id s196so2382220vke.7
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 11:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TT45UDm9g2rUYvv+kMOZm9eoLtFQ5YsQseNzc46jSto=;
        b=t3JJlxHYQz+oSR4Dqu/4ukQej27NrBPrElT31+BIE7HQfnjbim2lP0HjgTRSH8Psyh
         P15g9VmGWgIP1jBFb7CCyphhGksh/6ITcmbSNYvOraLo2wkn4/0Oc2+6Cqag/qr/1P4v
         b9zaOUnnBmUcepLQWd9ssyzkhsRju7xCXU+ehzQwvYWD+9yu5nxran1spc99Ms8Mwe/b
         riac/TdGA3j0EV0l4PkVa49vwGs3edZFegkAaPdBHqYF9wIc2wyttkCbL86acF83T4l4
         y36KBuI1nUAe9tTKJSsJTGyMOsAA/vgrIFgia2O9+dSg4XSZxh1XeIV6Wb86lLBGcQda
         zMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TT45UDm9g2rUYvv+kMOZm9eoLtFQ5YsQseNzc46jSto=;
        b=Jrh7ZXJjrhiHCjwTcwgzhK4yKDLRgFRs1dV9iw5kwwtl56LG6AjfVUMrMjiV+O0q1S
         tHH7W5JsdQXp7bD1ykZp2Wl6BZtahVTOKEuwm2jak0/h4jzZPgBYNk2HdyF/WOL2nFv7
         NwO+fO20WdjOAly+qRii1TYkcyINdorTmxoA30rdQUV5P0LwKGhzATURECQnNxZVoJKl
         3TV0MWb5CYjjGW3xdrVM/KlbELsJrQBm1NOZa/nkaFzZWHpn1u2bZ3AtAa2nEyNvQRkx
         DKRGktQ/jLtYeDTHH+bKrLbo4BlOAuYs7Wz+OzcXJVpjh8S/An2oAMRfQK9iOapwBdPX
         cyPQ==
X-Gm-Message-State: AJcUukcsNie6dA7awWUa7beRl7wF0HBkXL3agtlLkGV7IPGaNWXyJKQU
        BgnNABFC937tGNimgDOpMSly9BYQCXQtGyqm73o=
X-Google-Smtp-Source: ALg8bN62liOC57+ZugvaAgRJlLEaDBAP9ltT1wzDUqlfIgGDXJ+079bP1eDFDSjkEvAqlh59mP5FEm4nxDysqTv1jfA=
X-Received: by 2002:a67:4950:: with SMTP id w77mr5247179vsa.40.1547148868033;
 Thu, 10 Jan 2019 11:34:28 -0800 (PST)
Date:   Thu, 10 Jan 2019 11:33:48 -0800
In-Reply-To: <20190110193350.213327-1-masayasuzuki@google.com>
Message-Id: <20190110193350.213327-4-masayasuzuki@google.com>
Mime-Version: 1.0
References: <20190108024741.62176-1-masayasuzuki@google.com> <20190110193350.213327-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v4 3/5] remote-curl: define struct for CURLOPT_WRITEFUNCTION
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com, szeder.dev@gmail.com
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

