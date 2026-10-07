Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E3A4D9F78
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396319; cv=none; b=gtYi4d4A6URYIlN3CIXSIlXlJKOBGiPua+kjgRg2YP+Usvvh5o811nTRfg+MjLdOPKjXN9PEIz7aqJkC3C/lMh23XBKtr3QpJ1SddMpSF7i7tusip9cT+M6drebJNgOdEx5KJu/QPWg8XKIXUHNofUSIsxx476PAHFkZLrLs93w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396319; c=relaxed/simple;
	bh=mhCPTVp41rMdDFc/bDnFvmbKTWtnEjriCqbvDdcmhm8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc:
	 MIME-Version:Content-Type; b=WEjG+0Z434e7TaOYFPsvSUPf12Gr6h0nS/K8C32XcM8VXrBnpdxF0uloYBwRBbodpIuAq18UZ6x9Ru8Wp7TEJgqL2/wV2tZTiaRB5JZYecdKkxp/ZazSqJeoFXRuNWAiOrDPtEE6fsJKOokJ6US3+W2CU1C2gXwdnQwhurcwnAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGbSk+AG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGbSk+AG"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2e8e738ae0so321500066b.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 11:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791396316; x=1792001116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :date:from:references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B64tLgJv1Hb7KJGOkumXlmXS+feVl2pNhBA8LSZza6U=;
        b=NGbSk+AGE1h++C2B0zMPhsM+ozsKEGSmRKz+NV3CJxqF3rUmRm7q3PGQWEvsUJZtMB
         GS6qNPSAzUkoYriC1EAVMS2hh4yUEUBcx7a4tbwXelQmKU31Af4vPIWQI4jVw3sX7rfW
         +mAKIiXnozOpHLdroMF/QUPQvDd0IZsrg8nXevBpRvZkI0UMRAt8OfT6KOThKUitJ/6n
         z/dQqQXR8KJUcyEHP0YcHkq+KiAejvbMeaL1eZVlCAeampS/2EIejm3AdmDAmzxK8zSO
         593OhqxtN4ZxEYR4gfQ2zzoMYo9JkEvXwfNNZB+NugbA99HW4IilG6tTL+XI92bXOSEa
         OHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791396316; x=1792001116;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B64tLgJv1Hb7KJGOkumXlmXS+feVl2pNhBA8LSZza6U=;
        b=ORbz2kR9r+O6QS2Tq9/hvVh7Cafv167kI2yRTre8N5lpkZxnwmGhgalNXql+CaRj9R
         HZ5scv4DSCRUDaziOoH9/v/YVfAFHm4cMv3UG9nfYCpmQ4NJgbn0qxwru0N+FWiEYH+y
         52Qej00pHqCOEcv8QpwX4h0PSoox5r+apWV3jzqYMABX+j3A0pPWY2jhdEIqFpPvs9HJ
         tDiUbQGJEJ5EcMmZ0cNrB0PrMrJpPaz6MAXFwGuNE6hExKkfbv+TCVPEiwC8o6rvqU/L
         mTFsI1HUt9q5MzboHVKXw/G6FacezMo990Tuh0P0xDdRXaolWox8wUJHKEvovIpq8dnD
         TFdw==
X-Gm-Message-State: AFuF++m+CBj2sDB0GguzUJbjjLyTjdIPFWcVvOUXTAc+7oxjujoIcPXE
	T+Q1sk/3yLyRKlmomd4oV+24AIoIuHKaQJo/vIxzDVXwXn1sV0oQ5gDHt06ytgfx
