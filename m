Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 062041F803
	for <e@80x24.org>; Thu, 10 Jan 2019 19:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfAJTec (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 14:34:32 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:45029 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbfAJTeb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 14:34:31 -0500
Received: by mail-qt1-f202.google.com with SMTP id j5so12317678qtk.11
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 11:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WkPbmKE4EqFhKWYosAbesHk6+aKw8BGy9ySnI9h5PBA=;
        b=FXDFTbHj8XH+6xjY/uDnhotou43eydZGLdI/ozxA/ThpPDZ3vHRFKnas+TntLq24Uw
         yQrLIl6+BFfLGVDoTPLhVjU2X+8xuJZ7j0pe2B5285YKWV9aj/KAwnrnli+8gi8wD4bg
         riiSxgj9qp3xKQFZqTz2Taf/j74ju6mau0WAL1NJmttsE3tlLfFgcxmEak8a+pMRmLmG
         wkZBf5cwah5YT0bePFHDIe+D4kPUB+rOo68S49ckzvWmuN7VFBglh46QcjG0kpi/bHzZ
         m2qJw43mSyt+vToFHV/J5Ja9Qo6Q5pYaaa6tiYIgIrY/0UHRpnLeAnsTIkinYvboF/eM
         mliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WkPbmKE4EqFhKWYosAbesHk6+aKw8BGy9ySnI9h5PBA=;
        b=SndDjAJ9DNcsZcLgOeKZn7wh6aWxYaTplPx9q0tR6UpdItXg9ALY8spiWETuzZHzVo
         9wBYyQ+kI4rAN9OPe1GHqQlCXhSplkn1jKUcn3tHXHUXaAmM7Ytl84X4LbfcnphedYjv
         EDjYQaMkmA720uIsamFqCxRbv1sxS6GBXMGs2G98AjT04aSgD3a1eyIuwrNkcJ/LFuqs
         kwRJkMQ3EfhtxcXith4xUNDyNHwNaG4LhAhKJcaEn6WI2g59U5MlC4EBVRYOEIssLosc
         Y2HJ9V9e0K0+nb/guLRr4C0+Uh2yLNy5bPew1/T3uoxiDCe0QW9QBOPHqyRqSIAAGSz9
         HNig==
X-Gm-Message-State: AJcUukeb5Vt0Te9GcvoybjVM6C5SYnTRCmI8TON72NplW64AGhdiX8B9
        BGa2ld6zEhaf52vtSViJrmJXWwKvkippQkhtEI8=
X-Google-Smtp-Source: ALg8bN6bzmZavegMtGchlUfYZ0NikYRNYfbs5W6YpsBxrdU0Gr3DZ8LS63Azd1O3utZAA9xPon55ZGB2/L7FwppI0Os=
X-Received: by 2002:a0c:879a:: with SMTP id 26mr4413506qvj.62.1547148870458;
 Thu, 10 Jan 2019 11:34:30 -0800 (PST)
Date:   Thu, 10 Jan 2019 11:33:49 -0800
In-Reply-To: <20190110193350.213327-1-masayasuzuki@google.com>
Message-Id: <20190110193350.213327-5-masayasuzuki@google.com>
Mime-Version: 1.0
References: <20190108024741.62176-1-masayasuzuki@google.com> <20190110193350.213327-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v4 4/5] remote-curl: unset CURLOPT_FAILONERROR
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com, szeder.dev@gmail.com
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

