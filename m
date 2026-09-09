Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E854280E
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952410; cv=none; b=iAT/iub8dSQ8xLl8LcBAc17VdQcVWXEFjsv35GTJnp0hzr0iEOc/rovkwVMtcTVgt++Oiwt7CEsmxPcLq6bh4NV4nhdtPJPNL6E0dvTXyEKEUtTHeUmdMlSFjXmwfQt6oeFZhnWeZxUCEldWRgFg+3MoE9QPAWRdorLQQh4xSyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952410; c=relaxed/simple;
	bh=mgEkr7VQ7JQkoiYiVqM0ZD0+xT+sWgQsTJJrQytW2W4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZWnq18A4ZZTPNsYmm1Adw5HUd4wK08WX4UyY+QH/r+SkNbJPEXkBWIr+SQ944Aqs4i8FxOWPM3XvMnLxXoPFeZzbc4aKmJ3E77BBAJ9hU2dU1Oj9ztfCnrU/egDIdRdPdySCr7xhqii/94E0PkaQC8g2J5TLGWv80+EMOllddRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JKXscZab; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aM+9Oy2y; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JKXscZab";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aM+9Oy2y"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0EE4C1400086;
	Wed,  9 Sep 2026 07:13:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 09 Sep 2026 07:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788952404;
	 x=1789038804; bh=yvgcm48CDbbT1eYwdQDcCB0OnV2Aanz6qYZjJZZFqVw=; b=
	JKXscZabSUcOj/X+9Y1n1qv07ZzHM+VBYfp2mYpZthxfCXFypWtcOsB13isa5w3T
	cnE2feHfjCQpnS4WCA2oa9/0kGeI6ViaUn5SqC2P2u9aX6d1pyVH5EJNXHzj6WDF
	/E0CCiuyHaCeH2GeAy7k3fld9fqY987C7N2KOZh/K+VXSJZXPFdpibbt98NO/yqu
	tU0+QJEQu8+gMw8CoHd6JONenXOMtejpog0nMPBzHvR9l69atnJcyZWCjN9k1pOr
	ZLpHa5YDtDZAYGipT49Lmu9uvUr9ey0c862vpfDcFIGzCQG9sWRmFyLPnz1bYOLV
	OfRyFWd1o4s1BrG8IMqRlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788952404; x=
	1789038804; bh=yvgcm48CDbbT1eYwdQDcCB0OnV2Aanz6qYZjJZZFqVw=; b=a
	M+9Oy2yxIuG7rBLl28RG4r5vaK8YWLbghzm/7GsORxghWMyeJuAsoXhbd9zxycX5
	YOfIa5TUmfpX4ZmNdsTtcnGPEAIyX7IAqABnR2YS8VfejkiElr2JPkDbhm9//0KY
	JuCdofj7gEOs5s0iU0Cd6fnnt9mS8jSzNoi7TQFyyWCpiJjnUk6MYOuevnuaq8it
	B2wL6nO6Hwc3ZKJK5U6V/z3c0rmk1AX6I9Kh2G72//TZTaQei08oK/gv3NNsNYHt
	BPpRn1Sz0vaX3v0cIx0OAXz08AUoTvOkezAwMJwTwzHaFD7Sh6QAWpWcSu42Fk0a
	NPADlncFK5/bGruDC08OA==
X-ME-Sender: <xms:Uz-hasF2hrhONpdLSo-zWae7Q38S49gy3HKnoVLVqnNjHhsCeQAu-g>
    <xme:Uz-hasW2DJty8E9x65SGT9tbnm2EvvxqywYQ1BDx3x5RyP0oy9cvbAuSfog7yojng
    bGmNDh70QrWGTJnSb6TWk9VLwy_YMr2hAbfofR5PPssB0bMsyyVhg>
