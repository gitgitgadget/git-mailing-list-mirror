Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316BB296BC1
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161062; cv=none; b=m8DLM7TDqmXccKee5KE5dHBWlxQojUIC+RMe5vks+ovKzgvZHrrIKKTD2Zq4e6+Zi8m5HrpNsG3wj5OajWL2kLbNChIGWDi5ex6BbDH/QQDYIOIp5UESNVZpQ0HHU01MhuIFDdj6sW1ozVJTdEi2qHD4w5zFo9Vb2+NdLsXeMvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161062; c=relaxed/simple;
	bh=MTVYm5M+mqekBKEAB5KvP0zgQ3d1N+QWSXHnDL7JhoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfMlodLll0PIHhxBx1UCLK5oUcAPUNVzoqz6RdQ5q93hy55+/5HF2fuJWyWPd9vxwS6dx6FmlUNZd8CG+WOYY0Sp6761nGUe4t0NAfm1bQklzyvH5kgwR6dVtTXxstRJlYvCrIRwGWlNkIAWOKrlL24sqRl3c4McthyMAoF84KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3ZhnhY1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3ZhnhY1"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad9516a653so54319655ad.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773161060; x=1773765860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiuim5r6bfPoQvK9MpvmPTwpUxXGL8YvoUK7lGygsbo=;
        b=b3ZhnhY1m6Neouz40w4T5Ix+TF5wwX71x3nYzlxe8a+3MLA15tJWHNI6JcQ+DUTMqR
         spsjKdUJXUENN4SRRE2lHHcuI/DhFIxzykkOhgVH9xE+Hwr34Es7MHejV4qSA5QF/iDp
         MSzgo9m4ysxNPTIn+FNcMshw5n3yEmwDULuYNth7zDXPs/+65E+RWIBsVri2hTQjW98i
         3ymi1MuDiXqRgPpowlZQr6eM/rSaoPEw9Z79DRksK6pVl3Yj2mCgw+8MBNcu5jY0wp/B
         m3+pQvArQJGbkiycckDMMpc6P4oHTXr7oLdBCusgwnxxyw6419dc266B/Y97/iXK0fcN
         fNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773161060; x=1773765860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yiuim5r6bfPoQvK9MpvmPTwpUxXGL8YvoUK7lGygsbo=;
        b=V2/Ma3pmO86eVYbJIMsb3wko4sgGzt7Z6wiazlZuGaUDyLL8+OLLg23j9jPi10eQaC
         PvZJEn0FBZjNi/zvQQHODMTfabxRAVil/MF7buCOBoN0PRYDGniCcld8yAYENXww4n/H
         ELi8+YraSJ3gNQAhm6Eku+HxpehQ1wuA7Y8JlDQWD6aTOEmIveY4EW02IjMd9L8jawCy
         tvb6JA0R98NnhTwCytcIgXDScHZ89wewDgmfFMC7F6bWG+OQd+npkveEzQp0VU+K0fFo
         M563S4Smi++bE2PK1MPNeX8ZjQ1/ZepKexwQI/f7rUcrEF+NWbhKaxhvug6p+bWcN5Yi
         NglQ==
X-Gm-Message-State: AOJu0Yxf/lt8q1jL/iPrxb8+XabEccmcIwHrh8OATsPatTsKsW71eBNC
	u1Ri7EKq0fiQ9UQO8A6zoDgRtJD5gdWgJoY4dJbe/KxJqboNP+G/wPMioTYSk/kbPGQ=
X-Gm-Gg: ATEYQzxzq2/FZqoggPYSlT2D4pYyIswPZ7zUNLVzenvaH/lW1aiGx0KIjkM/K1ne5PZ
	Jzt7DydlRlME9+ZhCJ4mBd4OZ/LIKDN/MRgUYNZWL+PIrZ9SMdj9F4zxRaxDG+kwXjUvyQssaYY
	eV2acd27JrOoSNFW4dplbu9AMKhq9VX7Qe3rOSvI2Q3+LKMAh2FOU/2McG7AUd+VqscJDxQ9cdC
	qkweNkOaLk7zm50nKcMAUY4+4aAdJW25ka4Xd4z6t3CgVVyNFrY1wV0YhZ6wyIkk7NmMfB/C99h
	NjWx5NPc4/1IxW4ITZ63jj3DZ9Oweftc9hXyHFa1677HX3iGU0/ufhdiX08zIVuszqIADWrs1AG
	19RDClx5g1jMHPNgcVaPSkiDv41ycrfwu+yFXIqImV8EEoLItJGPGW+DqZ8b9eoRRtfP+9LO5Cp
	XCb3gcRffq5hS2PdmRp0veUTFlmtIWbQ5bTBfs/ZpI6a0+Z/34Z8+2tKskvw1ThIbNlYiUxY/BA
	MCmeSQgZGYPJOg=
X-Received: by 2002:a17:902:f78f:b0:2ae:7fdc:1a1a with SMTP id d9443c01a7336-2ae82498dcfmr139711185ad.51.1773161060201;
        Tue, 10 Mar 2026 09:44:20 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:c0ff:5e57:d15c:dbe9:ffbf:de10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e9ca8fsm217112345ad.30.2026.03.10.09.44.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Mar 2026 09:44:19 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH v2] submodule--helper: replace malloc with xmalloc
Date: Tue, 10 Mar 2026 22:14:12 +0530
Message-ID: <20260310164412.47403-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <xmqqqzprwu1q.fsf@gitster.g>
References: <xmqqqzprwu1q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The submodule_summary_callback() function currently uses a raw malloc()
which could lead to a NULL pointer dereference.

Standardize this by replacing malloc() with xmalloc() for error handling.
To improve maintainability, use sizeof(*temp) instead of the struct name.

While at it, drop the explicit type cast. In C, a void pointer (as
returned by xmalloc) is automatically promoted to the destination
pointer type. Removing the cast removes redundant syntax and prevents
potential bugs by ensuring the allocation stays synchronized with
the variable type if the declaration of 'temp' changes in the future.

Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
Changes in V2:
- Improved the commit message to explain the reasoning for removing
  the explicit type cast as requested by Junio.

 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 143f7cb3cc..f3e132888f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1160,7 +1160,7 @@ static void submodule_summary_callback(struct diff_queue_struct *q,
 
 		if (!S_ISGITLINK(p->one->mode) && !S_ISGITLINK(p->two->mode))
 			continue;
-		temp = (struct module_cb*)malloc(sizeof(struct module_cb));
+		temp = xmalloc(sizeof(*temp));
 		temp->mod_src = p->one->mode;
 		temp->mod_dst = p->two->mode;
 		temp->oid_src = p->one->oid;
-- 
2.51.2

