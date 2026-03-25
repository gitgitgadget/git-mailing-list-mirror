Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4013644D1
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470241; cv=none; b=nKIr9Ootf+V0A0i3PNFDm7L9n+Zt09SN8TXl95K1LT5izTXdRL+VP6/LD/HyZKjrmkdBO3UQutis0e5AaAn4mH23YQTVocXDvXOyNVJo+hnmdVwi88yW2N442FrI+Yf2CFoeG890EetudGJAjOeswaQuZTDH16LQSToQtm37ahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470241; c=relaxed/simple;
	bh=REcN1YNE95epk+X0l6iq5A+ktpPd6AjW3A68Sx3NyrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GygHx10wxLSOKynxqrTsdRbBhM7XZULOAhr0iT0wU/hPngpW+6Y4cqB/NIIQUejbhFwDN+zpBOdabF0zrzKcjKWqObRWi7Ak/CnOqnb2fUsHcmFSnMkYCSaoqZD80PbLJXf9x5XXME4IERu6vMVddD3U2xORq2w5vsoLMPeLqVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaXgWl+7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaXgWl+7"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a871daa98fso1842905ad.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774470239; x=1775075039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3dtmgO/wUN26PdBjyIgDUQJ4R5fMPYqsxbRS4GXm7U=;
        b=eaXgWl+7v6asj0KSTOAJdraSZfqp7gmYXqfEyZAeAEskZidHmn++U73YtMP41dA5np
         EWyO0ohxwlgIfMHaUAZlsSg+JStwDtViXhqyL/aF3Qu4XO6OSM0WuC9xQg5+hFohB/z5
         Jqv9IwqCl0zrFSlrsRo2uPSFXG8rRC4MFDOWBlQgBwe0KYYr3pxa9xxfGE5XnvJgkGrf
         ABTpt3xGZOi+Q08jZlcAbN44KHPMC0MLEWF9ugwINvYvoerfE1S3BUjuvoRiKslW+pJ0
         C1La/JHxVCGUA364EDA+F4lBRb7Kp5MzFZFlZQFPhz7Z9Gcx/R27GT9ChSnnzWtvkqdQ
         BEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774470239; x=1775075039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l3dtmgO/wUN26PdBjyIgDUQJ4R5fMPYqsxbRS4GXm7U=;
        b=ZqkUN76wMxvbBkD4YxKWcmiVUx5Udwk1uEJ4C5DZsOYzvGk5rMPVsSVtDt+SiFTikE
         /PZkxe3CMgqYgxDYdACDizZl31n4yBtU2r2GKhedYenzW/niSIBzj4wNtLztEWDHT0W6
         upRroQV3FmHZshSngPXcpJeo2XDeBY5DNDz4w3dtJQqmzuwQkMifbJF3cJqRndF1mAQ8
         Bv1XOjeAdCmGxbQHaouN/QyLn8MjxCo0A0OHM1BVp+znkT8b1/5vqg3hPmCcPHzRBN7S
         cJ2jMC3f8gcK4Dwj63ViPmc6mX3sVRdmkSDtRmjW3j3mguV8uy6TA6YrtCW+uG9dUjxp
         QMDQ==
X-Gm-Message-State: AOJu0YwwvaGWUi0hA4KfZX9/OJPjmYbgt+Bjtrosg1M2YYY1me0GqHPl
	564Tc+Mo6mOujS6hc6H0PKrjte/eYLR5SkLiTXKh9auEnimWZof+EkZ2W2OtAw==
X-Gm-Gg: ATEYQzwNVLAIglqRjHoyA3/eDmpGKRl02NgAcw23dXJZL3n8CeHCAZg0OSBgK+goTnx
	p0QHJx4RzSPA5j0kKBOFQkjxh5taLPEsmvabna0/H+gNsqYGO2PTVq9Myh7L5YQX/8L90fZKKGD
	SLbzXA248qfP+jNNix99ZN4AsZDI/WNV8oTt3YmI17u810wHHP60AfXDV/1aa+x3ATszVKU99pD
	Rq9ue4nei2P0KqTPa4zAd+ktxfctsVU6E6/sEwDttdca27c86YfiOTheEepfXc4tX9gdfTbPEmv
	Ue6u/m9E9itolQDytoFLCTnrM5m3aM6iGYnrB7G5extauZZqjQQCvyeg17dBF77OUdujM2/7nG5
	24ksPvv5wn25MIwivsOm6JWxEx3MEOwhBXLOtXJvSH9Av0UlDy+Ca3n0MzqrVh5JBelepGuK35U
	Cpz6/yOBdOiweDdJIHHNgvuS05nBErtW2ode9aceJn39HpFMFC83HR08dKGg==
X-Received: by 2002:a17:903:1b4f:b0:2b0:5e10:9dbd with SMTP id d9443c01a7336-2b0b09a8affmr57061505ad.3.1774470239125;
        Wed, 25 Mar 2026 13:23:59 -0700 (PDT)
