Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9B411CBA
	for <git@vger.kernel.org>; Sat,  2 May 2026 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731359; cv=none; b=BNSL2YrT4WDxyjI0PFo5TDAoIe9z46imUHb1/B+UnearacRVj3yAXJ3GwNObsJ7F7k6Cv9LT8Pew/qKe/VayKXietIQVCjDXYCwEBcKIHvKHC9WXA8laHb5L2yYHR3gzY7l1uAqSkgy3LiYi9sEQTGFYZxxWtzgLAtDsoZzvd8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731359; c=relaxed/simple;
	bh=lI0wHZEz0RU5Js8iCUlYDaiRJZSrjSdzcgbnZ4RVUOw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=KS5SYusknD647PmjllhSOSvgl7uXhfNyyNVfWVMjcdRsEAGM8oeunM0GbV9NieS2CFZUkSdmuFva5XmRylLo+dWtfXuytldE3OquWfSKVZeUAT1XMYWUOVeraMaNFHM9QKVLaBJ510yRq7fbigtdJkw/8tA8ZK//Hiq5OQYTrIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ie1JcsXm; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ie1JcsXm"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c156c4a9efso4884168eec.1
        for <git@vger.kernel.org>; Sat, 02 May 2026 07:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777731357; x=1778336157; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6buoaiLyj/t2uEtl+CJPNp1+eJu27IZ+OMMaC5GoEOs=;
        b=ie1JcsXmzTnhAH5RsHmUP1FJP13DcHMJPImQv0QHXkswZu/kDUL99AfBndoE5wrYR0
         iD0lIAophQ7Pn6b5IgBvDWcT0MEA8B6hoMR9cwvQ83HWhY9SrroLwQMZ90SWUVdGmHR9
         xyTZAs+4nFTPNTsl19do77EBb8S3zVmgeqT7FUsrKLya3hsEq+ZEnm4w9A3M/IDO08Ht
         pJFJ4EU8o7ccKBdvSSnNwBEfWBRMw/njzb3SNY0vGDFtTyF3Cis/o3vkGAhgcwDQhRiI
         M33VsmjW+GACZVdjR5Fd7TlxDxmb3AZVdXBW1U9z2vbD2dw0ehmBMa/Au4Ai6ctPSvoB
         nn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777731357; x=1778336157;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6buoaiLyj/t2uEtl+CJPNp1+eJu27IZ+OMMaC5GoEOs=;
        b=dj6pzKKzVIzvZlMv1iznn/afmMAepn4F9X0gw72eb88lAQ5Pv0CUiTfT03n9nwLwwc
         biuzijCRILDdU2LLpBdl+bQyTTEeYI8WT51aWUMFSfiZ5PfIiBrgYz5SEc8ZJX33XhBj
         KARTW2EtazrR8sTQqDQJdoeeUnMzCrVGuJuuUlspRq7I0G3A1TH7jO8sp4UMwbtZpJWE
         lk2TxhBUGGFTu0oKeRoX0lfibLPhAJc7q8qOA3BiasR1fPtFnbXRgmO02HFK3xCcj6Rk
         qhf48pJShlSY5iqs/g+TIdKqeuu7btX/o31PoePLbkf32tjFs9uCkfzK/HDqthU1uuoi
         Tt2Q==
X-Gm-Message-State: AOJu0Yyl1GpbrFZHto9heSsqYhedgoUV7LXJl+CDPsQCjU+hv4QHYQCJ
	Gvx1G8vOsLgfSPwH3WY3uNHPzV6Rpfa3ljHCtx8Dh3ZQoUqNl6i5KTwX5H8SiA==
X-Gm-Gg: AeBDietKQR+GMe5RJzy8rovagvGe3dyPLiGba9ToeQ5QXLtN9/rVMxXAPAZFblQxmAa
	9hYO1RD4dHPfOCzAXEVW+d3ubCps0tnqFqjnwfFhnjT1AvcyhNjN7MVappuNRMCUqsDFmfeiblP
	0ufN/CYWHJBehWq8C3UVHYy1o1Q5UWB9/sM/hz81FNv5oQHYciIm8JLL/46QjnSVXe9VB626T21
	NLdKHFa6CJ6LWGRp/IVPzTsmSntWOytc5D92RijFwLOUbuOv6LR1pMgE+6AWpM2boaDdG565Mit
	RzSwvjl6mnIgPWqBoArO4PXXWZNnEG4JfwR75l7V4hhiEBbOaKDd6XOHdy0uwRKrmOBhgMNOiN2
	nmIRXimkp066FTbnmHz6SbbZOqpamLjayGaWDnpoZjSJn7t1QOkjiH0YBHQtpOy1kfnoHk5htl4
	hMQSaMyR33U7YXEsMO6O93omF/N5JCM97NlKwX
