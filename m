Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD7DECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 19:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiIMT0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 15:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIMT0E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 15:26:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3817179632
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:26:03 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r66-20020a1c4445000000b003b494ffc00bso1582018wma.0
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=77O6rPRJ2q8PuFyRFUJwKrCINBOGtDCnw4Thl805/gI=;
        b=gP3ZMjKpTgsfAbodCdyfwu13nlfRGnc24J1aLaZ2CCl3kiz/VzBr63OejEjR3ZEaKc
         mTQt2G04TCqPFjSUIjszkund3j/+DDho1ubyQPpABJAZ1zp9bezc/UAYuP/q5Kq1i3Ib
         JGssq9MdjCmMFGJV+laPsho+0beKAC5hUcEu1fEPjpH+w2f93wt4xQTrWxRqtdCsebX6
         +MG7PFuiWza9afPI8MGjFvcW/pHQNFWSOJM8DPe+huvV0l1/fmf5IZyPCq0HE9o9X+HP
         hDafju6LR91bOlCFn3XsrpGJFhi6p3y1KgtuReOA5FaSaz9+tFMh/X44tKuOq6Fcmp6/
         +d3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=77O6rPRJ2q8PuFyRFUJwKrCINBOGtDCnw4Thl805/gI=;
        b=tnkCIVN59WhbMs3G2xijOSZa6sSAqygQy5NYdNRvCOzkGcpcnbGk91qIwi9CzWmTM6
         ZTIV6mBd1fewShHUxF5FEgWlp9x7GfSqrtSErd6ExwURlsOC57vOo51jROsuuF2JBKNp
         y5V/eYDV7RxQppY34vujBCYP8iqp5RscS7k7LfBCcV7cdOB1472ogAW51K31HRh5SQ9u
         rDJOG149XLCTkMclyIXI10td99Cj+gYIJoiDbyPZUJl+ScCLNEv3Cnab2EuS2Dq3l5ue
         NTxXxghhHdi3dvSsdRs7vkBZYMztXRM0Cnhn5tuwNDhZje99+fH5bI6bLfl3T0A2fMWB
         47WA==
X-Gm-Message-State: ACgBeo2x4WFLww+o27Ly4ppWgCjQjjKiAia8OrK47K1v8xnpk4uiC+nU
        D2yn0Vnj5AFIK8dXf9fKQC08dlCL09A=
X-Google-Smtp-Source: AA6agR41aZfJ8iQP/koCn7Taik6tne7eo2IcaKCZu7juVTPRWwR+531lcxg2ZFTtMtZootXrcvyTXw==
X-Received: by 2002:a05:600c:1c8d:b0:3a6:9d60:faf0 with SMTP id k13-20020a05600c1c8d00b003a69d60faf0mr629370wms.82.1663097162487;
        Tue, 13 Sep 2022 12:26:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cc17-20020a5d5c11000000b0022ac119fcc5sm2550028wrb.60.2022.09.13.12.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:26:02 -0700 (PDT)
Message-Id: <936545004b8b46cbe24d8069cfd95ae5b5f98593.1663097156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 19:25:53 +0000
Subject: [PATCH 5/8] credential: add WWW-Authenticate header to cred requests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Add the value of the WWW-Authenticate response header to credential
requests. Credential helpers that understand and support HTTP
authentication and authorization can use this standard header (RFC 2616
Section 14.47 [1]) to generate valid credentials.

WWW-Authenticate headers can contain information pertaining to the
authority, authentication mechanism, or extra parameters/scopes that are
required.

The current I/O format for credential helpers only allows for unique
names for properties/attributes, so in order to transmit multiple header
values (with a specific order) we introduce a new convention whereby a
C-style array syntax is used in the property name to denote multiple
ordered values for the same property.

In this case we send multiple `wwwauth[n]` properties where `n` is a
zero-indexed number, reflecting the order the WWW-Authenticate headers
appeared in the HTTP response.

[1] https://datatracker.ietf.org/doc/html/rfc2616#section-14.47

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 Documentation/git-credential.txt |  9 +++++++
 credential.c                     | 12 +++++++++
 t/lib-httpd/apache.conf          | 13 +++++++++
 t/t5551-http-fetch-smart.sh      | 46 ++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index f18673017f5..7d4a788c63d 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -151,6 +151,15 @@ Git understands the following attributes:
 	were read (e.g., `url=https://example.com` would behave as if
 	`protocol=https` and `host=example.com` had been provided). This
 	can help callers avoid parsing URLs themselves.
