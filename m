Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10500214A7F
	for <git@vger.kernel.org>; Tue,  6 May 2025 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529202; cv=none; b=f/vNDxWxLsn4qXGSPxCWJS9BUpsGEzDL2DbV4vZeB9OFGtssiXH6js0iMH/Xsmxy1SVZmQ2F2jaXzMDNIp/exQLCEuB4ZetbtSPON+wKmQiIMJkAj1i6qcUW6EwRdx+OxpHrZ8uPHPnY3/aS+UIKKy1wCA08aLiFI4YrW8ETzs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529202; c=relaxed/simple;
	bh=UVvOVc4V1Ode8oqfvXkDFLyO3H4PP8hSseqZtYqfAM8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YpiGAnzv/z2JBDZYLQ8U3lfc//DsFFLPdi11OjpLO0Cfa4tE6srWxAZqr1ZzoEAmc1yvP6p25jvrH3HrPCLpKylKxQTASdZbaMSr1Ex/XKNbP8VBmX1ackF/vRNCrgI5Tg+vHLDR50MmErN/JPfLw/ff8j+UGCbgYTKpb5HyPD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ffQJcZE0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oAY17V9v; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ffQJcZE0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oAY17V9v"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B89B1380F25
	for <git@vger.kernel.org>; Tue,  6 May 2025 06:59:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 06 May 2025 06:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1746529199; x=1746615599; bh=TUOyghsPdL
	z4SKMmEWdFkJlgWdhsVW/YajgBHSWkz4k=; b=ffQJcZE0uD/CxmqbNuWxcnJaE+
	/K1rG45y4sSufYihPf4HTA7uwWE1aTe1ZgrSZPiXjIK+KO5YQ0M8OT2vUSSrlhMd
	JVSMJho0TqW2vu/eeKdZ2KpA99flbnNmJ+OyegtHsoyny1ld5l86K4R6IvJvOwUn
	xYsPkuPJnyehGpUw2srKvHFvfcjr65Z8s0vC5NAEXGvjzPX3TH63rKExPabt7GBp
	QgijLNee9dt1lQZa3umC4B5TLPxJMf13+GS/8rJokRmwKCndvTFP6x1CINakvCF1
	wyTr/lIQzdLF6L74JDApwQwDGuGD4j5Akq27M8GLgcdWvt4spxsV3qMBekOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746529199; x=1746615599; bh=TUOyghsPdLz4SKMmEWdFkJlgWdhs
	VW/YajgBHSWkz4k=; b=oAY17V9vbQ8gPGQ3fj9oLQaXJ1PvCMwIvB6AUrWbwF5C
	OMuCJq1UdHEZ2Ie8+3XuToYM6RxxlML1rHxk0AqRSbCRgvFSZGnhSnO84oKthc/h
	8ZuZnfwF/WPSgnC63knrdHGDNMActVN6FwbBdwvnQ/PrwVEZCcOHCZbE490ySEjn
	zfPT9cHJF1u9Rc1L27LFLY1xzDC0pKsem26DItOME5h6ZpVl8ERWfceIV4mEZAIn
	wL3/RuAzMqta8xMerP4p3iXiJDNdHXl+JIkGt3tiu5RE+kUwtaKRfYHudrAKNMov
	pEDFqUFUUc+blIHNIuo3B3tclz1EQgAZw/hPnH2Vew==
X-ME-Sender: <xms:rusZaCdnq1GiEnCuEjRUoqhBgmxoXtrqnmNGqZAXDe298xhy5oMt9g>
    <xme:rusZaMMRkvbnZabJpqixbDtHlwQfkXCIuPAxe94KgO5rNxYyguuC19h6XuTd2Jf5p
    0fr2RwZ--h4baMOEw>