X-Received: by 2002:a05:7300:d50b:b0:2e6:e77d:7bcf with SMTP id 5a478bee46e88-2efb9c8b3b7mr1693927eec.22.1777731356608;
        Sat, 02 May 2026 07:15:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.87.216.119])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38e71cedsm10215663eec.9.2026.05.02.07.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 07:15:55 -0700 (PDT)
Message-Id: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 02 May 2026 14:15:47 +0000
Subject: [PATCH 0/7] pack-objects: integrate --path-walk and some --filter options
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>

The 'git pack-objects' command has a '--path-walk' option that uses the
path-walk API instead of a typical revision walk to group objects into
chunks by path name instead of relying solely on name-hashes to group
similar files together. (It also does a second compression pass looking for
better deltas after the first pass that is focused within chunks per path.)

The '--path-walk' feature was not previously integrated with the '--filter'
feature, so a warning would appear and disable the path-walk API when a
filter is given. This patch series integrates these together in the
following ways:

 * --filter=blob:none updates the path-walk API options to skip blobs.
 * --filter=blob:limit=<size> adds a scan to a list of blob objects to
   remove objects that are too large.
 * --filter=sparse:<oid> adds a scan to the chunks to validate that the
   paths match the sparse-checkout patterns.

In particular, this last check is significantly faster than the previous
algorithm because it can check all objects at a given path simultaneously
instead of checking all sparse-checkout patterns for each discovered blob
object.

A subtlety must be added here, in that we must change how we mark an object
as "seen" during the path-walk. We may need to add an object to multiple
paths and only mark it as "seen" if it indeed matched the sparse-checkout
patterns as the path is accepted for emitting to the callback. This adds a
new filter that the "seen" objects must also be removed from later chunks to
avoid sending the same object as grouped to multiple chunks.

There's also a subtle detail here in that the path-walk API also prunes tree
paths based on cone-mode sparse-checkouts, to enable 'git backfill --sparse'
operating quickly for small sparse-checkout scopes. But the
--filter=sparse:<oid> feature doesn't prune trees!

As a future step, I do plan to recommend that we add a treesparse:<oid>
setting that does allow us to trim the tree set by cone-mode sparse
patterns. At the time that partial clone filters were being created, cone
mode sparse-checkout didn't exist and neither did the sparse index. Those
features together make a smaller tree set possible, assuming the user never
needs to change their scope. This would be a significant change so it is not
implemented here, though the git pack-objects integration would be quick
after this series completes.

Neither the sparse:<oid> or hypothetical treesparse:<oid> options are or
should necessarily be supported by Git servers. It's too expensive to
compute dynamically and it doesn't work well with reachability bitmaps. What
becomes possible with this change is that it becomes reasonably fast to
construct bundles with these filters that can bootstrap a working
environment with the full history of all files within a given
sparse-checkout scope.


Performance Results
===================

Since the '--path-walk' option is ignored in today's Git version when a
'--filter' is added, the performance matches the behavior without
'--path-walk'. For the tables below, you can compare the rows against each
other (time and then packfile size) for the mode without and then with
'--path-walk' as a representation of "before" and "after". (These tables are
repeated in the commit messages as new implementations improve specific
rows.)

I chose a number of open source repositories of various sizes and shapes:


git/git
=======

Test                                              HEAD
-------------------------------------------------------------------
5315.2: repack (no filter)                       27.73
5315.3: repack size (no filter)                 250.6M
5315.4: repack (no filter, --path-walk)          35.19
5315.5: repack size (no filter, --path-walk)    220.1M
5315.6: repack (blob:none)                       13.42
5315.7: repack size (blob:none)                 137.6M
5315.8: repack (blob:none, --path-walk)          20.98
5315.9: repack size (blob:none, --path-walk)    115.2M
5315.10: repack (sparse:oid)                     72.53
5315.11: repack size (sparse:oid)               187.5M
5315.12: repack (sparse:oid, --path-walk)        29.00
5315.13: repack size (sparse:oid, --path-walk)  161.0M



