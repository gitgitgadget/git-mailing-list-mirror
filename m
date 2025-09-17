Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49CD2253B0
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071815; cv=none; b=VvdQQ24ffnSY4dVn4LkyaOR6mbKzF5EP2tKV6X0d/KrE+oAUn6leijwbTJGWvPEJziMLdiIS7muILaevyrmyWLq+Yc8j/iqxhc9gIBIY30te/T49e2Q5HKlcEduHtajmxAkzDs2IKDtcAcJZUyfgGuYfVDY45CqyHFfDWOuk9Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071815; c=relaxed/simple;
	bh=ZPWxojo3+iR52kb43hWBPz6ssqKKlg83FqekjIR/pnE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iLQIO98NrfH4rJsyABJJFC/vvtWK4T8FYogyvt1GG3RD+G69dplM46ahfset8P1ck8QAAuJGqN7f2tepe4r4sY/MMKWL3iiBBMfcK8vJus7YeahptfOzWxX3XLb7WqMHU28bSk+s7WPpQ1AdrrX2oGSzKwkZ4BQ0ulzkwi1+6f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2NrtHqi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2NrtHqi"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7725de6b57dso7630555b3a.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071813; x=1758676613; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfDp0bbl31JVebDMbAMRJIv4OO1MtDwLKiTtsDLsYTk=;
        b=Q2NrtHqin1HK3E/qAgikDeawydzZl7zIbwwularttnaEdENLkHhbLVn8TgbgjiVGV9
         3sMxnKXx3MRYqIpoC9ilKv3T3vmbyCjd+UjvvGtFUtGUb0XdL4MY7hHmod0eh9YTvSym
         TagGqzHJO5F1aHs7MHx6DPjUjPgDYmbo6LsEUFMMagYj/RSjiaMKbN6qurQVjuUEXoUl
         +4wtZ3MVMUQ5u1YzeLIcxm0y179OPTQEA2jrr5iMLHpixg3L8GgqWlN2333j5Tvpi4UJ
         PLzsVPEM2uXsVgkPq8zoLPTieR/YJHK0M5MeqVHkpl0FI1yXkGARuxFidCeJUXl/qlVj
         TSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071813; x=1758676613;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfDp0bbl31JVebDMbAMRJIv4OO1MtDwLKiTtsDLsYTk=;
        b=UtcquEfcsoqhoRy91qJ4DwrjAOZBWkdp4E3X74wGSdpiCSWvyW7LgmuxfmelWC/opt
         Q0fojUu0IuAUkWqRrFLTK8i/EmbqewKPBUxRKElb0p8Tgz8U0il7cSfjhs60q10GaExF
         RP/rs0Ix4OJ0sOjL2Wh+1d+VPsgj9Dll+uP526K+oK8Trn6lzbkRY19Xs6O3/7WCJiaT
         9geAUDoHe67zu0qRoKP3fVfvtQkVxsoKX5hHYbQwaba3kEaXMGz7exuzFPLXtwG7n5oS
         B5S3uPIaAIyZ2GELPpK+XaUZepPZkL/BS8fKDD5a6VXnkvvhQmYqcYKoy2+0dkROjWO/
         05Bg==
X-Gm-Message-State: AOJu0Yw/Mf8BlyXhKLc4TqnYhwvBjQoPBCDEmMH5GCzUN9xNoe6LRcqb
	+4QhARHNPfRqmL/cMYbbukalSli8aFrskJFdwPA/QiLyHMgOBmYgdjXttFDpUg==
X-Gm-Gg: ASbGncvzWrh4j8krgPLzWGrAovxJgXcCmW0/boI4IOexOCmLhIf1+odFjO4mmwTxVux
	EX1tHsLEFdovtX/jZxnciQPpGBfig5LcVkErAIRovGK1iIPw5oQydyuVL6qHN/7qK2NQhaMfY/f
	lH3XtuxCmaBFYgUTlSNdYLUaCCu1l3uzqSLeYq4kTE0GsvKS8k4t+toGilolCiyrf4RrHLI/2Pw
	W7ASaYI/cLN1mgrxhX1KLN/epbgzlc+JJktIxsFgaiF0tBrHiiob5KQLkuRWiYuvQwQl6obkbLg
	1SDQxDio77PzxqLsQMpAmUW/+7+Sqgi6AXOvnqoV0mZaLTE72j9L8nFEWOgQe+FVB2A1L7Y1szK
	50pRqlEPiiqqwdRhbdEIoYW8b3XI=
X-Google-Smtp-Source: AGHT+IFsJh05ddrXV2r3tGrQB7CW/71+BzCidXbr6iltVk29yNbkhqeLNK7xD+At1tSVsG67tLVayQ==
X-Received: by 2002:a05:6a00:2d8d:b0:772:4b05:78b0 with SMTP id d2e1a72fcca58-77bf7ebbd4bmr340504b3a.7.1758071812741;
        Tue, 16 Sep 2025 18:16:52 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b1840esm16999337b3a.48.2025.09.16.18.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:16:51 -0700 (PDT)
Message-Id: <6eeef4081cee269d5cf04df7628e693edd4537c1.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:30 +0000
Subject: [PATCH v2 10/18] win+Meson: do allow linking with the Rust-built
 xdiff
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When linking against the Rust-built `xdiff`, there is now a new required
dependency: Without _also_ linking to the system library `userenv`, the
compile would fail with this error message:

  xdiff.lib(std-c85e9beb7923f636.std.df32d1bc89881d89-cgu.0.rcgu.o) :
  error LNK2019: unresolved external symbol __imp_GetUserProfileDirectoryW
  referenced in function _ZN3std3env8home_dir17hfd1c3b6676cd78f6E

Therefore, just like we do in case of Makefile-based builds on Windows,
we now also link to that library when building with Meson.

Note that if we only have Rust depend upon libuserenv then at link time
GCC would complain about:

  undefined reference to `GetUserProfileDirectoryW'

Apparently there is _some_ closure that gets compiled in that requires
this function, and that in turn forces Git to link to libuserenv.

This is a new requirement, and therefore has not been made part of the
"minimal Git for Windows SDK".

In the near future, I intend to include it, but for now let's just
ensure that the file is added manually if it is missing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
[en: Squashed a few of Johannes's patches, and moved lib userenv
 handling from an earlier patch]
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 config.mak.uname | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 1691c6ae6e..9161694dc4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -759,6 +759,10 @@ ifeq ($(uname_S),MINGW)
 		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 		BASIC_LDFLAGS += -Wl,--large-address-aware
         endif
+
+	# Unfortunately now needed because of Rust
+	EXTLIBS += -luserenv
+
 	CC = gcc
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 		-fstack-protector-strong
-- 
gitgitgadget

