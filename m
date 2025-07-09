Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55FED517
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 06:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752042225; cv=none; b=akNeCiGpUbfPG5IwkKJLrHIBdFIlq8dKWCrUuGN+576MCAVEYMyofFifen3wKYfE2xwyAVJHLjm7Aivule0VZEaWNzpSgxHlbHwWKTfOkdPyT5iusqQfKiW+sJmfHoqksQ8e2sxvJg+yvvYWpqPmNZ+ehGXDeZfjg22MIi88N+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752042225; c=relaxed/simple;
	bh=1duZaJQm9HthSfvvk6pUAHDTOxja1DOVqmF71USvDL4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=XvvxE4t7q+N1oSSUKd5dkLEfkOt/GWfs5K1EGSd1yvi5dl3qmYzVeSflfohDywqbfI28iS5UsguCvPJ3KLTzaiqs3c9Sfxb7ZS8fDPFYzLdUUQ6waL6Da30My+i7CC0YeB4uOL+wezrgSEooOLwhYZ2YOvG8pRz9vPd7SfsCPwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o2g1+D4O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W+DcfZBD; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o2g1+D4O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+DcfZBD"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C8531140025A;
	Wed,  9 Jul 2025 02:23:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 09 Jul 2025 02:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752042222;
	 x=1752128622; bh=Rq+OGpf4hJg3Mnps+ByaUpreTmQ7m6ZpjoQ2qLN08Vo=; b=
	o2g1+D4O/C0p0cuNV2XV2pQzX8Z6ieZMWg7hh5WbnCHrBEvgWU/JW9td3XsCBGnk
	luXVqfxaABKX5c+wNCtI+erBj7bklEG1MkXAes7nJKknqbHvxImvoaYcBEdrdKIj
	cUk4Az2Kb2TDEC6sCs1Z1s1alwBdAVChzPAoblCM+Dw9ZpxMJRcC0Pf1QN6XIxFe
	36/7wTU7on8k/GYcxbLExWYhgixJKlMXovulhUyjI9uqn9pE5fuRxSf2OGM3CGCN
	euAEBUXTBoAPKm8xgH4nmKD/vuggv9WRy+U7BCNZ1FWuRO0furuXDaJX61P0yX5r
	MoWLPNDS2lVIB0OjQQqBYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752042222; x=
	1752128622; bh=Rq+OGpf4hJg3Mnps+ByaUpreTmQ7m6ZpjoQ2qLN08Vo=; b=W
	+DcfZBDM0QSmmfxnQXHQFmYb4kOmqjt7d6oq9/RPZTB6VkY0mBd09VLHyxwB+z6k
	PE0rtFysd1GSTb7eIzKOo/tscP/OG59S0dllOTjA8So3y0hZDbWHz1x24OPfsCqR
	UuOkazlxDzQNMkwXj+RFGat25+vyD7vs9yrEmNujFfZLLpB3WTy07Id7vojuQT5n
	gJur8RJGr3VBw5evK6gut5JkuBbmNObnW1tReKSJNDcX2JgVH24O66rRR+nfPri+
	I0kVPa8rCFzLs2LHYJquxpoO0UFLTq7lOGAYkMvxIwVjJMa6IYMHCAhKmtXocY2d
	IWqM+qwtpzR+xctTE94FA==
X-ME-Sender: <xms:7gpuaOugcW1oGjX2exq6y8uPZZG5zryLO4vg7_4GFfcGRaUkIZsxsg>
    <xme:7gpuaNgF5iQXcYvIhfvxUYCPhP0lEr9-db6iBtYI_S-km8Yn1_YfmoipojtwMdABh
    S6SvwAPsjDs6tVzXA>
X-ME-Received: <xmr:7gpuaJroKoZM5wcT-Nep56G8AHDUZOcZIq8LugPCiOpbFHHqNOfGOGvaqmeqwaEu41JUOP0evmhfK21XJLhhTfYqaXmVZToq4F0BKcdQNDGESQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefieekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epleelffevieeiieetteehheeuhffffeekkeevledvueehjeetiefhfeeiheevgedvnecu
    ffhomhgrihhnpehgihhtlhgrsgdrtghomhdpghhithhhuhgsrdgtohhmpdhkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepihhrvggttggr
    rdhkuhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtoheprhgrmh
    hsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehjlhht
    ohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:7gpuaKtgoDXF7ca9V8tfvbtSTgNnRh4UvJTD_KIIrp8o-6Hz-4diAA>
    <xmx:7gpuaMaIU-d5ziqCFMQRBn7oJteFy1fPHIHDCRtnDccEFpOVPB1Xgw>
    <xmx:7gpuaBY-5MqtVxhENzbzBgjZigNlDwizyEa_Bfp0RWAQFftANLwYFw>
    <xmx:7gpuaNnBfOvakm6MLgj4aR5Wi4nr0qy1ao1ywHfCiSs_VimSJB0Jyg>
    <xmx:7gpuaIiTX9tXXi3eMQCuME2gRILDD1IKf9LTeYZtRehYUx1Htb9gICKV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 02:23:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d817471d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 9 Jul 2025 06:23:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/8] A handful of Meson cleanups and improvements
