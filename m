Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3984F331EAB
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257840; cv=none; b=ovT3eNACjfbXBGCWxEf1/+nPm+/VXVGkc8o9W+w0L9uY6t9GkITek3iu6ulQC1Dwp17j4vgd0rhBH5pzb5pMSQy9MKCexqVxv2OFq8QDWoV+2D5BjoId+UyDQGpdp179B3m0ySdrFL4RZHPRmmbSd8rIGQZWCJ6cSZ/skgu8nfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257840; c=relaxed/simple;
	bh=6MDWz40rySlHYJ9/KrMlgtf2DWiYdqw88Epf/gviyVY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ZgCRPzJq25EcXwmt4h/C4kmbwPf7uFJJRkMHG36IwA61gKUpNMIwjhesROkL4w3PFxujDh5wp+sQ2bNLFi4D9wb2C5smpGQbwICsysSon9rmalM3OXyfw5RUmjZIDgH8mZjto9fKp0eD4F84SaCguTVIQ1+PEM2Vcegj6hubPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNiA251e; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNiA251e"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9a2b95b72so3624495a12.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 06:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790257837; x=1790862637; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xxxdQonZ2LIzsSqGNu8cDCw7oR6MhEmuZnEU2toNyCY=;
        b=VNiA251e2Mr7TNKTIwJP+vMj/PLWm7SCC6AXjNk+7/uVYhCZU2BXnaNzUHqWbAjNRS
         kpIvxSTpGBeyxYaQ3Mkt0FIfihdN7y9ukBE33cRgr4WUm91cJYGe/xJ3nJIOnEL3fywY
         vjsNHWAUGoVWqHCHwdaXcROgdyHsEnMEDGDW3lkGoGVE7exkal9O8C4+2nYmonMAUW5m
         JizBLMhTwEcfhCSYqhBUlrvapClVVLboJ9mWjONNTXFpdoz958A0HGFxdMVN4PaWwCBF
         +4Pu0uANZUzx/fP4qp9Whd35BTBrAld2hVsWwWc3uQhi/khh8fle4U3ZdtiZ0qMbjMo9
         QPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257837; x=1790862637;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xxxdQonZ2LIzsSqGNu8cDCw7oR6MhEmuZnEU2toNyCY=;
        b=VA3AvMyT7bdqnhO+lJbsdnjlN7ShR4ht0hN98bB5Ty2Y4a807O8JWOef0wEvu53w0U
         lGF+ZnB8QksLAPwkFgQoglwv2AgSSjWca7raeXrth/3+VE8iTzhrIEQMB3b1vjjDFO27
         gWp7Gy3cYbNl1/Vrr5kPmHZssqsoPYZB4jET0dOMLZKsBk3PvuTfZSIc82FD6kQGiLZo
         2AxrhbHlgMru2n27fhPQjbeWVvlhWhbcvTmuiltQhQW+hbk2MBohcKIEclA1uqeHg+yn
         PkR/mMBAUKVjMcdNgpeFMFZU3OAFvOuASC5dD91BPAYIswWjdLuhtLHYB/Ayv5ZG6qjC
         dO8Q==
X-Gm-Message-State: AFuF++naxdV+D+di0xdtNXqotkmDZ7VXYnP0njZ3qpjiKGNQtRXC6h6S
	929wqAXOyHdi96xdhoqUK3zmGOVRvO9/cGh6xVYUD5k2eEKebelX3Il/GOwA914C
X-Gm-Gg: AYBFou3G8VFZSuz02BsE5oCvXfmBOOeAeEjlrEWYlMy/3DtiZ/C4iUHaamwkjyVblkk
	1eYdOsjuDI26XAfiXEIdbL9YuOXXw19KwPXV1jjTwU7HAPjUStHYDDOLxvQjRTw0ETyKL01a9sB
	rnHA54k7YmJnWvsh7QIZXCZDOktFFz98G5ZprFQE1A6NvEmv3+Ngj2O/dYZ+918C3fxzgPmhhs3
	GdBuRYGE6cmmiJK3p1u3ZyCx2Joyhm4J6lCJo0u5ljBEmoj9IhkEQjwsXp7qlTzJZA5xirShNs/
	IuKwZ5ECtwAmiSzzJykHgM6I4h1MjfmplSkoB3ciZOgVUkiJbBdJnXLxfm0ngWvmi5TQaULwhYl
	1OjGB+7uzFnsTkoGVNuK6aVEdGdo4eKqCrbCi3tj264dmw5Raif9tbiV1FpNmIyIn8zGB5eF0z6
	DEF5VB1gCQM9YAvWTOLSjT3RfD4EynokmEdYVnoTX7IXETta/8pBeEAh7H2ezOE0G0mk/6CZeYJ
	Y/5
X-Received: by 2002:a05:6402:84c:b0:6aa:f0e:a152 with SMTP id 4fb4d7f45d1cf-6aac90c71d4mr2492348a12.20.1790257837084;
        Thu, 24 Sep 2026 06:50:37 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.150])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab38a8fadsm3606223a12.24.2026.09.24.06.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:50:36 -0700 (PDT)
