Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAB41F4CAC
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566102; cv=none; b=TNOWXeXMSk4GeYIICWnEqxLZadoPJ9e+jCzXjrblL1xcxC8OfQwF6agrYB7Adw7xZ4LXDNnR2NJtCOqh09eYcDazHskhL30zmhsDqRVg4HS+ENC35pGMALdMRlOEshdwKzmZUTfO/p2xlWxe0BCpbwsoIWsOv24FZAihlInC1KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566102; c=relaxed/simple;
	bh=sZ8pI5iWOoqcmv7KAu0Q/F47PKKciKDc8beLlRqGpxk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=TBp+eg1WUtLvhS01omOMPiOAmCrj0fg6cNl2JyHDBZKw53tcDBp5JbVN2eRQRG70vX6w7SQLKbRocDBB3uKopd8U044uLzYWVMNVZVnpbQ4Pzlwm1u6IvyFuJiWesCaHkIXkd4mOhabNhZ69t8JbiGqoohHXuPMvPd4WeMC6WXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RExhIF1M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pw1H4BYz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RExhIF1M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pw1H4BYz"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8866913801AC;
	Fri, 25 Apr 2025 03:28:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 03:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745566099;
	 x=1745652499; bh=IQ1CDaPHJW9icRg18zUC0QZd8Z9r21MLDJTA7qIU1vk=; b=
	RExhIF1MkmwgqrJH9/Evc5pP5Q2YRr6ryf/CEPBnA6gIVlc8euaXFPCwK3gAzjyI
	7QMIyJfoLKKVGOO2ackM5yfsKzO4JoBXD8kIpnlxmw0TbD/J/UTP6Evnk2vO2gcO
	D9LZQm/QCWFrKgr9vAplHll4T0yXHx2Dw2ImYGds+XdTu4MoDKZWptDk+JMcimbC
	SdSrIRe8cSDwakPiVUBoqF8RG+esrkfDw1Lvr3OeAyq+JszZz+M/X1HsBQPhJUtF
	HdB7KNrc1SBFsAFdLnG9myy05h1uND1QmZJaeKzZE6HQEZ65EtfiNQEiCdnHahFH
	ODzzaxVsQ4eDVueuq7FL2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745566099; x=
	1745652499; bh=IQ1CDaPHJW9icRg18zUC0QZd8Z9r21MLDJTA7qIU1vk=; b=P
	w1H4BYzbYyUR3IB1M7fvTA4HHHYgHXf9nfvQuKl0xjE++Vo4eJMc9gn3aBzRpRHl
	ItudLxiCxnnBqfCk5R+2npDmvHA4eyPkPfcABTcZrwhMCvlQnuLhi/eOUvQ/m5Em
	ds6VkfLqz48dPGOEqnzdFJL2XZl/U1Jktd5oOpnfHstZTt+DtI+bAWMQ+HEBHdNK
	GytJOvG2c6ofDlUEfenE1sTCPQW+IQAhN5NXO6V2BEIAW/eWdp3z7BDx2d1IHtf+
	VlUYXAnxHBngypFayulDKJ9sHssJVQ2R25lhwPdLu3r4Y32jn+cpQRjAbne9Fjdo
	RJU58AECA9CPDVa6MinOQ==
X-ME-Sender: <xms:kjkLaMcZIXAJZmY2APo485prFDXlVtjffaWbF0V-HqpB3ba2R0cMhg>
    <xme:kjkLaOPfqhjNZ0BV2JpHY5yeKza0tVtJvNspt9iCIR-qmfJNyHIXJ6BFnEDt8y9Fa
    7AZYa9qJxmUkLY2dQ>
X-ME-Received: <xmr:kjkLaNidizxXLr5nyiGA0MZQXfl7ZBfjN40EF_dqBnDdH7ePJN4zkY52eYxWnKMxqSnfl-OGRJT8sDkm6X9yHkJrgNeEKF3yUfIeayso>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:kjkLaB-xRU8dxY6USWAHG60jS1J_u5sru7FYZbxtYaCO-yKQDGMBMw>
    <xmx:kjkLaIsIpsTDiTE1fJyTyMUsGCXrMWrrV6yPck_tsxoZ1kKiQ3Nsgg>
    <xmx:kjkLaIEhadEipUvqfDsrKbxG5s9esYbHXCFZltRrLif43ZLm5FYQkQ>
    <xmx:kjkLaHO7ZtE7IwYLFS7bSPOHnzsmHtkXNAlSzmvmhqO1iBUbo56tEA>
    <xmx:kzkLaO7LbGt1PlD3M0XMACbKpynHdShS20_c4hfL70J78bAp-uH8n7Jx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:28:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6c5c4faa (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:28:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/5] meson: wire up support for benchmarks
Date: Fri, 25 Apr 2025 09:28:12 +0200
Message-Id: <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIw5C2gC/3XNywrCMBAF0F+RrI3k1SS68j/ExTRNbJCmJZGgl
 P67aREfYJf3MvfMiJKN3iZ02Iwo2uyT70MJYrtBpoVwsdg3JSNGWEU403i4JtzZ1Adc22DaDmI
 pQDswlZN7IRUq0yFa5+8LezqX3Pp06+Nj+ZLp3L5ATv+DmWKCawbG6kpSCfxYzna+Q7OW2UcQV
 KwIrAhEcKWIJkCl+hH4l8DYisCLoAAaqWsw0jVvYZqmJ7QEf745AQAA
X-Change-ID: 20250328-pks-meson-benchmarks-a8fac5f69467
In-Reply-To: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Hi,

