Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E9213E8A
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 23:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740526973; cv=none; b=XREVz6fRKotpr3kD3vB9WyRWI+o3PHkhDX8Ge+Fyi6pW1AeVsTtWbSzbgW1dc2zi6CW51Q3rKKBRMUuNlDguhjdtRB777lrzTo/ok6HrSb5Qrn0GswiPUfoeSp/JleLj5WtxvjlOWHv1bkzars0K79muR5SL7ZZfGC/nH+PkXyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740526973; c=relaxed/simple;
	bh=cTAHqooAAJpmpXSTKgyCSU7IYyoLOIg3lIEuySQe1QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXSz5e06obg7eNRhSrJCac0KfPMhxe5UZ0cPSA+1n3vVX69D3tbqsuYY05XMvgx3khk2kfnD4P3c41YTXgl/MAJ43ZaJm7Fd+xA7fTPcfx8GF2le6wYclWViXNqfkUhm7CyfDIAL0z4ap3x+K7aCZtvhlS5y7YmrR0aGd9Wn1f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OL4Am+Xi; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL4Am+Xi"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2a01bcd0143so5863845fac.2
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 15:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740526971; x=1741131771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCAxZe2IQN2W8mCzJxCAG2Q3HaF/GIt8v92ViaungsI=;
        b=OL4Am+Xi7RzhHs9QhD0OqYZLwHzIsBar2ijzxG6FkOL3j/Q7dWKsh9mnaNpzGcOIXN
         BVP8B6KGZtaEPzAlf05NZ/KdDSXyclZKxCqwjFSxd/SNtRcv6i3xvZW2JAzOLB8I5pCS
         EMnlWZ/wIlp4w7+XG/eYYduq+1TjxoeOxYq5stB5WBbERmnizyydX4HsJCRBQxX82R2f
         VhijgK1LLygt0ubMlsDKj6x1U6ZYENbuT3l53Q/+Cp3tWtEnaY+QRNXYohSaX+ui8Mz7
         zWeaW0IaRPPznckJtvOspsIP/sWc49pR6+19RwZWBWM6EJgynrxl9noDggxLbMlYUii1
         4dDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740526971; x=1741131771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCAxZe2IQN2W8mCzJxCAG2Q3HaF/GIt8v92ViaungsI=;
        b=AD/QcRA+xxXSOwrj8TSgXGSNBViNbSoaLVtimMzzjE9EB1X6UZ1/h6XbXcWmQcD86W
         VPaBhumdAbmCgw2shtjaVZ3s+orj/WKNO/cJpY5VK0wLhM0lvU4g8S5vGRDWColHdtZY
         yien+YvAwfY7piid3K+j2Z3ZgDB8okcDAjcgALX/i6kBr+7e8Shp2sqHcXsr228eQxni
         LLt0nF+XAL//67KYvZLqEYSzZgtleOg57Qby9cBfDMUOdXuRdZtckTOZnQ98nJVjQFVV
         78L/lD6JT0p1Jk3/t4a1LwMvN7zdY9dlkNfcMsfUWyAakpXdesfWeNIqnUrLZJ0CMVXP
         oelA==
X-Gm-Message-State: AOJu0YxKwGtAdzGNj/1tLmgo+zgeZ+R8uaDTOmBhIa4PVJpAB8vXStiN
	V9U06vxiUPG6QCbZe/cM42jvJNn0/jgjVLJVg+s+FMaRBA9aOF1JnugI9BMZ
X-Gm-Gg: ASbGncvOdgWxa+rflAwwvmIUYXnxeYpBHXuJDWd4B3jrbTIpjRl77Li5AKj/D2c611F
	yO4QYqDLsGAgUTNqaSvUMPrOziJzC4WRUotFxOPofCjGoVEKaq0tH97gkHqQ69i34f5spEyQ7VF
	2yRzidQafOZrVdoBgwlfh2RulhN7fQjh2UO6Y8vkCRK5KWX4wn0ZyWNruj1cOjqOmhFNlhgZULn
	9Qmx4XRrgQlOv0QZ3jO0gIozXADrWPvIBXzcSC8xF1SR9zG0FQ2yWADfsoow4UDbv1Kv4eNW/nA
	hCAYXaIY4vuKl//GJVoAPCq8qRpAliOVlQ==
