Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C7B4778C
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470272; cv=none; b=UD5gaW6NMprIrEekpM8EiO+Mf9YSYxkJOuhdEvOjhqwmFCbs/N54bYdWKKI0geAT1pKpiImhilGFtOmVUuXRUwmcEVxFf0wxa0+fzkor8cbOJ9q/adSWSWXirO4iYsXu/fY4C3HFnfRtYTpR0r2ewhSLUUJpaYJrGyVIauZxCe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470272; c=relaxed/simple;
	bh=K5Bk0rMy66k35Q8T+rkRlN79+vIXVhTRld8TrX25tAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UlNW5kyi5xAtSLS6VUItx5++TYc/OoAKW4Uxq/o+Z2+mJNmscZLU+hRLVsiMKrzMx+JNR4OsJ7Q7CZYIXJKVuejDnbBEhSdR3ayrZ+kQMiFS8SdHVFVBs3DfFo+s7zTDyDJjLEPqtOSDpBdySBUI6ldBoCzjGYja7uSeDe8Oaw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hUMKAhy9; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hUMKAhy9"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6133036B65;
	Wed,  4 Sep 2024 13:17:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=K5Bk0rMy66k35Q8T+rkRlN79+vIXVhTRld8TrX
	25tAA=; b=hUMKAhy9qZg5tWulqIyYlHR0eLvfiD/uqmHLTHtet2WqljE4epWCu5
	oPSqn9tPfq2GcwjNapMs1dS8Ybwb/nHJYPq1C2H47d2zx77uuFh0kAA7k9jIRoFl
	L24oierdz6EECKluZZeUCr0BXQVuYmegZ3e0FUXQVt9O4z+qGqutU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF07B36B63;
	Wed,  4 Sep 2024 13:17:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58ECC36B62;
	Wed,  4 Sep 2024 13:17:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 1/6] t: move reftable/stack_test.c to the unit
 testing framework
In-Reply-To: <20240904150132.11567-2-chandrapratap3519@gmail.com> (Chandra
	Pratap's message of "Wed, 4 Sep 2024 20:08:01 +0530")
References: <20240826173627.4525-1-chandrapratap3519@gmail.com>
	<20240904150132.11567-1-chandrapratap3519@gmail.com>
	<20240904150132.11567-2-chandrapratap3519@gmail.com>
Date: Wed, 04 Sep 2024 10:17:47 -0700
Message-ID: <xmqqmskn9w3o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9BADAA06-6AE1-11EF-9BE1-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Chandra Pratap <chandrapratap3519@gmail.com> writes:

>  int cmd__reftable(int argc, const char **argv)
>  {
>  	/* test from simple to complex. */
> -	stack_test_main(argc, argv);
>  	return 0;
>  }

This makes cmd__reftable() a no-op.

Even though you cannot remove t/helpter/test-reftable.c, as it
contains the implementation for "test-tool dump-reftable", we should
at least be able to do something like this.

--- >8 ---
Subject: [PATCH 7/6] t: clean up leftover reftable test cruft

With migration of the tests of the reftable to the unit-tests
framework, "test-tool reftable" has become an expensive no-op.

Retire everything that uses "test-tool reftable", and everything
that is used to implement it.

While at it, make the cmds[] list alphabetically sorted again by
moving the entry for "dump-reftable".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/helper/test-reftable.c     |  6 ------
 t/helper/test-tool.c         |  3 +--
 t/helper/test-tool.h         |  1 -
 t/t0032-reftable-unittest.sh | 16 ----------------
 4 files changed, 1 insertion(+), 25 deletions(-)

diff --git c/t/helper/test-reftable.c w/t/helper/test-reftable.c
index d27d7ee798..e62298c6a4 100644
--- c/t/helper/test-reftable.c
+++ w/t/helper/test-reftable.c
@@ -9,12 +9,6 @@
 #include "reftable/reftable-tests.h"
 #include "test-tool.h"
 
-int cmd__reftable(int argc, const char **argv)
-{
-	/* test from simple to complex. */
-	return 0;
-}
-
 static void print_help(void)
 {
 	printf("usage: dump [-st] arg\n\n"
diff --git c/t/helper/test-tool.c w/t/helper/test-tool.c
index f8a67df7de..252fa5de63 100644
--- c/t/helper/test-tool.c
+++ w/t/helper/test-tool.c
@@ -26,6 +26,7 @@ static struct test_cmd cmds[] = {
 	{ "drop-caches", cmd__drop_caches },
 	{ "dump-cache-tree", cmd__dump_cache_tree },
 	{ "dump-fsmonitor", cmd__dump_fsmonitor },
+	{ "dump-reftable", cmd__dump_reftable },
 	{ "dump-split-index", cmd__dump_split_index },
 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
 	{ "env-helper", cmd__env_helper },
@@ -61,9 +62,7 @@ static struct test_cmd cmds[] = {
 	{ "read-graph", cmd__read_graph },
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
-	{ "reftable", cmd__reftable },
 	{ "rot13-filter", cmd__rot13_filter },
-	{ "dump-reftable", cmd__dump_reftable },
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
diff --git c/t/helper/test-tool.h w/t/helper/test-tool.h
index e74bc0ffd4..84291318cb 100644
--- c/t/helper/test-tool.h
+++ w/t/helper/test-tool.h
@@ -55,7 +55,6 @@ int cmd__read_graph(int argc, const char **argv);
 int cmd__read_midx(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
 int cmd__rot13_filter(int argc, const char **argv);
-int cmd__reftable(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
 int cmd__repository(int argc, const char **argv);
 int cmd__revision_walking(int argc, const char **argv);
diff --git c/t/t0032-reftable-unittest.sh w/t/t0032-reftable-unittest.sh
deleted file mode 100755
index 471cb37ac2..0000000000
--- c/t/t0032-reftable-unittest.sh
+++ /dev/null
@@ -1,16 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2020 Google LLC
-#
-
-test_description='reftable unittests'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-test_expect_success 'unittests' '
-	TMPDIR=$(pwd) && export TMPDIR &&
-	test-tool reftable
-'
-
-test_done
