Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCD1C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 09:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjDUJtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 05:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjDUJs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 05:48:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594B3B770
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 02:48:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-2f8405b3dc1so930883f8f.3
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682070481; x=1684662481;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3aYktc0ZNhnfAXGc2In01KeaxDlVKIHSu/Dfwp6/3E=;
        b=RvtIXp373iWZyWsn5+HcnMldOcH3xUwjv7PwGqEppy4Rk1z+xl6c0ZGqBMYzqp/WP6
         k9LBzcRNq62rSP9unV+PrgEw7QbbzUlgM4A3rxfslKZQ2hP2iOFv/M3a6BOSodtnUi+B
         VSVmWpduFPP/GeMLj7CssUVWtHeKlWkXkuJZPPklu/sL8FMEkPnU5fXs/NfwJqdiFYad
         R2kXjwhJJJbtlFYkmptoU1x3dKaDGo2SoDwOgWrZ8tnpRmljBQeHRC4uNSgDtCBfwylP
         kCBotgHcrwH0lvbwbDVCU/++d6mGPNXdbi0GuIxa9hJO1zY9k1a8u/vpt8xmpM2mAErW
         oaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682070481; x=1684662481;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3aYktc0ZNhnfAXGc2In01KeaxDlVKIHSu/Dfwp6/3E=;
        b=RL3GjR06nN+Z/Bs0cbsTY7xqKZXjWcNTJ3Lv8WSMBMCMLMsMmpL23DxO1rR0URz7aB
         MHV+RR8QJTqJwcoYFSnLC+p/Zt28jn0SByY3TC2aTCS/L1HdU8NC5f186MTm0uh3jYBU
         X9Cum6+QRlRxN4ne2MHQrfCmkR8WSO6XnHX9xL1NLQjPzCMCMgFczyFzAyTC+ihfS5BF
         Dz0A+uwy4dUhrnrM0i18abpIOaRRqCI1HPjHHgibxb8ax5YujcMOHmE7nTGzfysfW8HU
         Cib76YqG69kqFdEuH2DsfVb1hcLR/D8x6oc9R67PG0HXyQCydWnBi3VpfhG0l/k8n2kT
         lIXQ==
X-Gm-Message-State: AAQBX9cdWPC81dBN2LdyIpAePPPreI1FdVaacERSut7LM55M4Kayp65D
        g043SepNlaXG6MGzh785uVPERE/u05E=
X-Google-Smtp-Source: AKy350bRU+kzdsWU4i2VZF49wnNrnMJtAkkXj9orzWNEDMrRUPKjElKxiR1acWZslPKZHcq9Lbjq6A==
X-Received: by 2002:a5d:58e9:0:b0:2f6:1a30:605c with SMTP id f9-20020a5d58e9000000b002f61a30605cmr3476173wrd.3.1682070481399;
        Fri, 21 Apr 2023 02:48:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f22-20020a1c6a16000000b003f17e79d74asm4382949wmc.7.2023.04.21.02.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:48:00 -0700 (PDT)
Message-Id: <pull.1394.v2.git.1682070479816.gitgitgadget@gmail.com>
In-Reply-To: <pull.1394.git.1678776364753.gitgitgadget@gmail.com>
References: <pull.1394.git.1678776364753.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 09:47:59 +0000
Subject: [PATCH v2] credential: new attribute oauth_refresh_token
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

Git authentication with OAuth access token is supported by every popular
Git host including GitHub, GitLab and BitBucket [1][2][3]. Credential
helpers Git Credential Manager (GCM) and git-credential-oauth generate
OAuth credentials [4][5]. Following RFC 6749, the application prints a
link for the user to authorize access in browser. A loopback redirect
communicates the response including access token to the application.

