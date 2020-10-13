Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42F8C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDCD20BED
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g2N+OcbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgJMTRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 15:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgJMTRn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 15:17:43 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BFCC0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 12:17:42 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id n8so575517qtf.10
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 12:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=jFIi5d8yHMioX6n/Y9ckXIX4A9pL0FgLjpnWEhbf7nY=;
        b=g2N+OcbKqVHnZP7lfMykYK55USdGjg+xku6DR88UvFGMwA9XeBX7lgnCbljYnnw5Ou
         rVWEBE6npO7kmczZ8M6nq9oiVOS/5xFvL3gteQRU7TPzPW5pn0ltO7r3cvhDTQIRpbhn
         GbK4ktRF0G/RKsklSsEZntJdQRJPgqd6NsG9wuJvWlVgPQPsMfqrF6t9RfrULGAEqCpz
         VfdwkvaX1Ygo15Rg5niLlGUHVDQZQ5ihdrG2mmyqOYUeGsZnZQiTy3qos7ybv99GQEQ9
         YTdlSAw9i2WtOmefHk/t52Y0+yt7oulIgyliYEhFRIHWHjH9I7MtcTnTattNyg23YOOu
         esvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=jFIi5d8yHMioX6n/Y9ckXIX4A9pL0FgLjpnWEhbf7nY=;
        b=PpLWwSxhHjx2pItKBAN40NP+uvnGyKfL/AjpgkvNNxoeX8EQpSopAb+PUfwaSXJeUs
         s01q8CRkl2dA9TcDjLtVetkJkwXTouM6YlPLDprbb0V8+88+GI9oBZ5UuI5TAu3BmhEY
         p8uSoWaDfWel/x5T8Ysn88tabakvuw4Lnm8GgT1bKQ/R1sz31graa/YfyKkbSY8eRKJB
         dz9o8afcjiYz50N7tnp+622s2vMswPIwjR8fvuVmJPqPJ7/xjQoWvsebap6EL3ZssHwI
         lLupGsr22ynah68TjJGaTwgfJMB9ydOMZmKiLMQlbseQSWT0rC2XhPOlD9mUKzdLaNG8
         ZBXg==
X-Gm-Message-State: AOAM533JONGu0ZE1CMdgaKINjAFjDvyZgw/y38BnyWW67hWn8wyiNIJs
        qhQHB06qLiMM2VyMa45QSy58O7HOKOrir+AdfokPFSgRZlfKjO3AzD+6dayj0Eqgw5ZS3CGLizZ
        jlkdjIxQuO8iFB2TokXoJZvlY8IaRcz2ve62ZSYEHMT4RsXiMy8UJe7cZ22Le3xE=
X-Google-Smtp-Source: ABdhPJybYrqLmzRXTCBKy/lpKn2/k6IOJ9SRkIc5VyTvY51gcsBq1yck4/nJBlX0J6mIfc073t4Y0MZPyIjDbg==
Sender: "smcallis via sendgmr" <smcallis@smcallis.bld.corp.google.com>
X-Received: from smcallis.bld.corp.google.com ([2620:15c:183:200:a6ae:11ff:fe11:fc5d])
 (user=smcallis job=sendgmr) by 2002:a05:6214:180d:: with SMTP id
 o13mr1458278qvw.34.1602616661782; Tue, 13 Oct 2020 12:17:41 -0700 (PDT)
Date:   Tue, 13 Oct 2020 13:17:27 -0600
Message-Id: <20201013191729.2524700-1-smcallis@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v2 1/3] remote-curl: add testing for intelligent retry for HTTP
From:   Sean McAllister <smcallis@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        masayasuzuki@google.com, jrnieder@gmail.com
Cc:     Sean McAllister <smcallis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HTTP servers can sometimes throw errors, but that doesn't mean we should
give up.  If we have an error condition that we can reasonably retry on,
then we should.

This change is tricky because it requires a new CGI script to test as we
need to be able to instruct the server to throw an error(s) before
succeeding.  We do this by encoding an error code and optional value for
Retry-After into the URL, followed by the real endpoint:

  /error_ntime/dc724af1/<N>/429/10/smart/server

This is a bit hacky, but really the best we can do since HTTP is
fundamentally stateless.  The URL is uniquefied by a nonce and we leave
a breadcrumb on disk so all accesses after the first <N> redirect to the
appropriate endpoint.

