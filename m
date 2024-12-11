Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0AE1EC4FE
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914616; cv=none; b=CfZI5GOGzThRTREchzmf2TwkTlUDj+sfU40JMG4PtqRfUCcg8Aui/Z8u8gNlRCVxUzRNj+Cp9c0ZBjyQtKfHsYoYd8eW29l/p87UZEcSl4lsjRzoc7tg0EafNF4q9ukQoWqWklLVSL2oENlSfvsq/B07+DUpSEHBuXEFxUgloms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914616; c=relaxed/simple;
	bh=+pq9EOTUlVnmzqEqJa1KxwECyhmHkK7eneOXsuyOYSc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GxVZkRx/sekYPcLWN9KJsiozWIk+1HGKGsOM3mXAMZ49WIvf3Eklp1Bdf5k3L4QZFHlDvH2j2DBgZ5t0kNPrxdRwW7Cm5ew4y79GZNfHMIm1pabI2/rZc8zhvnup6VDHIxiOyhew9qM47st5DklNCajUktP4zaZP6F3GnmHcQLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KS6FIZkd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dCQttyIa; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KS6FIZkd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dCQttyIa"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id E071C1140212
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 05:56:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 11 Dec 2024 05:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1733914613; x=1734001013; bh=6q7Lly3SAG
	cSGCwq0mXuEDT0oQxkyY04fZjj0GKcRwM=; b=KS6FIZkdz4EFIwpVBPobEqsoWW
	n/M6vzNmAH6GzTgpqwrChg6yIFMBoi4FjFlA4iFiM29QwWge1+5yqZH33nw7Eup6
	Zor+syIxDA+9vEMFvGK0N0GmKUr9Dmq7crWjiUhPfnFWufosvj0ryjcMEiWptt/e
	1mmM2Nd6EAhpH4XPf+1q3YyHZfZrn2oNEXoXWRgbzQI4BDeYYYjzEv57Hal5H0ch
	VeOjrcE8nCnpXXOt6kpZqBjg734fnsUMjlqtuNMryZcbIvopWW9OxZg6VTz1psyI
	c7B2pUbOO/3Ua6BhX/zhLFb/NYF4G0+FvrXYYW0eenC7SUjkiMHHj5sx28yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1733914613; x=1734001013; bh=6q7Lly3SAGcSGCwq0mXuEDT0oQxk
	yY04fZjj0GKcRwM=; b=dCQttyIaO+J9/0jADKz74B3OJihEZKwNdsY6dNfGbezu
	fE1csRx0GCIiwrR9iwARFyJOuElaGdV8/TfCoUSWnA8zO2+Vc99T+t+GBnKa5Bdi
	FJ0871VqjjIqVHiW+kL6B1KUpk0BSJuyi662uYr0/73YfiAdM1wJVVJMNvPk5LUy
	g8Js0fJ8Fr+fs4FsqasP9/MeQjNUZw8KTaoys+PWCvQeDNDbjlH+X0osORUSTECj
	MICnxIegHQDOWQCzeGarhlFUFgtqjCWxt8O+J/iuxVtXgBDhzJTTBsuHnkaOc4t+
	0q11qj36xSlO43syx3CfbeXSNwU1WfiUYxAF73EkqA==
X-ME-Sender: <xms:9W9ZZw4jltCaQ5oG-B41E2N-OexDMSaShuCP9C5VkMOe1wfVi3VZOA>
    <xme:9W9ZZx6dSXC6LXCNe-uN81lg5uLY5pQagzrUmbMLUlQlRyniSQnDM-MUczU10Bv2G
    cOTDiADK1nQcHTJYw>
