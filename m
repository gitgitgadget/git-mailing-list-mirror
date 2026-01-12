Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4556822AE65
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208589; cv=none; b=Ei0vxdFKt7OinVeWLLCmFb7i1rFAewi0C7/dZ2iIzFIaiYAlzO0+9VkCUYlXFWbmbJIcdJGTPWXVMpjEL/JuTlY6KA6hOz8diXdfc76s6+2USOMyp6i/md4aD29/3F9PndQnVAjiruY/6a/voNCgwc3BE77QaVyJYP+Wh7wTpvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208589; c=relaxed/simple;
	bh=D94Ud8LObeqhcfIgeTZA/bktoToGxraOzJ1/rjkoFGM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=BedD8hKMz/v7qZHbF00QcKP82ANbGNC9XozKiLKihNmlzEZoT3SCffDrC97w7DcqHRIiPpF5774JCjW9LlM+p+BQCMt+puehgXQ/RUsMg1HjqXKRhlPJpEYdJosMDjx8OcsjMy/+WnA9pk1Axxtv7D5YVD2NK5jHzEXVLgNmnxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f7V85e2g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zyT9x27b; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f7V85e2g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zyT9x27b"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8FDDA7A0040;
	Mon, 12 Jan 2026 04:02:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 12 Jan 2026 04:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208576;
	 x=1768294976; bh=KtSuw37l6JVPOaqom4LyYGRdMMNQyFg0w5D5nFknjjo=; b=
	f7V85e2gjwbmIXytBPek/3XaxghYm/lH1Xp1o0bdqzdkZqt5QYitjaplGsZIbGQG
	fINbwxHQgv7QrlZlVr+n+ESN5w3Rn4QEA4mKOkSZkfFOWmA+66/+e6vfRezQjeMC
	LNiEH7peGak0j5F1HG6EGLpOF39iR9FHcv5cI1ZqtSPxXL8aruTV50HExAtSJB6I
	CGMbgdjIhTWFykGOpY3D4ZF6iKgR+rn6bKyySUzxU4OYBKfbClWqQ20goQdLGapg
	g2wQu3KFj7XbaxUsCzYphP8OM0C7S9TutZotHG8HIrO6GRD4/WW9qkMSA7BMhq2R
	n2Zvwm0/wwTwj1te8lustg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208576; x=
	1768294976; bh=KtSuw37l6JVPOaqom4LyYGRdMMNQyFg0w5D5nFknjjo=; b=z
	yT9x27bVcCDCn1eeVr5DB9WqWa+vXZTodhFPsKfryIGcPVOm1SDLkHVw+WLK0Bre
	GLtjnsDPM36g35I5ynk7tOtq8ej0hz7B5hNGf83ekk8SN+Srm+z0eQC3t8MKHxOy
	AK+fl/+Tr1fffkOPt9FcJ1atMSotU3eSW8gcyjucPPJnHrDAFMCUurFtoG6Tx/MH
	a2XH9iMI2BLgSjoY5I9nL7IDyv5nzHzXri7zIA/c5xcHLh94XV3pQCACsKxgXF+J
	WkzHhX/X4NxzS7bnkGUlg4o75b29zCMPiCs8nhz4u/uWNyHdmncIZ4rngD8DkZWr
	Xo+aP4pdYZ4a0O152SNlg==
X-ME-Sender: <xms:wLhkaeBlWEWPtQm1EDC-6CxBaYf0tORC32oJ3BGS_DHJEJbLLIFZDA>
    <xme:wLhkaf-XfM42Ly8uOyLi82WrwIWbZDVVw8YBO-RDKq4bPDaGGf5wkg8Rm1tuigvjB
    p-nP-eAiTEv5pdYk3zRL3CY3QJRdDIR1eW-Td6oM2VeFtLI5eAF3g>
X-ME-Received: <xmr:wLhkae_ZLVFe0TKdAo3svXi9TBJ8zqlQpVsC7wv7s0Aig40TwIvyUBhqtHND6ODnPcuXkZt7uX3Sxd-nOP9f78uO00f-IuG3R2SJKAfQxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:wLhkaWcIcdVU8S8ck0rmhsfKQlxaG2XeI44j7cRy5WsVbuEGZqfeCw>
    <xmx:wLhkaXGZAurqBjzlOIcmoIJdhHkMMbyg9z0EJvdL7Sta4LqikBClJA>
    <xmx:wLhkaUdctHWvXT8f5Pmam8wtUiEHVDLxZ7s2O5YF1MZTp3-qpNyUpQ>
    <xmx:wLhkaREe-jk-YNbXsbMLzGIGZgjOSViOW4mmTR9mNoDjQa99oinIbg>
    <xmx:wLhkaTaYDfH3RRzgkEW8a3L4QROtWf1hfFQk5gJEkVLl3i1jud0CmOGC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:02:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8f6db558 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:02:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/17] Fixes and improvements for ref consistency checks
Date: Mon, 12 Jan 2026 10:02:49 +0100
Message-Id: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALq4ZGkC/4WNQQ6CMBBFr0Jm7Zi2oAVX3sOwQJjKxAikYxoJ6
 d0dvIDL9+e/PxsIRSaBS7FBpMTC86TgDgX0Yzc9CHlQBmfc2VjT4PIUjBQEk4phxcAfErRU+dq
 70vo+gLqLVvaDqrdWeWR5z3H9vUl2T/8tJosGy1Pth3tna9dUV+0d+QVtzvkL0ivnJrcAAAA=
X-Change-ID: 20260109-pks-refs-verify-fixes-1e47872317cf
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Hi,

