Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2C433AD
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758928132; cv=none; b=jIY0LuJSmUawHyny9Wjs7P5k2LPsxhDqw0yC5BYYrrK9BDl85Iv/g+li3ilGD0UQ07Nf+D1PrpgyofudTSSZsicN4Kb2bUD4wnSwUSvHqPvRaYDM/k1wOCRjZq3eQyjIrm8sK9RJy/x8mPzWHve/0kDVPZtfAo3oJepRChvn0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758928132; c=relaxed/simple;
	bh=kM3OeiQ1lRkCqJnPLXvSdEm7PAUwGXdmpfseisv9rJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKXK6eSiJN9XdtxLJ9JCsjwE1KIrdYAL05AhRvgL7j0KzxwY4Aj0sVenNTs7/FW/VVFkYtqIwUXghAKcJSconesQOA4jNciPJUwtvmVvk1kFGjBVnW2i40YwnUzYWg2eDasMAub/01FIhmFZXKY6RkpQk50e9Pefvy8+e86QFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUgZNUPt; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUgZNUPt"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3352018e051so2479222a91.0
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758928130; x=1759532930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtV2fwPuxhaYMQ4Q3nwjxVMgYN87JoE6v/Np9N0Lx9o=;
        b=JUgZNUPtvKJWPIgKEtEF/wofNP6ebGsj6rqGeDu+AUsLtCzUqkC6oIj0vnYMvNVOvr
         2yl2/7Sou5WqNRmlahpTUbxJyQj4xmpmLmIghyIuf0sbhUTzwXD0BTVCNhAtB0KVqaB5
         zJVWqbDsIbDl/tvLD0uCH5NAV1RWLTPoXrozGl5mxIO0aNywYg31ZbEEuWzNjwZ+6FMz
         IuyJlYWhlNyKtcYpc3LILK02wD+YssX3o4KfLR+Q14COtNiszwmOmoPj0GQziqh9zNVM
         4KzkPm6knF9tBg6slt2ORZ/fs/UnnmbwffC988EXAQrhTzPh69YNzrnK6ly4MnPlilj9
         V0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758928130; x=1759532930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtV2fwPuxhaYMQ4Q3nwjxVMgYN87JoE6v/Np9N0Lx9o=;
        b=gdLUVr+v0aEClxkL687mC7Ze1A7dzKpxh8+iulMB645wd8hJ8qviENlGfkE5l9mURX
         AmKCDMUf6PawkYFMt8yeCBI4SWojcvBHjhngyuHcM2n8JiO+51yBYHm5TglCny3Ll89b
         s4zVoGG6qR7ieO+CKBNDqV1ska47fv51c6hTJsJZrK4X+lXPJ2jhmGZkOSlg9YGr/pMe
         88D3q68AMm030fItRAwW512fLu6+qHSRLdiaR+8foxKwbg0/PqhFGubcBD7Kke+uSH2K
         XTtIOem8hM9MzJM9UCj37YDgTq3usa5KLt13qMC1Wn+E2ZZGeBPWaL9VjTXOfaYrqpMG
         d2Lw==
X-Gm-Message-State: AOJu0YyJsB+cPvUQK8y8l1OhqRbMpInEooxomH5KFJ6dXS7imLi/rPmq
	hoytvIARsAdfK7oP5ZFPapJgVRGJtQR1wtgrC+sI0LKTAblB4GM69wj6h5SupA==
X-Gm-Gg: ASbGncsTUagoz6chB5AkW/gAsXGYGuuuBOHQs59IyPPQgmRIRdRIx9Wt8fyToTq94Rg
	IlT4nxHrwuIa68Hgg9AoYPEkbsWyIps2kQ4KlOMcYiSL/BPDTmu0kzwhec2IvAJr7V+rGW2vFV4
	Lh9vtOibTMlvShtRl2VrjFEOfuLc0t6y/hagmICL/1kpnE/jvwQfmclF1BvzeRqJkHmwYqYjbQN
	9hPZmhqy2IuoN3goY4YxbKSHk8aDesjYu5NQfvI5cfqq+JVX1K6Es+0rCL5qNyXYVdb/nMGneWk
	6DGEzNdkl3NxiQ8F1q0GJJfV8Q0bxxqZmoLydv1frNXu17H+UAEXigGQhLcOmoZhOW5NS2dWtQ6
	TshGn6v8Z36YovHhiAtfSz9yL/Y409N5v9HiIrscyqEk2FwG7Gxado+cAlbLPhr/okofAUo4oRj
	mt9acEGozMdqKbi/NazV8wojw3W1h67v++krKBQBAZpy9QYSC17w==
X-Google-Smtp-Source: AGHT+IEE2Wwgp2KitUgokSHerLNt4s/VIIeysZnFo2gkZdOUuZDf2yB4KygVm4HmbYXp+xgckUqYig==
X-Received: by 2002:a17:90a:d008:b0:32e:a5c2:7f87 with SMTP id 98e67ed59e1d1-3342a2d8c17mr9052669a91.22.1758928130075;
        Fri, 26 Sep 2025 16:08:50 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:56:596:4193:db28:d218:fc74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bda71bdsm10005981a91.11.2025.09.26.16.08.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Sep 2025 16:08:49 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	ps@pks.im,
	newren@gmail.com,
	code@khaugsbakk.name,
	rybak.a.v@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johncai86@gmail.com,
	johannes.schindelin@gmx.de,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v2 0/1] replay: make atomic ref updates the default behavior
Date: Sat, 27 Sep 2025 04:38:37 +0530
Message-ID: <20250926230838.35870-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908043620.57848-1-siddharthasthana31@gmail.com>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the git-replay atomic updates series.

Based on the extensive community feedback from v1, I've completely redesigned
the approach. Instead of adding new --update-refs options, this version makes
atomic ref updates the default behavior of git replay.

Why this change makes sense:
- git replay is explicitly marked as EXPERIMENTAL with behavior changes expected
- The command is primarily used server-side where atomic transactions are crucial
- Current pipeline approach (git replay | git update-ref --stdin) creates 
  coordination complexity and lacks atomic guarantees by default
- Patrick Steinhardt noted performance issues with individual ref updates 
  in reftable backend
- Elijah Newren and Junio Hamano endorsed making the better behavior default

The new design:
    # Default: atomic ref updates (no pipeline needed)
    git replay --onto main topic1..topic2

    # Traditional behavior preserved for compatibility  
    git replay --output-commands --onto main topic1..topic2 | git update-ref --stdin

Key changes since v1:
- Made atomic ref updates the default instead of opt-in via --update-refs
- Eliminated confusing --update vs --update-refs option distinction  
- Avoided naming collision with git rebase --update-refs
- Fixed --allow-partial exit code behavior (exits 0 only if ALL updates succeed)
- Used die_for_incompatible_opt2() for consistent error reporting
- Updated documentation with proper line wrapping and consistent terminology
- Added comprehensive testing and performance considerations

This approach gives us atomic transactions by default while preserving full
backward compatibility for existing workflows that need the pipeline approach.

Thanks to Christian Couder, Patrick Steinhardt, Elijah Newren, Junio C Hamano,
Kristoffer Haugsbakk, and Andrei Rybak for the excellent feedback that led to 
this much cleaner design!

Siddharth Asthana (1):
  replay: make atomic ref updates the default behavior

 Documentation/git-replay.adoc |  76 +++++++++++++---
 builtin/replay.c              | 114 ++++++++++++++++++++---
 t/t3650-replay-basics.sh      | 166 ++++++++++++++++++++++++++++++++--
 3 files changed, 319 insertions(+), 37 deletions(-)

-- 
2.51.0

