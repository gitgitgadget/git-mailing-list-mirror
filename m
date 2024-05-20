Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736651D531
	for <git@vger.kernel.org>; Mon, 20 May 2024 21:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716239374; cv=none; b=H9mwn4kT1wI2byRCvhTSxE4rryAyZv5lZXRKXH4UYrZnJt/3XDiaRRSNykut98W86lR0LHGUPNSXr96edqJ9cspAh87qs+xNXqiI34pdmQMyKVFUFGsKLLlnDg1z1UMscGRUMHJ/09DPzTL1bWP20AbbBS/MqTqt0b7RBQh7454=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716239374; c=relaxed/simple;
	bh=mHjA97uGZPqyZ0C2pgjdslyaidhRGapmNxJO06/t/AU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=PD1Okfc/I0l02ZJBuU3mUYOTMHehVNYE0uJQPuF2T/LtZLcZ6bmOvsaSE1/MnssTSCva3BbgnDkVq66fRxVnThbPs3KkTR3iSOjB2T3LWjhMz1J2aPmcOnCKpluRJ6yBuIaIBfXV/zyGAi6wDtuWJcEraz3hkhV/rheesFO8Mpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMSFwfI6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMSFwfI6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4202c0d316cso15207165e9.1
        for <git@vger.kernel.org>; Mon, 20 May 2024 14:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716239369; x=1716844169; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V3E/f9UR5v5JdS+2vur/8UBhAC97KBYxdYv+t6CjLT0=;
        b=CMSFwfI6dWkyZofOvKLfGR9oFfqRuUpfEfv4n/9/AUWhFK1uWhW/1ITv99RX8eENoC
         cEHv7E6hRCUGYlrubV+H2qsb2MC/7LU603Cg+UIn5TOZdPpvtAZkWdH9yPCjRxZ+IXMb
         YDPBbyng1NaZsFaVobszKmK+7uJ0xE5B0N4nFhFoaCuG1HnuX+8ZB6L5uwxDVFzB5v70
         s5M1Um1laOrh0INiek8BVxXh7VcYQ4HH/ruMf2H8pzg4MuavSl9gL4Qv/IxnB2Nr5hS2
         jGDfEHI6NyVauoT1ytWYL5EihwBUSoRnIdQHlzqeM9Szh1TQMQLgKzyHEv6t6dTiYU/i
         +7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716239369; x=1716844169;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3E/f9UR5v5JdS+2vur/8UBhAC97KBYxdYv+t6CjLT0=;
        b=SaToK3m4W7Nz//r0v2l/WIHgzZRdy4QECyNBjj6pwlPYEyQGEruVkXlFKpDgVDhdMr
         R6/1boJ8z7wORcYkM5vbmav9mqVRuyMgb+wT8U4i0bj89KbRvfmrQqpVsopznUB7c7oJ
         UiMWow/wG9oSjzUeIjPGPIFcmzQpWBZZl6jxyPzvzPXRbVya1GcUdJ/2+sf+yzWNA1K8
         uUJwuUncKkTAQAJrZwCqs01ZOS5tuhVoCzqzp6rZoO1IfkqXrTZmREyIhNr223cKliFm
         sfD9jDW+tglBw/cs9sd0s4SVOtnKxdrQB4GqF+KPDEoODTX8ZRZlCVXECqSGf4/o3hcS
         99AQ==
X-Gm-Message-State: AOJu0YxVK9t/HBaUAbCiPXD0S9NYDABeB9InEbFmZS1w4/jYr2GB2YCU
	GCx6Og9SyNltq4wwHoIQ75O35xd7US4F3SHlP/S+8JpWnwUM8qgf5z96hQ==