Message-Id: <pull.2420.git.git.1790257834680.gitgitgadget@gmail.com>
From: "Nathan Froyd via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 13:50:34 +0000
Subject: [PATCH] builtin/fetch-pack: indicate when we have an exact oid
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Nathan Froyd <froydnj@gmail.com>,
    Nathan Froyd <froydnj@gmail.com>

From: Nathan Froyd <froydnj@gmail.com>

The `git fetch` path, when parsing OIDs, properly sets `exact_oid` on
the relevant refs; the equivalent path for `git fetch-pack` does not.
This oversight results in an invocation of `git fetch-pack $OID`
sending `want-ref $OID`, which results in errors like:

  fatal: unknown ref $OID
  fatal: remote error: unknown ref $OID

Make the two paths equivalent by setting `exact_oid` properly.

Signed-off-by: Nathan Froyd <froydnj@gmail.com>
---
    builtin/fetch-pack: indicate when we have an exact oid

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2420%2Ffroydnj%2Ffroydnj-fetch-pack-exact-oid-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2420/froydnj/froydnj-fetch-pack-exact-oid-v1
Pull-Request: https://github.com/git/git/pull/2420

 builtin/fetch-pack.c               |  4 +-
 t/t5703-upload-pack-ref-in-want.sh | 68 ++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 86754296fa..bef8a3dfc5 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -23,13 +23,14 @@ static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
 	struct ref *ref;
 	struct object_id oid;
 	const char *p;
+	int exact_oid = 0;
 
 	if (!parse_oid_hex(name, &oid, &p)) {
 		if (*p == ' ') {
 			/* <oid> <ref>, find refname */
 			name = p + 1;
 		} else if (*p == '\0') {
-			; /* <oid>, leave oid as name */
+			exact_oid = 1; /* <oid>, leave oid as name */
 		} else {
 			/* <ref>, clear cruft from oid */
 			oidclr(&oid, the_repository->hash_algo);
@@ -41,6 +42,7 @@ static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
 
 	ref = alloc_ref(name);
 	oidcpy(&ref->old_oid, &oid);
+	ref->exact_oid = exact_oid;
 	(*nr)++;
 	ALLOC_GROW(*sought, *nr, *alloc);
 	(*sought)[*nr - 1] = ref;
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 330d049b2c..c02e1fc79c 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -242,6 +242,74 @@ test_expect_success 'fetching with exact OID' '
 	test_grep "want $oid" log
 '
 
+test_expect_success 'fetch-pack with ref and exact OID from arguments' '
+	test_when_finished "rm -f log" &&
+
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	oid=$(git -C "$REPO" rev-parse d) &&
+	main_oid=$(git -C "$REPO" rev-parse main) &&
+	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch-pack \
+		"$REPO" refs/heads/main "$oid" >actual &&
+	cat >expected <<-EOF &&
+	$oid $oid
+	$main_oid refs/heads/main
+	EOF
+	sort expected >expected.sorted &&
+	sort actual >actual.sorted &&
+	test_cmp expected.sorted actual.sorted &&
+	git -C local cat-file -e "$oid" &&
+	git -C local cat-file -e "$main_oid" &&
+	test_grep "want $oid" log &&
+	test_grep "want-ref refs/heads/main" log
+'
+
+test_expect_success 'fetch-pack with ref and exact OID from stdin' '
+	test_when_finished "rm -f log" &&
+
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	oid=$(git -C "$REPO" rev-parse d) &&
+	main_oid=$(git -C "$REPO" rev-parse main) &&
+	cat >input <<-EOF &&
+	refs/heads/main
+	$oid
+	EOF
+	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch-pack \
+		--stdin "$REPO" <input >actual &&
+	cat >expected <<-EOF &&
+	$oid $oid
+	$main_oid refs/heads/main
+	EOF
+	sort expected >expected.sorted &&
+	sort actual >actual.sorted &&
+	test_cmp expected.sorted actual.sorted &&
+	git -C local cat-file -e "$oid" &&
+	git -C local cat-file -e "$main_oid" &&
+	test_grep "want $oid" log &&
+	test_grep "want-ref refs/heads/main" log
+'
+
+test_expect_success 'fetch-pack with OID and ref name resolves the ref' '
+	test_when_finished "rm -f log" &&
+
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	oid=$(git -C "$REPO" rev-parse d) &&
+	main_oid=$(git -C "$REPO" rev-parse main) &&
+	cat >input <<-EOF &&
+	$oid refs/heads/main
+	EOF
+	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch-pack \
+		--stdin "$REPO" <input >actual &&
+	cat >expected <<-EOF &&
+	$main_oid refs/heads/main
+	EOF
+	test_cmp expected actual &&
+	git -C local cat-file -e "$main_oid" &&
+	test_grep "want-ref refs/heads/main" log
+'
+
 test_expect_success 'fetching multiple refs' '
 	test_when_finished "rm -f log" &&
 

base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
-- 
gitgitgadget
