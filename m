Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED23AEF37
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562802; cv=none; b=ggWNi+klCP2Ri0FLvKXHj2UcWNRpR8I0pmC26WixS88C9eX5HFiger9aXh1raYcpYxd5COCvlNtOwZvThwU73mJubpjwn1rQp6sJLh/j7HNSE5mpy3sX2w3CmKdZRDtdxQ18rV7/Y71YmHOHCPCje96k0ROSJ6/wbtC4gs+iyPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562802; c=relaxed/simple;
	bh=IQs2ULzTo9w6LJYN57ROze+wG73rlqmFFi6s6e/w5wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPV9yTERvK1cWAwNz9WBIcgfipl5pIPG0b5XOjfe6PjjPx/tiP2ct7g3Qd/YVehYiYGnB5JQS/zxiNLHnoNsUOMVBIJLY7DqgIKhayOT77IlnizG8bgpOTPyixoxCWL7xa62uHYBzy2OTv4y0DpDgWYVnEtyqZwcCccdyh6DsVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjnbD7qd; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjnbD7qd"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cfb723793so3165655f8f.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 04:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775562794; x=1776167594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cyw7QeV5hMecn3Z2MDdKBMa5iJUWPUqxgTdrphW1q2o=;
        b=IjnbD7qdJ05bc2MUTpLU+rSYMvMrWS7pgQdUKCe0pRQkthKlSK5A7Sp8VO+jHx1VyR
         mhi36AGb481dtEAFqWCCpvgFWxKJnHr6tK9O/8JjRO66epKPhD0JWQIH07rLg8HdQZ0K
         kWYy02qR+p78oA6awwMAXO53Ua3EI1pEkE2oxgC5Cw0BFkNLh1xwIyfKaK1PHTc4eKUj
         Az9o3lUezw/doMHJHCJWNqHWCYisjtqYWyx3NGDMSXTG6/oFJ0fIfbTDSbzd394esVHI
         00pqCWq+MjVVP8Rlj7qPRiI0SV05gp3s7S/yFCurFbnHGLwK1+88yxaIeUhqimvCTKuh
         xXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775562794; x=1776167594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cyw7QeV5hMecn3Z2MDdKBMa5iJUWPUqxgTdrphW1q2o=;
        b=dRgd8Q4F/Y8n0EOT1R4Xbis7OgStZpF4IS0T+F850yLkfeRP3s30JH/tWDadJVxzMq
         3MzF0502t0StgoMSptuHHLf0kGGjoY6TCcNwHu2F07FwACzJyt9tW3OINwARiS4jjkbj
         vomAWEUklkli2O40xWuvBlUhPbucwH90CsLpbquHd+WBf5nsGmBtJ6ZVx3uOqQu1p3l4
         E/SxzXEU1oE7L+klyAmTp29v+7KqwfvJ+Yk/d8qUXfcwyMyzfc2Gn6kuG1oGq6NjBfqa
         TvnpcDzPFEOTTNQozc6cp015vPOZepPqDDOEqpiPFY+nTNEDjP+MTUjMc+JG294KSxNI
         EGIg==
X-Gm-Message-State: AOJu0YyKHlbIb7GLeYC38opmmSqL8fXWrKvd5vrtTZeCc47mx1wd9+Z7
	MeidrVXwLsqY9/C08RwVwIGF68Gq/8R4CdbJPG6VwiLde4D1xD3vyqIHNPCxRg==
