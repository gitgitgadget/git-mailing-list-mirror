Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3AF442F
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736149902; cv=none; b=fPdQidY2aCELI0qipgTa+m3TbMAV1u46r7zNiXtBoJxWzPWSGfkvIavSLA9ZFkEQILqrF7LSkzprqjIKcqSzIdopeKHvHKBrmRPSeyJ11zbxbyxRymmw/PDCSaBluOqqIcfBDfFFVGmXq/iVXBVThZWLi1FqDmCB2dSth5zDsa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736149902; c=relaxed/simple;
	bh=aONyf1Bt7ShEIuZE3ZDzuoTjuYrueSjdclbzWgPZOtU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=JFqNUGlG50S3a3W6xtAY82lO7akTwfT/3rLccMcC1DJ5N52vV+ohYIL6eJw+OBvMyGZqqGrH4lUjbr/sK7fEJynkGOKO5jqJhCQMrB9+SUR5LNNYsxcZbhOziJzldsH6ayhan65IrsSdoejYlaxA82IjmCNTAnj9oWUDCtzRbYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hKy07Khu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wHNdQNdF; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hKy07Khu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wHNdQNdF"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4994211405C6;
	Mon,  6 Jan 2025 02:51:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 06 Jan 2025 02:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736149899;
	 x=1736236299; bh=aL8+ktfOXJj3RfMysek0rnmYvjO+Qrv7Rgl5ZYEgdiQ=; b=
	hKy07KhuJRrs30BJaaTQwhoOfeBxOwGYDf0hn/KzadmVvDIS+Ua5pnju+LGAkfbV
	QE9RBEcj6I+uOBMfzh0Dm/rY45/5tzwCBsKNQjXDpBOgk0+E2xJsgIibabQXsYx8
	kXXIUE2pxVnMQBMydRYcxg5IQeO8Xsi29zxtt3Sjavs1A1LisuRS18xBlebX0Xex
	SZ1ADoIcr/dvc6fSSg3udVAj9jt0QugCaGsZz5IMCKgdWShLNNlyBso2EhoeFwE1
	NVSgWmeMz/rFob+zSmsLVPOW2K1Tj1c2y1Czv75PBak+cHp1MerfvI6m/SGBQljv
	lpHM1aWcLkJJs02FD6gF5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736149899; x=
	1736236299; bh=aL8+ktfOXJj3RfMysek0rnmYvjO+Qrv7Rgl5ZYEgdiQ=; b=w
	HNdQNdFW2LKciP4MbNad9+QWHIkABWy4/octkk5Q009o8NLW+7IxvOZYilqHxw8r
	/ag4FUlDcisfAOvnLrSjtYP3UMH1THCoWIMzuq7k+1L8J7IFM35lzjkeE8AnNRRH
	ejU+mQ2oL/355RlllIAHFnbz0owm+jd/lR2/sAk28Wy33IVJ3A06G1DVTzgJPyMC
	fze2+0w15kTpLtNrvocZPlizwmKZxDep5g+1bGN8iTqtVDbS3or027JuQocwfBqK
	g+5HzDkezVgt5/9p6UbBV6P0epHIDfsxT6vdOS47rLnoCbdxraU77MgtlSeHjJ71
	FRBGqzQAaICCIappDx+DA==
X-ME-Sender: <xms:i4t7Z0UQM3gof1QFNzAbbwNMV1uv3KDfMAAKHs9JjAJiWMDUjOBcsA>
    <xme:i4t7Z4kH7ivVEZjSZlc0jfcuPGGAQT2tlfqhNom03RNCP-jvgOUq3wSOmrbxgGw4V
    zIdHt6KaWhmSo7S-g>
X-ME-Received: <xmr:i4t7Z4ajykbOox9owFc6cDmfebSEB3QglUX6JGKxmUAjW66u5Ms8wJBw7OCbRRpc-zpg7A49Ezly1ceHk3Z8gqSdUx8y6AKmhy9aCSssUiqt5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefledguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepteeuueehhffhiedtueehtddtieekfedtudehtdeh
    fefhgeffveeggedthfehuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgs
    lhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:i4t7ZzVwnWs0yIiqzswzVyeBb5A0GBII9hTpQvaMT2O-g3SVi3so5w>
    <xmx:i4t7Z-ko-Of8yYrw5646YkY4-XhzMOy9dcBioLj6PpZNeqy5uqUuaA>
    <xmx:i4t7Z4ddHf8CI7MKMCdNofnlmjfFWCMwj4NyhHBKEs7g2vaFAt6G9A>
    <xmx:i4t7ZwGumb4c0Th9S-LsMgTj395-yBedSIeSJZvXRe4tmEQJyRSLSw>
    <xmx:i4t7ZzwK3mXvayCA-efGpoJIl-3ywF1ZWfnD5dD7qT77p00zWS5OAg6h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 02:51:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9058ce9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 07:51:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] remote: announce removal of "branches/" and
 "remotes/"