X-Google-Smtp-Source: AGHT+IGadv6fQaOZcualp7nKz3ZYOMg+dJy9WTjbkbKuZcQzgWbGQ/a/zPE62BUP1WFGDy0MoJq7OQ==
X-Received: by 2002:a5d:4ed2:0:b0:354:b641:ae8a with SMTP id ffacd0b85a97d-354b9068fafmr5960756f8f.30.1716239368995;
        Mon, 20 May 2024 14:09:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee92bcsm434819935e9.36.2024.05.20.14.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 14:09:28 -0700 (PDT)
Message-Id: <pull.1722.git.git.1716239367046.gitgitgadget@gmail.com>
From: "Boris Mbarga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 May 2024 21:09:26 +0000
Subject: [PATCH] http: display the response body on POST failure
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Boris Mbarga <elhmn42@gmail.com>,
    elhmn <elhmn@github.com>

From: elhmn <elhmn@github.com>

When Git sends a GET request and receives an HTTP code indicating
failure (and that failure does not indicate an authentication problem),
it shows the body of the response, i.e. the error message.
The same is not true for POST requests. However, it would be good to show
those error messages e.g. in the case of "429 Too many requests", because
the user might otherwise be left puzzled about the reason why their clone
did not work.

This patch aligns the way POST requests are handled with the GET request
handling.

Signed-off-by: elhmn <elhmn@github.com>
---
    http: display response body on POST failure

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1722%2Felhmn%2Fdisplay-rpc-post-err-message-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1722/elhmn/display-rpc-post-err-message-v1
Pull-Request: https://github.com/git/git/pull/1722

 http.c                               |  1 +
 http.h                               |  1 +
 remote-curl.c                        | 11 ++++++++++-
 t/lib-httpd.sh                       |  1 +
 t/lib-httpd/apache.conf              |  8 ++++++++
 t/lib-httpd/wrap-git-http-backend.sh |  7 +++++++
 t/t5551-http-fetch-smart.sh          |  5 +++++
 7 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100755 t/lib-httpd/wrap-git-http-backend.sh

diff --git a/http.c b/http.c
index 3d80bd6116e..2017e909054 100644
--- a/http.c
+++ b/http.c
@@ -1419,6 +1419,7 @@ struct active_request_slot *get_active_slot(void)
 		newslot->curl = NULL;
 		newslot->in_use = 0;
 		newslot->next = NULL;
