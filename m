Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370A81CA84
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740843375; cv=none; b=OKYSF+vbSUYwZCy2Bu9eHolrzLyTxKM7kr3o4Hpv2viStl7aqn/5MRyzo5Rz76rLjbfiORw7hBL7u3NfAmo+M2/Vmqh2YX1WaNucA5BG2QnDDuonoPZmW37XaquVVrbmYaY6i7Kp3g8vsmbL92u7JnYyGPpXn1u6a6teDdBjnjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740843375; c=relaxed/simple;
	bh=K9Dddfzoe4a6wZYX/e8/glSLUU5dsxOfRg9Z5JQxx4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yq0PujfEMYKg05x0g5f6u71JVST6XFkQZ37peclJrF52j2xnILS3PK9uNH4QQvqmQ0p7oUsP5rjuGPM63ucsNahBv3+ZS4uFgqwzKMgr3iY8MjdPdTRFG2ag9CoaRw2E7OBj2Rh1f4OJj8A20Jjl2okrpGJugNtywsRYBf+CvBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h1/MCn3/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TwaztJ8p; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h1/MCn3/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TwaztJ8p"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2BF172540160;
	Sat,  1 Mar 2025 10:36:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Sat, 01 Mar 2025 10:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1740843372; x=
	1740929772; bh=N5YNyJULQoz/8OdT1kIzP1U/dIyvD2gt1RSSlAy6fhY=; b=h
	1/MCn3/v1kwYRSYKU1P16/DaYIHdlHESQEwqYbmC2EJrT0Rg6VD+Z75dyWByfEKj
	BjG1v2qmXLpVs6JZk9AuWcmSENuJwAtmMXSePCXGCTFHgvwA9+bVMtFRjx0RGa7H
	MiOPC5FFtNHhHWvtLprCieQxa/xKV80jFiM5LM49TPtowUzhihTc/ksHrK1uljcE
	y+J5HNnFhiZ23JgpFVL2/245wC4Yzc5jN1ioZFZa4UatyfPaSMUzXnmFtvhSSHhx
	ZxTyKQQANJDGriSziiZaiXCvL+yDojqEbJW0N5EWOvtuzACT8qgwsu2HDZv2ISSL
	dVejydjN+t1ePxBy3Mcqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740843372; x=1740929772; bh=N
	5YNyJULQoz/8OdT1kIzP1U/dIyvD2gt1RSSlAy6fhY=; b=TwaztJ8pOqUo0ZayL
	ljcY5qoQM9PVZkE1ddhV8DaaiAqxIrfDcZ2ZEilD/xaAsYDLv2n4wW7YXFoC8hSo
	yLdOJjLnotszJbA5ssEgEB0bZiorknJhSKUxLTVrJ8UyfQ+VOzjAGUHUhHAQujP1
	ZcXNaUNVffJVzVCk5f9Rxl3LZy9HQ32fjvHgCKGUY+Ul8Ub0jt1IdWRghudoQ5Zb
	Bdnd6y+0tk2Ov/5cupVQNJcKj+LVXqIt6G9EHYWjegA3OqnF0G2EIiU4anYZHwuA
	ULlYOeUqJ+GHrZyfHPX09syqgBhXSagHXUIq1qYGvMOKNf2KJcYPSPhgJTBuPmqQ
	Add1Q==
X-ME-Sender: <xms:aynDZ0fjQFfD_6JTMkqg5RFy8TOcMwal8H0Z00zrqUir4I8SEPUBCg>
    <xme:aynDZ2OrPNILxloKOLjOYN-OWhiAgGHCF_u8hPH6pgJm2dAfp511fACCTAzk7AYdw
    3EvvG0pLdeELW2ANQ>
X-ME-Received: <xmr:aynDZ1hDdNYmIMKnGsgHKNu8LgAC-iQKYfnPq0d13UgeJQIBEiJ3NYLSKKxj2VxBxyg9YKWDKj6y8fof7xeYPIAF0vY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelfeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedvgeelgeehhffgvdeutefgteekffefhfegveekteev
    tdevleehhffhheefgfdujeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthh
    husgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsrghnuggrlhhssegtrhhush
    hthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:aynDZ58oBW5pQ6ZuEc8vKk2NCqcGDpcjr_qc4rGshKI65S62MwSd_g>
    <xmx:aynDZwvqiAt-MLF40Aji3Hif5goQLqx_85r7CLEinD31uZ_psWflnA>
    <xmx:aynDZwElnLi5SS2FzqmJBVc3XGL1MvI4Bx-NEez7-JvD7kjywvTVVg>
    <xmx:aynDZ_M4RFFMwEkvl2hrh1YBKhl9e9A_NIj-EQv81aRcB9ABBNsfpw>
    <xmx:bCnDZyLTOlbE4PMsp5MHNbCTK-bglm8FgHO8vySyG-tNjvnVgDuVlOKx>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Mar 2025 10:36:11 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] doc: txt -> adoc fixes
Date: Sat,  1 Mar 2025 10:36:01 -0500
Message-ID: <20250301153607.95746-1-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250228034713.203461-1-tmz@pobox.com>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is now based on ps/meson-contrib-bits.

Changes in v2:
  - build on ps/meson-contrib-bits
  - include changes to contrib/contacts/meson.build

v1: https://lore.kernel.org/git/20250228034713.203461-1-tmz@pobox.com/
CI: https://github.com/tmzullinger/git/actions/runs/13605720163

Todd Zullinger (3):
  doc: update howto-index.sh for .adoc extensions
  contrib/contacts: rename .txt to .adoc
  contrib/subtree: rename .txt to .adoc

 Documentation/howto/howto-index.sh                 | 14 +++++++-------
 contrib/contacts/Makefile                          |  2 +-
 .../{git-contacts.txt => git-contacts.adoc}        |  0
 contrib/contacts/meson.build                       |  4 ++--
 contrib/subtree/Makefile                           |  2 +-
 .../subtree/{git-subtree.txt => git-subtree.adoc}  |  0
 contrib/subtree/meson.build                        |  4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)
 rename contrib/contacts/{git-contacts.txt => git-contacts.adoc} (100%)
 rename contrib/subtree/{git-subtree.txt => git-subtree.adoc} (100%)

-- 
2.49.0.rc0
