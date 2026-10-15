Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A171349F13A
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047450; cv=none; b=QmhrAJTM2Lays5iamjok2flgwclQYRzqKEmIZnVEYJsrLdFlJbuOCnjtf9M47vleKVt2zgIqlykk+boy09vo9JvpHIO7AJhjE2m59Fo6IBijBqHmuRLop9ASE/coYXn1r/leN6VVB2t9+6ROghCltHN8jHb3sWl4Mr1O9ryrJmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047450; c=relaxed/simple;
	bh=WvkO53TGbeKKRruA2wep24WUwPIPnCAd0M0Gtk7nsjU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=oWBgvG3lUMhr4apio50kHxMW86/qYEbCe+3hXRZh6ieOhJS5gxSS2ybpsWZZNPOJi8r0H7ap+4bScQrwzAAU89tlRt4vTGrXTZJ0aw/pAzdHpQZu+F1swniCy/1QrcbCw4srdFN8Bf1QhjBK/iB1lOndWuO1fToIS3hmlZw4sRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MiIXZCbv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CcPDb1/q; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MiIXZCbv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CcPDb1/q"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id D732B1D00119
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:57:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 15 Oct 2026 02:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792047437;
	 x=1792133837; bh=ZzPUFn4lOQGKG1z2eAUKrFYNB0Fz4IEvobvFkd0DziM=; b=
	MiIXZCbvaJ9ZW9EJLbtLcNNUnaK/ZNEBckTA9TfmniMHupPIwl5WDdNxnU/ZL3mD
	W3jsNxqA+o+INdQuOJyKq/y3mc0PQGcsxSeGhQUr1iPQLu1prf8y9J3vVfxGuNvJ
	247gO2u6ZZCRy+B68EScwujS6563nxT9Uo+RUvNvffZOfBQ6EfI+KCfOuT7NB6ed
	CS7usaJpfwfy6HNfB+DQgloHEB3LbAScr291kFKTT1F0dh/E6OdvmkRrZuCfjFOS
	xCWjbSjJWfmaeQgq7lhj8nvKe29MCvdtV+ERQ3PlvngC9X6B01Lvdexp7CSJ63L9
	GZxrQfZfxaJ7BYrlBrK4uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792047437; x=
	1792133837; bh=ZzPUFn4lOQGKG1z2eAUKrFYNB0Fz4IEvobvFkd0DziM=; b=C
	cPDb1/qknkk1OiJqDurHSK5uciLZFWWf7+9IKLMODU/vgKdijBWY3FHwSkp4eAbe
	mixvMGm69XRTRU8XXXUwApa0wdE4oOSDDUOGTfaFx3HS/XPjWiRT9kvVSX4cf2dW
	4WKwlrp2M0fKYf+ZHVFP50qxZmS7UoGjo8FRXrpQVLn3zVxyUw5629rdUp+hWex/
	laXuiIQyVe7VQJdTSZdhMiaIPMO5tGUVJPwuFgtD5UO0sPdP85zZ+v+Y5Wh2/Rwa
	TxeRpK5mwlCmufNMSKaYiqnV9dcyt8jjTH0/zOLm5DSphAlKdkh10xu0Wh1F2/xT
	LScn5glYhKuVq5Vt64LAw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792047437; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:m4JnkQEaKePMB/jJOwWKdy1/vCH2xw4HhxVB4fJCQkwQfM8
	dAGapyiZwdMqBcxGllTEmjGPfZfwTXUFKF3cTbnIeoaNq8NpwpZ8BdseYg35Tssr
	/MuWBUv8vOuC+8UM03Wxwk8d90F2dJpljLgLI7dyObKxwiBGBMxJomTxdi4ksY6C
	vpq3aGHhqBXWDfVQfIlWDqdhPo3KlTkNQjwmYwDG/1z8hxyd8r0srdg+pMNCGvf8
	d7e0Samk+3b9rYQ5b+HcmJDsijrYgfY1yCde6ljLv8nskbwvXayqXUHFR1mwEyig
	bqigvGNM8ThNNAIKOgh1ocFNJ0OzEZe9mNogycg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:3WidTiGsM4QapdP4tkvVaqJdvEQADqBGt9DDCxxcy2Q=:WvkO53TGbeKKRruA2wep24WUwPIPnCAd0M0Gtk7nsjU=;
