Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EAD29AB11
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749375; cv=none; b=rHAWLUI+5XODYZovKGv7r5+jx/k/Ydf9/e+SnW5our17oQHEFejAx8k2Wfmv3p/shTdEzN/Hts3TOfyK65mHJiAaje6V2ADzm3SwLzv4tSrEwt+t9dYXVLQJs3uug9x2ou7vD6ZMDZ0DcnSnHPuBraEnIE4HtWrgHcvgaGrXb2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749375; c=relaxed/simple;
	bh=siQiQKAwkGp1Q3ClkZjrFiMEJHwkKW3h/svau7DcmIg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=khZYkSadHgq062AXLm03m8sNh6O4mS7q+VmohI0fWxePDnF48WEq4TvZaD0gZXS/mfnbyWWHr+PxfeUTRC19kLEtLLNfqjB28yRxMnWyuo8cKklcJWX3eXC8XQOCRnJaLg0kiy9ZANqHMuryKOpnDYd6efvTJoH9Mu3cJHW0cFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LpumQhLD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fbIPL/+p; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LpumQhLD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fbIPL/+p"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6CD317A021E
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 17 Jul 2025 06:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1752749371; x=1752835771; bh=mbPjY+Tovx
	Uk6RFPsB0UiRPTGnRrYs8bGHVxmqGh5UQ=; b=LpumQhLDf7NINqiynlNLqsGMqc
	fbae8Ken1HoTTBVsfMMGsg89Yiv9n7vYMDYwvD/kat4zmvdrYioS0oWe81LmxZoW
	jaTqlfejJ3UIT1V3Btb6cryQhRsYvaNQD1G7t6vHnkqrPjzNwwzr1Pt3MYlk/9Hj
	elA0P9kr/Q08DM07Zc+Kk9TcMYYduNZCbdAxjnpOQ4jAFGN0fMo66iRLjIMcRgt1
	sxjyTzPzTS7PjBNEfp7vURTmQ/ci+3dQmg6NlgCJOUPA7ssmzFatCyGS+SkmQky4
	xKq0CRzlCYaelSQOAMUdrWXGuV0U4E/vb/+axDCCycG1cZJ7wbcrL1hwm23Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1752749371; x=1752835771; bh=mbPjY+TovxUk6RFPsB0UiRPTGnRr
	Ys8bGHVxmqGh5UQ=; b=fbIPL/+ptd30QIqey/s96XjZfy1UvKgnuyMWSRzIf0y7
	0ORHyF0r7BVk/8NpDImuHDZl9xRsgnV0X/Rh6F54YQHkzt4TptqgUzRgQxIWKjza
	sov+rEvEcJ1dCuU9XXgiysZXHr86+Cqcrc0K4GaXwA2oD3mtAP427suzdeqIgkRS
	cCzm70uZYwhz2F1vXqoMOES6JUdch+VZKedxXHdWU9wYrPMhme4mJWqzY4L2L/k0
	hALJVyy7rpU70/4wKEIsx1ZxIFIPrASYaEkOiuePvXA6WaD9G36CYXAIwLt/sdUQ
	03hsIKo18eFNgg00P9MnaAhQS9xONko9it2Uc3cZzg==
X-ME-Sender: <xms:O9V4aIHFVoTRrw1s0lCwg5jkTXQ48OcvzTuakpLrub7DLWRSbvv54w>
    <xme:O9V4aDVpcrv2f-PXJn37ie5nSnAL_jHlgLKxdBJvENtO8aOK05WS21si6NZ5ILh2W
    _IBBxsg6_cwaUGsig>
X-ME-Received: <xmr:O9V4aLjqjfW1rnJ4WTp4v6t2YOa9SXA7CUUpK2q_TUhJ4yX7RVoLbIdBQlodmPxHapxnRkUnCakJkX6eMwYICbZiQNewOws2K5Eg8XBmFAtD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgffvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevueegkedtteeigeejueehuedugfevleefveehue
    ehgfetffffvefhuefhueekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:O9V4aMQ1E6HcMe4QMplH_9F4LD2elPL30rNfcTY4TWiyOxTAkrDrag>
    <xmx:O9V4aGHp1iE8SDniIchZzzwc-pExIdkmGkYO92vZ6s3pcKlcVhEO_w>
    <xmx:O9V4aMmNmdDTE0zeWAkzDu9efpKHsUl2IP5iiUBU8wK51Te1K-RlYg>
    <xmx:O9V4aB2Uo6KbwmD-7IDkHiox87NF4WHa89B93L8tl-yGnftDN4o-uw>
    <xmx:O9V4aLNTR7turFWyPTRS_R1-K_Yl0mAfZjs1nMnBFo6DGYHPRHNSpzOq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:49:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 30a770cf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:49:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/21] config: remove use of `the_repository`
Date: Thu, 17 Jul 2025 12:49:20 +0200
Message-Id: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADHVeGgC/x3MwQqDMAwA0F+RnA3Yom7dr8gOoqmGQVMScYr47
 ys7vsu7wEiZDF7VBUo7G0sqcHUF0zqmhZDnYvCN75qH6zF/DCdJkRf8Cm4roVIW4030RO9mCu0
 zxNB3UIqsFPn498P7vn+67OgFbgAAAA==
