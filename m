Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93093630A8
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113615; cv=none; b=XWI6mnGen19w7OY5bOyD2tQo3kvgoUNSk0OPoqmV96/xitentuT7evwpG8ow5UywFNxehs+pU1FgBxVMe0nHYQygP1aYfg9OdVf9Sj1bPIdfJzGNP1ReHyMgW4ZJZmFuoGp5c/B6WtnuCYsEC/Rj0SdnqRELRHirEYOodnmbI1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113615; c=relaxed/simple;
	bh=J/FF/O9zzSGSBopAJN1xJbirmLVrQ/qe8aH/qgMcq9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKZJ4gtzijm8ovMfqL2fI/ZjK7WD8TqDPkpBMetFK2Epak758KrkgkBslxrDlJsWwRzHda5v9Cyiglud2HZP2/PGYIEhd/1ru2arIKvUDtbLCp20Ez5R7UqNhBrPiCwHUiJ2VdthkatxYogmjii2FOQfTe0sIVLb5hin6CwySpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGL8EGZw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGL8EGZw"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486b96760easo5484935e9.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 00:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775113609; x=1775718409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHqpOpNyZBW9bO6t3jyi5HmmShSlj1tJdCFE3PfLQLY=;
        b=nGL8EGZwTpSpoRb2zSX6B5BfR8fagdO34zUmeFWP2AHVprEoC9+DAudP7BmfSgIcON
         W5mNWCPf1XGKEwJVN0Q2EaFhzEIle6QhnL3aN19iTtXXznWD0R6mEkogawC7Sg8gjg7l
         5cpNTLWziyQfmA8KRMshJB0VocBvEUASirs9JUVMBMCI8zAIiHa6FWfCyMFVPZqcRmza
         19n5p4c2ms0OVzjYbnQnrEbB0gjojUul/24SjLZLUQCfK3QYkJzkCDB8aFuVAjv5RPGQ
         29gHqnNBF0KChnYQRPWIIuuB4/5AiM6XU5dzCgwl19U7W0Dz5aizNqaHhlNbLT/yRdwZ
         lGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113609; x=1775718409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CHqpOpNyZBW9bO6t3jyi5HmmShSlj1tJdCFE3PfLQLY=;
        b=dkD9eh+i0mhj7616AXMVOTwweTLJBFf8dja0pdultgJ0i1OYmqvSANIngim71eapRM
         EHYozaT2kEJ9YnUUfTJ7Lt5CEv56HNFfMGmGwfehtS7cT4+vhwMy2Zw9JZ/AQFekDh9O
         3xZecaud87U9S9bkPdOuHrjZrmKYY6CIbdMKkSqY2Z0B1HfotYEIVZAfwICsaRJuceaj
         vCHxcTuNfUliGCmHb8I0pRUdLsgCHhxDbzNjKfVqg3aXyd7zU/lPjSy9ZwUgQ5x3BieM
         KyyQWbScmjf38TdiSt4mLn69bwT/y4euPIl1TJiIU0mUSegWJ75dLqeQHg2S7kVVH5uk
         tJag==
X-Gm-Message-State: AOJu0YxFymv+4+rZ459yplQqf+v3/bJgJtp3tCoJ26/WwEzoePFGKY5V
	hiDCexhbcv3t/6bjRDTk+JwukCSZXCNQvJI/5eYkuu0h+fA4Gl3ZoA+3fMRdzw==
X-Gm-Gg: ATEYQzz4hHet0m9owCJWHdYGqoIeAZ7YnUnqZ1mjwLFzJJSR9IPgVM9UpIHv+DPKzhX
	9sKU+9V3MnklGAz9IuJuvIT4ra12JfiJsi4AnLASnzREbcSolV/0oCjDq3i/PIyKnj6CpcYn5l1
	Dtb2anEjYQ+g6qdmYpEcDMvAamZcJOvT1L+qk3bE/aYvNhF9GrRnqY6rMBa254VdS7jbEccX05h
	Cn/AyixEUDb7ZQwAEYF60SL4KfwLGfoCJ90mJ9HisByz7qa3POhugrp0OJ5qqwN5x1GzGRFPgus
	Gz2qSvD/WZZsQ3IsYVGiwViIpQgfQra7dslsTwmri8wOlFHuDrLPSmJiM6x/VFXnvFZhvgEzcW6
	LmmPotfF99ZIVHkR2WUOY01Pefg9BUbanGRQEMbtzPPtxSqdf03JiadNvadDgpTdPBQJScXE7HJ
	oLwE+goC7qxD7HLSi6GEiGUvpGXKeP22t6MYP1R85+IKcOvAXKgC8zvzHCOsr5YjgrFzocJuEdb
	QTv9TjEY7EBa4JDU3LAGir1Yik0jTxMcYEa6aY=