+		newslot->errstr = NULL;
 
 		slot = active_queue_head;
 		if (!slot) {
diff --git a/http.h b/http.h
index 3af19a8bf53..cb542c62933 100644
--- a/http.h
+++ b/http.h
@@ -30,6 +30,7 @@ struct active_request_slot {
 	void *callback_data;
 	void (*callback_func)(void *data);
 	struct active_request_slot *next;
+	struct strbuf *errstr;
 };
 
 struct buffer {
diff --git a/remote-curl.c b/remote-curl.c
index 0b6d7815fdd..9b2a41b2451 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -804,8 +804,11 @@ static size_t rpc_in(char *ptr, size_t eltsize,
 	if (curl_easy_getinfo(data->slot->curl, CURLINFO_RESPONSE_CODE,
 			      &response_code) != CURLE_OK)
 		return size;
-	if (response_code >= 300)
+	if (response_code >= 300) {
+		strbuf_reset(data->slot->errstr);
+		strbuf_add(data->slot->errstr, ptr, size);
 		return size;
+	}
 	if (size)
 		data->rpc->any_written = 1;
 	if (data->check_pktline)
@@ -837,6 +840,8 @@ static int run_slot(struct active_request_slot *slot,
 				strbuf_addch(&msg, ' ');
 				strbuf_addstr(&msg, curl_errorstr);
 			}
+			if (slot->errstr && slot->errstr->len)
+				error(_("%s"), slot->errstr->buf);
 		}
 		error(_("RPC failed; %s"), msg.buf);
 		strbuf_release(&msg);
@@ -896,6 +901,7 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 	int err, large_request = 0;
 	int needs_100_continue = 0;
 	struct rpc_in_data rpc_in_data;
+	struct strbuf errstr = STRBUF_INIT;
 
 	/* Try to load the entire request, if we can fit it into the
 	 * allocated buffer space we can use HTTP/1.0 and avoid the
@@ -1030,6 +1036,7 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
+	slot->errstr = &errstr;
 	rpc_in_data.rpc = rpc;
 	rpc_in_data.slot = slot;
 	rpc_in_data.check_pktline = stateless_connect;
@@ -1040,6 +1047,7 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 
 	rpc->any_written = 0;
 	err = run_slot(slot, NULL);
+	slot->errstr = NULL;
 	if (err == HTTP_REAUTH && !large_request) {
 		credential_fill(&http_auth);
 		goto retry;
@@ -1060,6 +1068,7 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 
 	curl_slist_free_all(headers);
 	free(gzip_body);
+	strbuf_release(&errstr);
 	return err;
 }
 
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index d83bafeab32..8f5b6357176 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -164,6 +164,7 @@ prepare_httpd() {
 	install_script error-no-report.sh
 	install_script broken-smart-http.sh
 	install_script error-smart-http.sh
+	install_script wrap-git-http-backend.sh
 	install_script error.sh
 	install_script apply-one-time-perl.sh
 	install_script nph-custom-auth.sh
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 022276a6b9a..0ca58f54d72 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -108,6 +108,10 @@ SetEnv PERL_PATH ${PERL_PATH}
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
+<LocationMatch /smart_fail_on_post_with_body/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+</LocationMatch>
 <LocationMatch /smart_noexport/>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 </LocationMatch>
@@ -155,6 +159,7 @@ ScriptAlias /smart/incomplete_length/git-upload-pack incomplete-length-upload-pa
 ScriptAlias /smart/incomplete_body/git-upload-pack incomplete-body-upload-pack-v2-http.sh/
 ScriptAlias /smart/no_report/git-receive-pack error-no-report.sh/
 ScriptAliasMatch /error_git_upload_pack/(.*)/git-upload-pack error.sh/
+ScriptAliasMatch /smart_fail_on_post_with_body/(.*) wrap-git-http-backend.sh/$1
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
 ScriptAlias /error_smart/ error-smart-http.sh/
@@ -182,6 +187,9 @@ ScriptAliasMatch /custom_auth/(.*) nph-custom-auth.sh/$1
 <Files error.sh>
   Options ExecCGI
 </Files>
+<Files wrap-git-http-backend.sh>
+  Options ExecCGI
+</Files>
 <Files apply-one-time-perl.sh>
 	Options ExecCGI
 </Files>
diff --git a/t/lib-httpd/wrap-git-http-backend.sh b/t/lib-httpd/wrap-git-http-backend.sh
new file mode 100755
index 00000000000..d1fc540330e
--- /dev/null
+++ b/t/lib-httpd/wrap-git-http-backend.sh
@@ -0,0 +1,7 @@
+if [ "$REQUEST_METHOD" = "GET" ]; then
+	"$GIT_EXEC_PATH"/git-http-backend "$@"
+elif [ "$REQUEST_METHOD" = "POST" ]; then
+	printf "Status: 429 Too Many Requests\n"
+	echo
+	printf "Too many requests"
+fi
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index a623a1058cd..badf37b4d68 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -302,6 +302,11 @@ test_expect_success 'dumb clone via http-backend respects namespace' '
 	test_cmp expect actual
 '
 
+test_expect_success 'smart http should display an error message on POST request failure' '
+	test_must_fail git clone --single-branch $HTTPD_URL/smart_fail_on_post_with_body/repo.git 2>actual &&
+	grep -q "error: Too many requests" actual
+'
+
 test_expect_success 'cookies stored in http.cookiefile when http.savecookies set' '
 	cat >cookies.txt <<-\EOF &&
 	127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue

base-commit: 786a3e4b8d754d2b14b1208b98eeb0a554ef19a8
-- 
gitgitgadget
