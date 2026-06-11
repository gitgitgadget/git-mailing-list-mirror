Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA340B6E2
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184437; cv=none; b=RR6/9Q0Rn1n9df0wSwmE2DZcWIp3fIrsbGOLI3zmymmFoGYCsaFE+IW2TOJPwTcLXj2J+GmqjXWyR0/mGwCCnZ9F13RdbJUrqbgKNHxSKXKlqkaQpw9gj59LvWt7sZ2fPs8dhDRM44qNBaKbelRPearggvdt2tQc24TtnK7PPz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184437; c=relaxed/simple;
	bh=bz8UCv2QcjtKUGoie34ZXdp8JV8JpvPjWodE/VJIa9U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=cHc4QJ3FvT/vBn4OB49Rz7Gz+maT2Wf4VYNEGGXccujDIAgCO+G8TQqUqNOAOeJoANKoIoZ+6vTY0etSrjsiWoM1/0LT3VnUiJXHWU36961FqDNN1bzhPO5fdyRP6tIotdiGPnCf82Irorz2+ChIpWI1219/Eh7+3bbEZyBYRe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mvuyxPer; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DwNinvm6; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mvuyxPer";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DwNinvm6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A040714000E8;
	Thu, 11 Jun 2026 09:27:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 09:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781184435;
	 x=1781270835; bh=UHd0Aa5lUyL5kdqZkTKCin8ke2aMIup4WifMnWjmmF4=; b=
	mvuyxPerf+0i3m03d+0yitjC62ixiIgLVaNXg/0brEG3uvaVXuYFuTBoTZtdrJLB
	YEdANgczY7tekpIGAZVYgfO5m2YR9HroOB/iwRUUjtFHGtKXjf1AyAFLcACuTg85
	oEG7WY9jUVg9oJcyEbqnXRDu2bCPjo4VPZUhDuc3aTyFI6QzQpogHoT0O0M9/nID
	ZF7WDCgoQMBrOPaAyiuCritG77iy6xCQuj5wbvx+5KkQm7HSrUIoZSn0idE9SHHh
	9RYkL1tjxoPSwMPFb3aG5Bs7zqCtXVaAKy3u9/x8EUBrEj1lln6LMNQrD3W9AFz6
	SX9zsx7kwEUtFcGnWqZxUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781184435; x=
	1781270835; bh=UHd0Aa5lUyL5kdqZkTKCin8ke2aMIup4WifMnWjmmF4=; b=D
	wNinvm6shInUCSsTzT9Wh/PrCPdZqyS8JeNLceNzdOEYbT2UNDyN5XEl+sHjOg/x
	eXqgSaGVzpZwBpQq75PImWw77PUtUFMmsECX2yYqY9TFUpROwEpT6RqL980DdTy7
	SKsZf6b36g8ApW+GV8ha3ii71SXT5srU4Mh2t87VkE+RKwH8+k65ypZyZ6RZZeBa
	XOSEDZZqpP+3vmY/nEcjUGrYeMCugAAcdjSKQVxA+p3/xG7VLBDgnRnmt0Y65eDZ
	6ctgKg70KuPD59OJsmvAyhw3njK4NiHLudNtW3f9y95eusITjuAyGJBe0gOE2SZV
	YrP9FiDuYxRAQKl3tBzwA==
X-ME-Sender: <xms:s7cqaniIAGdaCYx03JhmmUfvxMVnFdhWiaixHk8P0Nw43h6AEUMWyQ>
    <xme:s7cqalgVF7pJPI4HP86TCwtTmyIk_ZWl721R6JM8gj-qYB0al8sgrlyjaNnds3wFf
    H8DhqtqimdOHdDYHA7qJrr5F1L5VHqibJgPp8G_2pBzk_SIndawAg>
