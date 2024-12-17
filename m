Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD7F653
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417865; cv=none; b=IxpHez2h/MwIajgsJ5Tn7IZHvV2KwFBsm0UT+btxwGw8oDpgZPkp9dDBpFn+NRMsFND+I65ctSCxSbOg7RLTVv5kZQ4KMvFeRpqOzUVeQiPT7YAcWaFkNXR1WZER4wuw8PjTOEoi5i3Pvp/Z44ZJ1+qV41PAP+Bv9w3eCPEOqAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417865; c=relaxed/simple;
	bh=OegXg3gbpnEZg+3L5X/xeGhPxF+DMtKlv/oWycPVG0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iR8XEeUIReaDSPebeRpfAUSvNpHxqe1fI/hBDXrN9v2zst87nGb+Jy+C8jycjeeT3GIzVmLpjdisuDCBCd+sST00vYl9SpTdTLe7utKCOiC4BjIbZzDbf+9aIt3xLo3gwyB5x5HPmYN7FVTvcuecQKkeiEITxBEsuX+3E8Wkl1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AGZqH1zU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N0wAQY/B; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AGZqH1zU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N0wAQY/B"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9912E13801D7
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 17 Dec 2024 01:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734417862;
	 x=1734504262; bh=5IjOLXmTSjozsaZPV7zi+a+wKJfSzySqRZzmLArgnvM=; b=
	AGZqH1zUfym9+D/Ou5NLWR3aPk1OMG3LtjlFZjItC3Xr8+fzuUydjTzVsgzmilMI
	3yRJJpFALf6Lw246xGLIUvJ//if8o0KQ00RJkWwVahbvpoLh9h0Mx2ovihq4lOsQ
	M6waN9ZXVWB+jNKhu+qiqwma4mjGg1jIOskSjzM9okLRe+PYdp+b/lf0PkP5inUz
	emiHj5f0fCftH/6jGX91kjKN1dQKXduYOYYQFWOJ+YCretgROSVIWd3u4akHNsyd
	8ksXBtlpBz8dPp45O2BMBEnHQd1tyA2mLSe0t3V8ynWokq88hOXEpUIBDrwRUjM1
	TYt+TWyYOr9KQ3P12/tt0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734417862; x=
	1734504262; bh=5IjOLXmTSjozsaZPV7zi+a+wKJfSzySqRZzmLArgnvM=; b=N
	0wAQY/B6JZXmz+Gnt6HeEibq3vUlKFYeTRAPMjruMY3CCdoGh+OwY7Ata5OV0kW+
	/2oClJRmKtQa7Lw3jfjlDZSVzB2oCTdOn3yOeBUxnPXKSC6S5Gu804lRlKk8tyzK
	WM6I9k41wgkocaTd5ZD7e6c64dGovgKecv9uZL+fbWEGvJ3IMtKk3YgrPArc4T9W
	2Af/gAAHQfXNmRfBYPPFrKHWLt2xQYht/gKcUjLCu8utYAGjLQKq9Pzp38gIhiN7
	su4I2KbnAI9r+4VJzjMJlGTwi+uYQ9D4mjs6yFGeQ2I4jnQBufD9CU78mnY9qoxM
	c7PWW5o+biT3yhm4q6cMQ==
X-ME-Sender: <xms:xh1hZ2IAl8romaTHQ_J1UMEb1gGcBS0nkokA8O_OiVf_XwGizNrhtA>
    <xme:xh1hZ-JR8YrFaotvsfc95Xo86GYJgH5Cwyg9B6Wo_po11XH9WcuNfUHA6v0QoEPGt
    zVUMg3esTR4Slhmkw>
X-ME-Received: <xmr:xh1hZ2tBCWjPL7UMpw3IBoHm7wcIK8I0jge3rJSucHhCfXkBNWeClQUENeUg_NKA4QBMVTmBTsfK08CU5q7fg280NqmIpTgFB-hIrjaBDx-tCTE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xh1hZ7ZoPvpQDitEYc86fA8UrDpIY2_5qkU8eGlUbIFyQdMHghoFZg>
    <xmx:xh1hZ9bdsTaqf8H0d1Wbnbt2OuPD2FlM1juP9es6KqceXYAEHZ3EhQ>
    <xmx:xh1hZ3BUOK2SXmmQuHJJXPNDDnG-gh1g25ky2Kml3nA4UygLRp23Dw>
    <xmx:xh1hZzYltsYzDP0TpYjL334b_3gAaGEwr7yRQ8i8H7BPyYrJuqPNvA>
    <xmx:xh1hZ8yUuUzvR93NmHPKbM1jkEg48cKNyU8rKrdspnc34TKNlI4mW1kf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81799b09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Dec 2024 06:42:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Dec 2024 07:43:56 +0100
