Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991B20C00C
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772397360; cv=none; b=j6UGUiO3MxRe2R2HI0thFXo76CBsJA3ijmztfYO9TybqkIk94FBStIdr2KlJmwF9Y6W4fyFSoY1c6Q64oDyT8eFpK3Da01Qlg1i4On08li3N6diIy2fut8wKqxJ/7TMwB4rCURpyZ7cHpoNLMkFiCeq6q+4/YMJaPdF2KXMoy+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772397360; c=relaxed/simple;
	bh=xHnBjM4bYmBZGEJ/xDpOWtPiwIUExyRTLQihFTUlWiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+0eaEBnMwrLNa0zzxgbZ3aMHs6WzHzjSGcYl6vk48xr9rjY1wNnjRP1fRw+risSp7C0orRK8KVKled6AsaXac6nrH2e6+u3L8cTKQnMHZAlKDOHZAERuGxMCUh+paXD1AgW8rgSC0jZmg295rWSq/ZzxXKPSP53HJmRrzB+u0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw4kLgfX; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw4kLgfX"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c70c38515d3so244577a12.0
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 12:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772397359; x=1773002159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/PlGV/P1xhiclaPTTrqu8VuYXEvl7UjGccPMcJ0uFo=;
        b=Qw4kLgfXDK0bW6Z8+qKRJuhJWZTliUjcN5l9pI369pWiM9Z1mYXFDu/YbIOFjVyXpC
         TlsbNYxqv5ZVKIdOMa/vZV4jC5Ku0KOcdVURx1f9SBA9/gpsBbKeLc7mB2Nd9wX8GeZz
         Awk5mfJrw3hhVfFkSiRaYb3y4ar9kPkkY9IxF6iVa12CiLqLo1IhwbnV+L4dGjt/ASTt
         sImTDpXGOrEM8AjI19oNqRzZ/tRBAcFH3m8i9iWSLQPe4MYycMbKW6x/laGkGdcyUcNP
         2yf9/R0kmFsTNHgCLLWehqV0zAu0HN2+24DTg/bF4wu4C8XSv+6aAoFgb1VwaGulMEgO
         MGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772397359; x=1773002159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/PlGV/P1xhiclaPTTrqu8VuYXEvl7UjGccPMcJ0uFo=;
        b=IxJsF6ipntZbp+7uBqM7aaYgdF6h8+FUua2Kqca5kYsEER9s6rM13gRsxCgCucxrYL
         KvkAvOv8l8QQUhvQiot8i8zniUvkWwWarv1zvDEeIlch+b8EZo28Z9S5hb4yoUJn/JWH
         2m//UIDxkkwOHBs6jQ6bAQTNTUF2+HwIHWv/x8osSNAcwdXG7zvqq/Ut0jMI2AWJ5cyB
         NLc/7A7ZtyJIHRnCgatQCaLUvyk+nc1CxPUqd9QmLJQjH50naUpQVBYbEigDTGPYXbA0
         Eux3OtSH4SzB3g2m+sOFOFqJbtKQwH8pELdgiYkTmFUmn5Jabds3mdcnD6lbTSdCfpu/
         bCSQ==
X-Gm-Message-State: AOJu0YzzAYsZJdCERU3Ack1Zv00bibVH+iFMEAEAVunzWcUJfw2tEKrl
	9timXM5Wxh69pfebtRdbBXkrIb1ZN/rRgxKLk8FQEaKmjx0JClRuUcOKeOrhGvqo
X-Gm-Gg: ATEYQzzEUoIqdVzOGhr21ws+FrlFXh9R32TjgvSFTbzfzpgaKvIerlG+0j4fnQftEG8
	FEjANmnvhhBzyXLu+GMPAYphU64rXnzE+D54Mm2TpRzjgjzwsGlBki5zX7eA4AOm57EBqbkaD5T
	f1xcYMe5RviRtGBGlvEp71tz8Ps9dqX6mbhgj/AXpTxD/dgRixPrg9hbJKcwA0ZSCKQvg4/WZFh
	U6Y3b9jqMlIw+Dy7H/EPMXrdX9kIylTpE1VFP1pYQMdVGDH5NDsf3T12VJEzCPCwlIdDw+K4g23
	T5vYUuY5FCjFPCuI2q3XqIwBiCxVIdUwXMSsyyUaqLQC5CTLnlWQVSHuFTY3uTnmmxDiQ748zn3
	Z75u3udAtuwSTfaUwF//BGD6ltsegPGe/m71oBUnc/JftyAWlJk10CVGn9Kb799I27wHRf0UDSz
	+DAR28QEOXz2OY8u4ziJXvJhZyW5fJfjzKNd8MsFm/oRCvL14qgONV6YMQWVbpSbgYRtkNPFCUb
	IpBZV3UoG5evaWR6cbt+xU=
