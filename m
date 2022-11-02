Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BDCC433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiKBWKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiKBWJr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:09:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC50763DC
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:09:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso2172549wma.1
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 15:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X79s6e7eaS3Rbf+G2seFln3AiezYjtW9yx3brlO1UYI=;
        b=I5vQEKqqaNGTG5NuGzkWxH7tsyJkZOGHuiKg6j0jsz4c/PUqaCOsNZJLldI0Bv2Q/J
         gG3siKqz51+it/Tr0cMELfzBKARALHn9vsF+SsSonTLveYl2juRg3GwU0MVq5t4tl1gm
         tZ/8ILI2SLC3eDTxtIREc9k5RJ0K0//x4h7ak2heZ0tmaDW16/IqnnbU48BRdV+24xuE
         XUpjOVcDRH9AHwxZ9ktDH3MSTUzKerRJ7NLXfg6mTJnzTJpG7tZ7ik3WjDTKrluCNsZP
         3ZjAl2jy5qIlpmhPXl7qbEWiuXODl/6Qp3hOUr/eJM2ElJUGEOJw+yfMlH5jYqa/+YoZ
         CLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X79s6e7eaS3Rbf+G2seFln3AiezYjtW9yx3brlO1UYI=;
        b=JmVyjs1aWni/X6dd9kGRBs0fsgnvDN2kPeWRSiCXv/z0Yrb9X35OrMGaDS1rrEP3Br
         LjfPWGe3ypvNASuB/oEfsAkO/f9jozncYmMdGG8OTSZmxbhFgSKE0GG5tNCR+e1JVD04
         4mLzb0X8te5ZROTSOiOyAr9H3mb0jxfaWVVIZy/iYVlioafutYaS90v9iQYckh71Bf1Q
         vO74nSGSw3EJprezZqpApyrc6PZgvhJLWk5MojpRyskvELZ6XpbW4fkKRYI/kJnXqe8I
         VyLH0ipORrEO3MJCktWd6bP3tkSygM6Ndd9E/FKMjpKXOQvmLHyyM7ub0b2nP9v7QMek
         QLzw==
X-Gm-Message-State: ACrzQf3JPn6CLbpM40YLGRsi6IJuxzPbyZ7Kk93akc8qFVs0G5J9UZK3
        qVuLev2Mi6w7aiAItGr7vjtXzNYHwQo=
X-Google-Smtp-Source: AMsMyM6MWXWLG0FN/kF1PWLlTd4Xwt42YgVRhGYZSPeF5cppO3h5OFm+sJtT5Res2GSfplpNfu0GBw==
X-Received: by 2002:a7b:c8d8:0:b0:3cf:691a:c4b3 with SMTP id f24-20020a7bc8d8000000b003cf691ac4b3mr15713593wml.120.1667426984973;
        Wed, 02 Nov 2022 15:09:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16-20020adff610000000b0023538fb27c1sm13816024wrp.85.2022.11.02.15.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:09:44 -0700 (PDT)
Message-Id: <b64d2f2c473c0b55f79930d0394b1fa8d81af7f3.1667426970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
        <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Nov 2022 22:09:29 +0000
Subject: [PATCH v3 11/11] t5556: add HTTP authentication tests
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
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Add a series of tests to exercise the HTTP authentication header parsing
and the interop with credential helpers. Credential helpers can respond
to requests that contain WWW-Authenticate information with the ability
to select the response Authenticate header scheme.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/helper/test-credential-helper-replay.sh |  14 ++
 t/t5556-http-auth.sh                      | 157 +++++++++++++++++++++-
 2 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100755 t/helper/test-credential-helper-replay.sh

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
index 78da151f122..43f1791a0fe 100755
--- a/t/t5556-http-auth.sh
+++ b/t/t5556-http-auth.sh
@@ -26,6 +26,8 @@ PID_FILE="$(pwd)"/pid-file.pid
 SERVER_LOG="$(pwd)"/OUT.server.log
 
 PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
+CREDENTIAL_HELPER="$GIT_BUILD_DIR/t/helper/test-credential-helper-replay.sh" \
+	&& export CREDENTIAL_HELPER
 
 test_expect_success 'setup repos' '
 	test_create_repo "$REPO_DIR" &&
@@ -91,7 +93,8 @@ start_http_server () {
 
 per_test_cleanup () {
 	stop_http_server &&
-	rm -f OUT.*
+	rm -f OUT.* &&
+	rm -f *.cred
 }
 
 test_expect_success 'http auth anonymous no challenge' '
@@ -102,4 +105,156 @@ test_expect_success 'http auth anonymous no challenge' '
 	git ls-remote $ORIGIN_URL
 '
 
+test_expect_success 'http auth www-auth headers to credential helper bearer valid' '
+	test_when_finished "per_test_cleanup" &&
+	start_http_server \
+		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
+		--auth=basic:realm=\"example.com\" \
+		--auth-token=bearer:secret-token &&
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
+	password=secret-token
+	authtype=bearer
+	EOF
+
+	cat >get-response.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-token
+	authtype=bearer
+	EOF
+
+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
+
+	test_cmp get-expected.cred get-actual.cred &&
+	test_cmp store-expected.cred store-actual.cred
+'
+
+test_expect_success 'http auth www-auth headers to credential helper basic valid' '
+	test_when_finished "per_test_cleanup" &&
+	# base64("alice:secret-passwd")
+	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
+	export USERPASS64 &&
+
+	start_http_server \
+		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
+		--auth=basic:realm=\"example.com\" \
+		--auth-token=basic:$USERPASS64 &&
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
+	authtype=basic
+	EOF
+
+	cat >get-response.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=secret-passwd
+	authtype=basic
+	EOF
+
+	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
+
+	test_cmp get-expected.cred get-actual.cred &&
+	test_cmp store-expected.cred store-actual.cred
+'
+
+test_expect_success 'http auth www-auth headers to credential helper custom scheme' '
+	test_when_finished "per_test_cleanup" &&
+	start_http_server \
+		--auth=foobar:alg=test\ widget=1 \
+		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
+		--auth=basic:realm=\"example.com\" \
+		--auth-token=foobar:SECRET-FOOBAR-VALUE &&
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
+	password=SECRET-FOOBAR-VALUE
+	authtype=foobar
+	EOF
+
+	cat >get-response.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=SECRET-FOOBAR-VALUE
+	authtype=foobar
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
+	start_http_server \
+		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
+		--auth=basic:realm=\"example.com\" \
+		--auth-token=bearer:secret-token &&
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
+	password=invalid-token
+	authtype=bearer
+	wwwauth[]=bearer authority="id.example.com" q=1 p=0
+	wwwauth[]=basic realm="example.com"
+	EOF
+
+	cat >get-response.cred <<-EOF &&
+	protocol=http
+	host=$HOST_PORT
+	username=alice
+	password=invalid-token
+	authtype=bearer
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
