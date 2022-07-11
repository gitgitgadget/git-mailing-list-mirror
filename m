Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A892FC433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 05:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiGKF7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 01:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGKF67 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 01:58:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6AE2602
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 22:58:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id ay25so2430418wmb.1
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 22:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eJDTwAB2n52XfLND+q4LYGwNjaQfH5Gb9ErVTcqQrME=;
        b=C32W8nvsa+bodGpigsfSMaG1p+JfQ/vx7jH3JfnKgK+Uu/12/mU2dTO6tjvtTq5Izv
         Nn2y5J3mJ4NyESzCDDtxLWvDqnf/z8AR2Kpkd3/DIsGB6OwuOnVtMdQPHyxndw9YABtD
         88l9Xun9PE+a9TJWEbmXpTMx+ObVRHPZdE/llyo0UMvfJANn12rqXeDtSeOZTJmo/vJc
         ahl0Zy6HHXOMvuGyly9PDS698CIH68FOpg4D3BKjJzYCbOPlZ9Wa+JIneSewKWyeJV8j
         W8IVxBiubwjf/M0iexe1FZOncl3iFY9M0zHR3joFkoqrSTKGx59tlbCq+SYiRltQuWDw
         fyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eJDTwAB2n52XfLND+q4LYGwNjaQfH5Gb9ErVTcqQrME=;
        b=i9sNHvl3COprv7vZ/wbOk7XkaCiHksbPNYdGiCLAwpbojhByrNU0OSsXsInQqz2KlP
         qjbHjsG3k+fLagNtL2dzsSLm9FokdqO6odTIUj55u2O3uGs1ztDPVgHbOMPYV4b7kDPr
         wy+Vv8NtWMWJgehug/SDaDpQRhzz3DYwa3rJs98PCbZaA4NUeGDY49GoSWvW3YGj8sem
         zhTQJQQ1avMKnbamCvVZz2rwdaQwBIUMDT+tmsvytNjxZOteok+DC4vFsb4yNtRnYFt/
         2Y3DCRMlS9rXuw7kEoCRO2q9Jpjrscox8XonR705+ZIqYIC/AHcKP8KJcsElTcifFPdm
         60tQ==
X-Gm-Message-State: AJIora97MZqOhq2HYpdx9XPTWvV8M0TNS11IktPp5pcONzqNOV5X8Z+X
        bHM7oNTRLSX6ocDd65T/z1WQaDd52MA=
X-Google-Smtp-Source: AGRyM1v74PALFbkXgyGwDYPZ/1/WIAKo5NvOt371ya6QXEwVyUP8w73Lw/gu3Ywi9Z4M7Xcuu/b1QQ==
X-Received: by 2002:a05:600c:3491:b0:3a0:4d4a:2e2d with SMTP id a17-20020a05600c349100b003a04d4a2e2dmr14371865wmq.4.1657519135814;
        Sun, 10 Jul 2022 22:58:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c434700b003a2da6b2cbesm5680116wme.33.2022.07.10.22.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 22:58:55 -0700 (PDT)
Message-Id: <pull.1251.v4.git.1657519134336.gitgitgadget@gmail.com>
In-Reply-To: <pull.1251.v3.git.1655054421697.gitgitgadget@gmail.com>
References: <pull.1251.v3.git.1655054421697.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Jul 2022 05:58:54 +0000
Subject: [PATCH v4] remote-curl: send Accept-Language header to server
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

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Li Linchao <lilinchao@oschina.cn>
---
    remote-curl: send Accept-Language header to server
    
    Changes sin v3:
    
     * fix rpc_state initialization issue
    
    Changes since v2:
    
     * free rpc.hdr_accept_language to avoid memory leak
     * fix test to reuse language to avoid install new language pack
     * reword commit message
    
    Changes since v1:
    
     * change get_accept_language() to http_get_accept_language_header()
     * reuse test case in t5550
     * reword commit message
    
    TODO: For SSH tranport, give it an environment variable to understand
    locale language.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1251%2FCactusinhand%2Fllc%2Fsend-Accept-Language-header-to-HTTP-server-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1251/Cactusinhand/llc/send-Accept-Language-header-to-HTTP-server-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1251

