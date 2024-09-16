Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181691514FB
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487130; cv=none; b=En/+uOqj0HFvtIM24Rsxnir+fDT7Zgb93TkykI3qw8J7UYuBrscmRRKaRmpKMBb00jDodvUsHPNp9enei9sZV1uOCcBS+CsfgxGmdbcRolPD73ZUCZdQSgGYYeTHQ6QJKxk/LJ4GUZQP1uMC0HxUx9Gqn6im+35KW/FT9V7MPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487130; c=relaxed/simple;
	bh=2RBC8Iykf1IoJkTRZDG+rgIeqcRdsgjg9sOJjXet92U=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYuHjrJpfDeiTf+KzZtqgVPC1ChZyL4OQMJKis5FK65KZKagNWAy0swz/JUv4UOzcaYPz4e5Ecx6L+H8MI4BP3OsrESDnD5Hztt5kmZ0q1sl+McYsQ2HgDy2bdf1abzsIMM/61ku5FGe3F6PfiBgvWe/KdDTL1oGPR14kKSv2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LFMrUNQu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l2fMIWEx; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LFMrUNQu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l2fMIWEx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 21212138026D
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 16 Sep 2024 07:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487128; x=1726573528; bh=0+9kmgD6j9
	ChrCCAvbIKMo5Hh99sdTE/YYvNfhu0M6g=; b=LFMrUNQu7iXZt52zO1i0+rTMZZ
	DBhA0Hd/exXiOnTvffBN1aso9GRzzdTnIMHSPQEjlfYyPLebfxbXyKV35E3EVq2K
	K/zwLpadbXAh1eZ+/V8DCXv1UttCW/fgVadKyw10samvK+RRZgTljOW4vYIvJve8
	q66ImsgaYTHpIWa6mUycDumL0EUvRrLqvEML5yU/zaN8xTn37WLHRhRX4WAx4ScH
	4IyTWC2sQjcsR1uFpPZqSYLlTZefBwBeflJ8aTptNDHWDVfoWM3X6iTCCos8s+xb
	XjeABpEz2As8mdUwo+Bcmps9xUyJ7GJrv8dvqy5XGOd2O6w8BJbum7jkQ5pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487128; x=1726573528; bh=0+9kmgD6j9ChrCCAvbIKMo5Hh99s
	dTE/YYvNfhu0M6g=; b=l2fMIWExzwbCYXg0MJCEUhKjQusnipHi3qNsGrVUNiGf
	UmPK8Hs7flHijK7VnE28GD3R8ETyWEU7Y9WXpbM9cFr+5kBJHMIiQnN+S1Z4y3Un
	ifQwt+D7jG+M3IgD9OeQFsG1PPi/MrqbAEX4ZmbjRBA6MuDBrC9WdDEeArwAjLTA
	sWOUf1H/ulESWhZp9e51QagMfNY09bQ3bUK1mmK3M/wbSz7q9QDHkHdMr56MyAup
	W08Lq1/HgCM3iEM2XhnjuzBVsyvkJBepfYQEZcZB2+/Wqz4cFzVHaxFg8Nd0ZqAx
	U9g+Aw1236/0C3yTUnDPGal9evJdUb3/RZRoGspiQg==
X-ME-Sender: <xms:VxroZjEa74q7TEZ6LVh35XFnhW_ndtmrCVNwbshaLwI1mdXvdgajMA>
    <xme:VxroZgVJeOS5vwj0MqxB_08OOtfdUmAxRdoEcx0QnczYInAOhLgyXwRQWofZmdRzc
    boXeZLvktXJ0iwSeg>
X-ME-Received: <xmr:VxroZlLtzfY5Kr6Se2yQs3BrZhLqQbkygV8dOmWvQyNcvXLF7xkVR-MxmnS_Z-uhfLCk6qGml99qwHS012BW1PA7I8DzvuVxiv6eU5m_e2VnTAJT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WBroZhEkYUGiXlbd7M7VrR_w7N8dK-7XrRYxtYVDcZHVPCX71BReJA>
    <xmx:WBroZpVls1boWnD0SBAdH8nRcE6nOC_k1Q9pQUq7SoN7GWQfZezYKw>
    <xmx:WBroZsO66HPEnbhnMxfEMhqv91D-s5xtGVjtLCIFm7eklq4viuH-Cw>
    <xmx:WBroZo1IRCrMDUZewClQstq1ebf4STwnFXvb19mLXuBXqBUXHNn8gw>
    <xmx:WBroZodAuKPbTnkAgxoReoektmz-uvUxQxs1vKvLeZp4rkStx8bW2wgS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a0ce2a71 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:10 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:45:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/23] builtin/help: fix leaking `html_path` when reading
 config multiple times
Message-ID: <4a59fe15ae30548164d1433d1d96fb2726512cb2.1726484308.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726484308.git.ps@pks.im>

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
index 282ea5721fa..2c249cbca4a 100644
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
2.46.0.551.gc5ee8f2d1c.dirty

