Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA435371056
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770640957; cv=none; b=aZgeR1cozJNCm2ojedfWrDkipqQNxfCjh7wxrybLl/x8FS1DcE1UGHaqoRNyS/kKHJ4QidvAAp470ftOP7B7VqO/rTIlzRajtmprrYGW6gsxW1k62RaFP6r/heyIwGayP2dv3tlhQNe8zpjLMGc9UJchrwI6XfQAFjfcVwqHyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770640957; c=relaxed/simple;
	bh=6X/b6TbEF33tYgSK7gUpdbYoJ7fMIPiXGjGbWQy9N/Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bw1/e0MJPXN6YTUMK8ydumxKSGsasWZOqZy/hIiD//3uj/rscGnfJ05Tj6OleU3H+FpDKASTWCrQgDthd3W6SLvoorG4ihArtClkYC3837Vl3Ux865eQu30QeRVBvFMpv+SnTHE3jaoJORj/D9FZv1x/XhXPC1djeeLusmsKMyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iEcelhnl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j/uE7yfV; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iEcelhnl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j/uE7yfV"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 12FD07A0114;
	Mon,  9 Feb 2026 07:42:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 09 Feb 2026 07:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1770640955; x=1770727355; bh=tFgikIWx2e
	Zq9DOBFNDHFHzgBGhu14We4LxMU21+Aqs=; b=iEcelhnlr47kkqmbl2bOwKZ3Pw
	K4yf0U5wxKbeHUuxIZ7XJeGdyM4U/bI46bW9O88M1lOXPxALkk9vv0WAWebddQiZ
	7nB/WuzHmZ8lMCcXYJfL6na9JDqpDGFPLmhMHhCGQynnfkxkSu35C7z36kLeNCmO
	lipdunHu7N1LZL4A7SiujVdjBRzVlx9Fy8vQ2q8Yv/w3tN5GlHfI/eqv3lpdnj9y
	rv8hmMkgMSURtW+BxrwyY4aiiL59h8IIgSVS7NdIxLgSQI81M3S6RtieLkAdtYxY
	GDtScewocydt/cZeblFrEIy9YJ5h3VZuceOxIHFJaxXOmpik1uDHQhHxSIEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1770640955; x=1770727355; bh=tFgikIWx2eZq9DOBFNDHFHzgBGhu
	14We4LxMU21+Aqs=; b=j/uE7yfVU0lhLL42dSnR/aQP89HrkF2h0YO0bnGv5uMW
	p0Bou9anQAfdscQWUsBRdfELcfygeg2ij4g0TV7IIUthKyBskriHmxNngzAQXSBK
	+V4WYrgkhsUvqms/ZXGqZgXsmaKgISbu3ZYv7XEMvr2X6CuY/QN/E8kP9o5USHOI
	G2MQVeftQx9oZCs/aVfp/HuV4pMEPvrCfV5Nh9I8W/kq3mI2UwIxHMqOkHevfptB
	iQv2KGEPXAto3ykxXF67LVZfKQIV9hKyb7GtMHnbhmR8YqgDXpR5mwuE4TNjnCKp
	trnpgSLPCmNGkHkCVp2TGWsl8JdBE+zF0xPW1vcQQA==
X-ME-Sender: <xms:O9aJabWwkYdMSmIiTe-jpoUMBu7gmreMG0KBjCOfR-rEOh0ytrtyNA>
    <xme:O9aJaZl6OlMMVYbk3fm87PrqUjCUJZkp7bO_yep860JTNfJpTQ7TzJ3jMcGzMM_Ft
    hvD12z6mGAvfG7U8s-Y330BcP8Dw5kfM5hTW5MdYeJkK7DqoC3fHQ>
X-ME-Received: <xmr:O9aJaVCfYOFFrwT1n1QinSQmF54X4zaTeyv3Md9fVSTmrboaTCoL-Z578WShJwOyEg_aHt3t_R930SbK-TS1i6SWUz_2XUufHTqjqprrL8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeikeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepfedtgfekvefgteekheefjefhledvveetgeduie
    ekieekleefleelvdeuheehgeefnecuffhomhgrihhnpehhthhtphdqfhgvthgthhdqughu
    mhgsrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:O9aJaRf-3ypo-b0tlIXP8N_Q_f56fjdgc1aejnWtX4ldT0WJK8R1yg>
    <xmx:O9aJaYJXopjcoMiBh2EZS45IWINwq_p__xJx1qf4vOwxLiYYtsmruA>
    <xmx:O9aJacf5Ld2NvN5jAq28zOo0H4vl9OutRVRCNDs7_C1J4WPpK2dl9g>
    <xmx:O9aJaX3WBCw6c07Ksj-Yi56kH5mAIwVt1MjO0InJ_6mwWA03j0ABZQ>
    <xmx:O9aJaWs9HsJSZ3kKE3-RIhv4bFtRjo9sDADdKc-uTmOgmy7JCdcL17aV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 07:42:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ecf1810 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 12:42:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] Fix tests with missing iconv(1) executable
Date: Mon, 09 Feb 2026 13:42:03 +0100
Message-Id: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABvWiWkC/x2MQQqAIBAAvxJ7bkFNovpKdChba4ksXJBA+nvSc
 RhmMghFJoGhyhApsfAVCui6ArfPYSPktTAYZVplVI+LxfsQdIynJIfsrpDQ80OCulnJdkq3tvF
 QBnekX5R+nN73A35u4iVsAAAA
X-Change-ID: 20260209-b4-pks-ci-msvc-iconv-fixes-13de4801643f
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.3

Hi,

I recently noticed that th MSVC-based tests in GitLab CI started to
fail. The root cause is that the iconv(1) executable cannot be found on
this platform anymore. This isn't entirely surprising: we depend on the
Git for Windows environment to provide necessary shell tools, and that
environment of course is not a fully fledged MSYS2 installation.

In any case, this patch series fixes those issues by building on top of
the ICONV prerequisite. If the prereq isn't found, then we also don't
assume that the iconv(1) executable exists.

An alternative strategy would be to introduce a new ICONV_EXECUTABLE
prereq. But given that Git doesn't perform any kind of reencoding itself
in case the ICONV support isn't built into it I found it to not be worth
the additional hassle.

In any case, this patch series causes the MSVC jobs to pass again on
GitLab CI.

Thanks!

Patrick

---
Patrick Steinhardt (4):
      t4xxx: don't use iconv(1) without ICONV prereq
      t4205: improve handling of ICONV prerequisite
      t5550: add ICONV prereq to tests that use "$HTTPD_URL/error"
      t6006: don't use iconv(1) without ICONV prereq

 t/t4041-diff-submodule-option.sh             |  8 +++--
 t/t4059-diff-submodule-not-initialized.sh    |  8 +++--
 t/t4060-diff-submodule-option-diff-format.sh |  8 +++--
 t/t4205-log-pretty-formats.sh                | 50 ++++++++++++++++------------
 t/t5550-http-fetch-dumb.sh                   | 20 +++++------
 t/t6006-rev-list-format.sh                   | 29 +++++++++++-----
 6 files changed, 77 insertions(+), 46 deletions(-)


---
base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
change-id: 20260209-b4-pks-ci-msvc-iconv-fixes-13de4801643f

