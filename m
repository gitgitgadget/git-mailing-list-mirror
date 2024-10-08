Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9108157465
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375243; cv=none; b=XZYSDgK8ztSPOGBq2l3JwRFZgKDjAclZ155zOqaUQOCTC7k8qd8JKvaErE5gOZNKB7ekNeV76sx2NnivbjuhMG0LGRNmvibCfnqsajkmNL3Wx2lgQene/Y2DlklaZzJ+KFUrraQAAVOe85YIbc4Yo7ROfwJKV+4n9c3Z45SPyvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375243; c=relaxed/simple;
	bh=L5w7MauZQJ6KPZBA4xL1drJ/Be30IIhOB8flcifjrg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TatVgkN0C4hQNiE35sIa9J1/s9M2YdOIqY1K8eyVOs9MZxCtWurmuKgPJKrumGIQu0s4Fgk2FTUohNwiNwCzxd9pUEjK4SI8f3+UwNaVyYVx0sbpnEnS3F02S8D8/a8jfxu7Onu7M4JDHTulm5/i2PddPMEwbAz1nAcvi8ZTDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=coYkc17K; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="coYkc17K"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e09f67bc39so4414757a91.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 01:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728375240; x=1728980040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+v8WysQDOK8cBv9dedGiChfgNd3Py9p05Brxa27pbQ=;
        b=coYkc17KRsPobHF+JgP5+oRuBUSvLKmjzCSMBJYXyMJ6uvrofwA1a32/TOJGtfXyjG
         1Ug7jDXbLN5h/9j84tJ6ga4yK4sRmoQNLQhVh3SBrdG8Me5X9pXRSU/P6zX7tM7KrJ5Y
         HqQ22fA+ci861Xx8t5WfJg8a4tzkyhmVPzshNvVtCSgovPJHSMICcNqcTFq9HKis79xD
         7332ppk5qaV5iVxWt1pNCG0vUXIhViK/hHLfEAXpHnwrIIOxCF/avze8WCbg/+HIaW2m
         TJ2Hq0CAAge+9DcGorAk3I2w6TD9g96ZjR1OuNBqbVUDy4wVhRUbMs65ZPJVHStH6EQ/
         DwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728375240; x=1728980040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+v8WysQDOK8cBv9dedGiChfgNd3Py9p05Brxa27pbQ=;
        b=HD1KgTxCFQ7w36ymI/rsrrVn4igb5CPZUFdprvIv+1Fg6ozRZt0lapsvCU8HEV1rrJ
         B2fAoDkmf7uLh6k+BXQPf7VE+MaQHVT2ZUbdDv5MCHPOqx5uuwFqF7+FKVbXVlIqPmIv
         mFff3JIFV4VPBb9aejkud3o8r9YJQnv5+AxQhuyCsGvkprE5OdrhP29LgOBH+IrU5Clp
         +eJ7IVa6QH8jOqwzEjtKBKzP/FSzQ3cDNFukXSrn6rF+EgKpufWzLDPau+FRvU8qoHcD
         2MEB9358oVLuHpnP86CUM/hel+nanJ5MKgCnjNyF0lx3eVEXdkLj/iorPzCg+0W6WkXl
         /n6g==
X-Gm-Message-State: AOJu0YwzzliqDLR2rffJexwKEseZNxDp8TPj//FWuBja9PY8OaCDC1sD
	8CBJWXkgSWjMUuK3oC1Q+emWX1jDtrXdhOtR4dtfkUCj6l9T2Re+Wnm3FhpFGbk4pxWrwy8onyO
	P
X-Google-Smtp-Source: AGHT+IEZC3REbhgYkmKpRpzCqcu6pnBfYoMbKKp/5FqbH12L3Yu8xGaK/z8JjRDk1BA35tMhaVTgEg==
X-Received: by 2002:a17:90b:17c4:b0:2e0:9d3e:bc2a with SMTP id 98e67ed59e1d1-2e1e636f96fmr16288675a91.32.1728375240397;
        Tue, 08 Oct 2024 01:14:00 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e83ca28fsm8739647a91.7.2024.10.08.01.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:13:59 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	sokcevic@google.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v2 0/3] repack: pack everything into promisor packfile in partial repos
Date: Tue,  8 Oct 2024 16:13:47 +0800
Message-ID: <20241008081350.8950-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240802073143.56731-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested by Jonathan[1], there are number of ways to fix this issue.
We have already explored some of them in this thread, and so far none of them
is satisfiable. Calvin and I tried to address the problem from fetch-pack side
and rev-list side. But the fix either consumes too much CPU power or results
in inefficient bandwidth use.

So let's attack the problem from repack side. The goal is to prevent repack
from discarding local objects, previously it is done by carefully
separating promisor objects and normal objects in rev-list.
The implementation is flawed and no solution have been found so far.
Instead, we can get ride of rev-list and just pack everything into promisor
files. This way, no objects would be lost.

By using 'repack everything', repacking requires less work and we are not
using more bandwidth.

Packing local objects into promisor packfiles means that it is no longer
possible to detect if an object is missing due to repository corruption
or because we need to fetch it from a promisor remote.

Promisor objects packing does not benefiting from the history and
path based delta calculation, and GC does not remove unreachable promisor
objects. By packing locally created normal objects into promisor packfile,
normal objects are converted into promisor objects. However, in partial cloned
repos, the number of locally created objects are small compared to promisor
objects. The impact should be negligible.

[1] https://lore.kernel.org/git/20240813004508.2768102-1-jonathantanmy@google.com/

*** Changes since v1 ***
Added tradeoffs in cover letter.
Fixed some partial clone test cases.
Updated partial clone documentation.

Han Young (3):
  repack: pack everything into packfile
  t0410: adapt tests to repack changes
  partial-clone: update doc

 Documentation/technical/partial-clone.txt |  16 +-
 builtin/repack.c                          | 257 ++++++++++++----------
 t/t0410-partial-clone.sh                  |  68 +-----
 t/t5616-partial-clone.sh                  |   9 +-
 4 files changed, 157 insertions(+), 193 deletions(-)

-- 
2.46.0