X-ME-Sender: <xms:TXnQao1gT9pdt_GobZwghoqFDaLDrbkQW6hUaACbS8bkT9yOeaSayQ>
    <xme:TXnQamwL-IPXvO9TKHVD1ms4iswp8KRRiOZjJvm28eQ2Fuyu-fyq-mBga0JMboh30
    FYLf_6N2ub2pkUmRl_xow8o9NJZIUtspy0PCJKmuvp8fWwqNIm-uw>
X-ME-Received: <xmr:TXnQaqs_M4O10E8vHdVboDt7uDb-ySh2UCuRxiYztJ5yp7lceUGR7ngeatBdWGlwvKSFlKs>
X-ME-Proxy-Cause: dmFkZTEiyTRrVU/rsk8U/jZ87jtCGjasjJOGmvPSZRtxp8N7UidLCGUJ0CYuXL0mKvVjZS
    abEaGcDs1vQX4/c9OvjcCEZxYjziqfsJzMLJIwY09p8GG+qaKvL1TH2K0heb/RJv8pY1pR
    nT+O2AaL8DoHvdrU7OGlXbGB8uWEZwgokmzhjXXZARowGJkc2xxr6vUrv937RtDCBZsELI
    M/uT/YLj8c7QoMhtTWvx9empXKRAo7ZVfU9BdQ7QOiV6DIHlUoX8KvCGQaBJfOty+Gnk2v
    3Ez4dslJIowbnO1fgI9+KCiG2tDJ70aIsWsTtTUdocell7QUkgRA3CyNDSQTV34LNiVBUR
    rpmjAajN8NgABRp5BPR7j0ENMMEcmZY/W1h2X+pvo8631pP+tU4G2ucu9uSiR4uz7DcCIb
    U9jXUU9VIdry9cH/yt2KQNYq4PeQVyjoD55s99P66ToaDeBOkWiuoQMq80ov2/7bNTZDyp
    fGY7ufhJ5k/zbeGCHDAVKicfVI02UJX2VXjQjj+idqYXEOXJPOa0xfTP+jwY+BBB733+1D
    nPiDeWjJCRo66BcnNR8HoCWrgoS/biwRFUhX86ZzL2JGhXr3qGvvfxfsXqc9xSe85TIfAb
    aq9qv932CQzYJbizdYqHAqplM7Cp1PH/mgcrQuo7e2F3eHZf9WRoLmT4FZCA
X-ME-Proxy: <xmx:TXnQaowtl8cR8qggBDiNaj9X4iTAhWnJk1GV0hLtz2YOTuwUlMgOEA>
    <xmx:TXnQatD7z5lJnUHBxhJRKYI6hsTCzGjypQwnWbhqmReucmL2tUOD6g>
    <xmx:TXnQamc2u2y8d_rhSYkb1gf6qhoEWw8aGO3umMJYEhQuGkHuatNi7Q>
    <xmx:TXnQankqkwWm6SwNMkl6-ry0ruDpue6S0OizUmpdpLe0eY58RIBOEQ>
    <xmx:TXnQajkeOK9gDKhrICXDC04hEZq5JTTz6HpjANYbGtPlFn4Ft7gjKYWy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 02:57:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 19ee1356 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 06:57:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/8] ci: some housekeeping and modernizations
