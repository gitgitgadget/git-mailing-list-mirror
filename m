Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355091EE7C6
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253054; cv=none; b=bWZvM2azJGSvW3iqTgNEMkuxPpfaBr70PmdfoCMk3186Cui5EFJI50Fv5nUUC/843KS5H/FMOO8qGw7TdkLG+jogEDPOkA678t9bxpVYiHsE6BE27RpeZjBzWpx/TG8hyl8omUctyRk3U33cllXele4jS4tAXBPwuXnZSh+eSc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253054; c=relaxed/simple;
	bh=xOVSBUQOxKXto+o0XpMmBcox6kfy/lJcQeByQrBFybA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=r1fz1frI8pNy4BEclpjhnHpiliwCTCMHXloKgKluEbcDEjvbIals4L2YUAJHdm5HUFYguFZQhu3B0ZZGsYmEtg9ZOZX5dWFZYEpkmq9MwZSpeHHQWw2hxHEBxE3XHHAJ2xHSR/UIT698YIHK+mMgSNlV/2DwzQ+PrzWv8fpSG3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pSQsllS9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ai2IOj1j; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pSQsllS9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ai2IOj1j"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE8631140109;
	Tue,  7 Jan 2025 07:30:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 07 Jan 2025 07:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736253047;
	 x=1736339447; bh=sMa+M1+P5Xg/P3nHXRATKClumAyk9WFC/FX38S5l8g0=; b=
	pSQsllS9/fiBhXX78lyODFmG5PatjI23fuiLwQUINNAbo7hQdz+71vpJ5Cfekj6W
	zJEikT8YVmKLFE3ftW++Cumb2BatCwXjmEfD+44z853ZZoTqKTYt4uWgMV7hMs9B
	yCG7UB+JQeHJ6EI8N8B+DNzYeZJZWTePA57s5gctiBuWS/mIz/UHU6Ib6T1QFbGd
	gDHQxE/xFhvo25eVZcend4sKHisZCS8i4o9RKVLK8SYD/uKfXT+aX8ZGO35pY6zx
	kDAUg0pytbcUQiy4P62trkGHjD12n2MTlWJQsARn1qrBZMJBGN77rG+gsOXIa7rq
	uZkeHxria1aod+scEAI6LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736253047; x=
	1736339447; bh=sMa+M1+P5Xg/P3nHXRATKClumAyk9WFC/FX38S5l8g0=; b=a
	i2IOj1jaJtgp/mBpElYMj8Rq1ds2lfmoU08DK/HJBkSih3AZzFrMz67e3AHW1Q/F
	veJh/5bMOBASwCFFtkBTWWFeHIKfltv50renll4cU5zS0QSJaeS3zCr5/XlBScrY
	bGuXEbfEyh/w9UYag0rUcflXXXndz9G4LuWOEoPTow7dyN3vWiwqEXiG8ndH6g3t
	sXWzj867gOe5YZZxHxAmQFR+cwiUpK3/1vD9ORErPSpaZrjpmqWMSS2ZnEtoim7G
	603/ao6U98qldcosKPP+BZoGo/Yg4DGo6i6D5JUS8UPCWY+Y2hE8pkSZZDFX8RXC
	1VQlhAuMOkZg0+1XY7Gog==
X-ME-Sender: <xms:dx59ZwSi4Itd0h6HoXp1YHYcRTmYnDnMn_dktBRX07P1-bgaSaFzBg>
    <xme:dx59Z9yv2nv-NvDTALQi6C9WNY3zGgkPJYXKbLagpo_gHGbgAk7GAlv8w9DAXOCRs
    JTEFOMqmWzsTvq9sQ>
X-ME-Received: <xmr:dx59Z93gTBRm_KXzULwaXOsiHSl-pWgFsVYHEmyN9Tt05IWLbNILAcPcQDXudEA5Twk4cyyhULbrtpPb2RWLM61H-LuGxKugLYVu3JJx28Ek6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevjeefheeggeeljeduffetveehgfeiueehgffgudff
    ffffgeeifeetveejleeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtlh
    grsgdrtghomhdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepge
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohgusegu
    uhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:dx59Z0C4Ye0EfeIWFYk7UepFiUwq2ImC0-yOWBn4VcYU9dm-ZsDBxQ>
    <xmx:dx59Z5i3aHVIpv2JaC26hbt74l_bWJ6K-hPl2wL1ux5UIyi9KMiKDg>
    <xmx:dx59ZwpYj6OOVGycNtYX2cze3tK3lYDEooxDxmgfHA5IfXusAll7jw>
    <xmx:dx59Z8gJ97Qypr9TkdRTUNX8I2Fnvn9sY76uJ0Qm0GfUddAHG8wKCQ>
    <xmx:dx59Z5cJxblGBQ4K1KewXhZZSMe43y5QUbxTmPFGaf8AZYTFp9rFm0-V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 07:30:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ca6fa569 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 12:30:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/10] A couple of CI improvements
