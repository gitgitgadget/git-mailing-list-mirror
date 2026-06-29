Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0410133F59C
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718483; cv=none; b=E3qTtKkOVwZ15+aP28UZ0GlLi2HgsU0lgBdj+CjzVaT5TSRFybA9F4QzSjab+naQ/OBydK8umhZM9IAqT2QHzA6XqUsv9JO3GzmckK8g+RuVKFQq8wW8C2eso85Z/jjpGMIcX3iYfBApMr9JjbgRJYEZx+yCJ9hvbSA66O8voug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718483; c=relaxed/simple;
	bh=MfjtnyG+7KM2YseMXFZIxziOE7YJRj2qdWKg6rrI7F0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=DQOgKiZNCOcYBAl/Dt8nF0fsyBTmecqBlZOwRaBfCR3cApb5090Z7RqfnIDIYjRxy6h+i5LpfdkRIx9AFmDTEjEKWnMRjSuLPDp9Oofb2W8w/5sPlEOe9ukXVbCq72ZeL004Leaz/tFLwznA2MBLLgZCQydCb74GEuLhoQCDMv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=raYvy+4t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bo++/nSo; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="raYvy+4t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bo++/nSo"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7C8BB7A0090;
	Mon, 29 Jun 2026 03:34:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 29 Jun 2026 03:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782718474;
	 x=1782804874; bh=nNb30Zf2GRpyOvF3zWfzEyLDmNutdIDavi/aF7Ga9qA=; b=
	raYvy+4t4p3R1C6ZlDcG+HM+FJ0ZgbvqRljkaiC89D4sYxmAr150vLra9IWej4Jb
	c+9S2g1MRN58zwhrDjO8SvcdAjFrMmHPHMFtRS+OyBdZtAT6i/6WuBU3h6Fj9msp
	s/15jMyz6zdJdSwG+5TCysB5z6tRWCX6ste8W8OEOm4/Naexsx/zBvmPl9EFomZY
	TQUFhAoxlzrM9DEyKj41a9lTBSt+MnUBakaaCyQmAZOUdoqh8286Ns39Rxe3x9Ho
	ydAfNI4xewWezYKGc9C+/pBN8zqzpaNL1UZmasfeUMw3bb+9MsGOgI6C2NxxEHfT
	TR38cqjf0f1IKVq36i9LDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782718474; x=
	1782804874; bh=nNb30Zf2GRpyOvF3zWfzEyLDmNutdIDavi/aF7Ga9qA=; b=b
	o++/nSosPKMYj0+0GxQCSObHWbOGLZmSoV/fE3OYBet0k7Og2wY/0qUiflYbPf57
	hd5G2eLmoW1HO58hb0OfVm6oV+s4C/QrozZtpB8+/8vu1BaDgy1IoSt2akmGVtch
	7O+kHn5X6R3zYzKXLw14ZVQ+HHiHZus71chesKzzvXK0bo2olzSrtNZICU8R4kUE
	pGJo3O6j+sg3+T89vmwxbTw2gAjzAhHn4vFYWY23jsl3lj3VmtBGbpq0iXahWWfV
	w5Ha8Yw9z1pCZsSZXNFd3N++Krz2m3uvRcNaKAxwJYjvcr/gVyhIwYWk7aMTvSOv
	GJDUt9CV/ni5HWlZnCDsQ==
X-ME-Sender: <xms:CSBCalCqOuL8AoxNnyzfJ9npCHiMbauZOZbfES_rd7AqF0b2zCuo9g>
    <xme:CSBCas3Tq02g8q0xJMIU8lb1ZoX_Ne6fzRDvfWmHJZHp_6pMuMpsdHH-7VwI706Uq
    R4W6YjxSXLXi-KgqUrUJRE0MJu0NmUfEfBdtU3bfCLxiGditd2gAJA>
