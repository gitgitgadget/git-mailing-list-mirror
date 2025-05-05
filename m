Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7FE1FC0F3
	for <git@vger.kernel.org>; Mon,  5 May 2025 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746442552; cv=none; b=JPs8UCziAGX8WMgUKSE36nvRBBEZcmnoKd7RdV/UtxHvTXqTDmhHsy4X1RH4LNY+0Ro2zu46URonRS1A2STsSfOBOYjUWyw9d9dwz5RK10EUwwmb0uAYiu2izwlOdyMr3e1Rp39LVKVbQI83mRI6fYq9VjRVrn+12Ay9lY1iLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746442552; c=relaxed/simple;
	bh=LkRlwpRukvVk+DCACkAY+G/3qIbB8V0T/QDjLfmixCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RoyV/BGpZD+B+vsKno+LelsE9SPWcP1Zh88dE5GfZAxoP41mQr+QiTtiA7DjliM0R9v5lJaOptV0Ahnba1/DW074ptaGtTv/Z/dpDaeOa6ub95Ie5/28uTKfSuchNzO+eanxOIQYhxzOS5MaMfWRsWTZSOW/w3ea6SRzsHDWfFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KaU2V9yH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WAHSq+ep; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KaU2V9yH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WAHSq+ep"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 593141140193;
	Mon,  5 May 2025 06:55:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 05 May 2025 06:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1746442549; x=1746528949; bh=2l89XweZ0X
	pgDU20KjAzPm0U3BV6V4ebbzA3gBqZPec=; b=KaU2V9yHrF9comv5S8Vdr7QX5s
	vf/fGgPc3uq1FtFMBQ+1YARU8A8Gx+GLuXHZiHAApmVTSA2JBmnFIkVRrQm0y3tu
	D7B01HtwCuCMaF/OJf37CLQbadJm0UDqgzLLkirscCCCpKo07FefO1SG7xndRJQ7
	dZRYA3kWdjO/fMYdaeiiKr3yN5qOzF6hipk4Vs5wqLMyUsI0L+vF/AS5qMVyT72l
	6ij66xrFqDpxFy9MZnmH7D3aC8GXN5onVvaIvgh6pG8nDllFGgWZHU/ZXd64au/+
	9LgY2/kDD0/VUd7IzqBtV70QkGq7NbY0c0yDGpPCSa5ozJiM5lWVk3+3nW3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746442549; x=1746528949; bh=2l89XweZ0XpgDU20KjAzPm0U3BV6
	V4ebbzA3gBqZPec=; b=WAHSq+ep1tUxA2I3g1xW76DpNQVL0V3P/wiSE7ttl7+k
	UXwSLzxTMxF45TMNyU47/dFsbKFHiSx4j+TXuVfKOImJQows6b7lJYfwKaXngpA8
	gV+fNpne3if3VkQrAndypPTRqVH8e+NKARlO6qnGLpeYUrMEHejU7OUygYKTfSU5
	A68IzuV8FFYeT/O1NsW7HDAd42PxjUq5SyWuVcNmH2RJQ2CNKCRiJCJ4Hj4Nh9Ub
	ywT/gEaJxoimUotUmnQSgGLoiG8Am5cIvmSzeLHeeDXvd2Txpxi1k3+HkmMH3S3V
	e7y50WEgMsCV58fOcyZIl234guqjl77Fh3biyp/UcA==
X-ME-Sender: <xms:NZkYaMK6EaQjy-H8vjUwBhRxe-9xVcoxfUGB8u8r9F8nS3pYKbtWkQ>
    <xme:NZkYaMLsJHhky5LMto3eryjqzw4NUDYrDjnt_QaeeJ_2Vt9HezRa0lYJ47J2nRYaW
    pomhWmK_ES1u95TEg>