X-Received: by 2002:a05:600c:45d2:b0:487:169:9f64 with SMTP id 5b1f17b1804b1-48883563408mr107125315e9.12.1775113609121;
        Thu, 02 Apr 2026 00:06:49 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8bc9dcsm101916335e9.6.2026.04.02.00.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:06:47 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 10/10] t5710: use proper file:// URIs for absolute paths
Date: Thu,  2 Apr 2026 09:06:13 +0200
Message-ID: <20260402070613.85934-11-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.765.g57b94de1f0.dirty
In-Reply-To: <20260402070613.85934-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
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

This is to be expected because RFC 8089 says that the `//` prefix with
an empty local host must be followed by an absolute path starting with
a slash.

While this hasn't broken the existing tests (because the old
`promisor.acceptFromServer` logic relies entirely on strict `strcmp()`
without normalizing the URLs), it will break future commits that pass
these URLs through `url_normalize()` or similar functions.

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
index bf0eed9f10..3eca6601ca 100755
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
@@ -242,7 +253,7 @@ test_expect_success "clone with promisor.acceptfromserver set to 'KnownName'" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=KnownName \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -257,7 +268,7 @@ test_expect_success "clone with 'KnownName' and different remote names" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.serverTwo.promisor=true \
 		-c remote.serverTwo.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.serverTwo.url="file://$(pwd)/lop" \
+		-c remote.serverTwo.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=KnownName \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -294,7 +305,7 @@ test_expect_success "clone with promisor.acceptfromserver set to 'KnownUrl'" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=KnownUrl \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -311,7 +322,7 @@ test_expect_success "clone with 'KnownUrl' and different remote urls" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/serverTwo" \
+		-c remote.lop.url="$PWD_URL/serverTwo" \
 		-c promisor.acceptfromserver=KnownUrl \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -326,7 +337,7 @@ test_expect_success "clone with 'KnownUrl' and url not configured on the server"
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
 
-	test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
+	test_when_finished "git -C server config set remote.lop.url \"$PWD_URL/lop\"" &&
 	git -C server config unset remote.lop.url &&
 
 	# Clone from server to create a client
@@ -335,7 +346,7 @@ test_expect_success "clone with 'KnownUrl' and url not configured on the server"
 	# missing, so the remote name will be used instead which will fail.
 	test_must_fail env GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=KnownUrl \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -347,7 +358,7 @@ test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
 
-	test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
+	test_when_finished "git -C server config set remote.lop.url \"$PWD_URL/lop\"" &&
 	git -C server config set remote.lop.url "" &&
 
 	# Clone from server to create a client
@@ -356,7 +367,7 @@ test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
 	# so the remote name will be used instead which will fail.
 	test_must_fail env GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=KnownUrl \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -380,13 +391,12 @@ test_expect_success "clone with promisor.sendFields" '
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
@@ -411,15 +421,14 @@ test_expect_success "clone with promisor.checkFields" '
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
@@ -449,7 +458,7 @@ test_expect_success "clone with promisor.storeFields=partialCloneFilter" '
 	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
 		-c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c remote.lop.token="fooYYY" \
 		-c remote.lop.partialCloneFilter="blob:none" \
 		-c promisor.acceptfromserver=All \
@@ -501,7 +510,7 @@ test_expect_success "clone and fetch with --filter=auto" '
 
 	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
 		-c remote.lop.promisor=true \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=All \
 		--no-local --filter=auto server client 2>err &&
 
@@ -558,7 +567,7 @@ test_expect_success "clone with promisor.advertise set to 'true' but don't delet
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$PWD_URL/lop" \
 		-c promisor.acceptfromserver=All \
 		--no-local --filter="blob:limit=5k" server client &&
 
-- 
2.53.0.765.g57b94de1f0.dirty