X-ME-Received: <xmr:CSBCan0r5d_VMNY_SL_EMhpdXvZvRl_bFJ7bohC3-WQxl-ygavcnqG8ov6bUgPP_kkA8hlCDog2sBTW5FYffWUFSghtX8Lu2cPudZqkL_05Y>
X-ME-Proxy-Cause: dmFkZTEFVijLjgVN8r4kCOoR8ty64JWPa4yxXHtLtMN8vE/aXmj5efeIFT15JixMmN6cQW
    wJi4bc0VOUcMtRKmsnffNsCrL+60oXaS2Qb3J6dfGlNtACW0XpMZ6jIJjXVImWLZBvcmiA
    O2xySmkjg454RFD6tVeZydb1PWuyrmmVWaKiBicEfqxGYpiUzBkhY0Q1kBZfzSroc6P7Cd
    Y4V91/Ol5tHtMs2d7/uk2em2bNRze1x6E0Jc+5y9CQeJBWwPYjC8tOq3wI7/Y4U9zNo/pY
    8aaw67RihZa6v3oOe9WGV6gdA8trNhWNEHBsSMBvxJj4O5udskE5gZbQuaLZTlzoRziFoT
    T8hPGfzKXVLr5G8IvPRZEHG/P1b+4gifelib0htxIBnjQhX2X/YqrcdaB4JYvaUZVHToVY
    Z2Sij3GlHd0js+RJW/q3tfDoajrxeN51zEaeFlahs4hx73z4+WKypotg0mU/XU8rjo7/x1
    wLs0dbBj4xOqY5pA60249z8JW3kQSA0JRzrHpXg+SDQk6hVWWvxeRVgkCaavgLZptmgFKo
    eF7PBpN5MFmNjhyIvfiXQqkIFH00wpk1IoyvEkCKJTh28ZIgm6cezX/ii6fkkTqf+TyoqL
    BsMZy5sA6i/7MTEOxO5pTiH+Nt0LC0B8PD0sNeQpdRFU6bFvhhKnMXrAXlFA
X-ME-Proxy: <xmx:CSBCahDxEUY6qwe7gTos2KGkCs-aF5ONSQfW___pO8lwpigvfOEyEQ>
    <xmx:CSBCam56AB0dV8c_PbOoQZM7qW0MdYkeJZSXjJFsJ-7HOXce8WFhNw>
    <xmx:CSBCaiL5aAc1ojOKdlPtrj-OM81C_6af6jiBJd_COPZBc8yLdyVn_A>
    <xmx:CSBCant7Ioq91I-Rd_YfYIUTObFz3hwbJxDu3JJR9KdN6dyM4GE8sg>
    <xmx:CiBCavdcGCQ1ptKjPecRklVLdzdyN8Lf4d7-W7BYR4Ri09Z94OT5QaQ7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:34:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1f57cd82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 07:34:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v7 00/11] builtin/history: introduce "drop" subcommand
Date: Mon, 29 Jun 2026 09:34:26 +0200
Message-Id: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAMgQmoC/33QzU7DMAwH8FeZciYojeMk3Yn3QBzaxGUBsVbJq
 EBT3x1nINRKhaOlv3/+uIpCOVERx8NVZJpTSeOZC3d3EOHUnZ9Jpsi10EpbZVUjeyOn1yJPqVz
 G/CljHiep/WCDhbYl1wvunDIN6eOmPj591+W9f6FwqVRN/LTfxs5Nzf0/YW6kktYAgQajIuIDR
 +7Tm6j8rNcA7AOaAWd06LHHxtm4AWAN+H0AGPAmdJ54jRbcBjAroFH7gKkb8O6D6sgHvT0B18A
 fP0AGwERApxGxDRvArgHcBywDml/YEoKNzv8Cy7J8AdeApPkKAgAA
X-Change-ID: 20260601-b4-pks-history-drop-28f6c6399e7b
In-Reply-To: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
References: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

Hi,

