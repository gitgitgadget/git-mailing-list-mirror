Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1D23ECBEE
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531702; cv=none; b=TL1378K67Kuh90WL19KRTNsIp9QfpBmtWdeFdRSnapHUebz2zANBl4zsnXGhSu/bFk4SQPEfI9iHUJvlDOeZPvHxEVlHA+W1dPu2AWPNJRfrICtTecWOAEmjncS6yud74xMCtIIO/ggOyZvA12l7Cu5Ksb53MGUd/OjPV/fta1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531702; c=relaxed/simple;
	bh=KnEGH00oCzhOZi6Au6JzKc9Xsq4/OLwvWLHGafWcag4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=FyXYJc/63yA0RALmpZDiXOfQgp8FZL1Z+hTLakZi3VWX3QUjP1EEulHJvMfb0yYk7eB49d9LwtgdSyQ7vtJqjMcu6l0FXj9StwHksg3k/icPy5OuJZVSrZ/AE7hIoYBCt4mHx0aAwJePfD9pif/mhlkLytXTATKz53MSxvZWywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CiNMDPm/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UtbAm3+S; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CiNMDPm/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UtbAm3+S"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id BACF4EC0216;
	Mon, 15 Jun 2026 09:54:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 15 Jun 2026 09:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531699;
	 x=1781618099; bh=GiCr/2M0qByDg7KFm8f0opTjJIZ5NbRQ00C8b93pglA=; b=
	CiNMDPm/BDn27RwJdJr+5fAfRXloQ3lAulnyq8df6NX+gUSXLLOdrMhaUtL63pIP
	0Hl9uK7s0Ag9NoUVbdtYDeWT4PCBKDT9VQ+E3yfyeIyFuCMoo6yOAX7V6DYaTOwp
	QbumJwO4SB/cll4NbTgN6lXsrHlQSyUojVAQJ6oVOCN7LaL1pIwtZggcsCR+i+f6
	kQ9IVKR9vhi5n4jdO56jOKw/2tu9p8BOcP7mxAm3+Jy8IYAhtWgWPA+YteBkrBCj
	+yL1IeTZ/SEPyDTzBiC/7MPSRc6kVpVNPrICk5d7pWOpRbh8MM2hymLZtah1QsDq
	7lxbSdWX7eW3vkkn9rZOCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531699; x=
	1781618099; bh=GiCr/2M0qByDg7KFm8f0opTjJIZ5NbRQ00C8b93pglA=; b=U
	tbAm3+SGybrcbzHnr38hejGBY8Hd0Q4Mu85lcY3VB+BjOT+oaQKgHM7z/0j0zqqk
	YLWRw6GeMGFYGWrJgHapXcX8iCJyTVOMLDsv4BQc8iy4H0NptcWqnJyDlmoZJ5DH
	NNqv7M+eKbdDWVwdQKpjJfQyx73o5qzuU0NTRxqmAZt/B9o8MSOJB3k9ied06iIv
	T5F74BC+kEss9VNa/ySi+Et9sccF7zqwzNdO66YWPccu9oWdc+5lG+j86G5LHEtG
	pMpwrB6Qn7trdIrINpN7wVbVAecGDRqjDSmVPcigXEfdPaNCQ+bOB1MP07QOfIHC
	u1jg4J1/TFhri85QlF/7Q==
X-ME-Sender: <xms:MwQwanwAH6TTeWiDhJ7tn93495fsixS33V33bR-awtU1JafjZsaTug>
    <xme:MwQwagzHkztdjFYVeFfHZSnpb5BVXKhfy88aEGCcdLt02ELTfFtVcUoa5E62kXsH4
    hbFsoLEVmU9c_YMmN8WLZY8u4tHPc0sElb64-UNl3LzedGhH6rBBg>
