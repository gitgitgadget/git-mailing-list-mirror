Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A3E24166E
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399039; cv=none; b=mFL9yeCYUMeiAOsPf+moRry6L4gMx+9yDrWyu7oi1LevZ4MGlgk4i3JUUgwsahJlyhOHsZvFNSZb+62unHeT4hRkAkhQCGwTELXYfeX1Kbzom6PhKd+lkBfdMhZk1rW+8coMw5pVPdaCZJCQwkA/q0jlFdhGj1E7sjsnnib5NAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399039; c=relaxed/simple;
	bh=xQA+wr5Qe6cu3CHoYrsrvjqWQcsQUwO6BIO0Kw99/VA=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=ggVVe7mcym6BiCojAfkEY8ddiPqo3MXH+5yBDuRPKPKVYDyFDKiT2sLeFhXjmjQRb5kjpki3BJs1y89UniIpdeEwUI0/fDTQpvY83kmLvGSZwOg4Y4j2xE2q4C2rFjn7nWGedF2eheZJMKo1/txL/L07npGPAfPGKFkj6TBLA10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+Esh/IQ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+Esh/IQ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b783d851e6so4691536f8f.0
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 06:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754399035; x=1755003835; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vBhhJzNAJ2P96s2Pbe0eFzYp+PizUXZpNyjtbiCKvcY=;
        b=V+Esh/IQz0Gn3+MxUtiFyPRsrNs/JGLd+bgNGJPTeY1pl6wjUyCOBparfZGAyclaQY
         CSN9TS14NEopSdBnRpLfkJ9C+wIh19dk/hn96iGNFVABSevz0cW5aCdP7A2l+tZbUpg1
         doFWlKUh+fqabOV8Gw3+Z6s2S1z+WoBFiY4TeoxWuzF3SiIT8dvCmRPUJkLK6Bb7KGu7
         NIeDZkQc3UiBUZf6wKXU+orJZb43kIHIJpmOWuM51QBFY/2L93hb2jS8QjdsJ1PS7erK
         0oxNP2sQViMoBjDTXraIxRvLGsWW0eSr4+0isCWYSFfE71ElaflFhFCt3clhhU5lQGK1
         sO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399035; x=1755003835;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBhhJzNAJ2P96s2Pbe0eFzYp+PizUXZpNyjtbiCKvcY=;
        b=CXoRDSGlku/1gRaOZ2pEjiPygEbPWYcqp8CQjS8EVjHGBnMUUX4z8DKL2LtPQHEXLM
         8Ah0BnNwxhXri8Cgw3WgzoRXvaTie9/TZ9hsJh12M5s3Sh5f4BkyPJAqTBXHGBxM/dXC
         sLGS7TNpZle6sQ2O9BLZqfsx4umo7dck3RMU6O99QhDFhagWDWGuLmwOHumivaxKONut
         39OPcqoYc1/nSKKd/RDhDuHs9spC4zEPL6AAmZYUsbpocPcoFlGkb3GMfWnz2hcdTb9z
         qsRDeQWQzQ4o20tdpqY564uXuRbNinz2GtmRnQtnP12N6VgxiHFsnVWeHaYTCCHiTOB4
         Msvw==
X-Gm-Message-State: AOJu0YzOYf/pck+fSGNVXbVeo0DkXJJC9GIkL0C7VCtlMEF6Hcs8Ugod
	5kHlj6c+U6xVSB5UvwIEicv2aARzHMmcDWU+U+JGD54ZDdeCKx0GOrVbv9VSYA==
X-Gm-Gg: ASbGncsLrY8OE+EodbqV2nQwRZ5MSEZ8Whrr0W2Kzct9X7RSGPOeZLOgo8bzRtwZwPV
	uONMvst4mkWeQbIEXKzqpcigCVcVGgVRXvGz4QDoHFefAWw2lKY2Baemgd7+22u+KxzmZ7NsaJW
	kEEAj843FFg778AViSXr0zS4jHxqfmY7+mZ6bpfpjiMEvAY2RoK650edPMY8I0Ql6QArgAlQD5n
	AWJlNBLboYbDQ44BdhUbqhtQEkQ7dwJv+Wm+iWc5e6v9NM4taC1k6I0Yc7KyduwuLeSHfCCVBH0
	t09ftwFFFhXYpgGxRTm57MiJutDuW/m6+WzQDqaRk8Y+Psbb8ZWB7exyXMkJaHXRv3q58xNu40Q
	PyN6IuUfq5N5DrfqXLdJpVrE=
X-Google-Smtp-Source: AGHT+IETjCDziirX5hC1o6FTGp33H46M/XgEn/Fc6g1541CkKes+T4/bpGh2a/QNz21qacEF9J3gaA==
X-Received: by 2002:a05:6000:288b:b0:3b7:87be:d9d8 with SMTP id ffacd0b85a97d-3b8d94c473amr10156787f8f.43.1754399035162;
        Tue, 05 Aug 2025 06:03:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453d6esm19249685f8f.37.2025.08.05.06.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 06:03:54 -0700 (PDT)