X-ME-Received: <xmr:Uz-harLdJDKv4jGqrkWYh0DoD8Du6H3XJKNH0eABuQJUor-HXEXzQUEMscbVtMutTHfMlQ>
X-ME-Proxy-Cause: dmFkZTG4ihTkcBKIKh6F2bKhNXeN2Im41k84gscjFZWzWbGYjYsaJ99eoZ7Wq4o9IkxiG8
    ZDQYB0yFQTcqXUKSzo+gRCHQCa+qu7n+nfCBmcI6lqidOKnQ/A+dOWVEjiXfgUTsUh+DPn
    fLVUgAObhMw9oEW7bw80oJhLlgkCI9KaVSJjAaU9kGnniVQYOy2iaZK/VSR09tKsvEgpcw
    DKfJmXE7A64LWQ3amcM3eLsWpVjeFA5L0lPkP+Y67KZrBSx54DS3YAqm6h3EjIUI5l6rPr
    DUzy+HoJSFDGAnStSPtH9a577/YgfuN2o/neO/BZfX49cKlxMz3/bEAmlZF1YlTyspVmDP
    /ARZvGdukgDsskGG0PQqo/4lPt19qgpeEX32wtJhidZf8e2hUeWViDYDYk4zgTTA0VKOtv
    WiOo1i+sDJrgyk/1vtx6+eYIW6F534Fb2Y5ljcnMO35sKfD/7p3fcc1MXt1EpzLNqOEPEF
    YWwniAbgs+kIHnqwNlBvppr/6TXOuSA6CNPARgaem9HqXBDh1TlD0j+9RNUaqSHeJSuuhc
    GzI6ZeRSyhmmjKQoQqsxaWqyBoTYI3m2yYNy+/DW4IOkHeG4AA7jWyC6G3IOr6FjrZIdMK
    GG39waMsvzOcjJUO0zYUkLRSE1uNeWg2p4U3XJ3xpxqWa4mxsYjSYe38OIUg
X-ME-Proxy: <xmx:Uz-has9eGA6NKcgMGiAkVN-kUbinE2U4WPHYIb82RGDvuk4OHSUFMA>
    <xmx:VD-hauKNo3t_RoDPUit8O1fXQ0NVmsLf_Tp30VEph18qK66K2tmNKw>
    <xmx:VD-hahnDCq2lzp1dq7xb4T4rmRi3Ab791i86hfTesOuLFBGAulGmkQ>
    <xmx:VD-haiOb1GlXCb0zEX4zG8M_BHO0hGUZGU1AUK_-MLO1e4M7fxPIJg>
    <xmx:VD-hampWcUenE-jCn6thPg0laVBx0WQA2sr0ocJ3cpJKDOgExTipMPW4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 07:13:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0851cb55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 11:13:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 13:12:57 +0200
Subject: [PATCH v3 11/13] t: rename GIT_TEST_DEFAULT_REF_FORMAT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-pks-unify-ref-storage-format-v3-11-ca041fb40ad8@pks.im>
References: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
In-Reply-To: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

With the same reasoning as for all the other environment variables,
rename the GIT_TEST_DEFAULT_REF_FORMAT environment variable to
GIT_TEST_DEFAULT_REF_STORAGE_FORMAT.

Note that in this case, the old name is not retained for backwards
compatibility as this is only running in the context of tests anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-build-and-tests.sh              | 2 +-
 t/README                               | 4 ++--
 t/t0600-reffiles-backend.sh            | 4 ++--
 t/t0601-reffiles-pack-refs.sh          | 4 ++--
 t/t0602-reffiles-fsck.sh               | 4 ++--
 t/t0610-reftable-basics.sh             | 4 ++--
 t/t0612-reftable-jgit-compatibility.sh | 4 ++--
 t/t0613-reftable-write-options.sh      | 4 ++--
 t/t0614-reftable-fsck.sh               | 4 ++--
 t/t1463-refs-optimize.sh               | 4 ++--
 t/test-lib-functions.sh                | 2 +-
 t/test-lib.sh                          | 2 +-
 12 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 1d9a0a736d..6a3b43b366 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -45,7 +45,7 @@ linux-sha256)
 	export GIT_TEST_DEFAULT_HASH=sha256
 	;;
 linux-reftable|linux-reftable-leaks|osx-reftable)
-	export GIT_TEST_DEFAULT_REF_FORMAT=reftable
+	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
 	;;
 
 esac
diff --git a/t/README b/t/README
index 9a9daaf2af..42716bb14a 100644
--- a/t/README
+++ b/t/README
@@ -448,8 +448,8 @@ GIT_TEST_DEFAULT_HASH=<hash-algo> specifies which hash algorithm to
 use in the test scripts. Recognized values for <hash-algo> are "sha1"
 and "sha256".
 
