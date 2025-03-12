Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82ED22A1E2
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785465; cv=none; b=ZtkvpiowsTQC1re2GGBf6hbIU25v7DlL+v11WvGl16ltwIFPO6AxzFfFsHkevC5d1Qt9s+Bt+XRFgncRTU/wL/J+zn4fV9CX2cdIv145GhYVZ0JUvTZpPvd4xrbiRJUt/jMDbR/mwqIRGsAJopjRQeZ2wVGqlwUNG5Z5AV0T+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785465; c=relaxed/simple;
	bh=zW07RwfWdYk0mWJtTAfc/+z+7q22KJ7dTFT3u20nJZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kt27T1fJehVuJwnwAmM0iQBIsqg0VR0LfVmTZJL1QL/rNjmJZ0czE5JrbAjNxjbFfXaNKtvTAK7dV3d6LXDvUgn49xWQpukth9QzJ6oFqELcYmYP6srMVXFe450SMPomZZq5ghmAYtYAM9+9HLffxLo+PzM2iNbd0z/sYQN+5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B34gByeo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AsceL6e+; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B34gByeo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AsceL6e+"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DCAFD114019E;
	Wed, 12 Mar 2025 09:17:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 12 Mar 2025 09:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741785461;
	 x=1741871861; bh=1qB9FwEVOBhBF1Ne6WpXHeiBAWFvFIjJE+XejueaqE4=; b=
	B34gByeoMbDFJ8Cv8+vd54drjn1ipZW9XVnUoxx6SITQkne0WMKBjaFLPtaxkjBu
	ItxVt9lTgC/qQIQNZVjSUL0aMcdEZgOsmuLWVBh7buRpS4NyjqhP6AVJHK7SnZpz
	iENYCmwaTaoaFSuww1TSzWjqWiBJAi2Or4YoqTzvnQ/9MihyhQqYhnNQUvwKf5tV
	213gst69LkVPnl84QYURmFgHkHIMPJx9VkAdVYrGCDp264YwibfgkcvNC6VDGA4E
	thYhwefR9ZAkDwZ8EZ43A2ovYPGu9iVo5F4vPc1TxD1W3ixuZUK3RMdVYO3+m+pa
	g5rOnoquSrEBKMqsQ+pudQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741785461; x=
	1741871861; bh=1qB9FwEVOBhBF1Ne6WpXHeiBAWFvFIjJE+XejueaqE4=; b=A
	sceL6e+WaEpZD14S5yeRvJH/sXhKE+JwJD4iY35I1/9lRYU3FHCEjZteUNBKsHZo
	yfSz2pLOpVSiqzt8SCxJYw4JXoq5UaMi6CO6mSBWDwqrz54m/R7AbYAelSdJ3X5h
	uW1l5AU91qejoG+kVbvZVVMyXxnqxuBye84sFlS4GH/fq89gJUQBmyfwWxZbBCKh
	N5HN9RHYv4/AG0iwDQ1TjJpWhawPB6yUTRMFMvA+oadvEK72cWq5lYbeDjlRDb/p
	gCZ/ldknZJckMfmHqiOkHW4ztVGXmBlufPECKDxTifIfXyIVpUDvL8uhW+zpyexq
	hVOshiUX7cvG4tSNYJELQ==
X-ME-Sender: <xms:dYnRZ_JGFvMqGvJ9K34UnzwBHyc3mknrMC6byQmo2Huipw6_zNfWMg>
    <xme:dYnRZzK9Rw_Ozh9xjXPVrqdVsQAhf-kH-tym3LzugOowDy9tS3qCIbIO5GCz5Ztdv
    nRxAWNRFZl95crKVA>
X-ME-Received: <xmr:dYnRZ3vS_rJ0zvEKWGzGIlAxd0mlFY7CHvI-EbONEevrgG_1eOqTHn9SQobpC86KqeADSiEBgXcGcjugpXaXlA6gz_8-7RPaXFQ4SwYF9IJOVe7xmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dYnRZ4aM4R99C3OkR3oeI7FdmAxZ0e95mnRcwTGEoJml_qTN1QVihw>
    <xmx:dYnRZ2b9FDMKDUIdMmRfKgNoIJR5C5f3KQtzfrKXsnkusNUDdyoKKg>
    <xmx:dYnRZ8AkiCoZuBN9QtdxfEzGRGVcwzabZzQytNXu4SbDCgErLYnjAw>
    <xmx:dYnRZ0a3mUDCFp1vdNvY2TTeeYe1a1WabOlUljFR1qWzJAYHOC4dCg>
    <xmx:dYnRZ9WotBhcXS2GwwMeJQGHyJ4_MqkTpQWYkMH41v1jgTEseJYRBiKb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 09:17:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2950b593 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 13:17:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Mar 2025 14:17:32 +0100
Subject: [PATCH 1/3] meson: define WITH_BREAKING_CHANGES when enabling
 breaking changes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-pks-meson-breaking-changes-v1-1-b89e9a59d228@pks.im>
References: <20250312-b4-pks-meson-breaking-changes-v1-0-b89e9a59d228@pks.im>
In-Reply-To: <20250312-b4-pks-meson-breaking-changes-v1-0-b89e9a59d228@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

While Meson already supports the `-Dbreaking_changes=true` option, it
only wires up the build option that propagates into the tests. The build
option is only used for our tests to enable the `WITH_BREAKING_CHANGES`
prerequisite though, and does not influence the code that is actually
being built.

The omission went unnoticed because we only have tests right now that
get disabled when breaking changes are enabled, but not the other way
round. In other words, we don't have any tests that verify that breaking
changes behave as expected.

Fix the build issue by setting the `WITH_BREAKING_CHANGES` preprocessor
macro when breaking changes are enabled. Note that the `libgit_c_args`
array is defined after the current spot where we handle the option, so
to not have multiple sites where we handle it we instead move it after
the array has been defined.

Based-on-patch-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index efe2871c9db..4ddc44f510d 100644
--- a/meson.build
+++ b/meson.build
@@ -672,12 +672,6 @@ build_options_config.set_quoted('GIT_TEST_UTF8_LOCALE', get_option('test_utf8_lo
 build_options_config.set_quoted('LOCALEDIR', fs.as_posix(get_option('prefix') / get_option('localedir')))
 build_options_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get_option('datadir') / 'gitweb'))
 
-if get_option('breaking_changes')
-  build_options_config.set('WITH_BREAKING_CHANGES', 'YesPlease')
-else
-  build_options_config.set('WITH_BREAKING_CHANGES', '')
-endif
-
 if get_option('sane_tool_path').length() != 0
   sane_tool_path = (host_machine.system() == 'windows' ? ';' : ':').join(get_option('sane_tool_path'))
   build_options_config.set_quoted('BROKEN_PATH_FIX', 's|^\# @BROKEN_PATH_FIX@$|git_broken_path_fix "' + sane_tool_path + '"|')
@@ -739,6 +733,13 @@ if get_option('warning_level') in ['2','3', 'everything'] and compiler.get_argum
   endforeach
 endif
 
+if get_option('breaking_changes')
+  build_options_config.set('WITH_BREAKING_CHANGES', 'YesPlease')
+  libgit_c_args += '-DWITH_BREAKING_CHANGES'
+else
+  build_options_config.set('WITH_BREAKING_CHANGES', '')
+endif
+
 if get_option('b_sanitize').contains('address')
   build_options_config.set('SANITIZE_ADDRESS', 'YesCompiledWithIt')
 else

-- 
2.49.0.rc2.394.gf6994c5077.dirty

