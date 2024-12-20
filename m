Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACB3218EAC
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712262; cv=none; b=Cveka5c988YqQgZ7kvt9waKnJtyYYraEbwSpm0auuThyywQOkObFTD7Iw85epmTbaEpsi6aH4p8u60j0yPaa8ktLcnCi5GG1CJWvzc+3SmB6vth/Yr5lo6AUiTINIlT/TT8osY8RLXOmMNv91K6LfUNcKhypNMiYCyLMOyHehTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712262; c=relaxed/simple;
	bh=KZ5FFrPL+T7xBYFVeVADlyUH8HK3HjSFWpokC2Zg7P0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=JujOM9gTJqDXWL/AGzzMM8JovfS01EThqkkPP1i5sBZxsRTB8TN1RH7/3EkjKPhyC3l9I9QL+juH9uEcHCdNKdxBtEAJGENjTjVvOeBg1VGEr/CrMSJBD3aMq/mdUbPqNCCUc9oiXkCXHWFKKhtf0O+KZbpGmK2qbkdv7TZYgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wHrxo1i1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lz5Wpjym; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wHrxo1i1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lz5Wpjym"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 52B921140163;
	Fri, 20 Dec 2024 11:30:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 20 Dec 2024 11:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734712259;
	 x=1734798659; bh=ARdjWdzZSaE34hLUSQkyO4TDLFRRNGDm3rGYyYWX3AM=; b=
	wHrxo1i13k6LVYl3a99zfX/RDUbaC5G5M5p53Ufs2ddP7o6dd0SI8sZ7g9gPjbVy
	YTnjLYpCg80CADpQwBmQaMtmOEqK+3SX2f5PcC9gQf3uHOM8KAZMGmFfdPCOR48q
	/zHuG4EAeii7+wQpqCtd5I0G/zeCfuEVfN/BMJjsDenEG2qadC/0yqGvb8DTU9Dq
	SIpJkjk4/1J7fEZ7GuT6v1U8iHsuKmqNZyAHUXYeXm709CXc5CasqQr0m99G1U+4
	Iqp+nmC1Z6PWE76ayUBaGBpiK5Tlm/StXsR9a7igTTocHCW4UyGAK9MWTQCQgTCV
	sSSHxhVRkKWCTNVj214mDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734712259; x=
	1734798659; bh=ARdjWdzZSaE34hLUSQkyO4TDLFRRNGDm3rGYyYWX3AM=; b=l
	z5Wpjymz7EvV8Uxs/miBu5GehRKKrt0K4jXsMGvsPVs0j0MZMak0m/cXatZOTTaj
	ttXDcrrA5DQjcHg+NCdyJ+LMFtvYe7ZzNxo8wzaSQY3ZPqvleBixuYEOFCM6g+Yy
	wqy3VPVE2sYAgjd9YqMBfkN8q+GqdcCFylzMR6e/Shx1juA5qXm0gjAvN9k/JTx6
	tKoOWAwcX1boXO16AAwy2c9HlzLQDpDG5Tr5gKvwRB+iUPjAKOWO3wLLCqXyveTq
	qjDQ0DBP88fMsLnASvjl2XTVNhvUpxNdVRtzqMUEooSVpKGMSQacpkuXhmMRhqIg
	7km3K6dAlMOYIQ+BwGE1g==
X-ME-Sender: <xms:w5tlZ_Uu53VqbVRQfEJuNB5J7Qnqt9REQr5H6g_uGMUUUb_D9zhnzQ>
    <xme:w5tlZ3k4ce-6i7V1B56I0H8Ed1yWKAHBpwbquXrKnkl8jxNXJ9iVYxAXWMIU_I1rb
    qL6V0pk-QA2Allzxw>
X-ME-Received: <xmr:w5tlZ7YZ3qAMg899DiWdUO7ZSvimMtyVRwVIs1_XdWUQjTZoiTT4-8xt8E4XVsExyK3pbv-9A5Ptfd9oWXTruJTXTyGe6ZRAn2vyTfRNEIDZf8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepieduvddvfe
    egudfhteegueffjeelhfekheefkeetueetleehuddtieefkeettdeinecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegurghnihgvlhdrvghnghgsvghrghdrlhhishhtsh
    esphihrhgvthdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:w5tlZ6XiVdaDtmzNAnmeDmEjRhj5Ez0VPz1B691k3o3Pod-UO5W9zw>
    <xmx:w5tlZ5mCka682n3rRGsXLzYrRV0B1mpZYlF8nj-euVUIpNcgm3Q2uw>
    <xmx:w5tlZ3etPKOSeyUYakzWxQ3kP6hk1DDakh1jnEXrBqWF5ueNjCZ2ig>
    <xmx:w5tlZzFXAJP8LprPP2xPu6R9sc8zrxR-9DmLK1eDirxeu_wTcRZ-MA>
    <xmx:w5tlZ_iqaptyFN6eV6BeqcKhaDTO3oyRTDEK8VLbu9iKxUAzU1dSGVWr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 11:30:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 891b016f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 16:29:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Dec 2024 17:30:35 +0100
