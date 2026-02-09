Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1BB1DFD96
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656186; cv=none; b=Ll+DZ54SLkfZTxzbAs8G+Rb2cN1qBdKivmmeqkfQY0hC0++WdSqujXStjPQSnaHpLcL0qIQiqRGuH+Qs3mR1JsdocmQL13NWzUaR8mETWxA6woCG1UHZoBEp9Khzcz3AOB7baYWic8QAV54Rv3h/H9kAgvKDjhlHMHkQjo4WYgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656186; c=relaxed/simple;
	bh=svHLSlsBHHOsbzG0lvNaDTihyiF8PDBPeUC4vM1dS+g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WJZ386hiGUY2Mm3B5wqGjzuxLsMp7E+KY01rlvzyi6M57C3q+cu2ozXwkPdT3AvIYVs7iEgOek2MZCkFUw5SnyC3mnIJcloq5XqmcQAZD35DXbil3K8T4H1SpUJro6/p0Sd5ME1M+NQkbVS4ZrzIFH088y4JU0iVMOUntFG/EoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B9NVfgTn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KkElW6zi; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B9NVfgTn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KkElW6zi"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 08BB51D0017A
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 11:56:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 09 Feb 2026 11:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1770656185; x=1770742585; bh=/ViZrlNqPb
	GyQiNBBuSdC9LLMCNUIm6qRmE2r1addY8=; b=B9NVfgTnrXh4F02hllGu1rTk3V
	HuM3J59WEuaNUfLw+k7D8g63VqNNEt1VKRlQW3Li94elK0pgmu94zP93hXKP8Qgf
	JN3JTjuAaLWlCKaS2SU6+Z0wcTF1NhXFiOORh0XWUy3AG69SfUFqNvnf67OZTvhU
	4lj2f6EY72ivUsl+uqHMwLJyv8LMIw6+a3FRiyDwKB4LSeL4dORY8ZeMeQFc9F42
	b/ewNEvJW+xWGdmhYNBam/33Pm9VZ9EXg0smTAdyM3OVLs9W/X37bJXWU1oP0hsU
	kGI4EEMO1SSOpW3cUayVluwyQbGnbXyEjuTH8rH5lwEtglcfpznAttzwNAtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1770656185; x=1770742585; bh=/ViZrlNqPbGyQiNBBuSdC9LLMCNU
	Im6qRmE2r1addY8=; b=KkElW6zic2n3dUqLUmEPEMIYB2iuUAW5Y4uzzsE2sNud
	EI+YGm0pxoBXBTRCiLARqJxdu/6yW2hVZaxqct4XYMFebG74LEzySZU1uTw4aq8i
	juUc3fXlUy5jtLvqEAiz+9RDdb4pcNgkI4ipcqZIUsLq2BVON2YGVBKQBj+4R3UQ
	cEy9YWYGIWBY3VuPZDUpSeZdBPMtnrRw2KKL6JFKNPuvh+Db+09Xs4gJFyAk96BR
	D/H0in4N4AaKC6uTb8mscGIL70HfK9rgvxf7VNJiD1dnOEFvrLTGWvi61C8lmWoI
	MDD+lDcRoD9GI3zpQWRgiUd3EGbgqV0P/KWI6q0hHg==
X-ME-Sender: <xms:uRGKaTroeBwVGAx5FAph9YNhq9NepEr31HtB5PeOE8BJVTRaDJRiEg>
    <xme:uRGKaUkRN8gJOkmniYRbra00x1_1yVZVZIA6ukG8HaHLu_DIChozinM3PC_vHfqdj
    _EQjd_rKAVvlRjTVQA4ix1VlZ1eA-GPXcebK5anPibFlvTb9iQvKQ>
X-ME-Received: <xmr:uRGKaV1daHLTR2bbPe5J5zNjsKwRg5ARoR2Yws8l2mngu9RrcLA16DdvqpKk2QbK14nEzwX8nR0lgs3VNgho0GqeFZlv30nGzM3Fc49U5hM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeefkeelvdfggfdufefhhfdugfelhfefleehueeftdekgfffffevtdegudevteeh
    ieenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthht
    ohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uRGKacDPgpoxYS9KcdzShChOaR9TaFkPrd0kjTvnyMwDKwERQUxpeg>
    <xmx:uRGKaSzqffZXAvPWqjFkiSs3n2FXo8J2LQc0WL_X9mUAALlLdZjKVg>
    <xmx:uRGKaakpO96fqXpTn6xzo3hYGJo9QY6ziBl4UQfp3OPzAI2_5F-Cgw>
    <xmx:uRGKaXGcactICDqBWpnUdjxbEzZbZSOsIyVnK5Jbd2zJgU0Q8xbVnw>
    <xmx:uRGKaTKPysWu4eDivmoKzv1qQwHPnUvPpH-4wtCdMmosVxjukwYQpn3p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 9 Feb 2026 11:56:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca2c28c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 9 Feb 2026 16:56:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/5] Some assorted fixes for GitLab CI
Date: Mon, 09 Feb 2026 17:56:10 +0100
Message-Id: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKoRimkC/x3MSwqFMAwAwKtI1gZqFT/vKuJCbarh0Q+NiCDe3
 eJyNnODUGIS+BU3JDpZOPiMqixg3We/EbLJBq10q7QacGkw/gVXRkcSPLKLKZzkyB+CQ236ubL
 WGN1BLmIiy9fXj9PzvMmu1LFuAAAA
X-Change-ID: 20260209-b4-pks-ci-meson-improvements-93d8a1ffdd27
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

I recently had the pleasure of debugging a couple of failing
MSVC+Windows jobs in GitLab CI, which hasn't been quite fun because we
didn't know to print error logs, and neither did we upload the failed
test artifacts. This patch series is the result of this frustration and
fixes a couple of smaller issues in the context of our CI:

  - I noticed that test slicing is slightly wrong because of a
    difference between zero- and one-based indices, which causes us to
    skip the first test on GitLab.

  - I deduplicated how we run Meson tests so that both GitLab and GitHub
    use the same "run-test-slice-meson.sh" script.

  - I add logic to handle failing tests via "print-test-failures.sh".

The result can be found at [1]. Note that tests are failing, but those
failures are fixed in a separate patch series via [2]. In any case, I
guess those test failures also serve as a good demonstration how the
failing tests show up now.

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/497
[2]: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>

---
Patrick Steinhardt (5):
      ci: handle failures of test-slice helper
      ci: don't skip smallest test slice in GitLab
      ci: make test slicing consistent across Meson/Make
      gitlab-ci: use "run-test-slice-meson.sh"
      gitlab-ci: handle failed tests on MSVC+Meson job

 .github/workflows/main.yml |  4 ++--
 .gitlab-ci.yml             | 17 +++++++++++++++--
 ci/run-test-slice-meson.sh |  2 +-
 ci/run-test-slice.sh       |  6 +++---
 t/helper/test-path-utils.c | 18 ++++++++++++------
 5 files changed, 33 insertions(+), 14 deletions(-)


---
base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
change-id: 20260209-b4-pks-ci-meson-improvements-93d8a1ffdd27

