Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE662F0660
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755029255; cv=none; b=FyVWy1F8/JRmV2csKeD0fvv5JA7TnBxdOpMY4gOgJF5L7kwFcLF8xmKm7e38qy6bPvoHYC53fz9GptXNWY7NH9FFq3NiJ+hZYG0flMquNZTTgMCeCYi8Wp25NTjmxOL9US8YlYBYUo3D61uJF/okD0+VUgYltzoPvo8FveOkKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755029255; c=relaxed/simple;
	bh=+r4abG35Tq9pDxBLfjeUB+keHL3DFkhKfNCh7B9yYEQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oxJj3gav2p7efBFjclI3e+B/SZspm2r3Bhr0kzi6q6XgzHVThixyEQDTvG0BZ6+XhJNqXGY/6JNXLze314LoBwfX40jIORWcEeF+8Cc9YGSXstj9u+nCIkOyb527OfTQXizbrOuqrephB1lZOkxLa461tuJZlQ+nXhcaTC+1roQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDNZ2b4q; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDNZ2b4q"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-458b885d6eeso38053725e9.3
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755029251; x=1755634051; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIwEcyYutYD4dM+kSeLrLzTkMqSP7UvXpfXdkt0xOjY=;
        b=VDNZ2b4qdWic5XNtBZap58pJFfWdfrAcAt3XUuNk8R9oUUbOtNzPXZ32S7NmGeFvoU
         xKJfhEc66ZuMpzwfEdRJneieIvjaKPvd+4j5AkMdVZInMqj+In4kV8a53ioYYNkpqHOK
         5ZbmYqOfYbqEwLXg9KVUR1El2ojmlLFF3ufLFVgla69J+GA7iPdG04mh/8z7lPaAQIVh
         dpWh0KfVDC5KdnSos/l7YBaMwXyFwZGoQufmFfBkNaVkOUu5+Y1BtyB4iXfHbhBLF0tQ
         Hec+UHyurI9TD1v2lAOe3a+gkoR6SpoXdifbMcSoPYlv5rkbkT5O6a7Q07qZvtFbP2Ss
         B64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755029251; x=1755634051;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIwEcyYutYD4dM+kSeLrLzTkMqSP7UvXpfXdkt0xOjY=;
        b=e37ClgD88jYhk70mV8Rgb3iGIadZiI79sk4GSvcrf8/+XOzZUNn8GSgqhZoJcSG4I0
         yoQa4RYZnqaz2Uv53DxT5zf7QQRvFt2oLk+hjE5yd3B91cBS9gBkjaKISpT+xcZrCpIb
         P0O7ieAo1+WHpdYECkNn8Hbo0nklXPqb/M1DKt2v0h74BR5RkMKQVPqn5dMSOoA478Lh
         H8Iqpx2SzSE+Uj26OATXSyjtBKZyv0ObvLtFmyX97aDHwgB+kTfjzZSsUzBtGPCi3xEn
         CAhmpANE+rP25AP/24rSy/C2oWFb7ylukJGzUWNVHVrH+zTByQRLfDQfcilHXlEuw0h7
         DP9w==
X-Gm-Message-State: AOJu0Yw/xotwSkr2p/3SJbiJRSHkfPx1gnAoPi/3+dUDxzIpckxzDMQo
	BAHkDse3dRbqksQP9RllOutAULgMfIj5TMNL9RzDiyqqq7RR11EKHiuo3zJQwQ==
X-Gm-Gg: ASbGncv99xJtDZSuR23jtSmEMPgwD7+3tjAEXpq2lEcV+FU05Lgpc4NlTMJs9EHziY+
	HtHLLNB5K769Lk8QHYRvaCs+eqBkKSD2QlhLDyCiJ2l53rzvT/V9HDzceVg6Q4dlEsEIVq72u7t
	Tu144Y7dSXmdFsbBn9vHbw1+vCLTRYGLFSGz3ZiJzlOa3Cto7G1NKjg/xBlsAoX3G1I6fnYOX5y
	fnLI2OGN/g60PBsA5MUds2tqiQjdZQpy1yQMBKrYh4+Ym2FKu+QinI+71UwhH2NHD68c6yJS4CG
	225j6U+44uJIGahH3Q/SxPpZ2TMQ8upReBe1r9mpgTn2jmUt7LYGEhIv/21s0xsRrtbA1SjxeMx
	nIphykeU7e5fMZFJ4na5llRY=
X-Google-Smtp-Source: AGHT+IEuCv3U0gKt9p0mGSBk0opH95i4gchU2wAsET89UHgvyYIpIAVYnZuuIkbz/f+nkYQ+11zGoA==
X-Received: by 2002:a05:600c:3b23:b0:456:eab:6344 with SMTP id 5b1f17b1804b1-45a165c4f74mr4466795e9.15.1755029251101;
        Tue, 12 Aug 2025 13:07:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a119eef59sm22482655e9.1.2025.08.12.13.07.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:07:30 -0700 (PDT)
Message-Id: <3a2cc38b72fb0f6ccc0ec9cbefadb7576cd8b934.1755029249.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 Aug 2025 20:07:25 +0000
Subject: [PATCH 1/5] doc: git-add: remove options from SYNOPSIS
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Motivations for this change:

1. Listing a huge number of options is visually overwhelming when
   opening a man page for an unfamiliar command. It makes it harder
   to understand the command's core syntax, like `git add <filename>`
2. For options which can be passed independently of any other options,
   including them in the SYNOPSIS does not add any information which you
   can't already get from reading the OPTIONS section. `git add` has
   some mutually exclusive options, namely:
   [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]]
   but personally I already find that line so hard to parse that
   removing it doesn't remove a lot of information
3. Some man pages already take this approach, like `git rebase` and
   `git status`

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-add.adoc | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index b7a735824d6c..12afeead6637 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -8,11 +8,7 @@ git-add - Add file contents to the index
 SYNOPSIS
 --------
 [synopsis]
-git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
-	[--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]] [--sparse]
-	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
-	[--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
-	[--] [<pathspec>...]
+git add [<options>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
-- 
gitgitgadget

