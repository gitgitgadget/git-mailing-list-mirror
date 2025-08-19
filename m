Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86323F421
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591524; cv=none; b=d430mxCBvPRRtKZdVNs17L+jUn9KsRPqV6BXgN/BKJu/a/qqcCi4AmJ714upuHx8Ig54UBYEvRS2qY6nZN6TNO3jOn+SA34/AhLfGTfKycRQFALIXyH3HwIJ3tgxrjaaT3Zh04L2w75EFouMdwWrcN4voFwiqERu09F3+HqWNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591524; c=relaxed/simple;
	bh=8Sfe9zyWvz5Ltz9+XJq2mwbbCc+Dj6Z9PYUxt+8A4dY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PtqLvchcb2shCokkmQHwZ2yZCoF5bwBkhfhOTHIcR/Nka+QCL+ghyoe3RafqThio1oKSx6chekReg3virhDYVtnd+DODWL44MZwS7go29/TIFtUB9zDia/4Y5uXM2CZb2UUmvMyRTe/0KbkNDNrcyN68fF78su3mUu5TK1DKwSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PmJaS2gP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LlDRImQN; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PmJaS2gP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LlDRImQN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A1917A027D;
	Tue, 19 Aug 2025 04:18:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 19 Aug 2025 04:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1755591520; x=1755677920; bh=l8N+UV+b+B
	rpLcf/6ORp961edzMnjsQ0RoDB67aMXhA=; b=PmJaS2gP+Rhq82aD/GkZKfrCm0
	kMbjQ6XeupqauyahHYVH3RBdFlobdz876s1HPiERGy0AN/OzU+mkwS3EkLRUlp+E
	4H1Nnmyo0/dwlDbwzURyrBTCvP+0GpF+KDbErcIHV/ukVQAy7PfBy0x2rU+2Ai4F
	jIwcpZ5Id4DTo9qjlpYtatz1G+S/d2T/PdgNz4hYcaikId4ux4WNzRUTAf5dk6ZO
	SV5EcwFQv5t3cHlIKz5AK4yohgKszU4fYtVy+zeCDLw09PMtCeyhzV2g1Uhl8hSB
	Nu7vsr0zjnizRLn35O7y1o38JyIkMxlUAv11SPWMHSJss9hk2+XtIl4hyr1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1755591520; x=1755677920; bh=l8N+UV+b+BrpLcf/6ORp961edzMn
	jsQ0RoDB67aMXhA=; b=LlDRImQN2wIOa/VHzUYKR0anIYst85XHDQegXrgyFrSP
	SU3ld5QgYnoSymRA/fQAI0EmPauccTSWH6jBWE8AIp570twnnlws0+J0AB2vmXRl
	egaowq7VTaWX+ekV9HKJAo0ECRiWyrmajeXAeOoEqv1pRxwAZxfk/AwJ4D73ra4L
	AISbbHAfGwg6RuFW0CfhDRTlxRZrND52RD2pF/km0mxw/03o3+7Cf1KH+Iklk2B2
	REYATRCigWBaeVf5ukmKs7JlxgbVklDmC2TkZu04u33dPLJMk/sXtECZnEWKFWMR
	OOBGVsurq8vqxtSr/O6MhkspP9i9du6DSjAACyoD8A==
X-ME-Sender: <xms:YDOkaLlRQ2C0dZWvyrdu9opG1V0KDhrrxv0cOg87Tw5hy4GcNIC4Ng>
    <xme:YDOkaPD36nA7dRymLY0Hfpmoi9GGws0dnb0j-57sdjYx1bNZAlGS_SdeCIO8Uioxw
    YyJU8PVPhrEPzoPDg>
X-ME-Received: <xmr:YDOkaDd65we4iTvK3KE-UV29AidRZvhvDFFA0hdrGoQLc9aplMKRWjLfPj7QbSEM6ebzfwOS_Dcs5KmhxOvhSSq_YLBTS3r2Iqv0id10grSV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepheetiefhgeffgfevjedvheetffffhfduteehie
    evtdegffdvtdfhtdejgffhtdefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskhgusg
    hgrdhorhhg
X-ME-Proxy: <xmx:YDOkaCLx1pthga2Sw3bVex8fj_FgBny5Nd7vNXVr6BbP0hOR8jnYWA>
    <xmx:YDOkaOciGdxy5sTVJc6kjjjIJwjKgnJCbz33Up-w4auOmwc8S8hI-Q>
    <xmx:YDOkaB0ZmKY42Yac6d8NWFvyfjvfRh-e0oxuBHJ3zCaivPninv5Wbg>
    <xmx:YDOkaPi24JPJmW2-KGIrpVf5o69dxRUYtFG-IzxuT115PS_OCo2Hbg>
    <xmx:YDOkaJ102jy_fx5Wv_kQxgdI4HpB0Ldyazp7ImyXUOjcbOa1xLwR4c1u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 04:18:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c8766901 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 19 Aug 2025 08:18:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] meson: wire up gitk and git-gui
