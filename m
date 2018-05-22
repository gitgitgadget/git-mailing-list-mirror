Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 193BF1F51C
	for <e@80x24.org>; Tue, 22 May 2018 18:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbeEVSmK (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 14:42:10 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:48581 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbeEVSmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 14:42:09 -0400
Received: by mail-io0-f202.google.com with SMTP id i1-v6so9795485ioh.15
        for <git@vger.kernel.org>; Tue, 22 May 2018 11:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=SJv+jeDabJ6RpzjNdCLklvfX7uoV2/AUKr+Fg2ONb1c=;
        b=kbeA9j3blxxObZciyRimMON3SkTuse5MNVxlH15HeVwY4eJySCxI8Qxmey1vnvGcXd
         Lh0WVxg/7KQ5lJ2nu/AXJhvMAErDkNUjfQYJVzqMdGLYt5KQH6sbgfvmABag0T2RtSha
         az7GCXufuakjOuEJKTll6F28xjWc3XT+HNWSmh2j66sB2wYHSOuGIZJpzb2PFcW7mxto
         bBIh+3/VjnMyH3zuWX1n/o9b1tMzaYtV1yDrHX5BuJq8PEM8IWoz71hZmNED4COZNzwz
         oiREtzQzCNXWsBuQbFHtWbpCdFUu72RY7jyuqLdpjx9d+Rpy/G4yKXx2IwIZfW+mEFEk
         ozRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=SJv+jeDabJ6RpzjNdCLklvfX7uoV2/AUKr+Fg2ONb1c=;
        b=CTxSXMtydaAA/z7BSnleWjGFjMBnrFX+9cdgQrZVoe8BGwpLT4IgWGHfm0obguqGea
         rBFNhu1hdnAWfKCpkDSkrJn2OiWsrbCTPLZAhKUwRGaAuvrqvDqOJ0JJ2wAIcS7ZnsT2
         XXKHylmNSQIa+9kd0PIq5DCMaNXnRXODhyXvnwMUhQAerDB25QdA0IJKpAkM7VMtmrmO
         N+ZdE5jOkPKGm+uJK7OrvmWcO5dGWPcu22AaHx++g9xca9HywL5ktQW+MqVR6/YRid/g
         ZI4IAV6M9Av1RH2uMXr7KlWWNiTBaVzrPew/s3rujzJcL3GbzlCQBzU6TiSqQfxaHUmL
         KKDg==
X-Gm-Message-State: ALKqPweuWmhd3euogvn+nqHA8KjjPP8vS0i+TP3s2heKkymCCHryrj0D
        Xl3dywSwYwzRveiOo5r9mLKlUNT+xIpsT90eB7uSK3l8bi40Y1fu3N2s0EnulEZ3z5lm4FxkYPp
        o/osPrEYJjnqdzhBEm2RuVQvFdgg6sPsAILYQS5t474ECGkx+S/JnPiQgtw==
X-Google-Smtp-Source: AB8JxZrJMTQg0SxwB5pDZQomzB7vh78T7TiGlkAcBOnW57zzUliybBe69nWZFrxzGp8bp4zSaB/XIanmkho=
MIME-Version: 1.0
X-Received: by 2002:a24:f107:: with SMTP id c7-v6mr1020791iti.29.1527014528842;
 Tue, 22 May 2018 11:42:08 -0700 (PDT)
Date:   Tue, 22 May 2018 11:42:03 -0700
In-Reply-To: <20180521234004.142548-1-bmwill@google.com>
Message-Id: <20180522184204.47332-1-bmwill@google.com>
References: <20180521234004.142548-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 1/2] remote-curl: accept all encodings supported by curl
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com,
        bmwill@google.com
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Configure curl to accept all encodings which curl supports instead of
only accepting gzip responses.

This fixes an issue when using an installation of curl which is built
without the "zlib" feature. Since aa90b9697 (Enable info/refs gzip
decompression in HTTP client, 2012-09-19) we end up requesting "gzip"
encoding anyway despite libcurl not being able to decode it.  Worse,
instead of getting a clear error message indicating so, we end up
falling back to "dumb" http, producing a confusing and difficult to
debug result.

Since curl doesn't do any checking to verify that it supports the a
requested encoding, instead set the curl option `CURLOPT_ENCODING` with
an empty string indicating that curl should send an "Accept-Encoding"
header containing only the encodings supported by curl.

Reported-by: Anton Golubev <anton.golubev@gmail.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---

Version 2 of this series just tweaks the commit message and the test per
Jonathan's suggestion.

 http.c                      |  2 +-
 remote-curl.c               |  2 +-
 t/t5551-http-fetch-smart.sh | 13 +++++++++----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index fed13b216..709150fc7 100644
--- a/http.c
+++ b/http.c
@@ -1788,7 +1788,7 @@ static int http_request(const char *url,
 
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
-	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
+	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
 
 	ret = run_one_slot(slot, &results);
 
diff --git a/remote-curl.c b/remote-curl.c
index ceb05347b..565bba104 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -684,7 +684,7 @@ static int post_rpc(struct rpc_state *rpc)
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
-	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
+	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
 
 	if (large_request) {
 		/* The request body is large and the size cannot be predicted.
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index f5721b4a5..913089b14 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -26,14 +26,14 @@ setup_askpass_helper
 cat >exp <<EOF
 > GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
 > Accept: */*
-> Accept-Encoding: gzip
+> Accept-Encoding: ENCODINGS
 > Pragma: no-cache
 < HTTP/1.1 200 OK
 < Pragma: no-cache
 < Cache-Control: no-cache, max-age=0, must-revalidate
 < Content-Type: application/x-git-upload-pack-advertisement
 > POST /smart/repo.git/git-upload-pack HTTP/1.1
-> Accept-Encoding: gzip
+> Accept-Encoding: ENCODINGS
 > Content-Type: application/x-git-upload-pack-request
 > Accept: application/x-git-upload-pack-result
 > Content-Length: xxx
@@ -79,8 +79,13 @@ test_expect_success 'clone http repository' '
 		/^< Date: /d
 		/^< Content-Length: /d
 		/^< Transfer-Encoding: /d
-	" >act &&
-	test_cmp exp act
+	" >actual &&
+	sed -e "s/^> Accept-Encoding: .*/> Accept-Encoding: ENCODINGS/" \
+			actual >actual.smudged &&
+	test_cmp exp actual.smudged &&
+
+	grep "Accept-Encoding:.*gzip" actual >actual.gzip &&
+	test_line_count = 2 actual.gzip
 '
 
 test_expect_success 'fetch changes via http' '
-- 
2.17.0.441.gb46fe60e1d-goog

