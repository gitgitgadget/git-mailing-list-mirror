Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC7A2D
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622189; cv=none; b=I9KTq6zMcR4YcZbAY90yNGKN8AgRpeEKlan253RIYGiPta0Ll0MWxkq+o9+nmsqtm0Ifit8bJSwN3bdf3v7hUi+Y65zWAGZtDB3Fx1nW+Y11T+o0z+Z8UCFBZVzp7572Eeu+bXkGgJOJxrZtJelyVUZ9/tUcmOIronetIKEaHTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622189; c=relaxed/simple;
	bh=nN5YmuESfkuAx81bCc3CCaAG8O4TpNR0U4DTKebk4O8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=qPgCti308977tr1cX6zpyXwwRNGz94Lwm1zXYooNT06t3fwtK9WbXov0Hhcsuajc98f3HnMvELZzB5vHxpZakKVscB8xYQvuRHtRzE+1kMhE4DMopb8P0RilKdJAG6s8OhXSXKVDG2uGYw4eGmQNhNQ/yOH9ofE8KGKH1bR5n2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pDy3KUZd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mlihAp3/; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pDy3KUZd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mlihAp3/"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1EE501D00126;
	Fri,  4 Jul 2025 05:43:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 04 Jul 2025 05:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751622183;
	 x=1751708583; bh=q1EHeaAA/NOuIlVLmKfSMeKsA4YlzEjmxhNedF+ln+0=; b=
	pDy3KUZdC2VzTNajp4zQukI5tAqIlF1edRs5fV1ne24kiQYCSu2SrctyfrUiRvOb
	yTeVje6V+gP37KOtCO+9b+3BaXLeK7SGuvprafKFvLg2Oy+8yUuA0My1QpYnrTSa
	8IkwKli8Xum9XmWSSUdZUxg0KbbhaA+2gAP2x9b5dNQ7Q+Vpj/N2reXQorCw3Hz3
	ScOsMmjImY/uxYTqNn2u3oXZHB0o9NNNUjseupuaQbIBHPgTl2hnZeJRrhErUKzp
	7v/7t4xAXwY5nNgVqY+M57fncvsV8Od1e8QIwg6hSQwUf9ukx08OZUuQaynnIVAQ
	8gGNoP4gzgzZCVRp2w3tqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751622183; x=
	1751708583; bh=q1EHeaAA/NOuIlVLmKfSMeKsA4YlzEjmxhNedF+ln+0=; b=m
	lihAp3//YhnIO/6kBcbAGTS6/1J9cl8vcbHAdyv4dx4ebyiTJgX2UVcUypz/vOIS
	PVd7fx3IztkpRusgiKGBhx45bBOuvJ9lEs0S6HSRw9ydZcYyReQ0nr/TfAfIKfsA
	wZpFiLru/4MZE25c/WdxiYZ8NMIajgTLjt/HX9Ump1a0iMmNPNqlI8AfKh6ekNcM
	FmYKsJFbDP+ZBjO5Cny5PHMIbxIBUBJURCyZb/fq++dN2aqhxwp5J0EcJF3z2aMH
	+xu/0HxK3/FFynN9itPZktZnkMx1kbxzxGjPNW27jKixlNgnrN0Bjgotnw1eeiC9
	YR026rzxIF9OtG6anvpug==
X-ME-Sender: <xms:J6JnaE6-QsD-fsXq0aw0XlmR0zV35Z90t5xZetRufbBLUiuZ7H8-jg>
    <xme:J6JnaF43Qy_pjZIeYh7fEK5fU-64Dr7bW9hAQf5bCbzvRPwsqhIwC8t4kS8-EzP5E
    29Zs3Lie5EgeEU0PA>
X-ME-Received: <xmr:J6JnaDdfZQlQMfHiJMmml6spDThM2T9h5QWNhWtt66IqcrgiPk3J44rkIrL7q8lyBG_AXjMCrJ_jnpo_2Nj_MLQedsuoALqk9fYZrGocmCuI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvvdekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhihvghnuhhssehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddthe
    esghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:J6JnaJJgTNH1aiX6KwmlZLn3cq5sKIqGpIbqeVydDPRjqJo7x7Bcgg>
    <xmx:J6JnaIIOJJt1gF7fwpmjXRCnUwGz6zB1Fpdvpyo4Kv84Sod148Ot2w>
    <xmx:J6JnaKyVIRBiC1jYu3Q-SAPzsRN1gsdA4k8vPkv7mHWK2Nj6d-Pfsw>
    <xmx:J6JnaMLT8p_LlvwnDAOGLz1hJ8ZxboeBInYeBlTizAPv1kBRufrSMQ>
    <xmx:J6JnaNGpgcOraVN28sXj84cD9t6R0D9d2BRmWLXTsEiutQgsvMfJQ1Hm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jul 2025 05:43:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0b5f18a9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 4 Jul 2025 09:43:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/2] Add reftable by default as a breaking change