Date: Wed, 09 Jul 2025 08:23:34 +0200
Message-Id: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOcKbmgC/4XNSw7CIBCA4as0rB1DeSi48h7GBaVTS7TQgBJN0
 7tLuzBujMt/MvPNRBJGh4kcqolEzC654EvwTUVsb/wFwbWlCaNM0j3l0AgYrwkGTMGDvaHxjzF
 BJ7mSqt1p0XFSbseInXuu7ulcunfpHuJrfZPrZfpPzDVQYIoKyzRnpsFjWdq6gSxcZt+E+kWwQ
 mhhrOS2FY2WH2Ke5zfKLzYQ+gAAAA==
X-Change-ID: 20250703-b4-pks-meson-cleanups-f53858d694f3
In-Reply-To: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this patch series contains a couple of more-or-less random cleanups and
improvements for Meson that I have accumulated over the last two months.

Changes in v2:
  - Fix an off-by-one error for test slices used in GitHub Workflows.
  - Now tested with both GitLab (https://gitlab.com/gitlab-org/git/-/merge_requests/375)
    and GitHub (https://github.com/git/git/pull/2010).
  - Link to v1: https://lore.kernel.org/r/20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im

Changes in v3:
  - Add a comment explaining why we only need to search for Python on
    the build target.
  - Link to v2: https://lore.kernel.org/r/20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (8):
      meson: stop discovering native version of Python
      meson: stop printing 'https' option twice in our summaries
      meson: improve summary of auto-detected features
      meson: clean up unnecessary variables
      meson: fix lookup of shell on MINGW64
      meson: fix GIT_EXEC_PATH with overridden -Dlibexecdir=
      meson: update subproject wrappers
      ci: use Meson's new `--slice` option

 .github/workflows/main.yml |  2 +-
 .gitlab-ci.yml             |  2 +-
 Documentation/meson.build  |  5 ++---
 meson.build                | 29 +++++++++++++++--------------
 subprojects/expat.wrap     | 18 +++++++++---------
 subprojects/pcre2.wrap     | 18 +++++++++---------
 6 files changed, 37 insertions(+), 37 deletions(-)

Range-diff versus v2:

1:  af222af4b0b ! 1:  5b6ff96df15 meson: stop discovering native version of Python
    @@ meson.build: if host_machine.system() == 'cygwin' or host_machine.system() == 'w
     -python = import('python').find_installation('python3', required: get_option('python'))
     -target_python = find_program('python3', native: false, required: python.found())
     -if python.found()
    ++# Python is not used for our build system, but exclusively for git-p4.
    ++# Consequently we only need to determine whether Python is available for the
    ++# build target.
     +target_python = find_program('python3', native: false, required: get_option('python'))
     +if target_python.found()
        build_options_config.set('NO_PYTHON', '')
2:  e1fe6822400 = 2:  cb5a42b63a0 meson: stop printing 'https' option twice in our summaries
3:  9caa9813f94 = 3:  4b165ffa205 meson: improve summary of auto-detected features
4:  2fbae915050 = 4:  fed79e92b3e meson: clean up unnecessary variables
5:  2a72ec1cf78 = 5:  f7496adc08a meson: fix lookup of shell on MINGW64
6:  c44a8783eac = 6:  e7692a76c89 meson: fix GIT_EXEC_PATH with overridden -Dlibexecdir=
7:  3fb621da6ae = 7:  19853592a22 meson: update subproject wrappers
8:  ad9176ef14e = 8:  5cd1b3ec3c3 ci: use Meson's new `--slice` option

---
base-commit: 8b6f19ccfc3aefbd0f22f6b7d56ad6a3fc5e4f37
change-id: 20250703-b4-pks-meson-cleanups-f53858d694f3

