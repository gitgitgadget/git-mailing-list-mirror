Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2AB1C5D76
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039260; cv=none; b=VLhWyOKEWcrHaLuFbpQuk52CImY8keN+ZX8BXYibt2F6lLvGzY/iyih8qFZ1bhCsZ7KQGRO4OttRJwiJLWsIjl2+UExo08WE1dhI7LwlzhQ5PyW0zjFG/c+L1fqEZn/cSWCXnaSDsOwGyWYRZzLigqDY+L3nm+hxbblUQEVAsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039260; c=relaxed/simple;
	bh=hXw6b7/8PdDx/cYq7kQezg21ubvurBuqePcuf/gmn1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bcI9WpHugr15GXSrRi711Dx1mdc3CH2pHmme40A2uU4wNoeYC5gjLyiZ384HdEgwZWY/CS2dUNxXwNP2+eLvdoycTZEIhYBHUfX1Bpc1I1O3autoteNapGY6x5OUBLjQxFEVMtaN/xEkk8hIxerv3lP7elXLj374fQUP2BPtOZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdzrVcps; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdzrVcps"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2232b12cd36so66825945ad.0
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 14:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741039257; x=1741644057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oj1jngaNoOPawWIAboaPUYKgJGGCnQP7xC+57TEEIS0=;
        b=DdzrVcpsSbSKnKRk/7JrBs42Y3LZm75+K86FO4sjKulG+JGe1sdA3jbfTTroUMFclJ
         nYL1qGnwJC6AKdq6c4fvbxHi2HKDfQP3qCFXHXRJufZBpg6pN+q9npmtAIkmYLo5eiSc
         mX7MKkS+0QElDx/UL5olLMwLxDDzjHk6arbbtqguz+tPG9enWSCpdq/apIJYCtKuaZGS
         aw/Z+kc2S5iGPf1v90WVJcG2oztjfp6Ec/79FS8kCkVBQ2opHLV29vehrljbWorSd/7R
         Stbm7boxs1Bf/SFo1j2evYAxYYcxJIAWAfJAIb27PoRoxD/x4lrgrhC6l8ZMxgMorKuN
         Zw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741039257; x=1741644057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oj1jngaNoOPawWIAboaPUYKgJGGCnQP7xC+57TEEIS0=;
        b=mClcNcpXtGAtJuYsrgPJIXdd348uACr9bjJPeStghj5mFDSFF9KIJQNByuDUyELo6o
         9CjFUtIlH82SQgcTA99wEdkFl/5jbTRkp8mSASt4GZAXywVaPAvcQpOsXVi8fkZGIsBP
         5/GXQvWg3m78g4+SkQjkTMTGl72Jh7RN0E+zTLkv6rawCBTNk1B6hK2dqkzB0OMSwny3
         67nz7e/cVGgJmTnSdkd2ah9wC5BYf5HNQsB+xESaLs0dxKOOrT5een30M2CKZLN7oMU/
         tASaAOozmOjZAGjI8vjoRLBGxPSld4teBgMpk1T21kWVZUkH7JpWRihtlWmfTZ5JTz/K
         dzbA==
X-Gm-Message-State: AOJu0YwAJtYAOLlsfNtlOXKIa2EWzoKkwuXfeoD2poajbXWt+rHdzCsI
	IgNwjlhPKXaAqjNmnh8VWF6+WnJuGDr9YrCHzUt6kCVaSyacLsTBiz8aXA==
X-Gm-Gg: ASbGncsNw5Idi93ifMzlKQN5Q89nil/bW1nFtfM9gG7nDfi9SFXRdc7VmltCqHONUyT
	URmBoZBc9O6Uq2r5xI9yE3zubX0klvls5SXByGnrU+1KOtlwUA83ya+WSd60Y433vEOUci4sUGu
	HSdl8T+QlDmCjXj5cJizBNE3dNryUVXqmsIQJUmQhCM8cXpVeI+x4Yqa1CKHHJufrs4tUsqx3bN
	KbZpZbLCI2hI399CJ4ZG5gz5s2sJOw+/MVvr4Zb8hDwzgBLDCsgBxejxj4b6Pvxdp2BaoP2A8zC
	nEsvx97RdSAJ95gz/D/M2uINjwkw//WuFtNjUVn6YeTQxRPmwwU3U6PL4yTBx/Mpg7+CpvZ1tNt
	s/3cSdLznRw==
X-Google-Smtp-Source: AGHT+IF/1sNxLGZMHFdP6s9/npeMX4o5k0sqmO9RpKqRR2dhrJksA7xOrFJ09osSc0TDjjbiGdBwyA==
X-Received: by 2002:a17:903:2b10:b0:21f:85af:4bbf with SMTP id d9443c01a7336-22368f94859mr234172555ad.20.1741039257415;
        Mon, 03 Mar 2025 14:00:57 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:b77d:283:5dd5:8e9e:2c56:864a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc7e1sm82746565ad.176.2025.03.03.14.00.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Mar 2025 14:00:56 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC][RFC PATCH 0/6] Add --subject-extra-prefix flag to format-patch
Date: Mon,  3 Mar 2025 19:00:23 -0300
Message-Id: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This is a "scratch-my-own-itch" patch, adding a new flag to format-patch. This
flag allows the user add an extra prefix to the subject, placed before the
actual prefix, like the "[GSoC]" in the subject of this patchset.

This is specially targeted for new users or developers from mentoring projects
like GSoC or Outreachy. Currently, if we want to add to the subject something
like "[Newbie]", "[GSoC]" or "[Outreachy]", we need to perform some hacks like
passing --subject-prefix="GSoC][PATCH" or changing it manually in the patch
content. 

With this new flag, this patchset could be created by using:

`git format-patch -6 --subject-extra-prefix="GSoC" --rfc --to="..."`

This would be only a feature request but I thought it would be better to 
present a first solution, so I'm sending my implementation as a RFC patchset.

Thanks!

Lucas Seiki Oshiro (6):
  builtin/log: add subject-extra-prefix flag to format-patch
  builtin/log: die if -k and --suject-extra-prefix are used together
  revision: add subject_extra_field to struct rev_info
  builtin/log: fill subject extra prefix in format-patch
  log-tree: add subject prefix in output email subject
  t4014: add tests for the new flag --subject-extra-prefix

 builtin/log.c           |  7 +++++++
 log-tree.c              | 12 ++++++++----
 revision.h              |  2 ++
 t/t4014-format-patch.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 4 deletions(-)

-- 
2.39.5 (Apple Git-154)

