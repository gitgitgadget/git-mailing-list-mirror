Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33343390224
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116917; cv=none; b=uJxWhXLjd67PKtJauTJxHOG+cs6BiNLfuivAaKBCzWNjB0yFLaPOPclS8qInNlEXHR9lJg+iDg78aR0HmMDGWCgdMXN2VBHbkBSc0OB+ObBzI/1GO5bCVroJGKvY9qleRv0ZTuY8trt6ao+FSVjyX+KCT7SNeQeYeoa03xJH4hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116917; c=relaxed/simple;
	bh=9KgTzD/QMLdrncSD2XGRKK47aOjN12m5aiQkWgpiCNk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Ef26wGNv6KkE8IzpAc+MZmL303IpB47zSVQHBHMOnohsZ9U+OTtqeK+7UA1Kja2MnDonD42b8NeBEOwAoVgeg/i2nTUSh6m1IXnPNmZ3E6WRPNilTYyRA/7dE5n6PgvSZfpYEtFzZo4M7OM7yQVqrJcSuqD6aKpeoUBGIvYahrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rT3pJCUl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MIZdNaN/; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rT3pJCUl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MIZdNaN/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F2951D000EC;
	Mon, 22 Jun 2026 04:28:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 22 Jun 2026 04:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782116909;
	 x=1782203309; bh=dT8LYHq6mD/uv8Z1dTOXqbwApncOOsqKrCDcDUhbbzA=; b=
	rT3pJCUlPPh9q800yNCN/A1P78gKB4KsgdOVuJUW+956At6ORgPtEkoXo29luKsI
	ZHvouq2wsD3Axml6p586Wg8P3ycqm+ZWLiB6zKKOn2xT/pyxnNKotF2DUknWWBwe
	5AB5oIm3zZkp1+wdof/bBPAQvkKfkKBBScUbN8goo8zms8ubFVWjWJgevEJMq2uT
	70dHQKXLMRMuhKn68eQc7OtfzvezxVogR7R40zuORErvubWGreuc4fafULfysDGS
	dbJwDiEgIZiTTC4NkdIVmRZWg4+ELKROah+lH0goB6EIVZabMyb2knQUwO7pL9PY
	Waai1Vhq9QOuEGOyY4zI8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782116909; x=
	1782203309; bh=dT8LYHq6mD/uv8Z1dTOXqbwApncOOsqKrCDcDUhbbzA=; b=M
	IZdNaN/PBJaU+QPQj2y78+zrFsNiPy3zvfwjlB0IJJbr0o7mX8lYeBCzq+eNySff
	tNceOzGfrfoMmSU3h6pL4c1pLTU/a6xxanG5RrrIDzGi6+9lAdwmS5qY7HE6K3Ax
	XrgncMXZyLTBJea4J7v6sOaMJwd8hwTKzr84eb4p1gVIyqy/xYQBz4lfe/7w63gn
	HqnzY68bfz7wRHLzHwzjuscM4yR8whHvSyIvdsV6njP3TayidpwdP6SALQC0bAYl
	Ojjr1voJEGwTSJArANkLsGsFd4+EbinGms6ACImUrcTICmi+OYrCTjNb4YGI35pA
	aIEfnU2FbqGJTOkJKuHUw==
X-ME-Sender: <xms:LfI4ajBY1OXiWldU5PrZnxJ9xcRx6p9aAGbXunovlWyy6pz3TQR7iQ>
    <xme:LfI4aghtE_IRAFASBS_YEpFKM9KOZtw9O1Tk8NeArZdoZPH4u4ezHo9h8o0mEXC4U
    AWv4vnY4tFPTXqgrscGaE6_4oSZ4KIXq2N-MJ31x8mbrufj5qo7jg>
X-ME-Received: <xmr:LfI4ajmqhGcsYaVF_7FC1Ye0tamIFJatJ4bq3BpU3W6XqAm50SKJLXFMobKeYbWEXprXKubB20hPSMreoSMGEQq_18oOJj9VKM9XSmlCrw>
X-ME-Proxy-Cause: dmFkZTGdnbhrwCZuOqCunEb1uCWH9T9wdwWL57+yru9gcF9ktOQzwGSO0Kt5gi/9kjhbef
    qHpgM6JDUer/435UC0RvBDU59Y3uNTz7tPTghgf9d+INyQNqX1C55YJEe0qCNWTk7jxnyy
    2GYEZwjdwRm0gRQhaRCHGH4uTRgS3poCbxOaexMjXS/FLrZotmfSxhp2R5qZThDi/4tq+a
    OAKIaVvereKJrNGJmJd7hkbJobXsxuaNUXKFMvy3jTkieDgO6lDXGH8oSTAhzMSHQJfG9Z
    90M/muuyks95KnEO52mFKrKcsE0CWx7rQ1a9g6l9l61Kn4PZTpkhiOPpX8BUW5gH7mr4CU
    RsdINLKVHJ7zGYpXpSP0/cdW6TLJlo4EERmjk+WdIzNjyWnqf6CzYYMAR2hdWplBe7X2Mk
    TWORKoicUcRZoZhpydw5TfuXOABj0PQ63GlY35FofFLi60TlwP4dDZ4pK25sm0VZAJmT1U
    +mqNFVEtEwE7vtNA1dneeI9N99VVJxRrhPYKVKI/sdqM5ZnxbhmfarLlsUdJvLQWV5xi43
    bZpSUATkrig5LFWJO+w58SoQDWLn1Sgsjm5duEwePMhE/p15JucT+42rOvzDwWTbJDxxbU
    n3JdV7n44107d2oUUSyTYE9UOZpCsk09yC98JyfRZXGX1cYRxM8xdMYWJtoA
