Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A142BEB5
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786054754; cv=none; b=gLYhfc+unMBHkFW1AYZwXFF2qwzx5rK/MoCzL6ybgG4tH7ukNwe4WdKEvpXqkpuM9A0gRCxs+z0uC9EQZC/ZnecainELP1DFVx3I97k6vNI2b4a7m0lGgquuHTMd1oqv4eqTT7k3vyPS831ZmRqizSwdYCz+IqMe7EYveqbXWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786054754; c=relaxed/simple;
	bh=wUQpmvx1qlpme1ozMx8wypYq74NdlDIgTDrrU12A5Qw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UYCuMCL/iMQc8/bk1LtF9X82oLE8T1jHNJok8lgfYt9fefy+7IdlbwUT6tp0v5PqKyBZHIKKkFHeM/ZP7ABbqVe3pxb1cNg7dK73OdRnD/3MjLjncV+3Dqh39ic8v10VbPFMCRhsPucR7aq0kAhJmQoJ1tQ/RvqH+xQreINEaks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B6D21dDT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZVvftCiD; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B6D21dDT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZVvftCiD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9E8967A0120;
	Thu,  6 Aug 2026 18:19:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 06 Aug 2026 18:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786054750; x=1786141150; bh=jXs1DsGilp
	49qFVWeIygX2Qme5DEtM7T6zZxFEtwonQ=; b=B6D21dDTZ3fgH6hjWkKiGHClSi
	l5MTcm1ju0CzRXZAcWWPpibK7ANK6+CRCKQQnFj0Z7gP+qR4fh4IBOZ2z51TBtAH
	X7scQg3bhL1B529yLChiwaxao/NRqU43dG/4mro9VHxY6D7xwTcP5WM1Nah4R4v7
	tdEcOp7bHLSOpOZ3AiMFdZBje40/NzdiKeVKuR5VJj2yHWWPa54aVuI5PNOT3cNh
	5U1yeV0yxxfSb/rAKwG1a6/7wRp6FdSNHw4cZ45vWTvEW7MEnNif7muHhM/kLGpE
	3vG8vVKcVqeELDEkCfsYQKfA0nYGKLvwQPsEo84BwUPrkx7ChNDxOuN5JWAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786054750; x=1786141150; bh=jXs1DsGilp49qFVWeIygX2Qme5DEtM7T6zZ
	xFEtwonQ=; b=ZVvftCiDBJo/lWiUJcrkO419uHE6V+xP3+8pN0R3tZxvNV2Jf7s
	C9mcrILTve1QDZ06k602IDrGuT1t0G0flPtxt0xzILfv1zUuiuKthChB8lKQXZq7
	dro11XWaNqyFtdpqkGnEdc0juwVo9Bg9rO7FkNKEKpDXGxdrRghG7KTzVliyk7Fr
	T3OlaHeO9u7T8FM+QtNrjGhAD35Kr/e1lxFHffUAkiiYSA2hbpvNaa6WUrnKy77v
	phE/uT+RscVcLIt0O/GUnqmO4P5LZvRxRpTwIgj0Z1A6Oi0deHwpxiS/Ultxrw+V
	O0TyFDC2bX2+8lZCWFKpMw8neQ1VhG2GKLw==
X-ME-Sender: <xms:Xgh1avNy5G2MkTtQedpiDGh8iCvq6g3fxXqqHmQGFM1WoDf5uvTYLg>
    <xme:Xgh1amgqWzNrGxjFWbYL8rO71OGKlA33mCZxf5MJzdmh-OYKM5MwltTCHS7KmoUFn
    _wYO7aYFuDx9FzKQ5NAfhCW5Qk6LxfuEeGJ8bQJ6JODnylBeD_fWq0>
X-ME-Received: <xmr:Xgh1aiu3cIEk09Xxhw_d3Ua_qoGI12yx6rE9gyWnlkpc1Liuere3K8ydfqGtZKQqrkg_I1yxcp-n3qFKBAeyy-Dmz1o9uIImMQ>
X-ME-Proxy-Cause: dmFkZTFLvYKf1veR9GG6C3V4HJKoXampDThK5nZjK/O5EQTXvxJ3FRjcOHp+6Xt0sE463s
    z86eCEQ2KM9++RZM2BHSupu0rfQ/hM3HgEQuV9xfDyT0vrJOIYL15Cr5u7ViClB8DPWhQW
    ishj6PvigiovafVW1SnMMTWUABZtnzG96QECGhgXrc0K+tVH7/S/htJq1o2jNDtmhwNRxj
    QL3flCJh5L5JrA1/lhc0b4Ia8PrhxI02IOjfEXT0K2M/pVfW4lBV6cUE8EO9rx8JNJSWLu
    NPo5QF91+UmaedZsZgIu0vfijsUkrKvbnWIsXO187dq9WDhWl1jOzABpmvzLnOpAUpg/sS
    YtdSb5MQvLXwfC04q97+XikPAgn6BF6XRy86brdgmVPPVTxrQqQzfSwUDN/dW5leE+M8fL
    ueLbIU0vXiu34fMpV2CT+MmhAs4FVRgrReUefGlQ7AmAqWOSJjRH2fyoiTrpKGLeRqc8UC
    t4w12kJptI8Go3Gfu/WCx8kd82gtgA1Yju9H5P4CJry6xY0DInVII/jyFx0b4pe1mpi4Fx
    2MTWq/GHr+RVv44fL9YojEhOVBeHObcK65Wi+tSVXEfkUomTbwvZC0ltmeipQVRF8+nqno
    RnjEWO6I4eRRFyhz5bfnrW8X+7uSKM20s5bpnND2hJ4mj5gQKzuGXKYr0vVw
