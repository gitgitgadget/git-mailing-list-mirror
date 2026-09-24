Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CD247B42F
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251517; cv=none; b=e2cykPiY333mIwi14iCp5fqnLjn8T7KQJk2lm0YnwRv3UdxnXZUqK3DXV5HRbyG7yeVivsL7LHn49j0fUI0cPVY+LYIDVR1Xr7kNyGVIqjNwRNTDCPb4y7ZouKQqPybMkquvoHzaFMT9mkemnyo8FqiTthsXLVaj7eNg1T5rMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251517; c=relaxed/simple;
	bh=CNd2SEhk1hdJHWROt1dgebgrmyaylCIi5OZQPp0r0Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9YmjgdanqHCaaWL+IT9zZBczb8qQC1TykxZICstPJ69T18necP5lYaVW9MPxjxstI5+MwcislMXx32Pd6cxNKPIzAecLa6ECSMY37jX2Uo2p7t8EwB5Ea0e2byDcm8lgw/WxBdw2Oq6Sz+i2dbgoUJos+gSuzNmrNVfh9yBTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWXjk+xj; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWXjk+xj"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-328664ef791so1325320eec.3
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 05:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790251515; x=1790856315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BJmL6jWKhOuGH1AI0rbjNwhIxWyAKDSINCm9QpZSWag=;
        b=lWXjk+xjK40X7D7rcYrC5Vu6X6IuWN3Lyru3Sc3SedX6JaP9RGhjj+KrDjO43p18md
         r4zV0QID1Pgf4vJ7VwJugnKpIdw+PEnHd4H3s3W9jYNDCZRmwxSKHagpj34GeLd6jREj
         AY8JHAmSkVAO4fabYDwcD2sIh20XqI1AZ5diARzONHTWFSk832BRC/xsHP1hOsUb6OmT
         3i11KOLSi1UEdffY0n6BKkcR0XnWpqizKVQAahCkc2NJNP+ZnPdUkGQMWe2zfFHE4wns
         H7WzZ71J/OCbNTyTEKuEmdXvDBkPC8LciXWQcqlKh2I+VP6cXrGQ3Bs2bQB33sCpMUt+
         yDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790251515; x=1790856315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BJmL6jWKhOuGH1AI0rbjNwhIxWyAKDSINCm9QpZSWag=;
        b=j+6G4f20nkeBR/k0msyhZDxEV+SOktiOn8YPQFzeL2fTyCneRju4tItUbWVkLw6rwE
         h9QHvcsId4Ne89jIaGAuUnlFBHY4oZ5lkCPZnnfGdgLpdcsnDV62XhjK0vr2cYIphKUh
         /9ZFzRgx2AWiwoSMqOO51ql1gxGu2D65jRq0D/M71x/3nd/bSHLzCuDdKbwZFW6UQHJh
         G2YcIxP8YfVEm2gzoAs+EKZQ0hTkx6/uP22EKMvxnwDjUyR1kZYiwwnLaQAknEGbq8av
         RtITEb6NGxWLBRjQJF6AmaqPqS/Z5QpW81jfAvz0JRcdmXKdKeehT9DMQpibP1akvlBX
         QOTw==
X-Gm-Message-State: AFuF++lhRvp9S4tcR/UtwYNPfXV197/c+W9mkC2iNPv9k7uX2j4zaqL+
	9N2+9fywDCpdUIAE6YfPTBBYH35x9CDfjlwPHsYak1XKmOZl4SsQ2OplNt/04mZPXg8=
X-Gm-Gg: AYBFou0J6Vfx01LI2JsYF6eCWBJ/28z147IVgWTdEcXXOknn3l0YcMwzQ44qA76U2qB
	+k5W44dEG1Y7dgnrXN6vwNCKTJAyk/J2umH3diUTGF+djI0gFf6gpg+mxtnq81spmeAdovK1SCD
	XaDoO0K//+I9Qr2vhNjy4Rg8jQEzpOX0R1g+vivI2mJnZLJXNZoRufKGNCdpuqqsRrGCdWfNCVi
	hb7i3B98slwD3VSoHJPv1+UqRbND5U4CpKICQC9HJxku5ElLHxdL6/9Jsl7TMux7+fzYP5vC4+T
	IvD/dH1jcFU9p6HIytLnwUNBFRMCdmypYUNayhdEeRG42nw3PG9c5CUmWWVwtC8iQ5k42Yj8+OJ
	7xIPPl0WCKQ90i0dQ8Nv9BwbPXVvJhGa6N9efrK6NJ6n6XBCNCW6fbgCOeOstpH3IFcwqxSTx3t
	ESkFgGPZlYAQdNEpUBoByIbo9gP28hCS/dAtogNfgleUVDcrelUO1TPlyhXS8UNN1wCmOsFtwfg
	Ci122R7XI8idTSavOXchOv2vQ==
X-Received: by 2002:a05:7301:251b:b0:33b:dc97:6040 with SMTP id 5a478bee46e88-3400439cc18mr1946107eec.1.1790251514987;
        Thu, 24 Sep 2026 05:05:14 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm14302671eec.5.2026.09.24.05.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:05:14 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC PATCH 1/3] t0009: add tests to cover more error reporting scenarios
Date: Thu, 24 Sep 2026 17:32:19 +0530
Message-ID: <20260924120502.2642141-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.12.g2c9c8d64bb
In-Reply-To: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce few more tests to t0009 to cover error reporting scenarios
when --git-dir is used.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 t/t0009-git-dir-validation.sh | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t0009-git-dir-validation.sh b/t/t0009-git-dir-validation.sh
index 4cba478e50..244dc07c0e 100755
--- a/t/t0009-git-dir-validation.sh
+++ b/t/t0009-git-dir-validation.sh
@@ -74,4 +74,40 @@ test_expect_success 'setup: .git as an empty directory is ignored' '
 	)
 '
 
+test_expect_success 'setup: custom git directory with missing HEAD is rejected' '
+	test_when_finished "rm -rf parent/empty-dir" &&
+	mkdir -p parent/empty-dir &&
+	(
+		test_must_fail git --git-dir parent/empty-dir rev-parse --is-bare-repository 2>stderr &&
+		test_grep "not a git repository" stderr
+	)
+'
+
+test_expect_success 'setup: custom git directory with HEAD as a symlink outside refs/ is rejected' '
+	test_when_finished "rm -rf parent/head-as-link-to-garbage" &&
+	mkdir -p parent/head-as-link-to-garbage &&
+	(
+		cd parent/head-as-link-to-garbage &&
+		git init --bare real-repo &&
+		touch garbage &&
+		rm real-repo/HEAD &&
+		ln -s ../garbage real-repo/HEAD &&
+		test_must_fail git --git-dir real-repo rev-parse --is-bare-repository 2>stderr &&
+		test_grep "not a git repository" stderr
+	)
+'
+
+test_expect_success 'setup: custom git directory with invalid GIT_OBJECT_DIRECTORY configuration is rejected' '
+	test_when_finished "rm -rf parent/invalid-git-object-directory-config" &&
+	mkdir -p parent/invalid-git-object-directory-config &&
+	(
+		cd parent/invalid-git-object-directory-config &&
+		git init --bare real-repo &&
+		test_must_fail env GIT_OBJECT_DIRECTORY="$(pwd)/does-not-exist" \
+			git --git-dir real-repo rev-parse --is-bare-repository 2>stderr &&
+		test_grep "not a git repository" stderr
+	)
+'
+
+
 test_done
-- 
2.56.0.rc1.12.g2c9c8d64bb

