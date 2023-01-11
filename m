Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B50C46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 22:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbjAKWOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjAKWNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 17:13:25 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B6D431A6
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:23 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bn26so16444972wrb.0
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SXgnA4M5wKdobtw7SHt2vwTto2ayZwPSP6ipHKss68=;
        b=QvXlavGy82zxzsK4hbA8nNEhz/N8eHA/5N6rBiwwp33pOzyAOhJhhYbulW2Y62F5kj
         +f5EXOqOV6xCOmuE62AZ+ZwZFPMFp4wb0wPgJkxxrdKtVU+XoIFO3HHoAoMjt6b/DnDA
         Jd5gWSdHYSyyq9HKZNN3JxukJITvZtNx2xIW427qPIIbeoWp/zsc+8MveAWLIdvZWu8z
         oaavbKm0iuDoahc7tMI6VBD2+AaDCcby3E5EY6o8WSyAJgPE7y0vH47Knd4ZN8Jzfde0
         PfOpB5X5CQqxc74rz6zh1vwulcjtR2GXnoCuMLPtQO+hvzB910F0Io/8n4X34EA3WmyP
         b3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SXgnA4M5wKdobtw7SHt2vwTto2ayZwPSP6ipHKss68=;
        b=5NESSK6ONGTP8+v1reqaubOoRvfDxzPpQK8XzNAOC4vrBRS7oy3sb6SnTjE1kKuAty
         9N3mBZj45RGCBO649IlfiNxumVhEtoph+1a5ytALQUyiIgoEbv99ZsQn6W3p19YcKvKa
         B/y4RwZzauPlHFO71GEAcimlCcFtZ1vH+MZTmisaAmfqAQ0Mv2BiAbRUIDHF5DoOLBvI
         jTMzbeD07mNeqcl3IVL4w2islDjiBNCO2V5RigPSqgYNelLwLpOT8GScvrSLhHBZnu+Y
         ZdoFNQLGPHtHQJ89i4uJVZEp6UYjQhM1L9T8Utlt2sJAj7ynqClsc1/zAyyn2myxr+o+
         aDnQ==
X-Gm-Message-State: AFqh2koZYJT6hJULd1aGxQRRY6afa1FV4L6AGIBnNMkf5zjuPmPBMxKw
        A6qiavzU0aei/8x2z1bcR2yFhLmAttg=
X-Google-Smtp-Source: AMrXdXu9kkk/s7oCvN6HIOtVEJfLEKA6kNykrhsQ6zy9/gB4L9Dj8ThtqyL1TWlGxAp7/cFyLZC8cw==
X-Received: by 2002:a05:6000:54f:b0:2bc:aa67:28fb with SMTP id b15-20020a056000054f00b002bcaa6728fbmr4998743wrf.49.1673475201975;
        Wed, 11 Jan 2023 14:13:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g1-20020a056000118100b002755e301eeasm14462334wrx.100.2023.01.11.14.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 14:13:21 -0800 (PST)
Message-Id: <af66d2d2ede2a502f32d74c86f302598c68d1476.1673475190.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
        <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Jan 2023 22:13:10 +0000
Subject: [PATCH v5 10/10] credential: add WWW-Authenticate header to cred
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
        Matthew John Cheetham <mjcheetham@github.com>,
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
 Documentation/git-credential.txt          |  19 +-
 credential.c                              |  12 +
 t/helper/test-credential-helper-replay.sh |  14 ++
 t/t5556-http-auth.sh                      | 270 +++++++++++++++++++++-
 4 files changed, 312 insertions(+), 3 deletions(-)
 create mode 100755 t/helper/test-credential-helper-replay.sh

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
index 897b4679333..8a3ad6c0ae2 100644
--- a/credential.c
+++ b/credential.c
@@ -263,6 +263,17 @@ static void credential_write_item(FILE *fp, const char *key, const char *value,
 	fprintf(fp, "%s=%s\n", key, value);
 }
 