X-Gm-Gg: AeBDieu0cV1fpkrZP63INjGj2XNPirfwDeLOKTUcP0qq+LLEVBtSsteMpnpWGnVLV6P
	mdFHSRU+YSnAi0QcX4NsK9QHm6c+45y5RWkyZY3dppHMKU8mE4IKQO9HfmuMzTPE93dM2+n9tMu
	RBL3i3mSJwdcvaXfbx4XajkBHzYYL/jfU3R4PjHF0D+CNnDIukYZOQUk8PDabzNJyTTIArcq7tQ
	e6X8SHOxRMadGAZyTmRupY5VaEDwG0lFchOh5sRT/Qxj6YX5Tlqr/i8tDoE2b1SLhSxfjYT4jB0
	GMVp0T+t2HpGUJHwfYRXfnKgRjlXhLOE/n+KvfzmxMpA9t0aLtOSenc7oTXHDMXoxpQ8klqaK2Q
	AQMa7R5x8kUFAFxn6FAvEcyKb32k9T8AUloAr9Gm5PiJGTmq8xkod+cOc7zOiOMA1GFUJql1Akp
	LKb4U9NMX/E231gBrSVjGrP71NSDgYJCKsQSkq+dhtq6OkV18OpMwfjNW2yHR5ySrQf+s+peS9O
	Pfi3/NB63tU5ExiClULp9F8i+ES8C/Hmq+umt4=
X-Received: by 2002:a5d:5d0f:0:b0:43d:184:8a9b with SMTP id ffacd0b85a97d-43d2929d8fcmr23610225f8f.16.1775562793553;
        Tue, 07 Apr 2026 04:53:13 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f5bsm45050794f8f.7.2026.04.07.04.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:53:13 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 10/10] t5710: use proper file:// URIs for absolute paths
Date: Tue,  7 Apr 2026 13:52:43 +0200
Message-ID: <20260407115243.358642-11-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.rc0.114.g05d466edb8
In-Reply-To: <20260407115243.358642-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
 <20260407115243.358642-1-christian.couder@gmail.com>
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
let's introduce a $TRASH_DIRECTORY_URL helper variable that explicitly
guarantees a leading slash for the path component, ensuring valid
3-slash `file:///` URIs on all operating systems.

While at it, let's also introduce $ENCODED_TRASH_DIRECTORY_URL to
handle some common special characters in directory paths.

To be extra safe, let's skip all the tests if there are uncommon
special characters in the directory path.

Then let's replace all instances of `file://$(pwd)` with
$TRASH_DIRECTORY_URL across the test script, and let's simplify the
`sendFields` and `checkFields` tests to use
$ENCODED_TRASH_DIRECTORY_URL directly.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t5710-promisor-remote-capability.sh | 79 +++++++++++++++++----------
 1 file changed, 51 insertions(+), 28 deletions(-)

diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index bf0eed9f10..b404ad9f0a 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -76,6 +76,31 @@ copy_to_lop () {
 	cp "$path" "$path2"
 }
 
+# On Windows, `pwd` returns a path like 'D:/foo/bar'. Prepend '/' to turn
+# it into '/D:/foo/bar', which is what git expects in file:// URLs on Windows.
+# On Unix, the path already starts with '/', so this is a no-op.
+pwd_path=$(pwd)
+case "$pwd_path" in
+[a-zA-Z]:*) pwd_path="/$pwd_path" ;;
+esac
+
+# Allowed characters: alphanumeric, standard path/URI (_ . ~ / : -),
+# and those percent-encoded below (% space = , ;)
+rest=$(printf "%s" "$pwd_path" | tr -d 'a-zA-Z0-9_.~/:% =,;-')
+if test -n "$rest"
+then
+	skip_all="PWD contains unsupported special characters"
+	test_done
+fi
+
+TRASH_DIRECTORY_URL="file://$pwd_path"
+
+encoded_path=$(printf "%s" "$pwd_path" |
+	       sed -e 's/%/%25/g' -e 's/ /%20/g' -e 's/=/%3D/g' \
+		   -e 's/;/%3B/g' -e 's/,/%2C/g')
+
+ENCODED_TRASH_DIRECTORY_URL="file://$encoded_path"
+
 test_expect_success "setup for testing promisor remote advertisement" '
 	# Create another bare repo called "lop" (for Large Object Promisor)
 	git init --bare lop &&
@@ -88,7 +113,7 @@ test_expect_success "setup for testing promisor remote advertisement" '
 	initialize_server 1 "$oid" &&
 
 	# Configure lop as promisor remote for server
