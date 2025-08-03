Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFD21EDA3A
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 21:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256326; cv=none; b=JFH/140UwBIk5N/g0f6BeTNzlhYc0J/YiUJMI8i5Mtn5YIY0f8Yvd/OA1Gjo+5JGEMP4OiyXGJgd8U5eHAwnzT2xgTfb/wQHbbwK1pWTCqQiigUpOThHWx4B3CqmG0Sxu2HDxbBwZzNFssk73OQAeVkpRizKyyj3V/W+P6m21h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256326; c=relaxed/simple;
	bh=OW/Saae6YoAWD2SQmBRu/B13Gv3kz2esMzaGEaRMTg4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lCc00z3fczEv9YI5u03Kg/AZ6NMqXnpqa5LJuDSANcPiruwFIhZwZbdUScQrf0AWSLvq7OgDvh1pDtWMD5R2qgDd2ZHd3/CtkeVBQNZ/tfFiCG/p9+2ClZhis6j5mq+UwIWb1BiDVfQSUFPe63ZFnULGqLWBnEZLD1OLaeX0egs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiFhCNJJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiFhCNJJ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae9c2754a00so932329266b.2
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 14:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754256323; x=1754861123; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJGJ88Ub+A0bLjV5eNpWDjXN/IhHezpzncWa15ImXXs=;
        b=SiFhCNJJvQenqadEe1+cOrpdfBG7itrEHuvxH/tioi3LN4uvYOJUvvKuuGtL3cHDB9
         Y2aY32lrVtc8AvmKrH1wVc6Ju1tBbNXEDKGIdG2kGaiLSA7QJHv5LUg719s6uTdW3uhR
         MilNk8Esr1WSB4XBQQnGbSXJOrvMkcwrYDT9UDgVEAY4yClSRyOyL+gRm/3ez6Yqzsg4
         2SOqLAj2IAiGOTBcMrW/HScevCxdsvQK0rOPM2hc+MfQ6nb07Ho4ZcLuZLtXjtklzYL9
         Dd7QA7CE2blSsFFTEniBCiGFo94pHBlOnpwFouRMjI6lqxAcvEZz3OGWlb2sP8nxlVKW
         GF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754256323; x=1754861123;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJGJ88Ub+A0bLjV5eNpWDjXN/IhHezpzncWa15ImXXs=;
        b=XSF45hGJ9t8S8ddMA9i4NLyA4rjRShWT78KwpSU2zQloJIY+4jIf5ll7YJyDUSE3rq
         RCvrmymDFjNNdU1g2C/8U50r0cbla/MfMUYndcOkWvNzvMzNMM4zEr3Ovs9M2aQl2DL2
         rfLGnhVC0m333ImUVejSRdbdXtw3nkWbBF9rzNPep6hEwaJztmWZLJvfxz0QqijIrHA3
         ex1bn4eyUbBRddqLuAlFT4d4ykyl6xJDBq7Gqq6nPQAAuAsmBQkwTcpkYp9HqPY8A4L0
         ZO0INY4pxyRYxhhuk/dKNyV1/QVg1LEKzSr7LfZmC+pjEoSfJ+c0CC/4GLvzoG/gRgSO
         lJEQ==
X-Gm-Message-State: AOJu0Ywk/AM14ym8KPNl7lp87jCa6t33SVoEKaKz4wFWGIctc7mO86NK
	9sXDCPpYWTfIguAAfQFpwT3pNTRLr3ekvb+l+FVFyjVW5dJPemLiwgHe0TKLog==
X-Gm-Gg: ASbGncs1rGi9NWIX4DIDXXiXbLLdyMC65yZkn0xqzG+j140Oj+JcqHQRWaMShv9Vw25
	dNC+Yx4ESAKqtD26ojLTqhbpQhpkUbEFtWGvnV0Ro7vilYFrfgDpP7VX04nt0J+7ms9fh5oVV0p
	58fOV3nbYxwSnAKu03d7VDvIhwDKyg+Qgz3cqhmTp28zQWBHAS09RIDWjxS+DA+yeWPaCu8vcOZ
	XW+d+sxCS46+DUviF9659tJ9L1MfsTd0w0W+Pz+TWhgqBPaOxWdoI/ecS3p0rgdOc4+U/vV6Z18
	ygzfsIi/VP1TsDvp1WP5ppB2PJZ8bv+EyCjKfI72Lpn5hBeeloroQa36X6EKfDEETZ6NUwi2z1Z
	8pNas5A5GlWM4sLeOXYFj8VM=
X-Google-Smtp-Source: AGHT+IGuHLMZBhc4D85zbnpEVWZWzlV/5zx2GpIU5ptVLyLeC2uzQbw+C+ls2Ev9f86VXHpj6vFmNA==
X-Received: by 2002:a17:907:9812:b0:af6:34ee:8a79 with SMTP id a640c23a62f3a-af94016b62dmr763962366b.36.1754256322945;
        Sun, 03 Aug 2025 14:25:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f00252sm5866165a12.8.2025.08.03.14.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 14:25:22 -0700 (PDT)
Message-Id: <51113ab9b81555387d5c4083b3c0ec3b0c2d2596.1754256318.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1948.git.1754256318.gitgitgadget@gmail.com>
References: <pull.1948.git.1754256318.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Aug 2025 21:25:18 +0000
Subject: [PATCH 4/4] mingw: support Windows Server 2016 again
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It was reported to the Git for Windows project that a simple `git init`
fails on Windows Server 2016:

  D:\Dev\test> git init
  error: could not write config file D:/Dev/test/.git/config: Function not implemented
  fatal: could not set 'core.repositoryformatversion' to '0'

According to https://endoflife.date/windows-server, Windows Server 2016
is officially supported for another one-and-a-half years as of time of
writing, so this is not good.

The culprit is the `mingw_rename()` changes that try to use POSIX
semantics when available, but fail to fall back properly on Windows
Server 2016.

This fixes https://github.com/git-for-windows/git/issues/5695.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index d53ce38b7f82..8538e3d1729d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2277,7 +2277,9 @@ repeat:
 		 * current system doesn't support FileRenameInfoEx. Keep us
 		 * from using it in future calls and retry.
 		 */
-		if (gle == ERROR_INVALID_PARAMETER || gle == ERROR_NOT_SUPPORTED) {
+		if (gle == ERROR_INVALID_PARAMETER ||
+		    gle == ERROR_NOT_SUPPORTED ||
+		    gle == ERROR_INVALID_FUNCTION) {
 			supports_file_rename_info_ex = 0;
 			goto repeat;
 		}
-- 
gitgitgadget
