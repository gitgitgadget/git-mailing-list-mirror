Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E462620E8
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102287; cv=none; b=Aa6tl4BJbaRcnRw0gdq2T/EjGrNEs4jyE6yS5fY+zT79P9ReAoEJtTZCRlgFuxJBYxKLN8KwRpoOmlKG1COCIaLjHe9OOznZB4ErUKT9mVo18a+S0MGfO9/kGZLWqcJLAH13uvKvzehbMJJPmBmJEvOBnfcCr1iOhd9EoO5cyKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102287; c=relaxed/simple;
	bh=pxYMkgtvTZ+3q1/XoizYCgCfBTQYMJfQD7agSxtAi1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trvT1x6SqcNa/GCgO8ZBPZDoFHIqwmzR0nvzNpFelSg/IdLQZDBZPgBa7eV9HLcnf9ZtGBYH2CU3lu8MbMS+anUjph5XKxuRq3WshPJsUxnW5C5d/Cblu5+iY5BuFYRGgB8t/uFmFO/LFz3OMDSsiAqu2k04PZuB39ZtOWBGpPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMlC3p3d; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMlC3p3d"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso11679362a12.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 01:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744102284; x=1744707084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mivJssq9vOTh7EflNg31uKyhSoce+2hbLOx7nzfCLZw=;
        b=WMlC3p3dwYhkuF1XIjUiuHORA1XVhL4YVGPBy8gG9bUCcAUfpZj66i/1u3jsVno45o
         IRlD6eRKQQV2lPZqNQceNg36FfwVnN9fMc+FYsutqcrcXbOad05RcTOZd7UQpJjyZPcn
         A77ZxY7EI9DmbtlS3S8zal8GCL16oDMvCF4s568+l9P7qbikk0SJYqqH2yN0p9W5RGcq
         Op7Zl5ymMn9YZbx/LN5J14DWtpoPEGNDsthXkNRIlIvZ+Gc1ZlrMA0V8Nqzi6xTw1sGH
         3OFFWh4U8vdufvRUrX9k3V39bEzb9dshWzQIXl5jFs26o85RnEsTiUC///S5Z3D6WHNr
         h0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102284; x=1744707084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mivJssq9vOTh7EflNg31uKyhSoce+2hbLOx7nzfCLZw=;
        b=DZ/X5YPkNuoLSrqQg5XY2b4y+HYdKEI8UDal32SclBbYKUQ/rzhp1l2c5EdS1doZy+
         /6Gy2dLKboeJWhFYOpAuCQdjZQDJ+Oo6jkMGKHvDIHdw9XNch123ZPqa4FVqVVy/hmfA
         JjYWjjE1lhUnO5w6YX+OvOFT+QhG2xarkTIwqN5RHGpkdKNLgql1YolzhnFYaFw3u669
         mj1KZM4sySLgN+6KnCbor4JMkY0Mb+LAMpyjbbjaTFPphbN7St/Xg2fLmD/ClSw7NcPp
         9x4aAYut+hkgwlhN+F4FRY0k5aMp7VZD8b1Nh4TZqXVBDmBiXsn0+mhnmCz9K/cOiHk2
         vXAQ==
X-Gm-Message-State: AOJu0YzjY6VhXcoi7uHGam+qLMs1fXGj0M9OEPbkyRaTl22CycPOoguC
	qOpw8lKOQ0AZbbIuP7lFxBukdLTzKa6vUsMdh+1xmu0jQCwY4sdG
X-Gm-Gg: ASbGnctw3/h1KMP2DZq3hjHB95kjtaIodRqSzM0pOGpEvrXADWodtNi50jZ/9Ejl8/T
	IpZqXEbaYlFB6MIHKgwwT4qsN6Q0rEfWHQh6L84zlJT0njLMfujsMcRV87TivUXqDLXFlkYKnMr
	CmN46IVmQN45MZrLu4psoXW/2JnCjU0ntuszox7WZVVRZ8YBngkZ6nv2+tKG/uezDg7jjI9SsDX
	Oqtv6+JwOI2pVoxZpbqa7kJmd/plADP4YQBTs/BgmkfoiC1rqFMqI5aECrsoM65Cb8/QT7MEIO9
	OVZga4y1SToEIwkA6GQBq2z1X/bbTr2T2iHCTdVyH1y2c5VRnT6+eeh+Sg==