Date: Mon, 06 Jan 2025 08:51:32 +0100
Message-Id: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAISLe2cC/4WOyw6CMBBFf4XM2jGdFkRY+R+GRYVRGsPDaSUaw
 r9b0cSly3Mn956ZwbM49lAmMwhPzruhj6A3CdSt7S+MrokMWumUtMpwvHoU7obAeBLb1y17bHg
 Urm2IXVQmt6nZF9bkOcSVeDm7x2o4Vh8Wvt2jKPzC1vkwyHP9YqJ3+hUS/RVOhAopNcTa7Aoy2
 SE2tq6DalmWF8OQMIDgAAAA
X-Change-ID: 20241205-pks-remote-branches-deprecation-037a4389a377
In-Reply-To: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
References: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

Hi,

back when Git was in its infancy, remotes were configured via separate
files in "branches/" (back in 2005). This mechanism was replaced later
that year with the "remotes/" directory. These mechanism have evenutally
been replaced by config-based remotes, and it is very unlikely that
anybody still uses these directories to configure their remotes. Both of
these directories have been marked as deprecated, one in 2005 and the
other one in 2011.

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
 remote.c                               |  6 +++++
 remote.h                               |  2 ++
 t/t5323-pack-redundant.sh              |  6 +++++
 t/t5505-remote.sh                      |  6 ++---
 t/t5510-fetch.sh                       | 13 ++++------
 t/t5515-fetch-merge-logic.sh           | 47 ++++++++++++++++++----------------
 t/t5516-fetch-push.sh                  | 14 +++++-----
 t/test-lib.sh                          |  4 +++
 21 files changed, 112 insertions(+), 59 deletions(-)

Range-diff versus v1:

1:  51bc2fc09e ! 1:  c15229fb98 Makefile: wire up build option for deprecated features
    @@ Commit message
         breaking changes in the Git project. In 2454970930 (BreakingChanges:
         early adopter option, 2024-10-11) we have amended the document a bit to
         mention that any introduced breaking changes must be accompanied by
    -    logic that allows us to easily enable the breaking change at runtime.
    +    logic that allows us to enable the breaking change at compile-time.
         While we already have two breaking changes lined up, neither of them has
         such a switch because they predate those instructions.
     
2:  71dc627473 = 2:  0131ac856f ci: merge linux-gcc-default into linux-gcc
3:  8134955d0b = 3:  38a71377c0 ci: repurpose "linux-gcc" job for deprecations
4:  aa986122ea = 4:  a8d18e3499 builtin/pack-redundant: remove subcommand with breaking changes
5:  b528488559 ! 5:  7445f06776 remote: announce removal of "branches/" and "remotes/"
    @@ Commit message
     
         Back when Git was in its infancy, remotes were configured via separate
         files in "branches/" (back in 2005). This mechanism was replaced later
    -    that year with the "remotes/" directory. These mechanism have evenutally
    +    that year with the "remotes/" directory. These mechanism have eventually
         been replaced by config-based remotes, and it is very unlikely that
         anybody still uses these directories to configure their remotes.
     
    @@ Documentation/BreakingChanges.txt: Cf. <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.c
     ++
     +As our documentation mentions, these directories are not to be found in modern
     +repositories at all and most users aren't even aware of these mechanisms. They
    -+have been deprecated for almost 20 years and 14 years respectively, and I am
    ++have been deprecated for almost 20 years and 14 years respectively, and we are
     +not aware of any reason why anybody would want to use these mechanisms.
    -+Furthermore, the ".git/branches/" directory is noadays misleadingly named and
    ++Furthermore, the ".git/branches/" directory is nowadays misleadingly named and
     +may cause confusion as "branches" are almost exclusively used in the context of
     +references.
     ++

---
base-commit: 713ec79a9091cec60b110d605b418904759982ab
change-id: 20241205-pks-remote-branches-deprecation-037a4389a377

