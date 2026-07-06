Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D713749E2
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344438; cv=none; b=mGIlWbJ5FyOaYM7VMb6zPirDUp8RO6dNxO7DfftwZkfnjHGRpCrAwulIBYxYfdbq8H37MRfHsY3wdAAvblbWbLxmZbTmmDiZZyctu/pGzdgbltPWj4mjpL1N5BZE/DiIc3+Xz+4Cbn183BRQKvey+aQFX93F2MrXOIiAi9pfxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344438; c=relaxed/simple;
	bh=+2e4xfc1qwftTSZJGt98aqjmXcmGxpLUp9Sd10HQqLI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=duCrLuevxrUvaRV/S0u2yEt9jzds1TMDVI75iMSRz7xDhTAiEjM8Qf41pekPAksP//28FKZSa4+OHPZfsjGNFq6DjG6GMoAkkbKxLjNx9iFHoi56Zntgo2eFIxxAwazA1rRXG22cEAd7T3m+RtnaQ2iXMA5ikOdwVmmP8YFk3iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g7QgGdC8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H05b0KzC; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g7QgGdC8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H05b0KzC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 549471D000CF;
	Mon,  6 Jul 2026 09:27:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jul 2026 09:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783344432;
	 x=1783430832; bh=arKbsIHMlFjE6M55G66cI0sfTqdg9TW2vZrtc2BXDoI=; b=
	g7QgGdC8eh8Su/jHneFSpqSL6HTMrsyygCi+rvPZu5rJcWCtnhzFq5Y+djoJDnHl
	m4IubJEDCkaNAjHp2M8sBudjGPcPaHB9rD8k2yJo+ijiq4pDtNHqzIHFtY/QtKEg
	9tUwWm5KzoUU8+YdJhz5l8+kpsbs2wOTPplM6z7G0Fiteyf8PKfNjvEg9U1dV2kz
	Nl+pO5Pq/xFdgctDvanUOt4izO5MRuXDpvFDL8PaikZy9ojiXedV9TT/5lzDGgP3
	2zuqDWFtIh2tEk8OtoyPa2poARMBb8C9UboYZ/19WoyK6uUyb3K1ho9xTDUF+nL/
	/6jZCrJThc1owNQQ6+P+MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783344432; x=
	1783430832; bh=arKbsIHMlFjE6M55G66cI0sfTqdg9TW2vZrtc2BXDoI=; b=H
	05b0KzCi3to5Ic8MtnNch0u6FIuBOq+6MltbE9a8hyRm5Je03+CvyHtcYvwCMFP6
	M+ob9CdJ47Mh27FlCI5+rV6GxWwYvkQAp1XdF3WKKfQdydbUC0mqUTkaaq+LkKOC
	qyrfW6aFNX661VcKXMJ/oiu9+Z9S2CQZ8BIpMlxyiDkoBI2lOVdrfK4woym7Expp
	15kEcjr9Y8/zTFHtqtFdHCqZNvaL3ag8KJbr3MxbxGPDDXcS/yoiKLSQPTwHlB0c
	qarockK9mNwvylMnlGnQLpKOQAhxMg8ax0zoQPYhGflhMxLJpJtQ9igWA07bX9mm
	TxSdq47d1bV4PQrtHHayg==
X-ME-Sender: <xms:L61LapIQDGHcXbHIrWnmZjtjdHXQmqKAqHfWrP1Plo37JX-OCNzDSw>
    <xme:L61LaskxcL2RZ87xgNOzMPgLdSanOVcPMQwt3odcpWdFReN1wmUtw77CDCsJe6toQ
    aGv-ZkF5w2ams9JroPZse5X-1BbxBCtEEnckZnxw20qrJtJ2Ctyb54>
