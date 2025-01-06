Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348E11DC993
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162220; cv=none; b=Op98CN3SAdnJDCbdra8azrLx5VY4FIPkC6iB3gXvi70enhTnhnHh1KCkNPi/Ecynmw6ZQqmmNUqJlUeP2/dXitlviMulhDr0tvraU82ZGJ17yWLse1yNe9MdbFEV1x39tgrDV4YrlDzpYkHtkk6TLvYX/EPqMAYyOtRADveiEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162220; c=relaxed/simple;
	bh=LFDsTFlAE1xUpLIHmrQfo7pKcRCmewHy6e3praZpHYY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=cw5BwRb42KGxRTUPcQya+Q7caU3ZibqalxCSOtTmcHuVG7FzkPng+nRBYxQcfyxwM1CygAYVvY8J4CAT8O3PsnoRbuDbf/tUJoIe5lNdzuXhN2DK56mIZY7ae26e6DRBlIZDf1SZXvuuODyl2gt8Ry3bluy7vCbU3qYYhNNXApw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C2q7qtJr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zfs+2H4a; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C2q7qtJr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zfs+2H4a"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D630613808FC;
	Mon,  6 Jan 2025 06:16:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jan 2025 06:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736162213;
	 x=1736248613; bh=ANITk7/Q78Qlo7/E9bQk8Loxi18zLukqa+52h3jvKVQ=; b=
	C2q7qtJrYbKE0/LyS4NTIHL1dvLLurmQXvZ83gId01GZW8Xr9651BsZOhmfJLM9G
	qeo0N/hVgKXDDDPhLOvNAeD9Oz2R+/9xZZPVjqgdoLWl3nUyVyTX8tR3C8AFvbsu
	mUdstm1FJD6iAQnItMUkO0RYE8psGw89ACpPKGhdnc99XZtvOig541xohSxUH3rd
	hB8q+iZpqX2iyaa2ZqQBJmCXQnH/UPB966dqms5HFUAcV3oXhXQxtfegVW/WYR3V
	6fSn//ivMz/xdOT5r94FzwGK4Ka/17CK7dGnNKKZGidMJlE38CokbJzKdowmhtzq
	JUxqHyswyjmPFynUpIzL5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736162213; x=
	1736248613; bh=ANITk7/Q78Qlo7/E9bQk8Loxi18zLukqa+52h3jvKVQ=; b=Z
	fs+2H4abtDOEeH3Q2cO3bR9gIeHdKSMP5Oli3GE8Sy+NRMMri2KlXQPaCm+sETlC
	bsyFpIxhug2IF+uA0tLISPykmvHAVsJbFqpYztPeVHEWaa2+hMwlBuYmiKBP7vKT
	NQyzv+KZ4QYTpaMheFlIZnr89Axhd/NCxMfRZrt90ZXKIVaPBe5jvMd0cCoGlzIr
	turUVvkffG2R2bK9DhmptT/hn3WBj0wKOmh9gnaCvqlRYtEaSRQbJUoAR9ETeIIH
	2f+AknwQN6KLj1laIPMJ6DaNiAY3FOdLsj8dmKjFRJqeqv9yZH0s49xrEOsvVeyR
	B6yKgOX5dvs1vs4ARp9xQ==
X-ME-Sender: <xms:pbt7Z4dUW4vRk0VLHp5oQ9vTlyicU3iQ_MqCvl-RRjlbzhOhbAHpTw>
    <xme:pbt7Z6NjPqpUy40KhvjLNQ21G9k8vy-qhAJA0dNCXIPHqWa9B2fd3Kp5h_hlMTJX0
    3342AxnbctAYmR9yw>
X-ME-Received: <xmr:pbt7Z5g2ubVX5hkKG4PGsCVzAj7ez53-R96VjJIoZrKpOwWNs_r2eZ7s9KHjJdXh_Z5aLeFQi6EH2Zltzbvd9G73f4EAKohRuCwnyqgBh5CNEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveejfeehge
    egleejudffteevhefgieeuhefggfduffffffegieefteevjeeluedvnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghdpghhithhlrggsrdgtohhmpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pbt7Z9867C9nu4HBpHO26G-1S5Fb_SbLKu-TgDpBXEIc3yBKnBdKXA>
    <xmx:pbt7Z0svUYjjDzSAUUmfc-3r6R1hXErfMc0ok4614QePMcJ_YbDf-A>
    <xmx:pbt7Z0EhGR_h6OOQ7YWbf7vFEXbchDeW3H-YrtJRmPT8ZvQlIr8cUg>
    <xmx:pbt7ZzMgHUpVgLjbbZ1UgDeLKLVYepMtc6qhljvSsOOWIRZQERTuKQ>
    <xmx:pbt7ZwIO8rDWn3R08wkYu19ukuemdCVhU_xNxo1TvIcqv1GT8nyA2Fhm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 06:16:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ecd05182 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 11:16:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/10] A couple of CI improvements
