Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4712A21FF4D
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773707368; cv=none; b=UDfPhFzVrptjDdpU5bhYBTvUQwVFThPc1qJ2A37Q99YTsYadeLm2flPYzeEmOWa1wR1DVei12g42b3vPtWuxrosuc8b8Y3bM02puUiceBLqIOKNnkfQAgZJjlqt7uD7anbBsCYnBSrN12krKVcMZPz0JZW4Z/I+hMJddJfXAkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773707368; c=relaxed/simple;
	bh=2jbqF8ZNR5RlwomFUeDpMktmFImv0BDTgDMI8RvgTcs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HYdGDP/HaFKk9yP30H146+2XbVp+mq1sfaycboo+TCOTrU+PJHCiBDSvQQXpw1D5aFd619W2irS9HY9Y6Hl2E+9PlysHS98AJIEiQIYAJNA55iQ3bAYIm6uAsR/yUfVvi/sKIAIoOe4m79Ap1zdhxspuYVoOxzFfvTKDv2sc7Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDN8ufLI; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDN8ufLI"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-128d7db88b9so6184474c88.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 17:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773707366; x=1774312166; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSO2EfFjgUUq2OxrqJqOBJYCMqN8qTa5wF2tm+02jFM=;
        b=GDN8ufLIdFVy0x0Zl4TwuAhN5j/+F0tRwNmCXJIkVumMkXX4A5HNkEn1btBiMoOMHf
         /k+rr3Gw08oY5PQjVr6Dnn/DjpjrxANLnhNONKvkanDwY0rOaoNi/3WASO/2lHTdIs2c
         GUJjSM6DXpJ01i46LsNbgivD8EI8fR5cexNRUgvrqAgq0tFkd93OZCDzVk8tLtRAIjEL
         iiGQDqnMcbrDivxaCW2CD09KxoiSHdAD0tr2RIq0OgIEhxH8857sWKlsfcM5uuAgHT3W
         9GhmlwJYsPmZkSg+JhRWnp8Ljc4CDS+ZFjDDaiSm8DwKu0124n0yWIE+DVH/WDzbWe6T
         XW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773707366; x=1774312166;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hSO2EfFjgUUq2OxrqJqOBJYCMqN8qTa5wF2tm+02jFM=;
        b=SL6a6LoXVOo+Sq+NbvejYl5cAYcTnuFXC4ty5v8ZQSuJJWEq+IejKCvhbwjXdtDpP7
         WivCR1Y4WQznMd10tzQ3zYymnc+rEXIm3GVAf8HQMRjDiHINNBwCPk0xP+UiRNLHYJHA
         XlfqMkgrnw2EX5KPEF6vQh3K7CIdFXUrzQQYRFK4RI5t+ijgl68CPIJs4QbjDfKCvhLa
         igh5Hdtamqib/Oz22QPghRWpP5twk9wVYYAN9cbwKHVNyz0spnWhdRysE51vMfAsHO8+
         ulA+Ip0n874oGCPXN8KxsnIA77L5y2BaqpmuptNBpwR0VkwiyezGDGbnSsHe2xZYMsbg
         plsw==
X-Gm-Message-State: AOJu0YwrBlW1HjFVBKaTQ9SrRaiAp0icZH7o27RaXpJAa3JgELSvjuiH
	euYWsu4XrVIfZeQM/sWenqYSif4EzPxcu6fpuOf2F3S9xPAVmPUhXiTPNcGw9A==
X-Gm-Gg: ATEYQzw3a/WDJ6RvapFoxqYLml7/eegNHoFULk6AedGRL+/RdxiGlH0m/IFJ56Zlb3c
	hREBsJgxPBymlxVESX9WzOW+4umlqcL5E/t1HjQMDYCyfarlkvaG94K+h3dPHKplUjdWksezLZ2
	euxzxjMewsHhwr5urM6vJasaXxZ1jvwRxidn4AIXTboSOPhyaxt+bUBkbHPoJxQXnccKhYRyqCN
	Tx7LvRzdCJpFty0M8STdj1Md173azjfR/1XYM4g93sQwldqX4SXkst8OssZIMqZoYavpMIEFQl8
	/FMJeDzAgvlvAip4oLTl0HHJSvQEFNYSMZgDL/JSGKqZ1a4uZrYjQqGf3GviwTBWKnRNxTwtFmv
	mmSjsyovLidSVIF5Kt1Vjj8+JHkwGESOlC/mQiqC3IGZZWAQdqSNS3oyGcQOb47W5JtWKJ3fTnQ
	bXN3umnuflzR3h38m5amrGLpo5gQ==
X-Received: by 2002:a05:7022:422:b0:11d:c22e:a131 with SMTP id a92af1059eb24-128f3d17be1mr6443957c88.3.1773707365736;
        Mon, 16 Mar 2026 17:29:25 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.136.171])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384e7asm13664727c88.11.2026.03.16.17.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:29:25 -0700 (PDT)
