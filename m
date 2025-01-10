Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5DA202F87
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508725; cv=none; b=Ip4OHxxAF8kslhsDXOims7a8CW7JRFaE9dqI4fxChHYZ0rM+T15dYMIrCgiUCSbVc1z3A3FF/mMlweXhno5cdFSsa8mqotR8v6oqGFUC2x8eFip4+WLQRFdus41UoW6+CUAUYtbr6k8cLsyvmj3mnaZvaC75SVdloOXboHr9qvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508725; c=relaxed/simple;
	bh=ru9hIUUYaduCw25ecPjINu/7hFC+OeK1d1FhQRwMDK8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=JruJP5ZnTFjlwxlFA4NCmrcw/MkysbqSoz7VezQ0WNGUFl5g3Hys/U+O7FJUjlT4CR6EUm33tA20hNP1gca/OTO59SH7aFmFq7I+cb8GDGauU71QgMBhMdUeogqtuw+FNepUhsAVBB3lCH/z203PBWWDF4SDUPDJCGJEnCH/Sz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OJUy7F9u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s/CzQn2c; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OJUy7F9u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s/CzQn2c"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA6AF1140106;
	Fri, 10 Jan 2025 06:32:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 10 Jan 2025 06:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736508722;
	 x=1736595122; bh=POA673yOLntILNVQE/bQp5s5+9AuZkNxLJ7mkO0QmsE=; b=
	OJUy7F9uuxNbUn4dmIxVbi2tTy3vFc0AAEbI3Ki3U2BkcjV/yOaTICBAA8QczsAV
	APGMvQkl86ERGJVVwBHr7sQcLolp1tMPnP6vol+KH+yZPO97h/mkBNhk9L8YuL74
	RrPVumLC7myxG9E0uEeFylS10+stk/Ny8rGhB5d78RKW6s7r5DQKnBgoTDgnlsP7
	PGPsZeq3kk7m5Oovg/9B0AUaWPhs8pRW/CTm7FxUu0cG8vuoIkzpYr0nBkEeIYBO
	3QJg0cflmBjtMw9QSJKa+/1i8ZwURg2Wp1LKWYMO+nMM48uhE2mNx+KlQXm1yli9
	woq1rFEIKIF5NPLb1F5XMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736508722; x=
	1736595122; bh=POA673yOLntILNVQE/bQp5s5+9AuZkNxLJ7mkO0QmsE=; b=s
	/CzQn2cLqd8IcpvIRNh7HNbSUsUt+/SHrnKR9SOstdyVRD/aI8YaZHQxClFfamMf
	Vj8/llyYUIH00i+Wrr/0JT6tBd+ZpIiPUPOMwvbw/A/cnDzQnYaRgh0Ev9O23GWI
	AhD0gpKNrDVgs4WM6ItG3vNUGglFZ0MzxU18vFMvAQSUr416AfYxMsxjQBmzaMdB
	db3guXMLlH7h2CSvAukkNN7W3NgCXPjqs8Oibj35Hi730njmGyBAcEp8BZic2ACq
	Id7p8fQ5Bm9kW5onwMDUkZiCavt7TVbG3xMWW1Tbs2arSzx3kdvFAk1yebxhRfKR
	wd8gSBevvFkDOgz62xyog==
X-ME-Sender: <xms:MgWBZ7hcpWjthmld6fN39WRkPHb3MIuMMfubwVRGYtKs1M-UuGMCEA>
    <xme:MgWBZ4DmS3GiqajAA4gqzVkVcQ3zNqbR4gLTDYYQ--SlL9AXNroGDP-MWbii9U4Br
    ny_GHMZlblNXxsTrQ>
X-ME-Received: <xmr:MgWBZ7F8yOMgsM58H_3Be3rx8N1zLmW-qIHK-RFSHxoS7Oi-_nLapTdABVmNrjl5Po0DVz5SukSNE8flTNFS5J4PFK9wkwih3eN1KikBfYPP2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevjeefheeggeeljeduffetveehgfeiueehgffgudff
    ffffgeeifeetveejleeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtlh
    grsgdrtghomhdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepge
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MgWBZ4SJc9J7EYyJ-fuRgDmrgQdW8lOV6-Rt3NCPPJf7zThQS1cZNQ>
    <xmx:MgWBZ4zpseLhYJoj5Yqq6kXRafgr3JMOCHvJljV6cyWOiShJ2npGdw>
    <xmx:MgWBZ-7UipPSnz-hQmhvnCyzq55b93tJh1MbW29HliVtWExLVrh11g>
    <xmx:MgWBZ9wOcK9Ipox3DpVDfnPrgM-pjs68axeYOi55p1QekxZjUssADQ>
    <xmx:MgWBZysdalXM2ia6B0TemyS3whT5bDgl1LIeWaOalhuDV68bHkJfm6Sy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 06:32:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 243f8207 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jan 2025 11:31:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/10] A couple of CI improvements
