Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DFC3EC6B2
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452666; cv=none; b=khOcPJdh0j0/02pKbHXwfnbJY11z7m1EjXCXIEGRmDrh2UVhzUr5YoA+p2hWX2kT1706g1koHt7Txj9RYTUEfd50Nr4aWywdx4ZxFx44a/5BwdwCHLqKeTuKWU+siBM+i773LQEXoh7yQPVo9S07DDfQbrBXPfgxJ3IF/j0y6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452666; c=relaxed/simple;
	bh=I/FDxq1fEp3KVqctuYGAXK1dfBtx50JWu2x79o7WOXg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc:
	 MIME-Version:Content-Type; b=ZuroEW6oZDoq0lGA7XLX9STBNYpsLZiJawbK5Y/f0u7ln9n6Gptgl6JgAMQGURAl8MLh0eOgjf3Al+x6pnR+WcJ3epJ4Sp8I2PPJ7XL7Y70d7dq9ibIOVs5XPOxFXEVh0rnRHjAmafVTf82xJ4UpRF1e4UawLj1jr6d7AHUkaz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQ40498w; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ40498w"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2acc1e170cso445578766b.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 02:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791452663; x=1792057463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :date:from:references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n0ThjQYpiIe7ezddZZqmPoRGXhJ5dLPk+3cZgL+rCL4=;
        b=jQ40498wcUj8/Ww73+pH4DJunmCLmwSXBKa8o2v1dkBPuKChB5eg0atdTWCauUwT5E
         KrtdD8iDPcczB0/nkp365oGixfSS/7JGKfFl0jieB7ZJuISVGDuHHWLQ6fSjetzTJ8XY
         YXshPm+6eEapcvmoPZb2ug7oIS/cr2XrCca1Q2gwlp3/XW5GO1dxhCPDCKNfBlmtRFzo
         gwMylK4h+xb+ar01WE5eek8/W5azQ8UIxYEAswzTupL6lF1SNQ2k+6mJAt+asUCcjcxb
         mEjv5AfDxL7chhi24crjlEkiw5ouyLzsVeC8lIVJ5tbmYztKfb6lpmvsjaw69GTIKMZS
         lPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791452663; x=1792057463;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n0ThjQYpiIe7ezddZZqmPoRGXhJ5dLPk+3cZgL+rCL4=;
        b=08O6VDZ8yKHkwvi6AfCAsBydwhFHGGG1S4aIevnBflpJcjW9aO7/HmWW7fAYp+4KzA
         a7mJUMfERCXtAz0i+MwSWgBoeN0cUhEOgwsiSwNsqy+H78r8JJGLQ7uKkQvkjE9o7IEB
         68+3Ge5OF3yL+vMRu78YPzw/eXlRlc8Yu9zO/5Xu6d4OhLvIqrJkXlXh0suDIHUhFYLG
         wB0P73NN3Aw5OmtYozHIon5Gv5btMAstE7NXT1BgO4GUryxd8hmn83vn5yl2SkHtwTjb
         8RCRC0NMtOvNZ02CF8F6YLn5ssVqtBIh1goiHgYLcdGMoCEvyUoaJexwVfGpVG3w26wj
         TbUw==
X-Gm-Message-State: AFuF++l8Se5hUqISih7mseARyfeKPNC4/xQY6MemCrxMkoZV0JhlWHvT
	Y/Snk+2gNJGGayI2JZfQSoSa8/AlMAjymPmlY5VH0uWNb8mnVc5XxDV2PeCakQ==