this small patch series introduces the new "drop" subcommand for
git-history(1). As a reader might guess, the command does exactly that:
given a commit, it will drop that commit from the commit history and
replay descendant branches on top of it.

Changes in v7:
  - Expose `replay_result_queue_update()` so that we don't have to
    duplicate its functionality.
  - Add missing SOB.
  - Link to v6: https://patch.msgid.link/20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im

Changes in v6:
  - Fix bad interactions of DRY_RUN with UPDATE_HEAD
  - Link to v5: https://patch.msgid.link/20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im

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
Patrick Steinhardt (11):
      read-cache: split out function to drop unmerged entries to stage 0
      reset: drop `USE_THE_REPOSITORY_VARIABLE`
      reset: rename `reset_head()`
      reset: modernize flags passed to `reset_working_tree()`
      reset: introduce dry-run mode
      reset: introduce ability to skip updating HEAD
      reset: allow the caller to specify the current HEAD object
      reset: stop assuming that the caller passes in a clean index
      replay: expose `replay_result_queue_update()`
      builtin/history: split handling of ref updates into two phases
      builtin/history: implement "drop" subcommand

 Documentation/git-history.adoc |  38 ++-
 builtin/history.c              | 286 +++++++++++++++++++---
 builtin/rebase.c               |  41 ++--
 read-cache-ll.h                |   1 +
 read-cache.c                   |  12 +-
 replay.c                       |   8 +-
 replay.h                       |   5 +
 reset.c                        | 102 +++++---
 reset.h                        |  51 ++--
 sequencer.c                    |  17 +-
 t/meson.build                  |   1 +
 t/t3454-history-drop.sh        | 537 +++++++++++++++++++++++++++++++++++++++++
 12 files changed, 978 insertions(+), 121 deletions(-)

Range-diff versus v6:

 1:  61c6eb1bdc =  1:  640b51b963 read-cache: split out function to drop unmerged entries to stage 0
 2:  50a61da426 =  2:  485dee2858 reset: drop `USE_THE_REPOSITORY_VARIABLE`
 3:  96ffa9d2a6 !  3:  fd82a0b592 reset: rename `reset_head()`
    @@ Commit message
         subsequent commit.
     
         Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/rebase.c ##
     @@ builtin/rebase.c: static int finish_rebase(struct rebase_options *opts)
 4:  874c3ecd59 =  4:  7fe6db0459 reset: modernize flags passed to `reset_working_tree()`
 5:  bba2845f2d =  5:  b0fba42b75 reset: introduce dry-run mode
 6:  ada93af1da =  6:  db635dbea4 reset: introduce ability to skip updating HEAD
 7:  3cf1dcf549 =  7:  5422a99683 reset: allow the caller to specify the current HEAD object
 8:  ff28ad814c =  8:  a264b72376 reset: stop assuming that the caller passes in a clean index
 -:  ---------- >  9:  8060e462d1 replay: expose `replay_result_queue_update()`
 9:  7b048d5a16 ! 10:  7233b48732 builtin/history: split handling of ref updates into two phases
    @@ builtin/history.c: static int handle_reference_updates(struct rev_info *revs,
      		    !detached_head)
      			continue;
      
    -+		ALLOC_GROW(result->updates, result->updates_nr + 1, result->updates_alloc);
    -+		result->updates[result->updates_nr].refname = xstrdup(decoration->name);
    -+		result->updates[result->updates_nr].old_oid = original->object.oid;
    -+		result->updates[result->updates_nr].new_oid = rewritten->object.oid;
    -+		result->updates_nr++;
    ++		replay_result_queue_update(result, decoration->name,
    ++					   &original->object.oid,
    ++					   &rewritten->object.oid);
     +	}
     +
     +	return 0;
10:  7389e0432a = 11:  61668ea59a builtin/history: implement "drop" subcommand

---
base-commit: 1666c1265231b0bc5f613fbbf3f0a9896cdef76e
change-id: 20260601-b4-pks-history-drop-28f6c6399e7b

