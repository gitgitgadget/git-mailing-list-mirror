Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3D54673
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 04:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770059; cv=none; b=KWn15ta4M+/zSCFS9kL5RVbMBuXV6z5s/enHK1yS+BOjZnatfNV6cRmBwWOYmvCGIsvD2gikchDp+JZj0Mz//UWEWpm4DG6xRlZK8BmbBzkNtquQaoVclcqVKoVLXkF0kLWn3K+Cymwfg5FtRg2dyK5+FvIKvviQ3k6Y36ZSJT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770059; c=relaxed/simple;
	bh=m/s2Xjv/M8p4QynW9jqbTEB5kjBDDg6cE7f5LpIUGfQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kQCfF8/wnbu1T/SxawRD6d8UUFT7vWGoQy5GmaGFNU07UuQqCK+AmpceKbY9iacI3UDIBDtFmqhpTxBIGFyh8D4YmJ5PqHuq4DHgsTwRNb5xLkxFgNI7Xba+6fSNk9AvdhnlnsJv/UuqusHeN8JQZfaNGrhtgvNl2XpTJ9uZkkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hexj4OCf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hexj4OCf"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42198492353so47140775e9.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 21:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718770056; x=1719374856; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3TpcVFTGzmzKYtzM8bJCjchzrljmJbuwEoHTl9lbTY=;
        b=hexj4OCfGecgOlsMI6OiauBEofPyDO9uu1hl5iGB9ZEAiHBzRukbq7k6+LOIw6wjGB
         KHZBWGsQxnCYhSoPXjrmmi0bqO/CgqiAu35l/yEx1DMbm4MjRqWpXb2IYiZ4qGN38ghd
         933B/6tpCHwh2u3CTBh+Z795DwMBTYGtDFcbO2ZJlCQuibuv8wxECy08SinVOXr4SjZg
         tDIY7NKIOAknEkX2ctz+BBdaIlSVOHr/WxmbTW+VxVQyU1OyaqCCJSQ1RRndwehqdNwL
         vSi3h7SLYybjPqAvSUVFhI8WNTnd/am/cdtrXufuMFPeeIaeaIp2MmR7L5+x2U2BFfrZ
         zm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718770056; x=1719374856;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3TpcVFTGzmzKYtzM8bJCjchzrljmJbuwEoHTl9lbTY=;
        b=MDEQdh81UCP7KadERyfAfUnVZJ1QiZ/PGTsXhBXeNkaSoJQTaGa3uB7XuuGbkw0Bn2
         hzc5a/XI9FOYdCi09U/9JeMTFhJjMjN2/jBjLpxLpSCcBLhzlOE3D6YIfv76Y1JZ5s4I
         8OzEDPa5rlCVUCPLbdi7MNeXeJVvvnCbGhB8z2p2JR8iMcbXPesHqO0XLlElZ8KTheQ1
         7su3oEnCzHlkMAmAT80IdCU3UZDFZOfZVBqmPuAGBI/kBcNMzgKVJyu/jmJgavAIf75u
         aLNdXdEW+/6MDM7CdncVZAJNVTr5dECJubT58k/BTdtERVWF8EnwI3uch9KQhs3Oqeds
         AADQ==
X-Gm-Message-State: AOJu0Yx2UrwnwdA9PxPe3Kzat9B6SGikehFzr+nIpUBpOt1jwDlOqUpN
	YawYSvByowZeBisYEWHldiCwvNIYAO8WmlU8MlWjqQw4N5iWTLfR2vJPvw==
X-Google-Smtp-Source: AGHT+IHyQ0xtuxxi9QjRR1aUPtS6uNKOlhtwz2bE19+E6aHulVdKjsnLb/ABC07TG1Y453E5KdkrnQ==
X-Received: by 2002:a05:600c:2e09:b0:421:79c8:dd37 with SMTP id 5b1f17b1804b1-4247529d570mr7088825e9.40.1718770055797;
        Tue, 18 Jun 2024 21:07:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42307d5b78fsm163773665e9.6.2024.06.18.21.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 21:07:35 -0700 (PDT)