X-Gm-Gg: AYBFou07Z/hlaGcT0czdnK1vgydy/ZHcsTxrsf9oGR4NbSkXAXfTrIwz/hAmboe2BmR
	ld2iWg/VgAHAkgR5Ol6T9pfdj4pijwDuutJDsqd7+6evInSkf/tJXaYnLZC1zRI6R/0mMYgHRds
	eTnIazVKnIZDXlRj1LazIXXzOvVF9jrW4UFfyoVQnUj+OLqvr/1I5MLot2N2to7Eg7VKymDOdYh
	7NDGPw4K+LlPX6efvH2Xnxy0++Skh6B5/G6DEKJbgWbltLvMfkXR3cJ9kFvL/po3LYvajo5KFQt
	tH1ROGw9wqmv0dPeCjhGOh5G5NpxLDEp9vJ8/CYmfzSWUV09OJuiTF4PQsno4PzZYQO/Dqhswx/
	TETLh7CnmJhjJ5nkxprQmP3opRf038lr4gO7geKSJ1EFHsdX1CLIsiSQ/whXin5A849Rf4jwQ67
	aZqsRKhp0ZF9dr45IzIzvtVBzeNQ+ZcAwrgnnzHTHWeglGh8BSOu7Y0MrVpbIVgQU9fBpCzyKE/
	azZzLqFwSjaChMcVcBR4LCtVqGWdqkc34xjOSd6xuFJmtFgJNl3UbJ1227qsd2aQQPHJHaFP6Ol
	3+br8zqAguZ0sO8X6Lwjb8xqUy0Nb1IpOksDXb6tRwO0lK2NnQWoSxrLNGYf5j9x946PGOtzhvj
	/k85JSy+xqnD0vHAiPiuuIHIXbYmU8f8WkPTE64IG9PU=
