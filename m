Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E613747F2C1
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905745; cv=none; b=s1PzI13/kcgG5zOL4xd/gykTCZpDNCXtI7manhztIOLjjRyr57tf42n6EuwdDA6zNBalaULE1vSK3zkDrL+eqGaA9SonymTwEEIUxBW9HUgFACHVBDXoM3mMZv+cQO5IX+Wvx09PlmkJU7Cg4mlOQP+Tehdyk3jk1rdTCYC/aOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905745; c=relaxed/simple;
	bh=rcuXwdDkugRnwBWUFpMfW8cL/Jo2oF4rXccSJUuATDc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=LWG+KexgNHVssi2CeWDq7gGiWKyvKZ8MoIwyANQ6S+jFTXI0HmZYXCv8jhrG5Lr34HCcEU+Up+NbVgHj6iBBJLvj6/Gyk4FobUwFeU9fvW3VjZ3MRNMalfX/8fzv68IE7dueG+DOzyfuL/Up5+4FxwYPQ9+Dg+/nqyJoX5DWPzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cb6OhTZW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bDFXvEtz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cb6OhTZW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bDFXvEtz"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1DE7414000E5;
	Wed,  1 Jul 2026 07:35:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 01 Jul 2026 07:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782905743;
	 x=1782992143; bh=rpgyERafB2mYbSiwnDZmirmv0kF23m0JaPS+gFdBXUo=; b=
	cb6OhTZWqwlKapNW1WJziGjtuGQNb4kyWILbEnoQggAHBOC69zmJAlQzF6tRprrI
	QLp7W8nc0h4VUsoDPGLEvWgIGYzvItPWdVZsR8+ZzJPehejShbONg5tyWzHBJuz0
	Cy6hHpGalbkS7DHeI63VX1a944Ko0EKjhtGRmY+lOaMx0nnxspk1fAQUPVyvupwn
	xC2ZkipG9Tj/+vigvbYK65GHTGSBApNo/epeoGIwq1iU//w8D73xbDvx0o6OtZJ2
	rY1E5CKBKxkg8px/uMNDsB3ySSE0ZI+X+hTRTd17/MIP4+3+yqF1Q/40dTFrTaBi
	CL7HjnZ48n6PFbetxtPLSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782905743; x=
	1782992143; bh=rpgyERafB2mYbSiwnDZmirmv0kF23m0JaPS+gFdBXUo=; b=b
	DFXvEtzOySTHorYGwv/64/If56MXBaBBUZMVxepsmDqkYPNxZcqk6ClZDmxU0Th1
	EOq9iiTBkYTtkI0+SnblU9AfhuVV02AnuY4Dn/ep30APBkOaUhHAzKuHjWgW5m2f
	xVBadH1ODtwg+QsHbNxNzGwvU0x8kISr0NeEP8qh13JN0MogiVahUhkuf5b+2OHo
	7cufZqeYzNpTrQrfTjrvqFUaMth9PGSYKhtHxRsDcbBaP4Y+pewuQj7wvj/K4R3a
	znhsbqBBo5ciYGmb+uXk0p1QyB9Pc0QRSDo/brT1FzKmba3FM/qP8cRaZHwPk+HE
	t9kY0v3Omfrrx7LUnCV2A==
X-ME-Sender: <xms:jvtEaiSeQIZXj2Wq1JK4g3nw-lBwzSHtHZDpWNHECYBf3YUN_v3alg>
    <xme:jvtEahEdtRzeORGzPIBDThOnQxcMr_nbblLHo4yb2QSd_087ppcz9SeYHC8rjzQUK
    URIMucz3fM4LbnAm3ybLSVcat39G89S_JKDJcdRDnt0BnQjOFiu>
X-ME-Received: <xmr:jvtEanF1XOHROGiqTSnPvu9C9QfoJDmC7NuI8FFRcdlv67EERddVng17VY_e7N39G0W_s0FturZG9vfIfPxapc7asBCOa_sQhduhdVgfP-s>
X-ME-Proxy-Cause: dmFkZTFWJX/40q8ss7zovW0N6or7ERcFDL09Sre4tzK0OUYAuDvJnARjlpdRynjAHnpTxy
    yMERgc6SeFP8GFPLjhw4D9k0UJyYw2j5dlX/baAQZUnkvU17pF7poX3qJnQkKOpfR636e+
    MpMVluvEv5NN9zPAqVaODxNXFUET/VvDipP7Z7SjB3TLbCP5RBThyPDHm0gWHpGNZ2G4Vn
    EQZTwqgIwvl91p/bkccNNOFQPdwkZqEmnkKJOTVVFZZ67mvcdI7o4UvfadrbyognzZHJgD
    +cNybF2+3nylbGI9pkb7YdRNhieYRTQZf+J20EoKIyqfIcFkJNJlQr3kmU6TzaHfzxEVVq
    +dfQk2RgIWY0b96fQQmmn6ihsdqMLQwqkZl1XuG9+uKJdQSXnBKnJ5Y90CHYs5HOohuXpV
    oUZ4p4dwlULngxDX8s1EUJHkl2WfCz7M6yM+eBCGknOqIzUHNvg5cdzbymCeGBkDsusoMs
    Tzg2JOE/TqInxwHMBzndRr9nEf15jl7sRt9mEctAYu0BQF3k+dCyxZNjC6n/VuKMgAPHdS
    PTOFtr5KX7NALEb5//H07a0i4Jfm8lOokPX0ZsxZ5wJQzdnymqH9hFGnxI2NT9jA3hdh5L
    bvo+/TbjsbFsgBcsUDZ61PabhZ2CQJO0OIfF7geanFsF/6i6xJBwXEosJuCA