X-ME-Proxy: <xmx:LfI4akq-F3i_w_iICk4ygytCO9ij38PYtFVZT-7d6gxJ-A4ik2WMFQ>
    <xmx:LfI4akG3i7yLIiX5a9lvglCUXAUOCzSlvqFC1tIERudI0iQyPaZLWg>
    <xmx:LfI4aoy6o2pnjh02qT-tSF15o5-0qa5j0FBxgRDmrF-b6bCJFfaudw>
    <xmx:LfI4ahpJS2rknoKBQSk2JcYITHym5qDaQZEfFBMHWcSanc1phL8HbA>
    <xmx:LfI4ajruhxn7bNyAXt5ak8_52PAMX0Kg2jhONZN7qeu9VKjZfsuCq9kv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 04:28:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0c3267fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 08:28:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 00/11] refs: fix "onbranch" conditions
Date: Mon, 22 Jun 2026 10:28:22 +0200
Message-Id: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACbyOGoC/43QwU7EIBAG4FfZcBYDdGCpJ9/DeBjo1KKxbaASN
 5u+u9PVmO6tx5/MfD+ZqyiUExXxdLqKTDWVNI0c7MNJxAHHN5Kp4yyMMk451coAcv4oMlNfJNY
 pdTIOXcpynJbUX/h9xkzjIhEIe01diBgEazNvpO9b08vrby5f4Z3isvHbxJDKMuXL7StVb3N/r
 Vodbq1aKmld9A6C0hGaZ157TJ9iq6xmj9rjqGG0B28BsW29be/QZo/642jDqEHrXEuecXeHwh4
 9fvQKjKKDswl0xhjhH13X9Qeys0eT7AEAAA==
X-Change-ID: 20260609-b4-pks-refs-avoid-chdir-notify-reparent-a4eaf1edbcab
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Hi,

originally, this patch series was a follow-up of the discussion at [1],
where it converted the reference backends to always use absolute paths
internally so that we could drop the `chdir_notify_reparent()`
machinery. But this focus shifted as we discovered that this led to
quite a sizeable performance regression.

Instead, the series now focusses on fixing handling of the "onbranch"
conditions. As part of the above work I discovered that we recurse when
creating the main reference database in case we have "onbranch"
conditions, and that recursion caused us to construct an ad-hoc
reference store that we essentially discarded. The leak wasn't ever
catched though because the store is kept alive by the `chdir_notify`
infrastructure.

This is a deeper-running issue though: the reference backends respect
some configuration guarded by "onbranch" conditions, but not all of
them. This issue is fixed by this series by lazy-loading all
configuration so that we don't need to read any configuration when we
initialize the reference store. This fixes the recursion and makes us
consistently honor those "onbranch" conditions.

This series is built on top of 1ff279f340 (The 13th batch, 2026-06-09)
with ps/setup-centralize-odb-creation at 42b9d3dc9d (setup: construct
object database in `apply_repository_format()`, 2026-06-04) merged into
it.

Changes in v5:
  - Fix the "onbranch" recursion properly: instead of papering over the
    issue, this series now refactors reference store initialization to
    not read any configuration at all anymore. Instead, the config is
    now parsed lazily. This fixes the recursion, but also makes us
    respect configuration guarded by "onbranch" conditions properly.
  - Link to v4: https://patch.msgid.link/20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im

Changes in v4:
  - Fix the "onbranch" recursion at the root of the problem by
    explicitly disabling the use of the ref store when parsing
    configuration at ref store initialization time.
  - Link to v3: https://patch.msgid.link/20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im

Changes in v3:
  - Reduce the scope of applying the GIT_REFERENCE_BACKEND environment
    variable even further so that we really only do this when we end up
    applying the reference format.
  - Fix a commit message that still referred to the dropped last commit.
  - Link to v2: https://patch.msgid.link/20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im

