Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C881D07BF
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882145; cv=none; b=Vv7aN7yPgWeRM6WO8PXrJh4omHggdVOsgNAtjs/uweTHKAi2UEHWK+Z0970VRM6VouLeL9TJmFvKIsbtO1KnQWS2GHiBIp2GuAyuKYt+3k5Xgf5AC+nsrZT43QpFZ/yKAzFOdILcY3XaNzrLliMdr5avpf09u7t9W+8x2iuo8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882145; c=relaxed/simple;
	bh=YPygr9srEyiMQCsMZGlzYK7vwuLj++Huy6fJlW8mbFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgEa9uMBa6tQuXbdJ3+xpAqUm91R53mTfe0uuelfwNXukHiwH2rFIBbcX6lSqrIP0g4uKYCOl/QExP1fCPepDiSnfZtialWtQ1svtxyUeodngzfyX85SWnEjfkoKjIAKTmTE3TSmiwFIH3+edK1HeIJRrjfRYSCDIy28AzLekBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IDWOcqFL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZsHjvInv; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IDWOcqFL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZsHjvInv"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 08FE91380236;
	Wed,  2 Oct 2024 11:15:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 11:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727882143; x=1727968543; bh=f6NI1yU/2K
	2dqdVufs2d5vlCaMJHHFsslp7GCaG86lk=; b=IDWOcqFL+EOEfQ76om11UUtYQd
	P13gmOw+Dz9EED54qjp/ZqJBrpSN8G/ji3d6LCsU7EAs4CW3rViGZt6FGmEp8IbD
	xWLLXJBQXCAK6qy5FBjgu1KNVVZZ9Q4mTB+mq5c8ULNPi/iT13qKZUvakfBXE/+D
	1Vwc1D7vr5yPBI4sDsQwZhG287nargcpsMPB1Fx1YKnjU8m3AC+jmTnyA43YmGyI
	gbX7pIYuq0dSHUAIgTeFoO4Ogup5MwbbS+kpDELPQIgsSMR4hK4DrIzrje1Xzykj
	/CGzHq5qvC2IfSzePHICwVFuEaYCl1DdaIx9J2vGnn82xQT4TMCeiHLMqjDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727882143; x=1727968543; bh=f6NI1yU/2K2dqdVufs2d5vlCaMJH
	HFsslp7GCaG86lk=; b=ZsHjvInvi4nAhkRGE7BVCEkkQhd1WMVgi7Yiw3N6uEvw
	2x7QoZT2bjjCDoveAJRmk9nAwngDHDzMTu1Ki23L2c6m4SbvoSMva9un0phTQJY7
	dREA0aFJtwCBztXgh+F43KA4UAQTpCR76oYFUWs4YVI4rriJFOZBUOnT+a7D47px
	9+I2L5rWbCEudbS6Y9jH6/HdzGG4lR8xZ9gg0o3XIJd+/rvNBTAPpNzhnbhHAj2E
	ie9N4KAI7Wp9I0GNDV1OMSnxMRjuniZoK9acdNDN7GrZYPcW1GbaEmKlN9QLiS/m
	B+Ghh884vf++9DGd8w5S3B/Tze+8WmK6MFCndHl9TQ==
X-ME-Sender: <xms:nmP9ZkZEh0VzmdywXPSQLbYP6x8vyfIjkBOmbfa8yEfId4Gowzi_kQ>
    <xme:nmP9ZvYRbQ4RimWVwKLFhDoZjHQKk7BPDFVWmsBEKvt3YUIK6LR0NB7PbiRsxbXPU
    tG3lZDmJkjIwfNkwQ>
X-ME-Received: <xmr:nmP9Zu8BvPwZa5WNeIe63Hu2UJqdoUSTw3aj_TUjxZrm8V64lFw0Av5PBud_ZwTo0wZ9dyPAT_jGaINA1AKRMcnGHkDLwUB_DJR-sa_47fKaUpxq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:nmP9Zur4ANVRHCAgV7N4gpzrLwRM2inn66dV1qK1_BRdyGPEaqEWbw>
    <xmx:nmP9Zvr7BzGToYzYFQE0Z2buWMU445W_4nnQJ7GfhQ_W3ADn0G9WRQ>
    <xmx:nmP9ZsSBJ6QeA69oUCnQ9xob54QQr3sVgMkTsVlw9INcRA8Ka5uShA>
    <xmx:nmP9ZvrptW6mfvKfm15Uu50VcUyH14dJwsc5ms9hxFLPLF3pkEUkqg>
    <xmx:nmP9Zm3OdLV_HfyhMwFcDw2o_UBenoPIFy5uU4Cqe6j9J393E5vENE7h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:15:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7af31df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:14:51 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:15:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 02/21] t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
Message-ID: <559b593b5982391c42ad2457435a5667fb3b495b.1727881164.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727881164.git.ps@pks.im>

When assembling our LSAN_OPTIONS that configure the leak sanitizer we
end up prepending the string with various different colon-separated
options via calls to `prepend_var`. One of the settings we add is the
path where the sanitizer should store logs, which can be an arbitrary
filesystem path.

Naturally, filesystem paths may contain whitespace characters. And while
it does seem as if we were quoting the value, we use escaped quotes and
consequently split up the value if it does contain spaces. This leads to
the following error in t0000 when having a value with whitespaces:

    .../t/test-lib.sh: eval: line 64: unexpected EOF while looking for matching `"'
    ++ return 1
    error: last command exited with $?=1
    not ok 5 - subtest: 3 passing tests

The error itself is a bit puzzling at first. The basic problem is that
the code sees the leading escaped quote during eval, but because we
truncate everything after the space character it doesn't see the
trailing escaped quote and thus fails to parse the string.

Properly quote the value to fix the issue while using single-quotes to
quote the inner value passed to eval. The issue can be reproduced by
t0000 with such a path that contains spaces.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index e718efe4c6..5de93911b9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1601,7 +1601,7 @@ then
 
 	prepend_var LSAN_OPTIONS : dedup_token_length=9999
 	prepend_var LSAN_OPTIONS : log_exe_name=1
-	prepend_var LSAN_OPTIONS : log_path=\"$TEST_RESULTS_SAN_FILE\"
+	prepend_var LSAN_OPTIONS : log_path="'$TEST_RESULTS_SAN_FILE'"
 	export LSAN_OPTIONS
 
 elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
-- 
2.47.0.rc0.dirty

