Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1C534EF1F
	for <git@vger.kernel.org>; Thu, 21 May 2026 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349361; cv=none; b=ESDcy7XH86egf9M2z3E/jEomkQh8venTgu67CLQ8oqjF5+rqUENA1dUt48m8ezuFpn6N3VluXf9pgdFAwtJ/ZK8ixRaODCvHAvYiclgmni1Cb4D8czj0Icnn6a/wf4GQGeb6GCZzwqJvoHkyXSjS+l5UGCYGbme3cIjIjju58r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349361; c=relaxed/simple;
	bh=xm4y69mOjWLpdwMsAGip65x1LqZDiCVxo+yq6IyOQi4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RLfQKJ+vTJR9cDnmFhbRwrheK7IkNCd/HTW+OsfqG7CNc5v2UV1avOe94SmC0Mbea51DvVfR+Pl5moKItw7iROmn9Xm9McSsYqSsbT0oVW8WW+saZyTpqbEoCAwM4OZyIfKOof7LfgWeEfJ5Gw9AWnPQJ8iK37V761VOh5t7WsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F1xnCzUi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ozrj38sL; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F1xnCzUi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ozrj38sL"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB39D140006C
	for <git@vger.kernel.org>; Thu, 21 May 2026 03:42:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 21 May 2026 03:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1779349358; x=1779435758; bh=OZoHOPB4R1
	3lvD/CG5WRaR7oWUYAFzeZs3m6ySg92u8=; b=F1xnCzUi3BpljCs8ECPLHfDvlj
	hw/8x0ANzFooGslJzzlQwkHPReP+WoORnnY5UC4PQMoNQU0IDvC2SSDvTPX7/1iu
	IXmX5JnSp8O8A7R1NySicd/oqOUEwHIR7kALofNqXRbfyh7Xfjs6pE9MIUCHjgZU
	zICYioaaiNCgDrmV8HKLOjotqKEZyK3PjSEGFiObMdVENHMVs6bH9zAAzHo2DrVU
	2PYmTQJ/R52pUpdmHQs3l2xXm2ZtvAdcpo/GWf24o4Fx7Iamdbr9u0w+IXZlDREM
	a0dtJaTUoAxJ8bEkLi4Nqj/Jinycklrd+wAcq4R43/zO1A4DvmNokkoG51ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1779349358; x=1779435758; bh=OZoHOPB4R13lvD/CG5WRaR7oWUYA
	FzeZs3m6ySg92u8=; b=Ozrj38sL290EiGnV+AZDQfbKBmZGvQC84cmbYsWmISRC
	I+zqesdwPh7loHAdFxQKM9lw2+/Fm/NPcW21HiJgDVAc84xWok6eVBiWeK9azjvN
	RkbZA4qwP6/qU28U/P9AO5vVZhMbw2ADdnjhbNu3t5Mo2Gq4vDFbTRwGCIrEgwxu
	CosDPubiSiXqYcyP0RGHRwLfgdbd74r2T2XL+UoNDueUYBChe3JV861Sxs42d953
	6zeSielcr2awyYTQWAzBbIyhjyUOxmqPrVTyNve1vlF5yOsj/v1/oWXUMEbcJ5Kr
	Ud1YEyGCpG4VtoEvmwH0LJBMQrgupjmGSmxmCPoStg==
X-ME-Sender: <xms:brcOar95efhqNx6l7cK891bm62SSHAkLrOJkmhV02Rf1GFhzggyf4A>
    <xme:brcOauqEznP7OxOVOV-8KEQ1yW8h5stmM3svmALyN9nGjZHqNk2TBF_orhkLUzJO6
    HZ5rhwrAIRnFn5IkEKGYemWZ6lLx0bdJeO40C9tR8DjwTMc3MS8krk>
X-ME-Received: <xmr:brcOauo-M8oIaWJGQHFBF8S15NNC1nOmliQDHm7zuQgBsHhnmxRRJj4-sXa6lJSDOwfjidQcFrxJl__mvNPg_fc8vNKiq-IHdVvjjYKNYtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeileegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:brcOasmGhXar_8TV35qSMoRXjeagl4u4XLc6LCIycEkLQcu32jr2OQ>
    <xmx:brcOagHvY54j32s0bThqASduNkKcsNmdEMRuMTZI3kZdVaweIYXPYA>
    <xmx:brcOalqW3i0P8VUYbLEa3hAVJbG_gu0znNfUF-BsmVJ-xsvFBaAqCQ>
    <xmx:brcOas7p0ThET1SQdaOocCvGeFiA42AH6KRO-4NYevvKNDi-5tflkw>
    <xmx:brcOansa_ffrovzi6KaIkVYGOPR47IsBpbj17HAJ6uazAME7TmDzJG2d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 03:42:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71b43068 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 07:42:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] setup: centralize object database creation
Date: Thu, 21 May 2026 09:42:27 +0200
Message-Id: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGO3DmoC/yXNSQ7CMAxA0atUXmOp6QAqV0EsMrhgQGlkp6hq1
 bsTYPk372+gJEwK52oDoTcrT7GEOVTg7zbeCDmUhqZujnVvBnQdpqeiUp4TeopZ7ItXwik49EI
 2FwDb7jT4vh2dMQEKlYRGXn6by/XfOrsH+fy1Yd8/d+Pan4gAAAA=
X-Change-ID: 20260519-b4-pks-setup-centralize-odb-creation-3479c53fb11d
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this small patch series refactors the logic for how we discover and
configure repositories. Most importantly, this involves the following
two steps:

  1. We unify the logic to apply the repository format, which is
     currently open-coded across multiple sites. These sites have
     already diverged, where some repository extensions are not
     consistently applied.

  2. We then centralize creation of the object database to happen at the
     same time we apply the repository format.

The end result is that we apply the repository format exactly once, and
that's also the point in time where we can finalize the setup of the
repo's data structures as we know about all details of the repo at that
time. Ultimately, this makes it trivial to introduce the "objectStorage"
extension, even though that's not part of this patch series.

The series is built on top of aec3f58750 (Sync with 'maint', 2026-05-21)
with ps/setup-wo-the-repository at df69f40c34 (setup: stop using
`the_repository` in `init_db()`, 2026-05-19) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (8):
      t0001: plug test gaps for git-init(1) with GIT_OBJECT_DIRECTORY
      setup: drop `setup_git_env()`
      setup: deduplicate logic to apply repository format
      repository: stop initializing the object database in `repo_set_gitdir()`
      setup: stop creating the object database in `setup_git_env()`
      setup: stop initializing object database without repository
      repository: stop reading loose object map twice on repo init
      setup: construct object database in `apply_repository_format()`

 commit-graph.c  |   4 +-
 environment.h   |   8 +---
 refs.c          |   3 +-
 repository.c    |  40 +++++------------
 repository.h    |   3 --
 setup.c         | 130 +++++++++++++++++++++++++++++++-------------------------
 setup.h         |  19 +++++++++
 t/t0001-init.sh |  10 +++++
 8 files changed, 117 insertions(+), 100 deletions(-)


---
base-commit: 3398daa441965513c48744305d33bd36404547d6
change-id: 20260519-b4-pks-setup-centralize-odb-creation-3479c53fb11d

