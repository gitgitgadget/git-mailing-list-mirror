Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38FD304BDF
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 04:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789358426; cv=none; b=Ys0AVt0X8mU6ly49NEsltwHvvZFCaJv4yO2pdogqh8jbUhEweiIly/RuNPj6RlEtNFLg783FIdtgWgcMBjX37tI6waqbMzIXoiDW1eTIuG1aH5XTDEvlfD6Y0/DqXIXbi1OMsWmlTQ7u4exQipuu01Lx+pAzBlpdBadsdjUBfyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789358426; c=relaxed/simple;
	bh=jJ1G6Ll6Is+GHjNz96TfNgTpZqIPPcpS3KjfYiNhInk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvHWfylfBHpc6YCvE8TFYeBviV6k0MXKCPXaWKZoX8NIinXhVvjF2WsNZq6xTgn1+RYye0UdEsmElSto2Ls8BWBUkswZmJsi5oJxCt037MwHEc6CtgQO/1hePPfBtSYq568OS1YnLlimJOVNuQP1fYyEFNSAHsJtEn9ab5HukMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=Czpnsb2p; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="Czpnsb2p"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-7f4f0c89e34so1100089a34.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 21:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1789358423; x=1789963223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=obpg1D8htw8Vqy2nPsR5NJrHGALHdkKSJJbuLolFyUc=;
        b=Czpnsb2p3kepIk14ALkwolPvv7dJDySBbhmOtUkjIChfXCH8MOr70qOpbajP2uR4Jg
         klM1icWh8beLbYxMb1nQpF86ryepvMThNMRCcQtZ/kwWG96u5Yckk1PjowQ1+ReVBSPI
         KbHRdnbHp8FkN+xkEt3L1/M4QdghyHidh78ULWC66v3KHGvICVfWpW3kMZYN+ymlVK6f
         M9aqWvxabdGTitZ091Kubv38CDx9Me472YJDWQHIsXYZywcJZ1Jcf2dcfCYEBZR4Scxd
         ZlWVto+NxO9o3D//q18slUmb9LXIiRjUNPNWQSKKeRwQCcuNTesH0+dg4wfXqXcMD5zp
         1CHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789358423; x=1789963223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=obpg1D8htw8Vqy2nPsR5NJrHGALHdkKSJJbuLolFyUc=;
        b=eXjkMT4wrU+D8i92hqtGfI8kKlkdwKpu7f9tg8uTE80iy2ovCDfMwyhf07VSm2jxbr
         G9KcEBVf7/15TAz/0hZSGd1VJQNzpBSYFGTMUfGxjYqw7/v0KqO+RiFwDODC2XRwZHAw
         iSLFf/gYwl2Xvze0q/R+wMSdPpLilvmXN6vHfZWBfP998UwlXT5+SCGpcwLXK3cR+Ukq
         zlQJreL/Pj4kmo25sq+xzfy8SfLhplywc9OQtDpKoHI3Q+eTEX15YWWF4uX833nkla5r
         /8l++EPI/lEQXdV+NVuWrEBQhJ4eahiR88FJVBOaKl84KUGnAt9vFHGcm6e9QvJjl3o5
         Ww5w==
X-Gm-Message-State: AFuF++mAMn2UMKdAyRAvO7E5BZHe0ifUEs3lmwCeaWR8flR33xei68Pi
	nairqHAp26KMc1SnB3bQo2Mj3cTaGJ8Bxx3lRFAiGQe9Z1+R0JnwKZZ9WBrZMVjE4MVX23XudLu
	4HnentY0=