Date: Fri, 04 Jul 2025 11:42:55 +0200
Message-Id: <20250704-pks-reftable-default-backend-v3-0-a1eb63e8442a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB+iZ2gC/43NQQ6CMBCF4auQrh1TWivElfcwLqbtVBoQSIuNh
 nB3CwvjTpf/5OWbmUUKniI7FTMLlHz0Q59D7gpmGuxvBN7mZoILxSsuYGwjBHIT6o7AksNHN4F
 G01Jv4Wgkd1KuW2SZGPPSPzf+cs3d+DgN4bV9S+V6/RNOJXCoD1ajtei04uc83/s7W9UkviX5Q
 xJZUigqqgTWRtFHWpblDSV2gWEPAQAA
X-Change-ID: 20250702-pks-reftable-default-backend-6c30f330250a
In-Reply-To: <20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im>
References: <20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Hi,

the recent thread at [1] motivated me to hack together this tiny patch
series that paves our path towards making the reftable backend the
default backend. It does two things:

  - It announces the breaking change for Git 3.0.

  - It makes it the default now already when "feature.experimental" is
    enabled.

The first item is subject to ecosystem support, most notably in
libraries like Gitoxide, libgit2 and JGit. The second item is intended
to extend the user base to power users so that we get more test exposure
out in the wild before we make it the default in Git 3.0.

Changes in v2:
  - Improve the breaking changes announcement a bit based on feedback.
  - Introduce a `REF_STORAGE_FORMAT_DEFAULT` define.
  - Print the default ref format as part of `git version --build-options`.
  - Link to v1: https://lore.kernel.org/r/20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im

Changes in v3:
  - Small tweaks to the commit messages.
  - Mention better data compression as another benefit.
  - Link to v2: https://lore.kernel.org/r/20250703-pks-reftable-default-backend-v2-0-5a27e72a8c5e@pks.im

Thanks!

Patrick

[1]: <xmqqtt3vkhwk.fsf@gitster.g>

---
Patrick Steinhardt (2):
      BreakingChanges: announce switch to "reftable" format
      setup: use "reftable" format when experimental features are enabled

 Documentation/BreakingChanges.adoc | 47 ++++++++++++++++++++++++++++++++++++++
 Documentation/config/feature.adoc  |  6 +++++
 help.c                             |  2 ++
 repository.h                       |  6 +++++
 setup.c                            | 14 ++++++++++++
 t/t0001-init.sh                    | 45 ++++++++++++++++++++++++++++++++++++
 6 files changed, 120 insertions(+)

Range-diff versus v2:

1:  efbc0ba7338 ! 1:  ecf018b81ff BreakingChanges: announce switch to "reftable" format
    @@ Commit message
         significantly better in many use cases.
     
         Announce that we will switch to the "reftable" format in Git 3.0 for
    -    newly created repositories.
    +    newly created repositories and wire up the change, hidden behind the
    +    WITH_BREAKING_CHANGES preprocessor define.
     
         This switch is dependent on support in the larger Git ecosystem. Most
         importantly, libraries like JGit, libgit2 and Gitoxide should support
    @@ Documentation/BreakingChanges.adoc: Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zo
     +  ** It is impossible to store two references that only differ in casing on
     +     case-insensitive filesystems with the "files" format. This issue is common
     +     on Windows and macOS platforms. As the "reftable" backend does not use
    -+     filesystem paths anymore to encode reference names this problem goes away.
    ++     filesystem paths to encode reference names this problem goes away.
     +  ** Similarly, macOS normalizes path names that contain unicode characters,
     +     which has the consequence that you cannot store two names with unicode
     +     characters that are encoded differently with the "files" backend. Again,
    @@ Documentation/BreakingChanges.adoc: Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zo
     +     every reference is created as a separate file. The "reftable" backend
     +     significantly outperforms the "files" backend by multiple orders of
     +     magnitude.
    ++  ** The reftable backend uses a binary format with prefix compression for
    ++     reference names. As a result, the format uses less space compared to the
    ++     "packed-refs" file.
     ++
     +Users that get immediate benefit from the "reftable" backend could continue to
     +opt-in to the "reftable" format manually by setting the "init.defaultRefFormat"
2:  812cc75dfd8 = 2:  642f774d743 setup: use "reftable" format when experimental features are enabled

---
base-commit: 83014dc05f6fc9275c0a02886cb428805abaf9e5
change-id: 20250702-pks-reftable-default-backend-6c30f330250a

