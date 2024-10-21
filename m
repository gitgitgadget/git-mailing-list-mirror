Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435871FB3D7
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549791; cv=none; b=NGDj2WUYo4s08qBvmXqqkCD8RHRXpC3J2R9LPF0kep0D2Ms0TvXoLfYHjAjV7PBD3oWkMXq/8S4r7uhESRAD67GNrl725BUude7YRCAZYl3e4jx8nNdHT9VsDc7onFt6iQOIWzvzwVxMwkP60WmPu9TSw7zEHqNE8z3oQ1wRWjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549791; c=relaxed/simple;
	bh=3SiSod+vIZw54MtPGnjUAMR0zp2+zCQpM/3dRtHUQe8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q7TUfGjx8d4d+8Qxlfc81tRQKKKGxBmt9WQIf2pJjBop36+8yIVIC6C+lWvb8Sa1dfXNAP6DEZI1o4KXuq/JrT7pkqiBVT/Cr6ea8LwC0pjlyMiTjn7jQhKIVaUCFyJgeR2gOL2fs0DUnOlT4W8TAzYojBc+8RQMqjFtw9JY120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UnffoDL9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UnffoDL9"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e000d68bb1so64703227b3.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729549789; x=1730154589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RDGmC8so2qKIsPdQITVvm5z+OA1sealTd6D1TTUkqR4=;
        b=UnffoDL9WM+hvvBZvQI3tIFsIk3Dv1ghsSWRAo5UbpirVcJEDxeHYnFZMpZJ0eYegN
         /HwJcCZmEBOQ3ymTfGlB3er6phH+Vd2V2bQCy5xHt08OYaJ1tFU2z/YQW2cP8Dj0zYpv
         SxHyCrUUTtC3+PQgJ6Z7t+rGPBaUXkBEh1TfWa/JT+moRQhdFJqWZRPXisTv1WzPlMXf
         uSSMLpR/ukbti9X35QKISow7vsOxgTmzEHhFBOl9xxorrqUvxgbLe9v+YcOmKQHxydHR
         IcuTKF22s6BMoNCO+7vSW3kmILR4udtKgkxKutYqV2pVEg0VFY5lqO2tZ8arAGk0YWYK
         GARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729549789; x=1730154589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDGmC8so2qKIsPdQITVvm5z+OA1sealTd6D1TTUkqR4=;
        b=v9pvOkhADch9q9tiX9taekLO2PxeuggDjR/XgiaM/NodVpbsboQfYTk43+2luNqnwx
         zfOXqPwl1yC9Q6eoEnUVDWafbiGfcqZecF8aFJVecacfnr+7WfKxZeuhQnlMhtRgLPc0
         MVSXrSQntzfZ5QDXV2yw4jndmbXAJlD14LDm/TnzIronz255lAH/nmmKQKkkSfGrMfOB
         KkMMbBR2BQZ7dNrAilK8LMCARtNpgbwQVqADhRTgaEuwoRFKfkg+kEPT1Hokz75lWFZm
         F65P62GKNJkWqXgxkvC2/McCW31rkt7tA2wqgmqxov+9rYp0J96jZ5NA8D5EYervKuAF
         CN7A==
X-Gm-Message-State: AOJu0YwNXtUebbTWJPhTGqT0D6CFIo0Ih/jnIxib1yFdHHvZ5h4NUg1P
	DIs7fnmnbEtEXfqDA7PZvSWSq68RfljjP5mvgKPXnNtEZMGvXiPbJve4I9Z0q/n3WhJsixfK5y8
	2dV/sHII9BeLAZRDwsKVkwaFYamtGTv1BKKVJ7Txeq51XVp0vFeXjXc0tFg790LZr9Rl26bKVj0
	mieDyUD38PgZ/vfnGS6Z1eJbgnSFM43qshbRcDMUqrwE/ldIP8W1Zs4RYOPTmVoe8l5g==
X-Google-Smtp-Source: AGHT+IHtx2vS31PxcOvmZ9x8/5nWeD9bWeNrStW3tNw6QvoxTBZYZUCKoV2Q1/SNTbAVY9V1pO3Zjo+upq42tKNtAXOF
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:5f48:7349:7c03:e18a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:670f:b0:6e2:c1c7:ec27 with
 SMTP id 00721157ae682-6e7d46a259cmr301547b3.1.1729549789195; Mon, 21 Oct 2024
 15:29:49 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:29:42 -0700
In-Reply-To: <20241014032546.68427-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014032546.68427-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <cover.1729549127.git.jonathantanmy@google.com>
Subject: [WIP 0/3] Repack on fetch
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, hanyang.tony@bytedance.com
Content-Type: text/plain; charset="UTF-8"

I think that ultimately we want something like repack on fetch, so I
made some effort to implement it. There were some details that needed
to be ironed out, but here's a WIP of the repack-on-fetch solution. In
particular, note that we do not need to create the expensive set used by
is_promisor_object().

As you can see from the patches, some polishing still needs to be
done, but I'm sending them out now to check if other people have
opinions about the solution. In particular, Han Young reported that an
alternative solution (repack on GC) takes too long [1], so I would be
interested to see if the time taken by this solution is good enough for
Han Young's use case.

[1] https://lore.kernel.org/git/CAG1j3zHJVrpK5JZtUXFwkZgWY1-CxqET+ygpaMqo5aM-KeWaxg@mail.gmail.com/

Jonathan Tan (3):
  move variable
  pack-objects
  record local links and call pack-objects

 builtin/index-pack.c     | 116 ++++++++++++++++++++++++++++++++++++++-
 builtin/pack-objects.c   |  31 ++++++++++-
 t/t0410-partial-clone.sh |  11 ++--
 t/t5300-pack-object.sh   |   8 +--
 t/t5616-partial-clone.sh |  30 ++++++++++
 5 files changed, 183 insertions(+), 13 deletions(-)

-- 
2.47.0.105.g07ac214952-goog

