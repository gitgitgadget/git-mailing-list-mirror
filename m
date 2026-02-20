Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB5D336ED2
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575867; cv=none; b=oXbMZ7kHIADdWh4P8hqZL2kuDQgygZ6ENE7qPDtoh6D1T+oeEzKAzOmDRXeOOJNUQOZFrmcC9vVLZYn+1eWfa3KboRl/v6Pw0KjwJcnL48ljrT+SZdKKec71qVgsonKiOUwKBzsn9YK4eGzDLWZkYQGLK6fikEh65XacLlVyjtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575867; c=relaxed/simple;
	bh=/Zdapa9oX8eIT3gVTAUytyUtmVDg9epT+UVdEJdkEEQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sRX7PmFLCejIbiGYYhTvvGsPH4FpOPMUpg1ADJUYBsixOHaOtBTqpF0SvcENZaUQrNvhc+Y0thwdIlTw67TGe6D3vQrQocfIKxnIafzewp0r6flpI3O5+jGzfEwOYz9VQqpVvO1x0Ssr8BTFMdgXnjunWXHDu5hTf6+AnnVzm74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I3Zc7SSf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gStL6/Px; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I3Zc7SSf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gStL6/Px"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 07D641D0009D;
	Fri, 20 Feb 2026 03:24:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 20 Feb 2026 03:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1771575864; x=1771662264; bh=JwHbdaqbxX
	d5+D/jZFvhvsM1Gi8T8/HNpNylVdU+d28=; b=I3Zc7SSfoRVN6VI7Y3O2ybswzV
	t6ojuaYFLZFCKv6nRKUXk7sYrxwmf0YIOiFKptYl1D3772ak/WeR/u2CtlRgoEAJ
	iVF9+GGiorjavbiNDdUfJGoPt42TcmRMFqb7yqEG6SzHoyWd/yJ1EQZ+u6cWgsAi
	UwsSpPGkkIoDE1gf+tL3XP4UHSe2qsiNY1w29ZwgUoxIHb1gUKXUZvFQUMPjSqIX
	FpsO6+c70MscgtyDde8mIcbQGXKGJpkt41p05JY3AbGgKV03d5iA4+ogDwS0AuM4
	jn4rgAa5SzcEkZ6G3OFTb0IwiREjp+ZbwDhPs/H+xoocQ+bOtKrRrj/AaHSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1771575864; x=1771662264; bh=JwHbdaqbxXd5+D/jZFvhvsM1Gi8T
	8/HNpNylVdU+d28=; b=gStL6/PxINaJerfYl+DdenK70cLP4f0j3JefbiAp4Icj
	Pr7tEruxxU7hUkurC6i6sWoEvzr4dc7oVzXi3rx4R6MlrAjG5eqDbFqm6aqAX1NL
	6ls4wF3imnP4tGBenvltXXgqlJZbP+OQinqlHDRmpMa+9TOBVdA/9VJZ0bnuD4pb
	oxMwunYrFLulJLQzT/ubMOi7cti+gGqKh8gqWiMHiUrIV922Q2Q54oC6fAEzdp30
	K4GbbzqaObr5eNqwSaN8MbQ9UpfNiSc1bLd2GSH5eMQgGueB0Lr9RrtsUHumXor3
	UGEQeJu9KYYj4TcnJQilIsK65j2YsWomVJWq4/jgAw==
X-ME-Sender: <xms:OBqYaXEWtwjmapy_bQCuyQCkzm9cRb3ovE6_IEWUr4IHUVMxi3WPtA>
    <xme:OBqYaaWz3breE580gUa0GQ0p_AV_gP1tWUj9zhsQvA_2ZWpu_oESu4PqlFGRGtDNn
    fr3fBVbscSv2jr6mSeO-6hKlNqNrJ6Lpoi4xnlVryRzde8ThhxrGA>
X-ME-Received: <xmr:OBqYaWyxMKYeP9EowarC08Rl0lDjRl5OSRTLFt1quql3hKIo6QPQVuJpsyMSUkyDIs4elrKYnUcb5feCxRrD2lJBYSGmRNddUXy5vMYynbH7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evueegkedtteeigeejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OBqYaQPcjOEPfbtRt9slrXGZfgoqZ106Hcoj6gCfojJnjcHtB9L-pw>
    <xmx:OBqYaf7cLu1yIuAqInWX6x_MMx9cgvbQfWoPLeq2QRnSZ6ea0ZQ93Q>
    <xmx:OBqYaZM3QLOezcp6NvEaWIpl_kHrs7Jh-_6B2hi_PKatb02GZbfyKQ>
    <xmx:OBqYaVluXpVs0u-j2vzXzSKPfj3A-KOJyzuSAs2BK63RzAKov5qszA>
    <xmx:OBqYaX1Q_joVua2goFKnK-JVNlUDs-KkT-mFm5NnJGfL_txZ1P58xBlm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:24:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 60ae6c87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:24:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/17] refs: unify `refs_for_each_*()` functions
