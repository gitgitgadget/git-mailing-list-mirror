Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC5712E58
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709373481; cv=none; b=dFVObbrGKlECom9NufTGQTwhulC97EG876pgMcfte0o6tIoIo+eqrxsqShjozx+Fuqvep4yYGXNH5iKJO70BUxV9mq9wf8JdMGRqUXfIu7WZvmJUFHB7gaN03xnjmKyjoBOOvM7XqviU/9SqnAwBjrUyu3frCdf8yW1Okq2rQWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709373481; c=relaxed/simple;
	bh=8TskW4uwpX02HUIQtnlWjXiP2Pcx/8WHLrZbXlQ4g6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQJsGGZ0MUTje6WlwwGlw65k03iaZ3hcBNSn01ZjN3bxFzU5l/jjiy/rgMGfe3nodL48TyZZfYMMH1tIk8yPwFTPU7KCZtCe+IIQrGm7Dt/nP6gJogoZfv125Fa7iHcUjcNjEyptvN01km83SaJdZu4CKSJ3yhBSbH7iIhzEqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHwqkQXe; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHwqkQXe"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so503876566b.0
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 01:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709373477; x=1709978277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkCOicRitwdj1WoSbtBAOQFj9VVvtAlnumdAohx+DRM=;
        b=aHwqkQXecOIn4zCVwGUdDpnUzBP6Iqx6kIMSq+D+fSeuPCDaa/LfmRW3qm/ZPbr7s0
         e79CH5RebMOmDHi6q4loAIOSxgre8DYxQ7n8zQjwkIUQPD2xVV0WMgmgB06+g679ZyuG
         cYA5gFysnhvNYACp9v7dzpK3lcAVZKF+303Qd7HnqS/a8XerWbVGEh8mYlgf76Z3Fw7a
         OiapNsj3jy9LMzaTPVHC2JPBbW+MLSmQyfXbeuZiUJ/vDxlLYGdbPyBizMav7Dcna0Mi
         scNjZgLlv+EqzpWzb9cJZxN54+enp6YwcXj9DYKmaQzZIbvf8K1V4KAKkO7S4goAlkYe
         H91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709373477; x=1709978277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkCOicRitwdj1WoSbtBAOQFj9VVvtAlnumdAohx+DRM=;
        b=kp4zKBbrSohiiFS9CtCUeCXtgjYJecQF9qoyW4HMOTWx0x5b433G93dp+e6MNS8xpf
         pBXeLr1RtVyWOtoiU/1/jCghmRYWGq2/AYEiD2J/oPljZR2DG5ZvnLe5I/YaTQ4wR5nP
         l9AcI2QmI5Hu0cOgnHzIiHn+5XXs5JQCIjM3DIVN0ytLG/hnPdnIo5GtUsBMXMp55zBv
         0gPhMGN4dC58elLeUYucJsRgia+wzEA8O+nNWI8sluPoxBgKBmx9EXB0hdFjfL7qghyA
         zZTTYSp7L06H01PzNyhY9/SINvSl1SF45zWZPLbLn9ViLxgUj1bNkZRSc3UwFuFPtqm7
         8gqw==
X-Gm-Message-State: AOJu0YzJVIhh0Npy8fM9/ev8CVpAmamLLhlwZagdNetNsVGM4hO6hllp
	WjTy04bytcs6zGCBU2IKcXZIfD1YbDEQURzft50RkNCNNkP6WraA
X-Google-Smtp-Source: AGHT+IFK6ZTnTPQABSrardPVb30EZiGspH30JWnW1lb+9xkA1AFTl3Rn3nAzcFFzzSxYCXYhg4GqrQ==
X-Received: by 2002:a17:906:264b:b0:a43:d1a5:e907 with SMTP id i11-20020a170906264b00b00a43d1a5e907mr2861491ejc.58.1709373477085;
        Sat, 02 Mar 2024 01:57:57 -0800 (PST)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:f403:1f77:2b7e:2436])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090608c900b00a42f36174c7sm2555693eje.92.2024.03.02.01.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 01:57:56 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: oliver@schinagl.nl
