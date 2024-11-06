Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099E7204F99
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905898; cv=none; b=B+BzMnNRg45siCLpUwyl5TX90M4I/eh6B4o4DolMY7Od5dR1rgBI/sKiNH0gsC6SRZ/plhH7HhOd133JghsX9xuol5wQwN5s+PLAV2ZSf3cvuE2jTziykHBCNmMj9eteWDv8HfNyme8Z6ZUHPfRKpEVD8oWCNzGugt7q1pbl6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905898; c=relaxed/simple;
	bh=IgwnOLKIFppyvrou4xggD5JWJuoP1pGmuXN6kMdq3zk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ah6+xWGzjTqRvL8UGSb0QKOCY+csAyETlI2bcm2qMkEJswAa77euJR+aPHemEORPHWBA/UADHnHtyQnDsyDluwVPG8RctaGAv7oN5Q3AlvowOMN6sxADbayIDTfC9ApHMP1pr46OR0QSK/+bBn3f4yvKyEy15fgdLlCYqquo3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U/SMAEvd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fh9fJa3y; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U/SMAEvd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fh9fJa3y"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E2261380665
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:11:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 06 Nov 2024 10:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905896; x=1730992296; bh=g7EvcnQDc5
	Otqo/iYhQsVzZqT3jGQfnSigQQLTaFxu4=; b=U/SMAEvdrdl832RZBVIC5G6fDa
	Eoh25Tao8yP6tiekPxycAd4DeZsXLAtcV2mGQNnZ2zzsKXUuCkW1MBgWtn9EpTIs
	+sENOMtR1M8A5KIQ/+AJWt2ipNfdPTeQmfEmit3+CwlkysLbPTbbULD3fs9tXjzq
	hXMYGXe2kbqKM5jfJph58o43a2TEW989eGvAj+n5PiUJqkb49IpBzDjdSnNW8n0Y
	GdqGvaPvROCCBwz+H+BzKqBFZwhXFQ8FUI6rHy0JPSaA/uUBt7nTlhz9FeB+CL5B
	D4r137xTaoRejBUq4/8GQOh1pVNnVNWUvvE4OUSQGvme8xewWKbH2Gx9IY2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905896; x=1730992296; bh=g7EvcnQDc5Otqo/iYhQsVzZqT3jGQfnSigQ
	QLTaFxu4=; b=Fh9fJa3ySf6/qxkqtDl6ySO+64noSQw2QNmZkgsHIVXYpDTAGpe
	dI0Ix/ZrKJ+izeEnEGRFPeJ7rPKJ5ZPOBT2vw1tuTT+eHX+xpcH50kRL5LcFPJB6
	tg1nBww6CX+07Uy7f/euFH+c5yMuHQ/75tcOKYJUIVsHLEcF9acdCseOp4w5Aeos
	XMhU8Z36Ziiy1H5+u9CH+vtXwgP7YL1blHtN5wUAjm5+kbLa1DxJy+hoLE/VDUS3
	OFY3K+3cS5SADScFoY4NIIA4os1i2i2EGEDgP4rnGLQ5Eq4UOLDmdP0C7yW9RTYn
	R/sFiz6GDJ40Msy63CQsVLOIVV9L4mRMM0A==
X-ME-Sender: <xms:J4crZxps9h8aYOt1FQ9qyJtfHFAqHoIGib2Kt_Qnl9Kmo3X8MkPo0w>
    <xme:J4crZzp_-XxEPD2rY_FuyKF2TkDx2B9x6S7EsiqJyjuVt-J-V-BrWhH_L8ssKvvJ8
    sjtj-6jRpNkt9u5ig>
X-ME-Received: <xmr:J4crZ-OfYetDRwLBTEbsEBpwA8XPPsbNObxv8FGTXv9I_pmmxJqAUApNJ0RF2vCUukLdq6Nz_ed538RPPpfBp_EigERRPnO_GeZqZFTuuxlbhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KIcrZ85xXnLjnnRrH4tkYf5lo_5iFI0fpqn01SmL07Kinv1gV1p3ag>
    <xmx:KIcrZw5NoVYthS-EkSm6PXmvdJCMxu5H9F7wFed3nk-zThmk9OPUsw>
    <xmx:KIcrZ0j_tntCUjkf6N-jZfl43O4m6i-qWPMc_gHkiU6yzwQhsV38NA>
    <xmx:KIcrZy7zQk9LsAjwuAdgjjJ7dxIy5P0m_Y07STuOrNu0s8EAm5_8AA>
    <xmx:KIcrZ-So-Ob5KoD6G157EL4hHvMNq7IfpES8RNjwg2nJOldRZF8rX-Be>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:11:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b9252a53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:11:10 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:11:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 23/26] t: mark some tests as leak free
Message-ID: <38c97f34d7fd7f5442670ed84a52e227f05fd58b.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

Both t5558 and t5601 are leak-free starting with 6dab49b9fb (bundle-uri:
plug leak in unbundle_from_file(), 2024-10-10). Mark them accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5558-clone-bundle-uri.sh | 1 +
 t/t5601-clone.sh            | 1 +
 2 files changed, 2 insertions(+)

diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 3816ed5058d..b488b505b92 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -2,6 +2,7 @@
 
 test_description='test fetching bundles with --bundle-uri'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bundle.sh
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index d0c18660e33..3b5285cfcf3 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -5,6 +5,7 @@ test_description=clone
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 X=
-- 
2.47.0.229.g8f8d6eee53.dirty

