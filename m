Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AC3306483
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806084; cv=none; b=itPtIoeGb+76lOXTsrSIDtmMz4ATFMPh4nnX1TLw6i3A21LMRwcHQ8iicQHDrP1v8QWaD5ck9hSJmVvOnCDGnbLLi+iu50RIxuYyZBMfNfkTB5r2eJT3cl8Uvp753eaLSvJO8IzeOrko/pgRPft9uf0xfAjeK90THoIntTqyrT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806084; c=relaxed/simple;
	bh=r83zJlbb7gm++GxoRgT98NXNLO/gGNaxfD+qf15rQZI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kXJymwaQwHeEfOAy8zhRVEfSBcZ+WXFTnpV3eYrM5Xcp7D1SnNAdCLJq0W+VY0QsRVvC+upbCqLdsfMlvYp4NtulH3VJQUHaba1SiwAjnNwbhxPRr6Ox7cgW4gUjkoxsE2Qcs34sLjlipE+44giPMao2BFclew7yV0G0wHo3/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b5nuj6I2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D9fvZekU; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b5nuj6I2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D9fvZekU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A06311D00246;
	Wed, 11 Feb 2026 05:34:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 11 Feb 2026 05:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1770806082; x=1770892482; bh=91URf1piVy
	swgZY3nFDzHGD90T9shOOas27wMPC/m6k=; b=b5nuj6I2obASguRIGKotQywkch
	BwAA4xJYN0YUJuaNbie/cDrE6oPjsL9xJLbO0Th1wVwKPJSyG/tRvzelAoPUJcrw
	fZaya1RYY6TWvJZTBbgBmZdiFXZUwpSWsqxgQ/9oq4N1QhplNBXqCMtFv99jJs3L
	0XnNZsNZtErqGcL2bPlW/QUYwKMpSqUMY62Rs+k7KwJS4+E1pmEKIsbTeFiLlmBC
	CAf//p9AoCch6sTFrUj7N9QHBCiR5ZY3f7as2nMhF2FxjhknIoETF+egXboFrCVd
	9moEs2X+CdgYMqZV19jkkPoM6wly4OyAn0GZ5FY21pnZGWIx2E1hINxGr2Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1770806082; x=1770892482; bh=91URf1piVyswgZY3nFDzHGD90T9s
	hOOas27wMPC/m6k=; b=D9fvZekU9pzTht1yP7zRN5umpYgwVkpdNecwztImLt8m
	E2i44eeEdnaynlqLkvx+jcMJNk1dO1vpdjg2+eCcHXmKW0ToTQvo9IE5/ezosDLe
	XBS6+JSNgSboULOQJKb0mYaMPni5QMMih0vfXenK8uHEcQEp879kr2v4EUiXM2EF
	SEuE9HrpWjoyNiJjF2dpxj/viEJbT7DYmNcwyB+QeUAR5t4dmxL+4NqL1USgjXtT
	6NUkMipyDfCsc/9fcKbg63j3Z/u97gGjRG20PC+h/za6goZenv9bB2YW7oY/uKOc
	iPquXGFbI/BhiCY5NGyKl8qc/nVbYgB3xdC2gjjRbA==
X-ME-Sender: <xms:QVuMaS7D-D2OrtZK3JJvfEzaO-H-_hpbReEEVgoN-tdKPxdzWIElfQ>
    <xme:QVuMaS4v3RfiDXRdvoB-tjWJUf-fJ2KsrKX-YwN0G0GKwURb2n_4Kpo248JEtjb-m
    Dbdm1eyuvVnoQffNzHAOaQDg9CxDEMzutBsVCq7wsybmHFG2KDk_g>
X-ME-Received: <xmr:QVuMaWd44rF_xTjb53CE-6s9BRNISfeMNfxCxCXi7105ULNByNEMhlYIF3TRcENAd8HhmJeUTb3DgR5agqfYV099atwCVLo0WFHQSJs7T84F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    fftefhtdelffevhfetgfefvddvhfeluedttedtueeuueehtddtjeduhfdvkefftdenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtlhgrsgdrtghomhdpghhithhhuhgsrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    phhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:QluMaeDbrV-buaRyhRLqakBj4yL9xH-PgO2jEAIAVxgRj_89m30m6Q>
    <xmx:QluMaR8UU5A6GLEhb0W_-jhSsKQyEX931UvsCGjcD9wv-ILCuzOgKw>
    <xmx:QluMaRK5ndQCnGTkRldm18p6NqUigRNlut8KV1QbRURif0ABZ5IVGw>
    <xmx:QluMaSgM8fu1sPA2AgVlrgbL1G30tey1p2IdTLiu3tc2Y0pBLSnx1Q>
    <xmx:QluMaUakovaOugrQUL3X5pu4vsbNwvQgQdySz-Ta6TDkT-afJuMWSabv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 05:34:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 07707ad6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 10:34:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/7] Some assorted fixes for GitLab CI
Date: Wed, 11 Feb 2026 11:34:26 +0100
Message-Id: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADJbjGkC/x3MSwqFMAwAwKtI1gZqFT/vKuJCbarh0Q+NiCDe3
 eJyNnODUGIS+BU3JDpZOPiMqixg3We/EbLJBq10q7QacGkw/gVXRkcSPLKLKZzkyB+CQ236ubL
 WGN1BLmIiy9fXj9PzvMmu1LFuAAAA
X-Change-ID: 20260209-b4-pks-ci-meson-improvements-93d8a1ffdd27
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>
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

Changes in v2:
  - Fix syntax in GitHub workflow.
  - Add another patch on top that fixes win+Meson tests in GitHub. Those
    tests didn't execute at all, even before this patch series.
  - This uncovers another bug in how we set up MERGE_TOOLS_DIR, so this
    results in another commit.
  - I've now tested also tested the changes on GitHub [3].
  - Link to v1: https://lore.kernel.org/r/20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/497
[2]: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
[3]: https://github.com/git/git/pull/2195

---
Patrick Steinhardt (7):
      ci: handle failures of test-slice helper
      ci: don't skip smallest test slice in GitLab
      meson: fix MERGE_TOOL_DIR with "--no-bin-wrappers"
      github: fix Meson tests not executing at all
      ci: make test slicing consistent across Meson/Make
      gitlab-ci: use "run-test-slice-meson.sh"
      gitlab-ci: handle failed tests on MSVC+Meson job

 .github/workflows/main.yml |  6 +++---
 .gitlab-ci.yml             | 17 +++++++++++++++--
 ci/run-test-slice-meson.sh |  2 +-
 ci/run-test-slice.sh       |  6 +++---
 t/helper/test-path-utils.c | 18 ++++++++++++------
 t/meson.build              |  1 +
 6 files changed, 35 insertions(+), 15 deletions(-)


---
base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
change-id: 20260209-b4-pks-ci-meson-improvements-93d8a1ffdd27

