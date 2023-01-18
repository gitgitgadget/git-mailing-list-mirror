Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EFBC00A5A
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 03:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjARDbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 22:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjARDag (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 22:30:36 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B7D51C4D
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:31 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q10so13290580wrs.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqov+LakXJJTebf7RM2+rAZA+HKTzRzGbXvTUFu8gW4=;
        b=egK81/GCigZo9dwWi1sMnXmcTMobT8qZKcVRX7Qf7LSkfcD1zY+50kf43pW4yaJkJZ
         T6m/9pswLNsOprwjOGj3FVp1N9gg8ZtF0mCWXvYP3lyWBxgL793IlD1WWRdXOrTYGbSc
         80aQY/oR4c53oIsT0C7IhrAbt4PZo8Qh5hNgG07tLPZZWrm3HTSZaEObr0jG4toABfiQ
         egHmbcCPL5xp/gasK02g8k11yO3xF7EhYuNtPma96j91Tr07FymSGJHoC4HV4Z1C0zO9
         90wu5rXW7tNPfIGHrCVcdbX18IHefAGsBuydguBneTqnQaBLj+u//fc/W70Eww0cGw8C
         pj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqov+LakXJJTebf7RM2+rAZA+HKTzRzGbXvTUFu8gW4=;
        b=AB13kS3VeGjPfNOvgt+s7fVUc1Ktd5OEdvSSIhDuB6cdriT43Z8Hnswsy9TIcgnHv0
         qgyzFsdHynp38GVuJZGOru7WV5J2z/3arzhbg+Tl5Jdk3Lprjg+mhP7Qz97FlpYAKp2b
         1PO1GSQUZU3678+tZwJAseZ8YNkE6WEyBdY1HnwqMqvQ4hX62uPKq/Iy9SRDYUOQZcW0
         v9+4nemhpDYEiNljLGYCZMby3Jssz8poqmvwze0cve2m+pnVYk6FrIGGELZP757ltvp6
         QuuYcTxQpyRGUTr7P3XugEziNWSWeceZe2VSIdMgi03vRDGKWSKEiRLouy9SlpY/bVN0
         oOlg==
X-Gm-Message-State: AFqh2kq14U1VfZAPEaGxgE5Ik/qNWmjfbJv557CSkwTicjeu4o6HzrXg
        8PB8RmvPZHWknAApjctbNl09RuY7210=
X-Google-Smtp-Source: AMrXdXvKe7GJpuoHjsUuV7rVA4Hw6iUSa4fm/HtyKWqTH1CEAu6K47UK4GLfMfvE10dRizsmAYhTcg==
X-Received: by 2002:a05:6000:11c6:b0:2bd:bf72:76f2 with SMTP id i6-20020a05600011c600b002bdbf7276f2mr4301750wrx.14.1674012629939;
        Tue, 17 Jan 2023 19:30:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t18-20020adff612000000b002be2f18938csm406245wrp.41.2023.01.17.19.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 19:30:29 -0800 (PST)
Message-Id: <7c8229f0b11693310ae47551fcc5e58f0bb64a0a.1674012618.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
        <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Jan 2023 03:30:17 +0000
Subject: [PATCH v6 12/12] credential: add WWW-Authenticate header to cred
 requests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Matthew John Cheetham <mjcheetham@github.com>,
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

In this case we send multiple `wwwauth[]` properties where the order
that the repeated attributes appear in the conversation reflects the
order that the WWW-Authenticate headers appeared in the HTTP response.

Add a set of tests to exercise the HTTP authentication header parsing
and the interop with credential helpers. Credential helpers will receive
WWW-Authenticate information in credential requests.

[1] https://datatracker.ietf.org/doc/html/rfc2616#section-14.47

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 Documentation/git-credential.txt |  19 ++-
 credential.c                     |  11 ++
 t/lib-credential-helper.sh       |  27 ++++
 t/t5556-http-auth.sh             | 245 ++++++++++++++++++++++++++++++-
 4 files changed, 300 insertions(+), 2 deletions(-)
 create mode 100644 t/lib-credential-helper.sh

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index ac2818b9f66..50759153ef1 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -113,7 +113,13 @@ separated by an `=` (equals) sign, followed by a newline.
 The key may contain any bytes except `=`, newline, or NUL. The value may
 contain any bytes except newline or NUL.
 
-In both cases, all bytes are treated as-is (i.e., there is no quoting,
+Attributes with keys that end with C-style array brackets `[]` can have
+multiple values. Each instance of a multi-valued attribute forms an
+ordered list of values - the order of the repeated attributes defines
+the order of the values. An empty multi-valued attribute (`key[]=\n`)
+acts to clear any previous entries and reset the list.
+
+In all cases, all bytes are treated as-is (i.e., there is no quoting,
 and one cannot transmit a value with newline or NUL in it). The list of
 attributes is terminated by a blank line or end-of-file.
 
@@ -160,6 +166,17 @@ empty string.
 Components which are missing from the URL (e.g., there is no
 username in the example above) will be left unset.
 
+`wwwauth[]`::
+
+	When an HTTP response is received by Git that includes one or more
+	'WWW-Authenticate' authentication headers, these will be passed by Git
+	to credential helpers.
++
+Each 'WWW-Authenticate' header value is passed as a multi-valued
+attribute 'wwwauth[]', where the order of the attributes is the same as
+they appear in the HTTP response. This attribute is 'one-way' from Git
+to pass additional information to credential helpers.
+
 Unrecognised attributes are silently discarded.
 
 GIT
diff --git a/credential.c b/credential.c
index 897b4679333..9f39ebc3c7e 100644
--- a/credential.c
+++ b/credential.c
@@ -263,6 +263,16 @@ static void credential_write_item(FILE *fp, const char *key, const char *value,
 	fprintf(fp, "%s=%s\n", key, value);
 }
 
+static void credential_write_strvec(FILE *fp, const char *key,
+				    const struct strvec *vec)
+{
+	char *full_key = xstrfmt("%s[]", key);
+	for (size_t i = 0; i < vec->nr; i++) {
+		credential_write_item(fp, full_key, vec->v[i], 0);
+	}
+	free(full_key);
+}
+
 void credential_write(const struct credential *c, FILE *fp)
 {
 	credential_write_item(fp, "protocol", c->protocol, 1);
@@ -270,6 +280,7 @@ void credential_write(const struct credential *c, FILE *fp)
 	credential_write_item(fp, "path", c->path, 0);
 	credential_write_item(fp, "username", c->username, 0);
 	credential_write_item(fp, "password", c->password, 0);
+	credential_write_strvec(fp, "wwwauth", &c->wwwauth_headers);
 }
 
 static int run_credential_helper(struct credential *c,
diff --git a/t/lib-credential-helper.sh b/t/lib-credential-helper.sh
new file mode 100644
index 00000000000..8b0e4414234
--- /dev/null
+++ b/t/lib-credential-helper.sh
@@ -0,0 +1,27 @@
+setup_credential_helper() {
+	test_expect_success 'setup credential helper' '
+		CREDENTIAL_HELPER="$TRASH_DIRECTORY/credential-helper.sh" &&
+		export CREDENTIAL_HELPER &&
+		echo $CREDENTIAL_HELPER &&
+
+		write_script "$CREDENTIAL_HELPER" <<-\EOF
+		cmd=$1
+		teefile=$cmd-query.cred
+		catfile=$cmd-reply.cred
+		sed -n -e "/^$/q" -e "p" >> $teefile
+		if test "$cmd" = "get"; then
+			cat $catfile
+		fi
+		EOF
+	'
+}
+
+set_credential_reply() {
+	cat >"$TRASH_DIRECTORY/$1-reply.cred"
+}
+
+expect_credential_query() {
+	cat >"$TRASH_DIRECTORY/$1-expect.cred" &&
+	test_cmp "$TRASH_DIRECTORY/$1-expect.cred" \
+		 "$TRASH_DIRECTORY/$1-query.cred"
+}
diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
index e36107ea95d..79122c611a1 100755
--- a/t/t5556-http-auth.sh
+++ b/t/t5556-http-auth.sh
@@ -4,6 +4,7 @@ test_description='test http auth header and credential helper interop'
 
 TEST_NO_CREATE_REPO=1
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-credential-helper.sh
 
 test_set_port GIT_TEST_HTTP_PROTOCOL_PORT
 
@@ -33,6 +34,8 @@ test_expect_success 'setup repos' '
 	git -C "$REPO_DIR" branch -M main
 '
 
+setup_credential_helper
+
 stop_http_server () {
 	if ! test -f "$PID_FILE"
 	then
@@ -92,7 +95,9 @@ start_http_server () {
 
 per_test_cleanup () {
 	stop_http_server &&
-	rm -f OUT.*
+	rm -f OUT.* &&
+	rm -f *.cred &&
+	rm -f auth.config
 }
 
 test_expect_success CURL 'http auth server auth config' '
@@ -152,4 +157,242 @@ test_expect_success 'http auth anonymous no challenge' '
 	git ls-remote $ORIGIN_URL
 '
 
+test_expect_success 'http auth www-auth headers to credential helper basic valid' '
+	test_when_finished "per_test_cleanup" &&
+	# base64("alice:secret-passwd")
+	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
+	export USERPASS64 &&
+
+	cat >auth.config <<-EOF &&
+	[auth]
+		challenge = basic:realm=\"example.com\"
+		token = basic:$USERPASS64
+	EOF
+
+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
+
+	set_credential_reply get <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+
+	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	wwwauth[]=basic realm="example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_expect_success 'http auth www-auth headers to credential helper ignore case valid' '
+	test_when_finished "per_test_cleanup" &&
+	# base64("alice:secret-passwd")
+	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
+	export USERPASS64 &&
+
+	cat >auth.config <<-EOF &&
+	[auth]
+		challenge = basic:realm=\"example.com\"
+		token = basic:$USERPASS64
+		extraHeader = wWw-aUtHeNtIcAtE: bEaRer auThoRiTy=\"id.example.com\"
+	EOF
+
+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
+
+	set_credential_reply get <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+
+	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	wwwauth[]=basic realm="example.com"
+	wwwauth[]=bEaRer auThoRiTy="id.example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_expect_success 'http auth www-auth headers to credential helper continuation hdr' '
+	test_when_finished "per_test_cleanup" &&
+	# base64("alice:secret-passwd")
+	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
+	export USERPASS64 &&
+
+	cat >auth.config <<-EOF &&
+	[auth]
+		challenge = "bearer:authority=\"id.example.com\"\\n    q=1\\n \\t p=0"
+		challenge = basic:realm=\"example.com\"
+		token = basic:$USERPASS64
+	EOF
+
+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
+
+	set_credential_reply get <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+
+	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
+	wwwauth[]=basic realm="example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_expect_success 'http auth www-auth headers to credential helper empty continuation hdrs' '
+	test_when_finished "per_test_cleanup" &&
+	# base64("alice:secret-passwd")
+	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
+	export USERPASS64 &&
+
+	cat >auth.config <<-EOF &&
+	[auth]
+		challenge = basic:realm=\"example.com\"
+		token = basic:$USERPASS64
+		extraheader = "WWW-Authenticate:"
+		extraheader = " "
+		extraheader = " bearer authority=\"id.example.com\""
+	EOF
+
+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
+
+	set_credential_reply get <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+
+	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	wwwauth[]=basic realm="example.com"
+	wwwauth[]=bearer authority="id.example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_expect_success 'http auth www-auth headers to credential helper custom schemes' '
+	test_when_finished "per_test_cleanup" &&
+	# base64("alice:secret-passwd")
+	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
+	export USERPASS64 &&
+
+	cat >auth.config <<-EOF &&
+	[auth]
+		challenge = "foobar:alg=test widget=1"
+		challenge = "bearer:authority=\"id.example.com\" q=1 p=0"
+		challenge = basic:realm=\"example.com\"
+		token = basic:$USERPASS64
+	EOF
+
+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
+
+	set_credential_reply get <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+
+	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	wwwauth[]=foobar alg=test widget=1
+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
+	wwwauth[]=basic realm="example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_expect_success 'http auth www-auth headers to credential helper invalid' '
+	test_when_finished "per_test_cleanup" &&
+	# base64("alice:secret-passwd")
+	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
+	export USERPASS64 &&
+
+	cat >auth.config <<-EOF &&
+	[auth]
+		challenge = "bearer:authority=\"id.example.com\" q=1 p=0"
+		challenge = basic:realm=\"example.com\"
+		token = basic:$USERPASS64
+	EOF
+
+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
+
+	set_credential_reply get <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=invalid-passwd
+	EOF
+
+	test_must_fail git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
+	wwwauth[]=basic realm="example.com"
+	EOF
+
+	expect_credential_query erase <<-EOF
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=invalid-passwd
+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
+	wwwauth[]=basic realm="example.com"
+	EOF
+'
+
 test_done
-- 
gitgitgadget
