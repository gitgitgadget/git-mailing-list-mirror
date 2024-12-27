Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB5B1B21AB
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735301457; cv=none; b=r2tUlM+1OYnbSy5DMW/6HPOav5rxtaov4YXgDy2PnsrUsTWOEKlF4i/GC7ppDvRjJfbhp+TEkCsNTRU18mPzGHJaTdGZ9gC08hy7gUHP9yDK8NkL3spVG3EXnlTH/8/4TbMkiXz9j0wJfUSxBYkLrbC9gn1jXM7qpc6ep5UHabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735301457; c=relaxed/simple;
	bh=4BmGsFksS2+4TEkIkuaL4PajOzcUxx5RvisJia0dWe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S+vG6b5SUrW40E9QRgtxPJBaoVWDhqWInh0Kh2OCZlzO8k2gpCrG3Q69ED6F0jRwJtCITRIKC6C37EXVB/fIazc7m6NMd+iZUIfRsvMR5gD56hjVetOExLxghQxPe2YxNmRvvXsfSb6MzMfSaxBvIuUe/gE28DQXUd3xFrSTN7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KEK/AOv7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vf/b8yXX; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KEK/AOv7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vf/b8yXX"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 88A97114015B
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 07:10:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 27 Dec 2024 07:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735301454;
	 x=1735387854; bh=tkkYMVqxI4hhjRAUYONl2Yc8bkbzNhx1g7kcYllVd4U=; b=
	KEK/AOv7WCwLvP6Omi9MpSzxN3o8Pxb+I3E+10rpieRA3XTs7unrF3hvQdkNO+pZ
	Omf3vUeF7Ff9fZ0ch/C8198oYNjQ0nhUtYjssNLq2UJhdl3qHDULnYkMxO1cXHKb
	NXZ04ALkeu+ju0Qpf2mxfwIFtLoDtjufYx2yxf6twmSCnU8Ib+qsTxfJEOGhQ8zR
	lLm9KmeKz03oYQJKZOhaZ9f9a7l21nTyD/mOVmppHH7d6Wn02U6sG46k8ShCNOPB
	hMGsZOEdwMtHjT24kNLsO2vxlkjQybWfdlo3eDEcfF0WGn4ZTjWQlmGLSTYAsgn9
	BU5kmQRH//1T4VqNQx7y0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735301454; x=
	1735387854; bh=tkkYMVqxI4hhjRAUYONl2Yc8bkbzNhx1g7kcYllVd4U=; b=v
	f/b8yXXt574nHymAAYLZdlK0tCKPvjvbJSR/6hKEyRIqWBb3esnu5aSAa9AbuvVs
	8Erg7D/Agde2bZuyGzhNDScyUbgfkEMZyTtVG/sUaf+TbJSOFgfkQ5nOVfUu/+qv
	8Gv6fOl1uWXrzyIX2RksHkQclpDBCCfjmuDmXDb+o4DIU5FQ+ACO4fyKRE2BYSjk
	5Sxkxa18cpElS1F6Uqtp4l5+p9gBQvp/qJFILqvOgWG2DyHRQbcRS2IPT6dpI9LX
	TBYvZDgBjxOn6GaMDuanU0jCsP/aXRBaqNeq4ooDltJ4wRFosRD12ZHrFeEirgfX
	/qOXsKN6p0BBA9w3u23XQ==
X-ME-Sender: <xms:TpluZ4dhYEMeeu9fuB6ylf8t8e2Grhnm0aUcM7Bj3PnuZbZdx00nTw>
    <xme:TpluZ6PsEopgyqmw9GDLotT1b7Sw7cXTdNou7ids04ZpNdiXvFO-Z3maq1S6vbi2k
    1bpQWe3EcUqjaOSsw>
X-ME-Received: <xmr:TpluZ5iLTUIkYWb8d_y-8_fPckvF_522vmCHn9AsR91gug2l6asRoqa5MyJj-QgyqZMJNWH1C-e3mOH2jpzA2tpXER9x_30KCDhWdRiuOsZLlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TpluZ99rcqt2IJmfcXMy1w3wnpawr1cB8v5weBiEwRA9IXSRS83wFQ>
    <xmx:TpluZ0sMetxNkN0gxsHyqRt73JkrPsT37uBnaEBiBnvZWU3AZmqMHQ>
    <xmx:TpluZ0E6DWctG8An1VWAaj6wyrD6t0nwuE3vsExuBgLbAa-OJ5AXYQ>
    <xmx:TpluZzPFgUeU4MqZDLCcqVba5G_oW7L5b3ZcRxj9kiMS8iC6p_ZNFQ>
    <xmx:TpluZxV0UV51YVNvQBlwGQaAnek3Ft7PmuzPUPXMSo4u5i1wPOFqlLFT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 27 Dec 2024 07:10:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 173947f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 27 Dec 2024 12:08:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 13:10:19 +0100
Subject: [PATCH 3/3] meson: enable auto-discovered "gitweb"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-meson-wo-gitweb-v1-3-14ca8515bb3b@pks.im>
References: <20241227-b4-pks-meson-wo-gitweb-v1-0-14ca8515bb3b@pks.im>
In-Reply-To: <20241227-b4-pks-meson-wo-gitweb-v1-0-14ca8515bb3b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In 7d549fe317 (meson: skip gitweb build when Perl is disabled,
2024-12-20) we have started to conditionally enable "gitweb" based on
whether or not Perl is enabled. By accident though that change causes us
to not build gitweb in case its feature flag is set to "auto" even if
autoconfiguration determines that it could be built. This is because we
use "gitweb_option.enabled()", which only checks whether the feature has
been explicitly enabled.

Fix the issue by using `gitweb_option.allowed()` instead, which returns
true in case it is either explicitly enabled or set to "auto". This also
works for the case where the feature becomes auto-disabled due to Perl
not being present because we use `disable_auto_if(not perl.found())`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 3e57793862e5fc15685b5f0fac7f7223af7bef1f..0064eb64f546a6349a8694ce251bd352febda6fe 100644
--- a/meson.build
+++ b/meson.build
@@ -1863,7 +1863,7 @@ subdir('contrib')
 # We make sure further up that Perl is required in case the gitweb option is
 # enabled.
 gitweb_option = get_option('gitweb').disable_auto_if(not perl.found())
-if gitweb_option.enabled()
+if gitweb_option.allowed()
   subdir('gitweb')
   build_options_config.set('NO_GITWEB', '')
 else
@@ -1916,7 +1916,7 @@ summary({
   'curl': curl.found(),
   'expat': expat.found(),
   'gettext': intl.found(),
-  'gitweb': gitweb_option.enabled(),
+  'gitweb': gitweb_option.allowed(),
   'https': https_backend,
   'iconv': iconv.found(),
   'pcre2': pcre2.found(),

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

