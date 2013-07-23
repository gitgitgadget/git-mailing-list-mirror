From: dborowitz@google.com
Subject: [PATCH] http: Add http.savecookies option to write out HTTP cookies
Date: Tue, 23 Jul 2013 15:40:17 -0700
Message-ID: <1374619217-26462-1-git-send-email-dborowitz@google.com>
References: <1374613676-20889-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 24 00:41:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1lGm-0006Pf-Ri
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 00:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934835Ab3GWWlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 18:41:09 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:64891 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934355Ab3GWWlG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 18:41:06 -0400
Received: by mail-pd0-f180.google.com with SMTP id 10so8555503pdi.39
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 15:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CisoVPIYZ1G2MK+b6jdFNTfSOgCXmdgEs0XPfRB32uU=;
        b=JkvtP0mDDEDXKyUTizu4xbhRTp2/ZMF3bOVJqdyc1IW0vkgFHqyyapwiqHyOKlFP5L
         f23WFzoNglQzPQAq8ro2yJgoVRU6OISqeNpNwSm6GQhi26WSOHP6p5LYpFDtOY18j2J2
         JRj33waEWb6ftp4kg0ofg4IN1mCwtU54K4i9QLXoIYGMIiv7LskOYRuTjhAQuVFmkqqt
         KXrCg+iM+2AswTLSc3xy6WH27PM7TB3sykSXQGMxhkAKEQFxV7RWHz2HEKgeZAQ+IHom
         5sZeLJv41LgLzxQEPdm9+9OjT5dqXkuxgW+58nAZb5pGF5RQV51p8L7TPFXB3Ozzl+Ea
         2CRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=CisoVPIYZ1G2MK+b6jdFNTfSOgCXmdgEs0XPfRB32uU=;
        b=hVZKj8PU8sm1id5n5iokwMlH+1BoXuaVAWWYv9ZcsJ07QYrIL2K5wmISwfFW9kQSzm
         H3jAQ8p90j+on+gQpOuHnFEG7rsYOw6Gmvci9G0ooZW5KyXoQzfTZPKTsBuv8vgUOC0M
         fh8/AY/NQQCikoYDUBtl3a+jd0R9LA7RQ4N+Ek4gXU2b3iCduNsqSFrklculbGSyOYSY
         STRFYO79QIKbXxYBddCZbkeWZ5T0yKwKA0IAtczQogh01sQAUFMGOFsYe6bmGyVt4vOo
         azV1U8nGL38M8a/9kFHZuFAel8uPBMzWe6mFlfR6Dh1j32bR1iJPf5W8jNFYsc2pUdKh
         EATg==
X-Received: by 10.66.155.163 with SMTP id vx3mr39782549pab.67.1374619265685;
        Tue, 23 Jul 2013 15:41:05 -0700 (PDT)
Received: from serval.mtv.corp.google.com (serval.mtv.corp.google.com [172.27.69.27])
        by mx.google.com with ESMTPSA id dc5sm43880340pbc.37.2013.07.23.15.41.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 15:41:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1374613676-20889-1-git-send-email-dborowitz@google.com>
X-Gm-Message-State: ALoCoQkj9QWrvt7/lP7JcgKtJKidKXigONLX2Y0t5Li1fpsny/I6TrCkedgwITjO6yKvDdASP8dHVHzKtMnUTYd9n1MkscgTyOFPa7Diu/MX9XMNFLUvUfseV1hfcoOtNEBZor3aCGxwqv9m73FDz4QlKpun1KGVwHzUdodSOkmMaDJfMAyPndfrl4BAvh48ajmhM3LfEV7lKsM0CfWq5EA2V5PSJjx4UNJHV/L2jFhDYSJHjFrI0fQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231068>

From: Dave Borowitz <dborowitz@google.com>

HTTP servers may send Set-Cookie headers in a response and expect them
to be set on subsequent requests. By default, libcurl behavior is to
store such cookies in memory and reuse them across requests within a
single session. However, it may also make sense, depending on the
server and the cookies, to store them across sessions. Provide users
an option to enable this behavior, writing cookies out to the same
file specified in http.cookiefile.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/config.txt |  6 +++++-
 http.c                   |  7 +++++++
 t/lib-httpd/apache.conf  |  8 ++++++++
 t/t5551-http-fetch.sh    | 18 ++++++++++++++++++
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e0b923f..e935447 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1456,7 +1456,11 @@ http.cookiefile::
 	of the file to read cookies from should be plain HTTP headers or
 	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
 	NOTE that the file specified with http.cookiefile is only used as
-	input. No cookies will be stored in the file.
+	input unless http.saveCookies is set.
+
+http.savecookies::
+	If set, store cookies received during requests to the file specified by
+	http.cookiefile. Has no effect if http.cookiefile is unset.
 
 http.sslVerify::
 	Whether to verify the SSL certificate when fetching or pushing
diff --git a/http.c b/http.c
index 2d086ae..2fbf986 100644
--- a/http.c
+++ b/http.c
@@ -45,6 +45,7 @@ static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static const char *curl_cookie_file;
+static int curl_save_cookies;
 static struct credential http_auth = CREDENTIAL_INIT;
 static int http_proactive_auth;
 static const char *user_agent;
@@ -200,6 +201,10 @@ static int http_options(const char *var, const char *value, void *cb)
 
 	if (!strcmp("http.cookiefile", var))
 		return git_config_string(&curl_cookie_file, var, value);
+	if (!strcmp("http.savecookies", var)) {
+		curl_save_cookies = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (!strcmp("http.postbuffer", var)) {
 		http_post_buffer = git_config_int(var, value);
@@ -513,6 +518,8 @@ struct active_request_slot *get_active_slot(void)
 	slot->callback_data = NULL;
 	slot->callback_func = NULL;
 	curl_easy_setopt(slot->curl, CURLOPT_COOKIEFILE, curl_cookie_file);
+	if (curl_save_cookies)
+		curl_easy_setopt(slot->curl, CURLOPT_COOKIEJAR, curl_cookie_file);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, NULL);
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index dd17e3a..397c480 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -22,6 +22,9 @@ ErrorLog error.log
 <IfModule !mod_version.c>
 	LoadModule version_module modules/mod_version.so
 </IfModule>
+<IfModule !mod_headers.c>
+	LoadModule headers_module modules/mod_headers.so
+</IfModule>
 
 <IfVersion < 2.4>
 LockFile accept.lock
@@ -87,6 +90,11 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_HTTP_EXPORT_ALL
 	SetEnv GIT_NAMESPACE ns
 </LocationMatch>
+<LocationMatch /smart_cookies/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+	Header set Set-Cookie name=value
+</LocationMatch>
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
 <Directory ${GIT_EXEC_PATH}>
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 55a866a..287d22b 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -187,6 +187,24 @@ test_expect_success 'dumb clone via http-backend respects namespace' '
 	test_cmp expect actual
 '
 
+cat >cookies.txt <<EOF
+127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
+EOF
+cat >expect_cookies.txt <<EOF
+# Netscape HTTP Cookie File
+# http://curl.haxx.se/docs/http-cookies.html
+# This file was generated by libcurl! Edit at your own risk.
+
+127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
+127.0.0.1	FALSE	/smart_cookies/repo.git/info/	FALSE	0	name	value
+EOF
+test_expect_success 'cookies stored in http.cookiefile when http.savecookies set' '
+	git config http.cookiefile cookies.txt &&
+	git config http.savecookies true &&
+	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
+	test_cmp expect_cookies.txt cookies.txt
+'
+
 test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
 
 test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
-- 
1.8.3.2
