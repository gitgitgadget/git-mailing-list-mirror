Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45236604E
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922756; cv=none; b=pnbYDSu7A6qWK8sbxBtxjUF5rr+QRALY1TOMV/mLvXyXqqoYDR9ufna4BpCdSxu8RImM+JXidnFCL4cWoXNu8UeYC6TCQn8y49dzoEZ25bqVRdi2NGdDsG+R37ZKNLUgJ/gF6oYbpoQ4rekEnFf7wgn6lIdiPmBvVXqT1hPj8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922756; c=relaxed/simple;
	bh=wqwq9Hze5Kj2cqiYEjOkSX3kAi0xvbcCpIDwI5y/SU0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=chVORSWI06OOQPlKXXQQdCDGTvdD/42zAalnBdNG5d+sQNQQCoO1qU1RpT7QGI4AmFqjEmBSTPvuvR1FOKyllBqZZprG+1yCHK2HzFOfPlz9HypsL0q2iE+2fAn0F6Jx11uMflcCUKf81sBrOZp5fv2Rk228rEdKfHLNi6QyMr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LVRI/9cG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=guZFhC+C; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LVRI/9cG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="guZFhC+C"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0115314001D1;
	Tue, 24 Feb 2026 03:45:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 24 Feb 2026 03:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771922753;
	 x=1772009153; bh=QjoFeXiLiQEZTYChe3CP5fQMgUVwqht5L4q7+E5pTv8=; b=
	LVRI/9cG2A2mUPPiYWnd+VzlUAeuKacNQDPJfzJdqmWoMyk0F2Uan8EB09IuCOdb
	blJaEDNNycFuUTeVgNfbo2pXazcIEANZCHuZdicHCRoUYBGV1Hlin+bxJ48AABiF
	5WDqiEIQyDMngqGI6hg/I1zA9Dn/HWb9QWfWBuGgnPSfXVMIPQ/uXUMtIMxYHCUy
	/YmC8pRx2dCgXCElvGVeP67XMTp4Su+YdScPiGcHrdeFTLgg14Tfs4W8MqtdHCzu
	yJ2KNwNTDlreR5KcH6UmLcWcUplQhXtxwtmWaMZQoL+kCsVqlOHD9pS+/JMSinpe
	+BCsewLByXkJOVZTnYe6YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771922753; x=
	1772009153; bh=QjoFeXiLiQEZTYChe3CP5fQMgUVwqht5L4q7+E5pTv8=; b=g
	uZFhC+CP2h3jPnh96U2yqdQ6M5oyGplJX4mB/K+dRnyHtlGMMUqAzcg6/0SkAec/
	/sXTkYfCnhKT/HbappsIHyB/ekibjoPrOodGksiOwe55rJjogrmeKHqiVBfq7HIT
	cxdMA71rYfSJ3GvP1rYNTgYAZdFnU3EIzGatVw5XIR0sFvh1Z0Ab1D2bGGHa7N30
	t28ZMce6UBgmAU59Re0jD7L1lr9IJMgTxeQNhquHvIPoVcu/noAAoJcTFd7haaOR
	OYiewCXJVyioAItDQeGp116CJxFti8YCgTTiaCVIriqZFYKqxRQyQQQ2jwhJG2OS
	Nt4c2bJYs/fuRQQ1HBsNw==
X-ME-Sender: <xms:QWWdaapufEJr65QTtFEwF7OvMyg3vzBQK7P5vDl8K8EoG1bqPso4NQ>
    <xme:QWWdafqaTu6Mgv0NIhAbJ2u40_Um2fgj5dfkfT7Vhm-0x7_StGrmZMg-MKGRKbWYV
    -aoVB_FU3dnetbDdpuw-hT3yZ1tdEzXTQdi6Kjdj6tTQ2QESZBLYJ0>
X-ME-Received: <xmr:QWWdaUOmFi9ypzzexDzOCr9ErZD2iJjR_irNc79c9EgtBvXFpzRUQIl4OM1r7CdOLKZgMP5HchsPUeYCNwFMgzZ4gE17C0t-7PFkn10yxMuOfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QWWdaYwK6Z5IY-f1iXQhCIbFD0b0fHmZRHn6Ng46SiQAmbdwQ3VNmQ>
    <xmx:QWWdaVt7BNfrOnKD83g7Pc8JKcin2OxC1NV2_MXaUwXqJ52usqaGRw>
    <xmx:QWWdaZ6VNoTaF-hdDeAmnnPWF4fhqVS6bNRtyh6yGK-ebHczerhXgQ>
    <xmx:QWWdacS7PM_TMcd16Dbsyzp333aMPzzKr7EIoIxej45AlIhG4FSbHg>
    <xmx:QWWdafIUJuwwbTaYEdzYVDwsetaJ4DsuCN_ISoJJkaWS9kCn0v9_RhVW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 03:45:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 94ae9697 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 08:45:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/8] builtin/maintenance: use "geometric" strategy by
 default
