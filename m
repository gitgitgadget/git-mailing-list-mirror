Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37E43DAAB1
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170540; cv=none; b=QskdUDliEV+ZroCDW4z0n+phSAmpL6Zp4oAjVjd7tjPUv5CT1tIK/A2LuRcztjA/TaFEojl89CzT+W3iCHceLCb2GJFQ0CDtKJJmB4DqBLHUWecaGnwplux0GUHYTrFX4fr5YKFyPwlofyel8SQIY0ifCuBCkAUOtFQ3tnzHT4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170540; c=relaxed/simple;
	bh=PLBHmCEg0R8e6D0yZLQcA2obAwRTMqbZiaHGIt0RHo0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=dJVxB2DVqMhRsvki+2bFfyF5lrylM2dpmlTnvy+6wtkbN//6KiMKC+MZGUslH6R6jB2YPR8J1toDFW2ofvN5aAusdBx5PFV+wSuMDGUje6BV60ZnhkArfoo10oN1v75WKgWyScK/YTi8oVgQYfJBGWUFy6Fn5ellJnqprEyqopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D5kk3ov0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iOoxp2Z1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D5kk3ov0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iOoxp2Z1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id F14E31D000EE;
	Mon, 31 Aug 2026 06:02:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 31 Aug 2026 06:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788170537;
	 x=1788256937; bh=3y0rpsz+0zLq0OpUv63JoEXB/IQCPOMQE+63FrmC9jE=; b=
	D5kk3ov0RIegAmkolAtBHAYZGgpJ6f4TxFZDP3Z+qU8VL5osCw9/1hGsbebs1JYh
	G1lrsjcJPtM/kxaL4tGmqkJsbXgIUEdtgkM7Dkv/5DwTxuQq5pRPiMRNw4f0DiB4
	F2vvBIp3b/GGsKwYhRN7qZn7Y50+v1tNho13nivxwlYWN9hx0CYoinNbe+CLe3+P
	j/+tSGyqhxMFNe0xUh/S4Gd0AUF/jXqzZ/TMd5Rocd4rxk11lyj82GnUJbxlUXx0
	zOdBsLas/M6eZ711Mk1TGnCV30OFFXcDzkyFIPuYOyITU/kNHVV4DzUVnjsGO+v7
	82janNdTmxRtfq06z9zaag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788170537; x=
	1788256937; bh=3y0rpsz+0zLq0OpUv63JoEXB/IQCPOMQE+63FrmC9jE=; b=i
	Ooxp2Z14LUuVzbF+eJdKK2nimYpaekrcwTwk045kPqu27Tmn/8cxC/ghGOQSVdSB
	J2NRkXussO2oCykD+GVJFrfIqwVlJ49+Pp4vJrBncKx3rPzS8m1wtEJvISGIcJHn
	Fpbi+UCZt4GtSA5XPKF8tQ53ZOCvkOdz6su/txP+gLcuzwDxgMJnlLiUT2W40DuT
	0fUe4o/P+znqsrzZLyICpbwznJCMYd2V4qPxUG/B89niew9y92U7PrgYaSlCqZ8k
	gBPVMjdMCGc0M7rtYI3G74NpSjwXFNTFglo3zQJz1d6hkw9cCyqC75GsOp/QRJW0
	vwPFURBUDo1L7fMBSMRuA==
X-ME-Sender: <xms:KVGVatZzmnPZYZdmAfrm9Sc3-jt0F4Z63ILm4iae9_OtVaoYWtFWlQ>
    <xme:KVGVar2N7wsKgaNpgaHbsfd_35t14I_14M7r_1DNr3-SLp4Odx1SfYZz0jQx1-7Gx
    1uhnJ9CxtkCV90nik1yfGdt8_bHuw4MvntSw99KU3FNkBqYp_aSWg>
