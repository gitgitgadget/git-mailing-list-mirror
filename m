Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C46372B3E
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238732; cv=none; b=hRACzdIdI0OlEhq0z9pCLOth+9KI18env2cv0GBb/PQHDYjhszQFiGCmfncVxP1StJ9o8UY/fMY9FMzjvMMpyHyoFkEh2xsTOqkp2VzjZIG6OeHteNAw3xuJZxAjh1Ic8//Lo8AN/xR73CJCCJ89YzebxmktaEjHwx2zggf+ZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238732; c=relaxed/simple;
	bh=Q8kTBXQIbrEA9rUatT1/TE52Bt0TDK5eaUifu1k3FOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y57OGgnZ/uHEoY8vwUiDN9Jeiv4yjAX+5VqHxoJs90wbGxyPW7tFPqOiNA7ofZV0hWbeFiok8shAcyiQcWH5IcPUskwrCiwNpYvui8ZFwNgwgbCGpaLTw+83+W9i8TkiDX/oSb3F+tXSl8ldiatmR/PxzheT1ZCB7Z70Vb7HIBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nY0qHBJa; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY0qHBJa"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd75abd09dso565451885a.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773238729; x=1773843529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8kTBXQIbrEA9rUatT1/TE52Bt0TDK5eaUifu1k3FOc=;
        b=nY0qHBJaGkeCFnthoX7OMKbj2O7LZ76TuMSErGmGPyBJA9lV4xrAlHkWZY+3ynUaiH
         d8HY1w1hSzjYsNnA/yajBNO2KzTkz40j24uulwPtb8ZC0c95nFswT4eKWaVtb+lRax1j
         LAEw8KClPzlbxfNohXgta3ejqifJOl6K3dfIG7rmDIZtQf+oqFdBcS5uIFwepNx4QStk
         Zj79wgRtle4gJEQuFn5GdMnFGLvAnhzrRFJ537apKJNtcda1yK7naSKLti+8aipBxhXX
         OhFLdqcmib1dJVANW0Bb+LpJwOdm+3PsC4qurE9WDSfAToq8PjhVms8jrXFSc011vDKI
         2Cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238729; x=1773843529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8kTBXQIbrEA9rUatT1/TE52Bt0TDK5eaUifu1k3FOc=;
        b=NajpwbhEKsHOj5Ba5eAWRA9GE6yaub6qtC3ijiHfZSxWCFCxXFwEna/AfKQPyneNJY
         jvrrlECSbyF09u1lDBHBJXF8ini4WyJp+oYJCfiBvefOWuux8rHhKFkAxKYsiNdYr0TJ
         pgWEgj2g92Ixjh2YB/QhmfKNYgY893eUEh63Qsw2++zTTDOC2yqhzLudn9S3kQFrMtKm
         uweaZwVvW+STln3gNjfpSR3X4lCmlKz/lD5eSi4X/rHoRLd0Cbigoh66kl2y2F5jMFUR
         UWDPvhOuSUNA7OTdWwnJicXBGKZeKn4kqcRHoheXa77lSiawaegYcoGT2A7v4yFKdTyd
         VnQA==
X-Gm-Message-State: AOJu0YxYnyX9Jy7LNTzzpVPqYEw2ZhkuofSNqxs5qYSkAvG0sTNOhdO3
	KWRVq9dXMZMHvHnhk3MGQ3STHlxWdj9xok2wWOp8xr14T9ldcwmdPq4EkBDT3w==
X-Gm-Gg: ATEYQzxBT2eKHXuhta+1Tbtcj4b8cgfWmWwvbAKVqJlXLC9bRNLQrtu+1ukFX2Q3lYl
	g4ZmY5gFnZZ+aqqbNYNm1zQUk/4tGbw2tMgeuQgxIOqlLKYokhcAa/xXjr8UYR9uuP7kVThwSHr
	DIVEPg5f20czMaqyTtZWZf3xESVCvtjNHl2xnw6JHZjcbV0mCbRx4KBk6927uequtn3y4LGAPwu
	yq8LUV+QuVwF38bjo2OVpxfEtfm5hPAeOLOtFvAVSGJ0zvcQCvXYcoR1/5NPfs3m4dTTcpkca0e
	X9CtrASLYriNknetQIjMvNQpvhSR/jrLu8i0LofY37Z+w/zxO6X6+HMp9MLsY27PR4TnMV9RLiQ
	p0GaLmWG67mtS1tRoTbp2rELxmiPjaQ1d/YX6bSi5lPX2ScgHqCZ3f6LELoCWT0DO3Ity972HMm
	X+ou60liu/Vi+fzan+yy+E4McfS5N8IsNPzS/v/f3ellR8JIfnSa/JlBqD8kkRGWRpYj+mkHSlt
	0WvHl3GSQ==
