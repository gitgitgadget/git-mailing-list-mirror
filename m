Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57B83A7F4E
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503249; cv=none; b=oydo08g4b5bafYteMYFD+shkZsjBCTE/ciufn5OmGj5UV8FHYBwKiMA7Gi8xSi+5TYtRMFZcMfch4LGDvxM9EW+LK2w64jiMcsF2AqlBM6CxJ8GDJ6ovfbTAos6iAFtBRkfKioeTW370IQ5tgHqUbd6KrITouYOK7TDlb/IqPvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503249; c=relaxed/simple;
	bh=lDFZD5lSxe9ZBA+ckZhon7R4WN/0KSyebPXM2/7UH8c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Ko7K4oGpTB88bA9E6RL2OpnoO6pex8EIaQ4NMop4qZFX9P7NdBa963/lmtrjTD3a9VLTNNtDQG95kqGEokRTyqUMgpInjVDhwZx9yyJCP8LgImyjzK1fnek9rx5Su96LrOKH2/2A0WaEx6StNiTuu6geQKzSGqe4u83dB1DeX8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OExAm0+8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pp7Sj5MJ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OExAm0+8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pp7Sj5MJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 30BB27A005A;
	Wed,  3 Jun 2026 12:14:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 03 Jun 2026 12:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780503246;
	 x=1780589646; bh=J2fZ3ZV6Fa3BD06el7oNJfcZhuanvW8jvjyezsZMdHk=; b=
	OExAm0+8LJthbzvFe2XJUUoz1iw3rtIFJIhX/71drWP3COe5Efo8YFx76AhNqcFt
	p0ZLhGAEvG1j0dyhqKiCQa8vRNeLh1Ag1Kpbu53YUpY/h0J4cuzxYOJf51Mzfjbk
	OBGAa2cGZjdgpcyDGs/nZOB0Ku1u28JWm0koaw3Imn/GveOwFJfOdQRTTtaBjYxq
	fUooBPV2ouko7Urfd40DzRN8W1lF2EBMXgNTYfoB+XzKEiD5qhI4F8SgW6UgGjIs
	/+3hMJinjpUtjflUfwYiXNUZXdb9rdc6+PiZPidlZIN6ZyO8ZeSAZ5F2zkjmQMQk
	8BKRg1dHPrLjb8HCd+XQ6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780503246; x=
	1780589646; bh=J2fZ3ZV6Fa3BD06el7oNJfcZhuanvW8jvjyezsZMdHk=; b=P
	p7Sj5MJPC9me4qzKhmYgHehaK3XlWAHmv+kbp+8es4Gpk95Qursrf2MmgcBDf6V8
	xocSIKaiF2FzfcAI8hiLbeclNzKzQMMuZjYw0WuWAvOSPyD1mctJa93Euyyv1zJK
	1EokcvUGb9C0MtbNlBa3bOxLrqxVbh1ftrAoCwP3+tVvEYeEYX39ahKR24FqbVSY
	07ER1XD1dyTu/62oOwwatw/SZDDE1BFa0NmUGVOk4lXbm9EcED0UvflwdKWeDbRH
	N8lVTiP28/iGQ6aIJZO9oC34d3e7KG8PfWAtiaMVeBauTzhyi/1iN7Ntf1jt2yo/
	WoUZx+dE7Mpk+MLLvU/5A==
X-ME-Sender: <xms:zlIgao-q40MnloxlgFcR-5Qnq8ecbY0dvU1Ja7FNCLjCXHm_JolnZQ>
    <xme:zlIgaoIQ0mLYgnNvHW7Mk8PjZ99PsrSVGoEogP-a16oKBhgF8pQWU_2n7kO0ltRHQ
    EZ2wWVv1wUiVcnGHLmEyzgacegls5oznhkdcAvZ30Rsc73Pa3tc5g>