X-ME-Received: <xmr:s7cqanLjNitKzhL3uHOmDjY8yHRYsyHL-JnJ-eALz5rcTr2BwCTByzK0UdHvaocvPp09yFCZE9vUyxivBSybEYDUjVTR8UO7-yT3xtY9CVBd>
X-ME-Proxy-Cause: dmFkZTGJG2tJGWCMOLue2nmT8xTMxGb/FjjBgeEfwJbFh4iYb5xhX/HejKbaNYcAilNrxS
    oMj9elr+ntszgKBnGCFTHIJKTorH4BXw47Z6eicZ0xvOA8c5P8M48zeBgdq+tZiOOa8kyJ
    I96y/t8B0zHg5XYIr7n9OT4xsVZAOZqED2RYW0Ut1YZ6ShIs1M1YY2NW9THDtbofEwhNLC
    mRfyO1jB6ahbHQh6vs7qxU90oZSzLAnJd5NZpDYdnxjft0Cacr6cU0Hu2oifKYFdgr8yW7
    R3Ih5iQNDFe1GULK0v7qu0oPlSdXNuSCpu+Y5lJ2KCa7j9XTsSoGQrW5zWok+7fCABQ9dY
    5rWORpoSXZI//f2gzAzIQ0+685Wsh5ZgwdzmAkxtMTNpy8/qF7wTAsJI3q/WAEdOPLrxjX
    t0K23oy5CVxNz0nVZjNZN5rRBQ4bgCreKSXHUGYXsAr6adfVSQ38wVARa8MpOC2qFa1C3H
    E5GVCuCbH+DrnhaCf/7qAV/U6j1OWKMKbwGAtnAJ3kL7p5jJnOnGYu1CIws/Hjs3NhvZ0g
    fEzWskU4zxPtMo81NEjyYtl6QhsfpQ+VegMA6osF2FachTO5hdH0jHV43uS1Ew43PbEFzy
    WzWC0sYrwxi3XN4qOr9RPpxgqbUOebqXKbFH30O7cQ032j3r/5pcIA1VPfgA
X-ME-Proxy: <xmx:s7cqakGdy0PtnnoV6rG_OYVAKSD4iaQOZMb45_Gyor5-LigjYVkM-g>
    <xmx:s7cqarSiH3mu6jeGfBJDOTuYFFG0zpDwYw-PMiPCzXWFGkeTcfhJ0g>
    <xmx:s7cqagdABwyZ6nN01R9hxrrb_YCU4YAFRsetG7W-LbblcLfvNyj6Ig>
    <xmx:s7cqaqrn0wPHmnrBO07IOZ8Rz0yrtli7S7ZD5vmWNp1ii83J8Zy8qg>
    <xmx:s7cqavVgLEa9GJ_MYHV7XzxBXt2H6dfq5ey0WqeiTu3a1qrmezeLuRwz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 09:27:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 15198c24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 13:27:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 00/10] builtin/history: introduce "drop" subcommand
Date: Thu, 11 Jun 2026 15:27:03 +0200
Message-Id: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKe3KmoC/33PTQrCMBAF4KuUrI3kv6kr7yEumnRqo9iWRIMiv
 buJClYoLh+8+WbmgQJ4BwFtigfyEF1wQ5+CXBXIdnV/AOyalBEjTBFFKDYCj6eAOxcug7/jxg8
 jZrpVVvGqgtKgNDl6aN3tpe727xyu5gj2kqnc+Iy/1kaae/83RIoJVoIDZ1yQRsptqqzdGWU+s
 jnAlwGWgFIwa6SRtFTND8DngF4GeAK0sLWGdEbFyx9AzABKlgGRL0i3t6QGbdn3hWmansQD6ne
 IAQAA
X-Change-ID: 20260601-b4-pks-history-drop-28f6c6399e7b
In-Reply-To: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
References: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

Hi,

this small patch series introduces the new "drop" subcommand for
git-history(1). As a reader might guess, the command does exactly that:
given a commit, it will drop that commit from the commit history and
replay descendant branches on top of it.

Changes in v5:
  - Reject UPDATE_ORIG_HEAD without UPDATE_HEAD.
  - Link to v4: https://patch.msgid.link/20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im

Changes in v4:
  - Remove the `SKIP_REF_UPDATES` flag in favor of a new `UPDATE_HEAD`
    flag, as suggested by Phillip.
  - Rename `reset_head()` to `reset_working_tree()`. This better matches
    the new scope of the function, and it helps us to catch any
    in-flight patches that would now have to set the `UPDATE_HEAD` flag.
  - Link to v3: https://patch.msgid.link/20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im