X-Received: by 2002:a05:620a:2985:b0:8cd:8f66:c9c4 with SMTP id af79cd13be357-8cda1a7c96emr355656985a.74.1773238729109;
        Wed, 11 Mar 2026 07:18:49 -0700 (PDT)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda213cba5sm138181585a.37.2026.03.11.07.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 07:18:48 -0700 (PDT)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitgitgadget@gmail.com,
	christian.couder@gmail.com,
	hanxin.hx@bytedance.com
Subject: Re: [PATCH v2] promisor-remote: prevent lazy-fetch recursion in child fetch
Date: Wed, 11 Mar 2026 08:18:46 -0600
Message-ID: <20260311141846.12315-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <abFJhFhHLhS4qdrM@pks.im>
References: <abFJhFhHLhS4qdrM@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> Is this a theoretical concern or a practical one? I would expect that
> backfill fetches never cause the server side to send a pack with
> REF_DELTA objects to nonexistent objects. And if they did they are
> broken.

Practical. We hit this at Anthropic: 276 GB of promisor packs written
by `git maintenance --task=prefetch` in 90 minutes against a ~10 GB
monorepo with ~61K stale prefetch refs pointing at GC'd commits.

> Exactly, this here matches my understanding. The backfill fetches don't
> perform negotiation, so we shouldn't ever see a thin pack in the first
> place. What I don't yet understand is your comment about the depth-2
> fetch -- when would we ever do that?

The code path already exists and is tested: t5616 line 832 ("tolerate
server sending REF_DELTA against missing promisor objects") creates
exactly this scenario. index-pack's fix_unresolved_deltas() calls
promisor_remote_get_direct() when it encounters a REF_DELTA against a
missing base (builtin/index-pack.c:1508). That's the depth-2 fetch.

With noop negotiation a well-behaved server shouldn't send REF_DELTA
against objects the client doesn't have. But partial clones with
blob:none mean the client is missing most blobs, and if the server
sends a thin pack deltified against one of those filtered-out blobs,
index-pack will try to fetch the base.

> I dunno, I think it's quite different overall. In the mentioned commit
> we protect against a stale commit-graph, which is something that is
> quite plausible to happen on the client side. But here we protect us
> against a remote side that sends a packfile that violates specs, as far
> as I understand.

Fair point. The commit-graph case is purely client-side corruption,
while this requires a misbehaving server. The bug shape is the same
(unbounded recursion through fetch_objects()) but the trigger is
different. I'll drop the comparison in the next version.

> Hm. Can we craft a test that shows us the resulting failure in practice?
> Testing for the environment variable feels like a bad proxy to me, as
> I'd rather want to learn how Git would fail now.

Good point. Reworked the test in v3. It now injects a thin pack
containing a REF_DELTA against a missing base via HTTP (using the
replace_packfile pattern from t5616). This triggers the actual
recursion path: index-pack encounters the missing base, calls
promisor_remote_get_direct(), which hits the GIT_NO_LAZY_FETCH=1
guard and fails with "lazy fetching disabled". Without the fix,
the depth-2 fetch would proceed and potentially recurse.

> Okay, so this seems to be an issue that can be hit in the wild. But I
> have to wonder whether this really is a bug on the client-side, or
> whether this is a bug that actually sits on your server. So ultimately:
> why does the server send REF_DELTA objects in the first place? Is it
> using git-upload-pack(1), or is it using a different implementation of
> Git to serve data?

The server is GitHub. I did a blob:none partial clone and after some
further git operations ended up in this state. I don't have
server-side data on why it sent REF_DELTAs against missing bases.

> Note that I'm not arguing that we shouldn't have protection on the
> client, too. But I'd first like to understand whether there is a bug
> lurking somewhere that causes us to send invalid packfiles.

Agreed, there may well be a server-side bug here. Regardless, the
client should fail fast rather than consume unbounded resources.
