Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E351736A027
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981144; cv=none; b=aDOnwl0Au9IKNA3XBVnWhBjPiq2ZAsn453BIXk9A1gNLzNg/ALK8iGna70XCY7SvOTh5cSOw1IalBdqFL5UKu3WoYZB2tKv4yBDb/NybXKaHZ7T0O3o778li8ENxr52xTS2Cs+NrULZluQTNZDXWOAdB+UVn79q4eiP0UjilEn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981144; c=relaxed/simple;
	bh=rMV91nQ/tiBuBzSqZx+K8CebyVyDPsaXNDyDQr4XJCI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=s7NlG3DOQwAAOVlb3KNt8hfnXJ9EvrYAG6u3vbkKfcr8WBjLMKdAJJHoXhkt9h/K4ojBnJFoLwfgjTYorBSKYs//pZ1qRXlXhsmKAedUdHiOug0cMb6rMrZ8Ahzy64HgdBHc7IrQgc8+NH20deUg7pGzN9dLfJVMK2M8dLMBFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jyt7dLcj; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jyt7dLcj"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-656d9230cf2so3272227eaf.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981137; x=1766585937; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/ryRAebtMjjichxOsxJMCrKkQ/OBsBsdmGjLzGoEWY=;
        b=Jyt7dLcjyONiUMm7PIZ7eREt6gtNP30okdMLteCOuAjep1j5AiMYrTbNg9K7d/sgFH
         E7DXttJsr0PsWWVhAz0g1IM2ZPMaOFYgXdE8P1Qkp8chvSoN+LznxOp1Q4eZee9C+HL9
         Zt6SBWs3z5h9QXEJ9OvcQDsGvx64wceC7d+xNeyZJgtuguRjPwos5kPQbyhTjzIHmZGS
         46MCbwKdalVNfSdItj04iduyLpKsfuZwAvFwEPEKZ6GRPxHVAAnT1SFzmpg+rZZQV7U7
         e4QZeJGuQRFE4C3q6AqGaeHE+Qx4mM3Tqa85sLoBmHpsNhHvpV/6Pz97H/tst9Z1TtJG
         L2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981137; x=1766585937;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/ryRAebtMjjichxOsxJMCrKkQ/OBsBsdmGjLzGoEWY=;
        b=uKRQ7umwkF/2zbK1vn5hHdPtU+dgfAs9o8Az3/DwFLIblQYSzefyNGDBFbD9kD68lp
         Ha8f9qp9F4tLNOY7G40sl+6obYgmfa/lhX+n5X498K+3Uknsug2J+MjigDlw+p/mvxB/
         dGVymhaEfPiY8pVFp81omWnG7ywSmEJFW05gUt6ZMGvb17nVnmIBpz4XizANTgblpEyx
         IAuWBFFcl/k5ymYA7JuRES50OPU9tqaPjBQPHr8Swv1hgm5biXqy9i60n/dTr7vorXLK
         GxvtbCn5O6gm8oU4qM0A3HtE02hTZXY6z4CEgAphY6hmp26VRy2tRGb86MZ8oSO9KR01
         YZqA==
X-Gm-Message-State: AOJu0YyUazg94Lh1Otnae3vDI4lvjr2wqSTcy9S6z3PHcyQZC+Zr/XZV
	P0pb+qaZcYuthraYQUgjS6WmQ/lTvsz9iL6BTkixu6B/9La6gg86oofvZ4B5kfeG7N+C4g==
X-Gm-Gg: AY/fxX5O1oRR4duRdncUFI9SmiRUnDZ/vswVNv2Iv/4/DdTbn1pHdvpA+mG3t5sCjvE
	vVYy3434hXVhc7uID6sifCkbiO8phBzOLvXGchGvqIfCR7w6ED97yJrTLJXgj5blH+ZAbpZ3DUR
	I8Ogu+uDcmXoHYJap4sw1eK6P7rlbm3jC3qhPDipgVZocH+SGaXnAAdoNudZtaL6vzMBK8k8OPy
	hzf4QFCiiTOWgMCQzqIIKPlfX7iUkPXBZij91c5Zdz4PKpk2IrwXQ8kD7JPOUVYTe3q9c4PYi+q
	/F3rmy6gR6KpLhejcgqsURbFLNVEpZK/ZOa9h8V+NVDQNjVJ3hvJHTPcjVBSDKoHAj+n7GDmwM0
	u9IRKbSwsXC9EJyf4KglXNxaoleLxMTDtbaH97FXe3/R8zmumpTshgxPvZjoxUfElY1B1rcAaqP
	6E64uFqjYQIygj
