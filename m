Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB25374162
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656188; cv=none; b=Xmun0uq5ZChC4cffMwvMCtM85dHiqzXpJD0TEej/sgtjTHt6L/sCN9Dy6iuJKpNO/4rVDOSVqwpWvKFUkYMLrD9ELzyhkWReo6Z+TUPtwa6rSXqNjMV/TQYulojeaBpv3ugV4UiMmDx5EFO3Z5tfK1F3+HrRMr2ASY1MlrN+GkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656188; c=relaxed/simple;
	bh=re6N+2iZ9x3onmDuR5KgpEZkj3D+5Zz47SFVJP4MNc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=emlTqQ2txsuXMU5yD4kVwwofGNrOV8ytwG4KzONrlmEkE2NKPbKYRaSnAeNRx3ALSkxMXeqKGUA13qiq8422slpEbGSmGl59Kl+wcxuIl3bUTV4NuovBQHNLMSKEXoB4flC/98HE5HG1XWVW6wmUC+QGH0wPxfSBwo3vZLA+Fc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aVd5Xgpt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qfQVf7H3; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aVd5Xgpt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qfQVf7H3"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id F0CF31D0016F
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 11:56:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 09 Feb 2026 11:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770656187;
	 x=1770742587; bh=hqqS92WKEXovTxHBvRVuGFklv4SEB+U7hxhGAH6Crrk=; b=
	aVd5XgptNLk488mQHp1acOu6GmYplSK/sXKmJjGnyYMlHKXn98u6x4o5YoF/StLz
	A0/GgNpkiOMdFtBBNEFurhRifUuWVrLtDNo4VmfAnQTUlgaJzvfXsSitJw8KlTvo
	RdDuP9lxJejKDdBCpggoxyTh++yhNlMbwnLmQqe6J71LmjdPTzgQoEhCUCDxCbwr
	em1B4BbrihBcI1n+QKlf0s+xISKcPJ/Zcdz5sHTpvrQZE8DyEfawNhVBQ9b9Qy4L
	6Aa1AAf3oDGvgi5A1SaZYi6arYEuM/XYId8DM6F3XCo/3ltZZd8a7xC5uuFdEqH/
	ssIgetQfYwr+d2GhFYblyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770656187; x=
	1770742587; bh=hqqS92WKEXovTxHBvRVuGFklv4SEB+U7hxhGAH6Crrk=; b=q
	fQVf7H3/yzz5O1/rWDKTu3dUk0nRdF3ihMtyyZxMYCMrWZpb046pRaR7UJ/igkkp
	64Pcdn7ByH9sL55EjGi13XBxme19xPD8hoiufYjs3gDAH8WyZ1vMIsuLilI+CWx+
	HFThLVQOicaN0zkUyXpfXbuj45IVQNJ1hUGflgaSrltQEOBkeEvlT6EFCCuJQT3I
	532xqM2FhFqANrJOeWuMWf4prxK6zFQWW7uZGalK7GNVxaBV4satUtUtR2L3ytkT
	Wu+zbH4Yt9qF94V7/mCT2l1hhdiK5cI9tFOSNpLMErQC2jFT7qxvGCMj0OJ82l9j
	a3DyDiaS6A917r1wLPExg==
X-ME-Sender: <xms:uxGKac_fDQGk0Y7rnkR_5_yw3muyqMTX93BNIMpFqiVsUO4sjJwzrw>
    <xme:uxGKabpZcGWYr1FGJOjlBS4352mn7KfTg9qfTB56LolrB4dEHNzkpUos0IImRudkW
    4gfRH92ZP6JpYmHImXe9tWoZUy-HSu5exD2pfRsk20hzGasWIU1Elc>
X-ME-Received: <xmr:uxGKaXq7DaEWeUyd8WVpGDYTusn7KLgjsbuKvflPqFA9SVjamhKLJGAeaxCrBJbgnSfOzv0DOeXGmbgqsqZIr1kkh-LSWwt31d1vbw72mRE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:uxGKaRnwNfJXODXkQRksd7pEwI6ZJa03XW1PqdxDyyW51XluC4yBFA>
    <xmx:uxGKaRGm3jwsBEpmjeWMcC2osV8-AnPozB1GHMXw1xa5QuSCyxQD4A>
    <xmx:uxGKaSroVotfsMTjJu13xjPFf7WgKF6tkpi7QHRWHPbaqpmdgQmoOw>
    <xmx:uxGKaV6fTerLObWwuYNvFL_VgmMMe0X4q_OIgp9X5wHaqI-E6RslDQ>
    <xmx:uxGKact32ngSYwCx0u_AnTvv5aXb3ELsU9QOaN5VURMX9XML-YCo5EEM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 9 Feb 2026 11:56:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3ef69929 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 9 Feb 2026 16:56:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 09 Feb 2026 17:56:11 +0100
Subject: [PATCH 1/5] ci: handle failures of test-slice helper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-b4-pks-ci-meson-improvements-v1-1-38444dec4874@pks.im>
References: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
In-Reply-To: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The "run-test-slice.sh" script executes the test helper to slice up
tests passed to it. As the execution is part of a pipe though, we end up
ignoring any potential error code returned by the helper.

Make the code more robust by storing the tests in a variable first so
that we can split up the pipeline.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-test-slice.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index 0444c79c02..ff948e397f 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -5,9 +5,9 @@
 
 . ${0%/*}/lib.sh
 
-group "Run tests" make --quiet -C t T="$(cd t &&
-	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
-	tr '\n' ' ')" ||
+TESTS=$(cd t && ./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh)
+
+group "Run tests" make --quiet -C t T="$(echo "$TESTS" | tr '\n' ' ')" ||
 handle_failed_tests
 
 # We only have one unit test at the moment, so run it in the first slice

-- 
2.53.0.295.g64333814d3.dirty

