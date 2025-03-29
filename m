Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0083BB676
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743260584; cv=none; b=rPvno0cjmkNOUrFPbnbhbiZ7s9QIVeYpBQFhfLdfNJvttss60dhIdUx4499N5tnvEBOQnFP5a4gg2eS0cB/evb3dI2jMJ77HPUorWKRYRfE+1ft9p8V/wtxpgyeJJ6Wb6V1btKW3kdiJhltDIYcsGiOkRDK5EpTyZxljIFGYLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743260584; c=relaxed/simple;
	bh=/9jNpbDzcH/ejfefulS3AStROGMw73QNZqZnND0RFd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMGu1O/61OTuQwcfULiFqRhZMWyiVK8VMHWh8ExnEdgX6vsfsZwCCcCaPCh+251yCt4nkXS2pTR4eyVqlkmepR3mrwhpJemx/S/IFi782zUbX1I4h1vFCit77K7+D/y8kXKxVDTWBOVaq5pRiySqh8L6TsSNXxqIYAVIRJz7vgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPYl5Jfd; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPYl5Jfd"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so7153906a91.3
        for <git@vger.kernel.org>; Sat, 29 Mar 2025 08:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743260582; x=1743865382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBv/ibhe2yYzgw6lVPDbRzxWuJmshrZtn7MuFfF1M6Y=;
        b=hPYl5JfdmCtku7Khw3OqeqJXVf34ErPwPYA0wmwQC7rLFBFAxalP7DwS4UKt8q1XtA
         Y8/PxfBezRVrF3zlXHJY+UTBPkQbMtLgurQut0vnrEw5vn0HKOcsXHh+1UcOqpLIQ2ca
         DERVswIlkhr1wu9J/3W89XdGc88dTBwl5lCK2IllORxE7AL6EzZo0WjkVq3nO0lI6qcd
         Zu4/MdsxBEKIxxZoAQYZfP+SFyXkjdRmCbPWu1A02XVDScKbnuttBP97dyArnzhRkBcY
         fPG/OhhbBFykCfbx4hOl++xM5QdMfnwTXKHXtlNW27yBNrjAvvSjC2O89NNh6mBo8xb1
         Bq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743260582; x=1743865382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBv/ibhe2yYzgw6lVPDbRzxWuJmshrZtn7MuFfF1M6Y=;
        b=NfihsXPwNYHz5qTLlxeYesqGbCNJDxH74uxbhf+DFNeujQNN/CrgusAJzjxb202xxY
         Kmmc0e+FtEkIMWYXDOucNCBMRPBiE8cpTzXfQBQsFGnH3GXhoAYjS+imuJUxkLL3JZ7d
         ED92LDfxpCV/UgWIof7viTxXs7cttluIEI7cqQLEqAn72hpZP5MxWTxb3euxoBd5GZut
         IwyzKyCs034aDmZc/MenBYeCTU1K0C/rWwzDzAKDkp/v1X8HRl+STn2F2Ii/zYaPQjd2
         8lCrp9yFQ2BGIzXF+/Op+TprMTKKskcQZjo3viYwmubOanOXYy1FmrLvde9Wxc3LbYq1
         7ozw==
X-Gm-Message-State: AOJu0Yw4KGAQPXFIvWuTr6zmgkymDr5O/Ccd/Nv1Y7/z+kBywkCAiOSy
	RR9WU5Rd5GNli6Kom9v0yl5JH3bdQjscLNgtE8i5qQlGxDF2TjZZVox4Xxqv