X-ME-Received: <xmr:rusZaDgaS6mVEMdty75BySm1u_BS9YuJuxpY2jAYT5N_94j8Zri7lbbHL75PCuOCY-5Svon_dSS9w9asLyhsnOiqzWMfEckmRZNbLlRG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgovfgvgihtqfhnlh
    ihqddqteefjeefqddtgeculdehtddmnecujfgurhephffufffkgggtgffvvefosehtjeer
    tdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesph
    hkshdrihhmqeenucggtffrrghtthgvrhhnpeehteeihfegfffgveejvdehtefffffhudet
    heeivedtgeffvddthfdtjefghfdtfeenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rusZaP_lC49IHH75F4FmJw6doULTuhnpXXmMGqNVDBgLXZnX9HVChA>
    <xmx:rusZaOvLC_5PznfIj-wWCCmpwVOFZ57QdlxFKfcQ0R5d6gGKufr0aQ>
    <xmx:rusZaGGRxQuZ1jVuWutcXSoX5E_Uq3x0dIN0Qdh_sw5ObOn7RN0z6g>
    <xmx:rusZaNOdxRmjKDFFFzldrXVm6s3o5F_094yDmm80GgxdRd_SgJmHSA>
    <xmx:r-sZaIKEcl7gvRUqiiMGmu0zLZAlF7B2UmjrKy_MwbzJ0IzXdr7bDY_w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 06:59:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 879e5d85 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 10:59:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] meson: parse TAP output generated by our tests
Date: Tue, 06 May 2025 12:59:49 +0200
Message-Id: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKXrGWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEyNL3YLsYt3c1OL8PN2SxAJdw9TUFDMDk0QDo0RjJaCegqLUtMwKsHn
 RsbW1AJVQfuVfAAAA
X-Change-ID: 20250429-pks-meson-tap-1eed604a02a3
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this patch series starts to parse TAP output generated by our tests when
executing them via Meson. This has the benefit that Meson starts to
understand skipped tests and reports how many subtests have been
executed:

    ```
    $ meson test t002*
    ninja: Entering directory `/home/pks/Development/git/build'
     1/10 t0024-crlf-archive                  OK              0.17s   2 subtests passed
     2/10 t0022-crlf-rename                   OK              0.18s   2 subtests passed
     3/10 t0029-core-unsetenvvars             SKIP            0.15s
     4/10 t0023-crlf-am                       OK              0.18s   2 subtests passed
     5/10 t0025-crlf-renormalize              OK              0.21s   3 subtests passed
     6/10 t0026-eol-config                    OK              0.25s   5 subtests passed
     7/10 t0020-crlf                          OK              0.81s   36 subtests passed
     8/10 t0028-working-tree-encoding         OK              0.85s   22 subtests passed
     9/10 t0021-conversion                    OK              3.45s   38 subtests passed
    10/10 t0027-auto-crlf                     OK             26.35s   2600 subtests passed
    
    Ok:                9
    Fail:              0
    Skipped:           1
    ```

This new feature is only enabled with Meson 1.8 and newer, which
contains a bugfix that we have upstreamed [1] to make the TAP parser
work in `meson test --interactive` mode.

Despite the changes to Meson itself, this patch series also contains a
couple of fixes for our test suite that caused us to not generate proper
TAP output.

Thanks!

Patrick

[1]: https://github.com/mesonbuild/meson/pull/13980

---
Patrick Steinhardt (4):
      t: fix cases where output breaks TAP format
      t/test-lib: don't print shell traces to stdout
      meson: introduce kwargs variable for tests
      meson: parse TAP output generated by our tests

 contrib/credential/netrc/meson.build         |  2 +-
 contrib/subtree/meson.build                  |  2 +-
 meson.build                                  | 12 ++++++++++
 t/meson.build                                |  6 ++---
 t/t0000-basic.sh                             | 35 +++++++++++++++-------------
 t/t1007-hash-object.sh                       |  2 +-
 t/t4041-diff-submodule-option.sh             |  4 ++--
 t/t4060-diff-submodule-option-diff-format.sh |  2 +-
 t/t7401-submodule-summary.sh                 |  4 ++--
 t/t9500-gitweb-standalone-no-errors.sh       | 14 +++++------
 t/test-lib.sh                                |  4 ++--
 11 files changed, 51 insertions(+), 36 deletions(-)


---
base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
change-id: 20250429-pks-meson-tap-1eed604a02a3