+static void credential_write_strvec(FILE *fp, const char *key,
+				    const struct strvec *vec)
+{
+	int i = 0;
+	const char *full_key = xstrfmt("%s[]", key);
+	for (; i < vec->nr; i++) {
+		credential_write_item(fp, full_key, vec->v[i], 0);
+	}
+	free((void*)full_key);
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
diff --git a/t/helper/test-credential-helper-replay.sh b/t/helper/test-credential-helper-replay.sh
new file mode 100755
index 00000000000..03e5e63dad6
--- /dev/null
+++ b/t/helper/test-credential-helper-replay.sh
@@ -0,0 +1,14 @@
+cmd=$1
+teefile=$cmd-actual.cred
+catfile=$cmd-response.cred
+rm -f $teefile
+while read line;
+do
+	if test -z "$line"; then
+		break;
+	fi
+	echo "$line" >> $teefile
+done
+if test "$cmd" = "get"; then
+	cat $catfile
+fi
diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
index 65105a5a6a9..a8dbee6ca40 100755
--- a/t/t5556-http-auth.sh
+++ b/t/t5556-http-auth.sh
@@ -27,6 +27,8 @@ PID_FILE="$TRASH_DIRECTORY"/pid-file.pid
 SERVER_LOG="$TRASH_DIRECTORY"/OUT.server.log
 
 PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
+CREDENTIAL_HELPER="$GIT_BUILD_DIR/t/helper/test-credential-helper-replay.sh" \
+	&& export CREDENTIAL_HELPER
 
 test_expect_success 'setup repos' '
 	test_create_repo "$REPO_DIR" &&
@@ -92,15 +94,279 @@ start_http_server () {
 
 per_test_cleanup () {
 	stop_http_server &&
-	rm -f OUT.*
+	rm -f OUT.* &&
+	rm -f *.cred &&
+	rm -f auth.config
 }
 
 test_expect_success 'http auth anonymous no challenge' '
 	test_when_finished "per_test_cleanup" &&
-	start_http_server &&
+
+	cat >auth.config <<-EOF &&
+	[auth]
+	    allowAnonymous = true
+	EOF
+
+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
 
 	# Attempt to read from a protected repository
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
+	    challenge = basic:realm=\"example.com\"
+	    token = basic:$USERPASS64
+	EOF
+
+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
+
+	cat >get-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	wwwauth[]=basic realm="example.com"
+	EOF
+
+	cat >store-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+
+	cat >get-response.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+
+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
+
+	test_cmp get-expected.cred get-actual.cred &&
+	test_cmp store-expected.cred store-actual.cred
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
+	    challenge = basic:realm=\"example.com\"
+	    token = basic:$USERPASS64
+	    extraHeader = wWw-aUtHeNtIcAtE: bEaRer auThoRiTy=\"id.example.com\"
+	EOF
+
+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
+
+	cat >get-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	wwwauth[]=basic realm="example.com"
+	wwwauth[]=bEaRer auThoRiTy="id.example.com"
+	EOF
+
+	cat >store-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+
+	cat >get-response.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+
+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
+
+	test_cmp get-expected.cred get-actual.cred &&
+	test_cmp store-expected.cred store-actual.cred
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
+	    challenge = "bearer:authority=\"id.example.com\"\\n    q=1\\n \\t p=0"
+	    challenge = basic:realm=\"example.com\"
+	    token = basic:$USERPASS64
+	EOF
+
+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
+
+	cat >get-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
+	wwwauth[]=basic realm="example.com"
+	EOF
+
+	cat >store-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+
+	cat >get-response.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+
+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
+
+	test_cmp get-expected.cred get-actual.cred &&
+	test_cmp store-expected.cred store-actual.cred
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
+	    challenge = basic:realm=\"example.com\"
+	    token = basic:$USERPASS64
+	    extraheader = "WWW-Authenticate:"
+	    extraheader = " "
+	    extraheader = " bearer authority=\"id.example.com\""
+	EOF
+
+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
+
+	cat >get-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	wwwauth[]=basic realm="example.com"
+	wwwauth[]=bearer authority="id.example.com"
+	EOF
+
+	cat >store-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+
+	cat >get-response.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+
+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
+
+	test_cmp get-expected.cred get-actual.cred &&
+	test_cmp store-expected.cred store-actual.cred
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
+	    challenge = "foobar:alg=test widget=1"
+	    challenge = "bearer:authority=\"id.example.com\" q=1 p=0"
+	    challenge = basic:realm=\"example.com\"
+	    token = basic:$USERPASS64
+	EOF
+
+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
+
+	cat >get-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	wwwauth[]=foobar alg=test widget=1
+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
+	wwwauth[]=basic realm="example.com"
+	EOF
+
+	cat >store-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+
+	cat >get-response.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	EOF
+
+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
+
+	test_cmp get-expected.cred get-actual.cred &&
+	test_cmp store-expected.cred store-actual.cred
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
+	    challenge = "bearer:authority=\"id.example.com\" q=1 p=0"
+	    challenge = basic:realm=\"example.com\"
+	    token = basic:$USERPASS64
+	EOF
+
+	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
+
+	cat >get-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
+	wwwauth[]=basic realm="example.com"
+	EOF
+
+	cat >erase-expected.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=invalid-passwd
+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
+	wwwauth[]=basic realm="example.com"
+	EOF
+
+	cat >get-response.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=invalid-passwd
+	EOF
+
+	test_must_fail git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
+
+	test_cmp get-expected.cred get-actual.cred &&
+	test_cmp erase-expected.cred erase-actual.cred
+'
+
 test_done
-- 
gitgitgadget