X-Gm-Gg: AYBFou2fDaxHKmNLf6Lup1cXOII5vZp3QCwlHE8mqVLBi0Rob7NWwwGH1zKgj8hjYk/
	NtdzzaKqEP1h2Y5/3Hnk4v2j+608siP3IcWyqquuIWFm6QVkFmFl5l8OC+Nyb45CtXTSRdDdC1E
	9jlzTe0w3cEn6CR+9H/pXbe6G4RRQjhO0ZXkZdyXfaWINiHXX2WDseie9Q9zuA5bkAA0jmhMsXx
	WWSGEKKn1Nc7sHwiG7oxalbNw9+ybl0XHXhq8IgJPiBfX0hGpk0TWV+9ticK7e1GXvq52p40MeC
	eGsd3IPm+FFXB0doCsxLIM5SWl0XlBjWsSCD0Uj54jZ7kpqvWBexwqyysiMDaLgrdJoLN5nlUlb
	tUHgdHKy3s90FFhpuz8XVfcKXPqNKZu4aLrBIxhEpq7ky7tOt+7dvrgDt9apPrOq2mho5DKD4S1
	UqUDwGIlRbbPWY4qLbP0UTVH1Q/NtdvRH/r7KFzTeSLZVTBJMNPFkB8MwgCUIcSaN+8RHAd9E=
X-Received: by 2002:a05:6830:6f88:b0:7e9:e8a6:6389 with SMTP id 46e09a7af769-8089738c086mr367334a34.4.1789358423207;
        Sun, 13 Sep 2026 21:00:23 -0700 (PDT)
Received: from localhost ([161.97.221.21])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-80825a9b5fasm1595262a34.22.2026.09.13.21.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 21:00:22 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tyler Cipriani <tyler@tylercipriani.com>
Subject: [PATCH v4 0/2] push: check pushed ref for --force-if-includes
Date: Sun, 13 Sep 2026 22:00:16 -0600
Message-ID: <20260914040018.76111-1-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904210122.431757-1-tyler@tylercipriani.com>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v3:

- check_if_includes_upstream unconditionally resolves peer_ref with
  RESOLVE_REF_READING, now all non-branch ref pushes will be rejected
  when using --force-if-includes
- add test for --force-if-includes tag push 1/2
- clarify log message problem example 1/2
- clarify deletion in log message 1/2
- add missing blank line between test cases
- shorten long line in builtin/push.c
- reword advice-message wording 2/2
- rename 2/2 from "detached HEAD" to "non-branch"

Changes since v2:

- Correct patch threading of 1/2 and 2/2 to reply to cover letter of
  current patchset vs. cover letter of the initial iteration.

Changes since v1:

- Clarify in log message 1/2 that --force-if-includes will reject a
  detached HEAD today (when the same-named local branch lacks the remote
  tip). And note that this change makes it explicit to always reject
  the detached HEAD case.

--force-if-includes has been checking the reflog of the local branch named
after the destination branch regardless of what's being pushed. This can cause
false rejections or unintended data loss.

False rejection has been reported twice that I could find:

- 2023-07-26 - Stefan Haller reported local branch with a different name
               false rejection[0]
- 2025-05-08 - D. Ben Knoble reported detached HEAD false rejection[1]

The same root cause can result in data loss: when a same-name local branch
contains the remote tip but you --force-if-includes push an unrelated branch,
clobbering the remote repo. PoCs are in t/t5533-push-cas.sh -- new test cases
fail against maint, but pass with patches applied.

Existing tests covered refspecs with different names for --force-with-lease,
but missed --force-if-includes. New patches cover:

- allow forced-update using refspec with different-named local branch
- allow same as above, but with HEAD
- reject force-update using refspec with different-named local branch lacking
  branch tip
- reject same as above using HEAD
- reject detached HEAD

Resolved question: the detached HEAD case; HEAD's reflog was considered
and rejected as too broad for purpose in the original review. cf. [2]

[0]: <https://lore.kernel.org/git/f51c73ed-eb03-83ca-fb31-d3e2645c9a63@haller-berlin.de>
[1]: <https://lore.kernel.org/git/CALnO6CCk0SgwObQRnpd5Pt_DvCKF8dBmyVHivU6Nr_O-GusGLA@mail.gmail.com>
[2]: <https://lore.kernel.org/git/CAHLx=O=tVhtiZpaRP9TpfiBfOMS2xPe3c3=mC3VNEdBrLOioFg@mail.gmail.com>

