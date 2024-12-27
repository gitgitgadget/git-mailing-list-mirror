Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5C1F4711
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735308002; cv=none; b=FZOpxMrJBxF3rIT1T7YZNsVo+7VXqDcTo4LF0a0khmeAymG7DC/oSdpYUolT/YqB5AbS7dxQ0n2kRCW1C9CaJ3mz0wzXNca4AYkPL+qIJbxzBMz/70Rf0lKmdf/ULdOO4zxux3NOr15jOd2r9sW46LTlWrOxBfjGjgKLJCfMVg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735308002; c=relaxed/simple;
	bh=yiu4NgL3g5NYokayBuYGO3RVrvSPnmorUC0Zgjdy6eU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=HoQVVzhEufaybPFFkGCPt83JFMJi/TZiQlQJJb8Go6hiapf5uPKn4MM31oyITNf5NpNdHFJdyWi4Qps+vUQDzrUrRRfhsIRRi09UaOwmnfnR/xQAT3kZFeJSrn4iXimb1qjP1WD6JzCZU7lJIi6DOot5cYokZMsRx9yzzxDu6gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U9gafZos; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hL7KMPwq; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U9gafZos";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hL7KMPwq"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id DEC331140119;
	Fri, 27 Dec 2024 08:59:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 27 Dec 2024 08:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735307999;
	 x=1735394399; bh=t9uL38wItaXZaK9cC6X+exXXAq3Hsm20CbHl+u2pM6A=; b=
	U9gafZos66QBHVI7Aw9bOEroFsGA1k73kEfTjLnZwRjInf2MZMLIEAY3SENc+gcL
	B1vMumVwixUoweFXUKPLZPvK34uFFmhIje3cOcpDOn7SANz8FX3EIt2W3DoyABRd
	iw2mS1bIqee+no/p327/GHH5k8xAVPdKA2saaDpy7MRWDOPE4QR6egf/hprcpiCR
	TsfAPBXlyneJ9R+k1Auhu2LXnHMknxdPyZxag711OBUVRbMkBkHdLgelnBIeZDzu
	llC1U8gZ686oO9N111A9tjVrzFpoH59AHlnkuurQZ0ymNX0aUDxPKBWHgQgoIdcX
	a9RDHMx9kcgCidPcNKMXNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735307999; x=
	1735394399; bh=t9uL38wItaXZaK9cC6X+exXXAq3Hsm20CbHl+u2pM6A=; b=h
	L7KMPwqbzmLKVZmB8/PG10V4Zon2I3eOzudv9eTMR60Ro3q9nQsTYtni/fKkXgcx
	fmljKsKo64nLUxqvws+fDZyGVlzC1yb90bONcAdOHkwxmQU3RMmTYQtJlW/geR7B
	DNkFBbopKXeswA3lbv9d9gQJcX36YVV19c3Xu8joOYl1gY5dlHzGT1EPzwJiOZhb
	HWs7+veG43GBh95d54zmmIaRNE/fPSg7mDIzmBWkjugmuX2LDZugm7Lhs6TKPqcD
	4T4qmSjba38CZO+lDXu0yR4/WJeVQClpKmpmciyC3TzhFT+0ZrE47+AqKKIm1cZ/
	EXwQWXx7imGcVSQubptpw==
X-ME-Sender: <xms:37JuZx6sPIuz5tA61R5Zu1UUfRWMmT0gzwijoHzmIIRxFKBMORDt1w>
    <xme:37JuZ-5YFsNUuP-pQUDBcmJmPqFB8nCHqHD0fIfC9BR2suTjth-95J-dP7hGc8-7T
    XQlOTL80A6VCWhxVA>
