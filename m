Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD1A213232
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743151131; cv=none; b=henLVMUygV0DpsTJ/9OlbkGBY3IQaWbIzjkjk/YNN5YaPiA8fSRe2aHEI5Avk0RpPkjY0AS3PIdoYFeo31xKo6baL8cgSDuoJDP5qSPEnn9p9GsLTi+EHAazdQInOXNR0pmfmTqytaZRFS3FIB/3IPTDMW4hONEqKrs32ryw/OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743151131; c=relaxed/simple;
	bh=6Mx+OttVO70q9Y/RI1f4AfNkMwBQDdfwGjWvKjpIxyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aR+xfZM+HtFNB+UkKOKOXe0y9VGFro9xnpIEoE/2mlsHYJTn3hQ24t5RLTgwUhpUGpOVcwqcn+kU1FwDKq78oE6WvobweOyR4ngXyk5My0R4ZowywdvjppQY9kHtjq66GOsnRlytuU40gBFFB3chteytXrm5F7YwmOkzgll6lUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PnbXTTzy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h9Gco9Dk; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PnbXTTzy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h9Gco9Dk"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 28D1711401DD;
	Fri, 28 Mar 2025 04:38:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 28 Mar 2025 04:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743151128;
	 x=1743237528; bh=uz50QcfITAuFXSvNI9OeJomYH5hJuU+E7Qw6yE/z39w=; b=
	PnbXTTzyW4DnsqLUQaadgtYv46c2e0PL3pcGrG2jFhcvBi/2S2Zzz+Lrp9qCgk9n
	E3GFq2jYBsJuCjYrv3MbkvffVLeEVjl7ijY1roVk37+dX+H9KdARmEN2sBgsO4XL
	ZyY/+F48NhQ6FjELZP59MiLbkIk7AzDBD8+cYXY4OXvliJo7C9FPHCD3lo4cPI1l
	+i7LT88Y9gyhgU6wMZsqXFNH8nlHrT5sWG7D85/jP8CENdU269MS+zzNSWzViHEY
	ZNIgS3zYSsFZYLdBasQQO+NVsw+nwEmji2AN0me7KGuZU1KoqRdgDlPB0BkSMEuu
	IXboLXrYkhulGSNTz/9jAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743151128; x=
	1743237528; bh=uz50QcfITAuFXSvNI9OeJomYH5hJuU+E7Qw6yE/z39w=; b=h
	9Gco9DkaxVBQ2Ju9EPQC8g0/02QvoCzs89u6T69mnCB9iIPMGxtQJ11AlUA61TeE
	YOSDRqLE+BaqNeJpBWg+/rK7I5qoyk/zqFJlr7SaFKKPRdRptHvGQRmE4GSol+g0
	eZvDNoyreZW5ZTw0LgGI4FqW1IjmjJT8FgEXdMGPUlTP2Tu1UXrBWBC/kQPwJEm1
	nxPDj6DBLSPdEMKD2HQQDKKg+Us0qDVjJj93MkTGf18VJ+SlouNXu7p04via5IiE
	ectGgR+57JNJz9xPtwu9LHCjeZMOcojiKSh8NipQ+QC/fWFORRmKOLDvKyJfcT5P
	cRAEXd8pFB/uR//EGHHlw==
X-ME-Sender: <xms:F2DmZ_7RK-GWu2T9_d38mVLiXl3OyN28_itjrktb0q4YvbkTSpLJAQ>
    <xme:F2DmZ065cGDxdO2inGix_Ug8uYW9HJGxgi2r-7tYBGodhiwaQ-PzTMh0G91kJ3pgU
    PiUeiT__udNVPH7sg>
X-ME-Received: <xmr:F2DmZ2dSw8UUfVGI2UDIBAJ_UPFvGYca8gWeHV2Kin1wlIOb9qFJ0Sm-GDBYC2jTpOu8uAn2C40bHYgnsakBzI4j8YlU3byWQ3_itFj70DC3Ri0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    rghmsehgvghnthhoohdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnth
    hoohdrohhrghdprhgtphhtthhopehtghesuggvsghirghnrdhorhhgpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:F2DmZwIMCj72ODIWoTt-Kuuh2AV5JDcDMVhnWUNCd-XANnDa9FBuQQ>
    <xmx:F2DmZzKtLHvdWHeR_zxxcerWdNdTlQyXbHDEtz-N3POZugvy2XU5wQ>
    <xmx:F2DmZ5xGnxx-KtiNxBmglQ67abqFhjDnWD1O0YL9Mvfgww97mFpEgQ>
    <xmx:F2DmZ_LJrhvJI7V-mofC9B9koz9DMmtQH_swtbMTrUH9rUx3AgyLqw>
    <xmx:F2DmZ7-ySZbK1OouneEyqpSXequmCmU7j6M-kqzLkKq3aaR_H3R0c3-t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 04:38:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 62b7f8f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Mar 2025 08:38:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Mar 2025 09:38:38 +0100