X-Gm-Gg: ASbGnctPVpAYY8FrObq9X+5WFg+r18aoJ7NIIwuIJEa6q8QGt+HmEBgWaCZY/iax+U2
	bQD31UmfR58ga3toNxocigzQ105IebQKG3gi8EDAozvHXJSvch4SABYfjRgp8/D8FQAa22SKn/m
	+hKnlLK3ZACkGvTHLS/ydkfsUPSWRq2OeE2KUZZwudvoqVsZ/Btfh6w4IkVX1yKkLP2PHNKSIME
	ZQDNomItVMpnCxwt/O8uZNOtKZwkpWD/Ic9Eli42VDpdo2wynJTLrRG4tXrbzYlEJr3m43GskJW
	CmO/Ssn8dH8qsk2I15S2jBGUuZn1HBlJ4x0wOOB3kctfiahZCbIhHA==
X-Google-Smtp-Source: AGHT+IF08k2zZSrEUEKLUQSUHHvjBLLqSCp1DiUZvoAuM+wOZwc161PJKvStg6Z7X4PqtBgkVBSJng==
X-Received: by 2002:a17:90b:33cb:b0:2ee:d024:e4fc with SMTP id 98e67ed59e1d1-3053215c6ccmr5407856a91.33.1743260582044;
        Sat, 29 Mar 2025 08:03:02 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30516d3cdf9sm3839412a91.7.2025.03.29.08.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 08:03:01 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: 05zyt30@gmail.com
Cc: git@vger.kernel.org
Subject: [GSoC] git-refs proposal draft
Date: Sat, 29 Mar 2025 23:02:46 +0800
Message-ID: <20250329150248.2274482-1-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAMvj1+rbYKFNeWEvvN76MTpzfuWc4TN4ViXRE4nTfWy7ZMspWg@mail.gmail.com>
References: <CAMvj1+rbYKFNeWEvvN76MTpzfuWc4TN4ViXRE4nTfWy7ZMspWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

## Name and Contact Information

- Full Name: Zheng Yuting
- Email Address: 05ZYT30@gmail.com
- Time Zone: UTC +8:00

---

## Abstract

The current Git reference management functionality is fragmented across
multiple independent commands (git-show-ref, git-for-each-ref,
git-update-ref, git-pack-refs, git-check-ref-format, and
git-symbolic-ref), leading to code redundancy and increased maintenance
costs. Based on Patrick Steinhardt’s integration vision[1], this project
aims to introduce 8 new subcommands (list, exists, show, resolve, pack,
update, delete, check-format) under the existing git-refs command to
achieve the following objectives:

- Feature Integration: Consolidate existing reference management
  commands under git-refs, while maintaining backward compatibility.
- Feature Enhancement: Introduce recursion depth control for git-refs
  resolve.
- Testing & Documentation: Add test cases ensuring consistency and
  update relevant documentation.

---

## Implementation Plan

### Command Integration Strategy

#### Design Goals

The project will unify scattered reference management functionalities
under the git-refs subcommand framework, ensuring:

1. Complete Feature Coverage: Each subcommand fully replaces its
   corresponding legacy command.
2. Parameter Compatibility: Preserve the semantics and output behavior
   of legacy command options.
3. Code Reusability: Minimize redundancy by sharing underlying modules
   (e.g., refs/files-backend.c).

#### Subcommand Mapping

- git-refs list
  Replaces git-show-ref and git-for-each-ref, merging reference listing
  functionalities with support for formatting (--format), filtering
  (--heads, --tags), and sorting (--sort).
- git-refs exists
  Replaces git-show-ref --exists, providing reference existence checks
  with positive (<ref>) and exclusion-based (--exclude-existing)
  verification.
- git-refs show
  Replaces git-show-ref --verify, validating reference correctness with
  a strict mode (--strict).
- git-refs resolve
  Replaces git-symbolic-ref, resolving symbolic references with added
  recursion depth control (--max-depth), while retaining deletion (-d)
  and quiet mode (-q) options.
- git-refs pack
  Replaces git-pack-refs, packing loose references with support for
  filtering (--include, --exclude) and automatic cleanup (--prune).
- git-refs update
  Replaces git-update-ref, providing transactional reference updates
  with batch processing (--stdin) and atomic guarantees.
