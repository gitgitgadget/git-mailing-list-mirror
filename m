Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191CA495E5
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837403; cv=none; b=rAzXXC14N7tUREVejBwwux84LoWECvJEX7eBJsGaJx7lUTAs7Gn70vtCyRZPIg1orIzXVa3qmn1Bvv/LcG7FJoYfPgncpVXfV/Or+wepZC8tRb7/Mbf75QSC9BpI+kpv1kIGtCkxf5C924IqkENKlMjeNB2ULhKnVQBK4htBpbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837403; c=relaxed/simple;
	bh=FlTxwar7421c7s9oCma+NRaQzhqhVH2Y9frWVSL99Wc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=gDzF0g0YKXBLiUqK8pEP/eCnplKaXfdU6WHbuvJoM/d8duxwyU1mYo1X2dQzDwGp4bW+8+JwGvJLcGiO+Ac1SkEQZJjlLuYNXoShOjygnyEoNVSNRTKhFwHzo3d/elSzNO+CDHEIBcathzoTVTKgjzPjh5eXi/AiodMB46pT32I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPn81j+9; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPn81j+9"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8947e6ffd20so43059736d6.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 01:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771837400; x=1772442200; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/hZb/JcGTVxPgwJwp9ZJK9WuQokozY2884BVCKzOkuE=;
        b=FPn81j+9XAAJMlcpfGvZzKbPjqufpIZv+6vj6MHKTVn6nPaU0vnRyiera1dHZyarnY
         dJWzji6HhaXWaa0iG7YzPuOU2OV2sWcGvUri+k9GGGf3JWEJajgZ3jYM6W2Jc40ihMca
         Ry6DJOA+3E+Z7GHZt4EeDIHLN9CJFL/61keXXlVYqNIabXqPjlC6K/f9t6eHaNSce7Cx
         NYM0ClNofwYOznraoglJB8AIfwTQFOVpl0qk+qKkFOBMsBNTKEuEpuUiAr+NOAA+Fafm
         uz/jWabNX2QK+jPu7mvn9j8cy7XAwN9RTu4bXqgHWpH81OtD+McIfBVHnUepz9XuJkFY
         HM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837400; x=1772442200;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hZb/JcGTVxPgwJwp9ZJK9WuQokozY2884BVCKzOkuE=;
        b=Q9K0kTtC3t1lCRtS3Q3u8hM1N9K09WEE0baKMFbMosxrCXZaC5vDuuNaO24Bcwv7r+
         WlKNeZ14mYXXxtEaJnronaRdYsz3F4VyrOQjZWGx5BaQOIleN/lmUQSz9+YDvjztNy9k
         24t1I2u5EYS8IPF3Uu8E/vA0F3Xn1Mk4UXG2SEYYwFdHHaNOpa2qsZkp3Rpmh6DVVQRq
         3qQ28ymlyfVYaM4IUrejk+nySBgr3nyF9wJPfOSJ/13s08SDFqx6+svVfAJNG5vb4tAe
         mfoTC2hQgCEYCMKF+xgfGrj81RpwTj0X4bP4aCKuKctC080g3rVEK/UisN9MbSgsulAA
         WANA==
X-Gm-Message-State: AOJu0YyLfRBR7dP/Pgg3NHFOtQXOM7wOCXWG/DbPdppFJO2T2Dti3U/b
	LBLmkl3dqsaF2bWqrNeQw79jwqgT/NMp+SpKGW79qZ7GQGRgCmr+obueYjoNSw==