Date: Tue, 24 Feb 2026 09:45:44 +0100
Message-Id: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADhlnWkC/5XNTQ6CMBCG4auQrh3TKQR/Vt7DsCjtFCZKIW0lE
 sLdrcQLuHwnme9ZRaTAFMW1WEWgmSOPPoc6FML02ncEbHMLJVUtFZ6hrWB6RBg0+0Ree0Ngyen
 XM0FH40ApsIGYgk7ULYAnZ8i6i6pqFHlzCuT4vXv3JnfPMY1h2fkZv9efpOSf0owgwWlqS4XaY
 tne8vORB9Fs2/YBjQ9YpecAAAA=
X-Change-ID: 20260218-b4-pks-maintenance-default-geometric-strategy-17fcedf92461
In-Reply-To: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Hi,

this series converts our default strategy used by git-maintenance(1)
from "gc" to "geometric". The aim of this is twofold:

  - It completes the conversion to a more flexible infrastructure for
    repository maintenance. git-maintenance(1) is structured around
    tasks that can be toggled on/off as needed, and this is a lot easier
    to extend going forward.

  - We start to use a more efficient repacking strategy by default,
    which should especially help large repositories out there.

Out of these two, I think that the first point is actually the more
important one.

Unfortunately, a lot of our tests are racy or will fail with the new
strategy. This is mostly because the new strategy may decide to optimize
data structures in cases where the old strategy didn't, and because the
tasks we perform might be different. The majority of this patch series
thus adapts our tests accordingly. The actual change is a one-line
change in the final commit.

I was a bit torn initially whether or not I want to make the geometric
strategy the default right away, or whether we might first want to use
"feature.experimental" as an additional step. I'm quite happy to adapt
the series accordingly, but for the initial version I thought it might
invite more discussions if I pick the nuclear option :)

Of course, no matter how we do this, it is still possible to revert back
to the old strategy by setting "maintenance.strategy=gc".

Changes in v2:
  - Document the updated default strategy.
  - Clarify how this interacts with Scalar.
  - Explain the current landscape of strategies a bit better.
  - Leave some breadcrumbs in the tests.
  - Link to v1: https://lore.kernel.org/r/20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (8):
      t: fix races caused by background maintenance
      t: disable maintenance where we verify object database structure
      t34xx: don't expire reflogs where it matters
      t5400: explicitly use "gc" strategy
      t5510: explicitly use "gc" strategy
      t6500: explicitly use "gc" strategy
      t7900: prepare for switch of the default strategy
      builtin/maintenance: use "geometric" strategy by default

 Documentation/config/maintenance.adoc   | 6 +++---
 builtin/gc.c                            | 2 +-
 run-command.c                           | 2 +-
 t/t0081-find-pack.sh                    | 1 +
 t/t3404-rebase-interactive.sh           | 6 ++++++
 t/t3406-rebase-message.sh               | 6 ++++++
 t/t3431-rebase-fork-point.sh            | 6 ++++++
 t/t3432-rebase-fast-forward.sh          | 6 ++++++
 t/t5316-pack-delta-depth.sh             | 1 +
 t/t5319-multi-pack-index.sh             | 1 +
 t/t5326-multi-pack-bitmaps.sh           | 3 ++-
 t/t5327-multi-pack-bitmaps-rev.sh       | 3 ++-
 t/t5331-pack-objects-stdin.sh           | 2 ++
 t/t5332-multi-pack-reuse.sh             | 1 +
 t/t5334-incremental-multi-pack-index.sh | 1 +
 t/t5400-send-pack.sh                    | 1 +
 t/t5500-fetch-pack.sh                   | 3 ++-
 t/t5510-fetch.sh                        | 1 +
 t/t5616-partial-clone.sh                | 7 ++++---
 t/t6500-gc.sh                           | 1 +
 t/t7700-repack.sh                       | 3 +++
 t/t7900-maintenance.sh                  | 9 ++++++++-
 t/test-lib.sh                           | 4 ++++
 23 files changed, 64 insertions(+), 12 deletions(-)

Range-diff versus v1:

