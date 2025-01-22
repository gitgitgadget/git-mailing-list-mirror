Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE3B5A79B
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547553; cv=none; b=MCMF7MM8UiGFxt8ULNERuwqSkFolqOii/LtVgJr0oi1Jv3f+WvIOSV/O6Wf1YwipYDEB5gOCyuJnEVTk1IFDwZWBnUESwM/zcsIzK63uzTselpw0yqYXsPGahM2KWH6zQGJhTuEvQtA5uijRrrsPtj1vonZVEwYQD34xzh22LeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547553; c=relaxed/simple;
	bh=qpPhUv4FRK8XhgeyqiMFgCaoxxrUUr83dRDagQ/uZl8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=CStfStuq6BwkuciR7eX7onVisOa0fiNoPCz41ILF6lY43UulI2kONTyuyHuStObukfw8oCm4Q81z+l2TmWCYLR3j2WVAQpm7F9uDKHP1YlfIqJSoganzlUb7GwnPc7RII3eZ2x3BkqokOGR6QkBBQJz1XObMWfhl3WHrWio+uJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l41Pw+38; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sUbsprga; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l41Pw+38";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sUbsprga"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 381F2138083C;
	Wed, 22 Jan 2025 07:05:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 22 Jan 2025 07:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737547550;
	 x=1737633950; bh=O4VVGfpbtqsNHSlOafMb8F4e1dbUwavvwMYgTU87TLQ=; b=
	l41Pw+38JtGGw/vL9D4ChwsYpbj62m02RglzSj8LEFm3dzQZR868kw1rheaRWW4l
	4acXVa1zlcq/mOHCMPcl5+rl0yW+OI+AMlx6fbZJw+EqyqVbD53leMVijdG8NhWl
	tBqng9e9Uy19iKpX74bBz8UB6l0saVDN+OTPIOB+tBy81tsFnAeI8BSaDWommaqj
	XrRagdvoR3tvfAAY3Q+1MuJvXjsvScT3qGIgWCG47AKNEETwHwr9jf/BDu6IaxEi
	SI27Cyy9PEnNkamiCD30azWHa9l4YrV9b2ItV4sfQBbd8vUBz7atICa/d7dVMOZ4
	GEZp/Kw/9h9isMz3QNwcHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737547550; x=
	1737633950; bh=O4VVGfpbtqsNHSlOafMb8F4e1dbUwavvwMYgTU87TLQ=; b=s
	UbsprgaD354E9dCXH+Zi/g7uL6SBdmyMEmc86ayhjE8myys0e8UeZ0BdEyc9A7Fo
	AaB+CGj/SbOwWcMxNLnpQdXs3vQW9rAHnrFlveDUiezAlpSY+7OHTHc9VF05xSXY
	Sps2aAAYCQhaagyirwNXaBuzyBCjSxRgwNXbOSgG8lMRVEWn8OiHV0OXdCmeK7+c
	wLiE7QMltrUyouE98D9+iy0BdSI9UQoMptM0uFAWVbvWvrM0I0v/tetIZ09U4pSH
	zpljJjbLt/NY3JGxh2quBHEcKctDs64o9o0nR88BA0XKEuv/DinzZWTtQo8U5bRu
	jp5aKdMD5271/OY72itvA==
X-ME-Sender: <xms:Ht-QZz8zy8oAxDUO2jwuI4-t4E849Vc6WXvqBUO4jbjImIOU8O8ROQ>
    <xme:Ht-QZ_uHmRA9teeMVA51lPmk7Occ130ijimREVfYnZWCJdZLiMhSAZeVrt-xofpDr
    mQ_rSZqZ4NPiWDfDA>
X-ME-Received: <xmr:Ht-QZxDATv5gUsQkWFyNuDvWxdp3EwhJSE1sttCe9ILPMmaPwaA-aPtM-bKbi-E8rx6ROHOFH-7-k8CksuipyZVFLWU3lf4LcIgElV7w21DQppg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveejfeehgeegleejudffteevhefgieeuhefggfdu
    ffffffegieefteevjeeluedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhith
    hlrggsrdgtohhmpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhope
    eipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhr
    ugesghhmrghilhdrtghomhdprhgtphhtthhopegvvhgrnhdrmhgrrhhtihhnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:Ht-QZ_eSuTvmocHGRN3qeQ5TdBwae2MpH9lNg1StQNvV-W6wWDtSMw>
    <xmx:Ht-QZ4NBBRJdiKa0B-vVqiPqitOK6dYyCjdiHsmAHLQ5WEbgpM0NWg>
    <xmx:Ht-QZxkzw-TRS1z_wRHNvzxY9tXNTUGfwI-ojUk0OzDfXaeEMzoOoQ>
    <xmx:Ht-QZyvJrgJActtaY-XBorluk5_n7VyoacDt836563cY9dG4kQPX4Q>
    <xmx:Ht-QZ0Dm95e6ta2ltAbGdw6jvxxaPp_cOBd_1z3eB35MVGOqWBAK5hnT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 07:05:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1d7c2e6b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 12:05:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/11] meson: a couple of additions
