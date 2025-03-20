Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9022423E
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467076; cv=none; b=Azo7Nhd/PPcvi3AUOWePLvBNEso3OOZMddjKGLSaKaHIm7Q0CmQYDNG4uun+w4zKe/jmMLlLvkYY00Q3s5c0Axm5A9C7A4wVype5RLa4onBp9ArluLSyMOybnhEGP2LYssgqP55v6vqbDO8dUws++dQTEBBVZxvPGS3T+gAeAZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467076; c=relaxed/simple;
	bh=d5D6qxExZjm6KM9/kQgPWXiW2Ibql8cbu2pytnWtyp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jv89DhA6cM7PWukSOYzsH/4KSUYBi17wG1cbJw06KaT1FHIwgotBgdn7ldtynhaniCyW3tw9YY6wna1jw6TN1JkrXXzF9yyxRbTxmib5XXlTvmeGspERdLutes2AiPTO5INbmxSKaNu4BTviChDtZaiane62ejBY2WaRedH+MHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aLhj+Cph; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=carTIbpA; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aLhj+Cph";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="carTIbpA"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 732A8114012C;
	Thu, 20 Mar 2025 06:37:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 20 Mar 2025 06:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742467072;
	 x=1742553472; bh=NspBGRepFb9KaEFYaXSRe2yU0MPHKHOaDPuRcjn3yeg=; b=
	aLhj+CphsrZpOM1seWLq0XTDTAwvsGpPu836y7EIF+j+5K4QOy3Gbfct1QFn0hij
	Ldk47opLibaZqYvoEZkamiGzR0z87q6NHs2tTjMvS7KmJpnuFm7ABkFmSmLgySa4
	ERZML9vUs5bQOQZNjyGRIrp6xsqLEFC/U/5K3gHBVM2K6/Fi3U/8RkKE7y/Io+Os
	Uh0QuyrFuDJuQRU1um9PMO3mblMMKDK/H/du4AwYsdp0ZAD5PnfmTxV9ILSGeRZd
	OZ/4shUfHL61mtf6o2YJPQY9s48qWzRgwNI4GaNIxYs5XubuSHp5mQDhFNe/W3z1
	jMubkqWuADNFnOzcqFxq9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742467072; x=
	1742553472; bh=NspBGRepFb9KaEFYaXSRe2yU0MPHKHOaDPuRcjn3yeg=; b=c
	arTIbpAs04oW2b8JeceZm7JZ70qE6aEsfmyPU6ow5SGDbTJ4ID6pqkc7WEknIvvV
	MGRiswrWiOB2Y/PPqAB/4ui/kV18uQZ0Ju+rUVyY/TEOKHLd3moJFiZUaV7c9bSg
	Bcy2G+JlDbU6trKOCGkjhZMYfwEwUcjI9k6xVAcdWtl9uyKgRjPl4khv4ePrJ0/v
	BT6f2XxxM+vrhvUiLnnIKb56UktBjAGapkdSBPb3IUUtiFXfYus+N9C7NPjZtlLw
	uEJJ6VA3Mg5LZ2mXr//KC4REis82VzejJMeHBIEoS0CVrGtUuvNRnIxJhts3r/0u
	3rH+DtY6QkeILYni7i5/w==
X-ME-Sender: <xms:APDbZ2nWWxIBe-x7fHdoiA77Rv88ioc7khycfZa6VxGrRDAUEGx0XQ>
    <xme:APDbZ928flJnJO39QUnMX4daKQYUG1lrS61LNBMRFoXwsoDb6Zg85e_5xMHpujpzm
    VoCjCXBo6k8nDldMw>
X-ME-Received: <xmr:APDbZ0pQwbaXjO60x-IiS8SGHLmceqFty4fUnDHaDNrSO155r_aNL2WotRMCiZZhX_ZB-uhJshYJhC9maMjrdcsA89rJd0LUrCYZ_P9QgsW-KI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjie
    htsehkuggsghdrohhrgh
X-ME-Proxy: <xmx:APDbZ6kXjfN06Pode4XxnSfbbgLqWqQfhoz-eXN9J0SvgglbaeUctg>
    <xmx:APDbZ02tZBBk8tigEvPbWvp-3zmYagtXqs61FPdhNmcM2sTOUH0Q2w>
    <xmx:APDbZxuUc3gJd0PBYZn2FdnT6NClvOLAz8ak2Q9yjg1xHWmFi8CcUQ>
    <xmx:APDbZwXjx4UfOHl0s6xosyqY7ETQmtdSDKEwVxgYh5lNGCAq0x2FUg>
    <xmx:APDbZ3TtbqTFwzpDFyQ4wrFE9hSlq7quhd_Jn4X_UQBra_6flOUN5nz0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 06:37:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 942d7c7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 10:37:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 11:37:46 +0100
Subject: [PATCH v2 1/2] meson: fix compat sources when compiling with MSVC
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-mingw-lockfile-flake-v2-1-a84c90cfc6c2@pks.im>
References: <20250320-b4-pks-mingw-lockfile-flake-v2-0-a84c90cfc6c2@pks.im>
In-Reply-To: <20250320-b4-pks-mingw-lockfile-flake-v2-0-a84c90cfc6c2@pks.im>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

In our compat library we have both "msvc.c" and "mingw.c". The former is
mostly a thin wrapper around the latter as it directly includes it, but
it has a couple of extra headers that aren't included in "mingw.c" and
is expected to be used with the Visual Studio compiler toolchain.

While our Makefile knows to pick up the correct file depending on
whether or not the Visual Studio toolchain is used, we don't do the same
with Meson. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index efe2871c9db..2cf9da3474b 100644
--- a/meson.build
+++ b/meson.build
@@ -1107,7 +1107,6 @@ if host_machine.system() == 'cygwin'
   ]
 elif host_machine.system() == 'windows'
   libgit_sources += [
-    'compat/mingw.c',
     'compat/winansi.c',
     'compat/win32/dirent.c',
     'compat/win32/flush.c',
@@ -1134,6 +1133,9 @@ elif host_machine.system() == 'windows'
   libgit_include_directories += 'compat/win32'
   if compiler.get_id() == 'msvc'
     libgit_include_directories += 'compat/vcbuild/include'
+    libgit_sources += 'compat/msvc.c'
+  else
+    libgit_sources += 'compat/mingw.c'
   endif
 endif
 

-- 
2.49.0.472.ge94155a9ec.dirty