Tyler Cipriani (2):
  push: check pushed ref for --force-if-includes
  push: fix --force-if-includes non-branch advice

 Documentation/config/advice.adoc |  4 ++
 advice.c                         |  1 +
 advice.h                         |  1 +
 builtin/push.c                   | 17 ++++++
 builtin/send-pack.c              |  5 ++
 remote.c                         | 29 ++++++++++-
 remote.h                         | 10 ++--
 send-pack.c                      |  1 +
 t/t5533-push-cas.sh              | 88 +++++++++++++++++++++++++++++++-
 transport-helper.c               |  5 ++
 transport.c                      |  8 +++
 transport.h                      |  1 +
 12 files changed, 164 insertions(+), 6 deletions(-)

Range-diff against v3:
1:  da27c421ed ! 1:  e7912c3fd0 push: check pushed ref for --force-if-includes
    @@ Commit message
         on the destination branch rather than the branch being pushed; using
         ref->name vs. ref->peer_ref->name.
     
    -    This can cause confusing rejections or unintended data loss.
    -
    -    Using a command like:
    +    For example, this command looks at the reflog for main vs. src, even
    +    though src is being pushed:
     
             git push --force-if-includes --force-with-lease origin src:main
     
    -    False rejections: when src is an up-to-date branch, but main is
    -    out-of-date or nonexistent, then the includes check will fail telling
    -    users the remote ref has been updated since the last checkout.
    +    This can cause confusing rejections or unintended data loss.
    +
    +    False rejections: when src is up-to-date with the tip of origin's main,
    +    but main is out-of-date or nonexistent, then the force-if-includes check
    +    will fail, telling users the remote ref has been updated since the last
    +    checkout.
     
         Data loss: when src is an orphan/out-dated branch, but main is
    -    up-to-date, then the if-includes check will allow the push, clobbering
    -    the remote main.
    +    up-to-date, then the force-if-includes check will allow the push,
    +    clobbering the remote main.
     
    -    Find local reflog using ref->peer_ref. When using a refspec like
    -    HEAD:refs/heads/main, we resolve HEAD. If HEAD is a branch, use that
    -    branch's reflog.
    +    Instead, use ref->peer_ref to locate a branch with a reflog. But if ref
    +    does not resolve to a branch (e.g., a detached HEAD, a tag, an oid),
    +    then we reject the push. The alternative would be to use HEAD's reflog,
    +    which is too broad to tell us if the history being pushed includes the
    +    tip of the remote. We need a per-branch reflog, which means that pushes
    +    of a ref that do not resolve to a branch are rejected. Rejecting the
    +    push of a ref like a detached HEAD already happens today (if the
    +    same-named local branch lacks the remote tip); now the detached HEAD and
    +    other non-branch pushes are explicitly rejected.
     
    -    But if HEAD does not resolve to a branch (i.e. a detached HEAD), then we
    -    reject the push. HEAD's reflog is too broad to tell us if the history
    -    being pushed includes the tip of the remote. Rejecting a detached HEAD
    -    already happens today (if the same-named local branch lacks the remote
    -    tip); now the detached HEAD state is explicitly rejected.
    -
    -    Skip deletions:
    +    Allow deletions, e.g.:
     
             git push --force-if-includes --force-with-lease origin :main
     
    +    A deletion has no source ref, so no branch reflog can be checked.
    +    Existing tests already enforce that deletions should work with
    +    force-if-includes.
    +
         ref->deletion is set after apply_push_cas (which triggers
         check_if_includes_upstream). The ref->peer_ref name is "(delete)".
         Instead check with is_null_oid to detect and allow deletion.
     
    +    The early return when peer_ref is missing in check_if_includes_upstream
    +    is necessary because apply_push_cas walks every advertised ref whenever
    +    use_tracking_for_rest is set (i.e., a bare --force-with-lease), so
    +    check_if_includes upstream is called for for refs that are not part of
    +    the push.
    +
    +    Remove unnecessary check for empty return from get_local_ref, since it
    +    never returns NULL for a non-empty name.
    +
         Reported-by: Stefan Haller <lists@haller-berlin.de>
         Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
         Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
    @@ remote.c: static int is_reachable_in_reflog(const char *local, const struct ref
      static void check_if_includes_upstream(struct ref *remote)
      {
     -	struct ref *local = get_local_ref(remote->name);
    +-	if (!local)
     +	struct ref *local;
     +	const char *name;
    -+	int flag;
     +
    ++	/* ref without peer_ref will not be pushed */
     +	if (!remote->peer_ref)
    -+		return;
    -+
    + 		return;
    + 
     +	/* A deletion has no local history to check against. */
     +	if (is_null_oid(&remote->peer_ref->new_oid))
     +		return;
     +
    -+	name = remote->peer_ref->name;
    -+	if (!strcmp(name, "HEAD")) {
    -+		name = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
    -+					       "HEAD", 0, NULL, &flag);
    -+		if (!name || !(flag & REF_ISSYMREF)) {
    -+			/* detached HEAD: no per-branch reflog to consult */
    -+			remote->unreachable = 1;
    -+			return;
    -+		}
    ++	name = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
    ++				       remote->peer_ref->name,
    ++				       RESOLVE_REF_READING, NULL, NULL);
    ++
    ++	/*
    ++	 * if we resolve the ref to anything other than a branch,
    ++	 * then there is no reliable reflog to check
    ++	 */
    ++	if (!name || !starts_with(name, "refs/heads/")) {
    ++		remote->unreachable = 1;
    ++		return;
     +	}
     +
     +	local = get_local_ref(name);
    - 	if (!local)
    - 		return;
    - 
    ++
    + 	if (is_reachable_in_reflog(local->name, remote) <= 0)
    + 		remote->unreachable = 1;
    + 	free_one_ref(local);
     
      ## t/t5533-push-cas.sh ##
     @@ t/t5533-push-cas.sh: test_expect_success '"--force-if-includes" should allow deletes' '
    @@ t/t5533-push-cas.sh: test_expect_success '"--force-if-includes" should allow del
     +		git push --force-if-includes --force-with-lease origin newbranch:main
     +	)
     +'
    ++
     +test_expect_success '"--force-if-includes" should allow forced update from HEAD' '
     +	setup_src_dup_dst &&
     +	test_when_finished "rm -fr dst src dup" &&
    @@ t/t5533-push-cas.sh: test_expect_success '"--force-if-includes" should allow del
     +		test_must_fail git push --force-if-includes --force-with-lease origin HEAD:main
     +	)
     +'
    ++
    ++test_expect_success '"--force-if-includes" should reject forced update from tag' '
    ++	setup_src_dup_dst &&
    ++	test_when_finished "rm -fr dst src dup" &&
    ++	(
    ++		cd src &&
    ++		git fetch &&
    ++		git switch main &&
    ++		git reset --hard origin/main &&
    ++		git switch -c newbranch origin/main &&
    ++		git checkout HEAD^ &&
    ++		git tag stable &&
    ++		test_must_fail git push --force-if-includes --force-with-lease origin stable:main
    ++	)
    ++'
     +
      test_done