X-ME-Received: <xmr:L61LavHQSd1ib4s4hxVat55zuqF1EuIB29IclBtLQhZTXxs9YSwL6RaQS_D99qvrvOxA0mi0PTGAiFpPWR_Pl414mTlu6AMsYtMYlvCI1zI>
X-ME-Proxy-Cause: dmFkZTGCw4XA9iQtFS966NFUDiG6UE7pd5jXUv58f33eITro08+eaOGdWnRK6KRnmsjmlA
    HIz731wvqMZrEOeh0hzeztIKtC0H/eCCCrYTm+0gBJHKXvCXTeoio9pZhZ633axbXtEya5
    DpLHt1Nf7kqjU560YC0E+nd7yFGb47qu9BDzQcHkPLLX0Vm0MicOLRe05n7CxvYVo9EDnD
    A0DNnvC0HL33U2dRco3actlhHyvepHBLs2wPFB235AxvjIkLTawZPNYtW4dzEHgqw+eu+G
    0eJ8FnOgjVbPD2KDQ6cSBkg0IEopr/aIbrqpCltmk/ta5Gs6lTclECe434OAXYWVhY0Ziz
    Wz3afHclgQjCdovA61/6ec9U8Z28NJ6TEByeESEFNZ5jY2OgPKl3Cj6nb3uuu5X5dwQSvL
    GmUUX9a7OyQzvSZpTdtnEFDnLxjR61R7WdjBnrMVyJAwRrOoj3YU+S+6V6u7U4xreoMC+I
    IrZ0kB0y+CzFTXAAdVfJpab34YYzV3hqJ3v/NbjtjCvo2b6Hhj9ZQq+QzDqdMwV0banxKr
    oS6YL2/kzSExVSTLrt/Xbm3f9MfNt9xDwSPy4duHYJ5tfF81funYJ0YDxyJqXKYq2zE5BO
    V6I5NVj//15qrWXbvHhaWcsc3PVIByWLLzjod9s6QIxdF7Yb/KWPmR9pdtrg
X-ME-Proxy: <xmx:L61LakEAHQ9piEiAsNjyrcrECGNQ1ki2ujixK4qOLGuCLxQGqjX7yA>
    <xmx:MK1LakP94IGSreQ7B2AqEDIrsGQBGfdvjhPavr8rexODjjd-WliqzA>
    <xmx:MK1LarGIqw7LphLDFnGIVvBtVkS-q3EHZj_F1f8MnxJINRTaxTvICg>
    <xmx:MK1LajND10oondEBNK7G9ktcmBIKN80Aosl1onhC8RY--QpqtXhVSA>
    <xmx:MK1LatNtOGx5klqSAsfDFY-VQkv1_aJuFLeyoLXDj4M0y19fGWNlN-Yx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 09:27:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6f69fff0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 13:27:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/5] builtin/refs: add ability to write references
Date: Mon, 06 Jul 2026 15:27:03 +0200
Message-Id: <20260706-pks-refs-writing-subcommands-v4-0-d51f6ce7f830@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACetS2oC/43NSwrCMBSF4a1IxkbyaBPjyH2Ig6a5qVfpg6RWp
 XTvpgqiozo88POdkUQICJHsViMJMGDEtkkjW69IeSqaCii6tIlgQjHFFe0ukQbwkd4C9thUNF5
 t2dZ10bhIdaG1hdy6wliSiC6VeH/xh+N7p/wMZT+bc3HC2Lfh8fof+Nz9eTVwyqjxueDGKs6M2
 6d8gzWZfwbxLekFSSSJaS8d30qpvPmR5Jck2YIkk+TAsswBhxL8R5qm6QlPlKirawEAAA==
X-Change-ID: 20260616-pks-refs-writing-subcommands-7a77be5bda9b
In-Reply-To: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

Hi,

Reference-related functionality in Git is currently spread across many
different commands: git-update-ref(1), git-for-each-ref(1),
git-show-ref(1), git-pack-refs(1) and git-symbolic-ref(1). This makes it
hard for users to discover what functionality we have available to work
with references.

We have thus started to consolidate this functionality into git-refs(1),
which is a toolbox of everything related to references. Until now, the
command doesn't handle functionality of git-update-ref(1).

This patch series backfills most of the functionality by introducing
three new commands:

  - `git refs delete` to delete references. This is the equivalent of
    `git update-ref -d`.

  - `git refs update` to update references. This is the equivalent of
    `git update-ref <refname> <oldvalue> <newvalue>`.

  - `git refs rename` to rename a reference, including its reflog. This
    does not have an equivalent in git-update-ref(1), but is inspired by
    and supersedes [1].

Changes in v4:
  - Add a couple more tests around symrefs.
  - Use a subshell in one of the tests for consistency.
  - Link to v3: https://patch.msgid.link/20260630-pks-refs-writing-subcommands-v3-0-deb04de1ecef@pks.im

Changes in v3:
  - Fix confused error message.
  - Link to v2: https://patch.msgid.link/20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im

