Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C857543635F
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307514; cv=none; b=bWeXOL7gwbIppQ0m4lHqU7XrgYb2U9klo7eYOgJ2TRK8GJgmgGQ5kA3x0OllI24hu0hI+WNhlgoIMvr7YX+x2ZDnD/D6/nvKZAHWMSUskTaIVGWB9fEOaPVbKVYAwWi6+iprk6b+anF3w/JyBG+o5PEfU9imXET62adSiGrFYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307514; c=relaxed/simple;
	bh=HZ3PXWAcELwp6dGZhEmPK6K5I02H0xdJoS0haJP6BYY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=sxS/fNnw98u42KaVbmVSJPjSYkmEBJqk0U9L/RkxGH8eSPnVua0WriBCPPxVHzeZajTu5X51NF2QjUHO7xm+J0ciEbwmtmLwIZC2f4CgXKv1Rp6Zxg8hZu/eIvLc2lQMX8EqcRbPILXE4Sv9a4Yny5nGLn8HwUZVQYMeD0C3gNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwFKmV8I; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwFKmV8I"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12339e2e2c1so656659c88.1
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 08:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770307512; x=1770912312; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VsWH5VhVrzQGmzhAClDRazQJEf90LQoLuslRYSy2eH4=;
        b=DwFKmV8Ibz90awoB7m2XDS2eOR/0GhIx9C51NAsPUFLhkMORBIZw248q2z386AQLpt
         ij2z+IJ9FDuuEZADaD3CcyIZ1wRwrAQO+WFS6E1ME0HiZtcqMRVFCB1GlwHX7o1fcnAY
         fwMCMFOo3P8ssv4pm+3JbF0U8a3HxmQA5zj5PxPGQpUMOWiy3wXy/plRZiADTuDPr1ma
         ulBRq2NU1peCvbF4jDWQ28zhf+xIRkefjy3f3YQXAY6gGNQX9pANXP49ru9nK2PYQDJa
         9RHzP/G4htLmldIpw8gY6430e14MuzCVN9yUIqbksVMI4r1Ep2FL0oFnFN3GYWkFar3l
         eo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770307512; x=1770912312;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsWH5VhVrzQGmzhAClDRazQJEf90LQoLuslRYSy2eH4=;
        b=PGeSjEKoSuUVU8jAbU2NRWytgSi8iVSC7awP34BYOoZgsrmOcZno03ew143q+BTg5Z
         BXeRN1y38RFJwi6PKgrW+ff3WeNC+iTXzkvT55kZySELidl3rTCaXcBn1/YYATjpLUj+
         FSUBrO/1RHXzJNWd8G1jL6tizt7IPTy0AUf0dTWDz8ftW8JytEOTLTENpWBk3Jtupx0q
         SHMpGP5k71jIBUkhw/0wBtrKOzhANduD//+VRBTbwBUpmR29lEYpSc6CaoSc3mclzJI/
         LcIJtNl/cQZVnXXyaL+bvo2mV191D4X0ECC7rGD3q4zswbHNz2bO8tvrIXJcuqWzIAQV
         2pAA==
X-Gm-Message-State: AOJu0YzsqosSh7+8BeXZybSFeLtl9WIqNM6lm207b6nwK8qtFo9GEI2V
	zA0DKwN+F2xLwWONfBbNqHmEJKSp9jMknfKsq/ThHiML6Mu7tUSFZwwT8le1tw==
X-Gm-Gg: AZuq6aJgMBO+KmLFSR6NZYdrlloHkP6cqBTqNr1LlWTDxx4bXQwsrJMJAFjnQd6NiID
	MKBLcRDbDhKQMsM0zMbWAlVHhP+eRZk/9o/nAulZwiS49ndS4DJy87mqS/bCkLeqKZq6/qJePD2
	4ji03swPwPW+0Z/Jh+gl56ZtVgk7kuop7Lb50FJ9u8RkORoF86EsIQk6butC3byf2t9wOgLMJ5I
	ZfOd7w7BAkxHu9DiOJRWsNNZg0MiyXf8RZal+SeStojrw0/tOKpJiiaG/5gsl9Lhm6+9RYyd172
	4ktWzGZUUeXJ7MBcDO1pQlGInTvvjU5zYG9csGTn0yakz2KKYgBzXaGidi3ckXMzCCuhUabRotk
	bwpGeQvRL1766ZRI3/LlkrBEpkwzbhURgY8n+yZsE4rWB1yDDakCYCQEYID+TZQLoU7OBMFhy3l
	oKhHwg7fPD2UEd9Q8=
X-Received: by 2002:a05:7022:504:b0:123:35cb:96d2 with SMTP id a92af1059eb24-126fc30a808mr1339115c88.21.1770307512313;
        Thu, 05 Feb 2026 08:05:12 -0800 (PST)
Received: from [127.0.0.1] ([172.182.194.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832e1298esm3601652eec.3.2026.02.05.08.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 08:05:11 -0800 (PST)
Message-Id: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Feb 2026 16:05:06 +0000
Subject: [PATCH 0/4] trace2: add macOS and Windows process ancestry tracing
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
    stolee@gmail.com,
    johannes.schindelin@gmx.de,
    Matthew John Cheetham <mjcheetham@outlook.com>

In 353d3d77 (trace2: collect Windows-specific process information)
Windows-specific process ancestry information was added as a data_json event
to TRACE2. Furthermore in 2f732bf1 (tr2: log parent process name) similar
functionality was added for Linux-based systems, using procfs.

Let's teach Git on macOS to also gather process ancestry information, and
emit it as a cmd_ancestry TRACE2 event.

Furthermore, let's refactor the Windows implementation to align with the
Linux and macOS versions - by emitting the ancestry information as a
cmd_ancestry event. We keep the older, custom data_json event type on
Windows for compatibility for consumers of the TRACE2 data that use the
older event.

Thanks, Matthew

Matthew John Cheetham (4):
  trace2: add macOS process ancestry tracing
  build: include procinfo.c impl for macOS
  trace2: refactor Windows process ancestry trace2 event
  trace2: emit cmd_ancestry data for Windows

 compat/darwin/procinfo.c                 | 99 ++++++++++++++++++++++++
 compat/win32/trace2_win32_process_info.c | 58 ++++++++------
 config.mak.uname                         |  2 +
 contrib/buildsystems/CMakeLists.txt      |  2 +
 meson.build                              |  2 +
 5 files changed, 138 insertions(+), 25 deletions(-)
 create mode 100644 compat/darwin/procinfo.c


base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2040%2Fmjcheetham%2Ftrace2-macos-ancestry-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2040/mjcheetham/trace2-macos-ancestry-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2040
-- 
gitgitgadget