X-ME-Received: <xmr:zlIgarbbm_aEPecqKH0szZGn1wE2K9gRn7LFVKhYx96cODf5Sc5L8hhkAiOQPqaupw483zdlKj6ebxu8cFFC6c6j9Ei0L0xo-XRP2H-qCl1I>
X-ME-Proxy-Cause: dmFkZTF5Fm/uutrKwb8H6TXTHyp37FEKJFThv9TvLtgA+o5pIcpVBfAii7ZF7m4LpuLCGE
    WxoNBjTg2AkKg9Qteorktl/OlLZulRa6ycv5E8jM14t7ie9NtidnNknYbaN6eTlblGyREG
    OcD1ofqY1dqXHLh7CQoYIUEQ+FKsUPawmkwDF/Of7evqO3VAzHtQtPzm3rJspMycqN4Huv
    Dp+kWy+XRadJuJjLum+EGDS7uzMpwCUIGGr51i9OsORG3H8u7eddCVpV+pneZqgo9alh14
    1Sp0entJF7bbS4YAiBm+DJNrroOBog7BgALOaS+oX4yXgMJ+v/ddIpB59pkmqxOvqdscGt
    r2RAArzQoBx5YJqiUeEmCk/bilC9smQTdjKiHudd0qgMmO0wuW0NuhSDYeoHVbL2POhyyj
    ROlL9G9Gi08v9dpjMgI3hB7AV7cCJ65qbOoL4RBo3S50v9K+2aQfmCW6RBzgsCA24Oa42O
    aQSckgwC1vacTsYbIiRXeoc1P+4M5bbBeitYZFYzSbG58SVxT9e1KJtCXHJ2NhDNO8CUcT
    vTLQtUa6Mim7+0EWD1Na4f2XLFT7FnpXJFUKKd6uXN7Y0FUDhwCE+qKz+8UlGkwYfZiSEn
    peruPxE+TuW4vxSkzADOAjzYxPlXMgu9IfI0UXsmyskfwnyS/WnMgSRyKQ8A
X-ME-Proxy: <xmx:zlIgaiKUVFBGZi7Av61hbV-0WVYhdNR-aMQGASeSeK_mIhSdJGbALA>
    <xmx:zlIgahAa06bYcsPwG4mnJJ5fgn4DxP36udFwk8LovgKParTkSLYHUQ>
    <xmx:zlIgavr5naLV5EHU8JWa0pempO0nJJ8N8lCL5vv_gzXbsj0QttemEg>
    <xmx:zlIgakgVJdiwuxKh9E8InlCR5qA1XyHXWkzUwxcIqklO1GuUdGAQmQ>
    <xmx:zlIgakKxRgRRFollcnLyzX2XzVGaolApBHw-d_zfzJ1twE2Qu5OounzB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 12:14:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c5bac1f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 16:14:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/9] builtin/history: introduce "drop" subcommand
Date: Wed, 03 Jun 2026 18:13:59 +0200
Message-Id: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMdSIGoC/32NQQ6CMBBFr0Jm7ZjSliqsvIdhYWGQ0QikxUZDe
 ncLunb5kvffX8CTY/JQZQs4Cux5HBLIXQZNfxmuhNwmBimkEUbkaDVOd489+3l0b2zdOKE8dqY
 xqizpYCEtJ0cdv7bquf6yf9obNfOaWo3ffLsN+er9fwg5CjRakZJKi7YoTknZ8wPqGOMH/jgZl
 sUAAAA=
X-Change-ID: 20260601-b4-pks-history-drop-28f6c6399e7b
In-Reply-To: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
References: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

this small patch series introduces the new "drop" subcommand for
git-history(1). As a reader might guess, the command does exactly that:
given a commit, it will drop that commit from the commit history and
replay descendant branches on top of it.

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
Patrick Steinhardt (9):
      read-cache: split out function to drop unmerged entries to stage 0
      reset: drop `USE_THE_REPOSITORY_VARIABLE`
      reset: modernize flags passed to `reset_head()`
      reset: introduce dry-run mode
      reset: introduce ability to skip reference updates
      reset: allow the caller to specify the current HEAD object
      reset: stop assuming that the caller passes in a clean index
      builtin/history: split handling of ref updates into two phases
      builtin/history: implement "drop" subcommand

 Documentation/git-history.adoc |  38 ++-
 builtin/history.c              | 289 ++++++++++++++++++++---
 builtin/rebase.c               |   2 +-
 read-cache-ll.h                |   1 +
 read-cache.c                   |  12 +-
 reset.c                        |  91 +++++---
 reset.h                        |  44 +++-
 sequencer.c                    |   2 +-
 t/meson.build                  |   1 +
 t/t3454-history-drop.sh        | 513 +++++++++++++++++++++++++++++++++++++++++
 10 files changed, 905 insertions(+), 88 deletions(-)