X-Google-Smtp-Source: AGHT+IHnOcmxL8IJfR+KannGV4YoIahmc8He73+poB6XvyZ1rWEz17Iz95q9U93P8xjZtznD4WSKRQ==
X-Received: by 2002:a05:6870:ac25:b0:2b8:308d:fa75 with SMTP id 586e51a60fabf-2c13071ce53mr892224fac.31.1740526970612;
        Tue, 25 Feb 2025 15:42:50 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c1113f5bc5sm609308fac.21.2025.02.25.15.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 15:42:49 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/3] batch blob diff generation
Date: Tue, 25 Feb 2025 17:39:22 -0600
Message-ID: <20250225233925.1345086-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212041825.2455031-1-jltobler@gmail.com>
References: <20250212041825.2455031-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through git-diff(1) it is possible to generate a diff directly between
two blobs. This is particularly useful when the pre-image and post-image
blobs are known and we only care about the diff between them.
Unfortunately, if a user has a batch of known blob pairs to compute
diffs for, there is currently not a way to do so via a single Git
process.

To enable support for batch diffs of multiple blob pairs, this series
introduces a new diff plumbing command git-diff-pairs(1) based on a
previous patch series submitted by Peff[1]. This command uses
NUL-delimited raw diffs as its source of input to control exactly which
filepairs are diffed. The advantage of using the raw diff format is that
it already has diff status type and object context information embedded
in each line making it more efficient to generate diffs with as we can
avoid having to peel revisions to get some the same info.

For example:

    git diff-tree -r -z -M $old $new |
    git diff-pairs -p -z

Here the output of git-diff-tree(1) is fed to git-diff-pairs(1) to
generate the same output that would be expected from `git diff-tree -p
-M`. While by itself not particularly useful, this means it is possible
to split git-diff-tree(1) output across multiple git-diff-pairs(1)
processes. Such a feature is useful on the server-side where diffs
bewteen a large set of changes may not be feasible all at once due to
timeout concerns.

This command can be viewed as a backend tool that exposes Git's diff
machinery. In its current form, the frontend that generates the raw diff
lines used as input is expected to most of the heavy lifting (ie.
pathspec limiting, tree object expansion).

This series is structured as follows:

    - Patch 1 adds some new helper functions to get access to the queued
      `diff_filepair` after `diff_queue()` is invoked.

    - Patch 2 introduces the new git-diff-pairs(1) plumbing command.

    - Patch 3 allows git-diff-pairs(1) to immediately compute diffs
      queued on stdin when a NUL-byte is written after a raw input line
      instead of waiting for stdin to close.

Changes since V2:

    - Pathspecs are not supported and thus rejected when provided as
      arguments. It should be possible in a future series to add support
      though.

    - Tree objects present in `diff-pairs` input are rejected. Support
      for tree objects could be added in the future, but for now they
      are rejected to enable to future support in a backwards compatible
      manner.

    - The -z option is required by git-diff-pairs(1). The NUL-delimited
      raw diff format is the only accepted form of input. Consequently,
      NUL-delimited output is the only option in the `--raw` mode.

    - git-diff-pairs(1) defaults to patch output instead of raw output.
      This better fits the intended usecase of the command.

    - A NUL-byte is now always used as the delimiter between batches of
      file pair diffs when queued diffs are explicitly computed by
      writing a NUL-byte on stdin.

    - Several other small cleanups and fixes along with documentation
      changes.

Changes since V1:

    - Changed from git-diff-blob(1) to git-diff-pairs(1) based on a
      previously submitted series.

    - Instead of each line containing a pair of blob revisions, the raw
      diff format is used as input which already has diff status and
      object context embedded.

-Justin

[1]: <20161201204042.6yslbyrg7l6ghhww@sigill.intra.peff.net>

Justin Tobler (3):
  diff: return diff_filepair from diff queue helpers
  builtin: introduce diff-pairs command
  builtin/diff-pairs: allow explicit diff queue flush

 .gitignore                        |   1 +
 Documentation/git-diff-pairs.adoc |  60 +++++++++
 Documentation/meson.build         |   1 +
 Makefile                          |   1 +
 builtin.h                         |   1 +
 builtin/diff-pairs.c              | 206 ++++++++++++++++++++++++++++++
 command-list.txt                  |   1 +
 diff.c                            |  70 +++++++---
 diff.h                            |  25 ++++
 git.c                             |   1 +
 meson.build                       |   1 +
 t/meson.build                     |   1 +
 t/t4070-diff-pairs.sh             |  83 ++++++++++++
 13 files changed, 432 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/git-diff-pairs.adoc
 create mode 100644 builtin/diff-pairs.c
 create mode 100755 t/t4070-diff-pairs.sh

-- 
2.48.1