Message-Id: <55a45b2fc81895d2b712f126f716a8152d73fc93.1773707361.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 00:29:18 +0000
Subject: [PATCH 2/5] t5620: prepare branched repo for revision tests
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
Cc: gitster@pobox.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Prepare the test infrastructure for upcoming changes that teach 'git
backfill' to accept revision arguments and pathspecs.

Add test_tick before each commit in the setup loop so that commit dates
are deterministic. This enables reliable testing with '--since'.

Rename the 'd/e/' directory to 'd/f/' so that the prefix 'd/f' is
ambiguous with the files 'd/file.*.txt'. This exercises the subtlety
in prefix pathspec matching that will be added in a later commit.

Create a branched version of the test repository (src-revs) with:
 - A 'side' branch merged into main, adding s/file.{1,2}.txt with
   two versions (4 new blobs, 52 total from main HEAD).
 - An unmerged 'other' branch adding o/file.{1,2}.txt (2 more blobs,
   54 total reachable from --all).

This structure makes --all, --first-parent, and --since produce
meaningfully different results when used with 'git backfill'.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t5620-backfill.sh | 52 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 58c81556e7..1331949be4 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -15,7 +15,7 @@ test_expect_success 'setup repo for object creation' '
 	git init src &&
 
 	mkdir -p src/a/b/c &&
-	mkdir -p src/d/e &&
+	mkdir -p src/d/f &&
 
 	for i in 1 2
 	do
@@ -26,8 +26,9 @@ test_expect_success 'setup repo for object creation' '
 			echo "Version $i of file a/b/$n" > src/a/b/file.$n.txt &&
 			echo "Version $i of file a/b/c/$n" > src/a/b/c/file.$n.txt &&
 			echo "Version $i of file d/$n" > src/d/file.$n.txt &&
-			echo "Version $i of file d/e/$n" > src/d/e/file.$n.txt &&
+			echo "Version $i of file d/f/$n" > src/d/f/file.$n.txt &&
 			git -C src add . &&
+			test_tick &&
 			git -C src commit -m "Iteration $n" || return 1
 		done
 	done
@@ -41,6 +42,53 @@ test_expect_success 'setup bare clone for server' '
 	git -C srv.bare config --local uploadpack.allowanysha1inwant 1
 '
 
+# Create a version of the repo with branches for testing revision
+# arguments like --all, --first-parent, and --since.
+#
+# main: 8 commits (linear) + merge of side branch
+#   48 original blobs + 4 side blobs = 52 blobs from main HEAD
+# side: 2 commits adding s/file.{1,2}.txt (v1, v2), merged into main
+# other: 1 commit adding o/file.{1,2}.txt (not merged)
+#   54 total blobs reachable from --all
+test_expect_success 'setup branched repo for revision tests' '
+	git clone src src-revs &&
+
+	# Side branch from tip of main with unique files
+	git -C src-revs checkout -b side HEAD &&
+	mkdir -p src-revs/s &&
+	echo "Side version 1 of file 1" >src-revs/s/file.1.txt &&
+	echo "Side version 1 of file 2" >src-revs/s/file.2.txt &&
+	test_tick &&
+	git -C src-revs add . &&
+	git -C src-revs commit -m "Side commit 1" &&
+
+	echo "Side version 2 of file 1" >src-revs/s/file.1.txt &&
+	echo "Side version 2 of file 2" >src-revs/s/file.2.txt &&
+	test_tick &&
+	git -C src-revs add . &&
+	git -C src-revs commit -m "Side commit 2" &&
+
+	# Merge side into main
+	git -C src-revs checkout main &&
+	test_tick &&
+	git -C src-revs merge side --no-ff -m "Merge side branch" &&
+
+	# Other branch (not merged) for --all testing
+	git -C src-revs checkout -b other main~1 &&
+	mkdir -p src-revs/o &&
+	echo "Other content 1" >src-revs/o/file.1.txt &&
+	echo "Other content 2" >src-revs/o/file.2.txt &&
+	test_tick &&
+	git -C src-revs add . &&
+	git -C src-revs commit -m "Other commit" &&
+
+	git -C src-revs checkout main &&
+
+	git clone --bare "file://$(pwd)/src-revs" srv-revs.bare &&
+	git -C srv-revs.bare config --local uploadpack.allowfilter 1 &&
+	git -C srv-revs.bare config --local uploadpack.allowanysha1inwant 1
+'
+
 # do basic partial clone from "srv.bare"
 test_expect_success 'do partial clone 1, backfill gets all objects' '
 	git clone --no-checkout --filter=blob:none	\
-- 
gitgitgadget

