Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5832E1662E4
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632542; cv=none; b=eI2vZtGzxMrpP4DNJC5GJFZoCjSXJgHO0aFr/kAMui+QRkgtw9V3hxkcnh/DBbx66s96So/n3U1auVMjpvBTrcgr3Je8x9+kMgvn4RWKepnyse3rn9QFoH06uSlcGq+bv0se0IXGAKgaf+tftAy1NWoN/ZZa/IqAcBSPQXkXNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632542; c=relaxed/simple;
	bh=scyfPdq2V06500G2pRDTi20fXcYcMuUDYoY3L8FDJcE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hjBCJJCOsL/VTqpzrs4KhyNu7e/+wbr2wAIQEx1aTsdCTZmuKRGHFSZECZiJl498vulhcWuVwjyIDOIifYUgfrynJE7ynsq67Dzvx0RIm2vqbt16GnHCDx+PurwdxqN7xUmzEAEnAXuUFQhRG/Sas/G2O4Bblliqo98n25069fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8hX4gg2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8hX4gg2"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3609565a1bdso831782f8f.1
        for <git@vger.kernel.org>; Mon, 17 Jun 2024 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718632538; x=1719237338; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uzBgyJ6lpuMxoGz9mckqLchokCtBDb3zCBBOT6Xars=;
        b=I8hX4gg2cVeu2VmQa9fJsOR4BpoTo9RQ+Onfp2iJSsPseyYWsS1z2s3NsQ6+344yHC
         whU6NZ0spZbvNwNrHFKQpPGxpk+526jDnoPLcpE0ZznQ2Eq274rpX7T7NBKKTwnwKo9A
         btxL6papNqrNouvMzCkzKuxxpgLX09aKx194MSZoXAN4ona3kg/zRKFIMHyhRkJXOUZ/
         lRdzZVNYe5LzBdPIxJ3eX7tEjpVgIiWXLiKEd3u+Ymqy8EGLe1qhm9ej6PdzoCKvj2KM
         rQTfWv3Ok0HN6zBQct3ibpwOCVD7G+MvYHKUcAS491c9rW5tCMpQlu6wIsB4xtClqaQk
         vLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632538; x=1719237338;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uzBgyJ6lpuMxoGz9mckqLchokCtBDb3zCBBOT6Xars=;
        b=ve/DYn0ViPTFai5uwlnS3qyQEVJ5VzyE9Y+hqaNsp+MQqF73Q26ZioXPNJIamKrLe5
         YObyvqiB3b7FBB+2WQaps/bIpkLnC+0qh+wSREDrsPgwsdknk6s95x6UwvQl8ODg9UWi
         0gavdzNwc6nAG7TygqqkakNw5I2Mk8dHwTysxJCtup/LD7xY8ffP7bfuFnx++NZySknj
         gLukqzh5PcfH7GezjPlGjhVH7wqZsl+1BlBIqN7kHJmPsWAF+Dbv+6bUvcb9C8STyQgV
         oHrut3kZm1yKukQwPrJAHuCG7Wtb8pvFHIUwc1sSOVxOy3Ud62IUW+cjmgXllwT48K2A
         /YSw==
X-Gm-Message-State: AOJu0YwYL5gt6YCPL9CPM2ksxe1+PbcyVvOI7ZM1qUxCocKtza9FhCE0
	d/Gh7bJgiet+Ggx5BCqCV1qvM9g2g+zkK6NOdwT6BkS/1xtpYRYdMQ0Neg==
X-Google-Smtp-Source: AGHT+IERkKUz9xEbzTzeolExxfjObJq/jLOMslceI4c7sPhw3j0gNP6R7ONMFxAhuv8zYMTO6U6F7A==
X-Received: by 2002:a5d:5231:0:b0:360:98dc:fe9 with SMTP id ffacd0b85a97d-36098dc1004mr1478017f8f.5.1718632537821;
        Mon, 17 Jun 2024 06:55:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360751037b6sm11917153f8f.98.2024.06.17.06.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:55:37 -0700 (PDT)
