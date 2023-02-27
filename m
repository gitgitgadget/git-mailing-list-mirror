Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81341C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 17:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjB0RUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 12:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjB0RUa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 12:20:30 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB2F231D7
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 09:20:27 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bt28so7022040wrb.8
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 09:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TdGOn2qYoUQP6nUI/3/lP6ZrWrbbccy9NnfMmJwvJY=;
        b=I45xYcAJuD160NczdKw4ZUmqzaIRWqX+a4R8cy0ymg7BwqYFr2Fb2aSAj/8iYOqso3
         vUyAeGgNI87e+C/4zFv2yKgHTykTB11iOho60/oiGrE84BrPyNUrzcFmICHl1iQkJj4T
         Jlk2E9OcYKulb/UctAwQfIL02V6n0xkNMWhVDyJJ+ggl4btk1q/nlhlebt+l9rjhhxu8
         wY5XIX7dObmLlnsgrwDbZm0322QnGqDYuvjGStu7h6+zQ1Ep/o8+61YUhr+qG8Q+/LUM
         3WTinv9cMe/HDn5GOgR+VQcHdsU+GWC97wK1k9EgaU7ek5jRkksO3wc1oISnxTL2Ul9I
         1ZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TdGOn2qYoUQP6nUI/3/lP6ZrWrbbccy9NnfMmJwvJY=;
        b=yQaO9Ylu/dqjZW2mhwWFDai/JAH5KDR+ruYz//gzSuECraDH7neYGnLU3KXWUD6NA5
         YIlgPb3YWLcvSZ0BuJPwJneTuViIVPqTYzV2/r5xFsVZ7DE7dJHlux1sYZ7cQZiXfTKO
         PLdQsbXP4FeYpXiZjywA4PbWTuGOvdGJrsqqO1czfptVloRk6hLG8AJnJnPMPu5nBbTg
         tbPTN5C6RY7FfCQKODc7p4bfERn6TcfHeHIGtj4Fbcwdcs1g2O/zG9kHCy/qoyTEuivW
         FSJg99TgSrwq5e/SVHoc+kQIQBqnbZNzFgEcrrRRn4lJUYRi+68L1+N+mbfv+jQtG7zF
         gUjg==
X-Gm-Message-State: AO0yUKWk0GhrPfDQpVOUi1alonFmf2f47S8NtkpUpNHg3VXLPZP3HKXw
        YCnRQ3LGfCIxr/0K1thewbhJ+QdfHz0=
X-Google-Smtp-Source: AK7set/D/tD+f7cVKolnigdWPyhZOPy8KKpM1lDp6SNFBB5AuefgxIli44Oz3ptyKP7bRKKfXZBGmw==
X-Received: by 2002:a05:6000:502:b0:2cb:d8f1:1d31 with SMTP id a2-20020a056000050200b002cbd8f11d31mr2631357wrf.18.1677518425053;
        Mon, 27 Feb 2023 09:20:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n33-20020a05600c502100b003e8dc7a03basm13800493wmr.41.2023.02.27.09.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 09:20:24 -0800 (PST)
Message-Id: <b774acf3896c4c1818f48776b1daba0ca6f74df8.1677518420.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v11.git.1677518420.gitgitgadget@gmail.com>
References: <pull.1352.v10.git.1676586881.gitgitgadget@gmail.com>
        <pull.1352.v11.git.1677518420.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Feb 2023 17:20:20 +0000
Subject: [PATCH v11 3/3] credential: add WWW-Authenticate header to cred
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
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
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
 credential.c                     |   3 +
 t/t5563-simple-http-auth.sh      | 242 +++++++++++++++++++++++++++++++
 3 files changed, 263 insertions(+), 1 deletion(-)

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
index 897b4679333..f566c8ab195 100644
--- a/credential.c
+++ b/credential.c
@@ -270,6 +270,9 @@ void credential_write(const struct credential *c, FILE *fp)
 	credential_write_item(fp, "path", c->path, 0);
 	credential_write_item(fp, "username", c->username, 0);
 	credential_write_item(fp, "password", c->password, 0);
