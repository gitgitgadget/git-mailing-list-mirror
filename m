Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371702517A5
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685038; cv=none; b=pZeaFQ+z06xNm1xbMTUOVmqiU8qKNrORVDvMV17025Z9NHt7HblFV+58ZM/zEua25b8h8drhbFjiGW3ZpTBr9D4zFNADDWjYhGgOmZYcxlV6pU388Cnjvwb2blE9w2Vx/q5xNzqCTDHu08gmDsat6A7dGW2cuPdWgbwYghlN26s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685038; c=relaxed/simple;
	bh=wwDz8PrZhNyqo6Gre5OvzI08wzwhuSKg/iN74Msiw/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tioZ8qipDwP/mulKyAd82I+t2Cxpi1smCeQr2mPNotrgbAGtNnkGUj/bywAklRjOzwUOCgxMN6MQ+eojsWc+43ZQPlGjH1FdNJHL19R+TJFmTN3XtmCUz5zDa2hOlRjLu2/T8eT5lRmp1e9xu/iUpP6l6uneoW72TaeXRB3geto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=qCW1eA9c; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="qCW1eA9c"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc88a9d1so99053fac.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 15:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1789685035; x=1790289835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RXd/YB0MLeFurWSrG3Q8YNvTtmB0QMU8oufQIT8Ww6M=;
        b=qCW1eA9cG4e7EK4EpcTOw2fWp4L36fQHXxPx/w51XcjsXBAIBjqeGy0kU4BYYeYJWR
         cam8XAsQNOmpbQqViSuCA8W27Ip3ilNRTKnUPqautVivbE+AwaFgVuGT6v7GkFeEq0KX
         /cxtEACOuxaUa1NjmYVqCY6VFC+3aoyVc52nsmO0+6OZydpd5//OuQyBY2aOuSCfSSR+
         leaId0bLWt6VAfSJSVZeu9OD6/VcFFI7i3zjjeTRVGgB7BtzTdwyMfVM9utJlWBeZXel
         ePUEMFWVd7xQVwNvZ1QOokh3IRBdBsbmEUO8AfYbWlvijSVRrGjb48udhySRwyHAUt3A
         X3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685035; x=1790289835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RXd/YB0MLeFurWSrG3Q8YNvTtmB0QMU8oufQIT8Ww6M=;
        b=QYFJWrT0A/r/pcaZ4Z+f852WsmISb6BAH+6G3jw2hg/1kC+FQ4BMQ4sKHzMzM5koRN
         j1OgLVpPsPTFtts+jg5tzj1FJ7OgA+NobChd1Tk926vHAQ5pQTT8YbHXQUE9R5MxMnoj
         djD3w9CqeQxVPuWwAgOWfCck19lhMMOavMzfuNH5Gc3F6bUG+aZWDG03kVS/0ELYV3zr
         V58k93rS3RGcA13hIepgfYbuqHlc8qj97JJJXYPkMrILnpuD50hiRj7Nd6QFL1MM/12s
         DjaR8O1SuCheKuXIdklLq/GvVbFYtsYKmup91aCMA8JnY3effjgYNaGDIpaSlvcISvtP
         BRGw==
X-Gm-Message-State: AFuF++m9UxJhYHV63hajK5Jk6UCkVc2CKX3E2jM7k1XUq6fuqAjWzyvB
	oySX+d+f/qzFhqAC9NqKSi+lmPFErKVZ9ht2nhp8yl8i749bC48KCJsiEpsuhc6xEfTxifeKh4d
	zb4qMjs0=
X-Gm-Gg: AYBFou20pnrGXFnaWZuXiRF9MrN1SHFe1SqGl4YX5eXuNPq1jqXluIY5jpaBZNrsojQ
	HtjzalG7o4SVRrIJ4rGpE/sGiBX1iq5LUMGO8LSeQFJpte7Xg8Yw4xTv6yJHAsbY65kEXSZdgnR
	Ti2ZM7kG4KsfiJ50bMKPJzSHQssX92q5m5uCUx9VEXy2f42HKb2IFhW9Pgqrms0dcmu5lxwKJZT
	fTPhJKjUu00XvQTVGV0Gm+X3CEHk8JjATSaRuHlD/dbbBxS7fAB66Jo84Z0+vM+LfCmydUJ0hn6
	/TjVf4EMdlKG7kmFNvX8WcuadNsvSXnW5X8ZeAAA/ZXiDOu3jBrRZQ96p66quC7QouCMpbpRVXl
	Jw5qkkX4UB29EVs5qc/pd666qWfjr0nX4tRyCw3ebeBb46EOrl25MPDqkBQ4lR+6aMUnpmMHdgK
	bm2PNkF5tr06yeu5as1033zElwbuQbO3/vXkjf1gCwrxYTQEER1aOx0B+iuk5IQ86pI1dzoaw=
