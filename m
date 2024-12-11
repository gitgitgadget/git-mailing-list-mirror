Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D8F1A8413
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914396; cv=none; b=Xn3dJN1IWHP/FwSvo43+EBVgX2aEOxroIMu+C/liYTScbsrAvZahvBqhuAa94Q0dYinZSqOBf4KMjLZFPdqMa+FH30K8FRe3LULulA/+r9IVyyNbvB+9x/wypqO1CdJeagN7X6ry10XbOr48CLbb24RM0m30fE/fQbHrJtkHlFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914396; c=relaxed/simple;
	bh=WHYURV58Su3U1JmZPiW+jHa/xbzYdyEvs3gGlCHH4lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sYgetxd8Kcu5fqDGhYl6Xt5d/5HBGBoL3U63qjld+IMyn7sbIk7eOrF+XRs1tgfreDio6pQI2GAKFNqA1X5UIQyKygNbbME3sANHo9SRTSuF6zRXCaOpzyyV8z7FXv38isDuRD4yFKk3+lVTtwS7x6CgZNiDWlavAP42ToqgROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sKPv99q1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xuLJfUYZ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sKPv99q1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xuLJfUYZ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AF190254020F
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 11 Dec 2024 05:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733914392;
	 x=1734000792; bh=kROOqGtySdYgwQ1O2BLWJq6mt1aWC9+fBkgb3TYk6cw=; b=
	sKPv99q1hLwIdIZwUiZt34+T7/czAdKqoddIZqH5E9mDXTLkkF11q89BdK7MakPB
	/Wt84UD6G9a/8DVYltIg8FIE6iqxG5m1t8df9bangV+i/X1O+oiHgQkB5nS8WGh7
	GQkDAvWSybWjGxY/cexRJB5N66TTxrnw9xe8AlqsDqfAR6ldR8R/QLsHxzIb1D7A
	wtadSUPOXie61oygn2yHqlPTFA/2LD8zke53+Zgf4PAyuTXN3AWTWAo0g34PO3mf
	uzaSzf0aJSAhIxk3re8wW7cO7uPYbytLw9iOnpwqFrathIFyTlh0AvwiOCs7FrnZ
	HwE0TsaZXVn62zcpH+GPwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733914392; x=
	1734000792; bh=kROOqGtySdYgwQ1O2BLWJq6mt1aWC9+fBkgb3TYk6cw=; b=x
	uLJfUYZEyeXJWk2FjmiE28c83ALlSSJpMl1kOX28R5nx2v8TK5NDOz8HvMXTX4Fb
	XulbqUjJ2r+jCOlLquGj+4StoIMADy5Barzs049bLoUibMCH+qSNadEIOLlSfY+2
	1iI9hk1f/tp5D3F4EfKj7XRDDfitQxBEAwd/SJYOwD+M6gcZDoD7bln3HVHfmT3X
	IUajoTkPpqPar2mUOp4h0gziPCk0LGfJGox1VD9GO8c6q9xt9/d+FYVN1/2dsDUH
	luX8Yw5BYnZ3x0wh+pE8adNN8Lk1ICO7KCqor4n8yQgGI0xN7cUyOnrSE7tYGqV7
	hq4duIhNC3P6PX0hndWVQ==
X-ME-Sender: <xms:GG9ZZ4AvZD4ULhWxJz1vuOUo0Crc3bQtbs1l9_wfsLRquL5EPt2igg>
    <xme:GG9ZZ6hVS6Uphexur_WRkL6tnvFXjFrbVa2_qTFMjqybDFg0hMfkPN988_nIdLFf1
    -7j-Cn5bdDzucdhFQ>
X-ME-Received: <xmr:GG9ZZ7nASK5yJRkrZwXrXS6wtYI1OLqCnVnskCY8sfXa_vw3enC0ZuKMrCFLJ_ImAwYmUemEZZv-JR8dAbR5gNUPKdTOFKzNbbK2F4nc6bzLJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GG9ZZ-ywj--HN2adNX9HwnYBUA37Pf1NFEXURHvJt8FzdHCW-i3frg>
    <xmx:GG9ZZ9Qg9hbwfTmm48HjaPLXIjScw7jF8PVfpvJYegT2UWd55opZTA>
    <xmx:GG9ZZ5YOoYTeL5ogkIcdZ4fV9ABdmCAIY9xCMx3_0RqvM0M9Ox_usA>
    <xmx:GG9ZZ2SLkyRmdLEucxKdCU8PaRm3IEAnZaQhfJ6lrDax0XnaCkjNtg>
    <xmx:GG9ZZ8Jt22Eto9vRS1v7VwKgQmMfg1xvsdDJBQiQXQvL1zM3kzLQS1AU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 40871f95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 11 Dec 2024 10:51:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Dec 2024 11:52:33 +0100
Subject: [PATCH 2/8] Makefile: drop -DSUPPRESS_ANNOTATED_LEAKS
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-pks-meson-ci-v1-2-28d18b494374@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
In-Reply-To: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The -DSUPPRESS_ANNOTATED_LEAKS preprocessor directive was used to enable
our `UNLEAK()` macro in the past, which marks memory as still-reachable
so that the leak sanitizer does not complain. Starting with 52c7dbd036
(git-compat-util: drop now-unused `UNLEAK()` macro, 2024-11-20) this
macro has been removed, and thus the preprocessor directive is not
required anymore, either.

Drop it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile    | 1 -
 meson.build | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Makefile b/Makefile
index 06f01149ecf399ae4bb1932188a007948d767283..2506f3b7e3377ab1a376338c86a727b2ae92a6e9 100644
--- a/Makefile
+++ b/Makefile
@@ -1490,7 +1490,6 @@ ifneq ($(filter undefined,$(SANITIZERS)),)
 BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
 endif
 ifneq ($(filter leak,$(SANITIZERS)),)
-BASIC_CFLAGS += -DSUPPRESS_ANNOTATED_LEAKS
 BASIC_CFLAGS += -O0
 SANITIZE_LEAK = YesCompiledWithIt
 endif
diff --git a/meson.build b/meson.build
index 0dccebcdf16b07650d943e53643f0e09e2975cc9..1af25af5cc1e718a4e50fb14274a36f811506219 100644
--- a/meson.build
+++ b/meson.build
@@ -712,7 +712,6 @@ else
   build_options_config.set('SANITIZE_ADDRESS', '')
 endif
 if get_option('b_sanitize').contains('leak')
-  libgit_c_args += '-DSUPPRESS_ANNOTATED_LEAKS'
   build_options_config.set('SANITIZE_LEAK', 'YesCompiledWithIt')
 else
   build_options_config.set('SANITIZE_LEAK', '')

-- 
2.47.1.447.ga7e8429e30.dirty

