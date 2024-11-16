Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF5819CC2D
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731785780; cv=none; b=ddAmUbZolmDWCr7MBjqyQM9p/oAX36AXDQAZwhWQWLkL48VuJ6JYDS00Zu2QmybpegzJLNZ+gDftgvfPy8SQAmxu1dQVaoIkbgiuTxZj3ABSmQg49a/UgoJnwoh11p6n6bgyXmkAheWRP4oASqY94/hkjpow9ieHTQcPxJwrSL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731785780; c=relaxed/simple;
	bh=0NYo/XYeH3+n/Qry/njTb1AtkwL6TFmD58G4xKjP9Tc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=d87Sjrt8Hcd+nGrd6Umew3SssFDvrqOiO5tj9EDl2FnGSNnyg63gX+liTfuARUo81GhzX+g/8xZRXLc8H5Mv2ZK4Uwth/hyoY+07U5mE4rCdI7wGVt5eFgIPna8TrWO9BpipaOIIExVMMusyyWDwSxMKvzla4FK6iZY7nBzN99s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMn8iYVZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMn8iYVZ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38230ed9baeso806079f8f.1
        for <git@vger.kernel.org>; Sat, 16 Nov 2024 11:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731785776; x=1732390576; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhawjVpJghbDgtfyy8U3o7VjiknI4ER7dr7TL3PtJ38=;
        b=cMn8iYVZh/ZbH5T04cAJZHTTqzLxSi/K+CoYjEFSDTfIm3tYwHyKE3apPduCPuayEo
         cv0uclM1aRdLPCU3C5tt4Q9D3t9FUEmUTpgawCAAmwJnDfXYHoqpuJSPueoJP4F+SEae
         hfpZx2m9yIXBcw0ZcU/amT1ur1FFQFCJtQRwAfCW8GqWGacLfAK31ai8uS8CxlGpNafR
         4o4v0hHGfq3KyQmLLUXfMYKU8Rz5e1lFFyA1Wx2D0nCoS+K/jb+7LMu3H+oTBWQZQ+dn
         AJb2/zS7+0bnF1zE33V8Bno7NZqX0BFcRWHr8sHnsjgRf8AOp44Ttu9FmqTuagY+mld+
         +hLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731785776; x=1732390576;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhawjVpJghbDgtfyy8U3o7VjiknI4ER7dr7TL3PtJ38=;
        b=ZwSywLhxVVqpSRF5ys/+ho5dhqw4fNH2CUNgf364WHjVrPPH+UAdEO9S/ZEfo56pmm
         Wrkippfmiu6rLM2OB7BToOzQmw0xjm5ENC5ARELvPu1ZJA1xdmKgWj21D8QNjz8hTYN3
         pLjOyqFkbwJ0W8OTVPB3G/uEo9GYTLcGH/TGAtP2zsr/ltfI56atjMAf5B5b4pIrS6Ag
         FKlhl/v3MopxKT8xoQCMpYUgDdfI6kmd2jgdfinL9kcna/iOKT3PnHo/D6oVvWP/voBD
         +Qv2E86+2CGh2f6d06LLP4ho+wATkY3+YQlbvxDUOxjqUy7ModvXz1OfkzGT+yEu8iSa
         ipkA==
X-Gm-Message-State: AOJu0Yw2LWH8u3h82MwYwk/Q+pgziwb6S4r2ruLh1XfNhpZD5IlkHxXy
	HXQHwHmAhvZ0i0OrZqDoRKzN6OLw6Reo3mlt5Ty6o03uh/ccu6PGc1J3sA==
X-Google-Smtp-Source: AGHT+IENQIh27ePwFshDjtRWfj70G4GNTERJg0ghybPGsxHBdARWRyhfU3XwbFNc02bDmaR/8HtD1g==
X-Received: by 2002:a5d:6c65:0:b0:37d:4ebe:1650 with SMTP id ffacd0b85a97d-38225a922ddmr6767710f8f.46.1731785776085;
        Sat, 16 Nov 2024 11:36:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3824038beb6sm471904f8f.80.2024.11.16.11.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 11:36:14 -0800 (PST)
Message-Id: <1154462f8bea8110afcf8a71bb5cdb3d040eb1ab.1731785769.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
References: <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
	<pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Nov 2024 19:36:07 +0000
Subject: [PATCH v3 4/5] doc: git-diff: apply format changes to
 diff-generate-patch
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/diff-generate-patch.txt | 44 ++++++++++++++-------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 4b5aa5c2e04..e5c813c96f3 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -14,7 +14,7 @@ You can customize the creation of patch text via the
 `GIT_EXTERNAL_DIFF` and the `GIT_DIFF_OPTS` environment variables
 (see linkgit:git[1]), and the `diff` attribute (see linkgit:gitattributes[5]).
 
-What the -p option produces is slightly different from the traditional
+What the `-p` option produces is slightly different from the traditional
 diff format:
 
 1.   It is preceded by a "git diff" header that looks like this:
@@ -30,20 +30,21 @@ name of the source file of the rename/copy and the name of
 the file that the rename/copy produces, respectively.
 
 2.   It is followed by one or more extended header lines:
-
-       old mode <mode>
-       new mode <mode>
-       deleted file mode <mode>
-       new file mode <mode>
-       copy from <path>
-       copy to <path>
-       rename from <path>
-       rename to <path>
-       similarity index <number>
-       dissimilarity index <number>
-       index <hash>..<hash> <mode>
 +
-File modes are printed as 6-digit octal numbers including the file type
+[synopsis]
+old mode <mode>
+new mode <mode>
+deleted file mode <mode>
+new file mode <mode>
+copy from <path>
+copy to <path>
+rename from <path>
+rename to <path>
+similarity index <number>
+dissimilarity index <number>
+index <hash>..<hash> <mode>
++
+File modes _<mode>_ are printed as 6-digit octal numbers including the file type
 and file permission bits.
 +
 Path names in extended headers do not include the `a/` and `b/` prefixes.
@@ -56,7 +57,7 @@ files, while 100% dissimilarity means that no line from the old
 file made it into the new one.
 +
 The index line includes the blob object names before and after the change.
-The <mode> is included if the file mode does not change; otherwise,
+The _<mode>_ is included if the file mode does not change; otherwise,
 separate lines indicate the old and the new mode.
 
 3.  Pathnames with "unusual" characters are quoted as explained for
@@ -134,17 +135,18 @@ or like this (when the `--cc` option is used):
 
 2.   It is followed by one or more extended header lines
      (this example shows a merge with two parents):
-
-       index <hash>,<hash>..<hash>
-       mode <mode>,<mode>..<mode>
-       new file mode <mode>
-       deleted file mode <mode>,<mode>
++
+[synopsis]
+index <hash>,<hash>..<hash>
+mode <mode>,<mode>`..`<mode>
+new file mode <mode>
+deleted file mode <mode>,<mode>
 +
 The `mode <mode>,<mode>..<mode>` line appears only if at least one of
 the <mode> is different from the rest. Extended headers with
 information about detected content movement (renames and
 copying detection) are designed to work with the diff of two
-<tree-ish> and are not used by combined diff format.
+_<tree-ish>_ and are not used by combined diff format.
 
 3.   It is followed by a two-line from-file/to-file header:
 
-- 
gitgitgadget

