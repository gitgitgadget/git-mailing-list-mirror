Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A3C2FC011
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771482348; cv=none; b=BwmRTzjy/vlnuRXTCP3kuDKCtFASfEiiUnzMVW5zmUQCe/xg50TiG7TJgvEZW0Qj5g7fKbJ3kLOCtwOejOPVUzEaMuNd7roRLB2yO8VKZnWOwwczZQDiGzxQjN7hxuDHEPERSfcuY2pPJQcsSJmlhzMYBTnrb8v8lswv75RaVZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771482348; c=relaxed/simple;
	bh=of9YFbZQqy9WucAjrkx25+uSXPgRgiiuGEUtkda6/Ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uj8QXyaoBiWlb1TcHTga9lW+JuwU9nyDMM4fjE/dGQT5omM3zt9qSpFOeI69EJZgqkeS7u0uwhx0EfaN8MoDvzn+GwT8Cn0gjO2ls4FWH+wGQLb1qVYlaCwaVgzRXRajGhyqvj03Ru+BiCgTP2CKOWMnFP9ZJmXDfcDE8Kie0vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RrN8Y2AO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jfOR47Vm; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RrN8Y2AO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jfOR47Vm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 36670EC007B;
	Thu, 19 Feb 2026 01:25:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 19 Feb 2026 01:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771482346;
	 x=1771568746; bh=CnOEr+ic5w+BDYaSJhBvZjBt97l1jf6VnzW8MRMAloA=; b=
	RrN8Y2AOHP8V+iqKMB22tgY8qlpzK5eSHMfCIKcM2BavnMrle77F8gVHT+haQH+a
	BTkOrhox5GUbKN2hNjugULQ6i4SyqIfX9yXfIViX00AbJDgQFCM33ZyTQnm9Hrrk
	xP/B5DxA/UdJpKPO0C5dQAXwkJZN1975O4HtmgUElbO0jTbY/yfmzKqMJ6ODDvgf
	gRNhJ6a+Yb+EB6NRq0+PgI2TxebQxpzd8JZvJf9lIQva93TxzggoqScEGA+njdkP
	WsJaB/FDzzkmLEYam+6n66JH+o3eQ2M+02UDVCaPiTm1k09SA8K0sbhhvqzEoebZ
	P2+DxSo2h6EbKaeY6n7+AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771482346; x=
	1771568746; bh=CnOEr+ic5w+BDYaSJhBvZjBt97l1jf6VnzW8MRMAloA=; b=j
	fOR47VmRhuhVi6VVlLdR1RszoQb2zV/Yo9Yo5hBy+QUV5qKdDFbGa7MM2WIU7LOy
	o6Nvq4YmhxmXVJATYfjLAaU6W13bto8eg/08UzgIAncanrXLA67kVV86bMyD/4I2
	NyKR4+81vUYRD+NvifVAC/sCmdG90y3eGP7+xgARkXP936fcI4biClDbt6H83Ko1
	nLcGVy57hyCR+NziQwyjxze2eBl9oPhsWDawCfvhP5AIJzL5erQ52FxiBeOLGuYq
	W8mIGQku2DO1vaxdT/1IdsiEpvr+rgXS2UzG1oanu5GIMYv3h5AaB0LxmnRkt/AQ
	bvBTLeGuQGbr/C0wT8+Fw==
X-ME-Sender: <xms:6qyWaQcWp9Sx1g1B-9gBGPqEvuL1EqibydwlVpK0GZi3a4ZuETSJig>
    <xme:6qyWaZGRjyT0lKi7WbKtculZSG82PKkDt3Z7NViy6f2qcFTbu-lQBcy6vPmkDkiGm
    eRnA1ForgTkVuXehSuAyBeFLqz7aj3w-Wtco9cPr_nka_Y2IAQOAQ>
X-ME-Received: <xmr:6qyWaZ3TpyAbQpPFZjWHA74mMceMc3uy1EgFwTDfZDv5aiQ9vZrNV_tjAAxSDlG0tMrOYjjMSyNm92_icbPs6SMDgn8Ex_tbbIGqCrDNcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:6qyWaRlS8W-kNRBhLEdhZQ03nDmg3Pd4KM29G4w0Uvfa9LsXpTPcFA>
    <xmx:6qyWaZ8npAsYzrtyO5OkHaSVDMDUhWSzvl1LHAkjQUIRywDwJwhjVQ>
    <xmx:6qyWaWoSDt1_baP-Ls6g0fNgpxOaA2rLCqm0oYGCMohEIZ3bowVQ8g>
    <xmx:6qyWaSlbev_FIWI9BZC_jZG4Mo8liu3dmqwaEU5iYwcGCLzvx906sA>
    <xmx:6qyWaXDqPnn7Tcri37eHlzVIoU3LvRlIR-J_LND1R6UBQ8_v3HoctMqq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 01:25:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a4c35b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 06:25:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Feb 2026 07:25:31 +0100
Subject: [PATCH v2 5/7] ci: make test slicing consistent across Meson/Make
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-b4-pks-ci-meson-improvements-v2-5-6047b8307ab2@pks.im>
References: <20260219-b4-pks-ci-meson-improvements-v2-0-6047b8307ab2@pks.im>
In-Reply-To: <20260219-b4-pks-ci-meson-improvements-v2-0-6047b8307ab2@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
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
index a011d8d0f9..826f2f5d3a 100644
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
2.53.0.414.gf7e9f6c205.dirty