Date: Wed, 22 Jan 2025 13:05:43 +0100
Message-Id: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABjfkGcC/3XNywrCMBAF0F8pWTuSR5MYV/6HuGjzsIPYlqQEp
 fTfTYuImy7vZe6ZmSQf0SdyrmYSfcaEQ1+COFTEdk1/94CuZMIpl5RRDW0N4yPB06ehh8Y5nMo
 iAZXSMtUKKnlLyniMPuBrg6+3kjtM0xDf25/M1vZLMrFHZgYUjA6qMSIow9ylXB3xSVYv83+j3
 jV4MU5Oe6u0ssGZn7EsywdXHjOa/QAAAA==
X-Change-ID: 20250107-b4-pks-meson-additions-055c16b3052b
In-Reply-To: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series backfills in a couple of missing features into
Meson. It also improves test coverage of our Meson-based CI jobs so that
we compile with Meson with Visual Studio and compile fuzzers. CI runs
for GitLab and GitHub can be found at [1] and [2], respectively.

The series is built on top of fbe8d3079d (Git 2.48, 2025-01-10) with
ps/meson-weak-sha1-build at 6a0ee54f9a (meson: provide a summary of
configured backends, 2024-12-30) merged into it.

Changes in v2:
  - Consistently use `meson.has_header_symbol()` to fix warnings for
    features not yet available in Meson 0.61, which is our minimum
    required version.
  - Add another patch that makes use use `--fatal-meson-warnings` so
    that such warnings will cause the build to fail.
  - Fix a bug that made GIT-VERSION-GEN always return tags as version.
  - Adapt the approach we use to populate the project and distribution
    tarball versions.
  - Link to v1: https://lore.kernel.org/r/20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im

Changes in v3:
  - Fix a commit message typo.
  - Revamp how the distribution tarball is created so that we don't have
    to adapt `GIT-VERSION-GEN` for it.
  - Link to v2: https://lore.kernel.org/r/20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/280
[2]: https://github.com/git/git/pull/1870

---
Patrick Steinhardt (11):
      GIT-VERSION-GEN: simplify computing the dirty marker
      GIT-VERSION-GEN: allow running without input and output files
      meson: populate project version via GIT-VERSION-GEN
      meson: fix dependencies for generated headers
      meson: wire up development environments
      meson: wire up generation of distribution archive
      meson: wire up fuzzers
      meson: make the CSPRNG backend configurable
      meson: fix compilation with Visual Studio
      ci: raise error when Meson generates warnings
      ci: wire up Visual Studio build with Meson

 .github/workflows/main.yml | 52 +++++++++++++++++++++++++++
 .gitlab-ci.yml             | 38 ++++++++++++++++++++
 GIT-VERSION-GEN            | 50 +++++++++++++++-----------
 ci/run-build-and-tests.sh  |  4 ++-
 meson.build                | 88 +++++++++++++++++++++++++++++++++++++---------
 meson_options.txt          |  4 +++
 oss-fuzz/meson.build       | 20 +++++++++++
 7 files changed, 218 insertions(+), 38 deletions(-)

Range-diff versus v2:

 1:  55d804eaaf =  1:  60298f9c26 GIT-VERSION-GEN: simplify computing the dirty marker
 2:  617527f489 =  2:  91d302da94 GIT-VERSION-GEN: allow running without input and output files
 3:  d1566ba566 !  3:  806c05dfb1 meson: populate project version via GIT-VERSION-GEN
    @@ Commit message
         meson: populate project version via GIT-VERSION-GEN
     
         The Git version for Meson is currently wired up manually. It can thus
    -    grow (and alread has grown) stale quite easily, as having multiple
    +    grow (and already has grown) stale quite easily, as having multiple
         sources of truth is never a good idea. This issue is mostly of cosmetic
         nature as we don't use the project version anywhere, and instead use the
         GIT-VERSION-GEN script to propagate the correct version into our build.
 4:  bf3063ff51 =  4:  dd3abd3dca meson: fix dependencies for generated headers
 5:  5ba393fa8e =  5:  cb78c1d7d3 meson: wire up development environments
 6:  f4e076bed7 <  -:  ---------- meson: wire up generation of distribution archive
 -:  ---------- >  6:  715da14a23 meson: wire up generation of distribution archive
 7:  4e30bf0bb6 =  7:  9c5b82dd45 meson: wire up fuzzers
 8:  af5ec69b3a =  8:  393ea8a671 meson: make the CSPRNG backend configurable
 9:  82ff90ff8b =  9:  6d1a2b1978 meson: fix compilation with Visual Studio
10:  f9d2f1b9f6 = 10:  3142fdab0b ci: raise error when Meson generates warnings
11:  c9d480ddc6 = 11:  6c339cd012 ci: wire up Visual Studio build with Meson

---
base-commit: 35a417ddf0eab983e4d5eb69e628aa198114bb05
change-id: 20250107-b4-pks-meson-additions-055c16b3052b

