Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857867E8B
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992989; cv=none; b=qLaPEXC1AqukkcCHIYccHb1PO+aihyrCl7C/yaSbOXXYWgOc08g4vECx8Qbefbxx2EaIw2iHdrRtEGkCJxMLLVZmaW8LM9qEbzyjdhlehhEUyY/k+5Qu+wknv/B9FZTWUFEEz54yhtTDtAKSYM13M02wwcO37YFjDfEvo2RxD/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992989; c=relaxed/simple;
	bh=48ZWlc/Yda+cZzB3XEMcFzvr4+7U1E5c2U8R097Wizw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MAUAqLjKv5eBUjaSRgIMOvRjE8UgHRVuHFLw3uXH5ELE12Ch3kL+Tugb9q1bhPmWZl+vq695DxQLroaGLqxikTsRHK8qg87pTyNvcPQQMt4JxpM0+DuN/ko4hZKazjyKs+WiX5nsy8R8IzaO5NoK5pAVCdQqo+LDCae9usQr8jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrtnLLfF; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrtnLLfF"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0d95e8133so8471261fa.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 02:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707992985; x=1708597785; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woNBiHr5qG8RxFN4DSTN/Cs6jhn2/eAzflaZYKpV0Zo=;
        b=RrtnLLfFa2fzg6CYSE47haifIdiVQgPpoiBMlnpfj/cb1mosE/UMDBtPoGFhe1a1e5
         UvBkGakqPpkeqt013OY7mtV3BV8gPPdPrFLpUx8WhS+GuzJW9v/4ade/z4HM8W/VP6te
         QOepjX7WyaEzltt7+sArLiR3cx0MxYW9Txu9QtzhEACeVBZ/tRo65Atscwy3kKSmOIGT
         67jv0mGkMSsABDuHLzRgF39CvVuWZZLgCoYgZ3F1eGFMO903FcujgdGllG7L1xJdwqK/
         4uxyP0wuyEpnL/NX+8rLFqmAlWTl0xmJjrYxsM+uP4IZjnNoY1Bg+i2z74Ayz+AFaZK8
         m9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707992985; x=1708597785;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woNBiHr5qG8RxFN4DSTN/Cs6jhn2/eAzflaZYKpV0Zo=;
        b=jnFc/9DUy5soQqms68JyEYP8AgVP/AYqfvIIG19FqAJf2GvOROTm/p021vqakt4SlJ
         UbemDVm1Hy9BhkSlLJ8nrBnFb7O2nwrgy8hT02pZncu3x6+ma6ZYCrRTWSbW290+ghLH
         ApCHlFgdmCPxPs3FFjbw4yVZWPgmuz5y7EjHStSnRRCI06MvXb5q5MNRNtBlr/rE2nnq
         oHa9cPeJ50f8LaGjmnUyUnsib1lIS9YvqxWauYm/mOoy/hqu8BgGg6C88I+ApU4VHvxu
         izskerom6GIyEIHcICca0EDmG03oNMYCuorYK8kqd1otBak+ga9OxT5Aly2S0UQTRHMh
         ArzA==
X-Gm-Message-State: AOJu0YzuyNBuGdBU9+QT+BHDf4MTJJzHEfko4xXXH5RSLVnXrRI9Lz3D
	18tz7/abcy0aVerRgbl4+5splz+cuz8XlHXxnros5/Xr9dCC9cL27appw3AM
X-Google-Smtp-Source: AGHT+IG6UHw75Gscz6PilpRBs4kOH1wGakWmbe7POxn85uko5XPliwWQr/6sc+oJx8j4UdX3fwq9Uw==
X-Received: by 2002:a05:6512:1289:b0:512:88a9:5d0c with SMTP id u9-20020a056512128900b0051288a95d0cmr874746lfs.15.1707992984520;
        Thu, 15 Feb 2024 02:29:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c211600b0040fddaf9ff4sm4602009wml.40.2024.02.15.02.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 02:29:44 -0800 (PST)
Message-ID: <8c10bf49b2537ea01035b21ffc1a011a7110d823.1707992978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
References: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
From: "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Feb 2024 10:29:35 +0000
Subject: [PATCH 4/7] fsmonitor: enable fsmonitor for Linux
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
Cc: "Eric Sunshine [ ]" <sunshine@sunshineco.com>,
    "=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason [ ]" <avarab@gmail.com>,
    "Glen Choo [ ]" <chooglen@google.com>,
    "Johannes Schindelin [ ]" <Johannes.Schindelin@gmx.de>,
    "Taylor Blau [ ]" <me@ttaylorr.com>,
    marzi <m.ispare63@gmail.com>,
    Eric DeCosta <edecosta@mathworks.com>

From: Eric DeCosta <edecosta@mathworks.com>

Update build to enable fsmonitor for Linux.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 contrib/buildsystems/CMakeLists.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 804629c525b..61ec95c8507 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -304,7 +304,16 @@ else()
 endif()
 
 if(SUPPORTS_SIMPLE_IPC)
-	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
+	if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
+		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-linux.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-linux.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-linux.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-linux.c)
+
+		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-linux.c)
+	elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
-- 
gitgitgadget