X-ME-Received: <xmr:KVGVatUvERMXuWZHtR23cDWmpI-eB9-TwFp7s4ZD3MkveaIZ1QE2X2gkcHvaMOkKe6NLxg>
X-ME-Proxy-Cause: dmFkZTFWJgIf5bg152NUX9m1/rmBaKtW+nC7SARPEgSJBFcBby708fANdjp9sc5oejbM65
    NbI687YBYeLXUSIZO6QjSfSse8ob0mFxIsntjdsoFNTIzF2pIqwYXYts/liEu3xi1nSu6t
    Vn73qd2wRCwEf1gYe3wm23Qt4xe0x0CDg4+SOIvMlGxz+xmFlho3hexx4Ec7vVCgwAM7PB
    gAH5wNBJA0t1VgxEw7r8dETlsn9n+DP8KR6a72qcLaXiVedE/pdFapGwsBNo9Vtz1v5xop
    xaHgzmLVWvka5ZukqyX6nQtE1KhnbbGwE/zWpbqVwARrkKSWmfMekkt4HsAE/yRONQuEm3
    tdLQ2S9VM07kjc3hR3m15t/EySBkbT7GjxcvAycz3aJlQ7nFMqzxzxlr6Gra1M4pYyVvoQ
    ajwwMMDgsBQkQT0E7faKpM0Oz9+udABBSVFBh/wS5wqj9LByJ+qlU38o5f4P+BS9xwYv4m
    zsELL9gKKS4odw1EMpHlmL8UR5Nn4rxhSRzzjMlPerN4ZrgTjh49uD0fjLTmtfVrcJFfN2
    xQ1cy/vO5BvL9NZxB1+KCe7Gyrk9nh70lxROQkP0g7cG98jb4dz5h4kNdFjtWyIKQRFDeF
    Y5Mi+l6/EihXDoYaNvpuSuYQ1IU4PpslapoijkMATHEFHdEy6zgJXf65aMkg
X-ME-Proxy: <xmx:KVGValU_cUaJYIs1lGFAR0Bvq5u1sUtH5af5-BeCCNYtRAQ4LrHiuQ>
    <xmx:KVGVasfQ2z_gNDMqpTcp0gO_AGZyFjxy6Oas3FlOEe_NRcuw5A2fJg>
    <xmx:KVGVauUvMMJfxNIymXs2Dijdt2w-GsuejCXtes1PrspEFO45S0S8aA>
    <xmx:KVGValcseyQyTtKDj0bLKFhQvnpfJAr_2PF8FT_adCYylMGlh-dKhA>
    <xmx:KVGVank4wDugFU_dc68xwNg3q3-UoBUQXyN02mwS6XSexn0qR9TcE6r4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 06:02:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0fb5103 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 10:02:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/8] odb: write alternates at creation time
Date: Mon, 31 Aug 2026 12:02:04 +0200
Message-Id: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOWw6CMBREt0L67TVteUT8Yh+Gj7Zc5ao80l5RQ
 9i7Bd2AnyeZmTOzCOgJgzgms/A4UaChj6B3iXCt6S8I1EQWWupCHlQK4y3A0Fh4emIEc2f0vWE
 MYBicR8NxAJg6hCKTSjZoy8xIEfdGj2d6ba5T/eXwsFd0vArWREuBB//ezkxqzf28Ov/DOymQU
 CqVq9SaMndpFbt76kS9LMsH+eWsY/EAAAA=
X-Change-ID: 20260813-pks-odb-write-alternates-at-creation-time-64010deb94a0
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

writing alternates into the object database currently happens via
`odb_source_write_alternate()`. But while that creates the ability to
create alternates at arbitrary points of a source's lifetime, we don't
use that functionality in the first place. Instead, we only ever write
alternates when creating a new repository.

This design is suboptimal due to a couple of reasons:

  - It requires us to have a `write_alternates()` callback, which is
    overblown as we never even write alternates to an object database
    after it has been created.

  - We're about to make alternates an implementation detail of the
    object database's backend in a future patch series, so alternate
    implementations may not even support them.

  - The backend has more flexibility with how exactly alternates are
    configured when it itself is in full control over their setup at the
    time where it creates the object database itself.

This patch series thus refactors how we handle alternates so that we
don't write them ad-hoc anymore. Instead, the series introduces a new
option for `odb_source_create_on_disk()` that makes it handle those
alternates at creation time.