Cc: git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 1/2] t4034: extract out `diff_with_opts`
Date: Sat,  2 Mar 2024 10:57:50 +0100
Message-ID: <20240302095751.123138-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240302095751.123138-1-karthik.188@gmail.com>
References: <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
 <20240302095751.123138-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current `word_diff` function in t4034 uses the arguments provided to
obtain the diff and compare them.

Let's rename this to `diff_with_opts` and add a new function `word_diff`
which is specific to the `--word-diff=` option. This function will act
as a wrapper around `diff_with_opts`.

In the following commit, when we introduce a config option for
`--word-diff`, we'd want to test the existing tests also with the config
option and at this point we can expand `word_diff` to test both config
and command line options.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t4034-diff-words.sh | 54 +++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 74586f3813..4f70aa6e9f 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -51,7 +51,7 @@ cat >expect.non-whitespace-is-word <<-EOF
 	<GREEN>aeff = aeff * ( aaa )<RESET>
 EOF
 
-word_diff () {
+diff_with_opts () {
 	pre=$(git rev-parse --short $(git hash-object pre)) &&
 	post=$(git rev-parse --short $(git hash-object post)) &&
 	test_must_fail git diff --no-index "$@" pre post >output &&
@@ -60,6 +60,10 @@ word_diff () {
 	test_cmp expected output.decrypted
 }
 
+word_diff () {
+	diff_with_opts "--word-diff=$1" $(echo "$@" | cut -d' ' -s -f 2-)
+}
+
 test_language_driver () {
 	lang=$1
 	test_expect_success "diff driver '$lang'" '
@@ -67,11 +71,11 @@ test_language_driver () {
 			"$TEST_DIRECTORY/t4034/'"$lang"'/post" \
 			"$TEST_DIRECTORY/t4034/'"$lang"'/expect" . &&
 		echo "* diff='"$lang"'" >.gitattributes &&
-		word_diff --color-words
+		diff_with_opts --color-words
 	'
 	test_expect_success "diff driver '$lang' in Islandic" '
 		LANG=is_IS.UTF-8 LANGUAGE=is LC_ALL="$is_IS_locale" \
-		word_diff --color-words
+		diff_with_opts --color-words
 	'
 }
 
@@ -81,7 +85,7 @@ test_expect_success setup '
 	git config diff.color.func magenta
 '
 
-test_expect_success 'set up pre and post with runs of whitespace' '
+test_expect_success 'setup pre and post with runs of whitespace' '
 	cp pre.simple pre &&
 	cp post.simple post
 '
@@ -101,9 +105,9 @@ test_expect_success 'word diff with runs of whitespace' '
 
 		<GREEN>aeff = aeff * ( aaa )<RESET>
 	EOF
-	word_diff --color-words &&
-	word_diff --word-diff=color &&
-	word_diff --color --word-diff=color
+	diff_with_opts --color-words &&
+	word_diff color &&
+	diff_with_opts --color --word-diff=color
 '
 
 test_expect_success '--word-diff=porcelain' '
@@ -127,7 +131,7 @@ test_expect_success '--word-diff=porcelain' '
 		+aeff = aeff * ( aaa )
 		~
 	EOF
-	word_diff --word-diff=porcelain
+	word_diff porcelain
 '
 
 test_expect_success '--word-diff=plain' '
@@ -145,8 +149,8 @@ test_expect_success '--word-diff=plain' '
 
 		{+aeff = aeff * ( aaa )+}
 	EOF
-	word_diff --word-diff=plain &&
-	word_diff --word-diff=plain --no-color
+	diff_with_opts --word-diff=plain &&
+	word_diff plain --no-color
 '
 
 test_expect_success '--word-diff=plain --color' '
@@ -164,7 +168,7 @@ test_expect_success '--word-diff=plain --color' '
 
 		<GREEN>{+aeff = aeff * ( aaa )+}<RESET>
 	EOF
-	word_diff --word-diff=plain --color
+	word_diff plain --color
 '
 
 test_expect_success 'word diff without context' '
@@ -181,17 +185,17 @@ test_expect_success 'word diff without context' '
 
 		<GREEN>aeff = aeff * ( aaa )<RESET>
 	EOF
-	word_diff --color-words --unified=0
+	diff_with_opts --color-words --unified=0
 '
 
 test_expect_success 'word diff with a regular expression' '
 	cp expect.letter-runs-are-words expect &&
-	word_diff --color-words="[a-z]+"
+	diff_with_opts --color-words="[a-z]+"
 '
 
 test_expect_success 'word diff with zero length matches' '
 	cp expect.letter-runs-are-words expect &&
-	word_diff --color-words="[a-z${LF}]*"
+	diff_with_opts --color-words="[a-z${LF}]*"
 '
 
 test_expect_success 'set up a diff driver' '
@@ -204,12 +208,12 @@ test_expect_success 'set up a diff driver' '
 
 test_expect_success 'option overrides .gitattributes' '
 	cp expect.letter-runs-are-words expect &&
-	word_diff --color-words="[a-z]+"
+	diff_with_opts --color-words="[a-z]+"
 '
 
 test_expect_success 'use regex supplied by driver' '
 	cp expect.non-whitespace-is-word expect &&
-	word_diff --color-words
+	diff_with_opts --color-words
 '
 
 test_expect_success 'set up diff.wordRegex option' '
@@ -218,7 +222,7 @@ test_expect_success 'set up diff.wordRegex option' '
 
 test_expect_success 'command-line overrides config' '
 	cp expect.letter-runs-are-words expect &&
-	word_diff --color-words="[a-z]+"
+	diff_with_opts --color-words="[a-z]+"
 '
 
 test_expect_success 'command-line overrides config: --word-diff-regex' '
@@ -236,12 +240,12 @@ test_expect_success 'command-line overrides config: --word-diff-regex' '
 
 		<GREEN>{+aeff = aeff * ( aaa+}<RESET> )
 	EOF
-	word_diff --color --word-diff-regex="[a-z]+"
+	diff_with_opts --color --word-diff-regex="[a-z]+"
 '
 
 test_expect_success '.gitattributes override config' '
 	cp expect.non-whitespace-is-word expect &&
-	word_diff --color-words
+	diff_with_opts --color-words
 '
 
 test_expect_success 'setup: remove diff driver regex' '
@@ -263,7 +267,7 @@ test_expect_success 'use configured regex' '
 
 		<GREEN>aeff = aeff * ( aaa<RESET> )
 	EOF
-	word_diff --color-words
+	diff_with_opts --color-words
 '
 
 test_expect_success 'test parsing words for newline' '
@@ -279,7 +283,7 @@ test_expect_success 'test parsing words for newline' '
 		<CYAN>@@ -1 +1 @@<RESET>
 		aaa (aaa) <GREEN>aaa<RESET>
 	EOF
-	word_diff --color-words="a+"
+	diff_with_opts --color-words="a+"
 '
 
 test_expect_success 'test when words are only removed at the end' '
@@ -295,7 +299,7 @@ test_expect_success 'test when words are only removed at the end' '
 		<CYAN>@@ -1 +1 @@<RESET>
 		(<RED>:<RESET>
 	EOF
-	word_diff --color-words=.
+	diff_with_opts --color-words=.
 '
 
 test_expect_success '--word-diff=none' '
@@ -312,7 +316,7 @@ test_expect_success '--word-diff=none' '
 		-(:
 		+(
 	EOF
-	word_diff --word-diff=plain --word-diff=none
+	word_diff plain --word-diff=none
 '
 
 test_expect_success 'unset default driver' '
@@ -363,7 +367,7 @@ test_expect_success 'word-diff with diff.sbe' '
 	[-b-]{+c+}
 	EOF
 	test_config diff.suppress-blank-empty true &&
-	word_diff --word-diff=plain
+	word_diff plain
 '
 
 test_expect_success 'word-diff with no newline at EOF' '
@@ -379,7 +383,7 @@ test_expect_success 'word-diff with no newline at EOF' '
 	@@ -1 +1 @@
 	a a [-a-]{+ab+} a a
 	EOF
-	word_diff --word-diff=plain
+	word_diff plain
 '
 
 test_expect_success 'setup history with two files' '
-- 
2.43.GIT