X-ME-Received: <xmr:37JuZ4cJMntP7iUS70P5RvLMzDINomnCtfq_elD0KCX_bNOoVLuhaiBu3zQHg1qOFghJKNkNGpXAJdnDCfRpnmRWZ3dK3eL7pM3LWWyIWQChkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeekkeejvedtueeukeektdeggfdtkeeuudeuudeguefg
    ffelhfehuedtvefhkeeugfenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnh
    gvlhdrohhrghdptghonhhfrdhinhdprhgsrdhinhenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtth
    hopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:37JuZ6LENIgIOfQVhUSTZ68A__sFtxzriiVBMhmhYnQUynJFRHebgg>
    <xmx:37JuZ1IJvWTTDbI2Uec1YyjIbX91dPokG60FcBlaR9VWi8zyW0b7HQ>
    <xmx:37JuZzxAW-_iZlNexP40zWJlg2i9qECV-cwvRIZJ8qxYDBsfnTbq3w>
    <xmx:37JuZxLTfZfz0J91Zi0PrvrVI6beSOdT18D96W1Vm-APPlyLDur4IQ>
    <xmx:37JuZ8UuzWgOA2kp-rgY1OPwqDcua54hDt7mxVaaIJu_69p2jo9sjwUE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 08:59:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 56a5880d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 13:57:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/12] meson: wire up missing HTML documentation
Date: Fri, 27 Dec 2024 14:59:28 +0100
Message-Id: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMGybmcC/22NwQ6CMBBEf4Xs2TV0W0A8+R+Gg5RFNgZKuoZoC
 P9uJfHm8U1m3qygHIUVztkKkRdRCVMCOmTgh9t0Z5QuMVBOzpAhbB3OD8WRNUzYBa9IpXVtb7m
 qSgdpN0fu5bU7r03iQfQZ4nu/WMw3/dnsH9tiMMfcV6e6qAvynb2kwlFGaLZt+wDKE5ACrwAAA
 A==
X-Change-ID: 20241212-b4-pks-meson-docs-2634bf3e7764
In-Reply-To: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
References: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Hi,

this patch series wires up missing HTML-based documentation with Meson.
This includes a couple of missing manpages, the user manual as well as
the random set of articles that we have. It also starts to generate the
indices for API docs and howtos so that the result is a complete set of
HTML docs, same as with our Makefile. It also fixes a couple of smaller
issues I found while working on the series.

Notably missing yet is an integration with CI as well as sanity checks
for any kind of missing docs in Meson. I'll work on this in a separate
patch series once the initial CI integration as well as this patch
series here have landed.

Further missing is the generation of both info pages and a user manual
PDF. I couldn't find any users of these anywhere in downstream distros,
so I decided to not care for now until somebody complains.

Changes in v2:

  - Change the base to 76cf4f61c8 (Merge https://github.com/j6t/git-gui,
    2024-12-26). This is done to fix conflicts with in-flight topics and
    to pull in the CI setup.
  - Fix a typo.
  - Include another commit to auto-detect missing manpages in Meson both
    via Meson itself, but also via our Makefile.
  - Make the equivalent check in t/Makefile work with Dash.
  - Link to v1: https://lore.kernel.org/r/20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (12):
      meson: wire up support for AsciiDoctor
      meson: properly wire up dependencies for our docs
      meson: fix generation of merge tools
      meson: generate HTML pages for all man page categories
      Documentation: inline user-manual.conf
      meson: generate user manual
      Documentation: refactor "api-index.sh" for out-of-tree builds
      Documentation: refactor "howto-index.sh" for out-of-tree builds
      meson: generate articles
      meson: install static files for HTML documentation
      t/Makefile: make "check-meson" work with Dash
      Documentation: wire up sanity checks for Meson

 Documentation/.gitignore                 |   1 +
 Documentation/Makefile                   |  24 ++-
 Documentation/asciidoc.conf.in           |  10 ++
 Documentation/{ => howto}/howto-index.sh |   2 +-
 Documentation/howto/meson.build          |  62 ++++++++
 Documentation/meson.build                | 255 ++++++++++++++++++++++++++-----
 Documentation/technical/api-index.sh     |  19 ++-
 Documentation/technical/meson.build      |  66 ++++++++
 Documentation/user-manual.conf           |  11 --
 meson_options.txt                        |   2 +
 t/.gitignore                             |   1 +
 t/Makefile                               |  12 +-
 12 files changed, 402 insertions(+), 63 deletions(-)

