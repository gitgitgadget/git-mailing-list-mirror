Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D61411DE
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720904914; cv=none; b=GcumEATxoow0qPiord4GQOV3JJ33qSyGiUyAOKFyo3Nj4QzxDZx8a/FsqEqzxif/n0L2TVxN2S/3MFjzs5TheILiNlGFeBfSk5Y2dSFFCF/Gm8Wdpg40HKPbEKqGV/1psG+xkDrrAdP6k9vq8gNPh28Kv86qHwJfMUA+ddb66bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720904914; c=relaxed/simple;
	bh=X4hE+H8Z1mDrZwOiKzXK0l++3FlajlA8Z1GvV7ZqIAg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ukgRAiO3IFJe+dIiSbW1rMKpXaRL3lkk8uKT7GzdOjSFzHMJ7nlzI9EX54xO1noNt4wXrI2vMDGQtGlS2JJZD0hOJTNVvLssCHApUzexCxdDf9WsS17oS7s6J56Xz1ITajkAl3fCJamuinreYb5kEXFEqGrGOgcxj5pEC55eVU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKJc9CCq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKJc9CCq"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4265c2b602aso20416745e9.3
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 14:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720904911; x=1721509711; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCqo5imxUdi2MwtXOaJpLZGB4nbapaxdZRNCFgMicOY=;
        b=MKJc9CCqyiFHpRcLpFFEcjMbBAqbaMFB8YelUaVpk4FxFvaHH0mITtI+u+L9XwLc09
         TN8pjA7sZpRr6x6gCknBFY+bBMNwMXMFLQUbSznWZv7VNgXcGli5MxL+CYVzvpU7fTg4
         go0h5yDpmndTOGjosuEpyFpvouAdEZ42amuQ8Lh5tf3EXUw/npFUTSk17RmYThvACOlR
         r/bYV1WTv59CASYBe9zmWxGab9wahnN7S88dkJN1gJEkd27H6/5g/M+gUtjceHTB/ybG
         /pad6qlYt3bk52A80OJuer9DeYkCiJERVtaFP4U0TKIeKVE4VfpsPXl9O4X2HHFAoAy7
         csqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720904911; x=1721509711;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCqo5imxUdi2MwtXOaJpLZGB4nbapaxdZRNCFgMicOY=;
        b=rdXOHqmqXRVkatoTJaQSmSFKwiso+T7B9KtzORTwkzW/igaHEQCUb/C3jLQves0Tij
         LYEYy9gc4G/zOFi2xM6b/s5VAZgourq26IX7b0640kAvQDogQqZ9RgUmY+PRHUWsijwv
         /cOmZ/epXiab6EkpFjldWM+b2NRizff8s0gDHh+i6egzMhsJDU5GngZ63a8SyPW3/GHN
         7pFH59Xv9MDFxBSGFpnqb7noEh6o5kiH/ztCEn1BDahtbqrK6E6wJhjEuAel9/zFXP82
         1HMd6sAZBlYKGVnkowPFnSmcnk/qDyacKiBoANOBcKc0HklR4HWpbBLkpJPFK6+uH8YY
         Zc1w==
X-Gm-Message-State: AOJu0YwPe7IdcOe7da7sjh8n1bZb6a2Ms+FuMXNdlgP5jywoRng05kCT
	3bWiRnFxkNiIA7L4ai3m1pWE+AeuRDcLeNx2SF53yHV7+s7PwrR4ufDOTA==
X-Google-Smtp-Source: AGHT+IH1UeknvOA8ABcD9Z/MTIyAhPed3QNSaPtOGGmYCsSCEFwCc/7/RpcYSMmLNgUuE8/YV0ZZVg==
X-Received: by 2002:a05:600c:4982:b0:426:6314:3336 with SMTP id 5b1f17b1804b1-426708fa8bbmr98307445e9.36.1720904910866;
        Sat, 13 Jul 2024 14:08:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5edb4a3sm32755025e9.31.2024.07.13.14.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:08:29 -0700 (PDT)
Message-Id: <60fde81d35ce58975307e507debbb27ade10853d.1720904905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
References: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
	<pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jul 2024 21:08:21 +0000
Subject: [PATCH v3 4/7] mingw(is_msys2_sh): handle forward slashes in the
 `sh.exe` path, too
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Whether the full path to the MSYS2 Bash is specified using backslashes
or forward slashes, in either case the command-line arguments need to be
quoted in the MSYS2-specific manner instead of using regular Win32
command-line quoting rules.

In preparation for `prepare_shell_cmd()` to use the full path to
`sh.exe` (with forward slashes for consistency), let's teach the
`is_msys2_sh()` function about this; Otherwise 5580.4 'clone with
backslashed path' would fail once `prepare_shell_cmd()` uses the full
path instead of merely `sh`.

This patch relies on the just-introduced fix where `fspathcmp()` handles
backslashes and forward slashes as equivalent on Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 6097b8f9e60..29d3f09768c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1546,7 +1546,7 @@ static int is_msys2_sh(const char *cmd)
 		return ret;
 	}
 
-	if (ends_with(cmd, "\\sh.exe")) {
+	if (ends_with(cmd, "\\sh.exe") || ends_with(cmd, "/sh.exe")) {
 		static char *sh;
 
 		if (!sh)
-- 
gitgitgadget