Changes in v3:
  - Fix commit message typos.
  - Make `update_orig_head` and `skip_ref_updates` mutually exclusive.
  - Use fancy revisions to specify the commit to drop in the example
    section.
  - Detect conflicting changes in the index/working tree in dry-run
    mode.
  - Consistently use a subshell.
  - Rename `RESET_HEAD_ORIG_HEAD` to `RESET_HEAD_UPDATE_ORIG_HEAD`.
  - 
  - Link to v2: https://patch.msgid.link/20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im

Changes in v2:
  - Reworked `update_worktree()` to use `reset_head()`, which required a
    bunch of changes to `reset_head()`.
  - Consistently mention the commit that cannot be dropped as part of
    error messages.
  - Adapt error message to not use backticks anymore.
  - Drop redundant "--graph" flag in a test helper.
  - Link to v1: https://patch.msgid.link/20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (10):
      read-cache: split out function to drop unmerged entries to stage 0
      reset: drop `USE_THE_REPOSITORY_VARIABLE`
      reset: rename `reset_head()`
      reset: modernize flags passed to `reset_working_tree()`
      reset: introduce dry-run mode
      reset: introduce ability to skip updating HEAD
      reset: allow the caller to specify the current HEAD object
      reset: stop assuming that the caller passes in a clean index
      builtin/history: split handling of ref updates into two phases
      builtin/history: implement "drop" subcommand

 Documentation/git-history.adoc |  38 ++-
 builtin/history.c              | 288 +++++++++++++++++++---
 builtin/rebase.c               |  41 ++--
 read-cache-ll.h                |   1 +
 read-cache.c                   |  12 +-
 reset.c                        | 102 +++++---
 reset.h                        |  51 ++--
 sequencer.c                    |  17 +-
 t/meson.build                  |   1 +
 t/t3454-history-drop.sh        | 537 +++++++++++++++++++++++++++++++++++++++++
 10 files changed, 971 insertions(+), 117 deletions(-)

Range-diff versus v4:

 1:  82e26ff318 =  1:  6f74de2025 read-cache: split out function to drop unmerged entries to stage 0
 2:  93e6e7276c =  2:  673658d03c reset: drop `USE_THE_REPOSITORY_VARIABLE`
 3:  79c2877a65 =  3:  3a4745775a reset: rename `reset_head()`
 4:  9e67c7ee84 =  4:  d53df7446e reset: modernize flags passed to `reset_working_tree()`
 5:  4da39e7cec =  5:  2c06054013 reset: introduce dry-run mode
 6:  683897ac8d !  6:  b9f3438140 reset: introduce ability to skip updating HEAD
    @@ reset.c: int reset_working_tree(struct repository *r,
      	unsigned update_orig_head = opts->flags & RESET_WORKING_TREE_UPDATE_ORIG_HEAD;
      	unsigned dry_run = opts->flags & RESET_WORKING_TREE_DRY_RUN;
      	struct object_id *head = NULL, head_oid;
    +@@ reset.c: int reset_working_tree(struct repository *r,
    + 	if (opts->branch_msg && !opts->branch)
    + 		BUG("branch reflog message given without a branch");
    + 
    ++	if (update_orig_head && !update_head)
    ++		BUG("cannot update ORIG_HEAD without updating HEAD" );
    ++
    + 	if (!refs_only && !dry_run && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
    + 		ret = -1;
    + 		goto leave_reset_head;
     @@ reset.c: int reset_working_tree(struct repository *r,
      		oid = &head_oid;
      
 7:  2d70838562 =  7:  9e7af4b77b reset: allow the caller to specify the current HEAD object
 8:  ad56a2d370 =  8:  90b12199e8 reset: stop assuming that the caller passes in a clean index
 9:  b47f608e92 =  9:  a7e0e345be builtin/history: split handling of ref updates into two phases
10:  f39ec74b0f = 10:  93bc3d46a4 builtin/history: implement "drop" subcommand

---
base-commit: 1666c1265231b0bc5f613fbbf3f0a9896cdef76e
change-id: 20260601-b4-pks-history-drop-28f6c6399e7b

