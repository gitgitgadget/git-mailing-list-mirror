Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4054E36923B
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981147; cv=none; b=Uf5HhMI2sxVvCdqeuv1+lbWk/QLNovtoyDekEeADdpnoG4DgDhHBlv+0CAiy/lhOPmjtU5BaKOYVzBwlbKOVqoRnEItsIm+4+EQeAIbkLJBM78QxmCMiNvgvrcJIAh2fT78yqYu2NavxJZ7KtEY87WCf590sAKwSr2S050Kt574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981147; c=relaxed/simple;
	bh=miKtS8gVeLBQxEb1qhafBvJeGFIR8q5A5wiQrIWCScE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A+Ju3yx9OPO8xu/bPcX9m1RqMICwlpFgltNSiUCQqFG3bV2dzd5I3ZnJMJm71kzOxAd/RMIS3XIn9fWNaG4Bui870Fo6hQ83ZXKP3a2kvmYbly0sLeHWhkmP4XQuOis12PpcBK8hkFwgIanMFjK3g1MZ0fN7B8jtAbDO2vHP7rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwPvjf5K; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwPvjf5K"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c6d3676455so2662909a34.2
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981139; x=1766585939; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDI6RHdU35FaQH8EQ/fZmzFLT4U35ZFph/RzRv+jlX4=;
        b=FwPvjf5K8X8RdRDtykDVLa3gLjqWe5Ly7B066lEclYODvQaOogu5KSzwwK/Mz9Vx4p
         StCSRuLrJsfvqff27Tbue6yyKECnFMeVM8767J4ox7sOiInlSckBI27/DC830CQvhBVU
         8yLbyKzqBUnUTjp8J0BeTayLkL+QF+WCGnXm8ycyodHzbQwofNev7+TDlp/o2AijNYY7
         PBSvMKeHPhF87mIbiHgSM3nPyfv2Ar1l0ktFpp+f3IkOaSZI4TQTNbidnC7/R11ZvyDH
         UqX7Mx/ViveaaKystAGxrfuCbr4834HNecfO/Qyx8RX0A1ICNX/qiSKp+Mm/BkBn8iXX
         7gyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981139; x=1766585939;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rDI6RHdU35FaQH8EQ/fZmzFLT4U35ZFph/RzRv+jlX4=;
        b=ENtMyCkOVFWDBYBMxLysKqBIpgLQuGXlQa57J+da53YMpsL39h43G9dOG9AVluk5l7
         Q4q/YGHEWeip45fwCTVGY3HsUU/CSL5j9ShUrIGVrGuYnveLDpFe3n1uqZE/Oas2OiJT
         Lt0XikYtdgAZhHVoIiqyKB5Z8juMa1ycQJ89QhtT8VBWt2iIxBBpJ0+7kAuJPnwFDr+0
         woJlDu1gKKS0IhAFLw4XKMVf0eVXMsdK661nH4oBAPhpaQTYf/xyMy2q1zSpJISyfVrB
         Sd/HhTP4TbN88QX3T9pA3ci3XXAhRWpxyvPa+6ve6w3kyCxkZS+j/NQohghekbMU1JEu
         3Z6w==
X-Gm-Message-State: AOJu0YxWD2adTreypmLiW1nww+sHFATknKNJFpPvfEj3po6W/wimfVuL
	sVF/zFnJVGNXCspVksH4X93yCxBNA0CtBBcEMkFakJ7gZTOtMM8uVgRUab2zKj6DsFryPQ==
X-Gm-Gg: AY/fxX7VTiQ4V/7g2frt00+n38gvUlwbvuq+83ef60k6Apz5p+wZSz2pSVzeTOuaqk1
	qrqN4Xvr2SAs+/yLsUSur6ro6gYToBioFcF/iJ2hLG4NllSRCVY+D9ce4ossBWtMFeWNtkl3FNl
	FMbu1RQVmwPZOdAn0rFBeLy0yx87l6CgRY+wDLIKFe1MOyEytKsSLMye1LUyyEQuuhfRYJ2TLnF
	MDN3ovYWIzHmrSbuniOq0mmzACsW5UplCpz2QxrQQRSneaT3tcovZpaucRZgWPdztEuMbGAASco
	bCShoovT6RRk5Z8NFTJyi6WO/pumxKGr824eKEjtRgFhoD++/YCZTmkvF8jd0Lbxm5+iaikG8oh
	UKkhXMGWQYffII46M60UQ/4gMN6vD62N7cH2gw6f4PpaP7Qfi/ZLIC/Gi+blt00ioy7sntBvfQV
	Nr9o94UnDqsVo7wLgQfHueq4g=
X-Google-Smtp-Source: AGHT+IGTOYpNlq+2OgaCxe4r9FxYspo31+clEFf2JgWp6rj7AUfYNvKfRsGpAMm+xSogD/CdDuLOIg==
X-Received: by 2002:a9d:615c:0:b0:7c7:8060:e197 with SMTP id 46e09a7af769-7cae838f604mr9824651a34.34.1765981139284;
        Wed, 17 Dec 2025 06:18:59 -0800 (PST)
Received: from [127.0.0.1] ([135.119.38.57])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb1d0facsm13675635a34.3.2025.12.17.06.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:18:58 -0800 (PST)
Message-Id: <e604ace822e4f9986a212bbc4e491f2e9f096510.1765981126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
References: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
	<pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:18:45 +0000
Subject: [PATCH v4 09/10] t6423: introduce Windows-specific handling for
 symlinking to /dev/null
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

The device `/dev/null` does not exist on Windows, it's called `NUL`
there. Calling `ln -s /dev/null my-symlink` in a symlink-enabled MSYS2
Bash will therefore literally link to a file or directory called `null`
that is supposed to be in the current drive's top-level `dev` directory.
Which typically does not exist.

The test, however, really wants the created symbolic link to point to
the NUL device. Let's instead use the `mklink` utility on Windows to
perform that job, and keep using `ln -s /dev/null <target>` on
non-Windows platforms.

While at it, add the missing `SYMLINKS` prereq because this test _still_
would not pass on Windows before support for symbolic links is
upstreamed from Git for Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6423-merge-rename-directories.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 533ac85dc8..53535a8ebf 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5158,13 +5158,18 @@ test_setup_12m () {
 		git switch B &&
 		git rm dir/subdir/file &&
 		mkdir dir &&
-		ln -s /dev/null dir/subdir &&
+		if test_have_prereq MINGW
+		then
+			cmd //c 'mklink dir\subdir NUL'
+		else
+			ln -s /dev/null dir/subdir
+		fi &&
 		git add . &&
 		git commit -m "B"
 	)
 }
 
-test_expect_success '12m: Change parent of renamed-dir to symlink on other side' '
+test_expect_success SYMLINKS '12m: Change parent of renamed-dir to symlink on other side' '
 	test_setup_12m &&
 	(
 		cd 12m &&
-- 
gitgitgadget