X-Gm-Gg: AZuq6aKXFKc8DUQG7nYYsGHoH93OkFVbzkU9MII3mGcyqJsNKGwrjV8WtKrJ8OkWi1K
	JhWq1ZxBOR3TCFdgNkKk2bCfnMla6cC4fsiTrb5YNX2507xd06aB4whpNckJ3IsC318drkBPuGF
	pw0hQjEDdZoNkkRNH4ryMFUx7sC/YtcrD5CEQ+obDNPzyj4AmTFUBJ1G7H63sRxWEtUxovGku+F
	79jdyNjvaARsmZ7mPCCi8nriHjW5kxGc4PgguFXUhCI5p5S0BFncAhN9T0LuSL6zFVNpvWbXWBv
	Gz1KQEJl4RGjw5maB4lWJk5MvdNHRZrDfmfRIEl5zNV4vNBXh6WZqGo1QnEO9JvyMnuTulyOJj5
	4muDRMFhWPBDWaVEFR2MJnP6qRFmj4TDCFddma+vrwt6L4LzxIkbIj8wAb4XrtYbdslIGWQvzAM
	feYAibkoiodQGkWs1e5NDk5MT9LtVT+SFKBeGL
X-Received: by 2002:a05:622a:249:b0:501:45c5:935e with SMTP id d75a77b69052e-5070bb81b0fmr94406491cf.7.1771837400517;
        Mon, 23 Feb 2026 01:03:20 -0800 (PST)
Received: from [127.0.0.1] ([48.211.210.118])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6df762sm62329021cf.29.2026.02.23.01.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:03:20 -0800 (PST)
Message-Id: <pull.2054.git.1771837399472.gitgitgadget@gmail.com>
From: "Md Ferdous Alam via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 09:03:19 +0000
Subject: [PATCH] t2018: move checkout case-insensitive test from t0050
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
Cc: Md Ferdous Alam <mdferdousalam1989@yahoo.com>,
    mdferdousalam <mdferdousalam1989@yahoo.com>

From: mdferdousalam <mdferdousalam1989@yahoo.com>

The test 'checkout with no pathspec and a case insensitive fs' in
t0050 does not really belong there as it tests branch checkout
behavior, not filesystem properties.  It also had an unnecessary
CASE_INSENSITIVE_FS prereq since the sequence of commands should
succeed on any filesystem, and it did not verify the resulting
worktree contents.

Move it to t2018-checkout-branch.sh where it belongs, drop the
prereq, and add a check that the expected file is present after
the checkout.

Signed-off-by: mdferdousalam <mdferdousalam1989@yahoo.com>
---
    t2018: move checkout case-insensitive test from t0050

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2054%2Fmdferdousalam%2Fmove-checkout-test-from-t0050-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2054/mdferdousalam/move-checkout-test-from-t0050-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2054

 t/t0050-filesystem.sh      | 20 --------------------
 t/t2018-checkout-branch.sh | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index ca8568067d..003329c082 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -117,24 +117,4 @@ $test_unicode 'merge (silent unicode normalization)' '
 	git merge topic
 '
 
-test_expect_success CASE_INSENSITIVE_FS 'checkout with no pathspec and a case insensitive fs' '
-	git init repo &&
-	(
-		cd repo &&
-
-		>Gitweb &&
-		git add Gitweb &&
-		git commit -m "add Gitweb" &&
-
-		git checkout --orphan todo &&
-		git reset --hard &&
-		mkdir -p gitweb/subdir &&
-		>gitweb/subdir/file &&
-		git add gitweb &&
-		git commit -m "add gitweb/subdir/file" &&
-
-		git checkout main
-	)
-'
-
 test_done
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index a48ebdbf4d..5f37e40591 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -285,4 +285,25 @@ test_expect_success 'checkout -b rejects an extra path argument' '
 	test_grep "Cannot update paths and switch to branch" err
 '
 
+test_expect_success 'checkout a branch when file and directory share case-insensitive name' '
+	git init repo-case &&
+	(
+		cd repo-case &&
+
+		>Gitweb &&
+		git add Gitweb &&
+		git commit -m "add Gitweb" &&
+
+		git checkout --orphan other &&
+		git reset --hard &&
+		mkdir -p gitweb/subdir &&
+		>gitweb/subdir/file &&
+		git add gitweb &&
+		git commit -m "add gitweb/subdir/file" &&
+
+		git checkout master &&
+		test_path_is_file Gitweb
+	)
+'
+
 test_done

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
gitgitgadget