Subject: [PATCH 09/14] credential: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-pks-use-the-repository-conversion-v1-9-0dba48bcc239@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Stop using `the_repository` in the "credential" subsystem by passing in
a repository when filling, approving or rejecting credentials.

Adjust callers accordingly by using `the_repository`. While there may be
some callers that have a repository available in their context, this
trivial conversion allows for easier verification and bubbles up the use
of `the_repository` by one level.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/credential.c |  6 +++---
 credential.c         | 34 +++++++++++++++++-----------------
 credential.h         | 11 +++++++----
 http.c               | 24 ++++++++++++------------
 imap-send.c          | 10 +++++-----
 remote-curl.c        |  4 ++--
 6 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/builtin/credential.c b/builtin/credential.c
index 14c8c6608b2fbd7091a11c14537d08783d5c281d..614b195b753ed8d0c2495ff9b26672250bf4edcb 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -32,15 +32,15 @@ int cmd_credential(int argc,
 		die("unable to read credential from stdin");
 
 	if (!strcmp(op, "fill")) {
-		credential_fill(&c, 0);
+		credential_fill(the_repository, &c, 0);
 		credential_next_state(&c);
 		credential_write(&c, stdout, CREDENTIAL_OP_RESPONSE);
 	} else if (!strcmp(op, "approve")) {
 		credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
-		credential_approve(&c);
+		credential_approve(the_repository, &c);
 	} else if (!strcmp(op, "reject")) {
 		credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
-		credential_reject(&c);
+		credential_reject(the_repository, &c);
 	} else {
 		usage(usage_msg);
 	}
diff --git a/credential.c b/credential.c
index a995031c5f5d842f8e82d5e44e4f7a3e51a9e815..b3f87b5b2f16c547d7889c7c60327cd75f3c27d9 100644
--- a/credential.c
+++ b/credential.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -166,7 +165,7 @@ static int match_partial_url(const char *url, void *cb)
 	return matches;
 }
 
