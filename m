Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A52D3749
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759341753; cv=none; b=lvTLHcau6x0xR0EAkrHbbOkR/3M1E7Q6oEjiFtIHKmtJaTRXt0hrPIoyGd1ft7qYsYL5Q153XcLUpH5AKkiR1CawFe7s4vZOr09FqIQWoSMVVhKpiATp9dssqBxQ3YXRU+TQqIXwW+rfLCUAApNRuqTyPsxEegcHOVxunmmS05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759341753; c=relaxed/simple;
	bh=iGLXEk0buZgqyOsjLzYvdr6L7AB4GH+/dt3+s4+BJc4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=lGbl+R9KC0mVLusNVzSQFNNPvrySHkurBwcWnn3R5LolLlcVDrkLLh7ZDzgt4GXa06t7kdsTUhW1n6QTNc3rhuavIE+CumqvImixq8g4H/WXPxrBwC/mdupV085b8FhJSPR7p4Eq9GLoxhEB31gKUGUDrQRX2qPp2D8eyG1hawc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsgnQxec; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsgnQxec"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-4256f499013so774355ab.1
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 11:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759341750; x=1759946550; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uolGNFaAydIC41riXeP9LsWlGDgiZsvDPtr+fZbFDdc=;
        b=bsgnQxecNawQlRbWORXZayVluD+gN+L/Yw7UzRbOWc9d2zy7+ecYTcILQlySXL10u9
         +dnMcDh/kmHG9l6+J6DmbFZrAhpukAUykPCGGbKXv/X+XmAKSBJakt+YYsqIucEBQ5Ac
         hBHbbIXl48ADoDnFzAei3FgycG7cZ2NhWobIq8g9Ex80u7Cg+k8/Eskn5ySVF1bZni7J
         XNk97F/sI6aNB60J/izdYQIVU7m/BCjaw6vefBhNBUD6Nh75/v3uHWzhn9+Y1DPfFWBd
         2ajt0MIoZvw8GFkKMwy52x6txwNqt1cOd0zS5EbfmmmBfGKXPjC15Ol0RlmRXhmpdrzf
         cfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759341750; x=1759946550;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uolGNFaAydIC41riXeP9LsWlGDgiZsvDPtr+fZbFDdc=;
        b=KjGYlngQEDWd5qXHP6B2czjal9rXCBg0h0sglmOGLnUldH7KT8iJKhjv/9m1ljBN6s
         t1ZtdFbzvqCIorbN1si583G4fR+UWARbCodoKPrMjLkhCOc7qS6q2IoDOqdn3UYnj8n/
         sKinFndyI4xsf+LlyO/Zw4bS6yXBAUrSHT+toMtUguzt0kVcsfu8cJ1TTFlVs1PzNlyU
         Ucs9swo2N500lvZJiDTS855vp3XCiFfI1+Ft1v0ib+HwjTFEIhJNZp1PfN1VtI95Xng0
         MRc52tIY1wKkewOS1ILvKTD4pcB6veLlT42t9MUwA3KIkAn7Jga13skrhMoJVLdCZynq
         Y1Ng==
X-Gm-Message-State: AOJu0Yw/rFnnLVf5ciHTOESca7Rnafo0ku7g9TEK3zFv2tf5zagoNi8W
	/+R0XSH6KcGODvbyhn46cOp4QhvdTQcMkFIAbCae+gqytoDVzCxRGLU/QydRnQ==
X-Gm-Gg: ASbGncsNQenSrlBZX7p2fiPLbl9noAT1vBiARW0b+l82D47xc7gq0BhlLAyAWUNQh9i
	BCmefhYu9ZL4El+pDh3l8EZP1v6UhhaLEaD4TPHUlkorhNzwuRtLiMiRlfIkmcPYgV0ncUF67W+
	AaxX/SKKHSm9UWCRnQrW1A+cqqY8BtkjO5GpDyaTphsTiCFJnUNSgWQjfmZgt6Caad4d+yoVWU8
	uiLRRXTKcxzq5B0aExJ+C9aHSeKNRNJe7H6vceRzZZuxbefGeek/OO0cT9Mn0DHVxL9GtDW2lQc
	hr5xhyd6aEkwlnt4MuO9uTDcQk7lzaJTAFEq6PeIMElSdBjDuvC7FUBaxABBfhTUhrCWY7JKnFU
	Wk3Hlv2j9DxZHvoQcTfrT9ZUWXDldLWB2s0oLkw9hv6hRPoVgKTxDxbBj9+L0
X-Google-Smtp-Source: AGHT+IEvQT6odjs/wYLw9EfPWz3T7Y2asmFxtjjLfGxv0RsUMVIrlC+Y27ry00D3bwQcXilv1ZMm7A==
X-Received: by 2002:a05:6e02:1647:b0:42d:8586:9751 with SMTP id e9e14a558f8ab-42d8586991dmr40008085ab.29.1759341750176;
        Wed, 01 Oct 2025 11:02:30 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.176.149])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ea42000sm50803173.19.2025.10.01.11.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:02:29 -0700 (PDT)
Message-Id: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Oct 2025 18:02:25 +0000
Subject: [PATCH 0/3] Makefile update libgit.a: Include xdiff and reftable in libgit.a
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>

Add xdiff and reftable to the static library libgit.a that Makefile
produces. Meson does not require any changes since it already includes those
libraries. The motivation is to simplify Rust's job of linking against the C
code by requiring it to only link against a single static library
(libgit.a).

The Rust compiler only needs to know how to link against libgit.a in 2 cases
that I can think of:

 * Rust unit tests
 * Rust defining the main function

Otherwise Rust can be compiled without linking, and then Makefile and Meson
can use Cargo's produced static lib files to build Git.

Note: The flag -fPIE or -fPIC is required for Makefile to build libgit.a in
a way that Cargo can use. It has been deliberately omitted from the
Makefile, for now, since Rust isn't part of Git (yet).

Ezekiel Newren (3):
  make: move xdiff and reftable objects before GITLIBS
  make: delete XDIFF_LIB, add xdiff to LIB_OBJS
  make: delete REFTABLE_LIB, add reftable to LIB_OBJS

 Makefile | 66 +++++++++++++++++++++++---------------------------------
 1 file changed, 27 insertions(+), 39 deletions(-)


base-commit: a91ca5db0318b6fda5a6721ee843f56e7e2fadfc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2065%2Fezekielnewren%2Fmerge_xdiff_and_reftable_with_libgit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2065/ezekielnewren/merge_xdiff_and_reftable_with_libgit-v1
Pull-Request: https://github.com/git/git/pull/2065
-- 
gitgitgadget
