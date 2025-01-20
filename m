Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22118FC84
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737358989; cv=none; b=FG/3FyNu1ZuWPwboUKRDmoSKLaJHvu9ZjXuaNk6R17al3TIBV9tyblrTia4j6OzjO+zd5AP3dH1xFbZDmeEkw+WixzJzAROEkCvcymr0FSrdY98wZBWiox2k3jdp2cmzgCwXIb8jNzV8dQ1ezDt60AMIuejDuFSe1Dr2ldY3vJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737358989; c=relaxed/simple;
	bh=cgvp4QKZW0tLYpQ+J7EeA9vFEQdVxZIpi7yQm6dNc6I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=TofxCzkCY3TUT4gM6QZQOqRYyQ1oQ7cO2Jspt8Wq4nIKtAuKZEMbqOBEncrP6+zoYEIAicLlbvguLi0WNyLvB8/ZqiV8Pw9k9gPlXskh+81vz9cuY2U94GUPuBg3A8bSsgkFzPqQk/orRPXCDNZV2oh3U8iZ42ru7Ud9bwpA0FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vBpGEKRg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PCJKBTZg; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vBpGEKRg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PCJKBTZg"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F1F87254010D;
	Mon, 20 Jan 2025 02:43:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 20 Jan 2025 02:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737358984;
	 x=1737445384; bh=3TGrDibhbcazyDWNU4J3NiDHOBvPeZTWpTMTxdOpokI=; b=
	vBpGEKRgb6JtZXA+eY0ZkGrE2Twvzi8PO71VGudMzRchF98TTpqKk24tNoRBkaBA
	VR2+BqPVqNI1gHXS7thSFzqp308R67LMFUR7O04p/ZnbRsBExgydiw5Xfv3N+rya
	YoTBMoH58IPE+LNuVVlfaPkq5HdnJhluA0jV36ubpQb1v9jUFQJp/xS3ad0guJkU
	kVAyETHyM3qYEFUAZBnIwCY4nUBxw36ll4GmWzL4am/P13nRr9JB7Achces/E/cz
	XnyTEcWRJpPLSD815BTIR8TRUNT9GvSxK+2s0JdFwFeasGJ2s9kNq604QT0q0bdQ
	zDoN++xT5rH/rPijDoNUKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737358984; x=
	1737445384; bh=3TGrDibhbcazyDWNU4J3NiDHOBvPeZTWpTMTxdOpokI=; b=P
	CJKBTZg/MzbIbtsXPTkjlD9Dp3Ekm8/AMHO68ogWvx0orHfVpe9GZEJ2FquDdeDC
	UmH7HOdO5ONUQO6thW5z7KnOQIxzX3XKrMQiB8kJTIsdksjQa3z7dHblRWZ4ho5Y
	RSPuJfN/Dd0JprIvazhzUCa2wFhAe9phKHWBfBqMND9k3RrIeewu8O7d7mffPUmP
	xdT5vowq6o8tLMcF+IYTxAFyvqXngd5R9iQsAf9uUiA3j5mfvyMWBm4GMc0qQ5JZ
	ycFPfIZHqT7Wt9TvkixCez+GOvb/I+wfUZEyF6HfUhtrc3crafhl5iYzMcUrkDVH
	AF1bKeZvv5Ud1VdUNOgfQ==
X-ME-Sender: <xms:iP6NZx3DwYL4X4j7jbnbXO-4Lp6l6LbqRNJHo_RpA9_so2NmpqM7NQ>
    <xme:iP6NZ4E9fg6oQaKFq67jgoyRePREzoQ1awSdeCOAgKpNLrhLKY3u3-WIQke0ybZiU
    Ay--x_f18gZbrA-rA>