Message-Id: <pull.1730.v7.git.1718632535.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v6.git.1718109943.gitgitgadget@gmail.com>
References: <pull.1730.v6.git.1718109943.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Jun 2024 13:55:32 +0000
Subject: [PATCH v7 0/3] object checking related additions and fixes for bundles in fetches
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    blanet <bupt_xingxin@163.com>

While attempting to fix a reference negotiation bug in bundle-uri, we
identified that the fetch process lacks some crucial object validation
checks when processing bundles. The primary issues are:

 1. In the bundle-uri scenario, object IDs were not validated before writing
    bundle references. This was the root cause of the original negotiation
    bug in bundle-uri and could lead to potential repository corruption.
 2. The existing "fetch.fsckObjects" and "transfer.fsckObjects"
    configurations were not applied when directly fetching bundles or
    fetching with bundle-uri enabled. In fact, there were no object
    validation supports for unbundle.

The first patch addresses the bundle-uri negotiation issue by removing the
REF_SKIP_OID_VERIFICATION flag when writing bundle references.

Patches 2 through 3 extend verify_bundle_flags for bundle.c:unbundle to add
support for object validation (fsck) in fetch scenarios, mainly following
the suggestions from Junio and Patrick on the mailing list.

Xing Xin (3):
  bundle-uri: verify oid before writing refs
  fetch-pack: expose fsckObjects configuration logic
  unbundle: extend object verification for fetches

 bundle-uri.c                |   6 +-
 bundle.c                    |   3 +
 bundle.h                    |   1 +
 fetch-pack.c                |  17 ++--
 fetch-pack.h                |   5 +
 t/t5558-clone-bundle-uri.sh | 181 +++++++++++++++++++++++++++++++++++-
 t/t5607-clone-bundle.sh     |  33 +++++++
 transport.c                 |   3 +-
 8 files changed, 235 insertions(+), 14 deletions(-)


base-commit: b9cfe4845cb2562584837bc0101c0ab76490a239
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1730%2Fblanet%2Fxx%2Fbundle-uri-bug-using-bundle-list-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1730/blanet/xx/bundle-uri-bug-using-bundle-list-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1730