Date: Fri, 20 Feb 2026 09:24:04 +0100
Message-Id: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACUamGkC/x2MQQqDQAwAvyI5G1hDVepXioclzWoorLJRKcj+v
 aHHgZm5waSoGEzNDUUuNd2yQ9c2wGvMi6C+nYECDYEo4P4xLJIM01ZQIq94Zk3K8fASx34kHp4
 PThzAH7ur+v3/X3OtP9HDdMZvAAAA
X-Change-ID: 20260220-pks-refs-for-each-unification-7572c694cfc0
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Hi,

we currently have 14 different `refs_for_each_*()` functions, with each
of them doing slightly different things. This makes for a confusing API
surface, and because the API is not built for extension we have to add a
new function every now and then to handle another esoteric edge case
that will ultimately only have at most a handful of callers.

This design isn't really sensible in my opinion, and this patch series
aims to fix that. Instead of having a dozen different functions, it
introduces a new `refs_for_each_ref_ext()` function that simply takes an
options structure as input. From thereon, callers can mix and match the
parameters that they care about.

The patch series is structured like this:

  - Patches 1 to 5 introduce some preliminary cleanups.

  - Patches 6 to 9 introduce `refs_for_each_ref_ext()` and move
    more functionality into it. This also fixes a performance bug that
    we have in one of the implementations.

  - Patch 10 adds some more verification for options that would have
    caught the bugs in ps/for-each-ref-in-fixes.

  - The remaining patches drop 7 out of 14 functions and replace them
    with `refs_for_each_ref_ext()`. It results in a bit of churn, so
    while I think this churn is worth it, I consider these patches to be
    optional.

The patch series is built on top of 73fd77805f (The 5th batch,
2026-02-17) with ps/for-each-ref-in-fixes at 6375a00ef1 (bisect:
simplify string_list memory handling, 2026-02-19) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (17):
      refs: move `refs_head_ref_namespaced()`
      refs: move `do_for_each_ref_flags` further up
      refs: rename `do_for_each_ref_flags`
      refs: rename `each_ref_fn`
      refs: remove unused `refs_for_each_include_root_ref()`
      refs: introduce `refs_for_each_ref_ext`
      refs: speed up `refs_for_each_glob_ref_in()`
      refs: generalize `refs_for_each_namespaced_ref()`
      refs: generalize `refs_for_each_fullref_in_prefixes()`
      refs: improve verification for-each-ref options
      refs: replace `refs_for_each_ref_in()`
      refs: replace `refs_for_each_rawref()`
      refs: replace `refs_for_each_rawref_in()`
      refs: replace `refs_for_each_glob_ref_in()`
      refs: replace `refs_for_each_glob_ref()`
      refs: replace `refs_for_each_namespaced_ref()`
      refs: replace `refs_for_each_fullref_in()`

 bisect.c                  |  16 ++-
 builtin/bisect.c          |  34 ++++--
 builtin/describe.c        |   7 +-
 builtin/fetch.c           |   7 +-
 builtin/fsck.c            |   7 +-
 builtin/receive-pack.c    |   8 +-
 builtin/remote.c          |   8 +-
 builtin/rev-parse.c       |  37 ++++---
 builtin/show-ref.c        |  21 ++--
 fetch-pack.c              |  15 ++-
 http-backend.c            |   8 +-
 ls-refs.c                 |  11 +-
 notes.c                   |   7 +-
 pack-bitmap.c             |  15 +--
 pack-bitmap.h             |   2 +-
 ref-filter.c              |  19 ++--
 refs.c                    | 256 ++++++++++++++++++++++------------------------
 refs.h                    | 198 +++++++++++++++++------------------
 refs/files-backend.c      |  19 ++--
 refs/iterator.c           |   2 +-
 refs/packed-backend.c     |   8 +-
 refs/reftable-backend.c   |  10 +-
 revision.c                |  46 ++++++---
 submodule.c               |   2 +-
 t/helper/test-ref-store.c |  15 ++-
 upload-pack.c             |  13 ++-
 worktree.c                |   2 +-
 worktree.h                |   2 +-
 28 files changed, 437 insertions(+), 358 deletions(-)


---
base-commit: dbbe43524e0814c1f93325795ed6aa26eb6e587e
change-id: 20260220-pks-refs-for-each-unification-7572c694cfc0

