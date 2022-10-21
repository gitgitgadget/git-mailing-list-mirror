Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B16C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 17:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiJURIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 13:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiJURIc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 13:08:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA8528E062
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:08:16 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b4so6028277wrs.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCpc+ltT3AIh4jG8dPe0QF3HCFsDuta84IrLFJ6YXPU=;
        b=YTRdFIOW3Pbc714R22LUbfeX63b7S+GXOmKBa/4dUR/pplFmNqCHVdgIkAP4R5wXBY
         D5321Z8rOUS3BpVDCAwmYX00Aj06StUgBLke7FhYGg0WeFeuYrTkpWb6OvriVD6EcKI/
         6OozyBP/xU1PryQQVxij9n/nzKf4afwMRCVH2cmOWLQTRlpl/oYHwc7ogpXrmZuIa/Dn
         kx4TulOEb74dID3IKDtRzRVi52wWRSs9KTANlYiEI461vmYfs9m8JvJfeEOZ8i3bRpLY
         VuW8Cy0gMYw1Fmd448gey9qIBWIjRG6YTbMW+iIyAwnPzNa8SxEfKZ/bk3BKynyzseoA
         +kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCpc+ltT3AIh4jG8dPe0QF3HCFsDuta84IrLFJ6YXPU=;
        b=7VivNpPxcRGBCsEINbG+spk0VFqMFHeX4DsSl5LDnLfCQaBbqmh3SSIInZQO70WuGD
         o5THIn+PRqTrqXOM0A8X+DYN4+FgyCRtsiY+PHqvaAS3tHfybevMMfkTQgQW3Wp9/tct
         UKkWefTbDo0CWRmX+Ui4qqSI1ui8sYtXElZc4CYQRv6k64vIA+fFFP+sz3igxkLj+dt4
         bkd+KbMnn02wDY6L8uMcGjfziZrkH/qmecTCwuRr7eWLW9p1RQV4Xn9ed4cE0qWxnGqY
         ba2pCAB3vS9D0slN4Qkm1oV1CR4EeykNAZ04k9Wh1noPDUmRi6h+/Y9bkt8RQHHdbfel
         HSew==
X-Gm-Message-State: ACrzQf0+UUCh74cx4O1u2Pi/8hgQLYUEJME5VxbqCvmN11L96pVAVf/I
        JljssrNRaXNuN6NEqHH43vfsy1GVpt8=
X-Google-Smtp-Source: AMsMyM6xBcGy3ipS8/SvQLokzrfuzI56ReDGnzbJTtBirgKud4chWByrKJvtq6nNFiO0UyjLYjN4TA==
X-Received: by 2002:adf:edc3:0:b0:22c:dbe9:e3b6 with SMTP id v3-20020adfedc3000000b0022cdbe9e3b6mr12853865wro.282.1666372094855;
        Fri, 21 Oct 2022 10:08:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b003b3365b38f9sm3716517wmg.10.2022.10.21.10.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 10:08:13 -0700 (PDT)
Message-Id: <b0b7cd7ee5e4914dba99ac93cc4800f25df9cb9a.1666372083.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
        <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 17:08:02 +0000
Subject: [PATCH v2 5/6] http: set specific auth scheme depending on credential
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Introduce a new credential field `authtype` that can be used by
credential helpers to indicate the type of the credential or
authentication mechanism to use for a request.

Modify http.c to now specify the correct authentication scheme or
credential type when authenticating the curl handle. If the new
`authtype` field in the credential structure is `NULL` or "Basic" then
use the existing username/password options. If the field is "Bearer"
then use the OAuth bearer token curl option. Otherwise, the `authtype`
field is the authentication scheme and the `password` field is the
raw, unencoded value.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 Documentation/git-credential.txt |  9 +++++++++
 credential.c                     |  5 +++++
 credential.h                     |  1 +
 git-curl-compat.h                | 10 ++++++++++
 http.c                           | 24 +++++++++++++++++++++---
 5 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 0ff3cbc25b9..82ade09b5e9 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -169,6 +169,15 @@ username in the example above) will be left unset.
 	attribute 'wwwauth[]' where the order of the attributes is the same
 	as they appear in the HTTP response.
 
