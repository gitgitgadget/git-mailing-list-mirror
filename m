Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98523793B1
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258964; cv=none; b=ZE60rmzRpPRkKL75gT1R5egCthUsti+OcgxRGX5ghLmRmcnZhcAKqQtArUiVMheSe+4O9Z6GFT8WBhPPJxnhDBEaq0E4Jtj/3wrbDIPb/btGNjjNHnO0J4FQJPk1d7N4I2b2HheD0W38I4pt77466A3m+dN1U1L/XpZ+ZjMwMz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258964; c=relaxed/simple;
	bh=JZaGiXcTIz6o0SVSm4o0wX2ovwndhkk5v94puY0z6GA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XYnbugSwKNP6dSgYdvPVOlmrBzzqRfEgxvrt4Bbs3hvWVIUu7OVy5tEaZzLx9JrAg6wUd1+775PxXTHWU/VIeO28WdZFyf47VzNIUB2kXTbEjoDtmJfygKc4iPvaT1khFJmxawgwxQsAVM8M7BZ7Vwkd1qndXZ8jZAoBYQZYGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U+xzsg8B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IArBG+b+; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U+xzsg8B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IArBG+b+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 041751D000C0;
	Thu, 24 Sep 2026 10:09:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 24 Sep 2026 10:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1790258960; x=1790345360; bh=/f/Jw4fAxH
	AtB67r6tZVM4dAUG36U6s65Hx4byQHgsg=; b=U+xzsg8B5oMv9HIMnPZnpH63XC
	/UfS1DhMms9v89zMDKCymxDCT1GHt4Wuixfa2imQYFOeRjdQ0rw3HWqk0oL5WfQO
	d475Id3GfJbieu7oc4bwUmFa32dGg8CEP870KFq99s39D5/dTPwl2V2NiTOCUMSp
	MOutIqLjVxQN2eQdObxbUj0mbes1FjsQC7DzZmlV9lsIa8p/7fNWaaL7g2aLomMs
	RXS+UXIMN6CzEWQ9+426kXvlbiAe+UhEFtlAZIf0NTW2rtB2xVwKQaNK2kUPQio+
	FNjhz/8QjOQbQDs7LnGUK79iFOYaE+WZTFKrB4BwmlxGHuOqUDtj2zSZwsLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790258960; x=1790345360; bh=/f/Jw4fAxHAtB67r6tZVM4dAUG36
	U6s65Hx4byQHgsg=; b=IArBG+b+YB843wRosx4czr3J9L38vYWMHt/+cxi7NQda
	4pyhvn1Zq4dQfRSO/HejS05V+mLwDvLVCuhNF6+s1mpj44L0fOkz51PkruO3nnH2
	NAhkyO/6wW9x3pYC3BlZYmzFoehkfgbdI5DhhnRzhwImoI865ypU2ACdS8x/XdF9
	aZNrDQGCOE3su1QF2Q9namozv7iRTviurVNMhMvlyqTgaDcFkiys/K1cIKYMaboO
	eDbSNPQeN/jH45cRC7ppGyFYFqEjBEd8QvgspJ/l1qzzntlvdy+eld1i7f2z+Z81
	dBn5H7PSJJpDA1IgM+uiTl/bDmtF0EnvgYZ7iVJ2XA==
X-ME-Sender: <xms:EC-1alh1mPg7ovphVQcA7BXErFZM6eufoINI7kj3PyLgDb4glS3Tcw>
    <xme:EC-1agCmCihfqb0RKerhILHuVKsI5Gdt2fS7NxGHMnwn9ddQazhWampnfAm3S8Q6M
    V4OwiGduWB3i-T1THAjykjYjotAcBkItvHazdtvqWql98qpRIQcpVk>