Subject: [PATCH v2] meson: skip gitweb build when Perl is disabled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-b4-pks-meson-fix-gitweb-wo-perl-v2-1-18ab23dd6446@pks.im>
X-B4-Tracking: v=1; b=H4sIAKqbZWcC/4WNwQqDMBBEf0X23C1JDFR76n+IBzVbXVpNSERbx
 H/vVnovc3rD8GaDRJEpwTXbINLCif0kYE4ZdEMz9YTshMEoY7XRBbYWwyPhSMlPeOcX9jyv1OL
 qMVB8Ypnnl9I51RE5EEuIJKvjoaqFB06zj+/jcNHf9uc26q970ajRapWXjSsk9ibzM49Q7/v+A
 XfKkPjLAAAA
X-Change-ID: 20241218-b4-pks-meson-fix-gitweb-wo-perl-93379dd0ceed
In-Reply-To: <20241220-b4-pks-meson-fix-gitweb-wo-perl-v1-1-41039ad8d8d4@pks.im>
References: <20241220-b4-pks-meson-fix-gitweb-wo-perl-v1-1-41039ad8d8d4@pks.im>
To: git@vger.kernel.org
Cc: Daniel Engberg <daniel.engberg.lists@pyret.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

It is possible to configure a Git build without Perl when disabling both
our test suite and all Perl-based features. In Meson, this can be
achieved with `meson setup -Dperl=disabled -Dtests=false`.

It was reported by a user that this breaks the Meson build because
gitweb gets built even if Perl was not discovered in such a build:

    $ meson setup .. -Dtests=false -Dperl=disabled
    ...
    ../gitweb/meson.build:2:43: ERROR: Unable to get the path of a not-found external program

Fix this issue by introducing a new feature-option that allows the user
to configure whether or not to build Gitweb. The feature is set to
'auto' by default and will be disabled automatically in case Perl was
not found on the system.

Reported-by: Daniel Engberg <daniel.engberg.lists@pyret.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Changes in v2:

  - Fix awkward description of the new "gitweb" option.
  - Link to v1: https://lore.kernel.org/r/20241220-b4-pks-meson-fix-gitweb-wo-perl-v1-1-41039ad8d8d4@pks.im

Thanks!

Patrick
---
 meson.build       | 13 +++++++++++--
 meson_options.txt |  2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 0dccebcdf16b07650d943e53643f0e09e2975cc9..8e34a895dca80da77d6809a6fe90fe7661f142a1 100644
--- a/meson.build
+++ b/meson.build
@@ -740,7 +740,7 @@ endif
 # features. It is optional if you want to neither execute tests nor use any of
 # these optional features.
 perl_required = get_option('perl')
-if get_option('tests')
+if get_option('tests') or get_option('gitweb').enabled()
   perl_required = true
 endif
 
@@ -1874,7 +1874,15 @@ if intl.found()
   subdir('po')
 endif
 subdir('contrib')
-subdir('gitweb')
+
+# Gitweb requires Perl, so we disable the auto-feature if Perl was not found.
+# We make sure further up that Perl is required in case the gitweb option is
+# enabled.
+gitweb_option = get_option('gitweb').disable_auto_if(not perl.found())
+if gitweb_option.enabled()
+  subdir('gitweb')
+endif
+
 subdir('templates')
 
 # Everything but the bin-wrappers need to come before this target such that we
@@ -1893,6 +1901,7 @@ summary({
   'curl': curl.found(),
   'expat': expat.found(),
   'gettext': intl.found(),
+  'gitweb': gitweb_option.enabled(),
   'https': https_backend,
   'iconv': iconv.found(),
   'pcre2': pcre2.found(),
diff --git a/meson_options.txt b/meson_options.txt
index 32a72139bae870745d9131cc9086a4594826be91..c374345b1a2e5bd9101fec07e9640b7726a623fb 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -23,6 +23,8 @@ option('expat', type: 'feature', value: 'enabled',
   description: 'Build helpers used to push to remotes with the HTTP transport.')
 option('gettext', type: 'feature', value: 'auto',
   description: 'Build translation files.')
+option('gitweb', type: 'feature', value: 'auto',
+  description: 'Build Git web interface. Requires Perl.')
 option('iconv', type: 'feature', value: 'auto',
   description: 'Support reencoding strings with different encodings.')
 option('pcre2', type: 'feature', value: 'enabled',

---
base-commit: d882f382b3d939d90cfa58d17b17802338f05d66
change-id: 20241218-b4-pks-meson-fix-gitweb-wo-perl-93379dd0ceed