Range-diff vs v6:

 1:  e958a3ab20c ! 1:  fc9f44fda00 bundle-uri: verify oid before writing refs
     @@ Commit message
          be found for negotiation because it exists in "incr.pack", which is not
          included in `packed_git`.
      
     -    This commit fixes the bug by removing `REF_SKIP_OID_VERIFICATION` flag
     -    when writing bundle refs. When `refs.c:refs_update_ref` is called to to
     -    write the corresponding bundle refs, it triggers
     -    `refs.c:ref_transaction_commit`.  This, in turn, invokes
     -    `refs.c:ref_transaction_prepare`, which calls `transaction_prepare` of
     -    the refs storage backend. For files backend, this function is
     -    `files-backend.c:files_transaction_prepare`, and for reftable backend,
     -    it is `reftable-backend.c:reftable_be_transaction_prepare`. Both
     -    functions eventually call `object.c:parse_object`, which can invoke
     +    Fix the bug by removing `REF_SKIP_OID_VERIFICATION` flag when writing
     +    bundle refs. When `refs.c:refs_update_ref` is called to write the
     +    corresponding bundle refs, it triggers `refs.c:ref_transaction_commit`.
     +    This, in turn, invokes `refs.c:ref_transaction_prepare`, which calls
     +    `transaction_prepare` of the refs storage backend. For files backend, it
     +    is `files-backend.c:files_transaction_prepare`, and for reftable
     +    backend, it is `reftable-backend.c:reftable_be_transaction_prepare`.
     +    Both functions eventually call `object.c:parse_object`, which can invoke
          `packfile.c:reprepare_packed_git` to refresh `packed_git`. This ensures
          that bundle refs point to valid objects and that all tips from bundle
          refs are correctly parsed during subsequent negotiations.
      
     -    A test has been added to demonstrate that bundles with incorrect
     -    headers, where refs point to non-existent objects, do not result in any
     -    bundle refs being created in the repository. Additionally, a set of
     -    negotiation-related tests for fetching with bundle-uri has been
     -    included.
     +    A set of negotiation-related tests for cloning with bundle-uri has been
     +    included to demonstrate that downloaded bundles are utilized to
     +    accelerate fetching.
     +
     +    Additionally, another test has been added to show that bundles with
     +    incorrect headers, where refs point to non-existent objects, do not
     +    result in any bundle refs being created in the repository.
      
          Reviewed-by: Karthik Nayak <karthik.188@gmail.com>
          Reviewed-by: Patrick Steinhardt <ps@pks.im>
     @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *fi
       	bundle_header_release(&header);
      
       ## t/t5558-clone-bundle-uri.sh ##
     +@@
     + test_description='test fetching bundles with --bundle-uri'
     + 
     + . ./test-lib.sh
     ++. "$TEST_DIRECTORY"/lib-bundle.sh
     + 
     + test_expect_success 'fail to clone from non-existent file' '
     + 	test_when_finished rm -rf test &&
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'fail to clone from non-bundle file' '
       
       test_expect_success 'create bundle' '
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'fail to clone from non-bundle
      +		git bundle create B.bundle topic &&
      +
      +		# Create a bundle with reference pointing to non-existent object.
     -+		sed "s/$(git rev-parse A)/$(git rev-parse B)/" <A.bundle >bad-header.bundle
     ++		sed -e "/^$/q" -e "s/$(git rev-parse A) /$(git rev-parse B) /" \
     ++			<A.bundle >bad-header.bundle &&
     ++		convert_bundle_to_pack \
     ++			<A.bundle >>bad-header.bundle
      +	)
       '
       
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone with path bundle' '
       '
       
      +test_expect_success 'clone with bundle that has bad header' '
     ++	# Write bundle ref fails, but clone can still proceed.
      +	git clone --bundle-uri="clone-from/bad-header.bundle" \
      +		clone-from clone-bad-header 2>err &&
     -+	# Write bundle ref fails, but clone can still proceed.
      +	commit_b=$(git -C clone-from rev-parse B) &&
      +	test_grep "trying to write ref '\''refs/bundles/topic'\'' with nonexistent object $commit_b" err &&
      +	git -C clone-bad-header for-each-ref --format="%(refname)" >refs &&
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (file, any m
       	! grep "refs/bundles/" refs
       '
       
     -+#########################################################################
     -+# Clone negotiation related tests begin here
     -+
      +test_expect_success 'negotiation: bundle with part of wanted commits' '
     -+	test_when_finished rm -rf trace*.txt &&
     ++	test_when_finished "rm -f trace*.txt" &&
      +	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
      +	git clone --no-local --bundle-uri="clone-from/A.bundle" \
      +		clone-from nego-bundle-part &&
      +	git -C nego-bundle-part for-each-ref --format="%(refname)" >refs &&
      +	grep "refs/bundles/" refs >actual &&
     -+	cat >expect <<-\EOF &&
     -+	refs/bundles/topic
     -+	EOF
     ++	test_write_lines refs/bundles/topic >expect &&
      +	test_cmp expect actual &&
      +	# Ensure that refs/bundles/topic are sent as "have".
     -+	grep "clone> have $(git -C clone-from rev-parse A)" trace-packet.txt
     ++	test_grep "clone> have $(git -C clone-from rev-parse A)" trace-packet.txt
      +'
      +
      +test_expect_success 'negotiation: bundle with all wanted commits' '
     -+	test_when_finished rm -rf trace*.txt &&
     ++	test_when_finished "rm -f trace*.txt" &&
      +	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
      +	git clone --no-local --single-branch --branch=topic --no-tags \
      +		--bundle-uri="clone-from/B.bundle" \
      +		clone-from nego-bundle-all &&
      +	git -C nego-bundle-all for-each-ref --format="%(refname)" >refs &&
      +	grep "refs/bundles/" refs >actual &&
     -+	cat >expect <<-\EOF &&
     -+	refs/bundles/topic
     -+	EOF
     ++	test_write_lines refs/bundles/topic >expect &&
      +	test_cmp expect actual &&
      +	# We already have all needed commits so no "want" needed.
      +	! grep "clone> want " trace-packet.txt
      +'
      +
      +test_expect_success 'negotiation: bundle list (no heuristic)' '
     -+	test_when_finished rm -f trace*.txt &&
     ++	test_when_finished "rm -f trace*.txt" &&
      +	cat >bundle-list <<-EOF &&
      +	[bundle]
      +		version = 1
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (file, any m
      +	refs/bundles/left
      +	EOF
      +	test_cmp expect actual &&
     -+	grep "clone> have $(git -C nego-bundle-list-no-heuristic rev-parse refs/bundles/left)" trace-packet.txt
     ++	test_grep "clone> have $(git -C nego-bundle-list-no-heuristic rev-parse refs/bundles/left)" trace-packet.txt
      +'
      +
      +test_expect_success 'negotiation: bundle list (creationToken)' '
     -+	test_when_finished rm -f trace*.txt &&
     ++	test_when_finished "rm -f trace*.txt" &&
      +	cat >bundle-list <<-EOF &&
      +	[bundle]
      +		version = 1
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (file, any m
      +	refs/bundles/left
      +	EOF
      +	test_cmp expect actual &&
     -+	grep "clone> have $(git -C nego-bundle-list-heuristic rev-parse refs/bundles/left)" trace-packet.txt
     ++	test_grep "clone> have $(git -C nego-bundle-list-heuristic rev-parse refs/bundles/left)" trace-packet.txt
      +'
      +
      +test_expect_success 'negotiation: bundle list with all wanted commits' '
     -+	test_when_finished rm -f trace*.txt &&
     ++	test_when_finished "rm -f trace*.txt" &&
      +	cat >bundle-list <<-EOF &&
      +	[bundle]
      +		version = 1
 2:  d21c236b8de = 2:  3dc0d9dd22f fetch-pack: expose fsckObjects configuration logic
 3:  53395e8c08a ! 3:  2f15099bbb9 unbundle: support object verification for fetches
     @@ Metadata
      Author: Xing Xin <xingxin.xx@bytedance.com>
      
       ## Commit message ##
     -    unbundle: support object verification for fetches
     +    unbundle: extend object verification for fetches
      
     -    This commit extends object verification support for fetches in
     -    `bundle.c:unbundle` by adding the `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH`
     -    option to `verify_bundle_flags`. When this option is enabled,
     -    `bundle.c:unbundle` invokes `fetch-pack.c:fetch_pack_fsck_objects` to
     -    determine whether to append the "--fsck-objects" flag to
     -    "git-index-pack".
     +    The existing fetch.fsckObjects and transfer.fsckObjects configurations
     +    were not fully applied to bundle-involved fetches, including direct
     +    bundle fetches and bundle-uri enabled fetches. Furthermore, there was no
     +    object verification support for unbundle.
      
     -    `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH` is now passed to `unbundle` in the
     -    fetching process, including:
     +    This commit extends object verification support in `bundle.c:unbundle`
     +    by adding the `VERIFY_BUNDLE_FSCK` option to `verify_bundle_flags`. When
     +    this option is enabled, we append the `--fsck-objects` flag to
     +    `git-index-pack`.
     +
     +    The `VERIFY_BUNDLE_FSCK` option is now used by bundle-involved fetches,
     +    where we use `fetch-pack.c:fetch_pack_fsck_objects` to determine whether
     +    to enable this option for `bundle.c:unbundle`, specifically in:
      
          - `transport.c:fetch_refs_from_bundle` for direct bundle fetches.
          - `bundle-uri.c:unbundle_from_file` for bundle-uri enabled fetches.
      
          This addition ensures a consistent logic for object verification during
     -    fetch operations. Tests have been added to confirm functionality in the
     -    scenarios mentioned above.
     +    fetches. Tests have been added to confirm functionality in the scenarios
     +    mentioned above.
      
          Reviewed-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
      
       ## bundle-uri.c ##
     +@@
     + #include "hashmap.h"
     + #include "pkt-line.h"
     + #include "config.h"
     ++#include "fetch-pack.h"
     + #include "remote.h"
     + 
     + static struct {
      @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *file)
       	 * the prerequisite commits.
       	 */
       	if ((result = unbundle(r, &header, bundle_fd, NULL,
      -			       VERIFY_BUNDLE_QUIET)))
     -+			       VERIFY_BUNDLE_QUIET | VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)))
     ++			       VERIFY_BUNDLE_QUIET | (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0))))
       		return 1;
       
       	/*
      
       ## bundle.c ##
     -@@
     - #include "list-objects-filter-options.h"
     - #include "connected.h"
     - #include "write-or-die.h"
     -+#include "fetch-pack.h"
     - 
     - static const char v2_bundle_signature[] = "# v2 git bundle\n";
     - static const char v3_bundle_signature[] = "# v3 git bundle\n";
      @@ bundle.c: int unbundle(struct repository *r, struct bundle_header *header,
       	if (header->filter.choice)
       		strvec_push(&ip.args, "--promisor=from-bundle");
       
     -+	if (flags & VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)
     -+		if (fetch_pack_fsck_objects())
     -+			strvec_push(&ip.args, "--fsck-objects");
     ++	if (flags & VERIFY_BUNDLE_FSCK)
     ++		strvec_push(&ip.args, "--fsck-objects");
      +
       	if (extra_index_pack_args) {
       		strvec_pushv(&ip.args, extra_index_pack_args->v);
     @@ bundle.h: int create_bundle(struct repository *r, const char *path,
       enum verify_bundle_flags {
       	VERIFY_BUNDLE_VERBOSE = (1 << 0),
       	VERIFY_BUNDLE_QUIET = (1 << 1),
     -+	VERIFY_BUNDLE_FSCK_FOLLOW_FETCH = (1 << 2),
     ++	VERIFY_BUNDLE_FSCK = (1 << 2),
       };
       
       int verify_bundle(struct repository *r, struct bundle_header *header,
      
       ## t/t5558-clone-bundle-uri.sh ##
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'create bundle' '
     - 		git bundle create B.bundle topic &&
     - 
     - 		# Create a bundle with reference pointing to non-existent object.
     --		sed "s/$(git rev-parse A)/$(git rev-parse B)/" <A.bundle >bad-header.bundle
     -+		sed "s/$(git rev-parse A)/$(git rev-parse B)/" <A.bundle >bad-header.bundle &&
     + 		sed -e "/^$/q" -e "s/$(git rev-parse A) /$(git rev-parse B) /" \
     + 			<A.bundle >bad-header.bundle &&
     + 		convert_bundle_to_pack \
     +-			<A.bundle >>bad-header.bundle
     ++			<A.bundle >>bad-header.bundle &&
      +
      +		cat >data <<-EOF &&
      +		tree $(git rev-parse HEAD^{tree})
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone with bundle that has bad
      +		clone-from clone-bad-object-no-fsck &&
      +	git -C clone-bad-object-no-fsck for-each-ref --format="%(refname)" >refs &&
      +	grep "refs/bundles/" refs >actual &&
     -+	cat >expect <<-\EOF &&
     -+	refs/bundles/bad
     -+	EOF
     ++	test_write_lines refs/bundles/bad >expect &&
      +	test_cmp expect actual &&
      +
      +	# Unbundle fails with fsckObjects set true, but clone can still proceed.
     @@ transport.c: static int fetch_refs_from_bundle(struct transport *transport,
       		get_refs_from_bundle_inner(transport);
       	ret = unbundle(the_repository, &data->header, data->fd,
      -		       &extra_index_pack_args, 0);
     -+		       &extra_index_pack_args, VERIFY_BUNDLE_FSCK_FOLLOW_FETCH);
     ++		       &extra_index_pack_args,
     ++		       fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0);
       	transport->hash_algo = data->header.hash_algo;
       	return ret;
       }

-- 
gitgitgadget