Message-Id: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 13:03:47 +0000
Subject: [PATCH 0/6] Introduce more doc linting
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

Reviewing the documentation part of the last patches, it turns out that the
majority of my comments are related to the latest documentation guidelines
which are both easy to forget and almost trivial to automatically check.

This series implements the automatic tests for basic doc rules. At the
moment it conflicts with "[GSoC][PATCH v6 0/6] Add refs list subcommand" and
possibly with "[PATCH v4 0/9] refs: fix migration of reflog entries"

Jean-Noël Avila (6):
  doc: test linkgit macros for well-formedness
  doc: check well-formedness of delimited sections
  doc: check for absence of multiple terms in each entry of desc list
  doc: check for absence of the form --[no-]parameter
  doc:git-for-each-ref: fix styling and typos
  doc lint: check that synopsis manpages have synopsis inlines

 Documentation/Makefile                        |  21 +-
 Documentation/RelNotes/1.6.2.4.adoc           |   1 +
 Documentation/blame-options.adoc              |   3 +-
 Documentation/diff-format.adoc                |   1 +
 Documentation/diff-options.adoc               |   3 +-
 Documentation/fetch-options.adoc              |  15 +-
 Documentation/git-am.adoc                     |   3 +-
 Documentation/git-backfill.adoc               |   3 +-
 Documentation/git-cat-file.adoc               |   6 +-
 Documentation/git-check-attr.adoc             |   3 +-
 Documentation/git-check-ignore.adoc           |   9 +-
 Documentation/git-check-ref-format.adoc       |   3 +-
 Documentation/git-clone.adoc                  |  12 +-
 Documentation/git-commit-graph.adoc           |   3 +-
 Documentation/git-commit.adoc                 |   4 +-
 Documentation/git-config.adoc                 |   3 +-
 Documentation/git-difftool.adoc               |   9 +-
 Documentation/git-fast-import.adoc            |   5 +-
 Documentation/git-fmt-merge-msg.adoc          |   3 +-
 Documentation/git-for-each-ref.adoc           | 264 +++++++++---------
 Documentation/git-format-patch.adoc           |  12 +-
 Documentation/git-fsck.adoc                   |   9 +-
 Documentation/git-gc.adoc                     |   6 +-
 Documentation/git-http-fetch.adoc             |   4 +-
 Documentation/git-index-pack.adoc             |   3 +-
 Documentation/git-log.adoc                    |   6 +-
 Documentation/git-merge-tree.adoc             |   3 +-
 Documentation/git-multi-pack-index.adoc       |   3 +-
 Documentation/git-p4.adoc                     |   1 +
 Documentation/git-pack-objects.adoc           |   3 +-
 Documentation/git-pull.adoc                   |   3 +-
 Documentation/git-push.adoc                   |  18 +-
 Documentation/git-range-diff.adoc             |   3 +-
 Documentation/git-read-tree.adoc              |   3 +-
 Documentation/git-rebase.adoc                 |   2 +-
 Documentation/git-refs.adoc                   |  20 +-
 Documentation/git-reset.adoc                  |   3 +-
 Documentation/git-send-email.adoc             |  30 +-
 Documentation/git-send-pack.adoc              |   3 +-
 Documentation/git-submodule.adoc              |   6 +-
 Documentation/git-svn.adoc                    |   2 +
 Documentation/git-update-index.adoc           |  12 +-
 Documentation/git-upload-pack.adoc            |   3 +-
 Documentation/git-worktree.adoc               |  12 +-
 Documentation/gitprotocol-http.adoc           |   2 +-
 Documentation/gitsubmodules.adoc              |   3 +-
 Documentation/gitweb.conf.adoc                |   2 +-
 Documentation/lint-delimited-sections.perl    |  48 ++++
 Documentation/lint-documentation-style.perl   |  33 +++
 Documentation/lint-gitlink.perl               |   7 +
 Documentation/merge-options.adoc              |   3 +-
 Documentation/mergetools/vimdiff.adoc         |   8 +
 Documentation/scalar.adoc                     |  18 +-
 Documentation/technical/api-path-walk.adoc    |   5 +-
 .../long-running-process-protocol.adoc        |   1 +
 shared.mak                                    |   2 +
 56 files changed, 445 insertions(+), 231 deletions(-)
 create mode 100755 Documentation/lint-delimited-sections.perl
 create mode 100755 Documentation/lint-documentation-style.perl


base-commit: 112648dd6bdd8e4f485cd0ae11636807959d48be
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1945%2Fjnavila%2Fdoc_linting-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1945/jnavila/doc_linting-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1945
-- 
gitgitgadget
