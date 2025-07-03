Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE662D8DC2
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535017; cv=none; b=j/gs11ao7B8p9cc3SjODNPqoOgFWm654ZIK7ML9KlyESE1ODm/4Xd21uv2ZgGl21CGgVoEemcOjOkZ+pM/23GXpPqkpByvc0s0UYNFyaLLWqQPXxqQ+FpPMgLEeSHGjMd0z/DVWdNrSxRgwrf3n8ZT7XpDuTNYLSCfCoNcD2XdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535017; c=relaxed/simple;
	bh=apM1CrsuGI01dhLMBCPiDozCHAZrL7afNrwj+XfrlI8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UBN8ImqZCGOhbQafGD2nxpIGoGSQa6VOk2QgLF1KST1d5NsKaRS507zSk4elgkd1KFlKW0vVd5Dwzg/eP8ura3JZJNR38QhB4Vntaf50kKy5VZfpj5PcGGpriQpQ0YP7B6H068BJ8gXLsGrLFuf9uURlv1BoqvXafhHdeYaGfE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wFSekP7V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IqVmZ1Qw; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wFSekP7V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IqVmZ1Qw"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5288B7A0275;
	Thu,  3 Jul 2025 05:30:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 03 Jul 2025 05:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1751535014; x=1751621414; bh=6QDMPYUEdz
	sAq/YbNmcFJfec2wvhVMs6G0AaJRDXHpo=; b=wFSekP7VhwHID3pEvjmaz7ronT
	PdmPri204G2XpQopMfZJASEV3/+OGMU54fHujSrQm/+y2/IbSOb+ACaUqR/me8zf
	U3qwIootgA1wPVb3TM8Zg2V3mu2Xxt+SrPQpJ/upDXebtwnlg/NIV/Vm0hqS8oQV
	JI8jpZl4fiRlo99IjGROHE0lILQBDO9Qs4ebQ7mBGug1Tt3u9ZVffsirmYFC6rpD
	4PzkWnVj+pm1mQy0lRgWmqHUPcuzTulpkL7YWulrv1ZkHmi5Lg6h3iwM+ZCS52LF
	XkfYM0zJAmKKWm3qXklSNLxt9KymWrT4Ih90lNM/QrJFRJy5FD3o2HWfsJ2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1751535014; x=1751621414; bh=6QDMPYUEdzsAq/YbNmcFJfec2wvh
	VMs6G0AaJRDXHpo=; b=IqVmZ1QwV+XVXXPWSzOY2jHE7nbQo43RgxBT9yyw6Iat
	VQIa5lda9sjzWytkDMs1wz9P9kT5T9OGlqvQGTK4FFTsqRIxf9ja+r6YfjzM2HNk
	nhRo8G8vKoKnm+8VrMtmqEp9lj5e0fgG2NO+lOhYIRLjMOu07Gnhmvs7RwwelzH0
	uLz2WQLURIP/M4UhWcgrWCvQ3r+X91rlZqYJH7kuTJOJYqGpCSni25vnn2728SvR
	GMq/LqIUjPJTbIH23T0Nn1X2U55K2rl+mzNFby2WsIo/YJ3kRjx3RVs/qM96VFQ8
	niVRanWDOYMalcfCjQY9MgPNjlB3vA8G6vGsIhL3oQ==
X-ME-Sender: <xms:pU1maFw8kD2ec9vEPDqKxab46PTP7bPo1PMaAUo6KeksAuZo3WISng>
    <xme:pU1maFR3aoHw9wMXqJmyEgwf4v_gPwcQeXfmb2Bc-zPCk18hZ-bEvtZ-sJgc7ztnC
    hPmF86GkEXS4Kj7Dg>
X-ME-Received: <xmr:pU1maPWeWpJEHXDhjwsfHj1G5Gqk2cO0pOHmrYCybUpGfEyJUastVxduqGLcsZgSfnshfzacVZszn9sE2pakD8Tin_ONjvQFdvT0kyOqiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    eugeektdetieegjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    vghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehirhgvtggtrgdr
    khhunhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:pU1maHg4JQD_TthWAPSUX9Bo2vsPZJtXRsdQf2zYpbf2WbalDq4_dQ>
    <xmx:pU1maHCfeNvHEWb1KosEzr6aSqV3RhjBGpMeKQnxTGNplzN0PGDbBg>
    <xmx:pU1maAIfwW1qWKZks-omTI1ndL_mSo-5no1O4d0gdGXBVmtkEN0x8A>
    <xmx:pU1maGCRiwGVxIV9NzYTMMiCyC8eogapQbnm4Oj4_J0rr16Ln1A4NQ>
    <xmx:pk1maDP25qSBoORuIdAXTBpEi1_4LPfSZpQ6tCuI60VsJ5uAlYHBL4p->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 05:30:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 21ad690d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 09:30:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] A handful of Meson cleanups and improvements
Date: Thu, 03 Jul 2025 11:28:42 +0200
Message-Id: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEpNZmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwNj3SQT3YLsYt3c1OL8PN3knNTEvNKCYt00U2MLU4sUM0uTNGMloN6
 CotS0zAqwudGxtbUA9AEmlGcAAAA=
X-Change-ID: 20250703-b4-pks-meson-cleanups-f53858d694f3
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>
X-Mailer: b4 0.14.2

Hi,

this patch series contains a couple of more-or-less random cleanups and
improvements for Meson that I have accumulated over the last two months.

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
 meson.build                | 26 ++++++++++++--------------
 subprojects/expat.wrap     | 18 +++++++++---------
 subprojects/pcre2.wrap     | 18 +++++++++---------
 6 files changed, 34 insertions(+), 37 deletions(-)


---
base-commit: 8b6f19ccfc3aefbd0f22f6b7d56ad6a3fc5e4f37
change-id: 20250703-b4-pks-meson-cleanups-f53858d694f3