2:  e07d16d53e ! 2:  2a455d8a76 push: fix --force-if-includes detached HEAD advice
    @@ Metadata
     Author: Tyler Cipriani <tyler@tylercipriani.com>
     
      ## Commit message ##
    -    push: fix --force-if-includes detached HEAD advice
    +    push: fix --force-if-includes non-branch advice
     
    -    When a --force-if-includes push is rejected due to a detached HEAD
    -    state where there is no per-branch reflog to consult, the advice is
    -    misleading:
    +    When a --force-if-includes push is rejected due lacking reflog to
    +    consult, the advice is misleading:
     
              ! [rejected] HEAD -> main (remote ref updated since checkout)
             error: failed to push some refs to '<remote>'
    @@ Commit message
         - Specify the expected remote tip with --force-with-lease=<ref>:<expect>
         - Ignore the error with --no-force-if-includes
     
    -    Add ref->unverifiable to differentiate between a detached HEAD rejection
    -    vs. a remote update rejection.
    +    Add ref->unverifiable to differentiate pushing something without a
    +    reflog to consult vs. a remote update rejection.
     
         Ensure tests check the rejection message.
     
    @@ Documentation/config/advice.adoc: all advice messages.
     +	pushRefUnverifiable::
     +		Shown when linkgit:git-push[1] rejects a forced update of
     +		a branch when we are unable to verify the remote-tracking
    -+		ref is available locally.
    ++		ref is integrated locally.
      	pushUnqualifiedRefname::
      		Shown when linkgit:git-push[1] gives up trying to
      		guess based on the source and destination refs what
    @@ builtin/push.c: static const char message_advice_ref_needs_update[] =
      	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
      
     +static const char message_advice_ref_unverifiable[] =
    -+	N_("Updates were rejected because the tip of the remote-tracking branch\n"
    -+	   "cannot be checked against a detached HEAD. If you want to push anyway,\n"
    -+	   "specify the expected value with '--force-with-lease=<ref>:<expect>'\n"
    -+	   "or use '--no-force-if-includes' to skip this check.");
    ++	N_("Updates were rejected because what you are pushing is not a branch,\n"
    ++	   "so there is no reflog to check against the tip of the remote-tracking\n"
    ++	   "branch. If you want to push anyway, specify the expected value with\n"
    ++	   "'--force-with-lease=<ref>:<expect>' or use '--no-force-if-includes'\n"
    ++	   "to skip this check.");
     +
      static void advise_pull_before_push(void)
      {
    @@ builtin/push.c: static void advise_ref_needs_update(void)
      
     +static void advise_ref_unverifiable(void)
     +{
    -+	if (!advice_enabled(ADVICE_PUSH_REF_UNVERIFIABLE) || !advice_enabled(ADVICE_PUSH_UPDATE_REJECTED))
    ++	if (!advice_enabled(ADVICE_PUSH_REF_UNVERIFIABLE) ||
    ++			!advice_enabled(ADVICE_PUSH_UPDATE_REJECTED))
     +		return;
     +	advise(_(message_advice_ref_unverifiable));
     +}
    @@ remote.c: void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
      				/*
      				 * If the ref isn't stale, and is reachable
     @@ remote.c: static void check_if_includes_upstream(struct ref *remote)
    - 					       "HEAD", 0, NULL, &flag);
    - 		if (!name || !(flag & REF_ISSYMREF)) {
    - 			/* detached HEAD: no per-branch reflog to consult */
    --			remote->unreachable = 1;
    -+			remote->unverifiable = 1;
    - 			return;
    - 		}
    + 	 * then there is no reliable reflog to check
    + 	 */
    + 	if (!name || !starts_with(name, "refs/heads/")) {
    +-		remote->unreachable = 1;
    ++		remote->unverifiable = 1;
    + 		return;
      	}
    + 
     
      ## remote.h ##
     @@ remote.h: struct ref {
    @@ t/t5533-push-cas.sh: test_expect_success '"--force-if-includes" should reject fo
      	)
      '
      
    +@@ t/t5533-push-cas.sh: test_expect_success '"--force-if-includes" should reject forced update from tag'
    + 		git switch -c newbranch origin/main &&
    + 		git checkout HEAD^ &&
    + 		git tag stable &&
    +-		test_must_fail git push --force-if-includes --force-with-lease origin stable:main
    ++		test_must_fail git push --force-if-includes --force-with-lease origin stable:main 2>err &&
    ++		test_grep "remote ref unverifiable" err &&
    ++		test_grep "no-force-if-includes" err
    + 	)
    + '
    + 
     
      ## transport-helper.c ##
     @@ transport-helper.c: static int push_update_ref_status(struct strbuf *buf,
-- 
2.47.3

