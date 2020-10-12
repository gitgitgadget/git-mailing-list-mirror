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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ED3C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B0742074F
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSaLC2mj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgJLUTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgJLUTp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 16:19:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CA6C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 13:19:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z27so8770999ybi.17
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 13:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Yq++ifELKNRO+08aBDj8AWCZPxxU3xuDTfXIdEnlfPI=;
        b=dSaLC2mjIzhSvVIgI38ii7JFodWjZo8snUHkmBDNeRzYvNkl8dBPp0thWFPLSxZYdH
         qAeMbOr/ONjcqEH9WVBE5/6FBmRa8h3qbKy5dHxEdOvBJZoNYFpkxzbbkVxcMPiMUWK4
         2iNlO1pRxyQExcGSaJA3bQetTyLbvzzTfRaFC665EQT7PqFK1mbhEd5dnOJgTl6XDaed
         IAnATRZaUv6gz8LhiXwodEA8KEjFDb36eKmHl/HHNHUJ4XdeV48HoXeh4pWsn0kR48/n
         LvZQvvk7ueAfVIa6Alt6h8TYi6fd9UZ4Nl9qY18DAIcFd4zas5YbfrWrU5g0LnHAeOIU
         15bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Yq++ifELKNRO+08aBDj8AWCZPxxU3xuDTfXIdEnlfPI=;
        b=MRp5J4Z/6Ve2FQwfIN0A8D6NWkNydNBHktVE7bnIcS1N09FpwEM+W0JHsEjFXWGqom
         Jzzmt8phL+JMmPTp/dDo6EINRVDB1BhT6Im0FriP8GvpNTWuDqV+qjj+9FI72948heqf
         sIGP9gdehXlVzsEplJ54FeX9b1GUuA5mof2dMPhocQ8DOPJNoU894x+SCL0QF8oAjL/2
         zd8mCYY6+/DoBu1Cpu3hPKFZjTZ/aoWO3Sudn9dSlN09DOg/PwRN1ZdfGmgPm269J6mZ
         qg5nSr+pMinO5fa3eVSPFgO02cnCYnxVIBplkFraVVITaniKul0bVbGz4v44UEsg/z19
         cRLg==
X-Gm-Message-State: AOAM530ZTVyfjOo7Tb+VtqIjlHj+GYN2rBHH9gvWEEg3/2vUBuukEUSI
        cKC2ad7+QFAYuKXN6i76PniM4+MJeo1DYD0BrkMv7uw9i96KXwHaDBI2YLFMjg0U+clm/BSdRfK
        NBsOv81eHX8tErKw9DOWIMri+epNFRjqH8PZvwUwXmXrDWbsyW8/8B8xIm2yKp2U=
X-Google-Smtp-Source: ABdhPJwizaoEQCtgfkxsq3Calp62jFIgDP6VCKHjvdwNCuxDWm/GKDlZ82AiGKyJY24nH02n01U8dm6D/hbzEw==
Sender: "smcallis via sendgmr" <smcallis@smcallis.bld.corp.google.com>
X-Received: from smcallis.bld.corp.google.com ([2620:15c:183:200:a6ae:11ff:fe11:fc5d])
 (user=smcallis job=sendgmr) by 2002:a25:cf84:: with SMTP id
 f126mr34698536ybg.148.1602533983165; Mon, 12 Oct 2020 13:19:43 -0700 (PDT)
Date:   Mon, 12 Oct 2020 14:19:40 -0600
In-Reply-To: <20201012184806.166251-1-smcallis@google.com>
Message-Id: <20201012201940.229694-1-smcallis@google.com>
Mime-Version: 1.0
References: <20201012184806.166251-1-smcallis@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH] remote-curl: add testing for intelligent retry for HTTP
From:   Sean McAllister <smcallis@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        masayasuzuki@google.com
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
 t/lib-httpd.sh             |  6 +++
 t/lib-httpd/apache.conf    |  9 +++++
 t/lib-httpd/error-ntime.sh | 79 ++++++++++++++++++++++++++++++++++++++
 t/t5601-clone.sh           |  9 +++++
 4 files changed, 103 insertions(+)
 create mode 100755 t/lib-httpd/error-ntime.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index d2edfa4c50..da1d4adfb4 100644
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
@@ -308,3 +309,8 @@ check_access_log() {
 		test_cmp "$1" access.log.stripped
 	fi
 }
+
+# generate a random 12 digit string
+gen_nonce() {
+    test_copy_bytes 12 < /dev/urandom | tr -dc A-Za-z0-9
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
index 0000000000..e4f91ab816
--- /dev/null
+++ b/t/lib-httpd/error-ntime.sh
@@ -0,0 +1,79 @@
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
+      if [ "$1" -eq "302" ]; then printf "Status: 302 Found\n"
+    elif [ "$1" -eq "429" ]; then printf "Status: 429 Too Many Requests\n"
+    elif [ "$1" -eq "502" ]; then printf "Status: 502 Bad Gateway\n"
+    elif [ "$1" -eq "503" ]; then printf "Status: 503 Service Unavailable\n"
+    elif [ "$1" -eq "504" ]; then printf "Status: 504 Gateway Timeout\n"
+    else
+        printf "Status: 500 Internal Server Error\n"
+    fi
+    printf "Content-Type: text/plain\n"
+}
+
+# read in path split into cmoponents
+IFS='/'
+tokens=($PATH_INFO)
+
+# break out code/retry parts of path
+nonce=${tokens[1]}
+times=${tokens[2]}
+code=${tokens[3]}
+retry=${tokens[4]}
+
+# get redirect path
+cnt=0
+path=""
+for ((ii=0; ii < ${#PATH_INFO}; ii++)); do
+    if [ "${PATH_INFO:${ii}:1}" == "/" ]; then
+        let cnt=${cnt}+1
+    fi
+    if [ "${cnt}" -eq 5 ]; then
+        path="${PATH_INFO:${ii}}"
+        break
+    fi
+done
+
+# leave a cookie for this request/retry count
+state_file="request_${REMOTE_ADDR}_${nonce}_${times}_${code}_${retry}"
+
+if [ ! -f "$state_file" ]; then
+    echo 0 > "$state_file"
+fi
+
+
+read cnt < "$state_file"
+if [ "$cnt" -lt "$times" ]; then
+    let cnt=cnt+1
+    echo "$cnt" > "$state_file"
+
+    # return error
+    print_status "$code"
+    if [ "$retry" -ge "0" ]; then
+        printf "Retry-After: %s\n" "$retry"
+    fi
+else
+    # redirect
+    print_status 302
+    printf "Location: %s?%s\n" "$path" "${QUERY_STRING}"
+fi
+
+echo
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 7df3c5373a..71d4307001 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -756,6 +756,15 @@ test_expect_success 'partial clone using HTTP' '
 	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
 '
 
+test_expect_success 'partial clone using HTTP with redirect' '
+    _NONCE=`gen_nonce` && export _NONCE &&
+    curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" > /dev/null &&
+    curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" > /dev/null &&
+    curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" > /dev/null &&
+	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server"
+'
+
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
-- 
2.28.0.1011.ga647a8990f-goog

