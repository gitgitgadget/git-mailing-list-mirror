Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E909F2F3C0A
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771482346; cv=none; b=sOPSzaG/RCBVuSg8Kntq2GxV7v+Q+7F5FSExjgFycJuEDvUXr+6zOlwQfPOLQKhrsi2okUvyk9sawlVM4newdueqJ82fDmLUSwyWjXxMPeWOhfO/pdqJbDZGrL2Mc2g3XFvpDlS8p77oEOFVV6xh1L1QoVpb6B4pCVWz3ODTkp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771482346; c=relaxed/simple;
	bh=n5ZlO8yX19zeVt6fXkwn9SkEuxaBRcK/SZl01v63vwI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=HQoeWt9eDkS5p7k7oHg3W+rSw21M25clN+57ZHQSdSJIoyloYoU3y3Yb5trpjVN5rtbLVBQXftA2W5nm0HQKhdvcuabhOdTF92J5qz6onxIZ+iEozm+9mMN7H4WLxCk1GydUqAmOQg6m/doISuiMXp+b0VOigIJy2bnCqi+SEqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T+Yczxbj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BUj+f227; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T+Yczxbj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BUj+f227"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CF7F5EC064B;
	Thu, 19 Feb 2026 01:25:33 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 19 Feb 2026 01:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771482333;
	 x=1771568733; bh=phsbQrZuKJixFXfuES5afNv8V4bT5pq5dyPwm+cu9ag=; b=
	T+YczxbjIaZabydRVZ3B/japiyEVq6s6b0RMAVaolFXpgBR+zx7p9D5IbESxCeNv
	f4EPtTIzkB6ubALNfxBHnpo4xpGnXMyg/0fTxBRgDIjj8tAqDv5I6hFTrsF+LG5L
	2cOACJZVc55xaVkqMW+oQ6fSZwm0qyur/x07UGCbaw/YTqBB5LmKxjKHjxfAptew
	dCulCITc32wuGAxndPhFZCNYFW3ibxd5KfhZnaof0WAkLpCdfvhhJIO6puM/NFJ9
	lNSpENVY0jai7q8TzyQ3nrWWRghllrfY8IobIXwxehbquq0r2YNAOfEaK5VRI3I/
	RBu5stwfmPy82FuOTuG5MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771482333; x=
	1771568733; bh=phsbQrZuKJixFXfuES5afNv8V4bT5pq5dyPwm+cu9ag=; b=B
	Uj+f227GgB7wp/jiO9RMFaBvcUYxHkG2zEIdH9KFGkqKNu20p7UNKIkfBD5nKcT9
	jGgRumjY2pqq59ujPuHUk8cxiXDwk6rEskTph5tkjPpv6+wPjYDY8BEDq7yRedZy
	KDT9cNyg3iUuvnsKd3gel0dl7qUSarSTElQqLNikS891UkX5ZDS57DAxix3Tvcw5
	7Lb5TDFLGUmczV57aL8Dxbv0OTA7hhS/pNvzEho7h/+AQqVO1eha961ZsYZOodXw
	xgnEmZoFvrbc0Kwsxv0FjUGFBVoRxL33AirIBnP8doHtKX2JhblyUf+85pxHNuw+
	l5IhO0+pyqoaSBZRr5haA==
X-ME-Sender: <xms:3ayWaVqTqV7F18yxoMC0JjdVge_wqJJ7jPJU83qpUV1NwL3eLchOHg>
    <xme:3ayWaeh_u6Y1PV_nzY5kW1pbLMAiVv67ENrDAf2tJwm75PcUF5mBMBaaSAxfnjCo2
    Tf1lgwd4_wDUogc63cYqrdJmcHD4ZrwzT3nvq8ut-AuoVjhfu8lmw>
