Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E966AC43334
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 17:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiFLRU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiFLRU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 13:20:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0862459A
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 10:20:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u8so4487378wrm.13
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 10:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yDJRm3+jSH2bKEDW+ujS17rUh85wqacieNzqfjhcVB4=;
        b=HupIwU/pmRzuLUsLhzcpUY1JLkBrEKWzRgkPZL9sWti1K95uCh79ToYdBIYgADjMVf
         btPC4z72CAdAquM6mhs4HTzhos3C9/8YiXL/EN1nKcTF9bIJG6BfsQ09aOzLwyco2h2F
         lbOUFatOnIDCu+2t5ut6wcRxrVAUlk+agr1N6Uv/nrU+WGvvnqa37SP56AC8bFxYZIQr
         XB+MV5PJoUe/exwEIKYbotbh6YEEgQCWwWsVz26TOPRn7L/GELRCsTzC6JdFMGNjFIIG
         mz10Qn/GUfFLWv7rjMURXDAMncpEZZ7E5aGgamr45eiEc0B+ruWMnAiJvK+9WLHdEyos
         2rLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yDJRm3+jSH2bKEDW+ujS17rUh85wqacieNzqfjhcVB4=;
        b=dqQAXw3cB+T95smdGbbyTQCo6A0bOP/Ea+v9xgWNMfjfI5hiXIxD4vCIxWr237XMWv
         4J1sZxIOELy26CFiLrdfw5DrDOstOswuwJ+sFFGUjP1pcI2J5uZVuMKl0ay2G/S+8ZWx
         P4eQpSyWg8B1tWfTdZzUJzlOaQWiCIb5SCtQ2Wb0GO+1PDH71TDVEoCEWVR8SuCFrnvL
         fBSKVacvrpSmVjnx2X1lMOXZlKDgPOVLt6FhLhav4aCohCNfugHqG+pZGfZzyGebJWY3
         J3soKPbj1MhIDElXRDcWDvk87bNce2mXNdUZiOQGrurJFMI/BVJDHVmuvSjwySGhCn6e
         iQOA==
X-Gm-Message-State: AOAM531ODC/VQeDo7N+TGOGQq7cI2MjJUCp3AbxsgMpZZd5U5TvgavuX
        QupDq1JJmt3iKn6RicYAxb22hboyVMDdfg==
X-Google-Smtp-Source: ABdhPJyO86Bu2Sa1/1KGQ3y1TuxRsHysodzVl17afyy8AvgTvPipJf5m8twqFe5UD5azDFgEit4kvA==
X-Received: by 2002:a05:6000:a0b:b0:219:f87e:86b with SMTP id co11-20020a0560000a0b00b00219f87e086bmr6398968wrb.570.1655054423196;
        Sun, 12 Jun 2022 10:20:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay15-20020a5d6f0f000000b002183cf9cd69sm6118022wrb.15.2022.06.12.10.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 10:20:22 -0700 (PDT)
Message-Id: <pull.1251.v3.git.1655054421697.gitgitgadget@gmail.com>
In-Reply-To: <pull.1251.v2.git.1654756523475.gitgitgadget@gmail.com>
References: <pull.1251.v2.git.1654756523475.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 12 Jun 2022 17:20:21 +0000
Subject: [PATCH v3] remote-curl: send Accept-Language header to server
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Li Linchao <lilinchao@oschina.cn>,
        Li Linchao <lilinchao@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Li Linchao <lilinchao@oschina.cn>

Git server end's ability to accept Accept-Language header was introduced
in f18604bbf2 (http: add Accept-Language header if possible, 2015-01-28),
but this is only used by very early phase of the transfer, which is HTTP
GET request to discover references. For other phases, like POST request
in the smart HTTP, the server does not know what language the client
speaks.

Teach git client to learn end-user's preferred language and throw
accept-language header to the server side. Once the server gets this header,
it has the ability to talk to end-user with language they understand.
This would be very helpful for many non-English speakers.

Signed-off-by: Li Linchao <lilinchao@oschina.cn>
---
    remote-curl: send Accept-Language header to server
    
    Change since v2:
    
     * free rpc.hdr_accept_language to avoid memory leak
     * fix test to reuse language to avoid install new language pack
     * reword commit message
    
    Changes since v1:
    
     * change get_accept_language() to http_get_accept_language_header()
     * reuse test case in t5550
     * reword commit message
    
    TODO: For SSH tranport, give it an environment variable to understand
    locale language.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1251%2FCactusinhand%2Fllc%2Fsend-Accept-Language-header-to-HTTP-server-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1251/Cactusinhand/llc/send-Accept-Language-header-to-HTTP-server-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1251

