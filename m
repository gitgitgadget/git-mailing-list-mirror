Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB711A2C0B
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253158; cv=none; b=VfHwa0EUuMHLcddQ2jybgyba7X/9XdmxMjRZ4tHi515IfeV6rfvQh3zJb7n49hCfKsaWdabDP98vSu7C4On9/60Xa4v7rLAJBNjikENTm5wG3bFio/5hyWZ7RvsZQ9kNWzeDkh5WMaVVAtKiZhRSJ7E0UActe8+A9PFpztwBG8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253158; c=relaxed/simple;
	bh=kb6eHH+Ctw8mp1iTyPueUWfwTihPlpeVBGdxxGXb0u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpRvBNowpsfv91Hqy/MQSG94ivsZV6+yTEe+FWTkA47Wyarcqqu0+K7HU0sp+tk/u9EvXpntY+K4dxCzaCsDVkii9yghcCypdzn+mP8PZW1Tj3mdQpE3t2vnhzHQlLJ4ZGppLmaJ7P4tlHGiZ90alH07JHML/LoKVLBV6LlarEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPOtcLUs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPOtcLUs"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b94a19fdso2348381f8f.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253154; x=1774857954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0CTZxIhh89gbTeMCQWjqgqzyFSjs2XdExoRQd9GlIM=;
        b=lPOtcLUstZfH3LsnP49FAY4kF5TqpRsVEZp9EuLFzWAI+domBJIUT2gpVMRK7tRln1
         0DricRcF2cAego3Z9FEolQuYCQ7n82ovjyESYuU9zuOjqpN6tyEjZpQ2ZS3e2FL31gDE
         ZQ69w1nUaQ6+d+DCiPtA2U26XgrRqABa7k+HUNdRtWwu/JZeryB2ITvv0JScam3x+1rP
         qWrvxM2xs6fCXbQM/VwSG6SapNRQOoyMK8phCNmo2jFTPX1eFxab10gYb5jd5gV2fEqo
         i470MAlOj8ikRg4aOAV8UXO5/vbxQN8HJkpqmLuhiZxSBl+QgtGch3habPoVW3q86qAP
         gWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253154; x=1774857954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f0CTZxIhh89gbTeMCQWjqgqzyFSjs2XdExoRQd9GlIM=;
        b=KeG3u75JjjI2Zbf6NTlc1PqNX0GNq7JClf+sLQ4Oba3JMOz7jaC96Q/oBWZlSkirp2
         tL2w1L4Ir9TjGqV2ITAGMRyfG97x2LTBiq1G65aiIk/2yfpG4j7meUSZxRcZVfqz0Ams
         DzyeukudJtUXqdxlbwS+8hvWMMoACQ38Kw5FrAne3vFaoFlktJdpMxjKsZuBwhNePMY2
         hjCJDER0RfYhTYt8exg557csqyPR8/NmQjwSyTB7Oyd9Npwh4Qqe38/GwhJyfH377Wa/
         3jt1PzENOv/F/q+TsbKSsIZ2qGNGBERvgOu5AM/PPCQ+gwK6+JdZhKu2QSCXXYOSiYaS
         fVkA==
X-Gm-Message-State: AOJu0Yy6HHaQ3EmRHtTtX/lACNw+wZlancXB+NqugrcTabJiIiYc8vit
	E/OvzqTd6+VfVx3cXLNIBJiBfCkJDOPczNbD9OZ7i5JNoodK9yFlwBbp9KDjvg==
X-Gm-Gg: ATEYQzwpxqcb0rGbSZA0bbbo/umHTG1crjg7ofhbj+P8x/fxofZFRR1Gl7096yzQY++
	T3RNCXQCgoIB7fR3nUvkI5b7CtI1Ds07dXKnmqj2UeN7pgqamNpXtl24qlANXp4Y6KbOIrJot8i
	UTriM0ThM0Nt0ENkiA8YLV+VYoS6j9/ZRkVu1ujKHNOLUu199ywaWIYAGyB/c8FEV+DjsOSy2H/
	LrDqPP7gX0rAQl07PZ5h15xymaI2ResR0UfHhg9ze4irioYwf8U1+Xju0Hqyfsh0BST9zVemFVH
	sU1sNH9AR6nLA0t0ctgAVimaR6J9i3ZxIBFVjal1kCNVWNlyaLGAkCx+lmzz2do1eqgwfcu9UpZ
	B2i6ckdvQwejphmYRTUCE4qqW4e/Rw9wMhs8GK7yCPKoXsRLzvQkNZbgCzrhpWVLVf6rZ9kQNFw
	pRbP5DkQDoTYGfCIBYw7ADpB16EcWF1swFbSJMa1qusgospzdchwRNk271t7Or4W0FyKebPiJkx
	11s+v/scL6hjhprkPwJbA/2dMY+6yFSgYngwR4=