this patch series contains a bunch of fixes and improvements for ref
consistency checks. It is structured as follows:

  - Patches 1 to 4 contain a couple of cleanups for the consistency
    checks done by the "files" backend.

  - Patches 5 to 7 introduce checks for root refs for the "files"
    backend.

  - Patches 9 to 14 introduce infrastructure for shared checks with the
    "files" and "reftable" backend.

  - Patches 15 to 17 move some ref consistency checks that were still
    driven by git-fsck(1) into `git refs verify`.

Changes in v2:
  - Remove unused `errors_found` field.
  - Fix a commit message typo.
  - Fix a copy-paste error in a function comment.
  - Link to v1: https://lore.kernel.org/r/20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (17):
      refs/files: simplify iterating through root refs
      refs/files: move fsck functions into global scope
      refs/files: remove `refs_check_dir` parameter
      refs/files: remove useless indirection
      refs/files: extract function to check single ref
      refs/files: improve error handling when verifying symrefs
      refs/files: perform consistency checks for root refs
      fsck: drop unused fields from `struct fsck_ref_report`
      refs/files: extract generic symref target checks
      refs/files: introduce function to perform normal ref checks
      refs/reftable: adapt includes to become consistent
      refs/reftable: extract function to retrieve backend for worktree
      refs/reftable: fix consistency checks with worktrees
      refs/reftable: introduce generic checks for refs
      builtin/fsck: move generic object ID checks into `refs_fsck()`
      builtin/fsck: move generic HEAD check into `refs_fsck()`
      builtin/fsck: drop `fsck_head_link()`

 Documentation/fsck-msgids.adoc |   6 ++
 builtin/fsck.c                 |  46 +--------
 fsck.c                         |   5 -
 fsck.h                         |   4 +-
 refs.c                         |  43 ++++++++
 refs.h                         |  18 ++++
 refs/files-backend.c           | 228 ++++++++++++++++++++++++-----------------
 refs/reftable-backend.c        | 167 ++++++++++++++++++++++--------
 t/t0602-reffiles-fsck.sh       |  30 ++++++
 t/t0614-reftable-fsck.sh       |  44 ++++++++
 t/t1450-fsck.sh                |  10 +-
 11 files changed, 414 insertions(+), 187 deletions(-)

Range-diff versus v1:

 1:  201451626d =  1:  21531efb05 refs/files: simplify iterating through root refs
 2:  88252f2b99 =  2:  861bd57d6e refs/files: move fsck functions into global scope
 3:  56d8ce2c85 =  3:  e06b8bdd23 refs/files: remove `refs_check_dir` parameter
 4:  ddf450134c =  4:  92992a522e refs/files: remove useless indirection
 5:  2d3ebf80fd =  5:  904fecf80e refs/files: extract function to check single ref
 6:  316dafeff8 =  6:  b5f5e86f1f refs/files: improve error handling when verifying symrefs
 7:  94a9b3d58b !  7:  d1abff98f8 refs/files: perform consistency checks for root refs
    @@ refs/files-backend.c: static int files_fsck_refs_dir(struct ref_store *ref_store
     +	struct worktree *wt;
     +	struct strbuf refname;
     +	struct strbuf path;
    -+	bool errors_found;
     +};
     +
     +static int files_fsck_root_ref(const char *refname, void *cb_data)
    @@ refs/files-backend.c: static int files_fsck_refs_dir(struct ref_store *ref_store
      	if (files_fsck_refs_dir(ref_store, o, wt) < 0)
      		ret = -1;
     +
    -+	if (for_each_root_ref(refs, files_fsck_root_ref, &data) < 0 ||
    -+	    data.errors_found)
    ++	if (for_each_root_ref(refs, files_fsck_root_ref, &data) < 0)
     +		ret = -1;
     +
      	if (refs->packed_ref_store->be->fsck(refs->packed_ref_store, o, wt) < 0)
 8:  a773fd65e9 =  8:  0b0e0e0033 fsck: drop unused fields from `struct fsck_ref_report`
 9:  12cf39ce8c !  9:  4bf249e530 refs/files: extract generic symref target checks
    @@ Commit message
     
         Reimplementing these checks for every single backend doesn't really make
         sense. Extract it into a generic `refs_fsck_symref()` function that can
    -    be used my other backends, as well. The "reftable" backend will be wired
    +    be used by other backends, as well. The "reftable" backend will be wired
         up in a subsequent commit.
     
         While at it, improve the consistency checks so that we don't complain
10:  9ae96c0acb ! 10:  5bd34fb53c refs/files: introduce function to perform normal ref checks
    @@ refs.h: int check_refname_format(const char *refname, int flags);
      struct fsck_ref_report;
      
     +/*
    -+ * Perform generic checks for a specific symref target. This function is
    ++ * Perform generic checks for a specific direct ref. This function is
     + * expected to be called by the ref backends for every symbolic ref.
     + */
     +int refs_fsck_ref(struct ref_store *refs, struct fsck_options *o,
11:  c2b0a1f517 = 11:  ca62b50abc refs/reftable: adapt includes to become consistent
12:  608b689d9e = 12:  66b5d6c981 refs/reftable: extract function to retrieve backend for worktree
13:  d39733206f = 13:  d31b7fb348 refs/reftable: fix consistency checks with worktrees
14:  37b8d22941 = 14:  eb960e66f2 refs/reftable: introduce generic checks for refs
15:  72b81062d2 = 15:  d0e2e3fe33 builtin/fsck: move generic object ID checks into `refs_fsck()`
16:  07a2403bc7 = 16:  029d02dd8a builtin/fsck: move generic HEAD check into `refs_fsck()`
17:  e944a0e430 = 17:  99eb06f153 builtin/fsck: drop `fsck_head_link()`

---
base-commit: d529f3a197364881746f558e5652f0236131eb86
change-id: 20260109-pks-refs-verify-fixes-1e47872317cf