nodejs/node
===========

Test                                              HEAD
--------------------------------------------------------------------
5315.2: repack (no filter)                       75.53
5315.3: repack size (no filter)                   0.9G
5315.4: repack (no filter, --path-walk)          80.54
5315.5: repack size (no filter, --path-walk)    885.7M
5315.6: repack (blob:none)                       12.65
5315.7: repack size (blob:none)                 148.6M
5315.8: repack (blob:none, --path-walk)          17.60
5315.9: repack size (blob:none, --path-walk)    134.6M
5315.10: repack (sparse:oid)                    518.84
5315.11: repack size (sparse:oid)               153.4M
5315.12: repack (sparse:oid, --path-walk)        27.99
5315.13: repack size (sparse:oid, --path-walk)  139.4M



microsoft/fluentui
==================

Test                                              HEAD
--------------------------------------------------------------------
5315.2: repack (no filter)                      146.77
5315.3: repack size (no filter)                 562.1M
5315.4: repack (no filter, --path-walk)          72.82
5315.5: repack size (no filter, --path-walk)    172.6M
5315.6: repack (blob:none)                        4.84
5315.7: repack size (blob:none)                  62.7M
5315.8: repack (blob:none, --path-walk)           5.19
5315.9: repack size (blob:none, --path-walk)     59.9M
5315.10: repack (sparse:oid)                     59.95
5315.11: repack size (sparse:oid)                85.6M
5315.12: repack (sparse:oid, --path-walk)        15.16
5315.13: repack size (sparse:oid, --path-walk)   72.5M



microsoftdocs/azure-devops-docs
===============================

Test                                               HEAD
---------------------------------------------------------------------
5315.2: repack (no filter)                        4.41
5315.3: repack size (no filter)                   1.6G
5315.4: repack (no filter, --path-walk)           6.00
5315.5: repack size (no filter, --path-walk)      1.6G
5315.6: repack (blob:none)                        1.35
5315.7: repack size (blob:none)                  60.0M
5315.8: repack (blob:none, --path-walk)           1.23
5315.9: repack size (blob:none, --path-walk)     60.0M
5315.10: repack (sparse:oid)                    138.24
5315.11: repack size (sparse:oid)                84.4M
5315.12: repack (sparse:oid, --path-walk)         1.86
5315.13: repack size (sparse:oid, --path-walk)   84.4M



Performance conclusions
=======================

As seen in earlier series around the '--path-walk' feature, the space
savings can be valuable but is not always guaranteed. When the space savings
doesn't happen, then the time spent is generally slower because of the
two-pass mechanism. The microsoftdocs/azure-devops-docs repo demonstrates
this case quite clearly.

However, even in these cases the 'sparse:<oid>' filters are much faster
because of the ability to check an entire set of objects against the
sparse-checkout patterns only once.

Thanks, -Stolee

P.S. I've CC'd the folks who were on the original path-walk feature thread
[1]

[1]
https://lore.kernel.org/git/pull.1819.git.1741571455.gitgitgadget@gmail.com/

Derrick Stolee (7):
  pack-objects: pass --objects with --path-walk
  t/perf: add pack-objects filter and path-walk benchmark
  path-walk: support blobless filter
  backfill: die on incompatible filter options
  path-walk: support blob size limit filter
  path-walk: add pl_sparse_trees to control tree pruning
  pack-objects: support sparse:oid filter with path-walk

 builtin/backfill.c                     |   5 +
 builtin/pack-objects.c                 |   9 +-
 path-walk.c                            | 154 ++++++++++++-
 path-walk.h                            |  21 ++
 t/helper/test-path-walk.c              |  17 +-
 t/perf/p5315-pack-objects-filter.sh    | 129 +++++++++++
 t/t5317-pack-objects-filter-objects.sh | 125 ++++++++++
 t/t5620-backfill.sh                    |   8 +
 t/t6601-path-walk.sh                   | 306 +++++++++++++++++++++++++
 9 files changed, 758 insertions(+), 16 deletions(-)
 create mode 100755 t/perf/p5315-pack-objects-filter.sh


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2101%2Fderrickstolee%2Fpath-walk-filters-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2101/derrickstolee/path-walk-filters-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2101
-- 
gitgitgadget
