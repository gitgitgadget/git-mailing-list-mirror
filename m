Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E05C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiLLVhH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiLLVgg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:36:36 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85685140C6
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:36:35 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg10so6807205wmb.1
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtFGJSzuLCu7fgCvtvMWmTU5Ym8iaMyfw6igubjubJs=;
        b=icRxobRd+HQ4IhpTJGe4rHtFUAdIqP60j3ALmoNVcvBqL489vvI4+wsVPLkas6Lkxu
         2gWUvK8Qj7oEdjsvOpQ5ElDlUldUKs5iIUmM/2uRmrM2XtslKWyJfYjRQB9bz9OaVH6x
         ZrhnbKVIeSmAGlPwkjvXEOklVdW061fzgnpxzLJ7auJM/NgrCKbz+/cnvCEK8dOoMmd4
         W/I69BWsYroqRWQd0wHM/dLopR2KuL48Ieixmqng/LxIQFovgL2cWGcP8FkQxkgcGUbs
         p7SmxVDnrZ2YgOsAJ37aUUht6cOk+kdW8hJcC36JU+3SYaiASZcJJjsyEHHFU8JknKVK
         m+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtFGJSzuLCu7fgCvtvMWmTU5Ym8iaMyfw6igubjubJs=;
        b=w34w5PsNh4MubOfXNgv1Zunipq2ZeD9MY2XVlsqao8h1BL7WlKvNwR0Wfm8PeQr42n
         hUT31nQkoYWh78XEh1jaIZLVUlb6Oe/UzxqQcY3j74qATgzHoYqH0FoCj2l7s43wjKTq
         JjXkzuWCkXBadi/husbVs0Cspu9rPlPvHckdZIesuQT602S4XhJx9+Z2Yg+WPdfJpg4C
         d+GNfpPhC4ccgt5Xd7PF7CcFKmY8F8p+h4Y/+Ax0r6pc3xi2/PsVHY9ysbbNYapExH7z
         9k47ClhVs6nKotI7ji7iaBBM1ePJ/xgXQqRWHGqsFIA5BCjRyIQd7rrH+H1RVy1XD1Yh
         si5g==
X-Gm-Message-State: ANoB5plvWlhoyBnsXvFsexM32BlJ7rV0GCiaja7v/qz5YzEt5s/DWUKM
        fsKsu9lU/qL+gY9lOZLJOA2dbl0AGes=
X-Google-Smtp-Source: AA0mqf79HxnflozjepUx43xXE0woc3TVCXp3jIDLzH3oejRXi6AlXpg8Q4oAMlr/n9Ddw3Gex0Tsbw==
X-Received: by 2002:a1c:f614:0:b0:3cf:5502:8a0 with SMTP id w20-20020a1cf614000000b003cf550208a0mr13825712wmc.27.1670880993935;
        Mon, 12 Dec 2022 13:36:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c66-20020a1c3545000000b003d09150b339sm10745457wma.20.2022.12.12.13.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:36:33 -0800 (PST)
Message-Id: <8ecf63835229676677e3f7e33f634eb5d3a568b7.1670880984.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
        <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 21:36:23 +0000
Subject: [PATCH v4 8/8] t5556: add HTTP authentication tests
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
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Add a series of tests to exercise the HTTP authentication header parsing
and the interop with credential helpers. Credential helpers will receive
WWW-Authenticate information in credential requests.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/helper/test-credential-helper-replay.sh |  14 +++
 t/t5556-http-auth.sh                      | 120 +++++++++++++++++++++-
 2 files changed, 133 insertions(+), 1 deletion(-)
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
index 78da151f122..541fa32bd77 100755
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
@@ -102,4 +105,119 @@ test_expect_success 'http auth anonymous no challenge' '
 	git ls-remote $ORIGIN_URL
 '
 
+test_expect_success 'http auth www-auth headers to credential helper basic valid' '
+	test_when_finished "per_test_cleanup" &&
+	# base64("alice:secret-passwd")
+	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
+	export USERPASS64 &&
+
+	start_http_server \
+		--auth=basic:realm=\"example.com\" \
+		--auth-token=basic:$USERPASS64 &&
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
+test_expect_success 'http auth www-auth headers to credential helper custom schemes' '
+	test_when_finished "per_test_cleanup" &&
+	# base64("alice:secret-passwd")
+	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
+	export USERPASS64 &&
+
+	start_http_server \
+		--auth=foobar:alg=test\ widget=1 \
+		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
+		--auth=basic:realm=\"example.com\" \
+		--auth-token=basic:$USERPASS64 &&
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