X-Received: by 2002:a05:6000:26c3:b0:43b:3d44:662a with SMTP id ffacd0b85a97d-43b64233db1mr16676983f8f.3.1774253153984;
        Mon, 23 Mar 2026 01:05:53 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm27834067f8f.20.2026.03.23.01.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:05:53 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 12/16] t5710: use proper file:// URIs for absolute paths
Date: Mon, 23 Mar 2026 09:05:15 +0100
Message-ID: <20260323080520.887550-13-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.625.g20f70b52bb
In-Reply-To: <20260323080520.887550-1-christian.couder@gmail.com>
References: <20260323080520.887550-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In t5710, we frequently construct local file URIs using `file://$(pwd)`.
On Unix-like systems, $(pwd) returns an absolute path starting with a
slash (e.g., `/tmp/repo`), resulting in a valid 3-slash URI with an
empty host (`file:///tmp/repo`).

However, on Windows, $(pwd) returns a path starting with a drive
letter (e.g., `D:/a/repo`). This results in a 2-slash URI
(`file://D:/a/repo`). Standard URI parsers misinterpret this format,
treating `D:` as the host rather than part of the absolute path.

While this hasn't broken the existing tests (because the old
`promisor.acceptFromServer` logic relies entirely on strict `strcmp`
without normalizing the URLs), it will break future commits that pass
these URLs through `url_normalize()`.

To future-proof the tests and ensure cross-platform URI compliance,
let's introduce a $PWD_URL helper that explicitly guarantees a leading
slash for the path component, ensuring valid 3-slash `file:///` URIs on
all operating systems.

While at it, let's also introduce $ENCODED_PWD_URL to handle spaces in
directory paths (which is needed for URL glob pattern matching).

Then let's replace all instances of `file://$(pwd)` with $PWD_URL across
the test script, and let's simplify the `ENCODED_URL` constructions in
the `sendFields` and `checkFields` tests to use $ENCODED_PWD_URL
directly.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t5710-promisor-remote-capability.sh | 55 ++++++++++++++++-----------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 357822c01a..c7a484228f 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -76,6 +76,17 @@ copy_to_lop () {
 	cp "$path" "$path2"
 }
 
+# On Windows, 'pwd' returns a path like 'D:/foo/bar'. Prepend '/' to turn
+# it into '/D:/foo/bar', which is what git expects in file:// URLs on Windows.
+# On Unix, the path already starts with '/', so this is a no-op.
+pwd_path=$(pwd)
+case "$pwd_path" in
+[a-zA-Z]:*) pwd_path="/$pwd_path" ;;
+esac
+PWD_URL="file://$pwd_path"
+# Same as PWD_URL but with spaces percent-encoded, for use in URL patterns.
+ENCODED_PWD_URL="file://$(echo "$pwd_path" | sed "s/ /%20/g")"
+
 test_expect_success "setup for testing promisor remote advertisement" '
 	# Create another bare repo called "lop" (for Large Object Promisor)
 	git init --bare lop &&
@@ -88,7 +99,7 @@ test_expect_success "setup for testing promisor remote advertisement" '
 	initialize_server 1 "$oid" &&
 
 	# Configure lop as promisor remote for server
-	git -C server remote add lop "file://$(pwd)/lop" &&
+	git -C server remote add lop "$PWD_URL/lop" &&
 	git -C server config remote.lop.promisor true &&
 
 	git -C lop config uploadpack.allowFilter true &&
@@ -104,7 +115,7 @@ test_expect_success "clone with promisor.advertise set to 'true'" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=All \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -119,7 +130,7 @@ test_expect_success "clone with promisor.advertise set to 'false'" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=All \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -137,7 +148,7 @@ test_expect_success "clone with promisor.acceptfromserver set to 'None'" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=None \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -156,8 +167,8 @@ test_expect_success "init + fetch with promisor.advertise set to 'true'" '
 	git -C client init &&
 	git -C client config remote.lop.promisor true &&
 	git -C client config remote.lop.fetch "+refs/heads/*:refs/remotes/lop/*" &&
