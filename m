Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FAD265622
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239161; cv=none; b=ZWYS/uC0HRl99DIZBmjkVz6TMjjthSUwZapg8T9UaTMnG9foJGv2cuI8BRii3hVzwGNkpvakjrEjQ71+yStBPb0CVd+jTG63HN5hEZDcOLF1qOBN1DBvlFNaPo3JeG2P7wcI4PX1ytlfkFxoKZZdxm3ZVGiKbxewY7FJbGemmmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239161; c=relaxed/simple;
	bh=Xu9RSpG1WMQaTiTFZDnF7EYfcuIZZX+l2sccObDjjho=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mQbj39oCBE92aB1oYmPuWfTYRfJg0yLWtLT7PmaX6AB3jQ+yz4zieLSB/KahlxNA2h+fDiK3GQRnzIExh9O3HexgBdx2YfBQzNdrbWGH9fP3RZqv9a8L7C1Ch41TiIxh+ZVNFT7nGdxe+hg52uKp5dcVXkTtSrK7i0yQ7rV0EhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPZT3HZO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPZT3HZO"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so42172805e9.1
        for <git@vger.kernel.org>; Mon, 21 Apr 2025 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745239157; x=1745843957; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/NycDt33KhPH46BTbLRZ6lIFXXC9LkPFiqgGukX0RI=;
        b=KPZT3HZOuDHZs+bl3/DoHihe3wau/XNYzUfPrrmh+c9bZyHipKX96Y0zIkYPJzxX1f
         iCt+JSDzDwhDqLWamRvSo2rRZ5OMSNk9cyBaM/UovKtB0xDTf1n1zRlOmDAVjVgna15Q
         yJuNSYA1XMx6pD3yQgcFRk37prp+PDh83zqQ2HtN8nFX9TadJpqnRVSokZ41Z4mLEdO6
         6puADewErXB6U410tcO+DYj7rLI+IchZVjLVei2ND+GmaZaZQ2zEC4athBEzr5R14rQO
         s4FTAqSLByaSV1uoxDyc8xS+BW9j6mJKH2/nTp1YfSo9bD/9IMuYKrscDmfzpr2a9XRt
         cT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745239157; x=1745843957;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/NycDt33KhPH46BTbLRZ6lIFXXC9LkPFiqgGukX0RI=;
        b=mBcCP/TSVJySOLfRPzVEDUkWxxn6cNVvz4VGrS03DdGIJyjo8lGJqWNtBk0Lk0wOBZ
         3Eeyt7X9xLBCLY7IftaCRfb9AladZFVaQX5Mh+rAdqgQXFkcednInwlc4UvlU0Io772k
         oGn4qUCMPpLsGVF+X79qOar6i8lIpOznOGqbnOMwHKYG8XOwRRxD5fbJADcmZ+R140LY
         cgFIY3jxpRgLW7cyjkp8d+2JMecWPjhO7Y07+GvAx1j6qIQpMn+B1XTqfH7lPlKR+8Kw
         YqzlVMJwS1BPz520qnIijErVgQ+RtGhf0awtJXUR5uWWRLzDBqnR4lxzHdWo0RfF33mp
         LM5Q==
X-Gm-Message-State: AOJu0Yxc60DO+BOyfASsJZYMVCEmW6h8e6oDwOiXzlgj3QJdUjcQ1uen
	PVHrWKDyVwHkkKn5AHpiW/1s/Jq6/oZBY0YBzFSYk+IY8GnjowHqvnmQPA==
X-Gm-Gg: ASbGncvYy+9x+wGr5PPRQgIiHpElQrWjZ9YKPU5nhw9I9kDVExUxm7Q49oAVZ+hPJ8B
	y2vN69aRC3dFvrimg9m8Eh52Dzongj1jgA2GoweStZIv4QA7vG2GIhRSvwGzgl+Ize7B2uv8XPs
	vBK7aQehUzmoB/aRYur2EX/ANnZL5Ih3BvfROHRuA91xD3z0AaXrg8+oYcwUoA0W0uOKT9rN/VJ
	a2Mex2NTjReCS/B2SHgqwIOB0xqOmiLVOneVGf8lTzFiNbN46SFaT1/FJpSoDI98vscFQusqtS+
	jwXDQc3t1AX5dG2+0eZ7UX6id7gna2my4piLZrJ+Cg==
X-Google-Smtp-Source: AGHT+IHcHd+a8bV4gmGaRRWa9fA9CKiaC/Zmi5rNdIakAhYt1RKwsOe4XB2PgsjHMiCp6BZyWLHhOQ==
X-Received: by 2002:a05:600c:1d06:b0:43d:98e7:38dc with SMTP id 5b1f17b1804b1-4406ab65fe7mr84066425e9.5.1745239157048;
        Mon, 21 Apr 2025 05:39:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6db1b3sm134528085e9.29.2025.04.21.05.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:39:16 -0700 (PDT)
Message-Id: <6ebc3ef57fd0455fc70c4a8531c7ed094d9cdaff.1745239150.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 21 Apr 2025 12:39:10 +0000
Subject: [PATCH 6/6] max_tree_depth: lower it for clangarm64 on Windows
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

Just as in b64d78ad02ca (max_tree_depth: lower it for MSVC to avoid
stack overflows, 2023-11-01), I encountered the same problem with the
clang builds on Windows/ARM64.

The symptom is an exit code 127 when t6700 tries to verify that `git
archive big` fails.

This exit code is reserved on Unix/Linux to mean "command not found".
Unfortunately in this case, it is the fall-back chosen by
Cygwin's `pinfo::status_exit()` method when encountering
the NSTATUS `STATUS_STACK_OVERFLOW`, see
https://github.com/cygwin/cygwin/blob/cygwin-3.6.1/winsup/cygwin/pinfo.cc#L171

I verified manually that the stack overflow always happens somewhere
around tree depth 1403, therefore 1280 should be a safe bound in these
instances.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 environment.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/environment.c b/environment.c
index 9e4c7781be0..cc853950bb2 100644
--- a/environment.c
+++ b/environment.c
@@ -82,9 +82,21 @@ int max_allowed_tree_depth =
 	 * the stack overflow can occur.
 	 */
 	512;
+#else
+#if defined(GIT_WINDOWS_NATIVE) && defined(__clang__) && defined(__aarch64__)
+	/*
+	 * Similar to Visual C, it seems that on Windows/ARM64 the clang-based
+	 * builds have a smaller stack space available. When running out of
+	 * that stack space, a `STATUS_STACK_OVERFLOW` is produced. When the
+	 * Git command was run from an MSYS2 Bash, this unfortunately results
+	 * in an exit code 127. Let's prevent that by lowering the maximal
+	 * tree depth; This value seems to be low enough.
+	 */
+	1280;
 #else
 	2048;
 #endif
+#endif
 
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
-- 
gitgitgadget