+
+`wwwauth[n]`::
+
+	When an HTTP response is received that includes one or more
+	'WWW-Authenticate' authentication headers, these can be passed to Git
+	(and subsequent credential helpers) with these attributes.
+	Each 'WWW-Authenticate' header value should be passed as a separate
+	attribute 'wwwauth[n]' where 'n' is the zero-indexed order the headers
+	appear in the HTTP response.
 +
 Note that specifying a protocol is mandatory and if the URL
 doesn't specify a hostname (e.g., "cert:///path/to/file") the
diff --git a/credential.c b/credential.c
index 897b4679333..4ad40323fc7 100644
--- a/credential.c
+++ b/credential.c
@@ -263,6 +263,17 @@ static void credential_write_item(FILE *fp, const char *key, const char *value,
 	fprintf(fp, "%s=%s\n", key, value);
 }
 
+static void credential_write_strvec(FILE *fp, const char *key,
+				    const struct strvec *vec)
+{
+	int i = 0;
+	for (; i < vec->nr; i++) {
+		const char *full_key = xstrfmt("%s[%d]", key, i);
+		credential_write_item(fp, full_key, vec->v[i], 0);
+		free((void*)full_key);
+	}
+}
+
 void credential_write(const struct credential *c, FILE *fp)
 {
 	credential_write_item(fp, "protocol", c->protocol, 1);
@@ -270,6 +281,7 @@ void credential_write(const struct credential *c, FILE *fp)
 	credential_write_item(fp, "path", c->path, 0);
 	credential_write_item(fp, "username", c->username, 0);
 	credential_write_item(fp, "password", c->password, 0);
+	credential_write_strvec(fp, "wwwauth", &c->wwwauth_headers);
 }
 
 static int run_credential_helper(struct credential *c,
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 497b9b9d927..fe118d76f98 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -235,6 +235,19 @@ SSLEngine On
 	Require valid-user
 </LocationMatch>
 
+# Advertise two additional auth methods above "Basic".
+# Neither of them actually work but serve test cases showing these
+# additional auth headers are consumed correctly.
+<Location /auth-wwwauth/>
+	AuthType Basic
+	AuthName "git-auth"
+	AuthUserFile passwd
+	Require valid-user
+	SetEnvIf Authorization "^\S+" authz
+	Header always add WWW-Authenticate "Bearer authority=https://login.example.com" env=!authz
+	Header always add WWW-Authenticate "FooAuth foo=bar baz=1" env=!authz
+</Location>
+
 RewriteCond %{QUERY_STRING} service=git-receive-pack [OR]
 RewriteCond %{REQUEST_URI} /git-receive-pack$
 RewriteRule ^/half-auth-complete/ - [E=AUTHREQUIRED:yes]
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 6a38294a476..c99d8e253df 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -564,6 +564,52 @@ test_expect_success 'http auth forgets bogus credentials' '
 	expect_askpass both user@host
 '
 
+test_expect_success 'http auth sends www-auth headers to credential helper' '
+	write_script git-credential-tee <<-\EOF &&
+		cmd=$1
+		teefile=credential-$cmd
+		if [ -f "$teefile" ]; then
+			rm $teefile
+		fi
+		(
+			while read line;
+			do
+				if [ -z "$line" ]; then
+					exit 0
+				fi
+				echo "$line" >> $teefile
+				echo $line
+			done
+		) | git credential-store $cmd
+	EOF
+
+	cat >expected-get <<-EOF &&
+	protocol=http
+	host=127.0.0.1:5551
+	wwwauth[0]=Bearer authority=https://login.example.com
+	wwwauth[1]=FooAuth foo=bar baz=1
+	wwwauth[2]=Basic realm="git-auth"
+	EOF
+
+	cat >expected-store <<-EOF &&
+	protocol=http
+	host=127.0.0.1:5551
+	username=user@host
+	password=pass@host
+	EOF
+
+	rm -f .git-credentials &&
+	test_config credential.helper tee &&
+	set_askpass user@host pass@host &&
+	(
+		PATH="$PWD:$PATH" &&
+		git ls-remote "$HTTPD_URL/auth-wwwauth/smart/repo.git"
+	) &&
+	expect_askpass both user@host &&
+	test_cmp expected-get credential-get &&
+	test_cmp expected-store credential-store
+'
+
 test_expect_success 'client falls back from v2 to v0 to match server' '
 	GIT_TRACE_PACKET=$PWD/trace \
 	GIT_TEST_PROTOCOL_VERSION=2 \
-- 
gitgitgadget