X-Received: by 2002:a05:6a21:6d88:b0:393:fb84:dc4c with SMTP id adf61e73a8af0-395c3b42d45mr7009493637.6.1772397358691;
        Sun, 01 Mar 2026 12:35:58 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5e4abcsm9496976a12.5.2026.03.01.12.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 12:35:57 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood@dunelm.org.uk
Subject: [PATCH v3 0/3] environment: move encoding configs to struct repository
Date: Mon,  2 Mar 2026 04:35:36 +0800
Message-ID: <20260301203539.1421152-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228040727.2057192-1-a3205153416@gmail.com>
References: <20260228040727.2057192-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3 of the series aimed at reducing the global state associated with 
'git_commit_encoding' and 'git_log_output_encoding'.

Changes since v2:
Based on the invaluable feedback from Phillip Wood, the architectural 
approach has been fundamentally adjusted. In v2, I attempted to migrate 
these variables into 'struct repo_settings'. However, since these are 
eagerly parsed user preferences, deferring them to lazy evaluation broke 
early validation.

In this v3 series, the variables are migrated directly into 'struct repository'. 

According to the thread Phillip Wood shared, plumbing the repository pointer
safely through the 'git_default_config' callback machinery is highly
invasive. Many top-level callers pass custom structs via the 'void *cb' pointer
so that blindly casting 'cb' to 'struct repository *' results in weird bugs (at
least I can't fix them all in one single patch)

Therefore:
1. The variables are parsed directly into 'the_repository' during config 
   parsing to maintain eager validation.
2. However, the entire read/write paths (commit creation and log APIs) are 
   fully plumbed to accept any 'struct repository' instance. 

Future efforts to libify the config machinery itself will only need to update
the parser, as the core APIs are now context-aware.

Tian Yuchen (3):
  commit: plumb 'struct repository' into commit creation APIs
  pretty: plumb 'struct repository' into pretty-print APIs
  environment: migrate encoding configs to struct repository

 builtin/am.c          |  6 +++---
 builtin/blame.c       |  2 +-
 builtin/checkout.c    |  4 ++--
 builtin/commit-tree.c |  2 +-
 builtin/commit.c      |  8 ++++----
 builtin/history.c     |  2 +-
 builtin/log.c         |  4 ++--
 builtin/mailinfo.c    |  6 +++---
 builtin/merge.c       |  6 +++---
 builtin/rebase.c      |  2 +-
 builtin/reset.c       |  2 +-
 builtin/rev-list.c    |  4 ++--
 builtin/shortlog.c    |  4 ++--
 builtin/show-branch.c |  2 +-
 builtin/stash.c       | 12 ++++++------
 bundle.c              |  4 ++--
 commit.c              | 20 ++++++++++----------
 commit.h              |  4 ++--
 environment.c         | 19 ++++++++-----------
 environment.h         |  7 ++-----
 log-tree.c            |  6 +++---
 notes-cache.c         |  2 +-
 notes-utils.c         |  2 +-
 pretty.c              |  8 ++++----
 pretty.h              |  4 ++--
 range-diff.c          |  2 +-
 remote-curl.c         |  2 +-
 replay.c              |  4 ++--
 repository.c          |  2 ++
 repository.h          |  5 +++++
 revision.c            | 10 +++++-----
 sequencer.c           | 32 ++++++++++++++++----------------
 submodule.c           |  2 +-
 33 files changed, 101 insertions(+), 100 deletions(-)

-- 
2.43.0

