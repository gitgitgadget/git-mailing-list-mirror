Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159E6C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9D620838
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LkT+BE6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbgJLSsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 14:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgJLSsU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 14:48:20 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B77C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 11:48:20 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d5so12508476qkg.16
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 11:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=e+VZ++kymGR3G1Ywah3ufHzhbUV8UmdvcdhehSzlw5U=;
        b=LkT+BE6biMj7SBL170THXAz6jFaB0n9eiSGzs00ANH536wdT3MBuo+OtGwtmXUsHdU
         16Y5+uIHOSq80GHtkmMjm0RGGfzl6ZIU4sgLtWEUIZTzWjbRcYVodc97fSt59sVdBqa6
         LJGm042ndKGwqhlKuRV8yacCiLunVGBW7FsAxT7ttQNrqljT6rC3EGCf85SFr0Th7qNX
         irPAgRkbBxTwcrkW9LWlnDRxYvBXgtGJ8jqpdZV4ZjH2YrlfX1tiRut+OxVVjVkr5FIm
         2xIoTg4K1373QgJupqdd5zdfdCfv7mXpKdrg6+bkmraoepoqNchhZaBU5YKXLL478b8X
         iYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e+VZ++kymGR3G1Ywah3ufHzhbUV8UmdvcdhehSzlw5U=;
        b=aQ+UrXB3TjZWfte24ZRAWLJ0Smn3SuFZel7QI5XBN4xBEG2wqvl1CKjscryO06EhJv
         baON8dDjzsnlrhwfA7GL3O4ZFymhPWAnMbc/k83ytKAcGqcsNw/J9QPm08a+aLdJAeqL
         VjT2KpSvjiCoOjWkQYeBQFfJxB7w4VE9XVa/UI6LMI2kXCxzYFb5rmindEc8SWWH9ES7
         EAJiPWTr5EyCJtCDko8Zzptgf/AgsuGiTv9JodLe9nmL5Z8lSjgqB/rfyPunj0HpGHAt
         H+VS1SJvKSOf9WdsW7glE13OhDO8NWBHgVEfCdxhFGlMcv6PCRazcPQR5tpZyN/kGX0/
         bgaQ==
X-Gm-Message-State: AOAM533JTFwSevb2EHp5Qxi9cy7hZRot0bJbUzpBes2IuKth7d/smjP3
        IVB3G/jFaxhEw58tLYS21EaPuvTLKl0hBl+yEEM3t/VjfXNQ/+NHKAudiZBix0uRSag+M2f1cVP
        90IicSN7g07li0AsV6AhZxnOiohtjgmZd1V6xoQDz9KdaHl/zHhstmDyycFo6Cco=
X-Google-Smtp-Source: ABdhPJxpJmKVspV4KfyItoxAaEtmSvZhoUoC/GvvNeD70OIhwHIpoA/CpyWmhSz23FNdmDVo+6jSPUcAj6mbUA==
Sender: "smcallis via sendgmr" <smcallis@smcallis.bld.corp.google.com>
X-Received: from smcallis.bld.corp.google.com ([2620:15c:183:200:a6ae:11ff:fe11:fc5d])
 (user=smcallis job=sendgmr) by 2002:a05:6214:184c:: with SMTP id
 d12mr27291242qvy.11.1602528499426; Mon, 12 Oct 2020 11:48:19 -0700 (PDT)
Date:   Mon, 12 Oct 2020 12:48:06 -0600
In-Reply-To: <20201012184806.166251-1-smcallis@google.com>
Message-Id: <20201012184806.166251-3-smcallis@google.com>
Mime-Version: 1.0
References: <20201012184806.166251-1-smcallis@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH 3/3] http: automatically retry some requests
From:   Sean McAllister <smcallis@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        masayasuzuki@google.com
Cc:     Sean McAllister <smcallis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some HTTP response codes indicate a server state that can support
retrying the request rather than immediately erroring out.  The server
can also provide information about how long to wait before retries to
via the Retry-After header.  So check the server response and retry
some reasonable number of times before erroring out to better accomodate
transient errors.

Exiting immediately becomes irksome when pulling large multi-repo code
bases such as Android or Chromium, as often the entire fetch operation
has to be restarted from the beginning due to an error in one repo. If
we can reduce how often that occurs, then it's a big win.