Changes in v2:
  - Drop the last patch. This seemingly destroys the whole purpose of
    the patch series, but after Peff's hint that this is actually a
    performance optimization I'm less inclined to drop the chdir_notify
    infra. I still think that the remainder of the patches make sense
    standalone, as they simplify "setup.c" and clean memory leaks. Going
    forward I'd like to investigate the idea of introducing a `struct
    fsroot` infrastructure that uses the platform-equivalent of openat
    et al.
  - Improve a couple of commit messages.
  - Link to v1: https://patch.msgid.link/20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im

Thanks!

Patrick

[1]: <aifAVpxanV31KUpC@pks.im>

---
Patrick Steinhardt (11):
      setup: inline `check_and_apply_repository_format()`
      setup: stop applying repository format twice
      setup: don't apply "GIT_REFERENCE_BACKEND" without a repository
      refs: unregister reference stores from "chdir_notify"
      chdir-notify: drop unused `chdir_notify_reparent()`
      repository: free main reference database
      refs: move parsing of "core.logAllRefUpdates" back into ref stores
      refs/files: lazy-load configuration to fix chicken-and-egg
      reftable: split up write options
      refs/reftable: lazy-load configuration to fix chicken-and-egg
      refs: protect against chicken-and-egg recursion

 builtin/checkout.c                  |   7 +-
 chdir-notify.c                      |  26 -----
 chdir-notify.h                      |   6 +-
 refs.c                              |  17 +++-
 refs.h                              |   9 ++
 refs/files-backend.c                |  69 ++++++++++---
 refs/packed-backend.c               |  16 ++-
 refs/refs-internal.h                |   6 --
 refs/reftable-backend.c             | 177 ++++++++++++++++++++-------------
 reftable/reftable-stack.h           |  30 +++++-
 reftable/reftable-writer.h          |  17 +---
 reftable/stack.c                    | 100 ++++++++++++-------
 reftable/stack.h                    |   2 +-
 reftable/writer.c                   |  21 ++--
 reftable/writer.h                   |   1 +
 repo-settings.c                     |  16 ---
 repo-settings.h                     |   9 --
 repository.c                        |   5 +
 setup.c                             | 102 ++++++++-----------
 t/helper/test-reftable.c            |   2 +-
 t/t0600-reffiles-backend.sh         |  21 ++++
 t/t0613-reftable-write-options.sh   |  19 ++++
 t/t1400-update-ref.sh               |  12 +++
 t/unit-tests/lib-reftable.c         |   8 +-
 t/unit-tests/lib-reftable.h         |   2 +
 t/unit-tests/u-reftable-merged.c    |   9 +-
 t/unit-tests/u-reftable-readwrite.c |  38 ++++++--
 t/unit-tests/u-reftable-stack.c     | 189 ++++++++++++++++--------------------
 t/unit-tests/u-reftable-table.c     |   8 +-
 29 files changed, 555 insertions(+), 389 deletions(-)

Range-diff versus v4:

 1:  a70b0f44b2 =  1:  1a3e7849fb setup: inline `check_and_apply_repository_format()`
 2:  b33b51748b =  2:  9fee5b6ac2 setup: stop applying repository format twice
 3:  a22755337a =  3:  8eeaaa2359 setup: don't apply "GIT_REFERENCE_BACKEND" without a repository
 4:  848645c3e8 =  4:  19f0e381aa refs: unregister reference stores from "chdir_notify"
 5:  489e274577 =  5:  5b1ec8f62a chdir-notify: drop unused `chdir_notify_reparent()`
 6:  a9811da5c8 =  6:  44abab07fa repository: free main reference database
 7:  8de1023c6b =  7:  21d46ff924 refs: move parsing of "core.logAllRefUpdates" back into ref stores
 8:  cb3cf159d2 <  -:  ---------- refs/reftable-backend: manually parse "core.sharedRepository"
 9:  1a7c195c03 <  -:  ---------- refs: fix recursing `get_main_ref_store()` with "onbranch" config
10:  c9b019a1a5 <  -:  ---------- refs: drop local buffer in `refs_compute_filesystem_location()`
 -:  ---------- >  8:  22d65ada3d refs/files: lazy-load configuration to fix chicken-and-egg
 -:  ---------- >  9:  715b090f40 reftable: split up write options
 -:  ---------- > 10:  a941049373 refs/reftable: lazy-load configuration to fix chicken-and-egg
 -:  ---------- > 11:  7ca965fe73 refs: protect against chicken-and-egg recursion

---
base-commit: 255322df35357168daefec8523a3cdc849edd6c1
change-id: 20260609-b4-pks-refs-avoid-chdir-notify-reparent-a4eaf1edbcab

