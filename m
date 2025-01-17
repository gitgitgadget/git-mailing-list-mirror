Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB1E1D5CE5
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107781; cv=none; b=d1ZvN31pJb6Z3o1+2L5/K8IV9eaqZwAp56v2oq3p70PD5ZUtF5sibIddMt5hOEDFnHh2b+g8K/bA79YqXzrW/2v6AqrFMpfb/vheUOSBG62uziQZKKUDogtk2pHSYmFwag/p1TpJ6q5ZH9Jk8ClEA2EWh187frzs1xZDCHMmR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107781; c=relaxed/simple;
	bh=W7SbDz3jicbv72BA9YaJ2pzNRGLd4kXdGyIkQTERvS0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ieSI1k6FqZM+uUDPUn/8Ci2z3rV22YsZ2RWG/zycUz3wJ5n9Y/+QZ0Ym880kvfmGQl2wTOgoSfsbiiJsX3YRN4TrEhcEHL0k/E1qSGHCOMTiAi0xm8L3sOb5E2gdZPDwurTkYOtMqfkJ3bzvokHh4eMRqVBdd+5g32+0jZQLLw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gzlIQX9h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RG3pLAM/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gzlIQX9h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RG3pLAM/"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A79211380217;
	Fri, 17 Jan 2025 04:56:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 17 Jan 2025 04:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1737107778; x=1737194178; bh=iCC7Xk+pnB
	AIGSnmNi/mWbBEOfWPXnneZKYaYpksE/o=; b=gzlIQX9hVomy0FOAEndvnae4eN
	jyM5X3Up3InPrpnXlWFonI3+C1ttRkv+DkWZ02rTkLpyKka6jRHv9dqg7x/yM0Eb
	3Nsscb9vkSMQx+O+ff0MqwsRR3+5er6Hyb6VeEyItICf5iJJCPbsuxX61xM1XJwF
	dMVsfvZRRchjOyutc6NRux2PpufaMvdVUoHyxatvplaCIvTKR0D+jueE1RflJXC6
	KhbNZSySYZK1EFRgQ+6SJEUzuKKXF0D8Gh7gkERSeRMlTDEVbxPaVkvBt4aoEENY
	M1aNP9kzB/cHshL7+Ymp08Pp/ux885LNO0/Y8wjc88RGQhXnPQ9bhR5PXriw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1737107778; x=1737194178; bh=iCC7Xk+pnBAIGSnmNi/mWbBEOfWP
	XnneZKYaYpksE/o=; b=RG3pLAM/IVUXuGnd0m2Kl7nhUfSDwAIw+ALqkBhOMIZ7
	FJtPoGpnUW67h/dqV23Ait2z5g2JiROQHKNDA5VIBuGioY/pB84rw7NA/ovihvII
	pDxjaNG4far4qMdhBghzNuLDQp/tu05XVRhSjETvQNzSap58/0pHQlkL+t0H7TEV
	oE045oLK9FN0SwJkZH6vis3TdxAY5hnRgrERKaMdIRpg5eaVER3yYo+cPd27Zfd9
	sWva6m1OZ0IBpS8ewAm5S/cdLz6NKb1p94i4FUfmZ7KwM7b/INQJkYojkJEvXzzK
	Bvar38atZY2RKZf7LYmuExlmTlO+y+YD9YZV4ZMhUQ==
X-ME-Sender: <xms:QimKZx8oWkU1VGhyuLS145_ApCX5BDIkt9ArytO-Fq_j0LHsyDlB0Q>
    <xme:QimKZ1sL-a2UENJ3Fji4yAAew9NJQbJRaq6iG7zFYuW4lJUkl-99U_TKbxMMU97S9
    SoEqSb7DEL4pWLMbQ>
X-ME-Received: <xmr:QimKZ_DvgSzDWTrDt98vXDReNoXGmzqhZqq0cJEnQL3huG4vhQgPrzPv-KS8LG-hZVc78ubJRS5r3REOzccP56LoQujV3zK9FRXqxGINRD6yTkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetie
    egjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghrghgrsehfrhgvvggsshgurd
    horhhg
X-ME-Proxy: <xmx:QimKZ1c1CEfN1OMjCkoJEFb3qs1TxBhP9Xi0JAXe975Gd3M_oN45Tg>
    <xmx:QimKZ2Ok4ngGngJst2kyzDycBoFDzJOZJmHdA93GdwOilgAjCAPt2w>
    <xmx:QimKZ3mMW_6qd9T0m9kKQ6uZKa6L3wy7jdifaiosak-DwBfWMf5b_Q>
    <xmx:QimKZwsXWW1iVVrYsR7PcepB7jWUD45CWZzxjLknUcvpfBq3MA5WGw>
    <xmx:QimKZ_a6alX8MeYZGt-lLy9SjY0ycwgxkNBGr-4JAwNunx1vAmbc_ZMN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 04:56:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2cc8c8fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jan 2025 09:56:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] contrib/subtree: doc fixes and support for Meson
Date: Fri, 17 Jan 2025 10:56:04 +0100
Message-Id: <20250117-b4-pks-build-subtree-v1-0-03c2ed6cc42e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADUpimcC/x3MwQpAQBCA4VfRnE3tsBKvIgfLLBOhHaTk3W2O3
 +H/H1AOwgp18kDgS1S2NYLSBPqpW0dGGaIhM1lhiEp0FvdZ0Z2yDKinOwIzUukrImtzazzEdA/
 s5f63Tfu+H00+W+dmAAAA
X-Change-ID: 20250117-b4-pks-build-subtree-17f91144340f
To: git@vger.kernel.org
Cc: Renato Botelho <garga@FreeBSD.org>
X-Mailer: b4 0.14.2

Hi,

this patch series fixes a broken build of documentation in
"contrib/subtree". While at it it also wires up support for the Meson
build system.

Thanks!

Patrick

---
Patrick Steinhardt (3):
      contrib/subtree: fix building docs
      meson: introduce build option for contrib
      meson: wire up the git-subtree(1) command

 contrib/meson.build         |  4 ++-
 contrib/subtree/.gitignore  |  2 ++
 contrib/subtree/Makefile    | 23 ++++++++++-----
 contrib/subtree/meson.build | 71 +++++++++++++++++++++++++++++++++++++++++++++
 meson.build                 |  3 +-
 meson_options.txt           |  2 ++
 6 files changed, 95 insertions(+), 10 deletions(-)


---
base-commit: 757161efcca150a9a96b312d9e780a071e601a03
change-id: 20250117-b4-pks-build-subtree-17f91144340f