Signed-off-by: Sean McAllister <smcallis@google.com>
---
 Documentation/config/http.txt |   5 ++
 http.c                        | 121 +++++++++++++++++++++++++++++++++-
 http.h                        |  13 +++-
 remote-curl.c                 |   2 +-
 t/t5539-fetch-http-shallow.sh |  41 ++++++++----
 t/t5540-http-push-webdav.sh   |  26 +++++++-
 t/t5541-http-push-smart.sh    |  15 +++++
 t/t5550-http-fetch-dumb.sh    |  12 ++++
 t/t5551-http-fetch-smart.sh   |  14 ++++
 t/t5601-clone.sh              |   6 +-
 10 files changed, 237 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 3968fbb697..0beec3d370 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -260,6 +260,11 @@ http.followRedirects::
 	the base for the follow-up requests, this is generally
 	sufficient. The default is `initial`.
 
+http.retryLimit::
+	Some HTTP error codes (eg: 429,503) can reasonably be retried if
+	they're encountered.  This value configures the number of retry attempts
+	before giving up.  The default retry limit is 3.
+
 http.<url>.*::
 	Any of the http.* options above can be applied selectively to some URLs.
 	For a config key to match a URL, each element of the config key is
diff --git a/http.c b/http.c
index b3c1669388..e41d7c5575 100644
--- a/http.c
+++ b/http.c
@@ -92,6 +92,9 @@ static const char *http_proxy_ssl_key;
 static const char *http_proxy_ssl_ca_info;
 static struct credential proxy_cert_auth = CREDENTIAL_INIT;
 static int proxy_ssl_cert_password_required;
+static int http_retry_limit = 3;
+static int http_default_delay = 2;
+static int http_max_delay = 60;
 
 static struct {
 	const char *name;
@@ -219,6 +222,51 @@ size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf)
 	return nmemb;
 }
 
+
+/* return 1 for a retryable HTTP code, 0 otherwise */
+static int retryable_code(int code)
+{
+	switch(code) {
+	case 429: /* fallthrough */
+	case 502: /* fallthrough */
+	case 503: /* fallthrough */
+	case 504: return 1;
+	default:  return 0;
+	}
+}
+
+size_t http_header_value(
+	const struct strbuf headers, const char *header, char **value)
+{
+	size_t len = 0;
+	struct strbuf **lines, **line;
+	char *colon = NULL;
+
+	lines = strbuf_split(&headers, '\n');
+	for (line = lines; *line; line++) {
+		strbuf_trim(*line);
+
+		/* find colon and null it out to 'split' string */
+		colon = strchr((*line)->buf, ':');
+		if (colon) {
+			*colon = '\0';
+
+			if (!strcasecmp(header, (*line)->buf)) {
+				/* move past colon and skip whitespace */
+				colon++;
+				while (*colon && isspace(*colon)) colon++;
+				*value = xstrdup(colon);
+				len = strlen(*value);
+				goto done;
+			}
+		}
+	}
+
+done:
+	strbuf_list_free(lines);
+	return len;
+}
+
 static void closedown_active_slot(struct active_request_slot *slot)
 {
 	active_requests--;
@@ -452,6 +500,11 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp("http.retrylimit", var)) {
+		http_retry_limit = git_config_int(var, value);
+		return 0;
+	}
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
 }
@@ -1668,7 +1721,7 @@ static int handle_curl_result(struct slot_results *results)
 }
 
 int run_one_slot(struct active_request_slot *slot,
-		 struct slot_results *results)
+		 struct slot_results *results, int *http_code)
 {
 	slot->results = results;
 	if (!start_active_slot(slot)) {
@@ -1678,6 +1731,8 @@ int run_one_slot(struct active_request_slot *slot,
 	}
 
 	run_active_slot(slot);
+	if (http_code)
+		*http_code = results->http_code;
 	return handle_curl_result(results);
 }
 
@@ -1903,20 +1958,55 @@ static void http_opt_request_remainder(CURL *curl, off_t pos)
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
 
+/* check for a retry-after header in the given headers string, if found, then
+honor it, otherwise do an exponential backoff up to the max on the current delay
+*/
+static int http_retry_after(const struct strbuf headers, int cur_delay) {
+	int len, delay;
+	char *end;
+	char *value;
+
+	len = http_header_value(headers, "retry-after", &value);
+	if (len) {
+		delay = strtol(value, &end, 0);
+		if (*value && *end == 0 && delay >= 0) {
+			if (delay > http_max_delay) {
+				die(Q_(
+						"server requested retry after %d second, which is longer than max allowed\n",
+						"server requested retry after %d seconds, which is longer than max allowed\n", delay), delay);
+			}
+			free(value);
+			return delay;
+		}
+		free(value);
+	}
+
+	cur_delay *= 2;
+	return cur_delay >= http_max_delay ? http_max_delay : cur_delay;
+}
+
 static int http_request(const char *url,
 			void *result, int target,
 			const struct http_get_options *options)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
-	struct curl_slist *headers = http_copy_default_headers();
+	struct curl_slist *headers;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf result_headers = STRBUF_INIT;
 	const char *accept_language;
 	int ret;
+	int retry_cnt = 0;
+	int retry_delay = http_default_delay;
+	int http_code;
 
+retry:
 	slot = get_active_slot();
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, &result_headers);
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_buffer);
+
 	if (result == NULL) {
 		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
 	} else {
@@ -1936,6 +2026,7 @@ static int http_request(const char *url,
 
 	accept_language = get_accept_language();
 
+	headers = http_copy_default_headers();
 	if (accept_language)
 		headers = curl_slist_append(headers, accept_language);
 
@@ -1961,7 +2052,31 @@ static int http_request(const char *url,
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
 
-	ret = run_one_slot(slot, &results);
+	http_code = 0;
+	ret = run_one_slot(slot, &results, &http_code);
+
+	if (ret != HTTP_OK) {
+		if (retryable_code(http_code) && (retry_cnt < http_retry_limit)) {
+			retry_cnt++;
+			retry_delay = http_retry_after(result_headers, retry_delay);
+			fprintf(stderr,
+			    Q_("got HTTP response %d, retrying after %d second (%d/%d)\n",
+				   "got HTTP response %d, retrying after %d seconds (%d/%d)\n",
+					retry_delay),
+				http_code, retry_delay, retry_cnt, http_retry_limit);
+			sleep(retry_delay);
+
+			// remove header data fields since not all slots will use them
+			curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, NULL);
+			curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, NULL);
+
+			goto retry;
+		}
+	}
+
+	// remove header data fields since not all slots will use them
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, NULL);
 
 	if (options && options->content_type) {
 		struct strbuf raw = STRBUF_INIT;
diff --git a/http.h b/http.h
index 5de792ef3f..60ce03801f 100644
--- a/http.h
+++ b/http.h
@@ -86,6 +86,17 @@ size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp);
 #endif
 