X-Gm-Gg: AYBFou3Ax9dvT667si+6CFIaeQ0VtVRSZRGMWrOdYLgAV/pTw878zX9YldIKb1Emru7
	FlKalkZNC6vLphBJfdb9XSsMAREVDyIwm8+4645i3ou42ZDafnWnu1vH33ELcfsCpHL4p2OXaVE
	5SlaEczJwae1GrwaeoDzuiz/FXYRxmh2zjxbR34AfNCwA2PapMa2ucAGAMC+T+sFc3sC/npH9KF
	RC0wroS8p8b91/JTvbyNBoqaqfkQapKSmHCHWrGWiBkL+aKsqOpVTfDmnPV1UsiBPcJz8JN1m0Z
	vwtIhPkqOGjmaFGq+kwx/ncHbfL2ocTeQS+y/xFSVOj089IYYiuKhGknxHTu8TnsPZlk+K8oXI7
	CJuQ2wkWsJaRrcsR4DH+sdak9T2wXNsxC+dCOLg9AQCGsKIpIhp4mmGDBnQbi+hGYwro88PA9q6
	RA21dWj0a4047qP3lnSpbyZ728rWY6xq2BfbhaiJmPxst3aT0fsgk6oKV84nTiqgfeGMqCbxa+h
	OA1OBZ5GRIPnYvlvO4H6JT7pqzyWdGhybOkAbmqYl/+q5ahRO/ZTjg8NIsirmAAEnWoj0jXsBW6
	tYo0ddVbPo/bT6AF3XzIhkt4znwFVwXd8lHQuFslOT5A5r7SYfYV/lV4NZcVIJPfxoJ+Blv1BtS
	eGjXUMJ4Yuw432lkGHrRDTFxcPyxJiiunLFVQRT88
