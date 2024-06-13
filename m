Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F0113A240
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718310316; cv=none; b=ogtpD+KBJVYWYWsrURe8l582I2CSJee7qExt4IpmOJO0s8pGhvVVO648dSvBYzSXWbvl9dqh6CBsItPCH0bWPm+w7Zf8NLxIbo5/QmTld1fkjwHnLLSiJAnXjb89e+C4sMyx7QyKOzULKcYLAX2BpfzZD5cIoiL/vB72y+Al590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718310316; c=relaxed/simple;
	bh=rfddR9IyWKrBII454hny5+7nItNCo354Z/dpCnKX+ko=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wb6qYZzRQAYZPHy9mXs9u5B1+/XtsUK3SQePdroTOAGSYRuAbFX/UYMX7APu/NnrLw/rZLoUEiKdAckZG501hAc6vHXRltm4qtSzDV0qwqWWtzYTnqInZEgeclTWlEMOb+Ui8UjNYSBfrtFCo/ItscHrjic7R7jp5Jj7yelk+O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjsK8wKo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjsK8wKo"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso16298675e9.2
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718310313; x=1718915113; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTvnjTA+Po5ea3tWbEUN6diN2UbWvIy0/eP5L9cBdDc=;
        b=TjsK8wKoWMNKxWQvrWwyJ//gB1F8sFyhZAGMQFl/QKOlcX85RmznObcdRmvYgmO7h8
         3BZuwlhjLYo6ITagsDG6kK0TDhtQO8iS7Ci+MFQdA/RsKWF9o9kdeMLKESlHVbFhx6po
         AyQfMW3SJCdv1fIWDv0/KWZfTP9d6AFBhFMCss2SMAWemx4ivVbf90kcF2dnhGU45ac8
         +ocY/+x+1Kwwci70tq3bnIeV1s5FkCC2OD4JM/ghS5w76f3UBxfKEfk+rMCsdchOCqmt
         fxQvP7vsHsX83knb41nqkOWAemAbpe6M9ck2tpXb4Bm8ca0+HGYAXZICQBcIbRaIGmlg
         dAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718310313; x=1718915113;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTvnjTA+Po5ea3tWbEUN6diN2UbWvIy0/eP5L9cBdDc=;
        b=T5dT1LMEzG56zlTvHUYt6n8IFSZuFus4cFEE32+vM4HxM/HmV/a9+2dZaloYmyhsYB
         yQ9yyX0MN6xYE2lk9zuGT+v+eEduxYNngh3JOQOWEZ2Cher5W4fwmru5bMbWIVHUAzel
         krh5O6hMexGfKH4pHXy0Z75qfQ2OeS7LeS6d2quELCPwtTwhK+RvzOWx2I8dcDT3BZdB
         NxgA4vTUXKH0y9X959MdSAFd+qMxbukcZpTjux8wo/HfM/7ah6dBHQ8FK7xiOwJw5jO/
         oZfvqXpzxrvwFCuQR+GHH83bK7eIFmIW7QXVE8uWwRpsq1RxWeR26cyeRUKhqAHqwzyR
         5bUQ==
X-Gm-Message-State: AOJu0YzTYzImrdGLbyw5khWTAm1ruHtDfrzBwryW3tV/9WH2xFHEeaoB
	AljQsjNGgmv7+p7MVQlcZ5AD+thdfYmg2K+BiW5jVO9g11S8XloQ4/cVMg==
X-Google-Smtp-Source: AGHT+IFMPKBPChu3Q0pS9pR8HE8E+jvlgdzA9ORN7UCHQGlcxCWcBlyDhNli6QTgv/Ap2mXIYr3trw==
X-Received: by 2002:a05:600c:3b06:b0:422:1705:7549 with SMTP id 5b1f17b1804b1-42304844acamr8268545e9.25.1718310312950;
        Thu, 13 Jun 2024 13:25:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42301a7c850sm29166365e9.6.2024.06.13.13.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:25:12 -0700 (PDT)
Message-Id: <2789c58cd3f0691a32cbd0a5aa96a438b799b9f3.1718310307.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Jun 2024 20:25:04 +0000
Subject: [PATCH 4/7] merge-ort: clearer propagation of failure-to-function
 from merge_submodule
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
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The 'clean' member variable is somewhat of a tri-state (1 = clean, 0 =
conflicted, -1 = failure-to-determine), but we often like to think of
it as binary (ignoring the possibility of a negative value) and use
constructs like '!clean' to reflect this.  However, these constructs
can make codepaths more difficult to understand, unless we handle the
negative case early and return pre-emptively; do that in
handle_content_merge() to make the code a bit easier to read.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 13b47d352fc..39799e65a36 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2193,6 +2193,8 @@ static int handle_content_merge(struct merge_options *opt,
 		clean = merge_submodule(opt, pathnames[0],
 					two_way ? null_oid() : &o->oid,
 					&a->oid, &b->oid, &result->oid);
+		if (clean < 0)
+			return -1;
 		if (opt->priv->call_depth && two_way && !clean) {
 			result->mode = o->mode;
 			oidcpy(&result->oid, &o->oid);
-- 
gitgitgadget