Signed-off-by: Sean McAllister <smcallis@google.com>
---
 t/lib-httpd.sh             |  8 ++++
 t/lib-httpd/apache.conf    |  9 +++++
 t/lib-httpd/error-ntime.sh | 80 ++++++++++++++++++++++++++++++++++++++
 t/t5601-clone.sh           |  9 +++++
 4 files changed, 106 insertions(+)
 create mode 100755 t/lib-httpd/error-ntime.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index d2edfa4c50..edc10b6f4b 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -132,6 +132,7 @@ prepare_httpd() {
 	install_script incomplete-length-upload-pack-v2-http.sh
 	install_script incomplete-body-upload-pack-v2-http.sh
 	install_script broken-smart-http.sh
+	install_script error-ntime.sh
 	install_script error-smart-http.sh
 	install_script error.sh
 	install_script apply-one-time-perl.sh
@@ -308,3 +309,10 @@ check_access_log() {
 		test_cmp "$1" access.log.stripped
 	fi
 }
+
+# generate a process unique one-up value
+global_counter_for_nonce=0
+gen_nonce () {
+	global_counter_for_nonce=$((global_counter_for_nonce + 1)) &&
+	echo "$global_counter_for_nonce"
+}
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index afa91e38b0..77c495e164 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -117,6 +117,12 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
+
+# This may be suffixed with any path for redirection, so it should come before
+# any of the other aliases, particularly the /smart_*[^/]*/(.*) alias as that can
+# match a lot of URLs
+ScriptAlias /error_ntime/ error-ntime.sh/
+
 ScriptAlias /smart/incomplete_length/git-upload-pack incomplete-length-upload-pack-v2-http.sh/
 ScriptAlias /smart/incomplete_body/git-upload-pack incomplete-body-upload-pack-v2-http.sh/
 ScriptAliasMatch /error_git_upload_pack/(.*)/git-upload-pack error.sh/
@@ -137,6 +143,9 @@ ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
 <Files broken-smart-http.sh>
 	Options ExecCGI
 </Files>
+<Files error-ntime.sh>
+	Options ExecCGI
+</Files>
 <Files error-smart-http.sh>
 	Options ExecCGI
 </Files>
diff --git a/t/lib-httpd/error-ntime.sh b/t/lib-httpd/error-ntime.sh
new file mode 100755
index 0000000000..64dc878746
--- /dev/null
+++ b/t/lib-httpd/error-ntime.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+
+# Script to simulate a transient error code with Retry-After header set.
+#
+# PATH_INFO must be of the form /<nonce>/<times>/<retcode>/<retry-after>/<path>
+#   (eg: /dc724af1/3/429/10/some/url)
+#
+# The <nonce> value uniquely identifies the URL, since we're simulating
+# a stateful operation using a stateless protocol, we need a way to "namespace"
+# URLs so that they don't step on each other.
+#
+# The first <times> times this endpoint is called, it will return the given
+# <retcode>, and if the <retry-after> is non-negative, it will set the
+# Retry-After head to that value.
+#
+# Subsequent calls will return a 302 redirect to <path>.
+#
+# Supported error codes are 429,502,503, and 504
+
+print_status() {
+	if [ "$1" -eq "302" ]; then
+		printf "Status: 302 Found\n"
+	elif [ "$1" -eq "429" ]; then
+		printf "Status: 429 Too Many Requests\n"
+	elif [ "$1" -eq "502" ]; then
+		printf "Status: 502 Bad Gateway\n"
+	elif [ "$1" -eq "503" ]; then
+		printf "Status: 503 Service Unavailable\n"
+	elif [ "$1" -eq "504" ]; then
+		printf "Status: 504 Gateway Timeout\n"
+	else
+		printf "Status: 500 Internal Server Error\n"
+	fi
+	printf "Content-Type: text/plain\n"
+}
+
+# set $@ to components of PATH_INFO
+IFS='/'
+set -f
+set -- $PATH_INFO
+set +f
+
+# pull out first four path components
+shift
+nonce=$1
+times=$2
+code=$3
+retry=$4
+shift 4
+
+# glue the rest back together as redirect path
+path=""
+while [ "$#" -gt "0" ]; do
+	path="${path}/$1"
+	shift
+done
+
+# leave a cookie for this request/retry count
+state_file="request_${REMOTE_ADDR}_${nonce}_${times}_${code}_${retry}"
+
+if [ ! -f "$state_file" ]; then
+	echo 0 > "$state_file"
+fi
+
+read -r cnt < "$state_file"
+if [ "$cnt" -lt "$times" ]; then
+	echo $((cnt+1)) > "$state_file"
+
+	# return error
+	print_status "$code"
+	if [ "$retry" -ge "0" ]; then
+		printf "Retry-After: %s\n" "$retry"
+	fi
+else
+	# redirect
+	print_status 302
+	printf "Location: %s?%s\n" "$path" "${QUERY_STRING}"
+fi
+
+echo
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 7df3c5373a..72aaed5a93 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -756,6 +756,15 @@ test_expect_success 'partial clone using HTTP' '
 	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
 '
 
+test_expect_success 'partial clone using HTTP with redirect' '
+	_NONCE=`gen_nonce` && export _NONCE &&
+	curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&
+	curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&
+	curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&
+	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server"
+'
+
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
-- 
2.28.0.1011.ga647a8990f-goog