-	git -C client config remote.lop.url "file://$(pwd)/lop" &&
-	git -C client config remote.server.url "file://$(pwd)/server" &&
+	git -C client config remote.lop.url "$PWD_URL/lop" &&
+	git -C client config remote.server.url "$PWD_URL/server" &&
 	git -C client config remote.server.fetch "+refs/heads/*:refs/remotes/server/*" &&
 	git -C client config promisor.acceptfromserver All &&
 	GIT_NO_LAZY_FETCH=0 git -C client fetch --filter="blob:limit=5k" server &&
@@ -173,7 +184,7 @@ test_expect_success "clone with promisor.acceptfromserver set to 'KnownName'" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=KnownName \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -188,7 +199,7 @@ test_expect_success "clone with 'KnownName' and different remote names" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.serverTwo.promisor=true \
 		-c remote.serverTwo.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.serverTwo.url="file://$(pwd)/lop" \
+		-c remote.serverTwo.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=KnownName \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -225,7 +236,7 @@ test_expect_success "clone with promisor.acceptfromserver set to 'KnownUrl'" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=KnownUrl \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -242,7 +253,7 @@ test_expect_success "clone with 'KnownUrl' and different remote urls" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/serverTwo" \
+		-c remote.lop.url="$PWD_URL/serverTwo" \
 		-c promisor.acceptfromserver=KnownUrl \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -257,7 +268,7 @@ test_expect_success "clone with 'KnownUrl' and url not configured on the server"
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
 
-	test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
+	test_when_finished "git -C server config set remote.lop.url \"$PWD_URL/lop\"" &&
 	git -C server config unset remote.lop.url &&
 
 	# Clone from server to create a client
@@ -266,7 +277,7 @@ test_expect_success "clone with 'KnownUrl' and url not configured on the server"
 	# missing, so the remote name will be used instead which will fail.
 	test_must_fail env GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=KnownUrl \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -278,7 +289,7 @@ test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
 
-	test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
+	test_when_finished "git -C server config set remote.lop.url \"$PWD_URL/lop\"" &&
 	git -C server config set remote.lop.url "" &&
 
 	# Clone from server to create a client
@@ -287,7 +298,7 @@ test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
 	# so the remote name will be used instead which will fail.
 	test_must_fail env GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=KnownUrl \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -311,13 +322,12 @@ test_expect_success "clone with promisor.sendFields" '
 	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
 		-c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=All \
 		--no-local --filter="blob:limit=5k" server client &&
 
 	# Check that fields are properly transmitted
-	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
-	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
+	PR1="name=lop,url=$ENCODED_PWD_URL/lop,partialCloneFilter=blob:none" &&
 	PR2="name=otherLop,url=https://invalid.invalid,partialCloneFilter=blob:limit=10k,token=fooBar" &&
 	test_grep "clone< promisor-remote=$PR1;$PR2" trace &&
 	test_grep "clone> promisor-remote=lop;otherLop" trace &&
@@ -342,15 +352,14 @@ test_expect_success "clone with promisor.checkFields" '
 	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
 		-c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c remote.lop.partialCloneFilter="blob:none" \
 		-c promisor.acceptfromserver=All \
 		-c promisor.checkFields=partialcloneFilter \
 		--no-local --filter="blob:limit=5k" server client &&
 
 	# Check that fields are properly transmitted
-	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
-	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
+	PR1="name=lop,url=$ENCODED_PWD_URL/lop,partialCloneFilter=blob:none" &&
 	PR2="name=otherLop,url=https://invalid.invalid,partialCloneFilter=blob:limit=10k,token=fooBar" &&
 	test_grep "clone< promisor-remote=$PR1;$PR2" trace &&
 	test_grep "clone> promisor-remote=lop" trace &&
@@ -380,7 +389,7 @@ test_expect_success "clone with promisor.storeFields=partialCloneFilter" '
 	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
 		-c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c remote.lop.token="fooYYY" \
 		-c remote.lop.partialCloneFilter="blob:none" \
 		-c promisor.acceptfromserver=All \
@@ -432,7 +441,7 @@ test_expect_success "clone and fetch with --filter=auto" '
 
 	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
 		-c remote.lop.promisor=true \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=All \
 		--no-local --filter=auto server client 2>err &&
 
@@ -489,7 +498,7 @@ test_expect_success "clone with promisor.advertise set to 'true' but don't delet
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=All \
 		--no-local --filter="blob:limit=5k" server client &&
 
-- 
2.53.0.625.g20f70b52bb

