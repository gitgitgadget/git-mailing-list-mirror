Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90E426F449
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895887; cv=none; b=jvK1oZrLz/UY5V7knM2vsfwyXk2OylFIXuYdEi5ByMqs4ZIrNUw1fgP/lOB9ohlGJ6qGUSVhR4dyXOtLFskFxT/PKuqH1+G8ifG1W2P3bh+YkP9x9vGKtLA8qGgMFIrMzjccQ9JMCXc/j10PWjXtOJEQZSLWAU4xY9rck8S5C0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895887; c=relaxed/simple;
	bh=fsb00xLpOxRrgT/DgrF+Cf4vGKMmdw1Ft/tXfKOD7cs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RxYDJoqSJDFXQkf6carxLgM5O0GBbMOsZQZnqq6+WIXz4YTTZ9FOFNDqXbBpkM9rvyT3nsz+tzTeaD1kCZNKs48If8RgyDZq5N8QUUzLlJmAzgMFNJUiXngZdSj4GHxnwiJlFlNlp++W+/6Xs+rQShyfcTInrBdnVIuoOSJ0pFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4vTqNFC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4vTqNFC"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso21219655e9.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739895884; x=1740500684; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nykryX9gYlil/AYXBT+DOOFcMiqRnFeK+MsOWuNjDGI=;
        b=j4vTqNFCh+TK5w3j2AAvxEK5sHnHPOMZFSo14ccAABARSjXnIxQR8F+zcYPyzYfGSj
         PJ9SolByBt1V9uGeYsCewHUDKOpY5zOdbl+wIXe5CZlBn3rD7uvXXnld5dYBUIu1JlYs
         fkkCQN2vl4uoGVrF8iBXxCqf3K3X1DTeaA0zDP5opaPZ8Hi5BkpE12v30GiXVxpPx7uK
         7uwmjnRQqN3JaRAzaJl/T4zRhcmAQchpcuDXk2lKjvIjr8GVbIv/Sd8FPUnLlu6ifmI1
         dU0XsUBnyQgL5FrfrEVaGQ/SnNkGEHT4CMbUQGxCY4yuipGG76TCfqKYSN9dDwdNQJOY
         dGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739895884; x=1740500684;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nykryX9gYlil/AYXBT+DOOFcMiqRnFeK+MsOWuNjDGI=;
        b=oQnyOjROlP9fAvkJO8qzlseNIdcTXyE2L5IP+shAaUnx91leo1gHn+twAZA8C2UTXP
         ynmDiL9HnaYcPQpq/Nl8G3h9SdQ0jXrMctjbCC1cHJeBg8lIiwY0EX0TftcHrGIQe3XG
         EsJ/4kYxlFVBS9/jwOMBYRWcVrPaiL5QA1Be4BgDqMFzxQ7Q0guX/Z7HV27iT+Lov/hd
         rbghli3CxK5PUqNLFmnX0X/Kt/+gs6kAnaxAekHoaCkQHnZ8e5mx/djjCzZ49qnwMTQb
         ttqHtfvrpJyW7UYOOKxg2GFaqVYzuaQuRRxzUAmWMukYgZsPMKTHJvf48D/8F0AEpR3j
         3L/Q==
X-Gm-Message-State: AOJu0Yw+NPhdRmfw+xUXAZsbF5w7qBT+if1NgQhjer/babiAH/OAYaH7
	LFmuN1iHQj6nEzOwZRs3DyyqbA4YwN6KbzZ3WOPBXf7pH6yB4Ez/GxHNzA==
X-Gm-Gg: ASbGncsDmHFBEp01QX4MGBUgqTLRi+XTDJPkM+Uv10v2pc6P6SjthFJ+sqsW6L0Bi/o
	juVy8jlFqWrWd+MSfaqpBYc6trExOb8KHsglVnJ2ycyD3+4YRPpHiBuqLK0tY//VcNWdINTH0ED
	nXHByVIJCLLpLGEvsPaaR6Xrb3buR+A4AiqtfPP99ZBXOeKw6CKy+7H6x7U+Eaay9HQIBOWob2i
	KJUNBJffTz+2RR5QX23+x9lMMAq+uyLbJ/8VxGQgpIhR4cvfJCYWchoD7M5/tGqwWr1PwlD1IOh
	phcy/hr1eEiUzCDf
X-Google-Smtp-Source: AGHT+IGlmOPFL96uGyOaQnt+k/ffipNuKKww0Hcx3GnmKMAfMzizWqnz92pz9LmkOZ9cY41KdWHwaw==
X-Received: by 2002:a05:600c:1c86:b0:439:98ca:e39b with SMTP id 5b1f17b1804b1-43998cae5a5mr15787535e9.29.1739895883391;
        Tue, 18 Feb 2025 08:24:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43996b35040sm17053145e9.23.2025.02.18.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:24:42 -0800 (PST)
Message-Id: <f95a15a42037ac3f523c15f460ecd325331bc5b7.1739895879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
	<pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Feb 2025 16:24:37 +0000
Subject: [PATCH v2 3/5] merge-tree: only use basic merge config
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Commit 9c93ba4d0ae (merge-recursive: honor diff.algorithm, 2024-07-13)
replaced init_merge_options() with init_basic_merge_config() for use in
plumbing commands and init_ui_merge_config() for use in porcelain
commands. As "git merge-tree" is a plumbing command it should call
init_basic_merge_config() rather than init_ui_merge_config(). The merge
ort machinery ignores "diff.algorithm" so the behavior is unchanged by
this commit but it future proofs us against any future changes to
init_ui_merge_config().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/merge-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 3c73482f2b0..3ec7127b3a6 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -576,7 +576,7 @@ int cmd_merge_tree(int argc,
 	};
 
 	/* Init merge options */
-	init_ui_merge_options(&o.merge_options, the_repository);
+	init_basic_merge_options(&o.merge_options, the_repository);
 
 	/* Parse arguments */
 	original_argc = argc - 1; /* ignoring argv[0] */
-- 
gitgitgadget