Date: Mon, 06 Jan 2025 12:16:49 +0100
Message-Id: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKG7e2cC/3WNOw7CMBBErxJtzSJ/sEiouAdK4S9ZIZLIiyxQ5
 Ltj0lO+Gb2ZDThmigyXboMcCzEtcwN16MBPdr5HpNAYlFBGSKHRnXB9MHrCRO/IqIKwSidn/Lm
 HZq057kWTbmPjifi15M9+UOQv/b9VJAq0g3ODCSn1Wl9bfaQnjLXWL+r3XFyrAAAA
X-Change-ID: 20250103-b4-pks-ci-fixes-2d0a23fb5c78
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
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
 t/t7422-submodule-output.sh | 10 ++++--
 7 files changed, 69 insertions(+), 93 deletions(-)

Range-diff versus v1:

 1:  8ef1870c39 =  1:  14a80c2683 t0060: fix EBUSY in MinGW when setting up runtime prefix
 2:  f0647aad30 <  -:  ---------- t7422: fix flaky test caused by buffered stdout
 -:  ---------- >  2:  967e76f482 t7422: fix flaky test caused by buffered stdout
 3:  2768ecb60c =  3:  bd2bae13e4 github: adapt containerized jobs to be rootless
 4:  3a8aafdc32 !  4:  bc0bf7b8d5 github: convert all Linux jobs to be containerized
    @@ Commit message
         The latter is more flexible because it allows us to freely pick whatever
         container image we want to use for a specific job, while the former only
         allows us to pick from a handful of different distros. The containerized
    -    jobs shouldn't cause a significant slowdown, either, so they do not have
    -    any significant upside to the best of my knowlegde. The only upside that
    -    they did have before the preceding commit is that they run as a non-root
    -    user, but that has been addressed now.
    +    jobs do not have any significant downsides to the best of my knowledge:
     
    -    Convert all Linux jobs to be containerized for additional flexibility.
    +      - They aren't significantly slower to start up. A quick comparison by
    +        Peff shows that the difference is mostly lost in the noise:
    +
    +                job             |  old | new
    +            --------------------|------|------
    +            linux-TEST-vars      11m30s 10m54s
    +            linux-asan-ubsan     30m26s 31m14s
    +            linux-gcc             9m47s 10m6s
    +            linux-gcc-default     9m47s  9m41s
    +            linux-leaks          25m50s 25m21s
    +            linux-meson          10m36s 10m41s
    +            linux-reftable       10m25s 10m23s
    +            linux-reftable-leaks 27m18s 27m28s
    +            linux-sha256          9m54s 10m31s
    +
    +        Some jobs are a bit faster, some are a bit slower, but there does
    +        not seem to be any significant change.
    +
    +      - Containerized jobs run as root, which keeps a couple of tests from
    +        running. This has been addressed in the preceding commit though,
    +        where we now use setpriv(1) to run tests as a separate user.
    +
    +      - GitHub injects a Node binary into containerized jobs, which is
    +        dynamically linked. This has led to some issues in the past [1], but
    +        only for our 32 bit jobs. The issues have since been resolved.
    +
    +    Overall there seem to be no downsides, but the upside is that we have
    +    more control over the exact image that these jobs use. Convert the Linux
    +    jobs accordingly.
    +
    +    [1]: https://lore.kernel.org/git/20240912094841.GD589828@coredump.intra.peff.net/
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 5:  a50ee3dd9a !  5:  22bd775ad0 github: simplify computation of the job's distro
    @@ Commit message
     
         There are a couple of exceptions:
     
    -      - The "linux32" job, w whose distro name is different than the image
    +      - The "linux32" job, whose distro name is different than the image
             name. This is handled by adapting all sites to use the new name.
     
           - The "alpine" and "fedora" jobs, neither of which specify a tag for
 6:  b31305597e =  6:  ddce6be0b6 gitlab-ci: remove the "linux-old" job
 7:  dfa41f5593 =  7:  40a0c1e22a gitlab-ci: add linux32 job testing against i386
 8:  bd1efb0373 =  8:  d775afb9c3 ci: stop special-casing for Ubuntu 16.04
 9:  fa505756a7 =  9:  0dd988643f ci: use latest Ubuntu release
10:  c64af8aa78 = 10:  bdca84eebd ci: remove stale code for Azure Pipelines

---
base-commit: 1b4e9a5f8b5f048972c21fe8acafe0404096f694
change-id: 20250103-b4-pks-ci-fixes-2d0a23fb5c78

