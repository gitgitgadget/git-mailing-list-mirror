Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474B14E2ED
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351169; cv=none; b=nQzi3uLbJLnIoFMMFd18dbltgVMOchhrCPFEwcQ/5IXNTEPp1sopi7qxNXtulDvqMyZLWfb2WmT9moBYcfk3+o7fMz7/GgaLqjooubM3p2VJccFCjt6SgbOfRfypLQ7nu787VeZHE5IuTzKTWulzQe8VxsVDfDOLHXty5NO9Ih0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351169; c=relaxed/simple;
	bh=zq6hQTHi7h3KQO+bZAmhLGR2olDrl2qZD0rhAZ52E4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQAZsl/rHLGriZE8SMEFQJuhxZ1puBsPj6uNV6uua2QFLXwWJq3L3BQ+nU3qhhVids8XQhErNBWrIj2yYaPyn3enuihBDLxkWCsyDT357lbwkdOuVdT2CijaHq75Epmgsfa/jesWNNlpaK/ram7CStd7Y1tJO7hSbul9flfamoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sn0USNsa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AacISyGl; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sn0USNsa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AacISyGl"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 49FFC1140287;
	Thu, 26 Sep 2024 07:46:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 26 Sep 2024 07:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351165; x=1727437565; bh=9NCTR1rvBv
	wQdBTEpukuZXSYvBZkSd/A2VTZtAIno90=; b=sn0USNsazI9xGBO5e69ltLLTgM
	m0gzHCA7HCvoc3VC8YuNY3lqDf4IJVEn6OGdYYixtXFuGIol11RVJZWBXcnR1gUR
	ckgPBVRfHSPv3R3ASO5nyUxZTv5isGIDig6c27wzkd1ba6kAYKGC0PGfKEqggu6t
	xhHkHyCCzuyjAUaNqpXcAjWGuaYC4vZOHhtgEXD3d5cBFob6QpdtgKaXBxIYXoCG
	Fh9FcXogdEORJXNCoTGkJZwX7IhylHSmzQks4B3U39SMo23xUf2k4akb07eB9TSG
	CUSc6/JryDJ3GuJgm736pohcA6dzUTJes1r/GJTBFtQcS1dcTvI7CBcNFCKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351165; x=1727437565; bh=9NCTR1rvBvwQdBTEpukuZXSYvBZk
	Sd/A2VTZtAIno90=; b=AacISyGl6EjeeMjb6fC+oHmtABqrXB+YyBjYHiXBwf/k
	gvlcmL1wkNO/nUh7in5UFtvswfkyd5cYsWh5l8MlcyHfmmrgrrcu4jWLv/WoDuKu
	mdl7lJEHaXAK8QbWa6MqZsWDsMImJLXNwwulnN10fvVbNhnoagcRjP8IR78ELrdA
	coL0NoQCmSDzgsBvmLCeDrziLzJQv7IvNfO0qTX3g5Fb3JesW/9tv0el0MrKDnUM
	qNvf0XeYplLa2FmLLuixB9Ru3itTNPl386WQZKBiVngBLBd8X3m/WCDO4ewt/LqX
	5gnzxfcUyM9DOYyayFVEfidQgNotxgBNNMXmbVc3gw==
X-ME-Sender: <xms:fEn1ZmhSArzHBK5SbcisSX1UORCc5cgVetQ4CqQBt0irAPelrdBlqw>
    <xme:fUn1ZnCi3JIvMPIBTmCdZT6avNnxBjSMhgsVVF4opSAsMbYSpWHc_pn0noEVcYp0N
    wgwylhFDPCRVvpeKw>