Range-diff versus v1:

 1:  e564c753c9 !  1:  376ed916ce meson: wire up support for AsciiDoctor
    @@ Documentation/meson.build: manpages = {
     -  input: meson.current_source_dir() / 'asciidoc.conf.in',
     -  output: 'asciidoc.conf',
     -  depends: [git_version_file],
    +-  env: version_gen_environment,
     -)
     +if docs_backend == 'asciidoc'
     +  asciidoc = find_program('asciidoc', required: true)
    @@ Documentation/meson.build: manpages = {
     +    input: meson.current_source_dir() / 'asciidoc.conf.in',
     +    output: 'asciidoc.conf',
     +    depends: [git_version_file],
    ++    env: version_gen_environment,
     +  )
     +
     +  asciidoc_common_options = [
    @@ Documentation/meson.build: manpages = {
     +    input: meson.current_source_dir() / 'asciidoctor-extensions.rb.in',
     +    output: 'asciidoctor-extensions.rb',
     +    depends: [git_version_file],
    ++    env: version_gen_environment,
     +  )
     +
     +  asciidoc_common_options = [
 2:  ce9bfd53f7 !  2:  6c6e593fad meson: properly wire up dependencies for our docs
    @@ Documentation/meson.build: if docs_backend == 'asciidoc'
     +    input: 'asciidoc.conf.in',
          output: 'asciidoc.conf',
          depends: [git_version_file],
    -   )
    +     env: version_gen_environment,
     @@ Documentation/meson.build: elif docs_backend == 'asciidoctor'
            '@INPUT@',
            '@OUTPUT@',
    @@ Documentation/meson.build: elif docs_backend == 'asciidoctor'
     +    input: 'asciidoctor-extensions.rb.in',
          output: 'asciidoctor-extensions.rb',
          depends: [git_version_file],
    -   )
    +     env: version_gen_environment,
     @@ Documentation/meson.build: cmd_lists = [
      documentation_deps += custom_target(
        command: [
 3:  905f220caa =  3:  b962455582 meson: fix generation of merge tools
 4:  ff35b7433a !  4:  32578c5cd2 meson: generate HTML pages for all man page categories
    @@ Commit message
         meson: generate HTML pages for all man page categories
     
         When generating HTML pages for our man pages we only generate them for
    -    category 1 in MEson, which are the pages corresponding to our built-in
    +    category 1 in Meson, which are the pages corresponding to our built-in
         commands. I cannot tell why I added this filter though: our Makefile
         installs all man pages, so a Meson-based build misses out on many of
         them.
 5:  bf8c278db5 !  5:  b704daf80c Documentation: inline user-manual.conf
    @@ Documentation/Makefile: manpage-cmd = $(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $
      technical/api-index.txt: technical/api-index-skel.txt \
     
      ## Documentation/asciidoc.conf.in ##
    -@@ Documentation/asciidoc.conf.in: manmanual='Git Manual'
    - mansource='Git @GIT_VERSION@'
    - revdate='@GIT_DATE@'
    +@@ Documentation/asciidoc.conf.in: manmanual=Git Manual
    + mansource=Git @GIT_VERSION@
    + revdate=@GIT_DATE@
      
     +ifdef::doctype-book[]
     +[titles]
 6:  aaebbf0e94 =  6:  7eaf4f4267 meson: generate user manual
 7:  1cc7d42a55 =  7:  52b9e4c34b Documentation: refactor "api-index.sh" for out-of-tree builds
 8:  29fbda50a5 =  8:  b9c8e5fe4d Documentation: refactor "howto-index.sh" for out-of-tree builds
 9:  cd7f5ee207 =  9:  1f724c113a meson: generate articles
10:  d52f3db2bc = 10:  acb6c5f370 meson: install static files for HTML documentation
 -:  ---------- > 11:  2b893f7c0e t/Makefile: make "check-meson" work with Dash
 -:  ---------- > 12:  adf4835053 Documentation: wire up sanity checks for Meson

---
base-commit: 76cf4f61c87855ebf0784b88aaf737d6b09f504b
change-id: 20241212-b4-pks-meson-docs-2634bf3e7764