this small patch series implements support for running our benchmarks in
"t/perf" via Meson. The series does not aim to replace "t/perf/run",
which is more fully-featured and allows running benchmarks against
multiple different trees. Instead, this series only allows running the
benchmarks against the current tree. Users are thus expected to continue
using "t/perf/run" for more advanced usecases.

Changes in v2:
  - Adapt "aggregate.perl" to use a "/usr/bin/env perl" shebang.
  - Link to v1: https://lore.kernel.org/r/20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im

Changes in v3:
  - Document how to run benchmarks in "meson.build".
  - Expand the message for the commit that enables out-of-tree
    benchmarking.
  - Link to v2: https://lore.kernel.org/r/20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im

Changes in v4:
  - The patch series was rebased on top of f65182a99e5 (The ninth batch,
    2025-04-24). This is due to a conflict with ps/test-wo-perl-prereq.
  - Introduce a 'benchmarks' option. This allows developers to require
    benchmarks as desired. By default, we auto-detect whether the host
    system has all dependencies available and enable or disable them
    accordingly.
  - Report whether or not benchmarks are enabled via `summary()`.
  - Our benchmarks depend on Perl, so add this dependency accordingly.
  - Link to v3: https://lore.kernel.org/r/20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (5):
      t/perf: fix benchmarks with alternate repo formats
      t/perf: use configured PERL_PATH
      t/perf: fix benchmarks with out-of-tree builds
      meson: wire up benchmarks
      meson: wire up benchmarking options

 meson.build           | 16 ++++++++---
 meson_options.txt     |  8 ++++++
 t/meson.build         | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/perf/aggregate.perl |  2 +-
 t/perf/perf-lib.sh    | 32 ++++++++++++++++++---
 t/perf/run            |  4 +--
 6 files changed, 128 insertions(+), 11 deletions(-)

Range-diff versus v3:

1:  2375a16c2c0 = 1:  174804805c2 t/perf: fix benchmarks with alternate repo formats
2:  69782035246 = 2:  41faa3d9b3b t/perf: use configured PERL_PATH
3:  cca40e9dd0e = 3:  87ea3ab1a45 t/perf: fix benchmarks with out-of-tree builds
4:  50e9b507db4 ! 4:  723a0a2e449 meson: wire up benchmarks
    @@ meson.build
      #   Test execution is parallelized by default and scales with the number of
      #   processor cores available. You can change the number of processes by passing
      #   the `-jN` flag to `meson test`.
    -@@ meson.build: git = find_program('git', dirs: program_path, required: false)
    - sed = find_program('sed', dirs: program_path)
    - shell = find_program('sh', dirs: program_path)
    - tar = find_program('tar', dirs: program_path)
    -+time = find_program('time', dirs: program_path, required: false)
    +@@ meson.build: git = find_program('git', dirs: program_path, native: true, required: false)
    + sed = find_program('sed', dirs: program_path, native: true)
    + shell = find_program('sh', dirs: program_path, native: true)
    + tar = find_program('tar', dirs: program_path, native: true)
    ++time = find_program('time', dirs: program_path, required: get_option('benchmarks'))
      
    - # Sanity-check that programs required for the build exist.
    - foreach tool : ['cat', 'cut', 'grep', 'sort', 'tr', 'uname']
    + target_shell = find_program('sh', dirs: program_path, native: false)
    + 
    +@@ meson.build: endif
    + # features. It is optional if you want to neither execute tests nor use any of
    + # these optional features.
    + perl_required = get_option('perl')
    +-if get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers') or get_option('docs') != []
    ++if get_option('benchmarks').enabled() or get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers') or get_option('docs') != []
    +   perl_required = true
    + endif
    + 
    +@@ meson.build: meson.add_dist_script(
    + )
    + 
    + summary({
    ++  'benchmarks': get_option('tests') and perl.found() and time.found(),
    +   'curl': curl.found(),
    +   'expat': expat.found(),
    +   'gettext': intl.found(),
    +
    + ## meson_options.txt ##
    +@@ meson_options.txt: option('docs_backend', type: 'combo', choices: ['asciidoc', 'asciidoctor', 'auto
    +   description: 'Which backend to use to generate documentation.')
    + 
    + # Testing.
    ++option('benchmarks', type: 'feature', value: 'auto',
    ++  description: 'Enable benchmarks. This requires Perl and GNU time.')
    + option('coccinelle', type: 'feature', value: 'auto',
    +   description: 'Provide a coccicheck target that generates a Coccinelle patch.')
    + option('tests', type: 'boolean', value: true,
     
      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
    @@ t/meson.build: foreach integration_test : integration_tests
        )
      endforeach
     +
    -+if time.found()
    ++if perl.found() and time.found()
     +  benchmark_environment = test_environment
     +  benchmark_environment.set('GTIME', time.full_path())
     +
5:  52cca4b17ae ! 5:  16c0230656f meson: wire up benchmarking options
    @@ meson.build: builtin_sources += custom_target(
     
      ## meson_options.txt ##
     @@ meson_options.txt: option('docs_backend', type: 'combo', choices: ['asciidoc', 'asciidoctor', 'auto
    -   description: 'Which backend to use to generate documentation.')
    - 
      # Testing.
    + option('benchmarks', type: 'feature', value: 'auto',
    +   description: 'Enable benchmarks. This requires Perl and GNU time.')
     +option('benchmark_repo', type: 'string', value: '',
     +  description: 'Repository to copy for the performance tests. Should be at least the size of the Git repository.')
     +option('benchmark_large_repo', type: 'string', value: '',

---
base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
change-id: 20250328-pks-meson-benchmarks-a8fac5f69467