X-Google-Smtp-Source: AGHT+IHHwf0jORk/5DpTGBQAoaYF1FTINnkrkDiO+H2DTcNYENB0J1CYYFouFcUu9cQ9nmvpZEpNLQ==
X-Received: by 2002:a17:907:7f90:b0:ac4:3d0:8bca with SMTP id a640c23a62f3a-ac81a6f53f5mr194125366b.29.1744102283381;
        Tue, 08 Apr 2025 01:51:23 -0700 (PDT)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5c804sm890801366b.15.2025.04.08.01.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:51:22 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	ps@pks.im,
	jn.avila@free.fr,
	gitster@pobox.com
Subject: [PATCH v6 0/8] refs: introduce support for batched reference updates
Date: Tue,  8 Apr 2025 10:51:04 +0200
Message-ID: <20250408085120.614893-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git supports making reference updates with or without transactions.
Updates with transactions are generally better optimized. But
transactions are all or nothing. This means, if a user wants to batch
updates to take advantage of the optimizations without the hard
requirement that all updates must succeed, there is no way currently to
do so. Particularly with the reftable backend where batching multiple
reference updates is more efficient than performing them sequentially.

This series introduces support for batched reference updates without
transactions allowing individual reference updates to fail while letting
others proceed. This capability is exposed through git-update-ref's
`--allow-partial` flag, which can be used in `--stdin` mode to batch
updates and handle failures gracefully. Under the hood, these batched
updates still use the transactions infrastructure, while modifying
sections to allow partial failures.

The changes are structured to carefully build up this functionality:

First, we clean up and consolidate the reference update checking logic.
This includes removing duplicate checks in the files backend and moving
refname tracking to the generic layer, which simplifies the codebase and
prepares it for the new feature.

We then restructure the reftable backend's transaction preparation code,
extracting the update validation logic into a dedicated function. This
not only improves code organization but sets the stage for implementing
partial transaction support.

To ensure we only skip errors which are user-oriented, we introduce
typed errors for transactions with 'enum ref_transaction_error'. We
extend the existing errors to include other scenarios and use this new
errors throughout the refs code.

With this groundwork in place, we implement the core batch update
support in the refs subsystem. This adds the necessary infrastructure to
track and report rejected updates while allowing transactions to
proceed. All reference backends are modified to support this behavior
when enabled.

Finally, we expose this functionality to users through
git-update-ref(1)'s `--allow-partial` flag, complete with test coverage
and documentation. The flag is specifically limited to `--stdin` mode
where batching multiple updates is most relevant.

This enhancement improves Git's flexibility in handling reference
updates while maintaining the safety of atomic transactions by default.
It's particularly valuable for tools and workflows that need to handle
reference update failures gracefully without abandoning the entire batch
of updates.

This series is based on top of 683c54c999 (Git 2.49, 2025-03-14) with
Patrick's series 'refs: batch refname availability checks' [1] merged
in.

[1]: https://lore.kernel.org/all/20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im/

---

Changes in v6:
- The documentation for 'git update-ref' didn't repeat the command, giving the intention
  that newlines added were continuation of options rather than alternative invocations.
- Link to v5: https://lore.kernel.org/all/20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com

Changes in v5:
- Inline the comments around the 'ref_transaction_error'.
- Use 'strbuf_reset()' wherever possible instead of 'strbuf_setlen(err, 0)'.
- Use an extra 'conflicting_dirnames' strset in 'refs_verify_refnames_available()' to track
  dirnames which were found to be conflicting, this is to avoid re-reading those dirnames.
- Add curly braces style mismatch in if..else block.
- Link to v4: https://lore.kernel.org/r/20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com