Range-diff vs v2:

 1:  a2dd9d4070e ! 1:  99a4e23ceb1 remote-curl: send Accept-Language header to server
     @@ Commit message
          remote-curl: send Accept-Language header to server
      
          Git server end's ability to accept Accept-Language header was introduced
     -    in f18604bbf2(http: add Accept-Language header if possible), but this is
     -    only used by very early phase of the transfer, that's HTTP GET request to
     -    discover references. For other phases, like POST request in the smart HTTP
     -    the server side don't know what language the client speaks.
     +    in f18604bbf2 (http: add Accept-Language header if possible, 2015-01-28),
     +    but this is only used by very early phase of the transfer, which is HTTP
     +    GET request to discover references. For other phases, like POST request
     +    in the smart HTTP, the server does not know what language the client
     +    speaks.
      
          Teach git client to learn end-user's preferred language and throw
          accept-language header to the server side. Once the server gets this header,
     @@ remote-curl.c: static int post_rpc(struct rpc_state *rpc, int stateless_connect,
       	/* Add the extra Git-Protocol header */
       	if (rpc->protocol_header)
       		headers = curl_slist_append(headers, rpc->protocol_header);
     -@@ remote-curl.c: static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
     - 		       struct strbuf *rpc_result)
     - {
     - 	const char *svc = rpc->service_name;
     -+	const char *accept_language;
     - 	struct strbuf buf = STRBUF_INIT;
     - 	struct child_process client = CHILD_PROCESS_INIT;
     - 	int err = 0;
      @@ remote-curl.c: static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
       	strbuf_addf(&buf, "%s%s", url.buf, svc);
       	rpc->service_url = strbuf_detach(&buf, NULL);
       
     -+	accept_language = http_get_accept_language_header();
     -+	if (accept_language) {
     -+		strbuf_addstr(&buf, accept_language);
     -+		rpc->hdr_accept_language = strbuf_detach(&buf, NULL);
     -+	}
     ++	rpc->hdr_accept_language = xstrdup_or_null(http_get_accept_language_header());
      +
       	strbuf_addf(&buf, "Content-Type: application/x-%s-request", svc);
       	rpc->hdr_content_type = strbuf_detach(&buf, NULL);
       
     +@@ remote-curl.c: static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
     + 	free(rpc->service_url);
     + 	free(rpc->hdr_content_type);
     + 	free(rpc->hdr_accept);
     ++	free(rpc->hdr_accept_language);
     + 	free(rpc->protocol_header);
     + 	free(rpc->buf);
     + 	strbuf_release(&buf);
      @@ remote-curl.c: static int stateless_connect(const char *service_name)
       	struct discovery *discover;
       	struct rpc_state rpc;
     @@ remote-curl.c: static int stateless_connect(const char *service_name)
       
       	rpc.service_name = service_name;
       	rpc.service_url = xstrfmt("%s%s", url.buf, rpc.service_name);
     +@@ remote-curl.c: static int stateless_connect(const char *service_name)
     + 	free(rpc.service_url);
     + 	free(rpc.hdr_content_type);
     + 	free(rpc.hdr_accept);
     ++	free(rpc.hdr_accept_language);
     + 	free(rpc.protocol_header);
     + 	free(rpc.buf);
     + 	strbuf_release(&buf);
      
       ## t/t5541-http-push-smart.sh ##
      @@ t/t5541-http-push-smart.sh: test_expect_success 'push to remote repository (standard)' '
     @@ t/t5541-http-push-smart.sh: test_expect_success 'push to remote repository (stan
       
      +test_expect_success 'push to remote repository (standard) with sending Accept-Language' '
      +	cat >exp <<-\EOF &&
     -+	=> Send header: Accept-Language: zh-CN, en;q=0.9, *;q=0.8
     -+	=> Send header: Accept-Language: zh-CN, en;q=0.9, *;q=0.8
     ++	=> Send header: Accept-Language: ko-KR, *;q=0.9
     ++	=> Send header: Accept-Language: ko-KR, *;q=0.9
      +	EOF
      +
      +	cd "$ROOT_PATH"/test_repo_clone &&
     @@ t/t5541-http-push-smart.sh: test_expect_success 'push to remote repository (stan
      +	test_tick &&
      +	git commit -m path_lang &&
      +	HEAD=$(git rev-parse --verify HEAD) &&
     -+	GIT_TRACE_CURL=true LANGUAGE="zh_CN:en" git push -v -v 2>err &&
     ++	GIT_TRACE_CURL=true LANGUAGE="ko_KR.UTF-8" git push -v -v 2>err &&
      +	! grep "Expect: 100-continue" err &&
      +
      +	grep "=> Send header: Accept-Language:" err >err.language &&
     @@ t/t5541-http-push-smart.sh: test_expect_success 'push to remote repository (stan
       '
      
       ## t/t5550-http-fetch-dumb.sh ##
     -@@ t/t5550-http-fetch-dumb.sh: test_expect_success 'git client sends Accept-Language correctly with unordinary
     - 	check_language "ko-KR, en-US;q=0.9, *;q=0.8" "ko_KR::en_US" &&
     - 	check_language "ko-KR, *;q=0.9" ":::ko_KR" &&
     - 	check_language "ko-KR, en-US;q=0.9, *;q=0.8" "ko_KR!!:en_US" &&
     --	check_language "ko-KR, ja-JP;q=0.9, *;q=0.8" "ko_KR en_US:ja_JP"'
     -+	check_language "ko-KR, ja-JP;q=0.9, zh-CN;q=0.8, *;q=0.7" "ko_KR en_US:ja_JP:zh_CN"'
     - 
     - test_expect_success 'git client sends Accept-Language with many preferred languages' '
     --	check_language "ko-KR, en-US;q=0.9, fr-CA;q=0.8, de;q=0.7, sr;q=0.6, \
     --ja;q=0.5, zh;q=0.4, sv;q=0.3, pt;q=0.2, *;q=0.1" \
     --		ko_KR.EUC-KR:en_US.UTF-8:fr_CA:de.UTF-8@euro:sr@latin:ja:zh:sv:pt &&
     -+	check_language "ko-KR, en-US;q=0.99, fr-CA;q=0.98, de;q=0.97, sr;q=0.96, \
     -+ja;q=0.95, zh;q=0.94, sv;q=0.93, pt;q=0.92, zh-CN;q=0.91, *;q=0.90" \
     -+		ko_KR.EUC-KR:en_US.UTF-8:fr_CA:de.UTF-8@euro:sr@latin:ja:zh:sv:pt:zh_CN &&
     - 	check_language "ko-KR, en-US;q=0.99, fr-CA;q=0.98, de;q=0.97, sr;q=0.96, \
     - ja;q=0.95, zh;q=0.94, sv;q=0.93, pt;q=0.92, nb;q=0.91, *;q=0.90" \
     +@@ t/t5550-http-fetch-dumb.sh: ja;q=0.95, zh;q=0.94, sv;q=0.93, pt;q=0.92, nb;q=0.91, *;q=0.90" \
       		ko_KR.EUC-KR:en_US.UTF-8:fr_CA:de.UTF-8@euro:sr@latin:ja:zh:sv:pt:nb
       '
       
     @@ t/t5551-http-fetch-smart.sh: test_expect_success 'clone http repository' '
       	> GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
       	> Accept: */*
       	> Accept-Encoding: ENCODINGS
     -+	> Accept-Language: zh-CN, en;q=0.9, *;q=0.8
     ++	> Accept-Language: ko-KR, *;q=0.9
       	> Pragma: no-cache
       	< HTTP/1.1 200 OK
       	< Pragma: no-cache
     @@ t/t5551-http-fetch-smart.sh: test_expect_success 'clone http repository' '
       	> Accept-Encoding: ENCODINGS
       	> Content-Type: application/x-git-upload-pack-request
       	> Accept: application/x-git-upload-pack-result
     -+	> Accept-Language: zh-CN, en;q=0.9, *;q=0.8
     ++	> Accept-Language: ko-KR, *;q=0.9
       	> Content-Length: xxx
       	< HTTP/1.1 200 OK
       	< Pragma: no-cache
     @@ t/t5551-http-fetch-smart.sh: test_expect_success 'clone http repository' '
       	EOF
      -	GIT_TRACE_CURL=true GIT_TEST_PROTOCOL_VERSION=0 \
      +
     -+	GIT_TRACE_CURL=true GIT_TEST_PROTOCOL_VERSION=0 LANGUAGE="zh_CN:en" \
     ++	GIT_TRACE_CURL=true GIT_TEST_PROTOCOL_VERSION=0 LANGUAGE="ko_KR.UTF-8" \
       		git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
       	test_cmp file clone/file &&
       	tr '\''\015'\'' Q <err |
     @@ t/t5551-http-fetch-smart.sh: test_expect_success 'clone http repository' '
      -		test_line_count = 2 actual.gzip
      +		test_line_count = 2 actual.gzip &&
      +
     -+		grep "Accept-Language: zh-CN, en" actual >actual.language &&
     ++		grep "Accept-Language: ko-KR, *" actual >actual.language &&
      +		test_line_count = 2 actual.language
       	fi
       '


 http.c                      |  4 ++--
 http.h                      |  3 +++
 remote-curl.c               | 13 +++++++++++++
 t/t5541-http-push-smart.sh  | 19 +++++++++++++++++++
 t/t5550-http-fetch-dumb.sh  |  2 +-
 t/t5551-http-fetch-smart.sh | 10 ++++++++--
 6 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/http.c b/http.c
index 11c6f69facd..33301d8d5d5 100644
--- a/http.c
+++ b/http.c
@@ -1775,7 +1775,7 @@ static void write_accept_language(struct strbuf *buf)
  *   LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *; q=0.1"
  *   LANGUAGE= LANG=C -> ""
  */
-static const char *get_accept_language(void)
+const char *http_get_accept_language_header(void)
 {
 	if (!cached_accept_language) {
 		struct strbuf buf = STRBUF_INIT;
@@ -1829,7 +1829,7 @@ static int http_request(const char *url,
 					 fwrite_buffer);
 	}
 
-	accept_language = get_accept_language();
+	accept_language = http_get_accept_language_header();
 
 	if (accept_language)
 		headers = curl_slist_append(headers, accept_language);
diff --git a/http.h b/http.h
index ba303cfb372..3c94c479100 100644
--- a/http.h
+++ b/http.h
@@ -178,6 +178,9 @@ int http_fetch_ref(const char *base, struct ref *ref);
 int http_get_info_packs(const char *base_url,
 			struct packed_git **packs_head);
 
+/* Helper for getting Accept-Language header */
+const char *http_get_accept_language_header(void);
+
 struct http_pack_request {
 	char *url;
 
diff --git a/remote-curl.c b/remote-curl.c
index 67f178b1120..251d4ee64f6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -580,6 +580,7 @@ struct rpc_state {
 	char *service_url;
 	char *hdr_content_type;
 	char *hdr_accept;
+	char *hdr_accept_language;
 	char *protocol_header;
 	char *buf;
 	size_t alloc;
@@ -932,6 +933,10 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 	headers = curl_slist_append(headers, needs_100_continue ?
 		"Expect: 100-continue" : "Expect:");
 
+	/* Add Accept-Language header */
+	if (rpc->hdr_accept_language)
+		headers = curl_slist_append(headers, rpc->hdr_accept_language);
+
 	/* Add the extra Git-Protocol header */
 	if (rpc->protocol_header)
 		headers = curl_slist_append(headers, rpc->protocol_header);
@@ -1080,6 +1085,8 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 	strbuf_addf(&buf, "%s%s", url.buf, svc);
 	rpc->service_url = strbuf_detach(&buf, NULL);
 
+	rpc->hdr_accept_language = xstrdup_or_null(http_get_accept_language_header());
+
 	strbuf_addf(&buf, "Content-Type: application/x-%s-request", svc);
 	rpc->hdr_content_type = strbuf_detach(&buf, NULL);
 
@@ -1118,6 +1125,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 	free(rpc->service_url);
 	free(rpc->hdr_content_type);
 	free(rpc->hdr_accept);
+	free(rpc->hdr_accept_language);
 	free(rpc->protocol_header);
 	free(rpc->buf);
 	strbuf_release(&buf);
@@ -1400,6 +1408,7 @@ static int stateless_connect(const char *service_name)
 	struct discovery *discover;
 	struct rpc_state rpc;
 	struct strbuf buf = STRBUF_INIT;
+	const char *accept_language;
 
 	/*
 	 * Run the info/refs request and see if the server supports protocol
@@ -1418,6 +1427,9 @@ static int stateless_connect(const char *service_name)
 		printf("\n");
 		fflush(stdout);
 	}
+	accept_language = http_get_accept_language_header();
+	if (accept_language)
+		rpc.hdr_accept_language = xstrfmt("%s", accept_language);
 
 	rpc.service_name = service_name;
 	rpc.service_url = xstrfmt("%s%s", url.buf, rpc.service_name);
@@ -1467,6 +1479,7 @@ static int stateless_connect(const char *service_name)
 	free(rpc.service_url);
 	free(rpc.hdr_content_type);
 	free(rpc.hdr_accept);
+	free(rpc.hdr_accept_language);
 	free(rpc.protocol_header);
 	free(rpc.buf);
 	strbuf_release(&buf);
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 2f09ff4fac6..fbad2d5ff5e 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -80,6 +80,25 @@ test_expect_success 'push to remote repository (standard)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
+test_expect_success 'push to remote repository (standard) with sending Accept-Language' '
+	cat >exp <<-\EOF &&
+	=> Send header: Accept-Language: ko-KR, *;q=0.9
+	=> Send header: Accept-Language: ko-KR, *;q=0.9
+	EOF
+
+	cd "$ROOT_PATH"/test_repo_clone &&
+	: >path_lang &&
+	git add path_lang &&
+	test_tick &&
+	git commit -m path_lang &&
+	HEAD=$(git rev-parse --verify HEAD) &&
+	GIT_TRACE_CURL=true LANGUAGE="ko_KR.UTF-8" git push -v -v 2>err &&
+	! grep "Expect: 100-continue" err &&
+
+	grep "=> Send header: Accept-Language:" err >err.language &&
+	test_cmp exp err.language
+'
+
 test_expect_success 'push already up-to-date' '
 	git push
 '
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index f0d9cd584d3..bc308519af5 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -369,7 +369,7 @@ ja;q=0.95, zh;q=0.94, sv;q=0.93, pt;q=0.92, nb;q=0.91, *;q=0.90" \
 		ko_KR.EUC-KR:en_US.UTF-8:fr_CA:de.UTF-8@euro:sr@latin:ja:zh:sv:pt:nb
 '
 
-test_expect_success 'git client does not send an empty Accept-Language' '
+test_expect_success 'git client send an empty Accept-Language' '
 	GIT_TRACE_CURL=true LANGUAGE= git ls-remote "$HTTPD_URL/dumb/repo.git" 2>stderr &&
 	! grep "^=> Send header: Accept-Language:" stderr
 '
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index b9351a732f6..245532df881 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -31,6 +31,7 @@ test_expect_success 'clone http repository' '
 	> GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
 	> Accept: */*
 	> Accept-Encoding: ENCODINGS
+	> Accept-Language: ko-KR, *;q=0.9
 	> Pragma: no-cache
 	< HTTP/1.1 200 OK
 	< Pragma: no-cache
@@ -40,13 +41,15 @@ test_expect_success 'clone http repository' '
 	> Accept-Encoding: ENCODINGS
 	> Content-Type: application/x-git-upload-pack-request
 	> Accept: application/x-git-upload-pack-result
+	> Accept-Language: ko-KR, *;q=0.9
 	> Content-Length: xxx
 	< HTTP/1.1 200 OK
 	< Pragma: no-cache
 	< Cache-Control: no-cache, max-age=0, must-revalidate
 	< Content-Type: application/x-git-upload-pack-result
 	EOF
-	GIT_TRACE_CURL=true GIT_TEST_PROTOCOL_VERSION=0 \
+
+	GIT_TRACE_CURL=true GIT_TEST_PROTOCOL_VERSION=0 LANGUAGE="ko_KR.UTF-8" \
 		git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
 	test_cmp file clone/file &&
 	tr '\''\015'\'' Q <err |
@@ -94,7 +97,10 @@ test_expect_success 'clone http repository' '
 		test_cmp exp actual.smudged &&
 
 		grep "Accept-Encoding:.*gzip" actual >actual.gzip &&
-		test_line_count = 2 actual.gzip
+		test_line_count = 2 actual.gzip &&
+
+		grep "Accept-Language: ko-KR, *" actual >actual.language &&
+		test_line_count = 2 actual.language
 	fi
 '
 

base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
-- 
gitgitgadget
