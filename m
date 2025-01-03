Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EEA1F9ECD
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735909306; cv=none; b=MhojYSQxo4tvDwEICMJ1eKZ7BQ7luAQcPCH2zX/2OE8CBNrW5lPDiiLxw0hwMRn1rN2v0JBMs2k/IXVfCxT8vGcWRcik3oGWmRUPPkVMCphABFhRutiiBSPBfXn+LGbcCL44EEuIQSMO2cxp40H6lWN+lIEsl+DICD90IqcyA7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735909306; c=relaxed/simple;
	bh=bY7vsI2GSrIl5fBjQCoTn9TQWe5SICcfgNHASisfazY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QdgSrFEHhV8ZZVxUPzZGfQAOLHY+VE0JpgbK2/pkhht0wnEP2KJ2AlsGi6xdojIoqsVff7e2EcW4NIx3Pr61Q3p/eofHH2kAqw50UyAFGXMrqu08lBT9QGCbM/YcVVEfQgMa132QNTISNKMlO+4mhcTnFFwcLiSuUaFv3nd3rQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3oHcOSU; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3oHcOSU"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaeecbb7309so1330928466b.0
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 05:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735909301; x=1736514101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeeQFvdrawwIpZhmO8XPc+72lZcVQ/GU62Xzmh1D3PY=;
        b=g3oHcOSU/PKRIPdcymm9ZymVAFFONh4X8graf0ZyzaOAb6wF3rlFHAo80UdHX5/H4d
         Nnz2kLL6hjQlMyvjyG6pRwiXDpLzXJ1ZcWabjMFGVMXtsU3wb2JtEGuU5X57xsgu2mR7
         Ii/H3C0KJBYRE/BDjGS4xCJJabiEkFzyAfNhprAdlzTJGWZEBdW7ZoTE2X1OOdn7wlj6
         d6j33KcVkPodpJlBh79bFH8xFpbFTJAXYdO6uANyuFfVRKbWbjNjhv0PoN2PfbXsKkrt
         XNujDvKnVmXj1mXMce6NJzSOT95ejkYgkGxHXYRhPVY8Du6T3t2CCQAcdigwGzqxdzR8
         mdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735909301; x=1736514101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeeQFvdrawwIpZhmO8XPc+72lZcVQ/GU62Xzmh1D3PY=;
        b=ab6TNXEFw56Yq6gd+gbWo6GRtPl6fa8OSQg6seLqPPgAsx7K49aZY1HdM9a8mTyB3M
         rfrnr7PoVEv05cah5sTpVVPng4IMlbsqR6M+1SiyaDybTpsbCnzgaAGbv/X4Q3s2W2UV
         cSkvXAgr9MrhrAWJvpFf3HOvJTnIIsiq5tSvdfhBKIJxPOEherPBYwsJbZ2mqFa4Ka+B
         i081kw3RMHgIgQI3pJbS7f5JAGgxQjUhStUMbpSGqv93gfPMg5YNl1nIFZS2fMTumfQ8
         0x3u9WtDfd2oWm7Lo4AmRf79vG3D882TM7scZ2M+Dlw1Y6O7IvVdlENZcr+cppfHq74o
         eruA==
X-Gm-Message-State: AOJu0Yy5wBngmvIGDy9QXKKzqmXe3w7ktljIEyvV0tOjs5gnkjyJa/5j
	ZTQiK1rKvgXdsDzZv+B8p/WyrWNJtooll2MMPBg1cyqLZafaCVLy5qaRln6f
X-Gm-Gg: ASbGncte4+rETupo2rwJQLF5k0r9dP3XUiecWwZxIDV8ld7PLXJ10kCdR0o1kCO4aQI
	745HmL40RokhqNintBp5s8nDmlP6BCTKjFZcJIXSyJon8ca5vN2XuEIDrJFbiP6C/uySdPHa3HD
	cMp2Wz2Qf0vyYTc2HJNXk08uHYrvdgXac6URGu/Ge2scS42LFynXu//HXc2QkVv1iHO7Wq32KV2
	wze4lwl1svVBHE85lzRdKMN09yPq0BhbNk0/7Qcia0e1S/nWSPsto9PbSbxN1yavvjs8hKei/S3
	E1M0UKESZPc3P7GRt6MpSCSV
X-Google-Smtp-Source: AGHT+IHb915kvemUmgtIw6/NlIKiChdIWK9FVogzJKD4EL5k6X65MGWX3WyIqlwPetLHhmxKSy4PxQ==
X-Received: by 2002:a17:907:2cc6:b0:aa6:23ba:d8c8 with SMTP id a640c23a62f3a-aac270270b9mr4186846766b.11.1735909301288;
        Fri, 03 Jan 2025 05:01:41 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:646f:3ee1:44b6:64:cfa6:d56f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82eb80sm1894890366b.34.2025.01.03.05.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 05:01:40 -0800 (PST)
From: Matteo Bagnolini <matteobagnolini2003@gmail.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	johncai86@gmail.com,
	matteobagnolini2003@gmail.com
Subject: [PATCH v2] t7110: replace `test -f` with `test_path_is_*` helpers
Date: Fri,  3 Jan 2025 14:00:35 +0100
Message-Id: <20250103130035.79376-1-matteobagnolini2003@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <Z3fM1bT2Z_0GoD4w@pks.im>
References: <Z3fM1bT2Z_0GoD4w@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: matteobagnolini <matteobagnolini2003@gmail.com>

`test -f` and `! test -f` do not provide clear error messages when they fail.
To enhance debuggability, use `test_path_is_file` and `test_path_is_missing`,
which instead provide more informative error messages.

Note that `! test -f` checks if a path is not a file, while
`test_path_is_missing` verifies that a path does not exist. In this specific
case the tests are meant to check the absence of the path, making
`test_path_is_missing` a valid replacement.

Signed-off-by: Matteo Bagnolini <matteobagnolini2003@gmail.com>
---
Sorry for avoidable spelling mistakes.
Updated commit message according to review.
 t/t7110-reset-merge.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 61669a2d21..9a335071af 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -270,13 +270,13 @@ test_expect_success '--merge is ok with added/deleted merge' '
 	git reset --hard third &&
 	rm -f file2 &&
 	test_must_fail git merge branch3 &&
-	! test -f file2 &&
-	test -f file3 &&
+	test_path_is_missing file2 &&
+	test_path_is_file file3 &&
 	git diff --exit-code file3 &&
 	git diff --exit-code branch3 file3 &&
 	git reset --merge HEAD &&
-	! test -f file3 &&
-	! test -f file2 &&
+	test_path_is_missing file3 &&
+	test_path_is_missing file2 &&
 	git diff --exit-code --cached
 '
 
@@ -284,8 +284,8 @@ test_expect_success '--keep fails with added/deleted merge' '
 	git reset --hard third &&
 	rm -f file2 &&
 	test_must_fail git merge branch3 &&
-	! test -f file2 &&
-	test -f file3 &&
+	test_path_is_missing file2 &&
+	test_path_is_file file3 &&
 	git diff --exit-code file3 &&
 	git diff --exit-code branch3 file3 &&
 	test_must_fail git reset --keep HEAD 2>err.log &&
-- 
2.39.2 (Apple Git-143)