X-ME-Received: <xmr:iP6NZx5uTh8c-rUFD_CQuytP_BErgF9fdmj_odazWlFeRljE-JAYWemWbmNMp3f0rD02uCyUvHs_HOMzyXTJ9eAZ65ESyKSUpqCdylQzRPpiuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeikedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepteeuueehhffhiedtueehtddtieekfedtudehtdeh
    fefhgeffveeggedthfehuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hrohgsvghrthdrtghouhhpsehkohhorhguihhnrghtvghsrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghnuggrlhhlrd
    gsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtg
    homhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:iP6NZ-1C35eXHBLiOucFKex2zYvDNsjP2iWm7Ph9IxgBGjzGxhgs8Q>
    <xmx:iP6NZ0Ex8LTea_VyXhx7L2pjVTPijnTi7i4DcruqNa0EPHLXD-eUsQ>
    <xmx:iP6NZ__6Vx2Zkie5A2eldAuWYLhWDlaMAjn54KmftfATcMM730gxSA>
    <xmx:iP6NZxmKqIGjzycRZ_LZyqKhVI6u7rcPQnTwZ0MVPbMSTbSkRX0A2Q>
    <xmx:iP6NZ54pSqvBYPSWDuXomRLLKQ0_mz6IsBUuy960HeUvHeaIzgzqLw7R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 02:43:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b2d97f63 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 07:43:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/5] remote: announce removal of "branches/" and
 "remotes/"
Date: Mon, 20 Jan 2025 08:42:57 +0100
Message-Id: <20250120-pks-remote-branches-deprecation-v3-0-c7e539b6a84f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIH+jWcC/4WOyw6CMBBFf4V0bU2nQ3m48j+Mi1pGaQwP20o0h
 H+34GvJ8t7JPWdG5slZ8myXjMzRYL3t2hhwkzBT6/ZC3FYxMylkClIo3l89d9R0gfjJ6dbU5Hl
 FvSOjQ9xygblOsSg15jmLlHg528diOBzf2dHtHkXhX9bWh849ly8GmNuPEGBVOAAXHFIEkpiVg
 GofF1vbsBk8yC9MCRDZOkxGmDRU5EYoVJj9YNM0vQBa7+hdLQEAAA==
X-Change-ID: 20241205-pks-remote-branches-deprecation-037a4389a377
In-Reply-To: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
References: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Robert Coup <robert.coup@koordinates.com>, 
 Christian Couder <chriscool@tuxfamily.org>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

Hi,

back when Git was in its infancy, remotes were configured via separate
files in "branches/" (back in 2005). Later that year we introduced a
more powerful mechanism with the "remotes/" directory. These mechanism
have eventually been superseded by config-based remotes, and it is very
unlikely that anybody still uses these directories to configure their
remotes. Both of these directories have been marked as deprecated, one
in 2005 and the other one in 2011.

This patch series follows through with the deprecation of these and
announces them for removal in Git 3.0. Furthermore, it creates the infra
to compile Git with such breaking changes enabled and wires up a CI job
both for GitHub and GitLab to test those breaking changes.

The series is based on top caacdb5dfd (The fifteenth batch, 2024-12-10)
with ps/build at 904339edbd (Introduce support for the Meson build
system, 2024-12-06) merged into it.

Changes in v2:
- Some small fixes to the deprecation notice of "branches/" and
  "remotes/".
- Some small fixes to commit messages.
- Link to v1: https://lore.kernel.org/r/20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im

Changes in v3:
- Print warnings when reading remotes from "remotes/" or "branches/".
- A couple of commit mesasge improvements.
- Link to v2: https://lore.kernel.org/r/20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (5):
      Makefile: wire up build option for deprecated features
      ci: merge linux-gcc-default into linux-gcc
      ci: repurpose "linux-gcc" job for deprecations
      builtin/pack-redundant: remove subcommand with breaking changes
      remote: announce removal of "branches/" and "remotes/"

 .github/workflows/main.yml             |  6 +----
 .gitlab-ci.yml                         |  6 +----
 Documentation/BreakingChanges.txt      | 25 ++++++++++++++++++
 Documentation/gitrepository-layout.txt |  7 +++--
 GIT-BUILD-OPTIONS.in                   |  1 +
 Makefile                               |  7 +++++
 builtin/remote.c                       |  2 ++
 ci/lib.sh                              |  5 ----
 ci/run-build-and-tests.sh              |  3 ++-
 contrib/buildsystems/CMakeLists.txt    |  1 +
 git.c                                  |  2 ++
 meson.build                            |  6 +++++
 meson_options.txt                      |  2 ++
 remote.c                               | 19 ++++++++++++++
 remote.h                               |  2 ++
 t/t5323-pack-redundant.sh              |  6 +++++
 t/t5505-remote.sh                      |  6 ++---
 t/t5510-fetch.sh                       | 13 ++++------
 t/t5515-fetch-merge-logic.sh           | 47 ++++++++++++++++++----------------
 t/t5516-fetch-push.sh                  | 14 +++++-----
 t/test-lib.sh                          |  4 +++
 21 files changed, 125 insertions(+), 59 deletions(-)

