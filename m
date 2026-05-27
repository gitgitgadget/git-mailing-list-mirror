Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2994222339
	for <git@vger.kernel.org>; Wed, 27 May 2026 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865516; cv=none; b=OxLJ7XqyWWHuf2owU44hRY0oBddiPIBV75xCYP8Kfle3SJjkKBFSOSAyFxeBm1kjptANS88NjnnR5gFpooAavNmSky9YoCIY4vMHyBGnK0sAAiVjow1MBVIjGf+lxLdfeK0ChL4TuD/yJzZGgwNNQbIESrrup5AbOJ2iyHBcuIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865516; c=relaxed/simple;
	bh=ptrBPg0n/TFYXziEU/26H6aPsmU5+yEIF4FxOwOpdS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHPrXCD0fIKyRuhman0Kmviy0vOfKdqWIWY4pqaUz0bO4axJh9xdizla8JfOYrVayx52fsyF7mS3DX83NSG6+pVF62HwXlumEUFnuMOB34d/uUjEuFJZIW/dsVqrstFZ5/UD429goGKDAPkxWrXC4Pf+E4Qq/qMWShaTPXnnH0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=DEess27A; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="DEess27A"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4903d5c67bfso30344435e9.1
        for <git@vger.kernel.org>; Wed, 27 May 2026 00:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1779865513; x=1780470313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvqKpOG0N6dsc1pDiHhFStSlWTaTsWTl7Lf2XsmO9V0=;
        b=DEess27A3K4EEOo2DKwJov6s3Oq+/taYa9TuUUiVryjTdKWdwymr8XYn8EDY3KmhJY
         JW6fl58F/YM5zqwrjyfQqMDSN8EtM+lu7Bh/B0wEm2buOwYvvT/cqMx8Dgt0LCN+k7Q1
         TpcPqS9E2hq88JwBQV7ujUUt+SF+0ZWSJjfP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779865513; x=1780470313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EvqKpOG0N6dsc1pDiHhFStSlWTaTsWTl7Lf2XsmO9V0=;
        b=SZ5/crpi3wIeyKQC1mrEDL1PjijbySRp+hMTCLJofiskfW72puEqoWem+Bo0QBz2Nl
         qYS+kagOuX9frXbHvTVwLfqhxcSM7nti82M65935W/o/TYl1+k21xFp4OOcZX9eRe0yf
         0jpl4hVk/XkodjYoiJKSKkX1dcVYpcsEx1BnpWTX1KygJHYptUmIoB1Th/I3layx3+QP
         /q0AWu+WTwVctPDd5Qr/E58jayh1SAzjEnZH09O91Tk+K7p12EvZvG7f7k1giJkNPiMe
         6x3/swxuL3ZEApo+DCFQWV4cm0Pxi6wJ0bhSiatkLCQNTWY48WYFiawDVLSDCJ7iO9p2
         QG5g==
X-Gm-Message-State: AOJu0YzLtqiANFM3KhcxAq19KvMHx3WZhT4PwwiZgd5IQ//HKSFqmxd/
	IOJzRBkQAOaePkJKmdMNNPfNG0D7j4RiUrCN5DVP/AdJ77nvkoJaF3g7X0ErZjgSWVDTGLX2u/s
	KpIPVkBY=
X-Gm-Gg: Acq92OFy9PfwrQUcl4Li1AaTVKrBzis4+6E4k3mu13eQsYMhuIqcYxwIFveyIP/DxEZ
	sifIHkUNmzJNsV+ZAkTVQaWH4qeV7Q6za62bwTAgcYKHskcktL82ekLjyu6AuhLQ8326WS5kPUz
	Ucpl/d/S7pEcNIaKrXoORipwAwUHHRFIdsaUwSMkQKmMpHevroi0/ylv1qpLC92DSsfrZMqjSIU
	lfkXbUdo3isR0KPySM5ZHV48AFivy9mA7PlrxtmrL/AuZb+ImKz+/DYrgjPwmKiX6cN3bAFUPaW
	hyB5wMoykzvN6oDUUCz8JsnaLVjkGtItiVZsbWto1fOVhYbMU66BxbxWDj+LGdR4gxxEkX0HRRL
	f1lhJyIupWsxifH3nrWpe/wF+xD8KbKhDZdQvfxiIrdq/kz8AOSV4tEwrdKJJjfUvFo0r3S7MhE
	YaUEEY6sPB+BW0Y1/fZVkeBUl2r4zTHd8ewffa4XjeL9udbMox