X-ME-Received: <xmr:NZkYaMtyp8piTQzTMi_HwofakvFmjYVlRx6w3kKV9DuiGzkfR_puvndyFq57uB65KZitoLp1fsrF7fh_dlicBKU0dC3SiRg2KrDh0rKPM0rDcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeekhefgiefhheffgfeigeeiteehueeijeffleehheef
    vedtiefhfeefieeffefhtdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdr
    shgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:NZkYaJauddzHNqL3pLgit4QPOG7bVUXQKoMcnfOiMO4EZz6H6UuMCg>
    <xmx:NZkYaDbegdveLpavbiRSHBNOwMYb1pPwwcO-1ptruAHEQFSFU1m_8Q>
    <xmx:NZkYaFC9nlJXV1YHQROAYnjWemep9ynLMlo0wIv_aO1zpUAPRHMq5A>
    <xmx:NZkYaJYMCiRLTzL64X-M3wVOQteTkU2B3vqXzkqkUucfitflNZ7Dng>
    <xmx:NZkYaOuUOqcrYF0UAD4QmvY8cv1IknX0gpx4Fh2mttKtGEItpCdHrrVk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 06:55:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 382fc414 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 10:55:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 05 May 2025 12:55:45 +0200
Subject: [PATCH] ci: fix aggregation of test results with Meson
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-b4-pks-meson-aggregate-results-v1-1-f38899a0a2cc@pks.im>
X-B4-Tracking: v=1; b=H4sIADCZGGgC/x2NwQqDMBAFf0X27EIMsYX+SvEQm2e6tI2yq1IQ/
 72hzGkuMwcZVGB0aw5S7GIylypd29DjGUsGS6pO3vneVXgMvLyMP7C5cMxZkeMKVtj2Xo0vDlN
 37VMKPlCNLIpJvv/BfTjPH5bmpTlwAAAA
X-Change-ID: 20250505-b4-pks-meson-aggregate-results-60ef175dd424
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

Our CI needs to be aware of the location of the test output directory so
that it knows where to find test results. Some of our CI jobs achieve
this by setting the `TEST_OUTPUT_DIRECTORY` environment variable, which
ensures that the output will be written to that directory. Other jobs,
especially on GitHub Workflows, don't set that environment variable and
instead expect test results to be located in the source directory in
"t/".

The latter logic does not work with Meson though, as the test results
are not written into the source directory by default, but instead into
the build directory. As such, any job that uses Meson without setting
the environment variable will be unable to locate and aggregate results.

Fix this by explicitly setting the test output directory when we set up
the Meson build directory. Like this, we can easily default to "t/" in
the source directory when the value hasn't been set explicitly.

Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

Johannes reported to me off-list that aggregation of test results
doesn't work on GitHub Workflow when using Meson, as can be seen e.g. in
[1].

As it turns out, the issue is that we don't set `TEST_OUTPUT_DIRECTORY`
for many of the GitHub Workflows jobs. And because Meson by default puts
test results into the build instead of into the source directory our
assumption that the results can be found in "t/" is broken. This isn't 

I never noticed this failure myself because in GitLab we always set the
above environment variable there. In any case, this patch fixes it as
can be seen at [2].

Thanks!

Patrick

[1]: https://github.com/git-for-windows/git/actions/runs/14806194960/job/41574766327#step:9:2125
[2]: https://github.com/git/git/actions/runs/14833082023/job/41638408968
---
 ci/run-build-and-tests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index f99b7db2ee8..bd300a05db8 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -56,6 +56,7 @@ case "$jobname" in
 		--warnlevel 2 --werror \
 		--wrap-mode nofallback \
 		-Dfuzzers=true \
+		-Dtest_output_directory="${TEST_OUTPUT_DIRECTORY:-$(pwd)/t}" \
 		$MESONFLAGS
 	group "Build" meson compile -C build --
 	if test -n "$run_tests"

---
base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
change-id: 20250505-b4-pks-meson-aggregate-results-60ef175dd424