X-ME-Received: <xmr:MwQwahZF5j7CyuSFQCZldLZP0T7ZOEqJeFNLqXydKM9x_YooJvOZOOv1wn2zOrsdgEnnAMGSEXBbjgpcmTj1lMpaCu9t3kFCag6vk7LIuw>
X-ME-Proxy-Cause: dmFkZTGoz+BNglyOreqOJaP19p/YKWIbCPTSLKA+uptuA2NFXInVJQ4RQGtGRkqOVbr9z9
    0Ge2LiJlMELvkN1rgovtvPKRrm3JuuUJeHthWNgc5Znqn0A+xxHuM32eW/oz0AAHF/J+0d
    wtWxAneeVQ/2BvrDxDfPI4rLNf2ZlvyXaEIZk2KcSq0ZILTHZAe/GlMxaPWOQrMu518X/E
    3z6pURRrxDREgxUIlwEwlGFXVqEaIyqFK7NbzPzI3Plv5Aj16E3W5apOds0opdMUal4jyn
    BpBvllxTFLA95Fg4dZaGgOJ5MJJhlZisV6QYqxY3s8HroPxl2KXlq4faoMthB8TKTLDkNd
    zEPNXNxvqc6oqPvanaCYBLinGglaT7oWwgxghnkZJRCkVdFBLNM7zBRC5Pu45uNwiVWovJ
    /iDZmxs4nKaR7Ym2p/C1JBwH7MAyFhvP204tTYnSRdg78Gq5esnQSCEkgdDAvpFFAlLQSg
    VrLyNACR+9CCdWBsYjRVM35+uO055fswJQ9pR23TDLHeX2aYi9aiElrSZTaysIT9cIlnI/
    ChG2VoQrAn5GBxDTxjYGSk1qHyvCj3k2KG6H024R2F7W9M5lymTAxE8+lKc97FI1JteIHU
    Ls+g3rg5hl10bgK6Q5I8UHg3YCaD6K9VPJG45IxbIBI3dbx1bU12aAXKdIqg
X-ME-Proxy: <xmx:MwQwahWIYXL9XxYTBfTje2On2iN6X9ioJzYNwxr99p14_Vp1tNNsGg>
    <xmx:MwQwavgWX1NgW3b0_mNhLTDjS0HdtJKpUDJ9hQMzYlrC-8GngH39bw>
    <xmx:MwQwavvYMCJbBYNq_aXn7_RdHd5WwBP1DcPE9Q_qNoakRmNtA1AG7w>
    <xmx:MwQwao4_5Wup5dFh5DyjSnbuM_r-cH18iSXzuql3Tp7XpQChNCHUow>
    <xmx:MwQwaglzG06_6ymBZmrjw77qB3VkAnanA74J1LElULY19yw9FsNKaMy0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:54:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 70dc95e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:54:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 00/10] builtin/history: introduce "drop" subcommand
Date: Mon, 15 Jun 2026 15:54:50 +0200
Message-Id: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACoEMGoC/33QwU7EIBAG4FfZcBYDDAN0T76H8VBg6qJx28Daa
 DZ9d2E1pk2qxz/555uBKyuUExV2PFxZpjmVNJ5rMHcHFk79+Zl4ijUzJZQRRkjuNZ9eCz+lchn
 zJ495nLhygwkGuo6sZ3VyyjSkj5v6+PSdy7t/oXBpVGv8jN/WzrL1/t8wSy640UCgQIuI+FAr9
 +mNNX5WawD2AVUBq1Xw6FFaEzcArAG3D0AFnA69o3pGB3YD6BUgxT6g2wX19kH05ILaPgHXwB9
 /gBUAHQGtQsQu/ALLsnwBZsSapMkBAAA=
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

Range-diff versus v5:

 1:  e21a324987 =  1:  07dee893d7 read-cache: split out function to drop unmerged entries to stage 0
 2:  d16b3df944 =  2:  96f33165b8 reset: drop `USE_THE_REPOSITORY_VARIABLE`
 3:  b73224c4b0 =  3:  35f31792f3 reset: rename `reset_head()`
 4:  1b5fbaa9c2 =  4:  1837483676 reset: modernize flags passed to `reset_working_tree()`
 5:  a73fb4b3e8 =  5:  206b73f71e reset: introduce dry-run mode
 6:  3be3208155 !  6:  48c7b1571f reset: introduce ability to skip updating HEAD
    @@ reset.c: int reset_working_tree(struct repository *r,
      
      	if (refs_only) {
     -		if (!dry_run)
    -+		if (update_head)
    ++		if (!dry_run && update_head)
      			return update_refs(r, opts, oid, head);
      		return 0;
      	}
 7:  fb3a357d93 =  7:  d6a9a3e524 reset: allow the caller to specify the current HEAD object
 8:  9b883dbbad =  8:  d4bc3acd87 reset: stop assuming that the caller passes in a clean index
 9:  88a929e1a5 =  9:  493a3f4422 builtin/history: split handling of ref updates into two phases
10:  8f19defcb0 = 10:  184849df09 builtin/history: implement "drop" subcommand

---
base-commit: 1666c1265231b0bc5f613fbbf3f0a9896cdef76e
change-id: 20260601-b4-pks-history-drop-28f6c6399e7b

