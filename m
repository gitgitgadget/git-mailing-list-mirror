Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA56374E63
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379215; cv=none; b=ggC+0nyW7fyto2BWgiywQv9X5oBd+gbzSViLrPp8SdeZzlYBjKs9qAkVyk6scOhdaUgHXjlpfhpBmbrPkwazEZdQC/8TQwhuWUqmK+eHFQ9G27Alu2AymehByWZdEoWdTwUxsdDT7PUiyZGkFr63iVZJvER8xMW8O4h+mXS2Rrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379215; c=relaxed/simple;
	bh=DFBLvmB/24oMuqZdKtPSPz0oD3Rp2GFKPWy4UCkvsO0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=rt+RHkK0HljJ5FZ+qMoi80jVyX+w13Hk0GBhyy+GBlsF4gwUlvZ8Rk8PHFj3bNnTacKxQqQ0uDhG/ZQ43yWKP6JgIyIEIg9jo+EgGpQMqKu574VJmGh7toyTQ3z6h3WPBd+t19LJe8yn6wa4jbNwsanTKgXKMkUnQLmUfhNSYkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J0i6UCLy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KmgbzAGx; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J0i6UCLy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KmgbzAGx"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C7E21D00130;
	Thu, 25 Jun 2026 05:20:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 25 Jun 2026 05:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782379212;
	 x=1782465612; bh=U1LN5aJDH4/ByP6WpFY62Xky56YSPH2LbG1N1y91AEQ=; b=
	J0i6UCLy1z5rXiykH2igsq8sVUM1WifnPY+G7W++HQgOKLoU/jHKBB5q36zdWUps
	aLo4XV9+fFG9b0jwKrrMyql4xSU5+znvh6VfZD6RJs5krqkRR1p0OtdtiDKf1tAA
	kssdrqyvM19Mxr7YG6TvsOvoHrN+kagT7/q7qV89E4vsEprcdiH6WY0uqXc+6Ulq
	JbIApDMGJrfHKd90mNsb3BNFIjRBS/x3zkbEIUeHE7Wvgck14Lls5Be6uUbM8y0i
	/d4UyQllUqh/ubEo+ZW1D9Ztm0q8Fs4WBsR2xMjGXSUufWo1AmFr4BKyBB7qguqr
	EotuJ6HGpRzNLia2hXgtWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782379212; x=
	1782465612; bh=U1LN5aJDH4/ByP6WpFY62Xky56YSPH2LbG1N1y91AEQ=; b=K
	mgbzAGxgBcktHCce39ssq+zZiPYsoIRvfOcbo6WZpx/liXdMT+n5a+xffaL9DXl0
	YO66fEJUPaiV2LlL5yhsjoVWhMw5SDTTWXOtvXRBt2ONsAFO70gASxv7sR4xlDSb
	CzYsaIlmdt4kFvv8CHu4rk8hfIQ5FShRpIArZgJSZjKbf1tEel2YEuJC1RdZyCZO
	642wzeKrYS/RLhyAGp3iz+o9hWISThlHjhhgxpL6WS50QEpOKt6371Kb1LDCrDHO
	0L5UkRS+bHX011U8iFmMgEOnXzgyn3MmoVCXmNy0EFRbF8JAnuszoag/YHR5nh36
	3zzW9Y9fLgbDLaraYpEbw==
X-ME-Sender: <xms:y_I8aiyjCUqXBOKiJUixyEIcyHsvqI5E1zyotyYjboFVkI2HEOk8fA>
    <xme:y_I8alTCciYThNy_agR42XBAJlI4Onsv2sueS_OWiP9XZPDpMtojWxVBu8WB37j_E
    z7kcAG2DO6-BOzNthlDRLX1BzQw8fnd308rST-PHflxLXXnhGuxDQ>
X-ME-Received: <xmr:y_I8apVDzuSjR7cq4o7v_L1TYAHCSHnrdHfQNQBw2Dup6G0UpiwrdM23At89FP5KjPSWW_i35FVLXMHyMsWhLPNoGvZzPmg1U5zcMyEf0Q>
X-ME-Proxy-Cause: dmFkZTGB8qXdO4GbehdWB3uARfSGcGi4sIKSJcX5hkvHGOhnin5TakpYYry+gql4BVN0gC
    ds/w/9qqUTANxk2eyyQm0eUnhpaGXQc2qoDh3gax3WCVl21GbjJzQ+2RBp3bzT8reFq7k6
    MbVKKUPlwPwktXt5zb81GlNnQvHpDi6fRI507tbe6vkHIvfKTnFiYcFjHXmqEIt/9yhkAF
    4hrx3VrdF3LedBbXLuz1MCQdN5ozTukd3qzmMI3xVHiQ52VvgmguHtQ/S+rPUa3AlPhpSp
    YhvjjDpvCF7itVMk7IQM3UJmZwEWJB71ZuMwwxtsM4AtJvChWTykhpZVEI3Dv8ug2tLbLi
    bQ8IVm5GZkft6kIR45yKBiqawi+My1iSrEXMZgdJzzL1ufZYQAuXGO0TlNkVCKmKBe/y/s
    hLZ219P2D1CSFZCIq7C5uCHqpCZLL6yqcV+0kkd8jQUEQ5sNVd/20atdS+tRW/rL9LDQYl
    YNcB5wdT5WuFPN0+DsDYQII4mP5ws7J0mkhqGOtSSvtfh73N9+tRwghvaRVRz9TqSPm6Iy
    0yBr2eIRMYqpRP8BU6jGbUbQxGTvpBVd60d2uO9o7ge8zSjZ7Z9m2mptg+cm+OHVhwcyzM
    Fg+/Z4MI0IfNzmhwWaEz32n9msQUF35Kt1NeseNXZffSW7JvHnzO/FFz+42w
