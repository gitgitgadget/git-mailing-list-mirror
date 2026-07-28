Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85E9391E60
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258173; cv=none; b=ltJzZHlJYOIWtNOmXOZN5dTI8S8bFtTa0suwRxXXV+6XrIQ+0Q/oPHR91GhBYVrlqFgllRTkLITuhBWMCV5sHY1sGTQ8cAjCn2Bds0LZxOTke/t1AmVTVQ/J2tFllUX3MG4R/e24LetsGZA0gzQdXMR7dD5MXcFlV1zdX/HXAYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258173; c=relaxed/simple;
	bh=fYNzxWHJnCP8iH+mxL4Y7QJjYLTfFBJ84s4GawnmRHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKgvmK2OGvpm5qtphkpit4Y5UeMuf16lPiLHC8KLFVr2mFTwyC3trZl7KakmjXme6Rm77OOcgQqHgwPzra9Dt+DLyKfReFVlesxMaeTH6fFM4OOurJxwDGUsu8WQ01Dc4wcYduM2fUWWXSvtYIWbt6Hn+Dw5gSbQrJkN9vFMOWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVOwWotV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVOwWotV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cca0c5799eso1464115ad.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785258172; x=1785862972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u+9AocexUC9ZWqOzzrRD6OAeXU69/NkNIeCfNWF+pr0=;
        b=oVOwWotVBDueKjnZbjoefbYpDL50xErfQkHp1CrMEE72d88S1FcwUVLOFQaP0e9AN9
         lMqFc4eTVMoBTBFEVJ+hYd3JJ16ghTgHl8m67wJlZTdGPX7oio+St36VryZZE1K/ls7e
         f1Lnv+8O2CxG+8g+WSwunSpK7Vsqb6CtTxHcj4tTp1Mg8r5gOSTFmodDX8AqFYta5vUq
         1DHiCFk4CMYO4fHiRWgv08AoKdwqw7odIhh9GuC8RcMewktWncmyaykqIo/ozKneZ9K9
         rWB4TT7EMx+tO+cUmrQQAMGXwzYXggQmaieROQL05160vlKEbfhsD52T1KI77Q0Oj3u3
         IiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785258172; x=1785862972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u+9AocexUC9ZWqOzzrRD6OAeXU69/NkNIeCfNWF+pr0=;
        b=SJFaTsUN5NKq5ORkxCkzH8lh/Kjy4kUdozA27O3grgZJEBialtAHrBXXHRLVVr+xZ3
         t3HBIW8dj6LqbFZvA/K/E3aGm2nEr7up55QjLcj6/f/PWv2Q9lDn86+Ri586o9KebFNI
         BbuwJ/nQmuAj+qq070jOGWYjj/exqzx41cWSfY0EhYXQ/t+VLgFrhgG+qsLOiJeL8zhM
         XtB3ID0UdVqniZJbqlnC+rPMOOWbaBexks1MZsIBq9favdabOWl6RzBsnx81HNGyezk8
         /dfyS8lvdh7WbTKX5HhMh/Jw5gBi9qxTUIl9BP0nFFdM2nwzjeGBfrCYgKQKqj9hYE3n
         ZxoA==
X-Gm-Message-State: AOJu0YxH8+OqdcRoHX7sAC/L6em0KfzP+OYwG6Qqz2eT5HiQdTxVeE+E
	0cfcAXBBzKkxG9hGWXjSEOhGYRAZBbn2MejFXS0YuKpU59DFHtXrXJcZjeq4DTCr
X-Gm-Gg: AR+sD10QgyncbNS1Bk32Y+kr6yKS5e8ePENPvXqqBCcxI/94YAWJQ1Z0MboiCSH+muL
	Kx7QEFMjWWXerZN88UbwMggYS+8WkqIosLDrnHbXCjXVeEYwT94+jbWkZIYGsi7eQ4dzikfK4Ji
	SbIbAlGK1nDB8vmeTTI4YbIC1/OIzTU8ZSzYG6hKALAc1i12RVFDOmW0nackx/vJw5UJrXew8dx
	uYYl0AakIuER5va3DOR4tDqyJbjKjvWIlxjFm9Q03q9cYWXbaiI0WE38UOzczK4u9x2cV/tdxbS
	3XqtVZsWiPU/1nHSKW3dRWdUij+gvFcS5PuhVOMBUuhkkHbDU6pLKmlRm9D42GeJ4Rg6L/KbR/X
	RpSoUaJKXi3/tcdq7bFbv4ITPtklaNs/Cv0+QKICYWKCOwKWM991FCBUW4PXm+HNp0eKvbIx9J3
	F6fmJx5kUaC//CCKm+Jjcyp4vD8K2s
X-Received: by 2002:a17:902:d4cd:b0:2c0:e2ea:6b0c with SMTP id d9443c01a7336-2d015c17676mr36695985ad.21.1785258171744;
        Tue, 28 Jul 2026 10:02:51 -0700 (PDT)
Received: from fedora.tail0f6912.ts.net ([220.158.183.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d3c68asm589060eec.24.2026.07.28.10.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 10:02:51 -0700 (PDT)
From: Hardik Kumar <hardikxk@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	hardikxk@gmail.com,
	l.s.r@web.de,
	pabloosabaterr@gmail.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im
Subject: [PATCH v5] utf8: replace utf8_strwidth todo with descriptive comment
Date: Tue, 28 Jul 2026 22:32:28 +0530
Message-ID: <20260728170228.31410-1-hardikxk@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726123427.173877-1-hardikxk@gmail.com>
References: <20260726123427.173877-1-hardikxk@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `utf8_strwidth()` function is used in multiple places that all
expect the function to return an int. The result is directly used for
padding and width calculations and passed to `printf()` calls. All
these operations expect the function to return an int value.

As we do not want to change the return type of function and its callers,
add a comment to explain that the need for an explicit cast is to avoid
integer overflow that caused git to crash.

- drop the todo implementation and remove from codebase.
- replace the todo with a reasonable explanation for the current
approach and why its not worth the change.

Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
---
changes in v5:
- update the comment to better explain the reason for explicit casting.
- improve commit message with a reasonable explanation of the patch.

 utf8.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/utf8.c b/utf8.c
index 96460cc..d82e54d 100644
--- a/utf8.c
+++ b/utf8.c
@@ -227,8 +227,9 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 	}
 
 	/*
-	 * TODO: fix the interface of this function and `utf8_strwidth()` to
-	 * return `size_t` instead of `int`.
+	 * The function is used in multiple locations where the callers
+	 * expect the result to be a signed int value. We explicitly
+	 * cast the the result to avoid integer overflow.
 	 */
 	return cast_size_t_to_int(string ? width : len);
 }
-- 
2.55.0