X-Change-ID: 20250716-pks-config-wo-the-repository-21de9489f965
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this patch series removes uses of `the_repository` in "config.c". It
does this via two things:

  - By removing all the wrapper functions `git_config_get()` et al that
    implicitly rely on `the_repository`.

  - By moving the Git-specific config parsing (that is, the non-business
    logic like parsing "core.sharedRepository") into "environment.c".

This series is inspired by my painful tries yesterday to start parsing
repo settings early in the Git process lifecycle. The changes should
make it easier to eventually achieve that.

The patch series is long, but almost all of the patches are trivial as
they simply replace code like `git_config_foo(...)` with its equivalent
`repo_config_foo(the_repository, ...)`.

The series is based on top of 90c0775e972 (The eleventh batch,
2025-07-16) with bc/use-sha256-by-default-in-3.0 at c79bb70a2e7 (Enable
SHA-256 by default in breaking changes mode, 2025-07-01) merged into it
to fix a conflict with "next". There are a couple of merge conflicts
with "seen", but they are trivial to solve.

Thanks!

Patrick

---
Patrick Steinhardt (21):
      config: drop `git_config()` wrapper
      config: drop `git_config_clear()` wrapper
      config: drop `git_config_get()` wrapper
      config: drop `git_config_get_value()` wrapper
      config: drop `git_config_get_value()` wrapper
      config: drop `git_config_get_string_multi()` wrapper
      config: drop `git_config_get_string()` wrapper
      config: drop `git_config_get_string()` wrapper
      config: drop `git_config_get_int()` wrapper
      config: drop `git_config_get_ulong()` wrapper
      config: drop `git_config_get_bool()` wrapper
      config: drop `git_config_set_in_file()` wrapper
      config: drop `git_config_set_gently()` wrapper
      config: drop `git_config_set()` wrapper
      config: drop `git_config_set_in_file_gently()` wrapper
      config: drop `git_config_set_multivar_in_file_gently()` wrapper
      config: drop `git_config_get_multivar_gently()` wrapper
      config: drop `git_config_set_multivar()` wrapper
      config: remove unused `the_repository` wrappers
      config: move Git config parsing into "environment.c"
      config: fix sign comparison warnings

 Documentation/user-manual.adoc                 |   2 +-
 apply.c                                        |   6 +-
 archive-tar.c                                  |   2 +-
 archive-zip.c                                  |   2 +-
 archive.c                                      |   4 +-
 branch.c                                       |  10 +-
 builtin/add.c                                  |   1 +
 builtin/am.c                                   |  10 +-
 builtin/blame.c                                |   2 +-
 builtin/branch.c                               |   8 +-
 builtin/cat-file.c                             |   2 +-
 builtin/check-attr.c                           |   2 +-
 builtin/check-ignore.c                         |   3 +-
 builtin/check-mailmap.c                        |   3 +-
 builtin/checkout--worker.c                     |   3 +-
 builtin/checkout-index.c                       |   1 +
 builtin/checkout.c                             |   4 +-
 builtin/clean.c                                |   3 +-
 builtin/clone.c                                |  26 +-
 builtin/column.c                               |   4 +-
 builtin/commit-graph.c                         |   5 +-
 builtin/commit-tree.c                          |   3 +-
 builtin/commit.c                               |   4 +-
 builtin/config.c                               |  60 +--
 builtin/count-objects.c                        |   3 +-
 builtin/credential-cache--daemon.c             |   2 +-
 builtin/credential-store.c                     |   2 +-
 builtin/credential.c                           |   3 +-
 builtin/describe.c                             |   2 +-
 builtin/diff-files.c                           |   2 +-
 builtin/diff-index.c                           |   2 +-
 builtin/diff-tree.c                            |   2 +-
 builtin/diff.c                                 |   2 +-
 builtin/fast-export.c                          |   3 +-
 builtin/fast-import.c                          |  12 +-
 builtin/fetch.c                                |  10 +-
 builtin/fmt-merge-msg.c                        |   2 +-
 builtin/for-each-ref.c                         |   1 +
 builtin/fsck.c                                 |   2 +-
 builtin/fsmonitor--daemon.c                    |   3 +-
 builtin/gc.c                                   |  70 ++--
 builtin/grep.c                                 |   5 +-
 builtin/hash-object.c                          |   3 +-
 builtin/help.c                                 |   5 +-
 builtin/hook.c                                 |   3 +-
 builtin/index-pack.c                           |   2 +-
 builtin/interpret-trailers.c                   |   3 +-
 builtin/log.c                                  |  24 +-
 builtin/ls-files.c                             |   1 +
 builtin/ls-tree.c                              |   3 +-
 builtin/merge-base.c                           |   3 +-
 builtin/merge-file.c                           |   2 +-
 builtin/merge-tree.c                           |   3 +-
 builtin/merge.c                                |   2 +-
 builtin/mktag.c                                |   2 +-
 builtin/multi-pack-index.c                     |   5 +-
 builtin/mv.c                                   |   2 +-
 builtin/name-rev.c                             |   2 +-
 builtin/notes.c                                |   4 +-
 builtin/pack-objects.c                         |   2 +-
 builtin/pack-refs.c                            |   1 +
 builtin/patch-id.c                             |   3 +-
 builtin/pull.c                                 |   9 +-
 builtin/push.c                                 |   2 +-
 builtin/range-diff.c                           |   2 +-
 builtin/read-tree.c                            |   3 +-
 builtin/rebase.c                               |   4 +-
 builtin/receive-pack.c                         |   2 +-
 builtin/reflog.c                               |   2 +-
 builtin/refs.c                                 |   2 +-
 builtin/remote.c                               |  56 +--
 builtin/repack.c                               |   2 +-
 builtin/replace.c                              |   3 +-
 builtin/rerere.c                               |   2 +-
 builtin/reset.c                                |   2 +-
 builtin/rev-list.c                             |   2 +-
 builtin/rev-parse.c                            |   4 +-
 builtin/rm.c                                   |   3 +-
 builtin/send-pack.c                            |   1 +
 builtin/shortlog.c                             |   2 +-
 builtin/show-branch.c                          |   2 +-
 builtin/show-ref.c                             |   3 +-
 builtin/sparse-checkout.c                      |   2 +-
 builtin/stash.c                                |   4 +-
 builtin/stripspace.c                           |   2 +-
 builtin/submodule--helper.c                    |  56 +--
 builtin/symbolic-ref.c                         |   3 +-
 builtin/tag.c                                  |   2 +-
 builtin/unpack-file.c                          |   3 +-
 builtin/unpack-objects.c                       |   2 +-
 builtin/update-index.c                         |   2 +-
 builtin/update-ref.c                           |   3 +-
 builtin/update-server-info.c                   |   1 +
 builtin/var.c                                  |   5 +-
 builtin/verify-commit.c                        |   1 +
 builtin/verify-pack.c                          |   3 +-
 builtin/verify-tag.c                           |   1 +
 builtin/worktree.c                             |   8 +-
 builtin/write-tree.c                           |   3 +-
 checkout.c                                     |   2 +-
 commit-graph.c                                 |   1 +
 compat/precompose_utf8.c                       |   6 +-
 config.c                                       | 546 +------------------------
 config.h                                       | 139 -------
 connect.c                                      |   6 +-
 contrib/coccinelle/config_fn_ctx.pending.cocci |   2 +-
 convert.c                                      |   2 +-
 daemon.c                                       |   2 +-
 dir.c                                          |   4 +-
 editor.c                                       |   2 +-
 environment.c                                  | 512 +++++++++++++++++++++++
 environment.h                                  |   3 +
 fetch-pack.c                                   |  16 +-
 fsck.c                                         |   1 +
 fsck.h                                         |   2 +-
 fsmonitor.c                                    |   2 +-
 gpg-interface.c                                |   2 +-
 help.c                                         |   6 +-
 http-backend.c                                 |   6 +-
 http-fetch.c                                   |   3 +-
 http.c                                         |   3 +-
 imap-send.c                                    |   3 +-
 list-objects-filter-options.c                  |   6 +-
 ls-refs.c                                      |   2 +-
 mailinfo.c                                     |   1 +
 merge-ll.c                                     |   2 +-
 merge-ort.c                                    |  18 +-
 notes-utils.c                                  |   2 +-
 notes.c                                        |   2 +-
 parallel-checkout.c                            |   4 +-
 pretty.c                                       |   2 +-
 promisor-remote.c                              |   8 +-
 protocol.c                                     |   2 +-
 reachable.c                                    |   2 +-
 read-cache.c                                   |   4 +-
 rebase-interactive.c                           |   2 +-
 reflog.c                                       |   1 +
 refs.c                                         |   2 +-
 refs/packed-backend.c                          |   2 +-
 refs/reftable-backend.c                        |   2 +-
 remote.c                                       |   2 +-
 rerere.c                                       |   9 +-
 revision.c                                     |   2 +-
 run-command.c                                  |   6 +-
 scalar.c                                       |  18 +-
 sequencer.c                                    |  36 +-
 setup.c                                        |  44 +-
 sideband.c                                     |   6 +-
 submodule-config.c                             |   2 +-
 submodule.c                                    |   2 +-
 t/helper/test-advise.c                         |   3 +-
 t/helper/test-config.c                         |  20 +-
 t/helper/test-read-cache.c                     |   3 +-
 t/helper/test-userdiff.c                       |   2 +-
 t/t4256/1/mailinfo.c                           |   2 +-
 t/t4256/1/mailinfo.c.orig                      |   2 +-
 trailer.c                                      |   4 +-
 transport.c                                    |  12 +-
 versioncmp.c                                   |   4 +-
 worktree.c                                     |   8 +-
 xdiff-interface.c                              |   1 +
 161 files changed, 1009 insertions(+), 1096 deletions(-)


---
base-commit: 592f97530d99d182d69c66e08279e189d006b410
change-id: 20250716-pks-config-wo-the-repository-21de9489f965