X-Received: by 2002:a05:600c:3b8c:b0:490:480e:266 with SMTP id 5b1f17b1804b1-490480e02eemr385641965e9.26.1779865513441;
        Wed, 27 May 2026 00:05:13 -0700 (PDT)
Received: from krka-x1c.spotify.net ([95.202.8.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b1a28sm3923197f8f.26.2026.05.27.00.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:05:12 -0700 (PDT)
From: Kristofer Karlsson <krka@spotify.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: limiting git branch --contains
Date: Wed, 27 May 2026 09:05:09 +0200
Message-ID: <20260527070510.3510836-1-krka@spotify.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20230324191009.GA536967@coredump.intra.peff.net>
References: <20230324191009.GA536967@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

I'm reviving this old thread because I believe the discussion here
is still relevant and the patch Peff included is good. I think I
accidentally created the exact same patch before I found this thread.

I work on a large repo (millions of commits, ~8000 remote tracking
branches) where "git for-each-ref --contains <commit> refs/remotes/"
was taking 4+ seconds even with a commit-graph, and much worse for
deeper commits. I started investigating and building a more complex
batched solution before I realized that the cached DFS algorithm
(contains_tag_algo) already exists and does exactly what's needed --
it just wasn't enabled for branches.

With generation numbers (commit-graph), the cached algorithm is
strictly at least as good as the uncached one. Both have the same
walk floor -- the generation cutoff in contains_tag_algo is equivalent
to the STALE boundary in paint_down_to_common. The cache then provides
a pure win: O(total unique commits) instead of O(N * commits per ref).

In my benchmarks, the improvement is significant and scales with the
number of refs and the depth of the target commit:

git.git (69K commits, 5826 tags) with commit-graph:

  Scenario              Master    Cached    Speedup
  Deep (v2.30.0)        1.08s     292ms     3.7x
  Recent (HEAD~100)     338ms     240ms     1.4x
  Orphan (unreachable)  271ms     241ms     1.1x

Large monorepo with commit-graph:

  Scenario              Master    Cached    Speedup
  HEAD~10000            511ms     239ms     2.1x
  HEAD~50000            4.14s     272ms     15x
  Orphan (unreachable)  4.13s     252ms     16x

I also tested with varying ref counts on git.git. The cached
algorithm is faster or tied in every scenario I tested -- the
crossover point is around 3-6 refs, below which both complete in
single-digit milliseconds.

Without commit-graph, the difference is even more dramatic (41-54x
on git.git with 5826 tags), though the theoretical argument is less
clean: without generation numbers, contains_tag_algo has no walk
floor and may traverse to root commits for unreachable targets.
In practice the cache still wins for N > 1, but I don't have a
proof that covers all possible DAG shapes. I think we should start
by optimizing it for the case where we have generation numbers,
and maybe keep exploring if there are any meaningful scenarios
without generation numbers where it would actually be a regression.

To reproduce the benchmarks:

  # Setup
  ORPHAN=$(git commit-tree HEAD^{tree} -m "unreachable")
  git commit-graph write --reachable

  # git.git with 5826 tags
  git for-each-ref --contains v2.30.0 refs/tags/

  # Large repo with remote refs
  git for-each-ref --contains HEAD~50000 refs/remotes/

-- Kristofer

