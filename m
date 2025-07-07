Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D707264F9C
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914421; cv=none; b=fEmloFaNOLAxnKfXxX5z6+YxGiTQl+TPj0+pcRVIPSG54kx7pR6CsCT8WQ/LgAikEO2zCJ4v08OL+kldA5hcR8aJlyeFmq+0qrUPnbZwDQ4Edgeylco7nz39GSjx1qKVgBX1M5J2KfJu/dtRBebXnnSy6CTP3pFz3To5Iy0XT2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914421; c=relaxed/simple;
	bh=V1TKFkj2avks98qi+QPmVnNSntCFyy/q85tSEtKIXT8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=ij9sHHDQ71L87RChGxs8yQ8yjvxkPZvgllceisVgyduThL5BXGJRYELnt6999BSqwYNbzYaSs3eeewDt10XSKjQaOaNoERThYiQZWRM5Ys2yQtWKEApOZmoSt3J+kU2vLCb3cc+aYkTv+ObkwUBQoTJ7pVn5WKREHdOFh59dkFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QE45C07C; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QE45C07C"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so25184405e9.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751914418; x=1752519218; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scvdSUiBmyCG5vF0CjLET40XEP076IKjDasqgPx5raM=;
        b=QE45C07ChQ2o31rC8KCijlfQGZXr1njzU+2Ap4++FTPJpjCcsG0TGWoeseOIUFlwok
         hNPR76QQussR4/3YDbKmxRbJuDlxyCVjJiXlulvmwICj77s8yXy+jUofurjRkGRbUuQK
         wbpknfb+UMnUSiLI7Bx/lmWeSmQf69UawVJAKwcsvH6wnlwlrWdqxZBrxFJbkS/5dUOY
         Jle50zFh5mRW6A8zywvvZ2C06aoGG0iBSdcoH379on9MJAZ844HCrVkPnck1UNF35xFY
         BMC0W2I9P9e8qvIajC0Kd+iNAloBxH2gVv470DnLWmu2xqeWxeaBw6qAwlbIReAhN47U
         nobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751914418; x=1752519218;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scvdSUiBmyCG5vF0CjLET40XEP076IKjDasqgPx5raM=;
        b=M81vrNZtmKEQ3Vd5B6JdJ0nkHZnmjSzZ+uzVzTFkhO+I8h5UIfks9Cumbvm28RUTtt
         0UcCEQBK0iUKHs/E8x6TIBcdLXtY8bEb3bBnmtEjVRPHhmnxsygPPaQbGWd4vOTIsIqx
         yWFAbos52wqr+Lf7ECOLn32nGjTup8PhL1xUMKbiqU80DGFkfHxhwSr3/SlynBryMcq2
         ddXVc71o0oe5KJojsNlyH8YdxCcnA+yPoN+EJ0GLoPrexBJjGHQKq4Mm+0Bm9CDhFbLE
         gWJwUeg75C9e4QtOI8U3IiiNKgmDDL3BdCyOnU+Sqk9d7iJiaZxptmu38d6vyT4/AwR3
         eTHA==
X-Gm-Message-State: AOJu0YyJhUE5y5d42OCE+w7CC8koz/SzHxxtY6OI6CZ7+NQcatV2TIAp
	7TMrnBhWK9oSgk26OStrgZWQOBQyfWE0DG3FhvvWG1drHo/a5/xoUAA68p3AJQ==
X-Gm-Gg: ASbGncvxqof8/bCpfIN/rTzTceGskaf44teQybpbQN76sztH0p21Axvh1h18E2DSCbB
	S7UK2SM9TyJy4H0/tJswyx/zesY/B1xvLdpDuA3MM+w4de7XVRXtTmpzFX/WKNyoXVzsiLIn00F
	HAbnY8tpA2r2BmW7sXc8NN1Aqc9RrixDHnlpcDhyJjRX2cXef3PhkNI71JehtZV0uJr22uAHPoH
	Z17BN3er5P0+MlVrNBFioNizeYD7dr2eJxo2o7G8UNxAwTJN0SyfFc4SeTPR1xqv5t6Q0tfHai0
	Q9Ux2sY9FmGkiHYrRC2fRxcmhwc5aZbQnhSgjD45PPQWbjmcV5YW4M70AeWyRvU=
X-Google-Smtp-Source: AGHT+IERq3DTNrbwuzRMk4Vtj3QAIqMTrIuF44jnFeSujSk8ykcbfuTbcVg1zb0wMhlohr/Rm6406Q==
X-Received: by 2002:a05:600c:3f09:b0:43d:fa58:81d3 with SMTP id 5b1f17b1804b1-454cccb83admr4957235e9.32.1751914417643;
        Mon, 07 Jul 2025 11:53:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3c1e48sm246335e9.29.2025.07.07.11.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:53:37 -0700 (PDT)
Message-Id: <b0b229082ce8f755f177022ec5ba05316275e590.1751914412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
References: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
	<pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Jul 2025 18:53:26 +0000
Subject: [PATCH v3 3/9] doc: git-log: convert line range options to new doc
 format
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

  format placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/line-range-options.adoc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/line-range-options.adoc b/Documentation/line-range-options.adoc
index f275df3b69fa..c44ba05320f9 100644
--- a/Documentation/line-range-options.adoc
+++ b/Documentation/line-range-options.adoc
@@ -1,12 +1,12 @@
--L<start>,<end>:<file>::
--L:<funcname>:<file>::
+`-L<start>,<end>:<file>`::
+`-L:<funcname>:<file>`::
 
-	Trace the evolution of the line range given by '<start>,<end>',
-	or by the function name regex '<funcname>', within the '<file>'. You may
+	Trace the evolution of the line range given by `<start>,<end>`,
+	or by the function name regex _<funcname>_, within the _<file>_. You may
 	not give any pathspec limiters.  This is currently limited to
 	a walk starting from a single revision, i.e., you may only
 	give zero or one positive revision arguments, and
-	'<start>' and '<end>' (or '<funcname>') must exist in the starting revision.
+	_<start>_ and _<end>_ (or _<funcname>_) must exist in the starting revision.
 	You can specify this option more than once. Implies `--patch`.
 	Patch output can be suppressed using `--no-patch`, but other diff formats
 	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
-- 
gitgitgadget