X-Received: by 2002:a17:907:d01:b0:c26:1649:47af with SMTP id a640c23a62f3a-c317c06f9d9mr303275766b.37.1791396315776;
        Wed, 07 Oct 2026 11:05:15 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([37.31.50.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c317c2f19bdsm129986066b.47.2026.10.07.11.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:05:15 -0700 (PDT)
Message-Id: <cover.1791395643.git.maciej.ciemborowicz@gmail.com>
In-Reply-To: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Wed, 07 Oct 2026 20:05:13 +0200
Subject: [PATCH v3 0/4] refs: run copy and rename through transactions
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Karthik Nayak <karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Reference copy and rename bypass the transaction API. With files, the
reference-transaction hook sees only the source deletion; with reftable,
it sees neither endpoint. This series puts the logical ref updates and
the reflog history into ordinary transactions so hooks can observe and
reject the complete operation.

Thanks to Patrick, Junio and Karthik for their feedback. Following the
review of v2, this version uses ref_transaction_update_reflog(), the API
used by backend migration, to replay history. A new
ref_transaction_replace_reflog() operation supplies the missing ability
to discard destination history before installing the queued entries.

Changes since v2:

* Split the work into four patches: internal hook suppression, reflog
  replacement, copy/rename integration, and removal of the old callbacks.
* Remove the special copy/rename dispatch from backend prepare, finish
  and abort. Each destination points to its source update, so multiple
  copies, renames and ordinary updates can share one transaction.
* Keep the hook-suppression flag private and check it centrally in
  run_transaction_hook(). It is used for the physical packed-refs child
  transaction, whose changes the parent already reports.
* Drop the pre-lock snapshot revalidation. A preparing hook may change
  the source; prepared and committed report the value read under lock.
  Copy sources are locked but are not reported as changes to the hook.
* Stage reflog replacements during prepare. A prepared veto discards
  staging files without restoring old values over live refs or changing
  the source, destination or HEAD history.
* Add coverage for complete reflog contents, mixed transactions, hook
  vetoes, source races and failure paths, and measure the performance
  cost of replaying history.

Backend-specific work remains necessary to implement the transaction
primitives. Files stages logs beside logs/refs using unique temporary
files. For directory/file conflicts and case-only renames, it queues
the destination in packed-refs: the loose source cannot remain visible
while also making room for a loose destination lock. During finish, a
backup preserves the source log until the destination log is installed;
an installation error restores that backup. Reftable writes tombstones
for old destination entries in the same table as the replacement.

The backends' final reflog records remain distinct: files appends
old->old; reftable appends old->zero and zero->old for rename, or
zero->old for copy. Forced reftable copies do change behavior: unrelated
destination history is replaced by source history, matching files when
the source has a reflog.

Replaying history requires O(N) time and memory. Buffered staging avoids
a write system call per entry, but files rename loses its constant-time
reflog move. On macOS/arm64, with no hook configured, median milliseconds
per operation over seven samples of ten operations were:

                    entries       base        v3
  files copy             10       5.05      5.08
  files rename           10       4.88      5.26
  files copy          10000      13.20     16.11
  files rename        10000       5.09     17.09
  reftable copy          10       5.25      6.11
  reftable rename        10       5.81      6.50
  reftable copy       10000      53.39     68.06
  reftable rename     10000      43.44     54.06

Process startup is included. Copy overwrites the same destination;
rename alternates between two names. Reftable starts from a migration
of the same files fixture. Repeated operations add normal log entries
and incur normal reftable compaction. Patch 3 adds
t/perf/p1424-ref-copy-rename.sh; these measurements used a separate
monotonic-clock driver because GNU time is not installed here. The
files rename regression is a cost of this design, not just hook overhead.

Validation covered 15 relevant suites with files and reftable, including
branch, update-ref, hooks, migration, reflogs and worktree refs. The two
new suites contain 34 tests, with backend-specific skips; they also
passed with SHA-256 and AddressSanitizer/UndefinedBehaviorSanitizer.
The reflog prerequisite and main change were tested as intermediate
trees. This was not a full test-suite run or a Linux/Windows run.

Files transactions are still not crash-atomic. A later failure in
finish may leave partial ref changes, as with ordinary transactions.
The source-log backup covers an installation error, not a process crash.
Unrelated nested renames can also contend for the global packed-refs
lock.

The base is 0f8e75abeb. This series is independent of the separate
batched-deletion old-OID fix discussed elsewhere in the thread.

Original patch:
https://lore.kernel.org/git/20260920165037.88524-1-maciej.ciemborowicz@gmail.com/

The range-diff below treats the rewritten and split implementation as
four new commits, so the changes above describe the mapping from v2.

Maciej Ciemborowicz (4):
  refs: distinguish internal transactions from logical updates
  refs: support replacing reflogs in a transaction
  refs: run copy and rename through ordinary transactions
  refs: remove backend-specific copy and rename callbacks

 Documentation/githooks.adoc     |  10 +
 refs.c                          | 200 ++++++++-
 refs.h                          |  25 ++
 refs/debug.c                    |  24 --
 refs/files-backend.c            | 739 +++++++++++++++++---------------
 refs/packed-backend.c           |   2 -
 refs/refs-internal.h            |  28 +-
 refs/reftable-backend.c         | 334 ++-------------
 t/helper/test-ref-store.c       |  76 ++++
 t/perf/p1424-ref-copy-rename.sh |  48 +++
 t/t1424-ref-copy-transaction.sh | 352 +++++++++++++++
 t/t1425-reflog-transaction.sh   |  59 +++
 12 files changed, 1206 insertions(+), 691 deletions(-)
 create mode 100755 t/perf/p1424-ref-copy-rename.sh
 create mode 100755 t/t1424-ref-copy-transaction.sh
 create mode 100755 t/t1425-reflog-transaction.sh

Range-diff against v2:
1:  d852537d8c < -:  ---------- refs: run copy and rename through transactions
-:  ---------- > 1:  6d7c146e57 refs: distinguish internal transactions from logical updates
-:  ---------- > 2:  5c3ec4eb49 refs: support replacing reflogs in a transaction
-:  ---------- > 3:  77af4e809c refs: run copy and rename through ordinary transactions
-:  ---------- > 4:  83fa644fb3 refs: remove backend-specific copy and rename callbacks

base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
-- 
2.39.3 (Apple Git-146)
