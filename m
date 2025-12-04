Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F83327C11
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764882580; cv=none; b=CfotCYdkrW9JlH2oznIN+3/Nqy8XtXcBz7TBbwiagOfZhlq//F0U1EU2bgr1mWf6MVK+CfJX1njjPSR90V4/RM1c6HOABu38UePlQc/sl4RolrlWHQM5pa1qO2HsNN8aTWooo1auzs1afLC5Qq3evyp9xHDSiZWLKzY0scNwOD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764882580; c=relaxed/simple;
	bh=yYF+XIR/rW7RII7j0BRljmL+IuOs+2yGpefA7/iJJGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtbgRsCI+BfPwdcTfxKCeg3zEKOBQEAr/AMzuMuYOOrxhrIFDhwe0JFW3RJdAGLilq0cq6HaW7/IK26fjiYay0vpXVtkMPZKx5xwOvpCeytY4TKiFt/G8cGx933NRxAdURglZ0fnGgLQCXv1WpIBBbljYi7bdufUoNOUVW8v1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4wA3XX9; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4wA3XX9"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2a45877bd5eso3353614eec.0
        for <git@vger.kernel.org>; Thu, 04 Dec 2025 13:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764882578; x=1765487378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVopW4AoMnmaCVbTkRMlfeJ9W8fFJHhZ2QZVhicX7hM=;
        b=g4wA3XX90UcvrofDLcz4uukypMhBu5E11EnJIU30jC56tVM36GL+JnJ3oc9M5sV9sX
         YXky+QrXi+HoWi5WjvkV2rt1Al6u4RD+DRICuw37JV6wAQJ5o5Fqv4cj37OHf2pZf/up
         wLTCmPib4lLoDqUieLDKcX6x96WIXZ8zbSSJt3r7sfgy/EoOEGfIHTXG64dMtKoIWlFH
         ZTapohD4urlRdNaFXlqSHFZYv4YpoTlGTiTwa4obBUxqqDLcAXvcq1t5qUn7yl/R2FHc
         whx3HMT9RKz5BEQvrs90CogZ+wnbNv61BDqQRXa5PqXjAvmkCC7nKV3ron+A9S2EohIo
         yOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764882578; x=1765487378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uVopW4AoMnmaCVbTkRMlfeJ9W8fFJHhZ2QZVhicX7hM=;
        b=s9G6MmXff5TAXxBqxMAkzQYZtgYWPgQWmUdFIFdMfbtBvS4Sk9vz8GrzzytIr+mpvc
         4zuaCkJrgP/KiLRziDLN21Mk7refayBD/8rXVFkWvOREsJnonLM/vcZspuvv20uf2tg7
         LbR6ZCB0BOpq4xHZg0G4BDu0XqYi+Em5sGA4ipwpz+Afw/0zPyB7Q4gwFDLspdD3pqGn
         WHh7gIXjsJvQIbejt2/hOLTDd6NiKR7mwmSfa5buqYf0XvAojERL1q94k3PrwD0TSNhN
         hbWzzc6PyIIFHYsCrxDtyaB4/AqPrgcUwmvUVFPxsDfsJedAk+G5BT1IUv11cHD6vhQk
         DzWQ==
X-Gm-Message-State: AOJu0YyM2XTOetTlGFXFAAboPvsYW7aQvKFqkcM1ikloSjt0nzE7pFCq
	QxdZ4GtoOS4plYJRz1Zqxsk0wZ0Tb1ztGrVeSKQugOgtCsEsLYr0swxIst3b4A==
X-Gm-Gg: ASbGnct+XK2plXmo5gEVCrdILkZaEDNAG+G54Yo7lmC4GIltOUrJ3SyNeLFBCNYXCey
	PbWdkeYO5Vq6OUj5YNJwFQ5R9jK6yD9lKZAMHzog0c1I+xMJeZRluZL1ZZY36/gdaGpXa9c5/kF
	/AV2zW6i0Q8qrtOU7pEb8tQH9wjF2QkWzU+EyKuQ+C/PSjO8oVk/5kCidb7up/NEYieHJYfxmRk
	6wmyoOHGW3XzYrzJkZ3MMfm0dXv6wk3/vY4xrJY9rN77IKPWqd91SwjOQoDtuWc8YaQWXKvY1Il
	kO/Jdi4WogfvZVADA5rXG2O2ISsBwkJUkBSPfGLWl8OC47qIKeEvjbYqRT/8RAz5yifUjFeclHw
	4fyi05VN34ZpZrIR3H6uieL5IJ4ylR8kfCjIH5IRBW8mFH/qWd9AsWtZtSPbzZd/BptJnTLW5kK
	ef5nz5jYKR1Ox3cI3m+TBGNrTl3HtuFp/9pIC3OSRPDGAJF4rjYF8kYQ==
X-Google-Smtp-Source: AGHT+IEKu0hCfP22m8kqW+MPWlW9NevcUMArJHQQv1ig86V6bYuPBwUE/kUuFN2aQ0zYImBIXOjpag==
X-Received: by 2002:a05:7301:3f9f:b0:2a4:3593:ccc3 with SMTP id 5a478bee46e88-2aba342dbcfmr2512014eec.10.1764882578085;
        Thu, 04 Dec 2025 13:09:38 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:32:8e1d:1817:8b3:9658:8ab6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba822b615sm7882624eec.0.2025.12.04.13.09.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Dec 2025 13:09:37 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	jltobler@gmail.com,
	ps@pks.im,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 1/3] repo: remove blank line from Documentation/git-repo.adoc
Date: Thu,  4 Dec 2025 17:10:10 -0300
Message-ID: <20251204210843.79411-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251204210843.79411-1-lucasseikioshiro@gmail.com>
References: <20251130203456.28437-1-lucasseikioshiro@gmail.com>
 <20251204210843.79411-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was an extra blank line in git-repo-structure documentation, which
led to an unwawnted '+' character after generating an HTML or PDF from
that page. This can be seen, for example, in Git 2.52.0 online docs [1].

Remove that extra line.

[1] https://git-scm.com/docs/git-repo/2.52.0

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 70f0a6d2e4..5d9c7641c2 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -50,7 +50,6 @@ supported:
 +
 * Reference counts categorized by type
 * Reachable object counts categorized by type
-
 +
 The output format can be chosen through the flag `--format`. Three formats are
 supported:
-- 
2.50.1 (Apple Git-155)