X-ME-Proxy: <xmx:Xgh1aqigp7eZVuvY2AEyCfUu-QhlxgJhhOhitKcD0cK9Pn2FH3-bYg>
    <xmx:Xgh1aoYvtPMHmm4R86O528knXN6LbOo2D6DYKMF_KRUuexkzI4myNA>
    <xmx:Xgh1apYX9YJknM0KC_nnDr9ZSclfjOdReM8gevX_-hkne6N3yK1pEg>
    <xmx:Xgh1atw3lFurBVFLHulJ2o7ERMvDR1Mun0jOWvcF7xXGiX4PwgEqtg>
    <xmx:Xgh1aiWJd1b_O4GfZpFlB4qFTE_tXVl2L1G1k5WIe_6cl4gTngryUyvZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 18:19:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  ttaylorr@openai.com,  me@ttaylorr.com,
  ps@pks.im,  johannes.schindelin@gmx.de,  l.s.r@web.de
Subject: Re: [GSoC PATCH v3 0/7] repack: add --drop-filtered to reclaim
 space in partial clones
In-Reply-To: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Thu, 6 Aug 2026 16:51:55 +0530")
References: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
	<20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
Date: Thu, 06 Aug 2026 15:19:08 -0700
Message-ID: <xmqqpkzuhoyr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> This is v3 of the series adding "git repack --drop-filtered" to reclaim
> disk space in partial clones by dropping large, locally-held promisor
> blobs that remain recoverable from the promisor remote. v2 was at [1].

Also I am getting a failure from t0450.

--- adoc        2026-08-06 22:05:39.038464944 +0000
+++ help        2026-08-06 22:05:39.046464970 +0000
@@ -1,4 +1,3 @@
 git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
            [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
            [--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]
-           [--filter=<filter-spec>] [--drop-filtered [--dry-run]]]
not ok 650 - repack -h output and SYNOPSIS agree
#
#                       t2s="$(adoc_to_synopsis "$builtin")" &&
#                       if test "$builtin" = "merge-tree"
#                       then
#                               test_when_finished "rm -f t2s.new" &&
#                               sed -e 's/ (deprecated)$//g' <"$t2s" >t2s.new
#                               t2s=t2s.new
#                       fi &&
#                       h2s="$(help_to_synopsis "$builtin")" &&
#
#                       # The *.adoc and -h use different spacing for the
#                       # alignment of continued usage output, normalize it.
#                       align_after_nl "$builtin" <"$t2s" >adoc &&
#                       align_after_nl "$builtin" <"$h2s" >help &&
#                       test_cmp adoc help
#
1..650


Have these patches been reviewed and tested?  Is this a new breakage
in v3?

I think the accumulated fixes so far I have are as follows, but I
suspect they need to be split and squashed into multiple patches (I
didn't check).

 Documentation/git-repack.adoc   | 2 +-
 builtin/repack.c                | 3 ++-
 t/t7706-repack-drop-filtered.sh | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git i/Documentation/git-repack.adoc w/Documentation/git-repack.adoc
index 1364d6cd49..1775fb7645 100644
--- i/Documentation/git-repack.adoc
+++ w/Documentation/git-repack.adoc
@@ -12,7 +12,7 @@ SYNOPSIS
 'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
 	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
 	[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]
-	[--filter=<filter-spec>] [--drop-filtered [--dry-run]]]
+	[--filter=<filter-spec>] [--drop-filtered [--dry-run]]
 
 DESCRIPTION
 -----------
diff --git i/builtin/repack.c w/builtin/repack.c
index 9473342843..81ec093808 100644
--- i/builtin/repack.c
+++ w/builtin/repack.c
@@ -40,7 +40,8 @@ static int write_bitmaps_given;
 static const char *const git_repack_usage[] = {
 	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
 	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
-	   "[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]"),
+	   "[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]\n"
+	   "[--filter=<filter-spec>] [--drop-filtered [--dry-run]]"),
 	NULL
 };
 
diff --git i/t/t7706-repack-drop-filtered.sh w/t/t7706-repack-drop-filtered.sh
index 6774886f1e..05d58fa456 100755
--- i/t/t7706-repack-drop-filtered.sh
+++ w/t/t7706-repack-drop-filtered.sh
@@ -142,8 +142,8 @@ test_expect_success '--drop-filtered removes the promisor blob locally' '
 		repack --drop-filtered --filter=blob:limit=1k -a &&
 
 	git -C repo cat-file --batch-all-objects --batch-check="%(objectname)" >present &&
-	! grep -q "$BIG" present &&
-	grep -q "$SMALL" present
+	test_grep ! "$BIG" present &&
+	test_grep "$SMALL" present
 '
 
 test_expect_success '--drop-filtered refuses when a merge is in progress' '
