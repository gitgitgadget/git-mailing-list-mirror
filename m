Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B71326D50
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597103; cv=none; b=pwXZ5TDcBMoBf2GEOjgeCpqkqdTfx5L3xjutMcsrUfMPRpaBh/eZ+WramyFbrphFEku/Fz12NupfNIj59Ny9m0L3XzOjHgyCcXeGCsiBiJSaRCF19qBk8vo0lm35YqHu17BK82kqDjfi1dSHO4RVI3/dDRYYB1yYjYnkQ0/e0qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597103; c=relaxed/simple;
	bh=RnUVJ5eRXwU4hZWANsMBaT1gNmCkuASMlreXzofjByY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=asOMi3EW0/XRQjEeYb1ZdZncqNN2KmBksonVq3n0XG17Y9LMm/ZfWinT7MxtfIh/chJzdowqK/9Y5vbTLEOasrmpnxAimmZoIFAal99yyi+tg52Z2GmBH2kuKRetlTvb9Vvk5vMQr78n2upsS80T4cD9CAUueeDVvGoXBcOHxsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rmor80Ox; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i6QgtinW; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rmor80Ox";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i6QgtinW"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id EA4F4EC00CD;
	Thu, 11 Sep 2025 09:24:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 11 Sep 2025 09:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1757597099; x=1757683499; bh=hEbpMbZboQ
	Q9BeLrk1YnHE0S5HpWqXP9PsKKi8jGjL8=; b=rmor80OxRu3+YFqD6IjYVRxylH
	KodgBJ2s4BVSzQgMZ/f1yke3m94TaE60ylknAxVuXA8dZAHpQiOAG/vizvg7DrY3
	kFqMaoGJ8fgqcKFjSxCw2XSLVMMEa6hVR01rZxhtvXSQ3teYn/NhajhiTm49+1kx
	BD8gaiRUakBbbM6pdcHTu59gZ1R3nh8Q7YU37nbpkzPeS8KrnZ0dLf8AUUZis6ND
	h8C0p6ZofDQL6TuJtimSZBD8t6BlEP35hRPfUgIRKGc99Cv/V2Wi0GWYpVHVwEOA
	9DgOjBWabDe0Nfq924uNHqZrb61wDv7f+rX8OB/f0BSwAG7i04MDskZMEBwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1757597099; x=1757683499; bh=hEbpMbZboQQ9BeLrk1YnHE0S5HpW
	qXP9PsKKi8jGjL8=; b=i6QgtinWc1alBoAn7Ot2SdKMuES60u4gAzckkxjZqU30
	jIaUjzUe6eKK0mnMfcWJdnnOfZgxZJZGukiqgNKYVGmSk2TZ6UNjXbbDcqox5KCw
	QxtVWlXnQh2zYEyg1c6nY3rPRHXeKhc5E1IXYl0JFW8nlBhsaYZEsq3FHwL9p8xL
	ygmyIXshAjppz+v3zCTisAW7zPyQK3VTsfg0JOm7v5/3F2UNR3slC9LeJKAp+d9M
	4G3lbtG1BYnr6YYWwjvaEBOgJ/ubvOXsAhVscJY0EAT4Tj15cS/t5IX2ySePn9tl
	zbM9vJk2NihCQ+V2LG4yGLl/F13LfpI7EIUOjax4MQ==
X-ME-Sender: <xms:q83CaJ-mopgvHzvj-6nMSB8_vEIQFNBB2JARxeZSXWYH0njEDh2vjg>
    <xme:q83CaA_UBdAPAjNYnt7H-FfxFI9MOXRSUXAdj3BNWPmdBM2Iysp_YbJlaIh9OFk3A
    lVmrXhxWFouhaRgUA>
X-ME-Received: <xmr:q83CaAdInzdMzNDQnqUfJ7SPC1E8XU0SCWihKudO685wzYbWeGPFMGGAxtgH4xEsOXCic-0HvtisuZBitNGDgcInMnVzxM2XrE2O1mEUzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddviedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgffvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevueegkedtteeigeejueehuedugfevleefveehue
    ehgfetffffvefhuefhueekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:q83CaJFwXaxEnvs_6-ibBaX1CDZUqkN5vPWPpnmbr1K_6CPEj5oXrw>
    <xmx:q83CaOe0KOUV63NtRhCGZWldmXhH4DiT8PRg1WgorBYD-Ksne8hO0Q>
    <xmx:q83CaDGao6ltJCkh3soM2o-REQrYwnSt1OuD6d9l5dY3wWLwPzvF9A>
    <xmx:q83CaHVtiz2fE4p9iEuSuESc4mzdiemk-SQGdbpF-AbXYLL3ET5Rdg>
    <xmx:q83CaFlRV9e35SatC4rnG2btFiLCGLpwchkqgZQrZYiGZEz9ZB4MvPs4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 09:24:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 449a9b0a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 11 Sep 2025 13:24:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/5] builtin/config: bug fixes for "get" subcommand with
 "--type=color"
Date: Thu, 11 Sep 2025 15:24:53 +0200
Message-Id: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKXNwmgC/x2MywqAIBAAfyX2nJCGYP1KdOix2lJorBCB+O8tn
 YY5zBTIyIQZxqYA40OZUhTRbQPbscSAinZxMJ2x3aC1us+sthQ9BcGVWKFd3WJ0j26wINnN6On
 9l9Nc6wf+c/QvYgAAAA==
X-Change-ID: 20250911-pks-config-color-e5b8a213e895
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series contains two bug fixes for `git config get
--type=color`:

  - We restore the behaviour where we can now parse colors without a
    config key.

  - We stop spawning the pager when the user requests to print ANSI
    color escape sequences.

Furthermore, the patch series does some lighter refactorings of t1300.
That test file still has its fair share of issues, but at least it looks
a bit less dirty now.

Thanks!

Patrick

---
Patrick Steinhardt (5):
      t1300: write test expectations in the test's body
      t1300: small style fixups
      builtin/config: do not die in `get_color()`
      builtin/config: special-case retrieving colors without a key
      builtin/config: do not spawn pager when printing color codes

 builtin/config.c  |  20 +++-
 t/t1300-config.sh | 344 +++++++++++++++++++++++++++---------------------------
 2 files changed, 185 insertions(+), 179 deletions(-)


---
base-commit: ab427cd991100e94792fce124b0934135abdea4b
change-id: 20250911-pks-config-color-e5b8a213e895