X-ME-Received: <xmr:9W9ZZ_cxicUvlQ4EygG3BR-J0JsTGGOGf44zmsWxE0z3QojhMH8jxQKWxLUUL33Ikl2FVsBQBfE6MHE7WYIEk-1J_0QLIWtExmIvo6Hrsw2I7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffufffkgg
    gtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevueegkedtteeige
    ejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9W9ZZ1Kc5eTWL2CMthC2zUC_Rzo6qkAyDklZ5eyzCyxEhXQjAL82iA>
    <xmx:9W9ZZ0L_EDTWBFlkMxEqvyaBmO9KUGV5RMIbRzoIgiD0C5Eas_otJA>
    <xmx:9W9ZZ2yXUH51cYBlIdunSFAZcRulvJVnASgED4DVFtNS7k7Nosj5Fw>
    <xmx:9W9ZZ4ISieJddLTRW3Wa8ScokWlOsOEWRGVIOcSZ7ORwQUUGCSg5kA>
    <xmx:9W9ZZ-gf4b74BIWEPuahMlhpKoOW2jNFc_caNglfL9xDRCCvUZSgxjKP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 11 Dec 2024 05:56:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 94b19929 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 11 Dec 2024 10:55:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/5] remote: announce removal of "branches/" and "remotes/"
Date: Wed, 11 Dec 2024 11:56:36 +0100
Message-Id: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAORvWWcC/y2NwQrCMBBEf6Xs2YU0qUT9FfGwTVcbxLTuRhFK/
 72LenwzzLwFlCWzwqlZQPidNU/FoN01kEYqN8Y8GIN3vmu92+N8VxR+TJWxFyppZMWBZ+FE1bb
 oQqQuHI4UYgR7seaaP1/D+fJj4efLRPUfrusGUO1NgYYAAAA=
X-Change-ID: 20241205-pks-remote-branches-deprecation-037a4389a377
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

back when Git was in its infancy, remotes were configured via separate
files in "branches/" (back in 2005). This mechanism was replaced later
that year with the "remotes/" directory. These mechanism have evenutally
been replaced by config-based remotes, and it is very unlikely that
anybody still uses these directories to configure their remotes. Both of
these directories have been marked as deprecated, one in 2005 and the
other one in 2011.

This patch series follows through with the deprecation of these and
announces them for removal in Git 3.0. Furthermore, it creates the infra
to compile Git with such breaking changes enabled and wires up a CI job
both for GitHub and GitLab to test those breaking changes.

The series is based on top caacdb5dfd (The fifteenth batch, 2024-12-10)
with ps/build at 904339edbd (Introduce support for the Meson build
system, 2024-12-06) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (5):
      Makefile: wire up build option for deprecated features
      ci: merge linux-gcc-default into linux-gcc
      ci: repurpose "linux-gcc" job for deprecations
      builtin/pack-redundant: remove subcommand with breaking changes
      remote: announce removal of "branches/" and "remotes/"

 .github/workflows/main.yml             |  6 +----
 .gitlab-ci.yml                         |  6 +----
 Documentation/BreakingChanges.txt      | 25 ++++++++++++++++++
 Documentation/gitrepository-layout.txt |  7 +++--
 GIT-BUILD-OPTIONS.in                   |  1 +
 Makefile                               |  7 +++++
 builtin/remote.c                       |  2 ++
 ci/lib.sh                              |  5 ----
 ci/run-build-and-tests.sh              |  3 ++-
 contrib/buildsystems/CMakeLists.txt    |  1 +
 git.c                                  |  2 ++
 meson.build                            |  6 +++++
 meson_options.txt                      |  2 ++
 remote.c                               |  6 +++++
 remote.h                               |  2 ++
 t/t5323-pack-redundant.sh              |  6 +++++
 t/t5505-remote.sh                      |  6 ++---
 t/t5510-fetch.sh                       | 13 ++++------
 t/t5515-fetch-merge-logic.sh           | 47 ++++++++++++++++++----------------
 t/t5516-fetch-push.sh                  | 14 +++++-----
 t/test-lib.sh                          |  4 +++
 21 files changed, 112 insertions(+), 59 deletions(-)


---
base-commit: 713ec79a9091cec60b110d605b418904759982ab
change-id: 20241205-pks-remote-branches-deprecation-037a4389a377