X-ME-Received: <xmr:3ayWaah4si-2ek3wBXN9Q2U_X6FwpnMpDWtRzq0bQUVTckMBF18Gzk0AUFORL1ImI6-czGey_n3MfLXXkidjWjNSiytuBoVH-mEdPFU_uA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeevjeefheeggeeljeduffetveehgfeiueehgffgudffffffgeeifeetveejleeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtlhgrsgdrtghomhdpghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:3ayWach55ReC_F5qQWEAvUU0O1EMGOqjFz1iOqrHSTBK1uefV4NUHg>
    <xmx:3ayWaSJHlEFUTvdgtTQTKPxTNzh9Tj8a489UgU9CwXtHo3du4XrkZA>
    <xmx:3ayWaTEvXzcQkU1FoCOu05GtCZwQDjX2dTzgEQqub3L14-KvdMsg9A>
    <xmx:3ayWaeRlUm2mo8266bW1mXKWCnjfZvCkBkycP5c_eaqi3FnPaxX3lA>
    <xmx:3ayWaX9TkLwkbo3gRUckY7awm70ExQFYIhc1WfY9AQTlCvZl7DRrufFQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 01:25:32 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 630143f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 06:25:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/7] Some assorted fixes for GitLab CI
Date: Thu, 19 Feb 2026 07:25:26 +0100
Message-Id: <20260219-b4-pks-ci-meson-improvements-v2-0-6047b8307ab2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANaslmkC/33NTQrCMBCG4avIrB1JovTHlfeQLtpkagdJUjIlK
 KV3NxbXLt+P4ZkVhBKTwPWwQqLMwjGUMMcD2KkPD0J2pcEoUymjWhwuOD8FLaMniQHZzylm8hQ
 Wwfbsml6Po3OmhkLMiUZ+7fy9Kz2xLDG9929Zf9cfrPV/OGtUaAdd1dY2amiqW7k9sYdu27YPL
 x880sUAAAA=
X-Change-ID: 20260209-b4-pks-ci-meson-improvements-93d8a1ffdd27
In-Reply-To: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
References: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
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

Changes in v3:
  - Correct a second invocation of "ci/run-test-slice.sh". I missed this
    invocation, and because this job doesn't run by default I didn't
    spot that it broke.
  - Link to v1: https://lore.kernel.org/r/20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im

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

 .github/workflows/main.yml |  8 ++++----
 .gitlab-ci.yml             | 17 +++++++++++++++--
 ci/run-test-slice-meson.sh |  2 +-
 ci/run-test-slice.sh       |  6 +++---
 t/helper/test-path-utils.c | 18 ++++++++++++------
 t/meson.build              |  1 +
 6 files changed, 36 insertions(+), 16 deletions(-)

Range-diff versus v1:

1:  b5ad91e1bc = 1:  b55e0b145f ci: handle failures of test-slice helper
2:  5bed073cfc ! 2:  fbdd1df05d ci: don't skip smallest test slice in GitLab
    @@ Commit message
         As the indices are now one-based it means that GitLab's CI is fixed.
         The GitHub workflow is updated accordingly.
     
    +    Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## .github/workflows/main.yml ##
    @@ .github/workflows/main.yml: jobs:
          - name: test
            shell: bash
     -      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
    ++      run: . /etc/profile && ci/run-test-slice.sh $((${{matrix.nr}} + 1)) 10
    +     - name: print test failures
    +       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
    +       shell: bash
    +@@ .github/workflows/main.yml: jobs:
    +       shell: bash
    +       env:
    +         NO_SVN_TESTS: 1
    +-      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
     +      run: . /etc/profile && ci/run-test-slice.sh $((${{matrix.nr}} + 1)) 10
          - name: print test failures
            if: failure() && env.FAILED_TEST_ARTIFACTS != ''
3:  6b061b829d = 3:  a5e411aade meson: fix MERGE_TOOL_DIR with "--no-bin-wrappers"
4:  828147d641 = 4:  b7d868fc53 github: fix Meson tests not executing at all
5:  05458adc6f = 5:  c9690b10a8 ci: make test slicing consistent across Meson/Make
6:  49df181d3d = 6:  bee3a9d944 gitlab-ci: use "run-test-slice-meson.sh"
7:  e7e9504c16 = 7:  ea1e1a4d87 gitlab-ci: handle failed tests on MSVC+Meson job

---
base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
change-id: 20260209-b4-pks-ci-meson-improvements-93d8a1ffdd27