-GIT_TEST_DEFAULT_REF_FORMAT=<format> specifies which ref storage format to use
-in the test scripts. Recognized values for <format> are "files" and
+GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=<format> specifies which ref storage format
+to use in the test scripts. Recognized values for <format> are "files" and
 "reftable".
 
 GIT_TEST_NO_WRITE_REV_INDEX=<boolean>, when true disables the
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index bbbf6fa422..23e38a1695 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -4,8 +4,8 @@ test_description='Test reffiles backend'
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-GIT_TEST_DEFAULT_REF_FORMAT=files
-export GIT_TEST_DEFAULT_REF_FORMAT
+GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=files
+export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT
 
 . ./test-lib.sh
 
diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index 3c706978ef..17283f8bea 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -12,8 +12,8 @@ semantic is still the same.
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-GIT_TEST_DEFAULT_REF_FORMAT=files
-export GIT_TEST_DEFAULT_REF_FORMAT
+GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=files
+export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT
 
 . ./test-lib.sh
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 13259821a0..10781417fd 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -4,8 +4,8 @@ test_description='Test reffiles backend consistency check'
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-GIT_TEST_DEFAULT_REF_FORMAT=files
-export GIT_TEST_DEFAULT_REF_FORMAT
+GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=files
+export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT
 
 . ./test-lib.sh
 
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index b6db54430a..065d6a69b4 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -7,8 +7,8 @@ test_description='reftable basics'
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-GIT_TEST_DEFAULT_REF_FORMAT=reftable
-export GIT_TEST_DEFAULT_REF_FORMAT
+GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
+export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT
 
 . ./test-lib.sh
 
diff --git a/t/t0612-reftable-jgit-compatibility.sh b/t/t0612-reftable-jgit-compatibility.sh
index 7df2ad5817..eddfd9a152 100755
--- a/t/t0612-reftable-jgit-compatibility.sh
+++ b/t/t0612-reftable-jgit-compatibility.sh
@@ -4,8 +4,8 @@ test_description='reftables are compatible with JGit'
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-GIT_TEST_DEFAULT_REF_FORMAT=reftable
-export GIT_TEST_DEFAULT_REF_FORMAT
+GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
+export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT
 
 # JGit does not support the 'link' DIRC extension.
 GIT_TEST_SPLIT_INDEX=0
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
index a65960d048..0b27d75fe3 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -2,8 +2,8 @@
 
 test_description='reftable write options'
 
-GIT_TEST_DEFAULT_REF_FORMAT=reftable
-export GIT_TEST_DEFAULT_REF_FORMAT
+GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
+export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT
 # Disable auto-compaction for all tests as we explicitly control repacking of
 # refs.
 GIT_TEST_REFTABLE_AUTOCOMPACTION=false
diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
index d24b87f961..9576a82478 100755
--- a/t/t0614-reftable-fsck.sh
+++ b/t/t0614-reftable-fsck.sh
@@ -2,8 +2,8 @@
 
 test_description='Test reftable backend consistency check'
 
-GIT_TEST_DEFAULT_REF_FORMAT=reftable
-export GIT_TEST_DEFAULT_REF_FORMAT
+GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
+export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT
 
 . ./test-lib.sh
 
diff --git a/t/t1463-refs-optimize.sh b/t/t1463-refs-optimize.sh
index 9afe3c1ed7..b4b9735828 100755
--- a/t/t1463-refs-optimize.sh
+++ b/t/t1463-refs-optimize.sh
@@ -8,8 +8,8 @@ semantic is still the same.
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-GIT_TEST_DEFAULT_REF_FORMAT=files
-export GIT_TEST_DEFAULT_REF_FORMAT
+GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=files
+export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT
 
 . ./test-lib.sh
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index ed9779b0f7..09a41d51ad 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1737,7 +1737,7 @@ test_detect_hash () {
 
 # Detect the ref format in use.
 test_detect_ref_format () {
-	echo "${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
+	echo "${GIT_TEST_DEFAULT_REF_STORAGE_FORMAT:-files}"
 }
 
 # Load common hash metadata and common placeholder object IDs for use with
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 60a2179a0a..321c2ba339 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -575,7 +575,7 @@ export EDITOR
 GIT_TEST_BUILTIN_HASH=$("$GIT_BINARY" version --build-options | sed -ne 's/^default-hash: //p')
 GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
 export GIT_DEFAULT_HASH
-GIT_DEFAULT_REF_STORAGE_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
+GIT_DEFAULT_REF_STORAGE_FORMAT="${GIT_TEST_DEFAULT_REF_STORAGE_FORMAT:-files}"
 export GIT_DEFAULT_REF_STORAGE_FORMAT
 
 # Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output

-- 
2.55.0.1074.ge7621b4bad.dirty

