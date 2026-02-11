Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89521369210
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806095; cv=none; b=ZuoiZ68XZ7l5Avpk86BssgOXT00RPcXY7nrZOEZGfO9HJ3KvDVanWv774ljSDT5T3cnuH9tInyPT3E7+zX3VZKCgWn9lsKNj31LYLjBaXKUokadkgILppJQczCB91lcrqv4KYQxX14gxaRGFGijFE5rXe1zhw9gRX8nj0fM1V50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806095; c=relaxed/simple;
	bh=qPb2DUtmc/b7/exeRu5m86/RsDSN2pfUVQMJLr84/54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYdjTSf7iZXr3gnoLNaU2MnbXVEju0fBrKVAEGIlzF+UqkrzUeceHKs3BT3Zr/++78bDKdltNwpZD4VbK5dN2M9FU8iq21M6hJUJBouMEFyPAm2Lw4ZQVpqRp2ZbJR9uBK0vW9xDNna5ofCT6Ykx3ZZGYNuBVybxZ2eN5KgUSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pioF/1ox; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cm0lp7jE; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pioF/1ox";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cm0lp7jE"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D04457A010F;
	Wed, 11 Feb 2026 05:34:53 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 11 Feb 2026 05:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770806093;
	 x=1770892493; bh=81l/0jILJZzma4z96DQJIC8BJFsZVFh7OAeN3vE8sq8=; b=
	pioF/1ox15Q21w3IBnll2QwxHRMbo/vKrzf5KgLjxT6te7fIZq+ZCwnN7HaTYKzR
	DKy/Q+liaQkEA34NKulvP2OXh25ds3/wlLKC5yAVpHEYsJrqtIFCxgGTA4dDwCcs
	1b5ogJQSTglOUFjnnIEVC2CrtHZDydjqa8qew9j1Mp7zm4efd/gEagDjgpSFhSgK
	5o1JPXLu2ZnUvDjDB2hNjNra9buRE2oxUJk1776fqwBpQsNSKZ4GRUeMFTQshrjY
	ogm7fcLIdu67HkbyOkTbiWrkoJ70626CaEkscsCaIntU6D54Nf6tNp6oRk3Hdb4V
	kWVQssVI4uWWHcKoAjyDNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770806093; x=
	1770892493; bh=81l/0jILJZzma4z96DQJIC8BJFsZVFh7OAeN3vE8sq8=; b=C
	m0lp7jEPICPrDPPAmNou65tDI8frfqLd38k4BqWL6F0GxN35Ariob/MHetxYnYR1
	CWHbwcMVwUeL6F5bKdkeq7wGFPGh5fK+rAfX+Ki0B+ddypd4oOSkmXy362IGuzNP
	t+7ImBWH33N6+biZF+hEsOhiTFzqdRQRnrTBEpOWC/nqycLK/lcbcT6tzbH7x3fg
	jTufrnvB+9PQ0tw8ZdtqEi0Yw+N+RT6kuhbpUZ70UXx+ttCM4TRUYyGV0BrLvNLh
	nF5hEmnTICIkYe5/NmWNz+gh0vMCTAYHvDbhYns0+q2Oa3WqWA4oeFjT709ur+/m
	hZ5v4lxwRu8Tg5FsB3AKg==
X-ME-Sender: <xms:TVuMaQoF3aWXB5nBM20lCsIONcmOSicyz2iARRHjcbqELvluIemHVQ>
    <xme:TVuMadrhCOa1Fv583mN7yhA-xe6RvZ1aaJi6d4EK1NINvmMiTN0s3Vn8Am1kNk9-M
    4Wf7AlNA1wNRzl_uinDSbSz36mkKz9bK2qV70feYfsHy7je1etnog>
X-ME-Received: <xmr:TVuMaaMTlJuoXnjn8OY_QRS_fAST8_7l0NdUrgIEqiYEq4g3Xe2macprXa8O6xFh39USR_0vfHL9pcDWYb69U4c6tyG7QWKELiD5YZBf_Yqp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:TVuMaWzcFJXhKkEzYN6hV2BEfyxC0uUX9afjOv0MB2UNpdFEHacfUA>
    <xmx:TVuMabsXvMC68wGqNi_KjT3pxMgeQOo-2XDj416_aKUl5tCmf2q3ag>
    <xmx:TVuMaX5qYmbJwwnbzg8371v1-CQa3fVcVtpFjdregN_L2coszkYZjg>
    <xmx:TVuMaSSfp_uYJAPYCLiIot6XnEp2KMmJVgu28tVUmEszZtTbNO4_KQ>
    <xmx:TVuMaQIut_X1Cs2IdiH8hEwf3BV5ia8lXU4fDR7qYaqjxaDduX5S2SRB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 05:34:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ef0ebdc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 10:34:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Feb 2026 11:34:31 +0100
Subject: [PATCH 5/7] ci: make test slicing consistent across Meson/Make
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-b4-pks-ci-meson-improvements-v1-5-cb167cc80b86@pks.im>
References: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
In-Reply-To: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

In the preceding commit we have adjusted test slicing to be one-based
when using the "ci/run-test-slice.sh" script. But we also have an
equivalent script for Meson that is still zero-based, which is of course
inconsistent.

Adapt the script to be one-based, as well, and adapt the GitHub workflow
accordingly. Note that GitLab doesn't yet use the script, so it does not
need to be adapted. This will change in the next commit though.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 ci/run-test-slice-meson.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 76ef513e72..352357965b 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -298,7 +298,7 @@ jobs:
         path: build
     - name: Test
       shell: bash
-      run: ci/run-test-slice-meson.sh build ${{matrix.nr}} 10
+      run: ci/run-test-slice-meson.sh build $((${{matrix.nr}} + 1)) 10
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       shell: bash
diff --git a/ci/run-test-slice-meson.sh b/ci/run-test-slice-meson.sh
index 961c94fba0..a6df927ba5 100755
--- a/ci/run-test-slice-meson.sh
+++ b/ci/run-test-slice-meson.sh
@@ -9,5 +9,5 @@
 
 group "Run tests" \
 	meson test -C "$1" --no-rebuild --print-errorlogs \
-		--test-args="$GIT_TEST_OPTS" --slice "$((1+$2))/$3" ||
+		--test-args="$GIT_TEST_OPTS" --slice "$(($2))/$3" ||
 handle_failed_tests

-- 
2.53.0.295.g64333814d3.dirty