Subject: [PATCH 4/4] meson: respect 'tests' build option in contrib
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-b4-pks-collect-build-fixes-v1-4-ead9deda3fbc@pks.im>
References: <20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im>
In-Reply-To: <20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Sam James <sam@gentoo.org>, 
 Eli Schwartz <eschwartz@gentoo.org>, Thorsten Glaser <tg@debian.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

Both the "netrc" credential helper and git-subtree(1) from "contrib/"
carry a couple of tests with them. These tests get wired up in Meson
unconditionally even in the case where `-Dtests=false`. As those tests
depend on the `test_enviroment` variable, which only gets defined in
case `-Dtests=true`, the result is an error:

```
$ meson setup -Dtests=false -Dcontrib=subtree build
[...]

contrib/subtree/meson.build:15:27: ERROR: Unknown variable "test_environment".
```

Fix the issue by not defining these tests at all in case the "tests"
option is set to `false`.

Reported-by: Sam James <sam@gentoo.org>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/credential/netrc/meson.build | 22 ++++++++++++----------
 contrib/subtree/meson.build          | 20 +++++++++++---------
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/contrib/credential/netrc/meson.build b/contrib/credential/netrc/meson.build
index a990dbb86da..3d74547c8ae 100644
--- a/contrib/credential/netrc/meson.build
+++ b/contrib/credential/netrc/meson.build
@@ -7,14 +7,16 @@ credential_netrc = custom_target(
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
-credential_netrc_testenv = test_environment
-credential_netrc_testenv.set('CREDENTIAL_NETRC_PATH', credential_netrc.full_path())
+if get_option('tests')
+  credential_netrc_testenv = test_environment
+  credential_netrc_testenv.set('CREDENTIAL_NETRC_PATH', credential_netrc.full_path())
 
-test('t-git-credential-netrc',
-  shell,
-  args: [ meson.current_source_dir() / 't-git-credential-netrc.sh' ],
-  workdir: meson.current_source_dir(),
-  env: credential_netrc_testenv,
-  depends: test_dependencies + bin_wrappers + [credential_netrc],
-  timeout: 0,
-)
+  test('t-git-credential-netrc',
+    shell,
+    args: [ meson.current_source_dir() / 't-git-credential-netrc.sh' ],
+    workdir: meson.current_source_dir(),
+    env: credential_netrc_testenv,
+    depends: test_dependencies + bin_wrappers + [credential_netrc],
+    timeout: 0,
+  )
+endif
diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
index 9c72b236259..63714166a61 100644
--- a/contrib/subtree/meson.build
+++ b/contrib/subtree/meson.build
@@ -12,16 +12,18 @@ git_subtree = custom_target(
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
-subtree_test_environment = test_environment
-subtree_test_environment.prepend('PATH', meson.current_build_dir())
+if get_option('tests')
+  subtree_test_environment = test_environment
+  subtree_test_environment.prepend('PATH', meson.current_build_dir())
 
-test('t7900-subtree', shell,
-  args: [ 't7900-subtree.sh' ],
-  env: subtree_test_environment,
-  workdir: meson.current_source_dir() / 't',
-  depends: test_dependencies + bin_wrappers + [ git_subtree ],
-  timeout: 0,
-)
+  test('t7900-subtree', shell,
+    args: [ 't7900-subtree.sh' ],
+    env: subtree_test_environment,
+    workdir: meson.current_source_dir() / 't',
+    depends: test_dependencies + bin_wrappers + [ git_subtree ],
+    timeout: 0,
+  )
+endif
 
 if get_option('docs').contains('man')
   subtree_xml = custom_target(

-- 
2.49.0.472.ge94155a9ec.dirty

