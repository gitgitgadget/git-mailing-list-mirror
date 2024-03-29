Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8A6A35E
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711194; cv=none; b=R2Tbz7lbhQT3wdnIESEVeLbqvUFdynZ3CRzVJxCjKUA8J5kFnC5YJmgM2S7mmVGy3nYCpV/gzTnZAJyKEAsgrzsev50W1Kf/+oW+eV5P2NUcKxo1leLGyvN1O0v+gNg26gl3eWu9WqqLFByADfaDQ/tE7TfGqHsxWP7+l97FpGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711194; c=relaxed/simple;
	bh=yQ7eI22ja9klc7n4JoT+7zogpvATCZ0pOciZH7+fGKo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=KNKXgbauEsrSCPKhsjL4U8stfH1HSnel/HsHF8HKxx2TSP4zOHGaWTbukPgfMB1dS/csd+IqWHZXCuChszgbOpV7c5O9/7GrOrwdZJc9w0PlGlCcp/eInNdDDTIsLO5QgMNZjYM6yFQDtlOl9yRO5rv1p7kFTCUX+5+MinQttCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QL1neKdX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL1neKdX"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41545616455so9813085e9.0
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 04:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711711190; x=1712315990; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQlU2cAUxZVbnJuMOo/NrOv9u7aocpKGad/VrATY6pk=;
        b=QL1neKdXIeEF8YobZn8xPk9Zdx9MaF5EIFQOAhTGn24MHvWS8tnb5wSagwu61V6jLB
         x8eNESAoDanl2M8/m7sOMv3fMg7ROvYVuL24TBcq3L9iVSbprz7P5559gBqSQ75lrkuk
         Re6DWGd/7kv3Vva4CmwBUsXSPanwQtDOJQ8BU0NlFsM/1ydEum2Ihsc4IITzst18EmWq
         xd7fpiIAtGBnp1JmB5RbjQcKa879nWdW6BD927Bx9aCaH/1/niaZ/3E/J3vufduaywTn
         3dOPb4KHwM+q3v3Lqe/L65fg/tyDIVc8DiAwhqUayisNniovwKWsxh78wrkxUQoTXFGQ
         dM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711711190; x=1712315990;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQlU2cAUxZVbnJuMOo/NrOv9u7aocpKGad/VrATY6pk=;
        b=P2HiNAQWXT0vzKfXBb7Ubr1UGlUdy0EBRUpOznyHh3gCXCkZ2TNCCawkCjfKWD4ogi
         gVbYLQQfsfs92A1UtnZlYs3M+aTKlG3HM8QWdGK7gEbLedpFnANHiX5qji9iIcpvR0S6
         q9W20GnyJWplDtFPoQzjTIxnvcYkR6JVOg6zTTRVzACSeAn4MKeYDQsHlGUqHxu0+2Vc
         X7Hz/IpB7TnFlVzfoQW4tdspcqshxZW2hvfrPG0NqViChykF8wVPfjgLaXUCGp5mksjw
         /D7ofm1bYadXtl0lbo+qiKpmNCPZvCGlaiqjPGQpdH/hgeT3Bp6hF6JdJWSRziMiAABn
         /FyQ==
X-Gm-Message-State: AOJu0Yzb/1Gu/h/mNXF75CcjeRvzFeXsErHJNHqWkQ1V3LNb5WuJA+s2
	AvRNzbaprKCLzwLthj5puamlPVO9u2W0duGlnUSi6DytBG5eW/R7l0g/7Lzu
X-Google-Smtp-Source: AGHT+IF+fHP1qgfr0CUAeo8fYcIj2V7JCdaA5AeHFFE0uXezeGTajq9SDCl9BZ/0BHzQMATk5tC0KA==
X-Received: by 2002:a05:600c:4f0d:b0:414:9012:8553 with SMTP id l13-20020a05600c4f0d00b0041490128553mr1356149wmq.3.1711711190074;
        Fri, 29 Mar 2024 04:19:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fm26-20020a05600c0c1a00b0041547fef66dsm4259314wmb.15.2024.03.29.04.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 04:19:49 -0700 (PDT)
Message-Id: <38bd78c92eb4ed456c6d8a471bd29658bd30c47f.1711711182.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1702.v2.git.1711711181.gitgitgadget@gmail.com>
References: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
	<pull.1702.v2.git.1711711181.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Mar 2024 11:19:41 +0000
Subject: [PATCH v2 5/5] doc: git-clone: do not autoreference the manpage in
 itself
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
Cc: Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
    Jeff King <peff@peff.net>,
    Eric Sunshine <sunshine@sunshineco.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Auto-reference in man pages is a confusion factor.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/clone.txt | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/clone.txt b/Documentation/config/clone.txt
index 71a967f262d..0a10efd174e 100644
--- a/Documentation/config/clone.txt
+++ b/Documentation/config/clone.txt
@@ -1,11 +1,21 @@
 `clone.defaultRemoteName`::
 	The name of the remote to create when cloning a repository.  Defaults to
-	`origin`, and can be overridden by passing the `--origin` command-line
+	`origin`.
+ifdef::git-clone[]
+	It can be overridden by passing the `--origin` command-line
+	option.
+endif::[]
+ifndef::git-clone[]
+	It can be overridden by passing the `--origin` command-line
 	option to linkgit:git-clone[1].
+endif::[]
 
 `clone.rejectShallow`::
 	Reject cloning a repository if it is a shallow one; this can be overridden by
-	passing the `--reject-shallow` option on the command line. See linkgit:git-clone[1]
+	passing the `--reject-shallow` option on the command line.
+ifndef::git-clone[]
+	See linkgit:git-clone[1].
+endif::[]
 
 `clone.filterSubmodules`::
 	If a partial clone filter is provided (see `--filter` in
-- 
gitgitgadget