-	git -C server remote add lop "file://$(pwd)/lop" &&
+	git -C server remote add lop "$TRASH_DIRECTORY_URL/lop" &&
 	git -C server config remote.lop.promisor true &&
 
 	git -C lop config uploadpack.allowFilter true &&
@@ -104,7 +129,7 @@ test_expect_success "clone with promisor.advertise set to 'true'" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
 		-c promisor.acceptfromserver=All \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -119,7 +144,7 @@ test_expect_success "clone with promisor.advertise set to 'false'" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
 		-c promisor.acceptfromserver=All \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -137,7 +162,7 @@ test_expect_success "clone with promisor.acceptfromserver set to 'None'" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
 		-c promisor.acceptfromserver=None \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -156,8 +181,8 @@ test_expect_success "init + fetch with promisor.advertise set to 'true'" '
 	git -C client init &&
 	git -C client config remote.lop.promisor true &&
 	git -C client config remote.lop.fetch "+refs/heads/*:refs/remotes/lop/*" &&
-	git -C client config remote.lop.url "file://$(pwd)/lop" &&
-	git -C client config remote.server.url "file://$(pwd)/server" &&
+	git -C client config remote.lop.url "$TRASH_DIRECTORY_URL/lop" &&
+	git -C client config remote.server.url "$TRASH_DIRECTORY_URL/server" &&
 	git -C client config remote.server.fetch "+refs/heads/*:refs/remotes/server/*" &&
 	git -C client config promisor.acceptfromserver All &&
 	GIT_NO_LAZY_FETCH=0 git -C client fetch --filter="blob:limit=5k" server &&
@@ -177,10 +202,10 @@ test_expect_success "clone with two promisors but only one advertised" '
 	GIT_TRACE="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
 		-c remote.unused_lop.promisor=true \
 		-c remote.unused_lop.fetch="+refs/heads/*:refs/remotes/unused_lop/*" \
-		-c remote.unused_lop.url="file://$(pwd)/unused_lop" \
+		-c remote.unused_lop.url="$TRASH_DIRECTORY_URL/unused_lop" \
 		-c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
 		-c promisor.acceptfromserver=All \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -210,11 +235,11 @@ test_expect_success "init + fetch two promisors but only one advertised" '
 	git -C client init &&
 	git -C client config remote.unused_lop.promisor true &&
 	git -C client config remote.unused_lop.fetch "+refs/heads/*:refs/remotes/unused_lop/*" &&
-	git -C client config remote.unused_lop.url "file://$(pwd)/unused_lop" &&
+	git -C client config remote.unused_lop.url "$TRASH_DIRECTORY_URL/unused_lop" &&
 	git -C client config remote.lop.promisor true &&
 	git -C client config remote.lop.fetch "+refs/heads/*:refs/remotes/lop/*" &&
-	git -C client config remote.lop.url "file://$(pwd)/lop" &&
-	git -C client config remote.server.url "file://$(pwd)/server" &&
+	git -C client config remote.lop.url "$TRASH_DIRECTORY_URL/lop" &&
+	git -C client config remote.server.url "$TRASH_DIRECTORY_URL/server" &&
 	git -C client config remote.server.fetch "+refs/heads/*:refs/remotes/server/*" &&
 	git -C client config promisor.acceptfromserver All &&
 
@@ -242,7 +267,7 @@ test_expect_success "clone with promisor.acceptfromserver set to 'KnownName'" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
 		-c promisor.acceptfromserver=KnownName \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -257,7 +282,7 @@ test_expect_success "clone with 'KnownName' and different remote names" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.serverTwo.promisor=true \
 		-c remote.serverTwo.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.serverTwo.url="file://$(pwd)/lop" \