X-Received: by 2002:a05:6870:b28e:b0:47b:7709:5568 with SMTP id 586e51a60fabf-486e564dd74mr469424fac.10.1789685034775;
        Thu, 17 Sep 2026 15:43:54 -0700 (PDT)
Received: from localhost ([161.97.221.21])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-4870ac15363sm85153fac.4.2026.09.17.15.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:43:54 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Tyler Cipriani <tyler@tylercipriani.com>,
	Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 0/3] push: check pushed ref for --force-if-includes
Date: Thu, 17 Sep 2026 16:43:48 -0600
Message-ID: <20260917224351.57171-1-tyler@tylercipriani.com>
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

Changes since v5:

- Update reflog rejection variable name to signal its use
  s/deferred_reject_reason/needs_force_reject_reason 3/3
- Typo fix: s/push force/force push/ in log message 3/3
- Remove imperative mood from log message 3/3
- Edit log message/comments for clarity and ensure the terms used for
  each agree 3/3
- Restored missing function words "to" and "a" in log message 2/3

Changes since v4:

- Add patch to series: Fix case where fast-forward pushes are being
  rejected by --force-if-includes: an existing bug that I made worse
  with the previous changes in my series.
- Add tests to cover allowed fast-forward merges when using
  --force-if-includes

Changes since v3:

- check_if_includes_upstream unconditionally resolves peer_ref with
  RESOLVE_REF_READING, now all non-branch ref pushes will be rejected
  when using --force-if-includes
- add test for --force-if-includes tag push 1/3
- clarify log message problem example 1/3
- clarify deletion in log message 1/3
- add missing blank line between test cases
- shorten long line in builtin/push.c
- reword advice-message wording 2/3
- rename 2/3 from "detached HEAD" to "non-branch"

Changes since v2:

- Correct patch threading of 1/3 and 2/3 to reply to cover letter of
  current patchset vs. cover letter of the initial iteration.

Changes since v1:

- Clarify in log message 1/3 that --force-if-includes will reject a
  detached HEAD today (when the same-named local branch lacks the remote
  tip). And note that this change makes it explicit to always reject the
  detached HEAD case.

--force-if-includes has been checking the reflog of the local branch
named after the destination branch regardless of what's being pushed.
This can cause false rejections or unintended data loss.

False rejection has been reported twice that I could find:

- 2023-07-26 - Stefan Haller reported local branch with a different name
  false rejection[0]
- 2025-05-08 - D. Ben Knoble reported detached HEAD false rejection[1]

The same root cause can result in data loss: when a same-name local
branch contains the remote tip but you --force-if-includes push an
unrelated branch, clobbering the remote repo. PoCs are in
t/t5533-push-cas.sh -- new test cases fail against maint, but pass with
patches applied.

Existing tests covered refspecs with different names for
--force-with-lease, but missed --force-if-includes. New patches cover:

- allow fast-forward push using --force-if-includes with an expired
  reflog
- allow fast-forward push of a tag on a different-named local branch
- allow forced update using refspec with different-named local branch
- allow same as above, but with HEAD
- reject force-update using refspec with different-named local branch
  lacking branch tip
- reject same as above using HEAD
- reject detached HEAD
- reject tag
- allow fast-forward push with an expired reflog
- allow fast-forward push from a tag

Resolved question: the detached HEAD case; HEAD's reflog was considered
and rejected as too broad for purpose in the original review. cf. [2]

Reject non-branch pushes due to lacking suitable reflogs for
--force-if-includes to determine if remote was integrated into ref being
pushed.

Fixes false rejections for pushes which never required force when using
--force-if-includes.

[0]: <https://lore.kernel.org/git/f51c73ed-eb03-83ca-fb31-d3e2645c9a63@haller-berlin.de>
[1]: <https://lore.kernel.org/git/CALnO6CCk0SgwObQRnpd5Pt_DvCKF8dBmyVHivU6Nr_O-GusGLA@mail.gmail.com>
[2]: <https://lore.kernel.org/git/CAHLx=O=tVhtiZpaRP9TpfiBfOMS2xPe3c3=mC3VNEdBrLOioFg@mail.gmail.com>