- git-refs delete
  Separates the delete functionality from git-update-ref, ensuring
  explicit handling of reference removals with safety checks and batch
  operations (--stdin).
- git-refs check-format
  Replaces git-check-ref-format, validating reference format with
  support for normalized output (--normalize).

#### Implementation Strategy

1. Option Parsing: Each subcommand will reuse the argument parsing
   logic from legacy commands (e.g., git-pack-refs --prune).
2. Shared Backend Logic: Calls to common functions in refs/ (e.g.,
   reference traversal, locking mechanisms).
3. Error Consistency: Maintain the same error codes and message
   formats as legacy commands.

---

### Example: Implementing git-refs pack

#### Functional Implementation

1. Modify builtin/refs.c:
   - Add cmd_refs_pack function implementing git-pack-refs logic.
   - Update cmd_refs to include pack with
     OPT_SUBCOMMAND("pack", &fn, cmd_refs_pack).
   - Define REFS_PACK_USAGE:
     git refs pack [--all] [--no-prune] [--auto] [--include <pattern>]
     [--exclude <pattern>].
2. Register New Subcommand in git.c:
   - Add { "refs-pack", cmd_refs_pack }, to the command array.
3. Reuse refs/files-backend.c Logic:
   - Ensure cmd_refs_pack calls pack_refs correctly, adjusting as
     necessary for new options.

#### Testing Plan

- Test Cases:
  Add t/txxx-refs-pack.sh, leveraging t/t0601-reffiles-pack-refs.sh
  scenarios to verify:
  - --prune removes obsolete references correctly.
  - --include and --exclude apply filtering as expected.
  - Packed references match legacy command outputs (diff .git/packed-refs).
- Performance Benchmarking (if needed):
  Add performance tests in t/perf to ensure no significant regression
  in execution time or memory usage.

#### Documentation Updates

- User Manual:
  Add a pack section to Documentation/git-refs.txt, mapping options to
  legacy command equivalents.
- Developer Notes:
  Comment code to highlight functional parity between git-refs pack
  and git-pack-refs.

---

### Timeline

- May 8 - May 11 (4 days): Initial Testing & Subcommand Framework Setup
- May 12 - May 28 (17 days): pack Subcommand Implementation
- May 29 - June 14 (17 days): check-format Subcommand Development
- June 15 - July 5 (21 days): update and delete Subcommands Development
- July 6 - July 26 (21 days): show and exists Subcommands Development
- July 27 - August 16 (21 days): resolve Subcommand Implementation
- August 17 - September 6 (21 days): list Subcommand Implementation
- September 7 - September 16 (10 days): Mid-term Review
- September 17 - September 23 (7 days): Mentor Review & Final Adjustments

---

## Background & Experience

I graduated in June 2024 from Wenzhou University with a degree in
Network Engineering. My experience includes C programming and
command-line tool development, along with proficiency in Shell
scripting. I am currently in a transitional phase and expect to finalize
my schedule by late April, and then update my weekly schedule for GSoC,
estimating 25-30 hours per week for this project currently.

### Project Experience

- One Student One Chip Project[2]
  Extending the open-source NEMU simulator by implementing CPU cycle
  functionalities in C.
- Web Development
  Developed a Django-based campus website, including user chat, news
  publishing, and teacher management modules.
- Custom Communication Protocols
  Built a UDP-based chatroom with peer-to-peer and group messaging.
- Stock Monitoring Tool
  Implemented real-time monitoring and historical data analysis, with
  email alerting and planned AI-driven strategy optimization.

I have also obtained CCNA certification and gained hands-on experience
as a network engineer. Additionally, I contributed a patch optimizing
send-email functionality in Git[3], giving me insights into the Git
codebase.

## Appendix

[1] https://gitlab.com/gitlab-org/git/-/issues/330
[2] https://ysyx.oscc.cc/en/project/intro.html
[3]https://lore.kernel.org/git/20250312064639.668875-1-05ZYT30@gmail.com/