For security, RFC 6749 recommends that OAuth response also includes
expiry date and refresh token [6]. After expiry, applications can use
the refresh token to generate a new access token without user
reauthorization in browser. GitLab and BitBucket set the expiry at two
hours [2][3]. (GitHub doesn't populate expiry or refresh token.)

However the Git credential protocol has no attribute to store the OAuth
refresh token (unrecognised attributes are silently discarded). This
means that the user has to regularly reauthorize the helper in browser.
On a browserless system, this is particularly intrusive, requiring a
second device.

Introduce a new attribute oauth_refresh_token. This is especially
useful when a storage helper and a read-only OAuth helper are configured
together. Recall that `credential fill` calls each helper until it has a
non-expired password.

```
[credential]
	helper = storage  # eg. cache or osxkeychain
	helper = oauth
```

The OAuth helper can use the stored refresh token forwarded by
`credential fill` to generate a fresh access token without opening the
browser. See
https://github.com/hickford/git-credential-oauth/pull/3/files
for an implementation tested with this patch.

Add support for the new attribute to credential-cache. Eventually, I
hope to see support in other popular storage helpers.

Alternatives considered: ask helpers to store all unrecognised
attributes. This seems excessively complex for no obvious gain.
Helpers would also need extra information to distinguish between
confidential and non-confidential attributes.

Workarounds: GCM abuses the helper get/store/erase contract to store the
refresh token during credential *get* as the password for a fictitious
host [7] (I wrote this hack). This workaround is only feasible for a
monolithic helper with its own storage.

[1] https://github.blog/2012-09-21-easier-builds-and-deployments-using-git-over-https-and-oauth/
[2] https://docs.gitlab.com/ee/api/oauth2.html#access-git-over-https-with-access-token
[3] https://support.atlassian.com/bitbucket-cloud/docs/use-oauth-on-bitbucket-cloud/#Cloning-a-repository-with-an-access-token
[4] https://github.com/GitCredentialManager/git-credential-manager
[5] https://github.com/hickford/git-credential-oauth
[6] https://datatracker.ietf.org/doc/html/rfc6749#section-5.1
[7] https://github.com/GitCredentialManager/git-credential-manager/blob/66b94e489ad8cc1982836355493e369770b30211/src/shared/GitLab/GitLabHostProvider.cs#L207

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential: new attribute oauth_refresh_token
    
    A minimal extension to the credential protocol to communicate OAuth
    refresh token. This is worthwhile because OAuth for Git authentication
    is ubiquitous. Current workaround is only feasible for a monolithic
    credential helper, discouraging interoperability between helpers.
    
    Patch v2 adds an additional test

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1394%2Fhickford%2Fcredential-refresh-token-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1394/hickford/credential-refresh-token-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1394

Range-diff vs v1:

 1:  299a26919f0 ! 1:  79e77a4426b credential: new attribute oauth_refresh_token
     @@ credential.c: void credential_clear(struct credential *c)
       	free(c->password);
      +	free(c->oauth_refresh_token);
       	string_list_clear(&c->helpers, 0);
     + 	strvec_clear(&c->wwwauth_headers);
       
     - 	credential_init(c);
      @@ credential.c: int credential_read(struct credential *c, FILE *fp)
       			c->password_expiry_utc = parse_timestamp(value, NULL, 10);
       			if (c->password_expiry_utc == 0 || errno == ERANGE)
     @@ credential.h: struct credential {
       };
       
      
     + ## t/lib-credential.sh ##
     +@@ t/lib-credential.sh: helper_test_clean() {
     + 	reject $1 https example.com store-user
     + 	reject $1 https example.com user1
     + 	reject $1 https example.com user2
     ++	reject $1 https example.com user4
     + 	reject $1 http path.tld user
     + 	reject $1 https timeout.tld user
     + 	reject $1 https sso.tld
     +@@ t/lib-credential.sh: helper_test_timeout() {
     + 	'
     + }
     + 
     ++helper_test_oauth_refresh_token() {
     ++	HELPER=$1
     ++
     ++	test_expect_success "helper ($HELPER) stores oauth_refresh_token" '
     ++		check approve $HELPER <<-\EOF
     ++		protocol=https
     ++		host=example.com
     ++		username=user4
     ++		password=pass
     ++		oauth_refresh_token=xyzzy
     ++		EOF
     ++	'
     ++
     ++	test_expect_success "helper ($HELPER) gets oauth_refresh_token" '
     ++		check fill $HELPER <<-\EOF
     ++		protocol=https
     ++		host=example.com
     ++		username=user4
     ++		--
     ++		protocol=https
     ++		host=example.com
     ++		username=user4
     ++		password=pass
     ++		oauth_refresh_token=xyzzy
     ++		--
     ++		EOF
     ++	'
     ++}
     ++
     + write_script askpass <<\EOF
     + echo >&2 askpass: $*
     + what=$(echo $1 | cut -d" " -f1 | tr A-Z a-z | tr -cd a-z)
     +
       ## t/t0300-credentials.sh ##
      @@ t/t0300-credentials.sh: test_expect_success 'credential_approve stores password expiry' '
       	EOF
     @@ t/t0300-credentials.sh: test_expect_success 'credential_approve stores password
       test_expect_success 'do not bother storing password-less credential' '
       	check approve useless <<-\EOF
       	protocol=http
     +
     + ## t/t0301-credential-cache.sh ##
     +@@ t/t0301-credential-cache.sh: test_atexit 'git credential-cache exit'
     + 
     + # test that the daemon works with no special setup
     + helper_test cache
     ++helper_test_oauth_refresh_token cache
     + 
     + test_expect_success 'socket defaults to ~/.cache/git/credential/socket' '
     + 	test_when_finished "


 Documentation/git-credential.txt   |  6 ++++++
 builtin/credential-cache--daemon.c |  3 +++
 credential.c                       |  6 ++++++
 credential.h                       |  1 +
 t/lib-credential.sh                | 30 ++++++++++++++++++++++++++++++
 t/t0300-credentials.sh             | 18 ++++++++++++++++++
 t/t0301-credential-cache.sh        |  1 +
 7 files changed, 65 insertions(+)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 3394c036113..0e6d9e85ec7 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -156,6 +156,12 @@ Git understands the following attributes:
 	When reading credentials from helpers, `git credential fill` ignores expired
 	passwords. Represented as Unix time UTC, seconds since 1970.
 
+`oauth_refresh_token`::
+
+	An OAuth refresh token may accompany a password that is an OAuth access
+	token. Helpers must treat this attribute as confidential like the password
+	attribute. Git itself has no special behaviour for this attribute.
+
 `url`::
 
 	When this special attribute is read by `git credential`, the
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 62c09a271d6..9db5f00184d 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -133,6 +133,9 @@ static void serve_one_client(FILE *in, FILE *out)
 			if (e->item.password_expiry_utc != TIME_MAX)
 				fprintf(out, "password_expiry_utc=%"PRItime"\n",
 					e->item.password_expiry_utc);
+			if (e->item.oauth_refresh_token)
+				fprintf(out, "oauth_refresh_token=%s\n",
+					e->item.oauth_refresh_token);
 		}
 	}
 	else if (!strcmp(action.buf, "exit")) {
diff --git a/credential.c b/credential.c
index e6417bf8804..84e32971a92 100644
--- a/credential.c
+++ b/credential.c
@@ -24,6 +24,7 @@ void credential_clear(struct credential *c)
 	free(c->path);
 	free(c->username);
 	free(c->password);
+	free(c->oauth_refresh_token);
 	string_list_clear(&c->helpers, 0);
 	strvec_clear(&c->wwwauth_headers);
 
@@ -243,6 +244,9 @@ int credential_read(struct credential *c, FILE *fp)
 			c->password_expiry_utc = parse_timestamp(value, NULL, 10);
 			if (c->password_expiry_utc == 0 || errno == ERANGE)
 				c->password_expiry_utc = TIME_MAX;
+		} else if (!strcmp(key, "oauth_refresh_token")) {
+			free(c->oauth_refresh_token);
+			c->oauth_refresh_token = xstrdup(value);
 		} else if (!strcmp(key, "url")) {
 			credential_from_url(c, value);
 		} else if (!strcmp(key, "quit")) {
@@ -278,6 +282,7 @@ void credential_write(const struct credential *c, FILE *fp)
 	credential_write_item(fp, "path", c->path, 0);
 	credential_write_item(fp, "username", c->username, 0);
 	credential_write_item(fp, "password", c->password, 0);
+	credential_write_item(fp, "oauth_refresh_token", c->oauth_refresh_token, 0);
 	if (c->password_expiry_utc != TIME_MAX) {
 		char *s = xstrfmt("%"PRItime, c->password_expiry_utc);
 		credential_write_item(fp, "password_expiry_utc", s, 0);
@@ -403,6 +408,7 @@ void credential_reject(struct credential *c)
 
 	FREE_AND_NULL(c->username);
 	FREE_AND_NULL(c->password);
+	FREE_AND_NULL(c->oauth_refresh_token);
 	c->password_expiry_utc = TIME_MAX;
 	c->approved = 0;
 }
diff --git a/credential.h b/credential.h
index 2b5958cd431..b8e2936d1dc 100644
--- a/credential.h
+++ b/credential.h
@@ -141,6 +141,7 @@ struct credential {
 	char *protocol;
 	char *host;
 	char *path;
+	char *oauth_refresh_token;
 	timestamp_t password_expiry_utc;
 };
 
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 5ea8bc9f1dc..33666406d92 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -43,6 +43,7 @@ helper_test_clean() {
 	reject $1 https example.com store-user
 	reject $1 https example.com user1
 	reject $1 https example.com user2
+	reject $1 https example.com user4
 	reject $1 http path.tld user
 	reject $1 https timeout.tld user
 	reject $1 https sso.tld
@@ -298,6 +299,35 @@ helper_test_timeout() {
 	'
 }
 
+helper_test_oauth_refresh_token() {
+	HELPER=$1
+
+	test_expect_success "helper ($HELPER) stores oauth_refresh_token" '
+		check approve $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		username=user4
+		password=pass
+		oauth_refresh_token=xyzzy
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) gets oauth_refresh_token" '
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		username=user4
+		--
+		protocol=https
+		host=example.com
+		username=user4
+		password=pass
+		oauth_refresh_token=xyzzy
+		--
+		EOF
+	'
+}
+
 write_script askpass <<\EOF
 echo >&2 askpass: $*
 what=$(echo $1 | cut -d" " -f1 | tr A-Z a-z | tr -cd a-z)
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index c66d91e82d8..b49fc14a2bd 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -214,6 +214,24 @@ test_expect_success 'credential_approve stores password expiry' '
 	EOF
 '
 
+test_expect_success 'credential_approve stores oauth refresh token' '
+	check approve useless <<-\EOF
+	protocol=http
+	host=example.com
+	username=foo
+	password=bar
+	oauth_refresh_token=xyzzy
+	--
+	--
+	useless: store
+	useless: protocol=http
+	useless: host=example.com
+	useless: username=foo
+	useless: password=bar
+	useless: oauth_refresh_token=xyzzy
+	EOF
+'
+
 test_expect_success 'do not bother storing password-less credential' '
 	check approve useless <<-\EOF
 	protocol=http
diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index 698b7159f03..c02a3b5969c 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -29,6 +29,7 @@ test_atexit 'git credential-cache exit'
 
 # test that the daemon works with no special setup
 helper_test cache
+helper_test_oauth_refresh_token cache
 
 test_expect_success 'socket defaults to ~/.cache/git/credential/socket' '
 	test_when_finished "

base-commit: 667fcf4e15379790f0b609d6a83d578e69f20301
-- 
gitgitgadget
