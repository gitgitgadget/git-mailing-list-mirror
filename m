Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E656E198A36
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134730; cv=none; b=QE/hht1hQdR5ZtqYmb8zP3yMATx7FoIWPIZmMueV6jauKIDmW5b282f8zc5i546hslgRfMD+0F832rt10lW/ppR295lxvINf+fVdDXtZRiLmdTcWmLfFqdShL2//Qdfc+VWx4REl+dRkRCmK7JoOG9etthUMyW84Ij+pXuwwRYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134730; c=relaxed/simple;
	bh=8EhaM0yb1Pv6dci41igd9phUgLdtVcD4jyd4WugkLVM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kswHGdOlBBxmO6snqbXUXcTX1RuCdSgisIMVIEM7pXlG0IA8EnW3oJZiuGZg1infMjmQkbp+1UthJIK87piIl3Nm58Wy1Q9j3+HKUEG5bxRS64XyTI1vIEfr8Dy6cEO0sBzjHBsZ43MYl+qCu5Pan5R+R8re96Hlki4Jmd2wS9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kg0xdp/Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ef4ybbtw; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kg0xdp/Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ef4ybbtw"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BEFF01380B1E
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 29 Jan 2025 02:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1738134726; x=1738221126; bh=hqJsAoNiRS
	Vt7fYg/YwJ6I+QMeafaPTkccTOEAUqI2o=; b=kg0xdp/QvRIz0RALc0Uunw9Dch
	1gvKCs+cdbbmm1cr5yOh1Ie8vHHT6SQrdzsALdujWQrh1s5x8NtHv4vNGkw9m8IP
	5ciQqjM6kUIdql79Wht5f3BfxTctIVhhKT4SagGQOc/qjK+niK5qm2SycQJfgCLB
	FNpr6+ow7PQ4BB6KxZ5vFoQ7ctzYcG0dC6rFRFuvISdSW2qYnYe+lVxdIpl3g2HZ
	fs74LcGp62aljX7RhAKm5WEwuieOs1bu0Ua3noG3kS/DAW9Kaz7cnSSF2aslyqsw
	bIIBs3KXdOs+wUhi2OlNzLWZhgREY2FKaOoBQVp+rGhM+ezEHLzT02VsFhcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1738134726; x=1738221126; bh=hqJsAoNiRSVt7fYg/YwJ6I+QMeaf
	aPTkccTOEAUqI2o=; b=Ef4ybbtwTUQjsxOr2NxGODzKc40B8XVKYzz2xQUl2rNl
	DRy+B4s0WA9L7FxQ9cdOqRRijBIDrq+8sZGi3jdi5+XVrJbMfQvYXLsQMfAVglEr
	z1F3yHIh0CDqrEsX3ANF0/631BBBGu/ljoDrn/T966qFULuCHTshXjyJm6vZT9Ux
	T7TCslZAEEleO8qYYMxcm9vYFzqAKJH04XQf1I4PzRH9PuJpMG2O5PSq0ifmyQ6x
	RAHzWOD3w4hzxfYWyMxsJIfAZAtAsr5updM2XRwWRpouWos4lEZ5OOxVFEHwiw39
	wMhaxGAxfeWyRQ8576wrugefaXIjfRKwNG3igeE2Mg==
X-ME-Sender: <xms:xtSZZ2J6uR3mLvuuIzXI1kunj0A5NL8NkqGhO1TxfwtU2ejVURwoqA>
    <xme:xtSZZ-JDO2Kd66wgu2PJFAyYqD9Ei_NgAAeuk4kay3wMqkGbGak21rTzmBUdzYKEn
    azBe4td6jo3hha3Cw>
X-ME-Received: <xmr:xtSZZ2tL8ZlF9BqX8AbdLhJMd-Je6cH9ZJjwbM24NY1T_774O_lFunKkMBgumT8aWSO4V1sBa0FPfprbRU5V9d2Ee47v96hcnfGBqt5fhFhkMer4FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetie
    egjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xtSZZ7aqBut6mFsJJvGplXKP4dyfCX6bTE0Qm2j2CmvpuTjzepTZhQ>
    <xmx:xtSZZ9b3QX9gTPYxrL2NIQA3V5EBk-X1ywxegr-kwDKoE1mQqXu1nQ>
    <xmx:xtSZZ3Bm7wG1gxr3GconZxhzV5daygnNqPsftTxT-fwM7qqomw5leQ>
    <xmx:xtSZZzbP1OrdvfzZTFqvdJDjtDbM33GDfsKsLXdFjllGYgWJWf14Eg>
    <xmx:xtSZZ8wWiEHOnlN0wPrz3h__RPctZmSzdVd_LOnu3RKigC5cSUDILx0D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 18f07f2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Jan 2025 07:12:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/11] meson: cleanups, improvements, smallish fixes
Date: Wed, 29 Jan 2025 08:11:53 +0100
Message-Id: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALnUmWcC/x3MywqDMBBG4VeRWTtgkqairyJdtPZvO0guZCQUx
 Hdv6PJbnHOQogiU5u6ggioqKTaYvqP1c49vsDybyQ7WD8Yaflw4b8oBmiJLyCVVBMRd2cGP3l0
 dJrNS63PBS77/93I7zx8fnf2+awAAAA==
X-Change-ID: 20250121-b4-pks-meson-improvements-3e575363e91c
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this patch series contains a mostly-random set of smallish improvements,
simplifications and fixes to the Meson build instructions.

Thanks!

Patrick

---
Patrick Steinhardt (11):
      meson: fix exec path with enabled runtime prefix
      meson: inline the static 'git' library
      meson: simplify use of the common-main library
      meson: stop linking libcurl into all executables
      meson: introduce `libgit_curl` dependency
      meson: drop separate version library
      meson: deduplicate the list of required programs
      meson: simplify setup of PATH environment variable
      meson: prevent finding sed(1) in a loop
      meson: fix overwritten `git` variable
      meson: consistently use custom program paths to resolve programs

 Documentation/howto/meson.build |   2 +-
 Documentation/meson.build       |  13 ++---
 meson.build                     | 124 +++++++++++++++++-----------------------
 t/helper/meson.build            |   4 +-
 t/meson.build                   |   4 +-
 5 files changed, 63 insertions(+), 84 deletions(-)


---
base-commit: da898a5c645ce9b6d72c2d39abe1bc3d48cb0fdb
change-id: 20250121-b4-pks-meson-improvements-3e575363e91c