X-ME-Proxy: <xmx:y_I8anayBhmZhWq-M15qMrJsUzJShcS0qxt_ajvrgGlwDhtoSFn4vA>
    <xmx:y_I8av01OTJFdnPzRMYB-drUNqJz0RhSbMbs3NUtN68bZ7Bu4RGv5A>
    <xmx:y_I8apiYr0KZDH_KiFLsAepu5kndeTsI3t2d7WQsPYNI-Si-sw_H8Q>
    <xmx:y_I8ajac5yvrSv0uIwGyTzVoYP4M6iGIb9JVjiG9qPg6IKkeqLTElw>
    <xmx:zPI8atYEC7ohCSGvSoIMYJAogtmC232UQMTQkMyDRxVaPT3rGAkIXCnT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:20:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1cddc561 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 09:20:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 00/11] refs: fix "onbranch" conditions
Date: Thu, 25 Jun 2026 11:19:58 +0200
Message-Id: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL7yPGoC/43RwU7EIBAG4FfZcBYDdKDUk+9hPAyUWjS2DVTiZ
 tN3d7oa0944/mTm+wncWA4phsyeLjeWQok5zhMF83BhfsTpLfDYU2ZKKCOM6LgDvnxknsKQOZY
 59tyPfUx8mtc4XOl8wRSmlSMEHGTonUfHSFtoI37fm15ef3P+cu/Brzu/T4wxr3O63q9S5D731
 ypFdWuRXHBtvDXghPTQPNPaY/xke2VRR1TXo4rQAawGxK6zujuhzRG19WhDqEJtTBcs4eaEwhG
 tf/QChKKBVrnQovdwQvUBVaoe1YQKaaHVQjb0of/otm0/k+rxmUECAAA=
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

Changes in v6:
  - Drop redundant condition when setting the default for
    "core.logallrefupdates".
  - Leave breakcrumb for why we lazy-load write options for the "files"
    backend.
  - Fix commit message typo.
  - Link to v5: https://patch.msgid.link/20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im

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
 refs/files-backend.c                |  76 ++++++++++++---
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
 setup.c                             | 101 ++++++++-----------
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
 29 files changed, 561 insertions(+), 389 deletions(-)

Range-diff versus v5:

 1:  27cb4688d9 =  1:  9281850ec4 setup: inline `check_and_apply_repository_format()`
 2:  f0e9e95c25 =  2:  cdd6a01554 setup: stop applying repository format twice
 3:  b3ecceae2e =  3:  748506f661 setup: don't apply "GIT_REFERENCE_BACKEND" without a repository
 4:  8d70b43f8c =  4:  9ffc2e94c6 refs: unregister reference stores from "chdir_notify"
 5:  190956a8f6 =  5:  080e7d175f chdir-notify: drop unused `chdir_notify_reparent()`
 6:  504a0326c3 =  6:  5a2b973766 repository: free main reference database
 7:  2f0ecfd9d9 !  7:  ecdbf37fde refs: move parsing of "core.logAllRefUpdates" back into ref stores
    @@ setup.c: static int create_default_files(struct repository *repo,
     +
      		/* allow template config file to override the default */
     -		if (repo_settings_get_log_all_ref_updates(repo) == LOG_REFS_UNSET)
    -+		if (repo_config_get_string_tmp(repo, "core.logallrefupdates", &value) ||
    -+		    refs_parse_log_all_ref_updates_config(value) == LOG_REFS_UNSET)
    ++		if (repo_config_get_string_tmp(repo, "core.logallrefupdates", &value))
      			repo_config_set(repo, "core.logallrefupdates", "true");
     +
      		if (needs_work_tree_config(original_git_dir, work_tree))
 8:  ea171d971d !  8:  618df32bb6 refs/files: lazy-load configuration to fix chicken-and-egg
    @@ refs/files-backend.c: struct files_ref_store {
     -
      	struct ref_store *packed_ref_store;
     +
    ++	/*
    ++	 * Options used when writing references. These are parsed from the
    ++	 * config lazily on first use via `files_ref_store_write_options()` so
    ++	 * that we don't have to access the configuration when initializing the
    ++	 * ref store. Do not access these fields directly, but use the accessor
    ++	 * instead.
    ++	 */
     +	struct files_ref_store_write_options {
     +		enum log_refs_config log_all_ref_updates;
     +		int prefer_symlink_refs;
 9:  e3bb0c90ef =  9:  13b14f9394 reftable: split up write options
10:  74b389c2f1 ! 10:  ba12b6f164 refs/reftable: lazy-load configuration to fix chicken-and-egg
    @@ Commit message
         properly, add a generic test to t1400 that verifies that the user can
         configure "core.logAllRefUpdates" via an "onbranch" condition. This is
         mostly a nonsensical thing to do in the first place, but it serves as a
    -    good sanity chekc.
    +    good sanity check.
     
         Note that we had to move `should_write_log()` around so that it can
         access the new `reftable_be_write_options()` function.
11:  0cb5a85167 = 11:  85a675ada9 refs: protect against chicken-and-egg recursion

---
base-commit: 255322df35357168daefec8523a3cdc849edd6c1
change-id: 20260609-b4-pks-refs-avoid-chdir-notify-reparent-a4eaf1edbcab