Date: Fri, 10 Jan 2025 12:31:56 +0100
Message-Id: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC0FgWcC/3XNTQrCMBAF4KuUrI3kt0ldeQ9xkaQTG8S2JBKU0
 rubdiGV4vLN43szoQQxQEKnakIRckhh6EsQhwq5zvQ3wKEtGTHCJKGEYyvweE/YBezDCxJmLTG
 Meyud0qioMcJaFHS5ltyF9Bzie32Q6XL9v5UpJtg01jay9V5zfi71MTzQMpTZFtd7zAomtQEpi
 FLUqh/Mt1jtMS9YitoQsE4LTb94nucPrczrJyUBAAA=
X-Change-ID: 20250103-b4-pks-ci-fixes-2d0a23fb5c78
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.2

Hi,

this patch series addresses a couple of issues I've found while
investigating flaky CI jobs. Besides two more fixes for flaky jobs it
also removes some stale code and simplifies the setup on GitHub Actions
to always use containerized jobs on Linux.

Test runs can be found for GitLab [1] and GitHub [2].

Changes in v2:

  - Expand a bit on the reasoning behind the conversion to use
    containerized jobs.
  - Fix commit message typo.
  - Properly fix the race in t7422 via pipe stuffing, as proposed by
    Peff.
  - Link to v1: https://lore.kernel.org/r/20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im

Changes in v3:

  - Another iteration on the SIGPIPE test, which should now finally plug
    the race.
  - Link to v2: https://lore.kernel.org/r/20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im

Changes in v4:

  - Improve the commit message of the SIGPIPE test commit to more
    accurately describe the race.
  - Link to v3: https://lore.kernel.org/r/20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/277
[2]: https://github.com/git/git/pull/1865

---
Patrick Steinhardt (10):
      t0060: fix EBUSY in MinGW when setting up runtime prefix
      t7422: fix flaky test caused by buffered stdout
      github: adapt containerized jobs to be rootless
      github: convert all Linux jobs to be containerized
      github: simplify computation of the job's distro
      gitlab-ci: remove the "linux-old" job
      gitlab-ci: add linux32 job testing against i386
      ci: stop special-casing for Ubuntu 16.04
      ci: use latest Ubuntu release
      ci: remove stale code for Azure Pipelines

 .github/workflows/main.yml  | 78 ++++++++++++++++++++++-----------------------
 .gitlab-ci.yml              | 19 ++++++-----
 ci/install-dependencies.sh  |  6 ++--
 ci/lib.sh                   | 34 +++-----------------
 ci/print-test-failures.sh   |  5 ---
 t/t0060-path-utils.sh       | 10 +++---
 t/t7422-submodule-output.sh | 43 ++++++++++++++++++++++---
 7 files changed, 100 insertions(+), 95 deletions(-)

Range-diff versus v3:

 1:  324b174988 =  1:  ca4dc636aa t0060: fix EBUSY in MinGW when setting up runtime prefix
 2:  cc095aa2b1 !  2:  d41c00feb1 t7422: fix flaky test caused by buffered stdout
    @@ Commit message
             error: last command exited with $?=1
             not ok 18 - git submodule status --recursive propagates SIGPIPE
     
    -    The issue is caused by us using grep(1) to terminate the pipe on the
    -    first matching line in the recursing git-submodule(1) process. Standard
    -    streams are typically buffered though, so this condition is racy and may
    -    cause us to terminate the pipe after git-submodule(1) has already
    -    exited, and in that case we wouldn't see the expected signal.
    +    The issue is caused by a race between git-submodule(1) and grep(1):
    +
    +      1. git-submodule(1) (or its child process) writes the first X/S line
    +         we're trying to match.
    +
    +      2. grep(1) matches the line.
    +
    +      3a. grep(1) exits, closing the pipe.
    +
    +      3b. git-submodule(1) (or its child process) writes the rest of its
    +      lines.
    +
    +    Steps 3a and 3b happen at the same time without any guarantees. If 3a
    +    happens first, we get SIGPIPE. Otherwise, we don't and the test fails.
     
         Fix the issue by generating a couple thousand nested submodules and
         matching on the first nested submodule. This ensures that the recursive
         git-submodule(1) process completely fills its stdout buffer, which makes
         subsequent writes block until the downstream consumer of the pipe either
    -    fully drains it or closes it.
    +    reads more or closes it.
     
         To verify that this works as expected one can apply the following patch
         to the preimage of this commit, which used to reliably trigger the race:
 3:  73c98e7628 =  3:  6593e3307c github: adapt containerized jobs to be rootless
 4:  4d8f2bdce7 =  4:  9997698c6e github: convert all Linux jobs to be containerized
 5:  4a987aa42e =  5:  65797c51dc github: simplify computation of the job's distro
 6:  bd44700668 =  6:  687ae0c3f2 gitlab-ci: remove the "linux-old" job
 7:  e095c6757c =  7:  974229776b gitlab-ci: add linux32 job testing against i386
 8:  f885740877 =  8:  112ea61a6b ci: stop special-casing for Ubuntu 16.04
 9:  17b19dc51e =  9:  465cd85898 ci: use latest Ubuntu release
10:  95ce4406c7 = 10:  d671ee1f7f ci: remove stale code for Azure Pipelines

---
base-commit: 1b4e9a5f8b5f048972c21fe8acafe0404096f694
change-id: 20250103-b4-pks-ci-fixes-2d0a23fb5c78