-static void credential_apply_config(struct credential *c)
+static void credential_apply_config(struct repository *r, struct credential *c)
 {
 	char *normalized_url;
 	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
@@ -191,7 +190,7 @@ static void credential_apply_config(struct credential *c)
 	credential_format(c, &url);
 	normalized_url = url_normalize(url.buf, &config.url);
 
-	git_config(urlmatch_config_entry, &config);
+	repo_config(r, urlmatch_config_entry, &config);
 	string_list_clear(&config.vars, 1);
 	free(normalized_url);
 	urlmatch_config_release(&config);
@@ -254,34 +253,34 @@ static char *credential_ask_one(const char *what, struct credential *c,
 	return xstrdup(r);
 }
 
-static int credential_getpass(struct credential *c)
+static int credential_getpass(struct repository *r, struct credential *c)
 {
 	int interactive;
 	char *value;
-	if (!git_config_get_maybe_bool("credential.interactive", &interactive) &&
+	if (!repo_config_get_maybe_bool(r, "credential.interactive", &interactive) &&
 	    !interactive) {
-		trace2_data_intmax("credential", the_repository,
+		trace2_data_intmax("credential", r,
 				   "interactive/skipped", 1);
 		return -1;
 	}
-	if (!git_config_get_string("credential.interactive", &value)) {
+	if (!repo_config_get_string(r, "credential.interactive", &value)) {
 		int same = !strcmp(value, "never");
 		free(value);
 		if (same) {
-			trace2_data_intmax("credential", the_repository,
+			trace2_data_intmax("credential", r,
 					   "interactive/skipped", 1);
 			return -1;
 		}
 	}
 
-	trace2_region_enter("credential", "interactive", the_repository);
+	trace2_region_enter("credential", "interactive", r);
 	if (!c->username)
 		c->username = credential_ask_one("Username", c,
 						 PROMPT_ASKPASS|PROMPT_ECHO);
 	if (!c->password)
 		c->password = credential_ask_one("Password", c,
 						 PROMPT_ASKPASS);
-	trace2_region_leave("credential", "interactive", the_repository);
+	trace2_region_leave("credential", "interactive", r);
 
 	return 0;
 }
@@ -489,7 +488,8 @@ static int credential_do(struct credential *c, const char *helper,
 	return r;
 }
 
-void credential_fill(struct credential *c, int all_capabilities)
+void credential_fill(struct repository *r,
+		     struct credential *c, int all_capabilities)
 {
 	int i;
 
@@ -499,7 +499,7 @@ void credential_fill(struct credential *c, int all_capabilities)
 	credential_next_state(c);
 	c->multistage = 0;
 
-	credential_apply_config(c);
+	credential_apply_config(r, c);
 	if (all_capabilities)
 		credential_set_all_capabilities(c, CREDENTIAL_OP_INITIAL);
 
@@ -526,12 +526,12 @@ void credential_fill(struct credential *c, int all_capabilities)
 			    c->helpers.items[i].string);
 	}
 
-	if (credential_getpass(c) ||
+	if (credential_getpass(r, c) ||
 	    (!c->username && !c->password && !c->credential))
 		die("unable to get password from user");
 }
 
-void credential_approve(struct credential *c)
+void credential_approve(struct repository *r, struct credential *c)
 {
 	int i;
 
@@ -542,20 +542,20 @@ void credential_approve(struct credential *c)
 
 	credential_next_state(c);
 
-	credential_apply_config(c);
+	credential_apply_config(r, c);
 
 	for (i = 0; i < c->helpers.nr; i++)
 		credential_do(c, c->helpers.items[i].string, "store");
 	c->approved = 1;
 }
 
-void credential_reject(struct credential *c)
+void credential_reject(struct repository *r, struct credential *c)
 {
 	int i;
 
 	credential_next_state(c);
 
-	credential_apply_config(c);
+	credential_apply_config(r, c);
 
 	for (i = 0; i < c->helpers.nr; i++)
 		credential_do(c, c->helpers.items[i].string, "erase");
diff --git a/credential.h b/credential.h
index 5f9e6ff2efef55fff8452fc6e50997a759a27118..1e6b0dc5b0f4654435c876b396ca0b6d833567ab 100644
--- a/credential.h
+++ b/credential.h
@@ -4,6 +4,8 @@
 #include "string-list.h"
 #include "strvec.h"
 
+struct repository;
+
 /**
  * The credentials API provides an abstracted way of gathering
  * authentication credentials from the user.
@@ -65,7 +67,7 @@
  * // Fill in the username and password fields by contacting
  * // helpers and/or asking the user. The function will die if it
  * // fails.
- * credential_fill(&c);
+ * credential_fill(repo, &c);
  *
  * // Otherwise, we have a username and password. Try to use it.
  *
@@ -218,7 +220,8 @@ void credential_clear(struct credential *);
  * If all_capabilities is set, this is an internal user that is prepared
  * to deal with all known capabilities, and we should advertise that fact.
  */
-void credential_fill(struct credential *, int all_capabilities);
+void credential_fill(struct repository *, struct credential *,
+		     int all_capabilities);
 
 /**
  * Inform the credential subsystem that the provided credentials
@@ -227,7 +230,7 @@ void credential_fill(struct credential *, int all_capabilities);
  * that they may store the result to be used again.  Any errors
  * from helpers are ignored.
  */
-void credential_approve(struct credential *);
+void credential_approve(struct repository *, struct credential *);
 
 /**
  * Inform the credential subsystem that the provided credentials
@@ -239,7 +242,7 @@ void credential_approve(struct credential *);
  * for another call to `credential_fill`). Any errors from helpers
  * are ignored.
  */
-void credential_reject(struct credential *);
+void credential_reject(struct repository *, struct credential *);
 
 /**
  * Enable all of the supported credential flags in this credential.
diff --git a/http.c b/http.c
index c8fc15aa118d3b1c0e8db1c804948c92a7314b5c..f08b2ae47465332714494cd5ea054880d42702c1 100644
--- a/http.c
+++ b/http.c
@@ -609,7 +609,7 @@ static void init_curl_http_auth(CURL *result)
 		}
 	}
 
-	credential_fill(&http_auth, 1);
+	credential_fill(the_repository, &http_auth, 1);
 
 	if (http_auth.password) {
 		if (always_auth_proactively()) {
@@ -652,7 +652,7 @@ static void init_curl_proxy_auth(CURL *result)
 {
 	if (proxy_auth.username) {
 		if (!proxy_auth.password && !proxy_auth.credential)
-			credential_fill(&proxy_auth, 1);
+			credential_fill(the_repository, &proxy_auth, 1);
 		set_proxyauth_name_password(result);
 	}
 
@@ -686,7 +686,7 @@ static int has_cert_password(void)
 		cert_auth.host = xstrdup("");
 		cert_auth.username = xstrdup("");
 		cert_auth.path = xstrdup(ssl_cert);
-		credential_fill(&cert_auth, 0);
+		credential_fill(the_repository, &cert_auth, 0);
 	}
 	return 1;
 }
@@ -700,7 +700,7 @@ static int has_proxy_cert_password(void)
 		proxy_cert_auth.host = xstrdup("");
 		proxy_cert_auth.username = xstrdup("");
 		proxy_cert_auth.path = xstrdup(http_proxy_ssl_cert);
-		credential_fill(&proxy_cert_auth, 0);
+		credential_fill(the_repository, &proxy_cert_auth, 0);
 	}
 	return 1;
 }
@@ -1784,9 +1784,9 @@ static int handle_curl_result(struct slot_results *results)
 			      curl_errorstr, sizeof(curl_errorstr));
 
 	if (results->curl_result == CURLE_OK) {
-		credential_approve(&http_auth);
-		credential_approve(&proxy_auth);
-		credential_approve(&cert_auth);
+		credential_approve(the_repository, &http_auth);
+		credential_approve(the_repository, &proxy_auth);
+		credential_approve(the_repository, &cert_auth);
 		return HTTP_OK;
 	} else if (results->curl_result == CURLE_SSL_CERTPROBLEM) {
 		/*
@@ -1795,7 +1795,7 @@ static int handle_curl_result(struct slot_results *results)
 		 * with the certificate.  So we reject the credential to
 		 * avoid caching or saving a bad password.
 		 */
-		credential_reject(&cert_auth);
+		credential_reject(the_repository, &cert_auth);
 		return HTTP_NOAUTH;
 	} else if (results->curl_result == CURLE_SSL_PINNEDPUBKEYNOTMATCH) {
 		return HTTP_NOMATCHPUBLICKEY;
@@ -1808,7 +1808,7 @@ static int handle_curl_result(struct slot_results *results)
 				credential_clear_secrets(&http_auth);
 				return HTTP_REAUTH;
 			}
-			credential_reject(&http_auth);
+			credential_reject(the_repository, &http_auth);
 			if (always_auth_proactively())
 				http_proactive_auth = PROACTIVE_AUTH_NONE;
 			return HTTP_NOAUTH;
@@ -1822,7 +1822,7 @@ static int handle_curl_result(struct slot_results *results)
 		}
 	} else {
 		if (results->http_connectcode == 407)
-			credential_reject(&proxy_auth);
+			credential_reject(the_repository, &proxy_auth);
 		if (!curl_errorstr[0])
 			strlcpy(curl_errorstr,
 				curl_easy_strerror(results->curl_result),
@@ -2210,7 +2210,7 @@ static int http_request_reauth(const char *url,
 	int ret;
 
 	if (always_auth_proactively())
-		credential_fill(&http_auth, 1);
+		credential_fill(the_repository, &http_auth, 1);
 
 	ret = http_request(url, result, target, options);
 
@@ -2251,7 +2251,7 @@ static int http_request_reauth(const char *url,
 			BUG("Unknown http_request target");
 		}
 
-		credential_fill(&http_auth, 1);
+		credential_fill(the_repository, &http_auth, 1);
 
 		ret = http_request(url, result, target, options);
 	}
diff --git a/imap-send.c b/imap-send.c
index 68ab1aea837c3549a56675407edae19e12c6bfdf..6c8f84e836bb4018d93520b6b5f96687c975d33a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -922,7 +922,7 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
 	cred->username = xstrdup_or_null(srvc->user);
 	cred->password = xstrdup_or_null(srvc->pass);
 
-	credential_fill(cred, 1);
+	credential_fill(the_repository, cred, 1);
 
 	if (!srvc->user)
 		srvc->user = xstrdup(cred->username);
@@ -1123,7 +1123,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 	} /* !preauth */
 
 	if (cred.username)
-		credential_approve(&cred);
+		credential_approve(the_repository, &cred);
 	credential_clear(&cred);
 
 	/* check the target mailbox exists */
@@ -1150,7 +1150,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 
 bail:
 	if (cred.username)
-		credential_reject(&cred);
+		credential_reject(the_repository, &cred);
 	credential_clear(&cred);
 
  out:
@@ -1492,9 +1492,9 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 
 	if (cred.username) {
 		if (res == CURLE_OK)
-			credential_approve(&cred);
+			credential_approve(the_repository, &cred);
 		else if (res == CURLE_LOGIN_DENIED)
-			credential_reject(&cred);
+			credential_reject(the_repository, &cred);
 	}
 
 	credential_clear(&cred);
diff --git a/remote-curl.c b/remote-curl.c
index a24e3a8b9abcc9f01d862a18dbd237fdad8d3d3a..1273507a96cae97eeaac9a95a47618e5e4f72850 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -942,7 +942,7 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 		do {
 			err = probe_rpc(rpc, &results);
 			if (err == HTTP_REAUTH)
-				credential_fill(&http_auth, 0);
+				credential_fill(the_repository, &http_auth, 0);
 		} while (err == HTTP_REAUTH);
 		if (err != HTTP_OK)
 			return -1;
@@ -1064,7 +1064,7 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 	rpc->any_written = 0;
 	err = run_slot(slot, NULL);
 	if (err == HTTP_REAUTH && !large_request) {
-		credential_fill(&http_auth, 0);
+		credential_fill(the_repository, &http_auth, 0);
 		curl_slist_free_all(headers);
 		goto retry;
 	}

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