Message-Id: <pull.1730.v8.git.1718770053.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v7.git.1718632535.gitgitgadget@gmail.com>
References: <pull.1730.v7.git.1718632535.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 04:07:30 +0000
Subject: [PATCH v8 0/3] object checking related additions and fixes for bundles in fetches
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
 t/t5558-clone-bundle-uri.sh | 187 +++++++++++++++++++++++++++++++++++-
 t/t5607-clone-bundle.sh     |  35 +++++++
 transport.c                 |   3 +-
 8 files changed, 243 insertions(+), 14 deletions(-)


base-commit: b9cfe4845cb2562584837bc0101c0ab76490a239
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1730%2Fblanet%2Fxx%2Fbundle-uri-bug-using-bundle-list-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1730/blanet/xx/bundle-uri-bug-using-bundle-list-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/1730

Range-diff vs v7:

 1:  fc9f44fda00 ! 1:  d8fbde2dcd4 bundle-uri: verify oid before writing refs
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'fail to clone from non-bundle
      +		git bundle create B.bundle topic &&
      +
      +		# Create a bundle with reference pointing to non-existent object.
     -+		sed -e "/^$/q" -e "s/$(git rev-parse A) /$(git rev-parse B) /" \
     ++		commit_a=$(git rev-parse A) &&
     ++		commit_b=$(git rev-parse B) &&
     ++		sed -e "/^$/q" -e "s/$commit_a /$commit_b /" \
      +			<A.bundle >bad-header.bundle &&
      +		convert_bundle_to_pack \
      +			<A.bundle >>bad-header.bundle
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone with path bundle' '
      +	commit_b=$(git -C clone-from rev-parse B) &&
      +	test_grep "trying to write ref '\''refs/bundles/topic'\'' with nonexistent object $commit_b" err &&
      +	git -C clone-bad-header for-each-ref --format="%(refname)" >refs &&
     -+	! grep "refs/bundles/" refs
     ++	test_grep ! "refs/bundles/" refs
      +'
      +
       test_expect_success 'clone with path bundle and non-default hash' '
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (file, any m
      +	test_write_lines refs/bundles/topic >expect &&
      +	test_cmp expect actual &&
      +	# Ensure that refs/bundles/topic are sent as "have".
     -+	test_grep "clone> have $(git -C clone-from rev-parse A)" trace-packet.txt
     ++	tip=$(git -C clone-from rev-parse A) &&
     ++	test_grep "clone> have $tip" trace-packet.txt
      +'
      +
      +test_expect_success 'negotiation: bundle with all wanted commits' '
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (file, any m
      +	test_write_lines refs/bundles/topic >expect &&
      +	test_cmp expect actual &&
      +	# We already have all needed commits so no "want" needed.
     -+	! grep "clone> want " trace-packet.txt
     ++	test_grep ! "clone> want " trace-packet.txt
      +'
      +
      +test_expect_success 'negotiation: bundle list (no heuristic)' '
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (file, any m
      +	refs/bundles/left
      +	EOF
      +	test_cmp expect actual &&
     -+	test_grep "clone> have $(git -C nego-bundle-list-no-heuristic rev-parse refs/bundles/left)" trace-packet.txt
     ++	tip=$(git -C nego-bundle-list-no-heuristic rev-parse refs/bundles/left) &&
     ++	test_grep "clone> have $tip" trace-packet.txt
      +'
      +
      +test_expect_success 'negotiation: bundle list (creationToken)' '
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (file, any m
      +	refs/bundles/left
      +	EOF
      +	test_cmp expect actual &&
     -+	test_grep "clone> have $(git -C nego-bundle-list-heuristic rev-parse refs/bundles/left)" trace-packet.txt
     ++	tip=$(git -C nego-bundle-list-heuristic rev-parse refs/bundles/left) &&
     ++	test_grep "clone> have $tip" trace-packet.txt
      +'
      +
      +test_expect_success 'negotiation: bundle list with all wanted commits' '
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone bundle list (file, any m
      +	EOF
      +	test_cmp expect actual &&
      +	# We already have all needed commits so no "want" needed.
     -+	! grep "clone> want " trace-packet.txt
     ++	test_grep ! "clone> want " trace-packet.txt
      +'
      +
       #########################################################################
 2:  3dc0d9dd22f ! 2:  518584c8698 fetch-pack: expose fsckObjects configuration logic
     @@ Commit message
          "fetch.fsckObjects" to control checks for broken objects in received
          packs during fetches. However, these configurations were only
          acknowledged by `fetch-pack.c:get_pack` and did not take effect in
     -    direct bundle fetches and fetches with _bundle-uri_ enabled.
     +    direct bundle fetches or fetches with _bundle-uri_ enabled.
      
          This commit exposes the fetch-then-transfer configuration logic by
          adding a new function `fetch_pack_fsck_objects` in fetch-pack.h. This
          new function is used to replace the assignment for `fsck_objects` in
     -    `fetch-pack.c:get_pack`. In the next commit, it will also be used by
     -    `bundle.c:unbundle` to better fit fetching scenarios.
     +    `fetch-pack.c:get_pack`. In the next commit, this function will also be
     +    used to extend fsck support for bundle-involved fetches.
      
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Helped-by: Patrick Steinhardt <ps@pks.im>
 3:  2f15099bbb9 ! 3:  698dd6e49b7 unbundle: extend object verification for fetches
     @@ bundle.h: int create_bundle(struct repository *r, const char *path,
      
       ## t/t5558-clone-bundle-uri.sh ##
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'create bundle' '
     - 		sed -e "/^$/q" -e "s/$(git rev-parse A) /$(git rev-parse B) /" \
     + 		sed -e "/^$/q" -e "s/$commit_a /$commit_b /" \
       			<A.bundle >bad-header.bundle &&
       		convert_bundle_to_pack \
      -			<A.bundle >>bad-header.bundle
      +			<A.bundle >>bad-header.bundle &&
      +
     ++		tree_b=$(git rev-parse B^{tree}) &&
      +		cat >data <<-EOF &&
     -+		tree $(git rev-parse HEAD^{tree})
     -+		parent $(git rev-parse HEAD)
     ++		tree $tree_b
     ++		parent $commit_b
      +		author A U Thor
      +		committer A U Thor
      +
      +		commit: this is a commit with bad emails
      +
      +		EOF
     -+		git hash-object --literally -t commit -w --stdin <data >commit &&
     -+		git branch bad $(cat commit) &&
     ++		bad_commit=$(git hash-object --literally -t commit -w --stdin <data) &&
     ++		git branch bad $bad_commit &&
      +		git bundle create bad-object.bundle bad &&
      +		git update-ref -d refs/heads/bad
       	)
       '
       
      @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone with bundle that has bad header' '
     - 	! grep "refs/bundles/" refs
     + 	test_grep ! "refs/bundles/" refs
       '
       
      +test_expect_success 'clone with bundle that has bad object' '
     -+	# Unbundle succeeds if no fsckObjects confugured.
     ++	# Unbundle succeeds if no fsckObjects configured.
      +	git clone --bundle-uri="clone-from/bad-object.bundle" \
      +		clone-from clone-bad-object-no-fsck &&
      +	git -C clone-bad-object-no-fsck for-each-ref --format="%(refname)" >refs &&
     @@ t/t5558-clone-bundle-uri.sh: test_expect_success 'clone with bundle that has bad
      +		clone-from clone-bad-object-fsck 2>err &&
      +	test_grep "missingEmail" err &&
      +	git -C clone-bad-object-fsck for-each-ref --format="%(refname)" >refs &&
     -+	! grep "refs/bundles/" refs
     ++	test_grep ! "refs/bundles/" refs
      +'
      +
       test_expect_success 'clone with path bundle and non-default hash' '
     @@ t/t5607-clone-bundle.sh: test_expect_success 'fetch SHA-1 from bundle' '
      +	test_create_repo bundle-fsck &&
      +	(
      +		cd bundle-fsck &&
     -+		test_commit first &&
     ++		test_commit A &&
     ++		commit_a=$(git rev-parse A) &&
     ++		tree_a=$(git rev-parse A^{tree}) &&
      +		cat >data <<-EOF &&
     -+		tree $(git rev-parse HEAD^{tree})
     -+		parent $(git rev-parse HEAD)
     ++		tree $tree_a
     ++		parent $commit_a
      +		author A U Thor
      +		committer A U Thor
      +
      +		commit: this is a commit with bad emails
      +
      +		EOF
     -+		git hash-object --literally -t commit -w --stdin <data >commit &&
     -+		git branch bad $(cat commit) &&
     ++		bad_commit=$(git hash-object --literally -t commit -w --stdin <data) &&
     ++		git branch bad $bad_commit &&
      +		git bundle create bad.bundle bad
      +	) &&
      +

-- 
gitgitgadget