1:  c5fadf42d0 ! 1:  9efc6d0a22 t: fix races caused by background maintenance
    @@ Commit message
         background maintenance all over the place.
     
         Disabling maintenance outright in our test suite is not really an
    -    option, as it would result in significantly divergence from the "real
    +    option, as it would result in significant divergence from the "real
         world" and reduce our test coverage. But we've got an alternative up our
         sleeves: we can ensure that garbage collection runs synchronously by
         overriding the "maintenance.autoDetach" configuration.
    @@ Commit message
         slightly, but that may just as well be noise.
     
         Introduce a new `GIT_TEST_MAINT_AUTO_DETACH` environment variable that
    -    allows us to override the auto-detach behaviour and set that varibale in
    +    allows us to override the auto-detach behaviour and set that variable in
         our tests.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    @@ t/t5616-partial-clone.sh: test_expect_success 'fetch --refetch triggers repackin
     
      ## t/t7900-maintenance.sh ##
     @@ t/t7900-maintenance.sh: test_description='git maintenance builtin'
    - 
      GIT_TEST_COMMIT_GRAPH=0
      GIT_TEST_MULTI_PACK_INDEX=0
    -+sane_unset GIT_TEST_MAINT_AUTO_DETACH
      
    ++# Ensure that auto-maintenance detaches as usual.
    ++sane_unset GIT_TEST_MAINT_AUTO_DETACH
    ++
      test_lazy_prereq XMLLINT '
      	xmllint --version
    + '
     
      ## t/test-lib.sh ##
     @@ t/test-lib.sh: test_lazy_prereq COMPAT_HASH '
2:  805417a4a7 = 2:  f80bde1353 t: disable maintenance where we verify object database structure
3:  8a579a768d ! 3:  7087a68815 t34xx: don't expire reflogs where it matters
    @@ t/t3404-rebase-interactive.sh: Initial setup:
      . "$TEST_DIRECTORY"/lib-rebase.sh
      
      test_expect_success 'setup' '
    ++	# Commit dates are hardcoded to 2005, and the reflog entries will have
    ++	# a matching timestamp. Maintenance may thus immediately expire
    ++	# reflogs if it was running.
     +	git config set gc.reflogExpire never &&
     +	git config set gc.reflogExpireUnreachable never &&
    ++
      	git switch -C primary &&
      	test_commit A file1 &&
      	test_commit B file1 &&
    @@ t/t3406-rebase-message.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      . ./test-lib.sh
      
      test_expect_success 'setup' '
    ++	# Commit dates are hardcoded to 2005, and the reflog entries will have
    ++	# a matching timestamp. Maintenance may thus immediately expire
    ++	# reflogs if it was running.
     +	git config set gc.reflogExpire never &&
     +	git config set gc.reflogExpireUnreachable never &&
     +
    @@ t/t3431-rebase-fork-point.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      # C was formerly part of main but main was rewound to remove C
      #
      test_expect_success setup '
    ++	# Commit dates are hardcoded to 2005, and the reflog entries will have
    ++	# a matching timestamp. Maintenance may thus immediately expire
    ++	# reflogs if it was running.
     +	git config set gc.reflogExpire never &&
     +	git config set gc.reflogExpireUnreachable never &&
    ++
      	test_commit A &&
      	test_commit B &&
      	test_commit C &&
    @@ t/t3432-rebase-fast-forward.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      . ./test-lib.sh
      
      test_expect_success setup '
    ++	# Commit dates are hardcoded to 2005, and the reflog entries will have
    ++	# a matching timestamp. Maintenance may thus immediately expire
    ++	# reflogs if it was running.
     +	git config set gc.reflogExpire never &&
     +	git config set gc.reflogExpireUnreachable never &&
    ++
      	test_commit A &&
      	test_commit B &&
      	test_commit C &&
4:  283143c1d8 = 4:  d230055b22 t5400: explicitly use "gc" strategy
5:  410dc16eb0 = 5:  dba219391f t5510: explicitly use "gc" strategy
6:  c4c8c5a7e4 = 6:  61bc1add2a t6500: explicitly use "gc" strategy
7:  93893cfee3 = 7:  b89505178d t7900: prepare for switch of the default strategy
8:  9e7aa390a5 < -:  ---------- builtin/maintenance: use "geometric" strategy by default
-:  ---------- > 8:  647d46a239 builtin/maintenance: use "geometric" strategy by default

---
base-commit: 73fd77805fc6406f31c36212846d9e2541d19321
change-id: 20260218-b4-pks-maintenance-default-geometric-strategy-17fcedf92461