Date: Tue, 19 Aug 2025 10:18:34 +0200
Message-Id: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFozpGgC/x3MSwqAMAwA0auUrA20/vEq4sLWqEGt0ogI4t0tL
 t9i5gGhwCTQqAcCXSy8+wiTKHBz7ydCHqIh1WmhK52hzfFYBDeS3ePpVjwXtLYqSlO6Wuc1xPI
 INPL9X9vufT/PyX41ZQAAAA==
X-Change-ID: 20250703-b4-pks-meson-tcl-tk-bb75616c8048
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

Hi,

I have upstreamed support for Meson into both gitk [1] and git-gui [2].
This small patch series wires up support in Git.

To the best of my knowledge this is the last missing piece for feature
compatibility with our Makefile. As such, from my point of view, I think
that we can stop treating the Meson build system as experimental and
instead officially endorse it. Once merged I'll thus send another patch
series that updates our documentation in various different places to
also mention how to build Git with Meson.

Thanks!

Patrick

[1]: https://github.com/j6t/gitk/pull/8
[2]: https://github.com/j6t/git-gui/pull/9

---
Patrick Steinhardt (3):
      git-gui: move into "subprojects/"
      gitk: move into "subprojects/"
      meson: wire up gitk and git-gui

 Documentation/SubmittingPatches                       |   4 ++--
 Documentation/gitk.adoc                               |   2 +-
 Makefile                                              |  18 +++++++++---------
 meson.build                                           |  14 ++++++++++++++
 meson_options.txt                                     |   4 ++++
 subprojects/.gitignore                                |   2 ++
 {git-gui => subprojects/git-gui}/.gitattributes       |   0
 {git-gui => subprojects/git-gui}/.gitignore           |   0
 .../git-gui}/GIT-GUI-BUILD-OPTIONS.in                 |   0
 {git-gui => subprojects/git-gui}/GIT-VERSION-GEN      |   0
 {git-gui => subprojects/git-gui}/Makefile             |   0
 {git-gui => subprojects/git-gui}/README.md            |   0
 {git-gui => subprojects/git-gui}/generate-git-gui.sh  |   0
 {git-gui => subprojects/git-gui}/generate-script.sh   |   0
 {git-gui => subprojects/git-gui}/generate-tclindex.sh |   0
 {git-gui => subprojects/git-gui}/git-gui--askpass.sh  |   0
 {git-gui => subprojects/git-gui}/git-gui.sh           |   0
 {git-gui => subprojects/git-gui}/lib/about.tcl        |   0
 {git-gui => subprojects/git-gui}/lib/blame.tcl        |   0
 {git-gui => subprojects/git-gui}/lib/branch.tcl       |   0
 .../git-gui}/lib/branch_checkout.tcl                  |   0
 .../git-gui}/lib/branch_create.tcl                    |   0
 .../git-gui}/lib/branch_delete.tcl                    |   0
 .../git-gui}/lib/branch_rename.tcl                    |   0
 {git-gui => subprojects/git-gui}/lib/browser.tcl      |   0
 {git-gui => subprojects/git-gui}/lib/checkout_op.tcl  |   0
 {git-gui => subprojects/git-gui}/lib/choose_font.tcl  |   0
 .../git-gui}/lib/choose_repository.tcl                |   0
 {git-gui => subprojects/git-gui}/lib/choose_rev.tcl   |   0
 {git-gui => subprojects/git-gui}/lib/chord.tcl        |   0
 {git-gui => subprojects/git-gui}/lib/class.tcl        |   0
 {git-gui => subprojects/git-gui}/lib/commit.tcl       |   0
 {git-gui => subprojects/git-gui}/lib/console.tcl      |   0
 {git-gui => subprojects/git-gui}/lib/database.tcl     |   0
 {git-gui => subprojects/git-gui}/lib/date.tcl         |   0
 {git-gui => subprojects/git-gui}/lib/diff.tcl         |   0
 {git-gui => subprojects/git-gui}/lib/encoding.tcl     |   0
 {git-gui => subprojects/git-gui}/lib/error.tcl        |   0
 {git-gui => subprojects/git-gui}/lib/git-gui.ico      | Bin
 {git-gui => subprojects/git-gui}/lib/index.tcl        |   0
 {git-gui => subprojects/git-gui}/lib/line.tcl         |   0
 {git-gui => subprojects/git-gui}/lib/logo.tcl         |   0
 {git-gui => subprojects/git-gui}/lib/merge.tcl        |   0
 {git-gui => subprojects/git-gui}/lib/mergetool.tcl    |   0
 {git-gui => subprojects/git-gui}/lib/meson.build      |   0
 {git-gui => subprojects/git-gui}/lib/option.tcl       |   0
 {git-gui => subprojects/git-gui}/lib/remote.tcl       |   0
 {git-gui => subprojects/git-gui}/lib/remote_add.tcl   |   0
 .../git-gui}/lib/remote_branch_delete.tcl             |   0
 {git-gui => subprojects/git-gui}/lib/search.tcl       |   0
 {git-gui => subprojects/git-gui}/lib/shortcut.tcl     |   0
 {git-gui => subprojects/git-gui}/lib/spellcheck.tcl   |   0
 {git-gui => subprojects/git-gui}/lib/sshkey.tcl       |   0
 {git-gui => subprojects/git-gui}/lib/status_bar.tcl   |   0
 {git-gui => subprojects/git-gui}/lib/themed.tcl       |   0
 {git-gui => subprojects/git-gui}/lib/tools.tcl        |   0
 {git-gui => subprojects/git-gui}/lib/tools_dlg.tcl    |   0
 {git-gui => subprojects/git-gui}/lib/transport.tcl    |   0
 {git-gui => subprojects/git-gui}/lib/win32.tcl        |   0
 .../git-gui}/lib/win32_shortcut.js                    |   0
 {git-gui => subprojects/git-gui}/meson.build          |   0
 {git-gui => subprojects/git-gui}/po/.gitignore        |   0
 {git-gui => subprojects/git-gui}/po/README            |   0
 {git-gui => subprojects/git-gui}/po/bg.po             |   0
 {git-gui => subprojects/git-gui}/po/de.po             |   0
 {git-gui => subprojects/git-gui}/po/el.po             |   0
 {git-gui => subprojects/git-gui}/po/fr.po             |   0
 {git-gui => subprojects/git-gui}/po/glossary/Makefile |   0
 {git-gui => subprojects/git-gui}/po/glossary/bg.po    |   0
 {git-gui => subprojects/git-gui}/po/glossary/de.po    |   0
 {git-gui => subprojects/git-gui}/po/glossary/el.po    |   0
 {git-gui => subprojects/git-gui}/po/glossary/fr.po    |   0
 .../git-gui}/po/glossary/git-gui-glossary.pot         |   0
 .../git-gui}/po/glossary/git-gui-glossary.txt         |   0
 {git-gui => subprojects/git-gui}/po/glossary/it.po    |   0
 {git-gui => subprojects/git-gui}/po/glossary/pt_br.po |   0
 {git-gui => subprojects/git-gui}/po/glossary/pt_pt.po |   0
 .../git-gui}/po/glossary/txt-to-pot.sh                |   0
 {git-gui => subprojects/git-gui}/po/glossary/zh_cn.po |   0
 {git-gui => subprojects/git-gui}/po/hu.po             |   0
 {git-gui => subprojects/git-gui}/po/it.po             |   0
 {git-gui => subprojects/git-gui}/po/ja.po             |   0
 {git-gui => subprojects/git-gui}/po/meson.build       |   0
 {git-gui => subprojects/git-gui}/po/nb.po             |   0
 {git-gui => subprojects/git-gui}/po/po2msg.sh         |   0
 {git-gui => subprojects/git-gui}/po/pt_br.po          |   0
 {git-gui => subprojects/git-gui}/po/pt_pt.po          |   0
 {git-gui => subprojects/git-gui}/po/ru.po             |   0
 {git-gui => subprojects/git-gui}/po/sv.po             |   0
 {git-gui => subprojects/git-gui}/po/vi.po             |   0
 {git-gui => subprojects/git-gui}/po/zh_cn.po          |   0
 {git-gui => subprojects/git-gui}/windows/git-gui.sh   |   0
 {gitk-git => subprojects/gitk}/.gitignore             |   0
 {gitk-git => subprojects/gitk}/Makefile               |   0
 {gitk-git => subprojects/gitk}/generate-tcl.sh        |   0
 {gitk-git => subprojects/gitk}/gitk                   |   0
 {gitk-git => subprojects/gitk}/meson.build            |   0
 {gitk-git => subprojects/gitk}/po/.gitignore          |   0
 {gitk-git => subprojects/gitk}/po/bg.po               |   0
 {gitk-git => subprojects/gitk}/po/ca.po               |   0
 {gitk-git => subprojects/gitk}/po/de.po               |   0
 {gitk-git => subprojects/gitk}/po/es.po               |   0
 {gitk-git => subprojects/gitk}/po/fr.po               |   0
 {gitk-git => subprojects/gitk}/po/hu.po               |   0
 {gitk-git => subprojects/gitk}/po/it.po               |   0
 {gitk-git => subprojects/gitk}/po/ja.po               |   0
 {gitk-git => subprojects/gitk}/po/meson.build         |   0
 {gitk-git => subprojects/gitk}/po/po2msg.sh           |   0
 {gitk-git => subprojects/gitk}/po/pt_br.po            |   0
 {gitk-git => subprojects/gitk}/po/pt_pt.po            |   0
 {gitk-git => subprojects/gitk}/po/ru.po               |   0
 {gitk-git => subprojects/gitk}/po/sv.po               |   0
 {gitk-git => subprojects/gitk}/po/ta.po               |   0
 {gitk-git => subprojects/gitk}/po/vi.po               |   0
 {gitk-git => subprojects/gitk}/po/zh_cn.po            |   0
 115 files changed, 32 insertions(+), 12 deletions(-)


---
base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
change-id: 20250703-b4-pks-meson-tcl-tk-bb75616c8048