+/*
+ * Query the value of an HTTP header.
+ *
+ * If the header is found, then a newly allocate string is returned through
+ * the value parameter, and the length is returned.
+ *
+ * If not found, returns 0
+ */
+size_t http_header_value(
+	const struct strbuf headers, const char *header, char **value);
+
 /* Slot lifecycle functions */
 struct active_request_slot *get_active_slot(void);
 int start_active_slot(struct active_request_slot *slot);
@@ -99,7 +110,7 @@ void finish_all_active_slots(void);
  *
  */
 int run_one_slot(struct active_request_slot *slot,
-		 struct slot_results *results);
+		 struct slot_results *results, int *http_code);
 
 #ifdef USE_CURL_MULTI
 void fill_active_slots(void);
diff --git a/remote-curl.c b/remote-curl.c
index 7f44fa30fe..2657c95bcb 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -805,7 +805,7 @@ static int run_slot(struct active_request_slot *slot,
 	if (!results)
 		results = &results_buf;
 
-	err = run_one_slot(slot, results);
+	err = run_one_slot(slot, results, NULL);
 
 	if (err != HTTP_OK && err != HTTP_REAUTH) {
 		struct strbuf msg = STRBUF_INIT;
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index 82aa99ae87..e09083e2b3 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -30,20 +30,39 @@ test_expect_success 'clone http repository' '
 	git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	git clone $HTTPD_URL/smart/repo.git clone &&
 	(
-	cd clone &&
-	git fsck &&
-	git log --format=%s origin/master >actual &&
-	cat <<EOF >expect &&
-7
-6
-5
-4
-3
-EOF
-	test_cmp expect actual
+		cd clone &&
+		git fsck &&
+		git log --format=%s origin/master >actual &&
+		cat <<-\EOF >expect &&
+		7
+		6
+		5
+		4
+		3
+		EOF
+		test_cmp expect actual
 	)
 '
 
+test_expect_success 'clone http repository with flaky http' '
+    rm -rf clone &&
+	git clone $HTTPD_URL/error_ntime/`gen_nonce`/3/429/1/smart/repo.git clone 2>err &&
+	(
+		cd clone &&
+		git fsck &&
+		git log --format=%s origin/master >actual &&
+		cat <<-\EOF >expect &&
+		7
+		6
+		5
+		4
+		3
+		EOF
+		test_cmp expect actual
+	) &&
+    test_i18ngrep "got HTTP response 429" err
+'
+
 # This test is tricky. We need large enough "have"s that fetch-pack
 # will put pkt-flush in between. Then we need a "have" the server
 # does not have, it'll send "ACK %s ready"
diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index 450321fddb..d8234d555c 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -68,12 +68,36 @@ test_expect_success 'push already up-to-date' '
 	git push
 '
 
+test_expect_success 'push to remote repository with packed refs and flakey server' '
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	 rm -rf packed-refs &&
+	 git update-ref refs/heads/master $ORIG_HEAD &&
+	 git --bare update-server-info) &&
+    git remote set-url origin $HTTPD_URL/error_ntime/`gen_nonce`/3/502/1/dumb/test_repo.git &&
+	git push &&
+    git remote set-url origin $HTTPD_URL/dumb/test_repo.git &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	 test $HEAD = $(git rev-parse --verify HEAD))
+'
+
 test_expect_success 'push to remote repository with unpacked refs' '
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
-	 rm packed-refs &&
+	 rm -rf packed-refs &&
+	 git update-ref refs/heads/master $ORIG_HEAD &&
+	 git --bare update-server-info) &&
+	git push &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	 test $HEAD = $(git rev-parse --verify HEAD))
+'
+
+test_expect_success 'push to remote repository with unpacked refs and flakey server' '
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	 rm -rf packed-refs &&
 	 git update-ref refs/heads/master $ORIG_HEAD &&
 	 git --bare update-server-info) &&
