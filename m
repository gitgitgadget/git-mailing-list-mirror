Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8AC187325
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744438811; cv=none; b=rt6wpPHNxkgrGzl451215+AS2/xcW+VqsVpnZyOASgs1/I5sb2WdfSjfLM8XilrQw11ugJi4lqygBMUKLHFvBk1ivgOrboWs7k6kvBx3pWrTgArZjHqJp0H6FKuWUHZ13BJFLAIEO8u+Pt5X9L27bKfcTKgDxNFPJz1Gmn8v388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744438811; c=relaxed/simple;
	bh=VIHFlbZJ5EcGYgE3I/DHFpwgQnWB3ftrKx5nE4nM3Q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tBOcqwHWQxncb4guCCJugAHGkYUQ8V4rWf5k3gzx+fEt8WOwwlVjJMIn4QOrVdBikH5PQXzm5AgIKv1SjO1QP828ecSdwp4heV5rmhfm2zyveUvrKqXLxDPTfEqD4C8p6/qML97E8ljZXnGHd6+cg4GzXwVzUT60T49zp5e6K2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THKkhMVn; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THKkhMVn"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac34257295dso517915266b.2
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 23:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744438807; x=1745043607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6LFMFYxN7a/od6S3FYC7IsTfp7IfsLHybQGNVTg/do=;
        b=THKkhMVnFGDI1B4rnKCaJOlbTcDR19Oky+lg6zwrH9jM1xPv1o6j36czs5Wrx1c8so
         m52L9i1Zmx4psgnrYnRUixR5uAKOC6QQEjEKhvSiWEIRtv/o7IK6wgOAiU4/SUOPycUi
         QFpiflE8Xsw1nQVOBopU/QW19P6+ctBbp44LC8WQpgKqSRjtf+5uFvHeHDOp+mloaVtD
         tla9PjStX8vpwG06YRD2YuorrI0BSXyNZ5e7C619j5owI3EEGwD8h0G/DUUuZ5oDmFPn
         pzS5es7Q9Div0LSx+ilNW6PKu/zETbEVDunXe4hQ5aYVUP5/UWX8JYx4Gt/e4beRjFZz
         3CXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744438807; x=1745043607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6LFMFYxN7a/od6S3FYC7IsTfp7IfsLHybQGNVTg/do=;
        b=tPJTpl50n+YL6RqDmNZVG0TqMjb4LU7c0DwJL8UIS51fopWoE3fNlOzieftS5v4Uxo
         A1tgsrES2StM1sTC0CIq66ry5qz34znfbdQXfyIlGWBm76jSNMjDn6KAdMsUdaNLnwt+
         8YztO4JG4MX1cphBPVT6pRNV72a43j4FCCvBbXIscJvurz5QW3UicvMg5838qPNhlJZy
         MyqTLBpxraetQwLiGqMCxzi/UAoO0aFBpKOHnqV6XNWm3o/clGhGbF6haiZH0wI1KWrF
         0+F6Y46S14B74cW5xJBq+1I8suLr2LrB5ARSFJILeQY8l2CdMe0UUJPYxqkp+DP0Kyng
         AsAw==
X-Gm-Message-State: AOJu0Yy7wEcPXyYsPqIa5OtQJjKHSUtHELYkWPPW2Y3eHi4/Rh4/QU0j
	yNXovgVjn72fMHCKFrI24dvgsU0DfSTUQ5/sPg1tg8+pCISgNXXWKjLx95V080d+Ga8=
X-Gm-Gg: ASbGncvCqconKBfCkQDfffS+bDAHpJqb58Rs/UZ3JTpGipoYW9Ez/5Wd1k0LhYoONlJ
	0eXW6cbbvq9Nbr20XvplMz8L3b2mktc3mCArUCYZerNyNQC9AsR8sjKNGIyAwMk4KLX6u1WUI5G
	2TuyKLn/9ElcWgJufpjof+yR67LalNKOL3Wb3hsS9dxgcCxcfAgTfnBUBZOWEBIUD8v4jqlQ0OI
	Y92N9sHgq7sJpDVNTFJBP3Qo9B0MXO38q5VMIq4dtLVzHCcDVYYGpP5EvNAoFEGtq1V+mHjKUNx
	Bf2a5olJADUelB+BoTvtM6O22WKXqcdrCjVTA6XE55WTKwiSbrXiwmBPWF/WsOPCSr0=
X-Google-Smtp-Source: AGHT+IHAehYqweg6CCkP7cc/n1dS1YnC1zP3H+Cc+qneIdLo5ELVxuILL4fZxvmCOjVrRDgf5GT3sw==
X-Received: by 2002:a17:907:720d:b0:ac7:d10c:1f39 with SMTP id a640c23a62f3a-acad3496121mr478905866b.20.1744438807073;
        Fri, 11 Apr 2025 23:20:07 -0700 (PDT)
Received: from localhost.localdomain ([206.0.75.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be9c27sm558519766b.68.2025.04.11.23.20.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Apr 2025 23:20:06 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Anthony Wang <anthonywang03@icloud.com>,
	Anthony Wang <anthonywang513@gmail.com>
Subject: [GSoC] [PATCH v6 1/1] t9811: be more precise to check importing of tags
Date: Sat, 12 Apr 2025 08:19:57 +0200
Message-Id: <20250412061957.81747-2-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250412061957.81747-1-anthonywang03@icloud.com>
References: <20250405103718.25160-1-anthonywang03@icloud.com>
 <20250412061957.81747-1-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tests use grep to search the output of `git tag` for tagnames they 
expect to exist, which can incorrectly pass if an unxpected tag
has the expected tag as its substring. We fix this by using `git 
show-ref --verify` instead.

Additionally, we add a negative test to verify that a possible
uninteded tag does not show up in the imported repository.

This change also fixes the original problem, where piping the
output of `git tag` caused the exit codes to be lost.

Signed-off-by: Anthony Wang <anthonywang513@gmail.com>
---
 t/t9811-git-p4-label-import.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 5ac5383fb7..39856629c0 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -95,9 +95,9 @@ test_expect_success 'two labels on the same changelist' '
 		cd "$git" &&
 		git p4 sync --import-labels &&
 
-		git tag | grep TAG_F1 &&
-		git tag | grep -q TAG_F1_1 &&
-		git tag | grep -q TAG_F1_2 &&
+		git show-ref --verify refs/tags/TAG_F1_1 &&
+		git show-ref --verify refs/tags/TAG_F1_2 &&
+		test_must_fail git show-ref --verify refs/tags/TAG_F1_ONLY &&
 
 		cd main &&
 
@@ -207,8 +207,7 @@ test_expect_success 'use git config to enable import/export of tags' '
 		git tag CFG_A_GIT_TAG &&
 		git p4 rebase --verbose &&
 		git p4 submit --verbose &&
-		git tag &&
-		git tag | grep TAG_F1_1
+		git show-ref --verify refs/tags/TAG_F1_1 &&
 	) &&
 	(
 		cd "$cli" &&
-- 
2.39.5 (Apple Git-154)

