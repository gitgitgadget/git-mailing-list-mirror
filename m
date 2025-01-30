Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382C81E98E8
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248257; cv=none; b=klT5JS4JOQKnDG4LAcaOIHST/dSQC2+2MV1FnXtgKWb22nTqKOJX8of8OYZUjRLicktu41orYUIIaSTsoSWb1q4yiY5i6Q+5EWqzD93UqTWDdDns2kvgrehTlI/SDnrYC2uKJHUXkdulbWmPk8ZsHUR8fHLyfFH3vr0W2d6xQDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248257; c=relaxed/simple;
	bh=6AH6sHnAtIvkxVy04w9mPlz3xCaluBA+/097TA84tso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rjuxMkjWnivdCIilYpcmMPFfnZ85IBqgXHKNq9z2qRW6j1ph49x3A/4NQ3jn8bKGlejf4FT0bvFWUR8/q783RnEjUU9UjuRgs8uIqVU724MCzYqO3YUPiULE+o0O0GcrjkGDO6JjG5NmMt56wc9/5sU6Qq9gYpGPvpTVNlz7AWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fXr3G9bJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A5U6boVb; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fXr3G9bJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A5U6boVb"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E5DA114012F;
	Thu, 30 Jan 2025 09:44:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 30 Jan 2025 09:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738248253;
	 x=1738334653; bh=kE5m4FNAlhTa4P/UPBeYYoOatv54ksyEmcdqFjU10s4=; b=
	fXr3G9bJyufcGKVoYL99zZP3OTSXXDxu/a+yFIsICNzYn9hH8BEe801a8AFtYlwQ
	abEFMjOsng7ZdUGwm1K53Mo2AT/IVsE5xeSkw/+rdNVjsvdtjs69asF0BBcMz+S9
	XnB3ktMDlRuaVqYdnnYPBoS+HNchJ77P8NgvKWCD/dVz9xEWLT+119tkc11j0faS
	DH+ugb3tMxaJkvvO91IgtKVEqhpGZ7Ho+SWxTFru/nPuOAdcM3/6l+8twSp/Cwcr
	sBBuiiGHeVx8hTIFUkkgevcxzhJMJqMK86F1mc2xvDaKT3Hnmgz+x6nSazzf/ssI
	43nnhnmvoSdlgKtYwb7ifw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738248253; x=
	1738334653; bh=kE5m4FNAlhTa4P/UPBeYYoOatv54ksyEmcdqFjU10s4=; b=A
	5U6boVbyvCboXyjGvLjZIyQGRYcnpPWGtLER0OxD0TPOwjjKJmDLGK1MgJeVSLAh
	s3AdEuxpJAalK9gKrSMypaYTYBnAtWTeiohmW7WXQhdxLZBQ0mE7Aa/uJi88tLZM
	cC9jS2xK93LZkctCIpNIsE1qhALk/TVLYY35M0g7H/DFizPZZt6f07hrU8OwTq3l
	Qc3rBo0NZ0M3zNkYh4OT+Rd45dvcoRpA8k4UuV21MZTrpFHB9Pz8cJnZG/AztLpV
	rzkCAkwRbovnn5lz0VdIePVi9SWUuzcrtlMmjsDGnqXy/yrMl0lcVKqlzQz69aid
	fKPSsVuaX0JkqFX6cwmWw==
X-ME-Sender: <xms:PJCbZ_1lFPqv_ftTXJezvI1VSPZLaHG53TAC-RqDYlqzcFdb8bBN2w>
    <xme:PJCbZ-HWgoGQG0z-icHZKxJy7L5aqWrUxszqm8GWTyoO2WrACPXK-Bzr91TEIok4X
    IRPTEEPIz7oLHIFxw>
X-ME-Received: <xmr:PJCbZ_77j95SPkq3CL8g4WOdLaJi0hcuz5Jt2PUwdPiUpteSY6ghXQfV5oMZs2d_XF2fI9pEvkFjUj42wHwofFp2fJ9FCYvvEBPbrbHd3AUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PJCbZ03rv_a3pGXGChJ-7jutKNAu24W4Snvr4Bhj4rUVTWOshiDtWw>
    <xmx:PJCbZyEiXmoUUFYsP4Pxcho602THHUjISecKtJRU2PqkeoIAjy_SLw>
    <xmx:PJCbZ1_KEHLnwh1DcWot-o0BZc5-PuK07D3W54DV8Iw3UarPLYgfDw>
    <xmx:PJCbZ_kVKQtaXOW-3u50Fi576g5mXEZC3ClJ9GnCbUz_HcuWpC2OAw>
    <xmx:PZCbZ3Ty5FdkDXl2Svd489cXNvnr1zeDeNm-zXGmsvGYo3f_j_Vk89_u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 09:44:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 237ee6c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 14:44:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 15:43:53 +0100
Subject: [PATCH v2 01/13] meson: fix exec path with enabled runtime prefix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-meson-improvements-v2-1-2f05581ffb44@pks.im>
References: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
In-Reply-To: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

When the runtime prefix option is enabled, Git is built such that it
knows to locate its binaries relative to the directory a binary is being
executed from. This requires us to figure out relative paths, which is
handled in `system_prefix()` by trying to strip a couple of well-known
paths.

One of these paths, GIT_EXEC_PATH, is expected to be absolute when
runtime prefixes are enabled, but relative otherwise. And while our
Makefile gets this correctly, in Meson we always wire up the absolute
path, which may result in us not being able to find binaries.

Fix this by conditionally injecting the paths depending on whether or
not the `runtime_prefix` option is enabled.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index dbc1dab605..1f83dc58c2 100644
--- a/meson.build
+++ b/meson.build
@@ -691,7 +691,6 @@ libgit_c_args = [
   '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
   '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
   '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
-  '-DGIT_EXEC_PATH="' + get_option('prefix') / get_option('libexecdir') / 'git-core"',
   '-DGIT_HOST_CPU="' + host_machine.cpu_family() + '"',
   '-DGIT_HTML_PATH="' + get_option('datadir') / 'doc/git-doc"',
   '-DGIT_INFO_PATH="' + get_option('infodir') + '"',
@@ -1466,6 +1465,7 @@ endif
 if get_option('runtime_prefix')
   libgit_c_args += '-DRUNTIME_PREFIX'
   build_options_config.set('RUNTIME_PREFIX', 'true')
+  git_exec_path = get_option('libexecdir') / 'git-core'
 
   if compiler.has_header('mach-o/dyld.h')
     libgit_c_args += '-DHAVE_NS_GET_EXECUTABLE_PATH'
@@ -1502,7 +1502,9 @@ if get_option('runtime_prefix')
   endif
 else
   build_options_config.set('RUNTIME_PREFIX', 'false')
+  git_exec_path = get_option('prefix') / get_option('libexecdir') / 'git-core'
 endif
+libgit_c_args += '-DGIT_EXEC_PATH="' + git_exec_path + '"'
 
 git_version_file = custom_target(
   command: [

-- 
2.48.1.468.gbf5f394be8.dirty

