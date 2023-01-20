Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71B6C25B50
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjATWJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjATWJG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:09:06 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A131A314C
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:09:04 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so4662134wms.2
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIBSatUxCSvGNYiN6zTAUA65IC5YxBv/B6yrODjpvhQ=;
        b=jcX+i3hFP/tc3XiSLszpmiH479YqmjHTaYPAEwrpFhKrRVylqMhWe+gReFzek8Tq/a
         UmOaeAdjyJHGvhiIZp804x7zZ+fhbj9VmALBb4NeSAOyqWynriy+d1I8KNOOxLmPrbMQ
         oif5j6GrdFKe03RX4SZkoluA5i1A2pAhkN/gUYpENUqddd8qmGechrpAiF0zYV64i9y+
         xQGNEa+bMAD/si7T7AK4j+L6ufqD8LCxL1J/fQfODrhDuNQcGP0kVaxkCvr3LfY6wV/s
         jf0QbOHSf09WUR4dgYQRLFxAqhlfhVQQuusLm4RDrCU4IIv5A8pqjJK3IhBtHhyNmdOc
         46bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIBSatUxCSvGNYiN6zTAUA65IC5YxBv/B6yrODjpvhQ=;
        b=gwbSU7CP1xxmf8Yo7MmyPs7QsqljdphfiFfnf4gmd+7PJ+gNU/k6N74DVDBff54Q2Z
         tQ8QoEwvjDCQN0JmgkJNdBlPU1KAeG5kkjEtvpVkFvCqgUAG417zyKalNvtchaFXFst1
         hrcmJChRFuE9/vaCLncIyDWyTQ7Gmse73pg/re57+qNqtK0qektIlPo1wIv+2sdCwob2
         xvqOvlt2OJm67HT1EZ1yx92k5rJRRz31b1JZd2bHpCpb6Blq1dhouV8NelC8ZwHSOPSp
         f8jci9PaX90nLUlvAmcU2X3IVOlBbZWfSLUn2Cn/iod63LWBd2d4RCdLrUpN6+vVnfYq
         CYQg==
X-Gm-Message-State: AFqh2kpRLbK2kqpoUjrdaEKgtMiooIRN0uvIt+swTyxwAeGutgL4IzAP
        Zmj/nlue+ubQ2680hf9uneqXiXD5udg=
X-Google-Smtp-Source: AMrXdXv1ZDPoOUurlVuu+Z4Y2ZlpQMaaYPD0WoQi1IDjvQd4oS7tYW1Inlk49O1K3sgQd+BoR+T7JA==
X-Received: by 2002:a05:600c:540c:b0:3cf:7704:50ce with SMTP id he12-20020a05600c540c00b003cf770450cemr15090369wmb.38.1674252542666;
        Fri, 20 Jan 2023 14:09:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7-20020a1c4c07000000b003d9a86a13bfsm3367726wmf.28.2023.01.20.14.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 14:09:02 -0800 (PST)
Message-Id: <09164f77d56e8efd1450091cf1b12af2bc6cf2f5.1674252531.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Jan 2023 22:08:50 +0000
Subject: [PATCH v7 12/12] credential: add WWW-Authenticate header to cred
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
        <avarab@gmail.com>, Matthew John Cheetham <mjcheetham@outlook.com>,
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
 t/t5556-http-auth.sh             | 242 +++++++++++++++++++++++++++++++
 4 files changed, 298 insertions(+), 1 deletion(-)
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
index 2c16c8f72a5..93b7c178da6 100755
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
 run_http_server_worker() {
 	(
 		cd "$REPO_DIR"
@@ -101,6 +104,7 @@ per_test_cleanup () {
 	stop_http_server &&
 	rm -f OUT.* &&
 	rm -f IN.* &&
+	rm -f *.cred &&
 	rm -f auth.config
 }
 
@@ -218,4 +222,242 @@ test_expect_success 'http auth anonymous no challenge' '
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