Changes in v2:
  - Add a new "create" subcommand.
  - Consistently quote in error messages.
  - Consistently use `<old-value>` in the synopsis.
  - Don't return negative exit codes.
  - Improve documentation of "update" subcommand to mention that you can
    create and delete branches.
  - Add tests to verify that we can use "update" to do this, both in
    racy and raceless ways.
  - Add missing calls to `repo_config()`.
  - Drop useless `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME` variable.
  - Link to v1: https://patch.msgid.link/20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im

Thanks!

Patrick

[1]: <xmqqv7brz9ba.fsf@gitster.g>

---
Patrick Steinhardt (5):
      builtin/refs: drop `the_repository`
      builtin/refs: add "delete" subcommand
      builtin/refs: add "update" subcommand
      builtin/refs: add "create" subcommand
      builtin/refs: add "rename" subcommand

 Documentation/git-refs.adoc |  40 +++++++
 builtin/refs.c              | 222 ++++++++++++++++++++++++++++++++++--
 t/meson.build               |   4 +
 t/t1464-refs-delete.sh      | 152 +++++++++++++++++++++++++
 t/t1465-refs-update.sh      | 268 ++++++++++++++++++++++++++++++++++++++++++++
 t/t1466-refs-create.sh      | 151 +++++++++++++++++++++++++
 t/t1467-refs-rename.sh      | 144 ++++++++++++++++++++++++
 7 files changed, 973 insertions(+), 8 deletions(-)

Range-diff versus v3:

1:  dc87ed0ebc = 1:  3b40441317 builtin/refs: drop `the_repository`
2:  cec7d978f1 ! 2:  8089847912 builtin/refs: add "delete" subcommand
    @@ t/t1464-refs-delete.sh (new)
     +test_expect_success 'delete without oldvalue verification' '
     +	test_when_finished "rm -rf repo" &&
     +	setup_repo repo &&
    -+	A=$(git -C repo rev-parse A) &&
    -+	git -C repo update-ref refs/heads/foo $A &&
    -+	git -C repo refs delete refs/heads/foo &&
    -+	test_must_fail git -C repo show-ref --verify -q refs/heads/foo
    ++	(
    ++		cd repo &&
    ++		A=$(git rev-parse A) &&
    ++		git update-ref refs/heads/foo $A &&
    ++		git refs delete refs/heads/foo &&
    ++		test_must_fail git refs exists refs/heads/foo
    ++	)
     +'
     +
     +test_expect_success 'delete with matching oldvalue' '
    @@ t/t1464-refs-delete.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'delete symref with --no-deref verifies target OID' '
    ++	test_when_finished "rm -rf repo" &&
    ++	setup_repo repo &&
    ++	(
    ++		cd repo &&
    ++		A=$(git rev-parse A) &&
    ++		B=$(git rev-parse B) &&
    ++		git update-ref refs/heads/foo $A &&
    ++		git symbolic-ref refs/heads/symref refs/heads/foo &&
    ++
    ++		test_must_fail git refs delete --no-deref refs/heads/symref $B &&
    ++		git refs exists refs/heads/symref &&
    ++
    ++		git refs delete --no-deref refs/heads/symref $A &&
    ++		test_must_fail git refs exists refs/heads/symref &&
    ++		git refs exists refs/heads/foo
    ++	)
    ++'
    ++
     +test_expect_success 'delete with message records reason in reflog' '
     +	test_when_finished "rm -rf repo" &&
     +	setup_repo repo &&
3:  8e73b0f711 = 3:  fb830f8f9e builtin/refs: add "update" subcommand
4:  f5ad0c9b18 = 4:  f3c17471c1 builtin/refs: add "create" subcommand
5:  5c01f2e828 ! 5:  82e4efb2a9 builtin/refs: add "rename" subcommand
    @@ t/t1467-refs-rename.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'rename with symbolic ref fails' '
    ++	test_when_finished "rm -rf repo" &&
    ++	setup_repo repo &&
    ++	(
    ++		cd repo &&
    ++		A=$(git rev-parse A) &&
    ++		git refs create refs/heads/target $A &&
    ++		git symbolic-ref refs/heads/symref refs/heads/target &&
    ++		! git refs rename refs/heads/symref refs/heads/renamed 2>err &&
    ++		test_grep "is a symbolic ref, .* not supported" err
    ++	)
    ++'
    ++
     +test_expect_success 'rename with empty message fails' '
     +	test_when_finished "rm -rf repo" &&
     +	setup_repo repo &&

---
base-commit: 700432b2ba22603a0bcb71475c9c333d17c9b0d1
change-id: 20260616-pks-refs-writing-subcommands-7a77be5bda9b