Received: from localhost ([2409:40e3:30ab:6862:a0a6:2ae9:64a5:8a64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7847acsm7652915ad.19.2026.03.25.13.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:23:58 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	newren@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	karthik.188@gmail.com,
	johannes.schindelin@gmx.de,
	toon@iotcl.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v6 0/2] replay: add --revert mode to reverse commit changes
Date: Thu, 26 Mar 2026 01:53:50 +0530
Message-ID: <20260325202354.10628-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260324220401.47040-1-siddharthasthana31@gmail.com>
References: <20260324220401.47040-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

git replay currently supports cherry-picking (--advance) and rebasing
(--onto), but not reverting. We need this at GitLab for Gitaly to
reverse commits directly on bare repositories without a checkout.

The approach is the same as sequencer.c -- cherry-pick and revert are
just the same three-way merge with swapped arguments. We swap the base
and pickme trees passed to merge_incore_nonrecursive() to reverse the
diff direction.

Patch 1 extracts the full revert message formatting logic into a new
sequencer_format_revert_message() function that handles everything in
one shared function rather than just the header. refer_to_commit() is
updated to take a struct repository and a bool instead of replay_opts
so it works outside the sequencer.

Patch 2 adds --revert <branch> as a standalone mode. Reverts are
processed newest-first (matching git revert) to reduce conflicts by
peeling off changes from the top.

The series is based on top of d181b9354c (The 13th batch, 2026-03-07).

CI: https://gitlab.com/gitlab-org/git/-/pipelines/2408816732

Changes in v6:
- Moved desired_reverse declaration to the top of cmd_replay() with
  other variable declarations to fix -Wdeclaration-after-statement
- Updated <revision-range> doc to mention --revert alongside --advance
- Link to v5: https://lore.kernel.org/git/20260324220401.47040-1-siddharthasthana31@gmail.com/
- Link to v4: https://lore.kernel.org/git/20260313054035.26605-1-siddharthasthana31@gmail.com/
- Link to v3: https://public-inbox.org/git/20260218234215.89326-1-siddharthasthana31@gmail.com/
- Link to v2: https://public-inbox.org/git/20251202201611.22137-1-siddharthasthana31@gmail.com/
- Link to v1: https://public-inbox.org/git/20251125170056.34489-1-siddharthasthana31@gmail.com/

Thanks,
Siddharth

---
Siddharth Asthana (2):
  sequencer: extract revert message formatting into shared function
  replay: add --revert mode to reverse commit changes

 Documentation/git-replay.adoc |  52 +++++++++--
 builtin/replay.c              |  36 ++++++--
 replay.c                      | 161 +++++++++++++++++++++++++---------
 replay.h                      |  11 ++-
 sequencer.c                   |  78 +++++++++-------
 sequencer.h                   |  13 +++
 t/t3650-replay-basics.sh      | 111 +++++++++++++++++++++--
 7 files changed, 361 insertions(+), 101 deletions(-)

Range-diff versus v5:

1:  6bd2ce4515 = 1:  6bd2ce4515 sequencer: extract revert message formatting into shared function
2:  9fd92497b9 ! 2:  41fe4861a2 replay: add --revert mode to reverse commit changes
    @@ Documentation/git-replay.adoc: The history is replayed on top of the <branch> an
      --contained::
      	Update all branches that point at commits in
      	<revision-range>. Requires `--onto`.
    +@@ Documentation/git-replay.adoc: The default mode can be configured via the `replay.refAction` configuration vari
    + 
    + <revision-range>::
    + 	Range of commits to replay; see "Specifying Ranges" in
    +-	linkgit:git-rev-parse[1]. In `--advance <branch>` mode, the
    +-	range should have a single tip, so that it's clear to which tip the
    +-	advanced <branch> should point. Any commits in the range whose
    +-	changes are already present in the branch the commits are being
    ++	linkgit:git-rev-parse[1]. In `--advance <branch>` or
    ++	`--revert <branch>` mode, the range should have a single tip,
    ++	so that it's clear to which tip the advanced or reverted
    ++	<branch> should point. Any commits in the range whose changes
    ++	are already present in the branch the commits are being
    + 	replayed onto will be dropped.
    + 
    + :git-replay: 1
     @@ Documentation/git-replay.adoc: When using `--ref-action=print`, the output is usable as input to
      	update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
      
    @@ Documentation/git-replay.adoc: all commits they have since `base`, playing them
     
      ## builtin/replay.c ##
     @@ builtin/replay.c: int cmd_replay(int argc,
    + 	struct ref_transaction *transaction = NULL;
    + 	struct strbuf transaction_err = STRBUF_INIT;
    + 	struct strbuf reflog_msg = STRBUF_INIT;
    ++	int desired_reverse;
    + 	int ret = 0;
      
      	const char *const replay_usage[] = {
      		N_("(EXPERIMENTAL!) git replay "
    @@ builtin/replay.c: int cmd_replay(int argc,
     +	 * Revert needs newest-first ordering (like git revert) to
     +	 * reduce conflicts by peeling off changes from the top.
     +	 */
    -+	int desired_reverse = !opts.revert;
    ++	desired_reverse = !opts.revert;
     +
      	repo_init_revisions(repo, &revs, prefix);
      

base-commit: d181b9354cf85b44455ce3ca9e6af0b9559e0ae2
-- 
2.51.0