X-ME-Received: <xmr:EC-1aiuk9dmJiSm3EP0rwH_3WBiaktrrWeWvDoljofRPzZmzPvbihEmW9W30wwXnHSDHnzU>
X-ME-Proxy-Cause: dmFkZTF+SoVW0pedTkeOqnxANNNxYAHek9Z3qcuVg3+UWJrQllA4EssNE/mHVfEZpcSrPw
    UtdtStnyTr4YWOY+8F2tF4oRmuQQjI2bQ0PbIcb7iEfxiM6Y8D5i/C5DRuknEObxR7Ptfn
    38Mzcf0HYFFzOYuNp15EAT/D2/gcYd1bIIG8MuYvaV9yooBBvTsU8sJcSLciNX52XQg8KE
    lX8Qp2WWmHm5dVtKOw6EqNNB1VzKyUwxOciww87LTgaDPkqkinOQIlch4au1RK79ajUwWT
    MUlWG2amiLry6OAjO60dD3dwEnpq82QJPMbT0JeVO40QwZvNRi8PBgG/A0wjw+A7gl3IJf
    5tIm4neU3V+B36oZZwsS7pTjIc1Mi+5em7kDETERjQ9UC+5UN3odLH8a4XtFIi1ZonMpXw
    +GlK6khTCo01dQ6JPfm6qYkzDyX5nWX05NYJaweauxj5QqIH9M7VvbQ6uEIT/xFXBQstQT
    X0XSF9DIRntZqJt2EN/pSNDEh/YTjv3+EZopyZRK1c0cdYblFjyPCsl95EOOQ5J6mG6sfL
    pAh7WlNfmwVVt9gv3i1gFeXvFEjmL2PxCduMt/8nlrmGclJ40WzDYcAIbYC7cO92KtWMv9
    SNuiN3YecuJwSTbe9z8kO/fgz7z2Rxtu/tSyP1kZiEwv495UBpOWn6Nw6xpQ
X-ME-Proxy: <xmx:EC-1albRk0gzdyKjvoGbuxq6WMKDzLqpkRxhPvsVkkYxQgeu7bxCcg>
    <xmx:EC-1alXjES7PrVgh5-GllFcNaPPJJLuQBZuBLtF9cZ5hqfQ-2xMCrw>
    <xmx:EC-1ap4U0JUJDlx0fdBMdRnvfqmtUxgCQA6rgLC2Paxqg6i30D5RJg>
    <xmx:EC-1aghuW52FP9saeNuPpz1ktvIvNM7zkkPxTCD2Qp5Wu27LV9TYkw>
    <xmx:EC-1aiF6jUXWJuWtaKDed9rMvvNyvNdmX6lTaeyz9V9m0BZzSny8Xxr2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 10:09:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c893c68d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 14:09:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/7] A couple of Meson improvements
Date: Thu, 24 Sep 2026 16:09:09 +0200
Message-Id: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw6CMBBG4Vchs3YSbBoVX8W4APoLo+klHSAkh
 Hen6vJbnLORIguU7tVGGYuoxFBwPlXUj20YwOKKydTmUjfGcvooe2gMLD7luMAjTMrdFa5p7Q3
 OgkqcMl6y/saP5986d2/00/dG+34ANVI3mHoAAAA=
X-Change-ID: 20260924-pks-meson-improvements-b7ed9a48ed4e
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

Hi,

this patch series contains a couple of improvements for Meson:

  - Clean build times are sped up, going from ~6.8 seconds to ~5.0
    seconds for a full build.

  - A test issue is fixed that causes shell completion tests to fail
    because the scripts are not properly updated.

  - Our subproject wrappers are updated to current versions.

  - A fix for GitLab's msvc-meson jobs that are broken right now due to
    a change in our runner images. See [1] for the now-working
    msvc-meson jobs. Note though that the MinGW-based jobs are still
    broken, but Dscho has been sending fixes for that already.

Thanks!

Patrick

---
Patrick Steinhardt (7):
      meson: avoid recompiling HTTP sources several times
      meson: don't recompile git-remote-http(1) multiple times for tests
      meson: use precompiled headers for our test-helper
      meson: use precompiled headers for unit tests
      meson: fix outdated completion helpers
      meson: update wrappers
      gitlab-ci: fix hanging MSVC jobs

 ci/install-dependencies.ps1    |  8 ++++++++
 contrib/completion/meson.build | 38 +++++++++++++++-----------------------
 meson.build                    | 16 ++++++++++------
 subprojects/curl.wrap          | 19 ++++++++++---------
 subprojects/expat.wrap         | 21 +++++++++++----------
 subprojects/openssl.wrap       | 23 +++++++++++------------
 subprojects/pcre2.wrap         | 24 +++++++++++-------------
 subprojects/zlib.wrap          | 21 +++++++++++----------
 t/helper/meson.build           |  1 +
 t/meson.build                  | 10 ++++++++--
 10 files changed, 96 insertions(+), 85 deletions(-)


---
base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
change-id: 20260924-pks-meson-improvements-b7ed9a48ed4e