Tyler Cipriani (3):
  push: check pushed ref for --force-if-includes
  push: fix --force-if-includes non-branch advice
  push: --force-if-includes should allow fast-forward

 Documentation/config/advice.adoc |   4 ++
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/push.c                   |  17 +++++
 builtin/send-pack.c              |   5 ++
 remote.c                         |  43 ++++++++++--
 remote.h                         |  10 ++-
 send-pack.c                      |   1 +
 t/t5533-push-cas.sh              | 115 ++++++++++++++++++++++++++++++-
 transport-helper.c               |   5 ++
 transport.c                      |   8 +++
 transport.h                      |   1 +
 12 files changed, 203 insertions(+), 8 deletions(-)

Range-diff against v5:
1:  e7912c3fd0 = 1:  e7912c3fd0 push: check pushed ref for --force-if-includes
2:  2a455d8a76 ! 2:  f85041efa8 push: fix --force-if-includes non-branch advice
    @@ Metadata
      ## Commit message ##
         push: fix --force-if-includes non-branch advice
     
    -    When a --force-if-includes push is rejected due lacking reflog to
    +    When a --force-if-includes push is rejected due to lacking a reflog to
         consult, the advice is misleading:
     
              ! [rejected] HEAD -> main (remote ref updated since checkout)
3:  1776f8d572 ! 3:  f9d97b0644 push: --force-if-includes should allow fast-forward
    @@ Metadata
      ## Commit message ##
         push: --force-if-includes should allow fast-forward
     
    -    In set_ref_status_for_push, we verify --force-if-includes's reflog
    +    In set_ref_status_for_push, we apply --force-if-includes's reflog
         reachability checks before fast-forward rules. As a result, valid
         fast-forward pushes may be rejected when a force push is unneeded; like
         when the reflog is expired:
    @@ Commit message
         documentation "Force an update only if the tip of the remote-tracking
         ref has been integrated locally."
     
    -    Instead, defer check for --force-if-includes until after determining if
    -    a push force is needed.
    +    Instead, defer reflog rejection for --force-if-includes until after
    +    determining if a force push is needed.
     
    -    Opted to create a deferred_reject_reason in set_ref_status_for_push
    -    rather than move the computation of reachability or verifiability to
    -    winnow scope of changes in this patch. Lazily checking for reachability
    -    or verifiability is a valid followup.
    +    Remember the reflog rejection reason as needs_force_reject_reason. If
    +    the fast-forward rules reject the push for a ref, show the reflog
    +    rejection reason to preserve existing behavior. But if fast-forward
    +    rules allow a push (a fast-forward, deletion, or new ref), then a force
    +    push is unneeded, the reflog rejection reason is discarded, and the push
    +    proceeds.
     
         Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
     
    @@ remote.c: void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
      	for (ref = remote_refs; ref; ref = ref->next) {
      		int force_ref_update = ref->force || force_update;
      		int reject_reason = 0;
    -+		int deferred_reject_reason = 0;
    ++		int needs_force_reject_reason = 0;
      
      		if (ref->peer_ref)
      			oidcpy(&ref->new_oid, &ref->peer_ref->new_oid);
    @@ remote.c: void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
      		 * from any reflog entry of its local ref indicating a
     -		 * possible update since checkout; reject the push.
     +		 * possible update since checkout, then remember the
    -+		 * rejection in case the push is non-fast-forward.
    ++		 * rejection in case force push is needed.
      		 */
      		if (ref->expect_old_sha1) {
      			if (!oideq(&ref->old_oid, &ref->old_oid_expect))
      				reject_reason = REF_STATUS_REJECT_STALE;
      			else if (ref->check_reachable && ref->unreachable)
     -				reject_reason =
    -+				deferred_reject_reason =
    ++				needs_force_reject_reason =
      					REF_STATUS_REJECT_REMOTE_UPDATED;
      			else if (ref->check_reachable && ref->unverifiable)
     -				reject_reason =
    -+				deferred_reject_reason =
    ++				needs_force_reject_reason =
      					REF_STATUS_REJECT_UNVERIFIABLE;
      			else
      				/*
    @@ remote.c: void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
      		}
      
     +		/*
    -+		 * If push is non-fast-forward and we were asked to
    -+		 * verify the reflog but were unable to, then reflog
    -+		 * verification is the right reject_reason.
    ++		 * If fast-forward rules rejected the push and we were
    ++		 * asked to verify the reflog but were unable to, then
    ++		 * reflog verification is the right reject_reason.
     +		 */
    -+		if (deferred_reject_reason && reject_reason)
    -+			reject_reason = deferred_reject_reason;
    ++		if (needs_force_reject_reason && reject_reason)
    ++			reject_reason = needs_force_reject_reason;
     +
      		/*
      		 * "--force" will defeat any rejection implemented
-- 
2.47.3