X-ME-Proxy: <xmx:jvtEavSlPdfyLsp6Mz1tBXqWmgiRAoRPr-BuIbevaNwBcx_jDrxGUg>
    <xmx:jvtEaoJXUau1Orb2ok3bpKocuZbZGAb2SJ0fl8ZJRui-yKDko0IhwA>
    <xmx:jvtEaqYS52wjo5QJP7f_HV-Ydskq6QNKFog15oG3Z9CMbZx75OULwQ>
    <xmx:jvtEaq_wbwki4x8_btx3qNrFkeOgifh0j9UKKQbH174ZvFsbXdK5CA>
    <xmx:j_tEagt1QfxOyCfss54P-uA3SjqDNGyEInuev2FWkKz5CgtMkdNn6Tu6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 07:35:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6517d37f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 11:35:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v8 00/11] builtin/history: introduce "drop" subcommand
Date: Wed, 01 Jul 2026 13:35:27 +0200
Message-Id: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH/7RGoC/33RzU7DMAwA4FeZciYodeL87MR7IA5tkrKAWKtkV
 KCp744zkEilwtGS/fnvykrMKRZ2PFxZjksqaTpTYO8OzJ/683PkKVDMQIAWWnR8UHx+LfyUymX
 KnzzkaeZgR+21dC6agVHlnOOYPm7q49N3XN6Hl+gvlaoZP+W3tktX8/7vsHRccK1klCCVCIgPl
 HKf3ljlF2gBuQ8AAUaBH3DAzuiwAWQL2H1AEmCV722kMZw0G0A1QCf2AVUnoNlH0UfrYbsCtsA
 fN0ACpAoSDSCi8xtAtwDuA5oAoBO6iFIHYzeAaQBw+4CpX6DlHfQOTfgF1nX9AkpdBBFLAgAA
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

Changes in v8:
  - Pass `RESOLVE_REF_READING` to make `refs_resolve_ref_unsafe()`
    return a NULL pointer when it cannot resolve the reference.
  - Drop unneeded code that sets `head_target = "HEAD"` on detached
    HEAD.
  - Add a test case that verifies that we can drop commits with
    "--update-refs=head" and a detached HEAD.
  - Link to v7: https://patch.msgid.link/20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im

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
 builtin/history.c              | 284 ++++++++++++++++++---
 builtin/rebase.c               |  41 +--
 read-cache-ll.h                |   1 +
 read-cache.c                   |  12 +-
 replay.c                       |   8 +-
 replay.h                       |   5 +
 reset.c                        | 102 +++++---
 reset.h                        |  51 ++--
 sequencer.c                    |  17 +-
 t/meson.build                  |   1 +
 t/t3454-history-drop.sh        | 561 +++++++++++++++++++++++++++++++++++++++++
 12 files changed, 1000 insertions(+), 121 deletions(-)

Range-diff versus v7:

 1:  4b8702dbff =  1:  8145bb1408 read-cache: split out function to drop unmerged entries to stage 0
 2:  1794f27cc4 =  2:  022d65d3db reset: drop `USE_THE_REPOSITORY_VARIABLE`
 3:  2cb6c21f6a =  3:  c37abd69d3 reset: rename `reset_head()`
 4:  55fb296c39 =  4:  84f80ff33b reset: modernize flags passed to `reset_working_tree()`
 5:  b57d52b5ca =  5:  2465dcf8ec reset: introduce dry-run mode
 6:  a54dbccb17 =  6:  65b1853ce4 reset: introduce ability to skip updating HEAD
 7:  f22a1c9b70 =  7:  acfc768574 reset: allow the caller to specify the current HEAD object
 8:  5ec7867767 =  8:  8e2d3fa7b3 reset: stop assuming that the caller passes in a clean index
 9:  d8c9548408 =  9:  80015c6cec replay: expose `replay_result_queue_update()`
10:  d01ce11892 = 10:  b518dcd5ef builtin/history: split handling of ref updates into two phases
11:  1ee3600b98 ! 11:  963636e72c builtin/history: implement "drop" subcommand
    @@ builtin/history.c: static int cmd_history_split(int argc,
     +
     +	*changed = false;
     +
    -+	head_target = refs_resolve_ref_unsafe(get_main_ref_store(repo),
    -+					      "HEAD", RESOLVE_REF_NO_RECURSE,
    ++	head_target = refs_resolve_ref_unsafe(get_main_ref_store(repo), "HEAD",
    ++					      RESOLVE_REF_NO_RECURSE | RESOLVE_REF_READING,
     +					      NULL, &head_flags);
     +	if (!head_target)
     +		return error(_("cannot look up HEAD"));
    -+	if (!(head_flags & REF_ISSYMREF))
    -+		head_target = "HEAD";
     +
     +	for (size_t i = 0; i < result->updates_nr; i++) {
     +		if (!strcmp(result->updates[i].refname, head_target)) {
    @@ t/t3454-history-drop.sh (new)
     +	)
     +'
     +
    ++test_expect_success '--update-refs=head can rewrite detached HEAD' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo --initial-branch=main &&
    ++	(
    ++		cd repo &&
    ++		test_commit first &&
    ++		test_commit second &&
    ++		test_commit third &&
    ++		git switch --detach HEAD &&
    ++
    ++		git history drop --update-refs=head second &&
    ++
    ++		expect_log HEAD <<-\EOF &&
    ++		third
    ++		first
    ++		EOF
    ++		expect_log main <<-\EOF
    ++		third
    ++		second
    ++		first
    ++		EOF
    ++	)
    ++'
    ++
     +test_expect_success 'conflict with replayed commit aborts cleanly' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&

---
base-commit: 1666c1265231b0bc5f613fbbf3f0a9896cdef76e
change-id: 20260601-b4-pks-history-drop-28f6c6399e7b