Date: Thu, 15 Oct 2026 08:57:09 +0200
Message-Id: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33N0QqCMBgF4FeRXbf4N6fNrnqP6ELnP/2TVJxKI
 b570yAMpMsD53xnYg47QsfOwcQ6HMlRU/ugDgEzZVoXyCn3mUmQsQDQvK0cN8TLZnBYIbZUF1w
 Ze7KpCTPILfPLtkNLz1W93j7ZDdkdTb9QS6Mk1zfda70dxdL7/zAKDjxLLYjIRDoxcPGtIz3Yw
 o9yCyT7gPRArOMwjzTaOBE/QLgBhNoHQg+AMlKhsEpD/gXmeX4DqvMGx0cBAAA=
X-Change-ID: 20261008-pks-ci-housekeeping-4cf7fac3b0df
In-Reply-To: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this patch series is a result from the discussions in [1]. It fixes a
couple of smaller issues in our CI and bumps jobs that use EOL Docker
images to instead use supported ones.

Passing test runs can be found at [2] and [3] for GitLab and GitHub,
respectively.

Note that I've also merged the Meson changes (ps/meson-improvements at
ce4a600322 (gitlab-ci: fix hanging MSVC jobs, 2026-09-24)) in there so
that GitLab passes, but those are not strictly required as a dependency.

Changes in v4:
  - Make the test in t5004 work both with SHA1 and SHA256 by forcing the
    repo to SHA1.
  - Link to v3: https://patch.msgid.link/20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im

Changes in v3:
  - Rename "linux-exotic" to "linux-feature-testbed".
  - Link to v2: https://lore.kernel.org/all/20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im

Changes in v2:
  - Improve commit messages.
  - Rework the "linux-reftable" job to be more useful instead of
    dropping it.
  - Link to v1: https://patch.msgid.link/20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im

Thanks!

Patrick

[1]: <20260906151137.GA328152@coredump.intra.peff.net>
[2]: https://gitlab.com/gitlab-org/git/-/merge_requests/687
[3]: https://github.com/git/git/pull/2445

---
Patrick Steinhardt (8):
      t5004: fix test creating an archive with large objects under SHA256
      ci: fix "fedora-breaking-changes-meson" job
      ci: drop unused "linux-clang" logic
      ci: switch away from unsupported i386/ubuntu image
      ci: rename linux-TEST-vars job
      ci: switch away from EOL'd Ubuntu version in linux-feature-testbed
      ci: drop now-dead Python 2 coverage
      ci: improve reftable test coverage

 .github/workflows/main.yml      | 11 ++++-------
 .gitlab-ci.yml                  | 11 ++++-------
 ci/install-dependencies.sh      |  8 ++------
 ci/lib.sh                       | 13 ++-----------
 ci/run-build-and-tests.sh       | 14 +++++++-------
 t/t5004-archive-corner-cases.sh | 42 +++++++++++++++++++++++------------------
 6 files changed, 43 insertions(+), 56 deletions(-)

Range-diff versus v3:

1:  507e7089ef < -:  ---------- t5004: skip SHA-1-only test in SHA-256 repository
-:  ---------- > 1:  25e4fe2c09 t5004: fix test creating an archive with large objects under SHA256
2:  f84df9f38b = 2:  10addd4745 ci: fix "fedora-breaking-changes-meson" job
3:  1b881f2e9e = 3:  7e6ae01f41 ci: drop unused "linux-clang" logic
4:  02a6626c5e = 4:  8a5707e477 ci: switch away from unsupported i386/ubuntu image
5:  f515ac9160 = 5:  68d62caa4a ci: rename linux-TEST-vars job
6:  5528b7d564 = 6:  d1bc4ddd69 ci: switch away from EOL'd Ubuntu version in linux-feature-testbed
7:  a12f3fbef0 = 7:  5d52020434 ci: drop now-dead Python 2 coverage
8:  5c37cb46f3 = 8:  c6b6e4c63a ci: improve reftable test coverage

---
base-commit: 8e383dedc6bbc4fd7bbb203512fbf2eafc151e04
change-id: 20261008-pks-ci-housekeeping-4cf7fac3b0df