Date: Tue, 07 Jan 2025 13:30:42 +0100
Message-Id: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHIefWcC/3XNTQ6CMBAF4KuQrh3TH0qBlfcwLlpoZWIE0ppGQ
 7i7AwtjYly+efneLCz5iD6xtlhY9BkTTiMFdShYN9jx6gF7ykxyqbngClwJ8y1BhxDw6RPInlu
 pgtOdqRmpOfq9IHS+UB4wPab42h9ksV3/b2UBHGzjXKP7EGqlTlQf8c62oSy/cfWLJWFeWa9Lb
 oxw5oPXdX0DqxM8kOgAAAA=
X-Change-ID: 20250103-b4-pks-ci-fixes-2d0a23fb5c78
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.2

Hi,

this patch series addresses a couple of issues I've found while
investigating flaky CI jobs. Besides two more fixes for flaky jobs it
also removes some stale code and simplifies the setup on GitHub Actions
to always use containerized jobs on Linux.

Test runs can be found for GitLab [1] and GitHub [2].

Changes in v2:

  - Expand a bit on the reasoning behind the conversion to use
    containerized jobs.
  - Fix commit message typo.
  - Properly fix the race in t7422 via pipe stuffing, as proposed by
    Peff.
  - Link to v1: https://lore.kernel.org/r/20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im

Changes in v3:

  - Another iteration on the SIGPIPE test, which should now finally plug
    the race.
  - Link to v2: https://lore.kernel.org/r/20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/277
[2]: https://github.com/git/git/pull/1865

---
Patrick Steinhardt (10):
      t0060: fix EBUSY in MinGW when setting up runtime prefix
      t7422: fix flaky test caused by buffered stdout
      github: adapt containerized jobs to be rootless
      github: convert all Linux jobs to be containerized
      github: simplify computation of the job's distro
      gitlab-ci: remove the "linux-old" job
      gitlab-ci: add linux32 job testing against i386
      ci: stop special-casing for Ubuntu 16.04
      ci: use latest Ubuntu release
      ci: remove stale code for Azure Pipelines

 .github/workflows/main.yml  | 78 ++++++++++++++++++++++-----------------------
 .gitlab-ci.yml              | 19 ++++++-----
 ci/install-dependencies.sh  |  6 ++--
 ci/lib.sh                   | 34 +++-----------------
 ci/print-test-failures.sh   |  5 ---
 t/t0060-path-utils.sh       | 10 +++---
 t/t7422-submodule-output.sh | 43 ++++++++++++++++++++++---
 7 files changed, 100 insertions(+), 95 deletions(-)

Range-diff versus v2:

 1:  924cc137a7 =  1:  2d20c22e1c t0060: fix EBUSY in MinGW when setting up runtime prefix
 2:  85f732d57f <  -:  ---------- t7422: fix flaky test caused by buffered stdout
 -:  ---------- >  2:  97e94a22d0 t7422: fix flaky test caused by buffered stdout
 3:  96ffed8ad9 =  3:  5f105f2d04 github: adapt containerized jobs to be rootless
 4:  a276e87563 =  4:  ffcb18fe34 github: convert all Linux jobs to be containerized
 5:  736d660c31 =  5:  e7a9dc276c github: simplify computation of the job's distro
 6:  0c2e227cb8 =  6:  7e1f6b651a gitlab-ci: remove the "linux-old" job
 7:  60c3cb0d76 =  7:  03b4a82fc0 gitlab-ci: add linux32 job testing against i386
 8:  216c043aac =  8:  df57d16eb9 ci: stop special-casing for Ubuntu 16.04
 9:  234b741805 =  9:  7c63294ace ci: use latest Ubuntu release
10:  421852878a = 10:  d47387d596 ci: remove stale code for Azure Pipelines

---
base-commit: 1b4e9a5f8b5f048972c21fe8acafe0404096f694
change-id: 20250103-b4-pks-ci-fixes-2d0a23fb5c78