X-ME-Received: <xmr:fUn1ZuEhgpiriVfwMDHar9gJCxe_iGEiBP3jYFNLC9AHjIOvxoF6GZxs3Z4wAAXZ6ITHhhMK5AzJzz2Hy7RbsUYPnLguOMFxHp_lOjlOtPQ3mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fUn1ZvT-J3iWAgLlo4xBdC3Ih3yXgz7RNuxBsh1Kx98vNuoj4_escg>
    <xmx:fUn1ZjyKSvXMcVc00-LvUxcRGj2DB9K6VAN_AMJrOk5mXurWtqLuzg>
    <xmx:fUn1Zt5fJWHPn3Sf8U1pPy49Jy5627WVnXRIZ6XNBbz_SrUpSFik-g>
    <xmx:fUn1ZgzXUEjwl0V216R1KUQByaQo2A9jWQHdmVS_YHrQ9KG9UFxcpQ>
    <xmx:fUn1Zj-jGl_s3DMLSrSMq7ORQVExf29zC-hmVIUBSXqp-uVvYIAgJJ9y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f835c2f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:45:23 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:45:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/23] Memory leak fixes (pt.7)
Message-ID: <cover.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726484308.git.ps@pks.im>

Hi,

this is the second version of another round of memory leak fixes.
There's only a single change compared to v1, namely a revised commit
message.

Thanks!

Patrick

Patrick Steinhardt (23):
  builtin/help: fix dangling reference to `html_path`
  builtin/help: fix leaking `html_path` when reading config multiple
    times
  git: fix leaking argv when handling builtins
  submodule: fix leaking update strategy
  builtin/submodule--helper: clear child process when not running it
  builtin/submodule--helper: fix leaking error buffer
  t/helper: fix leaking subrepo in nested submodule config helper
  builtin/submodule--helper: fix leaking remote ref on errors
  dir: fix off by one errors for ignored and untracked entries
  builtin/pull: fix leaking "ff" option
  diff: fix leaking orderfile option
  parse-options: free previous value of `OPTION_FILENAME`
  diffcore-order: fix leaking buffer when parsing orderfiles
  builtin/repack: fix leaking configuration
  builtin/difftool: plug several trivial memory leaks
  trace2: destroy context stored in thread-local storage
  submodule: fix leaking submodule ODB paths
  grep: fix leaking grep pattern
  promisor-remote: fix leaking partial clone filter
  builtin/maintenance: fix leaking config string
  builtin/maintenance: fix leak in `get_schedule_cmd()`
  revision: fix leaking parents when simplifying commits
  diffcore-break: fix leaking filespecs when merging broken pairs

 builtin/difftool.c                            |   6 +
 builtin/gc.c                                  | 131 +++++++++++-------
 builtin/help.c                                |  16 ++-
 builtin/pull.c                                |  11 +-
 builtin/repack.c                              |  57 ++++++--
 builtin/submodule--helper.c                   |  26 +++-
 combine-diff.c                                |   3 +-
 diff.c                                        |   7 +-
 diff.h                                        |   2 +-
 diffcore-break.c                              |   4 +-
 diffcore-order.c                              |  19 +--
 dir.c                                         |   6 +-
 git.c                                         |  22 ++-
 grep.c                                        |   2 +-
 parse-options.c                               |  22 +--
 promisor-remote.c                             |   2 +
 revision.c                                    |   5 +
 submodule-config.c                            |   2 +-
 submodule.c                                   |   9 +-
 submodule.h                                   |   6 +-
 t/helper/test-submodule-nested-repo-config.c  |   2 +-
 t/t0012-help.sh                               |   1 +
 t/t1414-reflog-walk.sh                        |   1 +
 ...common-prefixes-and-directory-traversal.sh |   1 +
 t/t4008-diff-break-rewrite.sh                 |   2 +
 t/t4022-diff-rewrite.sh                       |   1 +
 t/t4023-diff-rename-typechange.sh             |   1 +
 t/t4031-diff-rewrite-binary.sh                |   1 +
 t/t4056-diff-order.sh                         |   1 +
 t/t4204-patch-id.sh                           |   1 +
 t/t5310-pack-bitmaps.sh                       |   1 +
 t/t5326-multi-pack-bitmaps.sh                 |   2 +
 t/t5329-pack-objects-cruft.sh                 |   2 +
 t/t6004-rev-list-path-optim.sh                |   1 +
 t/t6019-rev-list-ancestry-path.sh             |   1 +
 t/t6111-rev-list-treesame.sh                  |   1 +
 t/t7061-wtstatus-ignore.sh                    |   1 +
 t/t7406-submodule-update.sh                   |   1 +
 t/t7407-submodule-foreach.sh                  |   1 +
 t/t7408-submodule-reference.sh                |   2 +
 t/t7411-submodule-config.sh                   |   1 +
 t/t7420-submodule-set-url.sh                  |   1 +
 t/t7521-ignored-mode.sh                       |   1 +
 t/t7524-commit-summary.sh                     |   2 +
 t/t7601-merge-pull-config.sh                  |   1 +
 t/t7700-repack.sh                             |   1 +
 t/t7800-difftool.sh                           |   1 +
 t/t7814-grep-recurse-submodules.sh            |   1 +
 t/t7900-maintenance.sh                        |   1 +
 trace2/tr2_tls.c                              |  10 +-
 50 files changed, 279 insertions(+), 124 deletions(-)