X-Google-Smtp-Source: AGHT+IHU84vObTKZzkVDGfgu8WS3j6Y9TaQSlFGbD+u7ZidoU4pvuZKhCicRZS3b1jXZ4P2MB4fSdA==
X-Received: by 2002:a05:6820:1c9a:b0:659:9a49:8fba with SMTP id 006d021491bc7-65b4525765amr8774626eaf.51.1765981136865;
        Wed, 17 Dec 2025 06:18:56 -0800 (PST)
Received: from [127.0.0.1] ([135.119.38.57])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b360ab79bsm11291338eaf.12.2025.12.17.06.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:18:56 -0800 (PST)
Message-Id: <31ed59481c59727a95868a8473f1fdfe258831cc.1765981126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
References: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
	<pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:18:43 +0000
Subject: [PATCH v4 07/10] t1006: accommodate for symlink support in MSYS2
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The MSYS2 runtime (which inherits this trait from the Cygwin runtime,
and which is used by Git for Windows' Bash to emulate POSIX
functionality on Windows, the same Bash that is also used to run Git's
test suite on Windows) has a mode where it can create native symbolic
links on Windows.

Naturally, this is a bit of a strange feature, given that Cygwin goes
out of its way to support Unix-like paths even if no Win32 program
understands those, and the symbolic links have to use Win32 paths
instead (which Win32 programs understand very well).

As a consequence, the symbolic link targets get normalized before the
links are created.

This results in certain quirks that Git's test suite is ill equipped to
accommodate (because Git's test suite expects to be able to use
Unix-like paths even on Windows).

The test script t1006-cat-file.sh contains two prime examples, two test
cases that need to skip a couple assertions because they are simply
wrong in the context of Git for Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1006-cat-file.sh | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 1f61b666a7..0eee3bb878 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1048,18 +1048,28 @@ test_expect_success 'git cat-file --batch-check --follow-symlinks works for out-
 	echo .. >>expect &&
 	echo HEAD:dir/subdir/out-of-repo-link-dir | git cat-file --batch-check --follow-symlinks >actual &&
 	test_cmp expect actual &&
-	echo symlink 3 >expect &&
-	echo ../ >>expect &&
+	if test_have_prereq MINGW,SYMLINKS
+	then
+		test_write_lines "symlink 2" ..
+	else
+		test_write_lines "symlink 3" ../
+	fi >expect &&
 	echo HEAD:dir/subdir/out-of-repo-link-dir-trailing | git cat-file --batch-check --follow-symlinks >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'git cat-file --batch-check --follow-symlinks works for symlinks with internal ..' '
-	echo HEAD: | git cat-file --batch-check >expect &&
-	echo HEAD:up-down | git cat-file --batch-check --follow-symlinks >actual &&
-	test_cmp expect actual &&
-	echo HEAD:up-down-trailing | git cat-file --batch-check --follow-symlinks >actual &&
-	test_cmp expect actual &&
+	if test_have_prereq !MINGW
+	then
+		# The `up-down` and `up-down-trailing` symlinks are normalized
+		# in MSYS in `winsymlinks` mode and are therefore in a
+		# different shape than Git expects them.
+		echo HEAD: | git cat-file --batch-check >expect &&
+		echo HEAD:up-down | git cat-file --batch-check --follow-symlinks >actual &&
+		test_cmp expect actual &&
+		echo HEAD:up-down-trailing | git cat-file --batch-check --follow-symlinks >actual &&
+		test_cmp expect actual
+	fi &&
 	echo HEAD:up-down-file | git cat-file --batch-check --follow-symlinks >actual &&
 	test_cmp found actual &&
 	echo symlink 7 >expect &&
-- 
gitgitgadget

