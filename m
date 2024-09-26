Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA87170A01
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351170; cv=none; b=vBbyO5OnAIDOmOr/MpMFw5NR40AIKNacH1Sz39KH0MI1/H5VtIDkkBhgtBRZh+A3W/tsX48cG/kJ1AAcL76U8Kjda7awR0bzHQIiku7yIOoDVTGAcXARK033WxmkJ8PXMOmZdXO6JgU0+QHTgPWCjMEnYmnHHLKXMSmvflyTc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351170; c=relaxed/simple;
	bh=4B+yInSySv8wYLvDqalGbjvpIwx6ZQqB6o/dYdNUUbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1fC1s+J5hS/Ecp0NH85Kg4sLkzAcLx6sqA6xBlIpUuM+mTs8c6Km0bToB+knMxFHiciRjYYvA+4BsWgJFmtZV3GWev5Ygblksf0ze1ku2AJ9mEu1TVRb/7c4E0qBU66PnDvrEetKgFdJBYlMPc/GYxCQhe2tP3cyN+FzVfP9r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=st7VgMVV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KNCkOyiB; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="st7VgMVV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KNCkOyiB"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A7CD114028D;
	Thu, 26 Sep 2024 07:46:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 26 Sep 2024 07:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351167; x=1727437567; bh=DG4+Zt75eX
	JWltJbH8ZW0p8onZyKD2xTPggPIXGVa+4=; b=st7VgMVVgpV12aIMmC48lCmdCb
	T21gTGJxLRB3rfnIhROIluI7K1yuuYlxWn9uPS0EoMrNbGa/065xebvA9VoELK48
	WC2/gvXqi1xyUrqjraSQf15CtRI370MkZ/6OyIyH/1KBAHPXrzLiw6JrBT2A14tv
	YFH1ktgRBobWqSrXDjy7B94QMUHgMc0Kz7pNhDihLKfLm/00tj8PQ0IYirx/RK7z
	QIghis8OAixW/1lguzyzD+OuUsV42Nez1zqiBMKSD729mK59ibvhgy0AwFDGgBhC
	Cy9KIxlW6uDyYG0byYiyTTWOq5jLNRvGa6tDy+mdxPgQDm7gByax4+ILJr5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351167; x=1727437567; bh=DG4+Zt75eXJWltJbH8ZW0p8onZyK
	D2xTPggPIXGVa+4=; b=KNCkOyiBVuXg3bBIEHWs53/RgnTro6VkZczWFTS7JSdC
	QSYeOXD8XxCLmOLTVu+uv0LXG0/2JiLnuhqyvCKeQQxzja66zInO0uSk7ze+iYxM
	+Ytqy0EtjmuZbKpAOz9vOcLbQl6Kz4Fdp++kUZG8Ozd4UT4S9W0cn0ClEnH6Q2fj
	cDSyM1t1KjoNl6HXzhwGqRyJHP4KmvUJpwmdqcLiuKGmmDA7U3WzoEtTkRd11Ytw
	+KgTPoFxet/HxNNh4F4d7PdtoMRQLM7eKEVpxvS1KUpptaftL3HWJOOVd2w1SDeS
	I8rq+fxmbNY0jIWym0/TenQDJu7ZDZycBAsY6Kj1Og==
X-ME-Sender: <xms:f0n1ZkJIsE2e0yTKkYThc3YXX80J6CvmJTKlAROtTly-5UQOsraXQQ>
    <xme:f0n1ZkIsyJUpFcQ-E_P0Ke5hDe8GuRGe1wayOwoJ5kHops4XNYFMdy8zCtRyO7IBD
    tUYcTWCJLYKtK-0ZA>
X-ME-Received: <xmr:f0n1Zkt8Np4zSqchEqR-5u1UqtjPgSqI_IZhwNrp-XguQRqwdfPwzZDdj2j69jPyjXc8mkinonXWjLlxvb4fGTXuBizEC6HrBlqvnKhmZmwERw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:f0n1Zha65TR7307SSBiLukLzhqmmtWOphup1-bcNbQjt7VRmTa3kkw>
    <xmx:f0n1ZrbDi8cUlxcFO90sW_lmPk2_blDtv3d08QXMOxDg_ZSIUypESQ>
    <xmx:f0n1ZtB0Bkn43ixl8f9ST1bdeRO6nD16NQEuIGSAGn3RiL69xQkDUQ>
    <xmx:f0n1ZhYuEGcAFB1wjtFki0R7piGyvx1FHHU07SUbeHHI2jKbbjC_ng>
    <xmx:f0n1ZnGkGmSKOnxEptre1qFK_3oPOlEx_xQNfi3uMTnK0zCZhbTrhL3U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 986b3ffe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:45:28 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/23] builtin/help: fix leaking `html_path` when reading
 config multiple times
Message-ID: <4a59fe15ae30548164d1433d1d96fb2726512cb2.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

The `html_path` variable gets populated via `git_help_config()`, which
puts an allocated string into it if its value has been configured. We do
not clear the old value though, which causes a memory leak in case the
config exists multiple times.

Plug this leak. The leak is exposed by t0012, but plugging it alone is
not sufficient to make the test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/help.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/help.c b/builtin/help.c
index 282ea5721f..2c249cbca4 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -52,7 +52,7 @@ static enum help_action {
 	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
 } cmd_mode;
 
-static const char *html_path;
+static char *html_path;
 static int verbose = 1;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static int exclude_guides;
@@ -409,6 +409,7 @@ static int git_help_config(const char *var, const char *value,
 	if (!strcmp(var, "help.htmlpath")) {
 		if (!value)
 			return config_error_nonbool(var);
+		free(html_path);
 		html_path = xstrdup(value);
 		return 0;
 	}
-- 
2.46.2.852.g229c0bf0e5.dirty

