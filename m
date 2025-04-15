Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643B22820DA
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711039; cv=none; b=eiNsR/y5o/812WoFMlHGBpw9aJtyMMbV5YAUsZZ/YVVw+D1W7B9ibBkW61IMB5zQIWSD+1DtMVjbdhKmPf0LxOFBj2YrxOcl3KdCdEPmwbOfHVzWTEwtHnAqGNkGStqm8ex8pfr1d9aInl7rQx9MJ5L5FFXeCw4uuTNUsHa33Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711039; c=relaxed/simple;
	bh=PpaJvNChcxKY1xNgEkpidf6VZjf+7l52vmMbAWDqpGo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dxwuAvONdogTOsVcuAVeA0cM6rOUDFRnDOReHZyYJL6einNUGs++p8rGryfLdDcItfKnRBIZyvnx6a8QsUL1B6Yt7PV90edMzvDZeg0i0mGk6QFg+eu5lhL3wcyqncU2iudRMHTniPkXR/hIncClnki+cNkJlG8XZT+sDhI+CUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JR+mmKyo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X1Qb9NuU; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JR+mmKyo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X1Qb9NuU"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5CC412540091;
	Tue, 15 Apr 2025 05:57:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 15 Apr 2025 05:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1744711036; x=1744797436; bh=45If3rudfJ
	ClBnhGco3fLoI4N3OE9rWAysOBdkmXbsI=; b=JR+mmKyocvCENTQjKymgd6d9/4
	SmIJVR4Po+Nicl6ec/FbgsOcj1lMkxQSn19FeVxadNnJcoGBfA3Z9PQ3EySUaDL0
	JoMrNfJU8uGS5EVd934U9HOsp7EO96Omyv1inhaR6CqPOjSzTrSG0KQtKZ5l/R3c
	uxgP7iRoe0KyPLw6blLRZiCXqTKrpJ2ly5MLxBDd9/DJH4n2f+ZpAmqO0eNlLkGs
	N2UiCwfgwpnzIVWvWlmBul+S+sTr6cVICwKIruLlNAv+Ffr/xY0FEF/IqIKygwNa
	Wgzs542V947l9RPgg39xVzCIB9vbNYwEhKn+rvb4Tu+SN+MgS65+2aTMVcsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1744711036; x=1744797436; bh=45If3rudfJClBnhGco3fLoI4N3OE
	9rWAysOBdkmXbsI=; b=X1Qb9NuUPgwx5kCl7JZfwIZVnwuuDfyiXLBjDWw7IYi2
	k3eXw5+yGFRtksovSgH3Gerds2ee0gLgZgZjAIfJKYiZpgPSIFHj8poDhaDGKhi6
	Vf9VLRpRrZq7+9wAFUa5XVypJMY5p+/O0oc0p7jE/iVH1ddIcJgdnIZPQQGariMQ
	TygndnntaV6P083qpui19BX/FuxjBJ4mjpizYms7MyWxgzp4DJZqNYtiMK7S6STl
	4Fca0aK9W8xcZrMOxgVn/ZstCSQnd8pmpB8KhwuYjoOf6X9dY9wqxy1e47qwgPG2
	zbqwSqyEsX58IH22hPYTE0bKmoNx31O2/zhs1ATknQ==
X-ME-Sender: <xms:fC3-Z0pI43C4mfIc6SNvweyU8j34ot3GVAzmyEOddsfF5fggTbktlQ>
    <xme:fC3-Z6pf5lvr9-p-fP0hNd3TbpesccnMMPCeZqZQM4H2_v3JXHgeADOKPZyRpK-8m
    gpnRB0zlw4drn1zNg>
X-ME-Received: <xmr:fC3-Z5PPIa-9axnle_yoY0gJMsqAzBm9huzHZ_gyGULsVXG8cFmiey6_625wSVDv2Hq8M2K-TQgnbFi4wqCSXonMGFLaRJO1WlK-VvyIdKFPYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevueegkedtteeigeejueehuedugfevleefveehueeh
    gfetffffvefhuefhueekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:fC3-Z77fSgzO110zkGtmmG9zfTV2Rp7OMTZGfR1rq7wzmWO0MU6Ejg>
    <xmx:fC3-Zz68UcQZ6kBCFRPKsSdGfkyFZklDJIXzC7G14xgj6A6QctOjqw>
    <xmx:fC3-Z7h2-9OrYF7i4Br4-8jNZ5M1YicHJ2VI0dEe3doxGsQEPmcQPg>
    <xmx:fC3-Z95t-KL29_kTaZuECBVyvugJv3vScYCMn5OScJavpxRjV9YENw>
    <xmx:fC3-Z_MWuhI4PwlhvuPqqyNOWXQ_fbqHjrYqanxMEJRIZaPAisnpjXtE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:57:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 30814e16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:57:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] Drop Perl dependency in a couple of subsystems
Date: Tue, 15 Apr 2025 11:57:07 +0200
Message-Id: <20250415-b4-pks-drop-perl-v1-0-c6addf175858@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHMt/mcC/x3MTQqAIBBA4avIrBtQU6KuEi36mWooVEaIILp70
 vJbvPdAJmHK0KkHhC7OHEOBqRTM+xg2Ql6KwWrrtdMtTg7TkXGRmDCRnOgb5xtja0f1DCVLQiv
 f/7If3vcD28rjuWIAAAA=
X-Change-ID: 20250409-b4-pks-drop-perl-574571234e3c
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

Hi,

this patch series is a follow-up to my recent series that got rid of our
strict dependency on Perl for running our test suite [1]. The goal of it
is to remove the dependency on Perl in a couple more areas:

  - git-filter-branch(1)

  - git-request-pull(1)

  - Building our documentation.

With these converted you can get a fully-functioning Git distribution
with only a small handful of features missing:

  - gitweb.

  - Scripts to import repositories from GNU Arch, CVS and Subversion.

  - git-send-email.

  - Our Perl bindings, obviously.

  - The netrc credential helper from "contrib/".

None of these feel critical for day-to-day usage of Git, so Perl is now
a truly-optional dependency of Git.

The series is built on top of 485f5f86361 (The fourth batch, 2025-04-08)
with ps/test-wo-perl-prereq at 7a7b6022670 (t5703: refactor test to not
depend on Perl, 2025-04-03) merged into it.

Thanks!

Patrick

[1]: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>

---
Patrick Steinhardt (4):
      filter-branch: stop depending on Perl
      request-pull: stop depending on Perl
      Documentation: stop depending on Perl to massage user manual
      Documentation: stop depending on Perl to generate command list

 Documentation/Makefile      |   8 ++--
 Documentation/cmd-list.perl |  80 ----------------------------------
 Documentation/cmd-list.sh   | 104 ++++++++++++++++++++++++++++++++++++++++++++
 Documentation/fix-texi.perl |  15 -------
 Documentation/fix-texi.sh   |  21 +++++++++
 Documentation/meson.build   |   4 +-
 git-filter-branch.sh        |  37 ++++++++--------
 git-request-pull.sh         |  74 ++++++++++++++++---------------
 meson.build                 |   2 +-
 t/t5150-request-pull.sh     |   6 ---
 10 files changed, 191 insertions(+), 160 deletions(-)


---
base-commit: b09b3d4791ed248fed65de18cd6d8c084f7f0280
change-id: 20250409-b4-pks-drop-perl-574571234e3c