+`authtype`::
+
+	Indicates the type of authentication scheme used. If this is not
+	present the default is "Basic".
+	Known values include "Basic", "Digest", and "Bearer".
+	If an unknown value is provided, this is taken as the authentication
+	scheme for the `Authorization` header, and the `password` field is
+	used as the raw unencoded authorization parameters of the same header.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/credential.c b/credential.c
index 8a3ad6c0ae2..a556f9f375a 100644
--- a/credential.c
+++ b/credential.c
@@ -21,6 +21,7 @@ void credential_clear(struct credential *c)
 	free(c->path);
 	free(c->username);
 	free(c->password);
+	free(c->authtype);
 	string_list_clear(&c->helpers, 0);
 	strvec_clear(&c->wwwauth_headers);
 
@@ -235,6 +236,9 @@ int credential_read(struct credential *c, FILE *fp)
 		} else if (!strcmp(key, "path")) {
 			free(c->path);
 			c->path = xstrdup(value);
+		} else if (!strcmp(key, "authtype")) {
+			free(c->authtype);
+			c->authtype = xstrdup(value);
 		} else if (!strcmp(key, "url")) {
 			credential_from_url(c, value);
 		} else if (!strcmp(key, "quit")) {
@@ -281,6 +285,7 @@ void credential_write(const struct credential *c, FILE *fp)
 	credential_write_item(fp, "path", c->path, 0);
 	credential_write_item(fp, "username", c->username, 0);
 	credential_write_item(fp, "password", c->password, 0);
+	credential_write_item(fp, "authtype", c->authtype, 0);
 	credential_write_strvec(fp, "wwwauth", &c->wwwauth_headers);
 }
 
diff --git a/credential.h b/credential.h
index 6f2e5bc610b..8d580b054d0 100644
--- a/credential.h
+++ b/credential.h
@@ -140,6 +140,7 @@ struct credential {
 	char *protocol;
 	char *host;
 	char *path;
+	char *authtype;
 };
 
 #define CREDENTIAL_INIT { \
diff --git a/git-curl-compat.h b/git-curl-compat.h
index 56a83b6bbd8..839049f6dfe 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -126,4 +126,14 @@
 #define GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS
 #endif
 
+/**
+ * CURLAUTH_BEARER was added in 7.61.0, released in July 2018.
+ * However, only 7.69.0 fixes a bug where Bearer headers were not
+ * actually sent with reused connections on subsequent transfers
+ * (curl/curl@dea17b519dc1).
+ */
+#if LIBCURL_VERSION_NUM >= 0x074500
+#define GIT_CURL_HAVE_CURLAUTH_BEARER
+#endif
+
 #endif
diff --git a/http.c b/http.c
index 17b47195d22..ac620bcbf0c 100644
--- a/http.c
+++ b/http.c
@@ -517,7 +517,8 @@ static int curl_empty_auth_enabled(void)
 
 static void init_curl_http_auth(struct active_request_slot *slot)
 {
-	if (!http_auth.username || !*http_auth.username) {
+	if (!http_auth.authtype &&
+		(!http_auth.username || !*http_auth.username)) {
 		if (curl_empty_auth_enabled())
 			curl_easy_setopt(slot->curl, CURLOPT_USERPWD, ":");
 		return;
@@ -525,8 +526,25 @@ static void init_curl_http_auth(struct active_request_slot *slot)
 
 	credential_fill(&http_auth);
 
-	curl_easy_setopt(slot->curl, CURLOPT_USERNAME, http_auth.username);
-	curl_easy_setopt(slot->curl, CURLOPT_PASSWORD, http_auth.password);
+	if (!http_auth.authtype || !strcasecmp(http_auth.authtype, "basic")
+				|| !strcasecmp(http_auth.authtype, "digest")) {
+		curl_easy_setopt(slot->curl, CURLOPT_USERNAME,
+			http_auth.username);
+		curl_easy_setopt(slot->curl, CURLOPT_PASSWORD,
+			http_auth.password);
+#ifdef GIT_CURL_HAVE_CURLAUTH_BEARER
+	} else if (!strcasecmp(http_auth.authtype, "bearer")) {
+		curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, CURLAUTH_BEARER);
+		curl_easy_setopt(slot->curl, CURLOPT_XOAUTH2_BEARER,
+			http_auth.password);
+#endif
+	} else {
+		struct strbuf auth = STRBUF_INIT;
+		strbuf_addf(&auth, "Authorization: %s %s",
+			http_auth.authtype, http_auth.password);
+		slot->headers = curl_slist_append(slot->headers, auth.buf);
+		strbuf_release(&auth);
+	}
 }
 
 /* *var must be free-able */
-- 
gitgitgadget

