Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56188334C31
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346360; cv=none; b=iVWmPxXxK60grFf3O5gdlHqiSC1n1hob5C3JzmdUb0b0ouQKFNscacVrqaxqeQlF3VctQ4Bm3imK5soasUoHWXlzWUzSsdob94AlFVUpG50o5esK390wrYYEmJBs+SaFnPfBeldXjgP6YwIaFPke3aHvpjBBowDoSkLHkIvrdxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346360; c=relaxed/simple;
	bh=p6OiSBd1nc46Sjk9fvnsXes+gFr5bMKQoVPegQvto/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pv76OJwmV3X2uO0xsxvlqeHTU6ZYS14tYs5tqFXTY703Rk/7ftwNNSZn2p3waGAubTPsEgnwbvk2XExElbGBUyjCD83ZBJfuYVRdVwP3ZUE/mrKWVrafo+awOc6bUaXVJsgEgCap7OUUCzXa13M8bWGHfhnwWiMRm8NvBfrDaDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsWZyp28; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsWZyp28"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-82491fbf02cso2573655b3a.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 08:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771346358; x=1771951158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6OiSBd1nc46Sjk9fvnsXes+gFr5bMKQoVPegQvto/E=;
        b=TsWZyp28wu+NYniblQU2iXVOyeCl2ph/7YOOAs6ANrmXUBeHquQVEk73uwPgbqhMGY
         rZi4NwOlx1x3n0LTmP7q69Z4cBwlhtjindmP3xB7pTuXcj98bFE69koazgPAgUMX2Smc
         uhPxxfC30kx53iYBdHgCHE1Bys6FAqDhY7LYwoRFkwAuVF5ktYjFbzQpld0FXyKDUw4Z
         8cOyBumqiAfPt6juhV/6vTE5q+FurazMmeV4fNwrrkerU4RIqQFRP/cRcACY/xXew02C
         NTCbnTj0U8I1UIil47tnhwp5uaTKmtM7EgPh8tMgMxXHDDyUo+ObsRG68sRoxukMZbFF
         9VYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771346358; x=1771951158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p6OiSBd1nc46Sjk9fvnsXes+gFr5bMKQoVPegQvto/E=;
        b=VT/+iiPx5MGu/bRPujJdxYnyV5TMlTWwEDYfBeTO74eKcsIGADiig4phHGbZRG/Q5v
         c4kX+fyOi/x1AZOggauV4h4oE3VB9gBfdQGZ94V0jhTC5u+mTJ4Ks71Q4QmQ+0ntmEcd
         Zq4DkrI/CNcQx5lE+Bvluv4s8jl1t1xv+VM2ozJq4jILZ80k7c5Nmz3PUXpOodBCU8Be
         I10pJa3zzn1BF2Dc8/ZBEy9fsK0rgvoQQxyzucuQDTys+cNVAIBt9Pel1cxOea2THruy
         OUNlWG+Qp3WHSS8Fh2Y1RG0RtcWUTjQHvohdD1o3/LUfhfijklzjv2a1IpuK0o7pnE9b
         dGdg==
X-Gm-Message-State: AOJu0YxFeNadYlVpt9k2/MomuJEbMHZWE4O+d7oVi7tJgF1BPizBhxHi
	fPVgZ3Bzs1EJHqrm3cYznoZnMcWBoRbP1RbM5d8qqrttg/BnvzEz4aWXXvveCTdpeA1gwA==
X-Gm-Gg: AZuq6aJ8D7AVyrSXGc/Lq2fBt8yRexHFFpyR4D0+lgZFSCXaHRe5xZdx+sz3kMA0TU+
	du5ciuJrEd4+UuuhDsDg45t3yTZQ5lxxVGm1AZcxlty25cFSGaGW3kEwfXFGZQ0m6SZNL7oAYgg
	8qPnEP4egjSQVizaa5VvdNTCsEdeArPBAB5x/TTscjtSBwDSuEj19CEY45DnGkY5rqneAwG2hrk
	xAej2wYPNTXX2tnIQftPY5GpoyqbUTp25JWxsP37flV57KA4g3jw6U01/p0uyzDCHU6TWNQC06l
	VFvXpS3il0ordx/jPlzitG//HPYGnVJHSJGa0egIUg5eW+kBXbMYqYGGfLCnFvJBGlhwNO2+Ajj
	0aGT520xwUdvtUg78XPQIny/VItoXymtP4+0urGrK/p7kCu5b0r47GZDnNS8FBgSwGE+bNY1SIv
	Pr3dVwoXm+jCzH/b/P4jfLWkpMERmv4LIi5H02zZpLyqbOxM4rAeeVm8oZx34IP0gqDbCq
X-Received: by 2002:a05:6a20:734c:b0:392:e5eb:f0f with SMTP id adf61e73a8af0-39483aa450dmr10163325637.68.1771346358425;
        Tue, 17 Feb 2026 08:39:18 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:a392:d36:fa44:db83])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2a6c3sm13537354b3a.5.2026.02.17.08.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 08:39:18 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	karthik.188@gmail.com
Subject: Re: [PATCH 1/2] wt-status: avoid passing NULL worktree
Date: Tue, 17 Feb 2026 22:08:59 +0530
Message-ID: <20260217163909.55094-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <0619603c-278c-42e3-a186-a674a124a451@gmail.com>
References: <0619603c-278c-42e3-a186-a674a124a451@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 17/02/2026 10:18, Shreyansh Paliwal wrote:
> >
> > I wanted to just check for my understanding: the NULL usage of worktree in
> > get_worktree_git_dir() caller, repo_git_pathv() callers and inside function
> > add_reflogs_to_pending() is intentionally left unchanged for now,
> > and is meant for a follow-up once this gets gets finalized.
> > or it is out of scope wrt this cleanup?
>
> I left those out as they're not needed for cleaning up wt-status.c. They
> can be cleaned up separately if you're still interesting in working on
> that. It would certainly be worth removing "the_repository" from
> get_worktree_git_dir(). The others are not quite so bad as they don't
> use "the_repository".

Thanks, that makes sense.
I will send a patch for get_worktree_git_dir() sometime later.

Best,
Shreyansh