This is part of the bigger goal of moving handling of alternates into
the "files" backend.

This series is built on top of 2c3adbb2c4 (The 18th batch, 2026-08-24)
with ps/odb-eagerly-load-alternates at 0076dc9f81 (odb: drop
`alternates_db` field, 2026-08-17) merged into it.

Changes in v2:
  - Use a lockfile to write "info/alternates" during creation time.
  - Remove useless "strvec.h" include by reordering declarations a bit.
  - Link to v1: https://patch.msgid.link/20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (8):
      builtin/clone: defer setup of the object database
      builtin/clone: move around `setup_reference()`
      builtin/clone: refactor handling of "--reference{,-if-able}"
      builtin/clone: move setup of alternates for shared local clones
      builtin/clone: move setup of alternates for non-shared local clones
      odb/source: support writing alternates when creating the database
      builtin/clone: write alternates via `odb_create_on_disk()`
      odb/source: remove the ability to write alternates

 builtin/clone.c            | 108 +++++++++++++++++++++++--------------
 odb.c                      |   9 ----
 odb.h                      |   7 ---
 odb/source-files.c         | 130 ++++++++++++++++++++++++++-------------------
 odb/source-inmemory.c      |   7 ---
 odb/source-loose.c         |   7 ---
 odb/source-packed.c        |   7 ---
 odb/source.h               |  43 +++++----------
 setup.c                    |  15 ++++--
 setup.h                    |  15 ++++--
 t/t5604-clone-reference.sh |  25 +++++++++
 11 files changed, 203 insertions(+), 170 deletions(-)

Range-diff versus v1:

1:  85b01b6b1b = 1:  ca4f283e20 builtin/clone: defer setup of the object database
2:  1e131d0a84 = 2:  4849b826ed builtin/clone: move around `setup_reference()`
3:  a6d33bf077 = 3:  870b994a9d builtin/clone: refactor handling of "--reference{,-if-able}"
4:  fd88a949f5 = 4:  6268e14ecb builtin/clone: move setup of alternates for shared local clones
5:  e18f135daa = 5:  c148c65508 builtin/clone: move setup of alternates for non-shared local clones
6:  e0733d5d63 ! 6:  360b8e83db odb/source: support writing alternates when creating the database
    @@ odb/source-files.c: static void odb_source_files_close(struct odb_source *source
     +static int odb_source_files_create_on_disk(struct odb_source *source,
     +					   const struct odb_create_on_disk_options *opts)
      {
    ++	struct lock_file alternates_lock = LOCK_INIT;
      	struct strbuf path = STRBUF_INIT;
     +	struct strset seen = STRSET_INIT;
     +	struct strbuf line = STRBUF_INIT;
    -+	FILE *f = NULL;
     +	int ret;
      
      	safe_create_dir(source->odb->repo, source->path, 1);
    @@ odb/source-files.c: static int odb_source_files_create_on_disk(struct odb_source
      	safe_create_dir(source->odb->repo, path.buf, 1);
      
     +	if (opts->alternates && opts->alternates->nr) {
    ++		FILE *alternates, *orig;
    ++
     +		strbuf_reset(&path);
     +		strbuf_addf(&path, "%s/info/alternates", source->path);
     +
    ++		repo_hold_lock_file_for_update(source->odb->repo, &alternates_lock,
    ++					       path.buf, LOCK_DIE_ON_ERROR);
    ++
    ++		alternates = fdopen_lock_file(&alternates_lock, "w");
    ++		if (!alternates) {
    ++			ret = error_errno(_("unable to fdopen alternates lockfile"));
    ++			goto out;
    ++		}
    ++
     +		/*
     +		 * The alternates file may already exist, e.g. when it has been
     +		 * seeded from a template directory. Read any preexisting
     +		 * entries so that we don't end up writing duplicates.
     +		 */
    -+		f = fopen(path.buf, "r");
    -+		if (f) {
    -+			while (strbuf_getline(&line, f) != EOF)
    ++		orig = fopen(path.buf, "r");
    ++		if (orig) {
    ++			while (strbuf_getline(&line, orig) != EOF) {
     +				strset_add(&seen, line.buf);
    ++				fprintf(alternates, "%s\n", line.buf);
    ++			}
     +
    -+			if (ferror(f)) {
    ++			if (ferror(orig)) {
     +				ret = error_errno(_("unable to read alternates file"));
    ++				fclose(orig);
     +				goto out;
     +			}
     +
    -+			fclose(f);
    ++			fclose(orig);
     +		} else if (errno != ENOENT) {
     +			ret = error_errno(_("unable to read alternates file"));
     +			goto out;
     +		}
     +
    -+		f = fopen(path.buf, "a");
    -+		if (!f) {
    -+			ret = error_errno(_("unable to open alternates file for writing"));
    -+			goto out;
    -+		}
    -+
     +		for (size_t i = 0; i < opts->alternates->nr; i++) {
     +			const char *alternate = opts->alternates->v[i];
    -+
     +			if (!strset_add(&seen, alternate))
     +				continue;
    -+
    -+			fprintf(f, "%s\n", alternate);
    ++			fprintf(alternates, "%s\n", alternate);
     +		}
     +
    -+		if (ferror(f)) {
    ++		if (ferror(alternates)) {
     +			ret = error_errno(_("unable to write alternates file"));
     +			goto out;
     +		}
     +
    -+		ret = fclose(f);
    -+		f = NULL;
    -+		if (ret) {
    -+			ret = error_errno(_("unable to write alternates file"));
    ++		if (commit_lock_file(&alternates_lock)) {
    ++			ret = error_errno(_("unable to commit alternates file"));
     +			goto out;
     +		}
     +	}
    @@ odb/source-files.c: static int odb_source_files_create_on_disk(struct odb_source
     +	ret = 0;
     +
     +out:
    -+	if (f)
    -+		fclose(f);
    ++	rollback_lock_file(&alternates_lock);
     +	strbuf_release(&line);
      	strbuf_release(&path);
     -	return 0;
    @@ odb/source-files.c: static int odb_source_files_create_on_disk(struct odb_source
      static void odb_source_files_prepare(struct odb_source *source,
     
      ## odb/source.h ##
    -@@
    - #include "object.h"
    - #include "odb.h"
    - #include "odb/transaction.h"
    -+#include "strvec.h"
    - 
    - enum odb_source_type {
    - 	/*
    -@@ odb/source.h: enum odb_source_type {
    - 	ODB_SOURCE_INMEMORY,
    - };
    +@@ odb/source.h: struct object_id;
    + struct odb_stream;
    + struct strvec;
      
     +struct odb_create_on_disk_options {
     +	/*
    @@ odb/source.h: enum odb_source_type {
     +};
     +
      /*
    -  * Convert between the enum and its name. Returns the equivalent of "unknown"
    -  * for unknown types.
    +  * The source is the part of the object database that stores the actual
    +  * objects. It thus encapsulates the logic to read and write the specific
     @@ odb/source.h: struct odb_source {
      	 * This callback may be NULL in case the source does not need any
      	 * on-disk setup.
7:  24ae5658ea = 7:  2809430e28 builtin/clone: write alternates via `odb_create_on_disk()`
8:  3bda635fb8 ! 8:  2abcd3b53c odb/source: remove the ability to write alternates
    @@ odb.h: int odb_mkstemp(struct object_database *odb,
       * recursive alternates it points to), but do not modify the on-disk alternates
     
      ## odb/source-files.c ##
    -@@
    - #include "chdir-notify.h"
    - #include "config.h"
    - #include "gettext.h"
    --#include "lockfile.h"
    - #include "object-file.h"
    - #include "odb.h"
    - #include "odb/source.h"
     @@ odb/source-files.c: static int odb_source_files_read_alternates(struct odb_source *source,
      	return 0;
      }

---
base-commit: afa255aeb620346d56a2c01fb5ae9163513c56d7
change-id: 20260813-pks-odb-write-alternates-at-creation-time-64010deb94a0