+	for (size_t i = 0; i < c->wwwauth_headers.nr; i++)
+		credential_write_item(fp, "wwwauth[]", c->wwwauth_headers.v[i],
+				      0);
 }
 
 static int run_credential_helper(struct credential *c,
diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index bc880bf80f9..ccf7e54b073 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -70,6 +70,248 @@ test_expect_success 'access using basic auth' '
 	expect_credential_query get <<-EOF &&
 	protocol=http
 	host=$HTTPD_DEST
+	wwwauth[]=Basic realm="example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HTTPD_DEST
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_expect_success 'access using basic auth invalid credentials' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	username=baduser
+	password=wrong-passwd
+	EOF
+
+	# Basic base64(alice:secret-passwd)
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	WWW-Authenticate: Basic realm="example.com"
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	test_must_fail git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=Basic realm="example.com"
+	EOF
+
+	expect_credential_query erase <<-EOF
+	protocol=http
+	host=$HTTPD_DEST
+	username=baduser
+	password=wrong-passwd
+	wwwauth[]=Basic realm="example.com"
+	EOF
+'
+
+test_expect_success 'access using basic auth with extra challenges' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	username=alice
+	password=secret-passwd
+	EOF
+
+	# Basic base64(alice:secret-passwd)
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	WWW-Authenticate: FooBar param1="value1" param2="value2"
+	WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
+	WWW-Authenticate: Basic realm="example.com"
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=FooBar param1="value1" param2="value2"
+	wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
+	wwwauth[]=Basic realm="example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HTTPD_DEST
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_expect_success 'access using basic auth mixed-case wwwauth header name' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	username=alice
+	password=secret-passwd
+	EOF
+
+	# Basic base64(alice:secret-passwd)
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	www-authenticate: foobar param1="value1" param2="value2"
+	WWW-AUTHENTICATE: BEARER authorize_uri="id.example.com" p=1 q=0
+	WwW-aUtHeNtIcAtE: baSiC realm="example.com"
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=foobar param1="value1" param2="value2"
+	wwwauth[]=BEARER authorize_uri="id.example.com" p=1 q=0
+	wwwauth[]=baSiC realm="example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HTTPD_DEST
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_expect_success 'access using basic auth with wwwauth header continuations' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	username=alice
+	password=secret-passwd
+	EOF
+
+	# Basic base64(alice:secret-passwd)
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	# Note that leading and trailing whitespace is important to correctly
+	# simulate a continuation/folded header.
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	WWW-Authenticate: FooBar param1="value1"
+	 param2="value2"
+	WWW-Authenticate: Bearer authorize_uri="id.example.com"
+	 p=1
+	 q=0
+	WWW-Authenticate: Basic realm="example.com"
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=FooBar param1="value1" param2="value2"
+	wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
+	wwwauth[]=Basic realm="example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HTTPD_DEST
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_expect_success 'access using basic auth with wwwauth header empty continuations' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	username=alice
+	password=secret-passwd
+	EOF
+
+	# Basic base64(alice:secret-passwd)
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	CHALLENGE="$HTTPD_ROOT_PATH/custom-auth.challenge" &&
+
+	# Note that leading and trailing whitespace is important to correctly
+	# simulate a continuation/folded header.
+	printf "">$CHALLENGE &&
+	printf "WWW-Authenticate: FooBar param1=\"value1\"\r\n" >$CHALLENGE &&
+	printf " \r\n" >>$CHALLENGE &&
+	printf " param2=\"value2\"\r\n" >>$CHALLENGE &&
+	printf "WWW-Authenticate: Bearer authorize_uri=\"id.example.com\"\r\n" >>$CHALLENGE &&
+	printf " p=1\r\n" >>$CHALLENGE &&
+	printf " \r\n" >>$CHALLENGE &&
+	printf " q=0\r\n" >>$CHALLENGE &&
+	printf "WWW-Authenticate: Basic realm=\"example.com\"\r\n" >>$CHALLENGE &&
+
+	test_config_global credential.helper test-helper &&
+	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=FooBar param1="value1" param2="value2"
+	wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
+	wwwauth[]=Basic realm="example.com"
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HTTPD_DEST
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_expect_success 'access using basic auth with wwwauth header mixed line-endings' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	username=alice
+	password=secret-passwd
+	EOF
+
+	# Basic base64(alice:secret-passwd)
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	CHALLENGE="$HTTPD_ROOT_PATH/custom-auth.challenge" &&
+
+	# Note that leading and trailing whitespace is important to correctly
+	# simulate a continuation/folded header.
+	printf "">$CHALLENGE &&
+	printf "WWW-Authenticate: FooBar param1=\"value1\"\r\n" >$CHALLENGE &&
+	printf " \r\n" >>$CHALLENGE &&
+	printf "\tparam2=\"value2\"\r\n" >>$CHALLENGE &&
+	printf "WWW-Authenticate: Basic realm=\"example.com\"" >>$CHALLENGE &&
+
+	test_config_global credential.helper test-helper &&
+	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=FooBar param1="value1" param2="value2"
+	wwwauth[]=Basic realm="example.com"
 	EOF
 
 	expect_credential_query store <<-EOF
-- 
gitgitgadget