Range-diff against v1:
 1:  e3bed973af =  1:  e3bed973af builtin/help: fix dangling reference to `html_path`
 2:  4a59fe15ae =  2:  4a59fe15ae builtin/help: fix leaking `html_path` when reading config multiple times
 3:  ea3dd851ad =  3:  ea3dd851ad git: fix leaking argv when handling builtins
 4:  7cdd2691b7 =  4:  7cdd2691b7 submodule: fix leaking update strategy
 5:  0d0964a2be =  5:  0d0964a2be builtin/submodule--helper: clear child process when not running it
 6:  52d12e034b =  6:  52d12e034b builtin/submodule--helper: fix leaking error buffer
 7:  96bd7f01d5 =  7:  96bd7f01d5 t/helper: fix leaking subrepo in nested submodule config helper
 8:  d088703d31 !  8:  d5e7a24aac builtin/submodule--helper: fix leaking remote ref on errors
    @@ Metadata
      ## Commit message ##
         builtin/submodule--helper: fix leaking remote ref on errors
     
    -    When `update_submodule()` fails we return with `die_message()`.
    -    Curiously enough, this causes a memory leak because we use the
    -    `run_process_parallel()` interfaces here, which swap out the die
    -    routine.
    +    When `update_submodule()` fails we return with `die_message()`, which
    +    only causes us to print the same message as `die()` would without
    +    actually causing the process to die. We don't free memory in that case
    +    and thus leak memory.
     
         Fix the leak by freeing the remote ref.
     
 9:  d5c9cccb82 =  9:  fca161d389 dir: fix off by one errors for ignored and untracked entries
10:  747c9a76a2 = 10:  2338b5e2a8 builtin/pull: fix leaking "ff" option
11:  85c0f9e5f5 = 11:  cb08db4d37 diff: fix leaking orderfile option
12:  330b6c52a0 = 12:  650b89bcca parse-options: free previous value of `OPTION_FILENAME`
13:  c975dfe462 = 13:  cd79422087 diffcore-order: fix leaking buffer when parsing orderfiles
14:  a5f3931eee = 14:  e015d1704b builtin/repack: fix leaking configuration
15:  c79a5118e4 = 15:  7bb07ec2f0 builtin/difftool: plug several trivial memory leaks
16:  0fb3dc55e5 = 16:  30928eb8f9 trace2: destroy context stored in thread-local storage
17:  f1cb8122d1 = 17:  35f5de5467 submodule: fix leaking submodule ODB paths
18:  411df7248d = 18:  3d1cece660 grep: fix leaking grep pattern
19:  690de28bef = 19:  da7768bad5 promisor-remote: fix leaking partial clone filter
20:  ed4091255c = 20:  0a72fc83f7 builtin/maintenance: fix leaking config string
21:  46956bd8fb = 21:  95200b8a76 builtin/maintenance: fix leak in `get_schedule_cmd()`
22:  2a23df9a68 = 22:  8e7ea54863 revision: fix leaking parents when simplifying commits
23:  57a3a9e9f8 = 23:  8cbc41425f diffcore-break: fix leaking filespecs when merging broken pairs
-- 
2.46.2.852.g229c0bf0e5.dirty

