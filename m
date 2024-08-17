Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D2C13BC35
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723882865; cv=none; b=M1nT+6F01JgrrtjYjZN9vrwsvBjAWkYlNCj2H/G6c93kk3OvqeXZihs74Ra0QyVauXOYW242HgpkSnmLHoUvsU6N1uhCFv6vQ41gCjg6/chUdVMxksGD9wGjL59PJtG0NOcswKM8Iu1h68FxLlk4/jsEwcClR7YeBIdJRWAnblc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723882865; c=relaxed/simple;
	bh=OiaIbfiz1gBmyH7oaXiHtLZsyl0oHKYPT37rV1yKaG8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CkJrEFvFLyXPN31deNaP7K7+7mTWtle++gRFEgwUtFKX6iRMOJ96jP+iZzywmvIIlP67L5CdKRt0RNQnbd+VA0iA0m6W0v9dOOfjFUNGSfgPzF5CFkKU65bnOkgN9Ir2NTZil8aQenL86XTETDTXTaqd+GSNsbmaLnWhcc/pAkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24661 invoked by uid 109); 17 Aug 2024 08:21:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 08:21:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27920 invoked by uid 111); 17 Aug 2024 08:21:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 04:21:06 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 04:21:01 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 0/15] marking some more unused parameters
Message-ID: <20240817082101.GA6761@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

These are from my pile of -Wunused-parameter fixes. I built this on top
of the "dropping" series I just posted at:

  https://lore.kernel.org/git/20240817072621.GA1535666@coredump.intra.peff.net/

but it should also be fine to apply it in parallel. This should
hopefully be pretty quick to review, as it's only marking things UNUSED,
and never removing them or changing code.

  [01/15]: imap-send: mark unused parameter in ssl_socket_connect() fallback
  [02/15]: update-ref: mark more unused parameters in parser callbacks
  [03/15]: refs: mark unused parameters in ref_store fsck callbacks
  [04/15]: refs: mark unused parameters in do_for_each_reflog_helper()
  [05/15]: oss-fuzz: mark unused argv/argc argument
  [06/15]: t/helper: mark more unused argv/argc arguments
  [07/15]: unit-tests: ignore unused argc/argv
  [08/15]: reftable: ignore unused argc/argv in test functions
  [09/15]: reftable: drop obsolete test function declarations
  [10/15]: reftable: mark unused parameters in virtual functions
  [11/15]: t-hashmap: mark unused parameters in callback function
  [12/15]: test-mergesort: mark unused parameters in trivial callback
  [13/15]: setup: mark unused parameter in config callback
  [14/15]: daemon: mark unused parameters in non-posix fallbacks
  [15/15]: scalar: mark unused parmaeters in dummy function

 builtin/update-ref.c             |  8 ++++----
 daemon.c                         |  6 +++---
 imap-send.c                      |  2 +-
 oss-fuzz/dummy-cmd-main.c        |  2 +-
 refs.c                           |  5 +++--
 refs/packed-backend.c            |  4 ++--
 refs/reftable-backend.c          | 18 +++++++++---------
 reftable/block_test.c            |  2 +-
 reftable/blocksource.c           |  8 ++++----
 reftable/generic.c               |  8 +++++---
 reftable/iter.c                  |  3 ++-
 reftable/readwrite_test.c        |  2 +-
 reftable/record.c                | 31 ++++++++++++++++++-------------
 reftable/reftable-tests.h        |  2 --
 reftable/stack_test.c            |  6 +++---
 reftable/test_framework.c        |  2 +-
 reftable/writer.c                |  2 +-
 scalar.c                         |  3 ++-
 setup.c                          |  2 +-
 t/helper/test-example-tap.c      |  2 +-
 t/helper/test-hashmap.c          |  2 +-
 t/helper/test-mergesort.c        |  2 +-
 t/unit-tests/t-ctype.c           |  2 +-
 t/unit-tests/t-hash.c            |  2 +-
 t/unit-tests/t-hashmap.c         |  3 ++-
 t/unit-tests/t-mem-pool.c        |  2 +-
 t/unit-tests/t-prio-queue.c      |  2 +-
 t/unit-tests/t-reftable-basics.c |  2 +-
 t/unit-tests/t-reftable-merged.c |  4 ++--
 t/unit-tests/t-reftable-pq.c     |  2 +-
 t/unit-tests/t-reftable-record.c |  2 +-
 t/unit-tests/t-reftable-tree.c   |  2 +-
 t/unit-tests/t-strbuf.c          |  2 +-
 t/unit-tests/t-strcmp-offset.c   |  2 +-
 t/unit-tests/t-strvec.c          |  2 +-
 t/unit-tests/t-trailer.c         |  2 +-
 36 files changed, 81 insertions(+), 72 deletions(-)

-Peff
