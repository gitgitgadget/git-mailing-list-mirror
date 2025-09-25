Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C412B14A0B5
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804867; cv=pass; b=Gy4Yd91oPjnmxRMQu35hT9JoP1eNQNbg3rgjAHw+0DTmlLzf8VnXlse7C1/bPloZswhRFFlwkJs5S30wczV2pqXyzwvV+/145JGgtMYExF8s8jMEhUDsZJIkd+/0YU5U90NezT7QPNoBAQwCtcXTnE99xwoP5vu+pB5RULJ18Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804867; c=relaxed/simple;
	bh=YldKuwj+EyXoZAiJ5++VzYqe+pKKr1enOnPmDSIq2JI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S5wXgu5C8fGJ9P7x6pIYiPzgEvzVxHmAyJQSINdRNHWQsMXClLrbiTIUxrUVbJYC1DDqdz8ZbXnL7sxH202eVUUlvRHSgIuBgPeFb1/rIew3IdcDk97Gr9ErnfifRU0a/Xg+QfWpeDnoVz8ANEuJJrNl7n4g7Gt7GE9FSXrQ6DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ItdeQj3X; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ItdeQj3X"
ARC-Seal: i=1; a=rsa-sha256; t=1758804855; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PMr9eyeeXF0L5J7OtXrIWrUFkJmjD9WKJK3VapbuYE9pWNpQObI+Ai2LZ2nOYd0CZ8sHj41K7jMfSwwgoyyuSauCNMgql3sxXn8YvZxPpmpG7zDfAURUAEZ66GpJKeXj7gc199x6V06mXTrPb8Xp71RddM8cXnaKDDz2sB2TaUM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758804855; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=G3ewBVGl6AehKuPfXnB7N4gaz54xvRblMlGRg9b3GAE=; 
	b=lc2fZ3Ee4Q36sTxrUiyREojqliRPMVWZvlT5fZgdrhhw5nDH8TbeHIbBJ5RWjhDIJZBuB53H8U0UfFnp7vD6F6GAjfViUIkBbuPwJST0fdL3DfzNrXtcYtJUJUILVaVIJKPorG7JtlWG2kxPnfBIf8+bp4h/BKp2fsqG5kpMLro=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758804855;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=G3ewBVGl6AehKuPfXnB7N4gaz54xvRblMlGRg9b3GAE=;
	b=ItdeQj3XrSbpVn5a/Qv6NQ5pkAJyb9cqhzWoHDCBA3fzIa11B7utHOLm2qZNFzch
	XlyOO6uJmGVPKsqoBHUlktBnEV6zzIMWhmS5fLRvAb0z7dp1tLAQ6St0Zye7eGDfVcR
	qkLywFkqgF37pNaP2XO8gp7h8HE1UGcr1o46U1h4=
Received: by mx.zohomail.com with SMTPS id 1758804853260889.5162192225828;
	Thu, 25 Sep 2025 05:54:13 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 00/10] Convert remaining hooks to hook.h
Date: Thu, 25 Sep 2025 15:53:43 +0300
Message-ID: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello everyone,

This is a continuation of Emily and Aevar's work to convert remaining hooks
to the hook.h interface, by adding and using two new run-command/hook APIs:
 * feeding hook stdin via a callback
 * capturing server-side collated outputs

I've tried to keep the implementations as simple as possible and avoid any
unnecessary copying by feeding the data directly to the hook stdin fds and
even batching the writes of pre/post-receive so we achieve similar perf/data/
syscall efficiency as we had before the callback conversion.

As suggested by Aevar [1], I've removed the string_list API, the extra copies
and the $'\n' assumptions on the data, however I did not go the full zero-copy
route with mmap-ing because I think that will break backwards compatbility. We
could explore that in a future series as an efficientization of the current IPC,
this patch series basically aims for parity with the existing implementation.

This series also unblocks config-based hooks and hooks parallelization which will
follow up in a separate series.

The patch series is based on the master branch, I've pushed it to github [2] and
it also passes CI runs. [3]. Also merged and tested against next with no conflicts.

1: https://lore.kernel.org/git/230209.86y1p7y4fa.gmgdl@evledraar.gmail.com/
2: https://github.com/10ne1/git/tree/dev/aratiu/hooks-conversion-v1
3: https://github.com/10ne1/git/actions/runs/18006589297

Big warm thank you,
Adrian

Adrian Ratiu (1):
  reference-transaction: use hook.h to run hooks

Emily Shaffer (9):
  run-command: add stdin callback for parallelization
  hook: provide stdin via callback
  hook: convert 'post-rewrite' hook in sequencer.c to hook.h
  transport: convert pre-push hook to hook.h
  run-command: allow capturing of collated output
  hooks: allow callers to capture output
  receive-pack: convert 'update' hook to hook.h
  post-update: use hook.h library
  receive-pack: convert receive hooks to hook.h

 builtin/fetch.c             |   2 +-
 builtin/receive-pack.c      | 310 +++++++++++++++++++-----------------
 builtin/submodule--helper.c |   2 +-
 hook.c                      |  11 +-
 hook.h                      |  30 ++++
 refs.c                      |  61 ++++---
 run-command.c               | 115 +++++++++++--
 run-command.h               |  44 ++++-
 sequencer.c                 |  62 +++++---
 submodule.c                 |   2 +-
 t/helper/test-run-command.c |  67 +++++++-
 t/t0061-run-command.sh      |  37 +++++
 transport.c                 |  79 ++++-----
 13 files changed, 547 insertions(+), 275 deletions(-)

-- 
2.49.1