Range-diff versus v1:

 -:  ---------- >  1:  d6e4f3193d read-cache: split out function to drop unmerged entries to stage 0
 -:  ---------- >  2:  2eef3d77e4 reset: drop `USE_THE_REPOSITORY_VARIABLE`
 -:  ---------- >  3:  cbfd105ca3 reset: modernize flags passed to `reset_head()`
 -:  ---------- >  4:  bbb7f3c61c reset: introduce dry-run mode
 -:  ---------- >  5:  b3d036cea1 reset: introduce ability to skip reference updates
 -:  ---------- >  6:  7df1787049 reset: allow the caller to specify the current HEAD object
 -:  ---------- >  7:  f58254bbb8 reset: stop assuming that the caller passes in a clean index
 1:  2a4b683b8c =  8:  9dee781f0a builtin/history: split handling of ref updates into two phases
 2:  02712e70d3 !  9:  2b4e4075e6 builtin/history: implement "drop" subcommand
    @@ Documentation/git-history.adoc: The staged addition of `unrelated.txt` has been
     
      ## builtin/history.c ##
     @@
    + #include "read-cache.h"
    + #include "refs.h"
    + #include "replay.h"
    ++#include "reset.h"
    + #include "revision.h"
      #include "sequencer.h"
      #include "strvec.h"
      #include "tree.h"
    @@ builtin/history.c: static int cmd_history_split(int argc,
     +			   const struct commit *new_head,
     +			   bool dry_run)
     +{
    -+	struct index_state index = INDEX_STATE_INIT(repo);
    -+	struct unpack_trees_options opts = { 0 };
    -+	struct lock_file lock = LOCK_INIT;
    -+	struct tree_desc desc[2] = { 0 };
    -+	char *desc_buf[2] = { 0 };
    -+	int ret;
    -+
    -+	if (!dry_run &&
    -+	    repo_hold_locked_index(repo, &lock, LOCK_REPORT_ON_ERROR) < 0)
    -+		return -1;
    -+
    -+	if (read_index_from(&index, repo->index_file, repo->gitdir) < 0) {
    -+		ret = error(_("unable to read index"));
    -+		goto out;
    -+	}
    -+
    -+	setup_unpack_trees_porcelain(&opts, "history drop");
    -+	opts.head_idx = 1;
    -+	opts.src_index = &index;
    -+	opts.dst_index = &index;
    -+	opts.fn = twoway_merge;
    -+	opts.merge = 1;
    -+	opts.update = !dry_run;
    -+	opts.dry_run = dry_run;
    -+	opts.preserve_ignored = 0;
    -+	init_checkout_metadata(&opts.meta, NULL, &new_head->object.oid, NULL);
    -+
    -+	desc_buf[0] = fill_tree_descriptor(repo, &desc[0], &old_head->object.oid);
    -+	desc_buf[1] = fill_tree_descriptor(repo, &desc[1], &new_head->object.oid);
    -+
    -+	if (unpack_trees(2, desc, &opts)) {
    -+		ret = -1;
    -+		goto out;
    -+	}
    -+
    -+	if (!dry_run) {
    -+		cache_tree_free(&index.cache_tree);
    -+
    -+		if (write_locked_index(&index, &lock, COMMIT_LOCK)) {
    -+			ret = error(_("could not write index"));
    -+			goto out;
    -+		}
    -+	}
    -+
    -+	ret = 0;
    -+
    -+out:
    -+	clear_unpack_trees_porcelain(&opts);
    -+	rollback_lock_file(&lock);
    -+	release_index(&index);
    -+	free(desc_buf[0]);
    -+	free(desc_buf[1]);
    -+	return ret;
    ++	struct reset_head_opts opts = {
    ++		.oid_from = &old_head->object.oid,
    ++		.oid = &new_head->object.oid,
    ++		.flags = RESET_HEAD_SKIP_REF_UPDATES,
    ++	};
    ++	if (dry_run)
    ++		opts.flags |= RESET_HEAD_DRY_RUN;
    ++	return reset_head(repo, &opts);
     +}
     +
     +static int find_head_tree_change(struct repository *repo,
    @@ builtin/history.c: static int cmd_history_split(int argc,
     +			    argv[0]);
     +		goto out;
     +	} else if (original->parents->next) {
    -+		ret = error(_("cannot drop merge commit"));
    ++		ret = error(_("cannot drop merge commit: %s"), argv[0]);
     +		goto out;
     +	}
     +
    @@ builtin/history.c: static int cmd_history_split(int argc,
     +	}
     +
     +	if (head_moves && update_worktree(repo, old_head, new_head, false) < 0) {
    -+		ret = error(_("failed to update working tree; "
    -+			      "run `git checkout HEAD` to sync"));
    ++		ret = error(_("could not update working tree to new commit %s"),
    ++			    oid_to_hex(&new_head->object.oid));
     +		goto out;
     +	}
     +
    @@ t/t3454-history-drop.sh (new)
     +
     +expect_graph () {
     +	cat >expect &&
    -+	lib_test_cmp_graph --graph --format=%s "$@"
    ++	lib_test_cmp_graph --format=%s "$@"
     +}
     +
     +expect_log () {

---
base-commit: 1666c1265231b0bc5f613fbbf3f0a9896cdef76e
change-id: 20260601-b4-pks-history-drop-28f6c6399e7b

