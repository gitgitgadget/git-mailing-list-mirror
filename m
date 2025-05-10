Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FDF182B7
	for <git@vger.kernel.org>; Sat, 10 May 2025 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902059; cv=none; b=M9sFnbM+GiuhTekGz2IoWgFbP7SabnE8J9WRKyRNSlm4fPYCn0ES2Zz8ybGVUakc+riuN0XnLJ2xw/rw17x7Ufv8JfmTWgE75Ck01CzJSIYHfbim6834YvhHYNIeGU93jm3lkdPCJW/c7E1m2Yvn33nOM5tUnkVQY58vfQAAK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902059; c=relaxed/simple;
	bh=ZCjNGJhXmiqnzd2L1GKApvpyyBY995QQZS9WVHzVOOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0uzJTA/dP3LonO4omks+PcYgtJlUvare1Sxirb25x8Zn79YaZlKzxR8SEvrwzVNOYDPkCm0ZPaHXF1cU5mp/HzlZGtO3mOcuHiel/dZco35fBl15qzWzzgt6MyASAnirGvzZlw8XpahfnMguDn+NdYr8mwTg2862i/wggmahlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMz+qWLu; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMz+qWLu"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e72a786b1b8so2917857276.1
        for <git@vger.kernel.org>; Sat, 10 May 2025 11:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746902056; x=1747506856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7YRrTiQhTc7FEFlW0zxreJ510IqVyNe6b+yd+4WU5c=;
        b=hMz+qWLueeRbfW8v5qmF6PdnDr2YbMPk0f5Xn8Rw6vciWxwNgEX1wklneoi7BYQ9Mn
         xHLLxK194e+sTxww00vDnCssxwNY5mAxBt7f07E2W64bVe1WMM+WtinUgQQT1wirZNo/
         7N6HWB+HpB4VQzAjjzTFa50E0Ff2EMGbPh+7T6y8vgLgjQmssnxIBpO3mEDt3n8MFBSk
         gEVdvJOYJ7h1UJuZNn9/CHJEiKth/QkLdfBC3Nflb+JgeMJTSmWkIxoY+oQ9jci7MkZj
         tcwzppKPJKicsDkLwnnYOBzmx5oTF+XhoKXelQy7FfvDyg5jXKRaIt/Fr2fHFZij09LO
         MUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746902056; x=1747506856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7YRrTiQhTc7FEFlW0zxreJ510IqVyNe6b+yd+4WU5c=;
        b=kYkNFhQgmv1MTg7pTekSb8qjH2DAfVOsoFLUH1fJ7zbRBjoCZUI+QoxtAjYrDRsUZ3
         D/ko3pjiA5fZeZKq59lGCYIN7ExSm/RKS3+WbCMWVOQqr+RFWaso+n0PCi7UYcTowBwL
         qUB3uIPfb13322xcfwqFU2geyguqOhc0n+SKDdlk72E7Jl0qalcW4buqHjnbnj/UCYQh
         aYxKXkXHqIpN35cpVcXTB0+7eDQFq9IFYO5kJsIiO5Vd6nkTp7MwvL6KXGKTr8FRul8X
         njLMchp7QQwwyUDhGAxymKbHSSl4S6yqqtfMTvkjlsJi+WI2foE8e6/S/wHdjXDrBtPW
         oAMw==
X-Gm-Message-State: AOJu0YxpmtS8kBIiHL+PNUHzlUEsfscNi1Mj36TYd61dcGeMlZ99pkLH
	rTGTHTtvhmuMKC0gXhwQAXMZkO74MiEdazZxWMQemQrYAspu3JTwaMMUvg==
X-Gm-Gg: ASbGncuNpydJjuBvwTajpRQ5vn3CCqlLbQgRjDqVLIJ4vjUjIjvWOzxVxUD6ISUC2S8
	bZKfwqeDa/Bl/sAJvGWeGpW2nC6zBQ2kh/VADIKUQ8Q6xjQs/KIAj3KoaGyHXMtxIidBPAxwZQe
	x5qSUG6+hJfh+WNn5jziPG6ky3X44NEzq0pUY6hvBOX/4gJV/zorGyx9MaadBoBCAowJpEvJRI+
	mEI4QdEuQjZ+K250/EFrOiJg0ETsZ0Ei40HS/Grf61hq7dx2mnXWpO8Kyxz7syFZjk2B6xuyPj0
	J2J4Hkf2yl4Y1Cc08EydOO1u2EWiTwT8Dafz55HNtgppIBwnucUwWo1y0HRz1Y8QaWpjQnhUxgD
	/YQI1qZCISGdxYAqRALnpVT8d
X-Google-Smtp-Source: AGHT+IGCsays5ZtpfZGqRgOnh8T5JGP7s27d4v/vUExtLcofgsG0gJYkHQbs6DteJOHkiVnPglyZ/A==
X-Received: by 2002:a25:d8cd:0:b0:e78:ee7a:476e with SMTP id 3f1490d57ef6-e78ee7a4902mr12995515276.21.1746902056679;
        Sat, 10 May 2025 11:34:16 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a6:1600:541:bcf5:33bd:f1fc])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78fd4a72f0sm1191649276.20.2025.05.10.11.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 11:34:16 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/9] t3903: reduce dependencies on previous tests
Date: Sat, 10 May 2025 14:33:36 -0400
Message-ID: <20250510183358.36806-2-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510183358.36806-1-ben.knoble+github@gmail.com>
References: <20250510183358.36806-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skipping previous tests to work through only failing tests with
arguments like --run=4,122- causes some tests to fail because subdir
doesn't exist yet (it is created by a previous test; typically
"unstashing in a subdirectory"). Create it on demand for tests that need
it, but don't fail (-p) if the directory already exists.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t3903-stash.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 74666ff3e4..b8936a653b 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -895,6 +895,7 @@ setup_stash()
 
 test_expect_success 'apply: show same status as git status (relative to ./)' '
 	git stash clear &&
+	mkdir -p subdir &&
 	echo 1 >subdir/subfile1 &&
 	echo 2 >subdir/subfile2 &&
 	git add subdir/subfile1 &&
@@ -1327,6 +1328,7 @@ setup_stash()
 
 test_expect_success 'stash -- <subdir> leaves untracked files in subdir intact' '
 	git reset &&
+	mkdir -p subdir &&
 	>subdir/untracked &&
 	>subdir/tracked1 &&
 	>subdir/tracked2 &&
@@ -1343,6 +1345,7 @@ setup_stash()
 
 test_expect_success 'stash -- <subdir> works with binary files' '
 	git reset &&
+	mkdir -p subdir &&
 	>subdir/untracked &&
 	>subdir/tracked &&
 	cp "$TEST_DIRECTORY"/test-binary-1.png subdir/tracked-binary &&
-- 
2.48.1