Range-diff vs v3:

 1:  99a4e23ceb1 ! 1:  3bec1e85e26 remote-curl: send Accept-Language header to server
     @@ Commit message
          it has the ability to talk to end-user with language they understand.
          This would be very helpful for many non-English speakers.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Li Linchao <lilinchao@oschina.cn>
      
       ## http.c ##
     @@ remote-curl.c: struct rpc_state {
       	char *protocol_header;
       	char *buf;
       	size_t alloc;
     +@@ remote-curl.c: struct rpc_state {
     + 	unsigned flush_read_but_not_sent : 1;
     + };
     + 
     ++#define RPC_STATE_INIT { 0 }
     ++
     + /*
     +  * Appends the result of reading from rpc->out to the string represented by
     +  * rpc->buf and rpc->len if there is enough space. Returns 1 if there was
      @@ remote-curl.c: static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
       	headers = curl_slist_append(headers, needs_100_continue ?
       		"Expect: 100-continue" : "Expect:");
     @@ remote-curl.c: static int rpc_service(struct rpc_state *rpc, struct discovery *h
       	free(rpc->protocol_header);
       	free(rpc->buf);
       	strbuf_release(&buf);
     -@@ remote-curl.c: static int stateless_connect(const char *service_name)
     +@@ remote-curl.c: static int fetch_dumb(int nr_heads, struct ref **to_fetch)
     + static int fetch_git(struct discovery *heads,
     + 	int nr_heads, struct ref **to_fetch)
     + {
     +-	struct rpc_state rpc;
     ++	struct rpc_state rpc = RPC_STATE_INIT;
     + 	struct strbuf preamble = STRBUF_INIT;
     + 	int i, err;
     + 	struct strvec args = STRVEC_INIT;
     +@@ remote-curl.c: static int push_dav(int nr_spec, const char **specs)
     + 
     + static int push_git(struct discovery *heads, int nr_spec, const char **specs)
     + {
     +-	struct rpc_state rpc;
     ++	struct rpc_state rpc = RPC_STATE_INIT;
     + 	int i, err;
     + 	struct strvec args;
     + 	struct string_list_item *cas_option;
     +@@ remote-curl.c: free_specs:
     + static int stateless_connect(const char *service_name)
     + {
       	struct discovery *discover;
     - 	struct rpc_state rpc;
     +-	struct rpc_state rpc;
     ++	struct rpc_state rpc = RPC_STATE_INIT;
       	struct strbuf buf = STRBUF_INIT;
      +	const char *accept_language;
       


 http.c                      |  4 ++--
 http.h                      |  3 +++
 remote-curl.c               | 21 ++++++++++++++++++---
 t/t5541-http-push-smart.sh  | 19 +++++++++++++++++++
 t/t5550-http-fetch-dumb.sh  |  2 +-
 t/t5551-http-fetch-smart.sh | 10 ++++++++--
 6 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/http.c b/http.c
index 168ca30c558..5d0502f51fd 100644
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
index 67f178b1120..b8758757ece 100644
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
@@ -607,6 +608,8 @@ struct rpc_state {
 	unsigned flush_read_but_not_sent : 1;
 };
 
+#define RPC_STATE_INIT { 0 }
+
 /*
  * Appends the result of reading from rpc->out to the string represented by
  * rpc->buf and rpc->len if there is enough space. Returns 1 if there was
@@ -932,6 +935,10 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 	headers = curl_slist_append(headers, needs_100_continue ?
 		"Expect: 100-continue" : "Expect:");
 
+	/* Add Accept-Language header */
+	if (rpc->hdr_accept_language)
+		headers = curl_slist_append(headers, rpc->hdr_accept_language);
+
 	/* Add the extra Git-Protocol header */
 	if (rpc->protocol_header)
 		headers = curl_slist_append(headers, rpc->protocol_header);
@@ -1080,6 +1087,8 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 	strbuf_addf(&buf, "%s%s", url.buf, svc);
 	rpc->service_url = strbuf_detach(&buf, NULL);
 
+	rpc->hdr_accept_language = xstrdup_or_null(http_get_accept_language_header());
+
 	strbuf_addf(&buf, "Content-Type: application/x-%s-request", svc);
 	rpc->hdr_content_type = strbuf_detach(&buf, NULL);
 
@@ -1118,6 +1127,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 	free(rpc->service_url);
 	free(rpc->hdr_content_type);
 	free(rpc->hdr_accept);
+	free(rpc->hdr_accept_language);
 	free(rpc->protocol_header);
 	free(rpc->buf);
 	strbuf_release(&buf);
@@ -1153,7 +1163,7 @@ static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 static int fetch_git(struct discovery *heads,
 	int nr_heads, struct ref **to_fetch)
 {
-	struct rpc_state rpc;
+	struct rpc_state rpc = RPC_STATE_INIT;
 	struct strbuf preamble = STRBUF_INIT;
 	int i, err;
 	struct strvec args = STRVEC_INIT;
@@ -1299,7 +1309,7 @@ static int push_dav(int nr_spec, const char **specs)
 
 static int push_git(struct discovery *heads, int nr_spec, const char **specs)
 {
-	struct rpc_state rpc;
+	struct rpc_state rpc = RPC_STATE_INIT;
 	int i, err;
 	struct strvec args;
 	struct string_list_item *cas_option;
@@ -1398,8 +1408,9 @@ free_specs:
 static int stateless_connect(const char *service_name)
 {
 	struct discovery *discover;
-	struct rpc_state rpc;
+	struct rpc_state rpc = RPC_STATE_INIT;
 	struct strbuf buf = STRBUF_INIT;
+	const char *accept_language;
 
 	/*
 	 * Run the info/refs request and see if the server supports protocol
@@ -1418,6 +1429,9 @@ static int stateless_connect(const char *service_name)
 		printf("\n");
 		fflush(stdout);
 	}
+	accept_language = http_get_accept_language_header();
+	if (accept_language)
+		rpc.hdr_accept_language = xstrfmt("%s", accept_language);
 
 	rpc.service_name = service_name;
 	rpc.service_url = xstrfmt("%s%s", url.buf, rpc.service_name);
@@ -1467,6 +1481,7 @@ static int stateless_connect(const char *service_name)
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
 

base-commit: 30cc8d0f147546d4dd77bf497f4dec51e7265bd8
-- 
gitgitgadget