Range-diff versus v2:

1:  bc6d8bcb19 ! 1:  3ceab66906 Makefile: wire up build option for deprecated features
    @@ Commit message
         such a switch because they predate those instructions.
     
         Introduce the proposed `WITH_BREAKING_CHANGES` preprocessor macro and
    -    wire it up with both our Makefiles and Meson.
    +    wire it up with both our Makefiles and Meson. This does not yet wire up
    +    the build flag for existing deprecations.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
2:  015a70e998 ! 2:  408f3afa48 ci: merge linux-gcc-default into linux-gcc
    @@ Commit message
             have other testcases that don't and also some that explicitly use
             "master".
     
    -    So overall, the job does not add much to our test coverage. Merge it
    -    into our "linux-gcc" job to reduce our test matrix a bit.
    +      - We use "ubuntu:20.04" in one job and "ubuntu:latest" in another. We
    +        already have a couple other jobs testing these respectively.
    +
    +    So overall, the job does not add much to our test coverage.
    +
    +    Drop the "linux-gcc-default" job and adapt "linux-gcc" to start using
    +    the default GCC compiler, effectively merging those two jobs into one.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
3:  f776eb0e4e = 3:  545df94c7d ci: repurpose "linux-gcc" job for deprecations
4:  c40f85dde2 = 4:  0142480800 builtin/pack-redundant: remove subcommand with breaking changes
5:  78bda8dd6b ! 5:  a67bde4eda remote: announce removal of "branches/" and "remotes/"
    @@ Commit message
     
         Back when Git was in its infancy, remotes were configured via separate
         files in "branches/" (back in 2005). This mechanism was replaced later
    -    that year with the "remotes/" directory. These mechanism have eventually
    +    that year with the "remotes/" directory. Both mechanisms have eventually
         been replaced by config-based remotes, and it is very unlikely that
         anybody still uses these directories to configure their remotes.
     
    @@ remote.c: static void add_instead_of(struct rewrite *rewrite, const char *instea
      static const char *skip_spaces(const char *s)
      {
      	while (isspace(*s))
    +@@ remote.c: static void read_remotes_file(struct remote_state *remote_state,
    + 
    + 	if (!f)
    + 		return;
    ++
    ++	warning(_("Reading remote from \"remotes/%s\", which is nominated\n"
    ++		  "for removal. If you still use the \"remotes/\" directory\n"
    ++		  "it is recommended to migrate to config-based remotes. If\n"
    ++		  "you cannot, please let us know you still use it by sending\n"
    ++		  "an e-mail to <git@vger.kernel.org>."), remote->name);
    ++
    + 	remote->configured_in_repo = 1;
    + 	remote->origin = REMOTE_REMOTES;
    + 	while (strbuf_getline(&buf, f) != EOF) {
    +@@ remote.c: static void read_branches_file(struct remote_state *remote_state,
    + 	if (!f)
    + 		return;
    + 
    ++	warning(_("Reading remote from \"branches/%s\", which is nominated\n"
    ++		  "for removal. If you still use the \"branches/\" directory\n"
    ++		  "it is recommended to migrate to config-based remotes. If\n"
    ++		  "you cannot, please let us know you still use it by sending\n"
    ++		  "an e-mail to <git@vger.kernel.org>."), remote->name);
    ++
    + 	strbuf_getline_lf(&buf, f);
    + 	fclose(f);
    + 	strbuf_trim(&buf);
     @@ remote.c: static void read_branches_file(struct remote_state *remote_state,
      	strbuf_release(&buf);
      	free(to_free);

---
base-commit: 713ec79a9091cec60b110d605b418904759982ab
change-id: 20241205-pks-remote-branches-deprecation-037a4389a377