X-Received: by 2002:a17:907:7f8d:b0:c26:3107:71bb with SMTP id a640c23a62f3a-c317be34e66mr478983566b.24.1791452662730;
        Thu, 08 Oct 2026 02:44:22 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([192.166.203.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c318ae45e19sm114188366b.61.2026.10.08.02.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:44:22 -0700 (PDT)
Message-Id: <cover.1791452597.git.maciej.ciemborowicz@gmail.com>
In-Reply-To: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Thu, 08 Oct 2026 11:44:15 +0200
Subject: [PATCH v4 0/4] refs: run copy and rename through transactions
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
it sees neither endpoint. This series represents the logical ref updates
and reflog history through ordinary transactions, allowing hooks to
observe and reject the operation.

Junio, thank you for reporting the t0600 and t5510 failures in v3. I
reproduced both on macOS with the original base as well. I had not run
those suites before submitting v3; they were outside the test selection
reported in that cover letter. That was a gap in my validation, and I
am sorry for sending the regression.

Patch 2 added a call to prepare_reflog_replacements() after preparing the
packed transaction. If packed preparation failed, its error was saved in
ret, but the new call overwrote it with success. The files transaction
could then proceed despite the failure to prepare packed-refs. The fix
jumps to cleanup after freeing the failed packed transaction, preserving
the error and releasing the remaining resources. The existing t0600.16
and t5510.35 cover this path; their expectations have not been changed.

Changes since v3:

* Rebase onto 6de20f6092 (The 4th batch, 2026-10-06), the master commit
  used in Junio's report.
* Preserve the packed preparation error in patch 2 as described above.
* Register t1425 and t1424 in t/meson.build in the commits adding them.

The four-patch structure and implementation otherwise remain unchanged.
This iteration does not address the concern about the size of the main
patch; the range-diff below isolates the correction and registrations.

I ran the complete standard core test collection, including the unit-test
executable, on macOS/arm64 with each default ref backend:

  files:    Files=1064, Tests=34710, Result: PASS
  reftable: Files=1064, Tests=34712, Result: PASS

Both full runs include successful t0600, t5510, t1424 and t1425 runs.
The build enables Perl, Python, cURL and gettext. The files run used:

  LC_ALL=C make -j8 PYTHON_PATH=/opt/homebrew/bin/python3 \
    GNU_GETTEXT_PATH=/opt/homebrew/opt/gettext \
    DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS='--jobs 8' test

The reftable run used GIT_TEST_DEFAULT_REF_FORMAT=reftable and ran every
t[0-9][0-9][0-9][0-9]-*.sh plus unit-tests/bin/unit-tests through prove,
with four jobs and a separate TEST_OUTPUT_DIRECTORY. Backend-specific
suites can override the default. The Meson registration check and
git diff --check also pass. The contrib test target completed with no
unexpected failures; diff-highlight retains two known TODO failures.

The harness totals include skips and expected failures. The files run
skipped 126 whole scripts, mostly for unavailable SVN, Perforce and CVS
tools. Other skips include GPG, JGit, Windows-specific tests, tests
requiring sudo or writable /, case-sensitive filesystem tests, the
opt-in 2GB clone test, and t5564 because its web-server setup failed.
There are also individual prerequisite-based skips within suites.
I have not validated this iteration on Linux or Windows.

The performance trade-off described in v3 remains: replaying history
uses O(N) time and memory, replacing the files backend's constant-time
reflog rename. The measurements in patch 3 are from the v3 base, not a
new benchmark on this base. Files transactions also remain non-atomic
with respect to process crashes and failures late in finish.

Previous iteration:
https://lore.kernel.org/git/cover.1791395643.git.maciej.ciemborowicz@gmail.com/

Maciej Ciemborowicz (4):
  refs: distinguish internal transactions from logical updates
  refs: support replacing reflogs in a transaction
  refs: run copy and rename through ordinary transactions
  refs: remove backend-specific copy and rename callbacks

 Documentation/githooks.adoc     |  10 +
 refs.c                          | 200 ++++++++-
 refs.h                          |  25 ++
 refs/debug.c                    |  24 --
 refs/files-backend.c            | 740 +++++++++++++++++---------------
 refs/packed-backend.c           |   2 -
 refs/refs-internal.h            |  28 +-
 refs/reftable-backend.c         | 334 ++------------
 t/helper/test-ref-store.c       |  76 ++++
 t/meson.build                   |   2 +
 t/perf/p1424-ref-copy-rename.sh |  48 +++
 t/t1424-ref-copy-transaction.sh | 352 +++++++++++++++
 t/t1425-reflog-transaction.sh   |  59 +++
 13 files changed, 1209 insertions(+), 691 deletions(-)
 create mode 100755 t/perf/p1424-ref-copy-rename.sh
 create mode 100755 t/t1424-ref-copy-transaction.sh
 create mode 100755 t/t1425-reflog-transaction.sh

Range-diff against v3:
1:  6d7c146e57 = 1:  948927d8fb refs: distinguish internal transactions from logical updates
2:  5c3ec4eb49 ! 2:  d023da3c09 refs: support replacing reflogs in a transaction
    @@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref
      	transaction->backend_data = backend_data;
      
      	/*
    +@@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref_store,
    + 			if (ret) {
    + 				ref_transaction_free(packed_transaction);
    + 				backend_data->packed_transaction = NULL;
    ++				goto cleanup;
    + 			}
    + 		} else {
    + 			/*
     @@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref_store,
      		}
      	}
    @@ t/helper/test-ref-store.c: static struct command commands[] = {
      	{ "for-each-ref--exclude", cmd_for_each_ref__exclude },
      	{ "resolve-ref", cmd_resolve_ref },
     
    + ## t/meson.build ##
    +@@ t/meson.build: integration_tests = [
    +   't1421-reflog-write.sh',
    +   't1422-show-ref-exists.sh',
    +   't1423-ref-backend.sh',
    ++  't1425-reflog-transaction.sh',
    +   't1430-bad-ref-name.sh',
    +   't1450-fsck.sh',
    +   't1451-fsck-buffer.sh',
    +
      ## t/t1425-reflog-transaction.sh (new) ##
     @@
     +#!/bin/sh
3:  77af4e809c ! 3:  150349f9d0 refs: run copy and rename through ordinary transactions
    @@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref
     -		if (update->flags & REF_DELETING &&
     +		if (update->flags & (REF_DELETING | REF_NEEDS_PACK) &&
      		    !(update->flags & REF_LOG_ONLY) &&
    - 		    !(update->flags & REF_IS_PRUNING)) {
    - 			/*
    + 		    !(update->flags & REF_IS_PRUNING) &&
    + 		    !is_root_ref(update->refname)) {
     @@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref_store,
      					REF_HAVE_NEW | REF_NO_DEREF,
      					&update->new_oid, NULL, NULL,
    @@ t/helper/test-ref-store.c: static struct command commands[] = {
      	{ "for-each-ref--exclude", cmd_for_each_ref__exclude },
      	{ "resolve-ref", cmd_resolve_ref },
     
    + ## t/meson.build ##
    +@@ t/meson.build: integration_tests = [
    +   't1421-reflog-write.sh',
    +   't1422-show-ref-exists.sh',
    +   't1423-ref-backend.sh',
    ++  't1424-ref-copy-transaction.sh',
    +   't1425-reflog-transaction.sh',
    +   't1430-bad-ref-name.sh',
    +   't1450-fsck.sh',
    +
      ## t/perf/p1424-ref-copy-rename.sh (new) ##
     @@
     +#!/bin/sh
4:  83fa644fb3 = 4:  f3f2c7ee11 refs: remove backend-specific copy and rename callbacks

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
2.39.3 (Apple Git-146)
