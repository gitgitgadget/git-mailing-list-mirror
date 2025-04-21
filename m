Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4C1DC994
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239160; cv=none; b=d562UuOuT5OF8vyjO5dOUN55od5VWumTXRO2aRJMvVP3jYz5WaBou9Q0maeX6BjpDnLZkaERlFNcj1KIBYkFK+DrES/xI62LQIeuYqSaINO+kqcjXzfQaskXvJOVO2k1PG4O77/D31XBPe8N198a8qy+SSYynhSGOuHKmr3OR3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239160; c=relaxed/simple;
	bh=UNMvRrviKnl4JA+Z1N73oezsdoyKAzNauEQF9KpUpmw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LdYn2DtVKAjkd0kM+Rd6X9pb1Eb6xlO/iFheVg05bWDRIz81eAmgvTGc8P/i4WuFBO2kuiWlFmWZOGFOfUGn8YNaCU81/GvKn5NTkpPYxcIccyvJP9eHFt3dv8oggGeBFoBMOPuql+aUmoMfMKC8cjEbNxZTuIReYHzaCddG0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPx1z4WA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPx1z4WA"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so35664075e9.1
        for <git@vger.kernel.org>; Mon, 21 Apr 2025 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745239155; x=1745843955; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALDsaaKQ+z7cPRtrQ/hykW85qBkozF9veFhA7c7NFFc=;
        b=hPx1z4WA1CEdeb3o3AVe/dtU1t+u4NXTv4sxXDBYd0eawMfCgf8jh9AEh3tVaZAnZ3
         nVbM3bg6aeWIgTOsqQlIxAciPMHz7kG69EmkwAzKtALRrl9D22qKUlClCqcjoiIBojWn
         6aVyygLB4H1G0SlYCu7aesHpntF+6CFUqDMz2ZIRGOGz35lCOMnQ7QNpYHDOR+rSKb7x
         cZ7mQpmoT006EI6v+hBMOmvedy7sFMDNlZNGx7xmIJ4yjlVc+eB2ftv4k6eYpDuk9XfH
         PprD3nm+CmeETE8j0ChHIBCQo+057McitSQ/0Q33KPPjg2a4YbManpGh7MeKkgAMh5mf
         j2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745239155; x=1745843955;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALDsaaKQ+z7cPRtrQ/hykW85qBkozF9veFhA7c7NFFc=;
        b=HmQm06nYpSEuElbDZkpbHyLHq6vHjEE6yYYZ0w4G1960rgSEKKoDExF8ze4NYjVMs/
         9E6UBFkDFoiMk4irK3gtvkDGUh/lQjLSrHFEQz0V8QRc3Wgz2XAnNvYafIHx3+9RSo7V
         CiqD/iTBH1kbm807YgUAwmFgbQEeVuLN5fzPdwFZTHOZMkiYQNwpnNZkjhPF56ozk4uv
         3OjO3kM4AD83iPbS8USydvsRjesyNkLe4h92MgG5QGn3J+EqKt7zCSCxaPqyuH7aGdV6
         eExHaauNiNOk5+lwacT236GM1Sl8V0Z2g31YhnFy4Rson4H+1nxOxDRtFIwbjn9hldEc
         Dzww==
X-Gm-Message-State: AOJu0YxlDLTkSqvmnzNUabRIOrld6M/Wlc9AdpKob+1Kk+Abt+RPqxBm
	ucH1y5yqude0xQvfwJfpdSPFOxbjtYVdMkLCKca9XAU2zuj8P55btxmONw==
X-Gm-Gg: ASbGncvQU+G3VsqsGffENc8+20SIwYTt/3eSfZZyqVYdrxmJZpIq/NuNVmXgWFoRUH/
	9UvBqWPmqBlIofpcI8m53fsSnzw1Yb+25Yf3RBQe45SaD1hG9Mf8rc5e72Aub1RCU479IC7ACBd
	+aAOYssn1H1cMpz50tIlq3Kr/Ywd8T19dDm0XMyIruqAK9i0k2+LYw7PAMVakk1hWYZnbeP4ZAA
	4pekPvF2FKJUAIfCsSBWMIAFbD36eZXBLWPchrRlFnbfQrWgwPMd/37BZr9xN/YaLkFZO2zR339
	dO5foJabjbxrLTw5o61gHNzshVlde4X090T1JaXRGg==
X-Google-Smtp-Source: AGHT+IFN8rMz9foRQQbLp6a2lQiKl7ahFL1Sdh1KtC0LUSGE7ruByoYk8xaP8VlSNVvrJQj16cPoaA==
X-Received: by 2002:a05:600c:1d02:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-4406ac604c9mr96543205e9.32.1745239155332;
        Mon, 21 Apr 2025 05:39:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4a4c37sm12025707f8f.98.2025.04.21.05.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:39:14 -0700 (PDT)
Message-Id: <c89ead8eaba7f824d6a4828964f8384f60b17101.1745239150.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 21 Apr 2025 12:39:08 +0000
Subject: [PATCH 4/6] msvc: do handle builds on Windows/ARM64
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

Git for Windows/ARM64 settled on using `clang` to compile `git.exe`, and
hence needs to run in a system where `MSYSTEM` is set to `CLANGARM64`
and the prefix to use is `/clangarm64`.

We already did that in the `MINGW` arm, i.e. for regular Git for Windows
builds using MINGW GCC (or `clang`'s shim pretending to be GCC), now it
is time to do the same in the MS Visual C part.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 6222d2c5a48..bd94f458088 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -432,7 +432,11 @@ ifeq ($(uname_S),Windows)
         ifeq (MINGW32,$(MSYSTEM))
 		prefix = /mingw32
         else
-		prefix = /mingw64
+		ifeq (CLANGARM64,$(MSYSTEM))
+			prefix = /clangarm64
+		else
+			prefix = /mingw64
+		endif
         endif
 	# Prepend MSVC 64-bit tool-chain to PATH.
 	#
-- 
gitgitgadget