+    git remote set-url origin $HTTPD_URL/error_ntime/`gen_nonce`/3/502/1/dumb/test_repo.git &&
 	git push &&
+    git remote set-url origin $HTTPD_URL/dumb/test_repo.git &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 187454f5dd..9b2fc62e11 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -77,6 +77,21 @@ test_expect_success 'push to remote repository (standard)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
+test_expect_success 'push to remote repository (flakey server)' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	: >path5 &&
+	git add path5 &&
+	test_tick &&
+	git commit -m path5 &&
+	HEAD=$(git rev-parse --verify HEAD) &&
+	git remote set-url origin $HTTPD_URL/error_ntime/`gen_nonce`/3/502/1/smart/test_repo.git &&
+	GIT_TRACE_CURL=true git push -v -v 2>err &&
+	git remote set-url origin $HTTPD_URL/smart/test_repo.git &&
+	grep "POST git-receive-pack ([0-9]* bytes)" err &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	test $HEAD = $(git rev-parse --verify HEAD))
+'
+
 test_expect_success 'push already up-to-date' '
 	git push
 '
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 483578b2d7..350c47097b 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -176,6 +176,18 @@ test_expect_success 'fetch changes via http' '
 	test_cmp file clone/file
 '
 
+test_expect_success 'fetch changes via flakey http' '
+	echo content >>file &&
+	git commit -a -m three &&
+	git push public &&
+	(cd clone &&
+		git remote set-url origin $HTTPD_URL/error_ntime/`gen_nonce`/3/502/1/dumb/repo.git &&
+		git pull 2>../err &&
+		git remote set-url origin $HTTPD_URL/dumb/repo.git) &&
+    test_i18ngrep "got HTTP response 502" err &&
+	test_cmp file clone/file
+'
+
 test_expect_success 'fetch changes via manual http-fetch' '
 	cp -R clone-tmpl clone2 &&
 
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index e40e9ed52f..85d2a0e8b8 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -45,6 +45,7 @@ test_expect_success 'clone http repository' '
 	EOF
 	GIT_TRACE_CURL=true GIT_TEST_PROTOCOL_VERSION=0 \
 		git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
+    cd clone && git config pull.rebase false && cd .. &&
 	test_cmp file clone/file &&
 	tr '\''\015'\'' Q <err |
 	sed -e "
@@ -103,6 +104,19 @@ test_expect_success 'fetch changes via http' '
 	test_cmp file clone/file
 '
 
+test_expect_success 'fetch changes via flakey http' '
+	echo content >>file &&
+	git commit -a -m two &&
+	git push public &&
+	(cd clone &&
+		git remote set-url origin $HTTPD_URL/error_ntime/`gen_nonce`/3/502/1/smart/repo.git &&
+		git pull 2>../err &&
+		git remote set-url origin $HTTPD_URL/smart/repo.git) &&
+	test_cmp file clone/file &&
+    test_i18ngrep "got HTTP response 502" err
+'
+
+
 test_expect_success 'used upload-pack service' '
 	cat >exp <<-\EOF &&
 	GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 71d4307001..9988e3ff14 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -757,13 +757,17 @@ test_expect_success 'partial clone using HTTP' '
 '
 
 test_expect_success 'partial clone using HTTP with redirect' '
-    _NONCE=`gen_nonce` && export _NONCE &&
+    _NONCE=`gen_nonce` &&
     curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" > /dev/null &&
     curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" > /dev/null &&
     curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" > /dev/null &&
 	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server"
 '
 
+test_expect_success 'partial clone with retry' '
+	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/error_ntime/`gen_nonce`/3/429/1/smart/server" 2>err &&
+    test_i18ngrep "got HTTP response 429" err
+'
 
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
-- 
2.28.0.1011.ga647a8990f-goog