Changes in v4:
- Rebased on top of 2.49 since there was a long time between the
  previous iteration and we have a new release.
- Changed the naming to say 'batched' updates instead of 'partial
  transactions'. While we still use the transaction infrastructure
  underneath, the new naming causes less ambiguity.
- Clean up some of the commit messages.
- Raise BUG for invalid update index while setting rejections.
- Fix an incorrect early return.
- Link to v3: https://lore.kernel.org/r/20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com

Changes in v3:
- Changed 'transaction_error' to 'ref_transaction_error' along with the
  error names. Removed 'TRANSACTION_OK' since it can potentially be
  missed instead of simply 'return 0'.
- Rename 'ref_transaction_set_rejected' to
  'ref_transaction_maybe_set_rejected' and move logic around error
  checks to within this function.
- Add a new struct 'ref_transaction_rejections' to track the rejections
  within a transaction. This allows us to only iterate over rejected
  updates.
- Add a new commit to also support partial transactions within the
  batched F/D checks.
- Remove NUL delimited outputs in 'git-update-ref(1)'.
- Remove translations for plumbing outputs.
- Other small cleanups in the commit message and code.

Changes in v2:
- Introduce and use structured errors. This consolidates the errors
  and their handling between the ref backends.
- In the previous version, we skipped over all failures. This include
  system failures such as low memory or IO problems. Let's instead, only
  skip user-oriented failures, such as invalid old OID and so on.
- Change the rejection function name to `ref_transaction_set_rejected()`.
- Modify the commit messages and documentation to be a little more
  verbose.
- Link to v1: https://lore.kernel.org/r/20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com

---

Karthik Nayak (8):
  refs/files: remove redundant check in split_symref_update()
  refs: move duplicate refname update check to generic layer
  refs/files: remove duplicate duplicates check
  refs/reftable: extract code from the transaction preparation
  refs: introduce enum-based transaction error types
  refs: implement batch reference update support
  refs: support rejection in batch updates during F/D checks
  update-ref: add --batch-updates flag for stdin mode

 Documentation/git-update-ref.adoc |  14 +-
 builtin/fetch.c                   |   2 +-
 builtin/update-ref.c              |  66 +++-
 refs.c                            | 171 ++++++++--
 refs.h                            |  70 +++--
 refs/files-backend.c              | 314 ++++++++-----------
 refs/packed-backend.c             |  69 ++--
 refs/refs-internal.h              |  51 ++-
 refs/reftable-backend.c           | 502 +++++++++++++++---------------
 t/t1400-update-ref.sh             | 233 ++++++++++++++
 10 files changed, 969 insertions(+), 523 deletions(-)

---

Range-diff versus v5:

1:  cae24142a1 = 1:  cae24142a1 refs/files: remove redundant check in split_symref_update()
2:  239aecdb0f = 2:  239aecdb0f refs: move duplicate refname update check to generic layer
3:  06404dd350 = 3:  06404dd350 refs/files: remove duplicate duplicates check
4:  a3e645aa37 = 4:  a3e645aa37 refs/reftable: extract code from the transaction preparation
5:  2615bfe78e = 5:  2615bfe78e refs: introduce enum-based transaction error types
6:  d5c1c77b0d = 6:  d5c1c77b0d refs: implement batch reference update support
7:  4bb4902631 = 7:  4bb4902631 refs: support rejection in batch updates during F/D checks
8:  674630f77c ! 8:  ed92beaf18 update-ref: add --batch-updates flag for stdin mode
    @@ Documentation/git-update-ref.adoc: git-update-ref - Update the object name store
     -'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] | [--create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z])
     +[synopsis]
     +git update-ref [-m <reason>] [--no-deref] -d <ref> [<old-oid>]
    -+	       [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid> [<old-oid>]
    -+               [-m <reason>] [--no-deref] --stdin [-z] [--batch-updates]
    ++git update-ref [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid> [<old-oid>]
    ++git update-ref [-m <reason>] [--no-deref] --stdin [-z] [--batch-updates]
      
      DESCRIPTION
      -----------

-- 
2.48.1