+		-c remote.serverTwo.url="$TRASH_DIRECTORY_URL/lop" \
 		-c promisor.acceptfromserver=KnownName \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -294,7 +319,7 @@ test_expect_success "clone with promisor.acceptfromserver set to 'KnownUrl'" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
 		-c promisor.acceptfromserver=KnownUrl \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -311,7 +336,7 @@ test_expect_success "clone with 'KnownUrl' and different remote urls" '
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/serverTwo" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/serverTwo" \
 		-c promisor.acceptfromserver=KnownUrl \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -326,7 +351,7 @@ test_expect_success "clone with 'KnownUrl' and url not configured on the server"
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
 
-	test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
+	test_when_finished "git -C server config set remote.lop.url \"$TRASH_DIRECTORY_URL/lop\"" &&
 	git -C server config unset remote.lop.url &&
 
 	# Clone from server to create a client
@@ -335,7 +360,7 @@ test_expect_success "clone with 'KnownUrl' and url not configured on the server"
 	# missing, so the remote name will be used instead which will fail.
 	test_must_fail env GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
 		-c promisor.acceptfromserver=KnownUrl \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -347,7 +372,7 @@ test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
 
-	test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
+	test_when_finished "git -C server config set remote.lop.url \"$TRASH_DIRECTORY_URL/lop\"" &&
 	git -C server config set remote.lop.url "" &&
 
 	# Clone from server to create a client
@@ -356,7 +381,7 @@ test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
 	# so the remote name will be used instead which will fail.
 	test_must_fail env GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
 		-c promisor.acceptfromserver=KnownUrl \
 		--no-local --filter="blob:limit=5k" server client &&
 
@@ -380,13 +405,12 @@ test_expect_success "clone with promisor.sendFields" '
 	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
 		-c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
 		-c promisor.acceptfromserver=All \
 		--no-local --filter="blob:limit=5k" server client &&
 
 	# Check that fields are properly transmitted
-	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
-	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
+	PR1="name=lop,url=$ENCODED_TRASH_DIRECTORY_URL/lop,partialCloneFilter=blob:none" &&
 	PR2="name=otherLop,url=https://invalid.invalid,partialCloneFilter=blob:limit=10k,token=fooBar" &&
 	test_grep "clone< promisor-remote=$PR1;$PR2" trace &&
 	test_grep "clone> promisor-remote=lop;otherLop" trace &&
@@ -411,15 +435,14 @@ test_expect_success "clone with promisor.checkFields" '
 	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
 		-c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
 		-c remote.lop.partialCloneFilter="blob:none" \
 		-c promisor.acceptfromserver=All \
 		-c promisor.checkFields=partialcloneFilter \
 		--no-local --filter="blob:limit=5k" server client &&
 
 	# Check that fields are properly transmitted
-	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
-	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
+	PR1="name=lop,url=$ENCODED_TRASH_DIRECTORY_URL/lop,partialCloneFilter=blob:none" &&
 	PR2="name=otherLop,url=https://invalid.invalid,partialCloneFilter=blob:limit=10k,token=fooBar" &&
 	test_grep "clone< promisor-remote=$PR1;$PR2" trace &&
 	test_grep "clone> promisor-remote=lop" trace &&
@@ -449,7 +472,7 @@ test_expect_success "clone with promisor.storeFields=partialCloneFilter" '
 	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
 		-c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
 		-c remote.lop.token="fooYYY" \
 		-c remote.lop.partialCloneFilter="blob:none" \
 		-c promisor.acceptfromserver=All \
@@ -501,7 +524,7 @@ test_expect_success "clone and fetch with --filter=auto" '
 
 	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
 		-c remote.lop.promisor=true \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
 		-c promisor.acceptfromserver=All \
 		--no-local --filter=auto server client 2>err &&
 
@@ -558,7 +581,7 @@ test_expect_success "clone with promisor.advertise set to 'true' but don't delet
 	# Clone from server to create a client
 	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
-		-c remote.lop.url="file://$(pwd)/lop" \
+		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
 		-c promisor.acceptfromserver=All \
 		--no-local --filter="blob:limit=5k" server client &&
 
-- 
2.54.0.rc0.114.g05d466edb8

