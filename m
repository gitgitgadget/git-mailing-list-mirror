Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5D1FBEB9
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749373795; cv=none; b=LEgLjc1X7fyURDevtgpoUewHV2R+3CsgYPhF7QFRJpfs28gVi4wcf5wi39V5eZhB5ud3ZxmYnFfwawwS3fEN5jBhtKYDv4zcPE5x/aR2T1MMVeuqXwmwTe6pZ+gdGRhQPvv7k5CyZyHBmez4OaMT+coFweZ1EfO6mjQcYrmnBas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749373795; c=relaxed/simple;
	bh=V1TKFkj2avks98qi+QPmVnNSntCFyy/q85tSEtKIXT8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=N+WXAR1z9Webr4Lb2WYFks5JT55OWQ2PpvPgF4ruM2OeNNmSLZ4JlBMqWfJ8w1S2fXX/OXz3Rzr3OBpH26hTd0/4Yc4Si7BbW3BvVEW6S/VdIL1ZEXs/bbMb1mhIVh/hKna0GRuvvE65CVQzUwWsKz4oES0iAVzSuPnabSwR7sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmGuzNGD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmGuzNGD"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d3f72391so45331565e9.3
        for <git@vger.kernel.org>; Sun, 08 Jun 2025 02:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749373791; x=1749978591; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scvdSUiBmyCG5vF0CjLET40XEP076IKjDasqgPx5raM=;
        b=MmGuzNGDNGYsxtwCJIK6nfztIk5+z7XfZLJePWWitg4o5kE8yUXz68e3ZkX/e8yft6
         WkVyf3aUudr+30IabwWwNKqyD4Y7fzOmLSPe4NYCEsgcJvrZwMa55UGFDJqoQaE9O7Uo
         wqn3NT+lb5NXgUxQjk/Xlh6Lj58YA3Tl21gKRRnLbIm8sYtaGRZCjvE0lfI8uu4qvJeW
         Yjno9X5z5PZU2k7Z20/FU6xjP4K64oV9xhY18mgYR1fVvUYgHs4zHolJvqNyb3ZPlina
         CmhqZRmo/A7+C76mn4Wwz+h3/uQBBpsqDXwzOjLWjr1rcRNdwWZEgmPOcD9Z2SWls518
         NAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749373791; x=1749978591;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scvdSUiBmyCG5vF0CjLET40XEP076IKjDasqgPx5raM=;
        b=jk2QhCdIfOQELwBqrQ/gxnMAad3bidwdfZh3VKz7ik5o9As6Te2+goU/zGh2yk7ZjM
         wRG18zmR5b9TphYOvVfwD10SnoEE1URE73t2HAdx8BkUAOMcF/PAK6ipD8E8MbaGnsjO
         69QqLtHkqfjoeFN5fqsyJ4d++djtW1RV0JAD/fmSJbdvMcmgPMzE45RB4MTZc0RJtOTB
         uDQjQ/UsiOLhKQYM9+sZ/5Cuwr9VBhrn312usM9Goz4+Ev5RU0bX7/dTxk1OeWeAWD4c
         ETMJoEkvdprq4qeT3drnscmR8+RyYfvifVtK6L3l16MZjjaDfu2rIfvSEskGuemv7dFi
         KKJg==
X-Gm-Message-State: AOJu0Yx50YToM3vofVbwT2WNyuSEYbCg7KcssGowbDopNj9hAbHjzFcT
	YJxqvOuVvTddhenn9O/nada4iuE4IDJ7keaYJQ5S9ogMALH4EuTbgJj8/Wa1Ug==
X-Gm-Gg: ASbGncuCd3dQDzpmthDzRgHVlq/07W/K/DJ3eQtd6nieCe+VttPLp2EgLYGvK+8MlFf
	bhHRs7k6GHjvbSUcpsT9nUjrhfmXkkL345dvEt3CtkhBx9+FXRXxGSNcO2D2IlozSHNJ4gULve9
	s5nXCMZ1Zm5cxH4muvedWq7RYytxPx/LSLJ/T0mQVEy0O7UhBGBF3LMeovwwbHrufQdOYwp0FIQ
	7aWKx4RQUiTYrGSfk9zPO6QGkBJ1NNmH+M1wUX8BoFlou1IxrQXPV51nKniHxtwql6uumoHjWIU
	rHuRANU72EZrl+TBy5pRDo9QYTFOdZqObzTBdaFqkBBTaI6CAL8NrgCn2MCcIIU=
X-Google-Smtp-Source: AGHT+IGyC8K62cGBoYHGnUhy14w5X1XCLDUe4jSRkgv5YnWjkZ+1XK/NNBmJfk1gek8ludxQHQtUpQ==
X-Received: by 2002:a05:600c:3b0e:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-4520147f41emr90569015e9.18.1749373790919;
        Sun, 08 Jun 2025 02:09:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4526e05636dsm78826325e9.4.2025.06.08.02.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 02:09:50 -0700 (PDT)
Message-Id: <3992c1786ef3c87c8456f360e14c5b2d11b2622a.1749373787.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 08 Jun 2025 09:09:40 +0000
Subject: [PATCH 3/9] doc: git-log: convert line range options to new doc
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
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

