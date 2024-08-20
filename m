Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB390191F6D
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162746; cv=none; b=lRk0du2cqclbATtGKaY16HRLjwd53QK6n7yyDvrXD+x2iF0aHVGUA3ZoxaqrFtykX5fL+ojBJUbHFE2WJT5gG46lCAPZyrGLwc471By+gVyZfmGUAwiGV+0p1WsQZzwg8DGDtC0w7kzZ4YEEavJ/g4rbKTQpwvPt91MgmRlNQIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162746; c=relaxed/simple;
	bh=eowiTkLzdfTLy9KuGhwXGUGGY+unWvi17iYZP3vx+AI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcLCkIFFHvtqIHsOR6Y4aI7SfsSc/0pTFLubN7phifRcdt9RmsET5v54U5NII6VSXKY/eOiBSTi21XpgXzFncP18A9JkwI9Vh0W1ZrlGi+ddoaFvJ0+un7gQWkEgC9qVgfzBPoi8ZkKRd2dBOID9YbgoDqWHH5lhaWVcxBrDiTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gzeGYYg2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eLjP4vAe; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gzeGYYg2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eLjP4vAe"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id C14FE138D263
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 10:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162743; x=1724249143; bh=VpZD48IYH/
	iZ5avU+FtTy+iY4+9OcKX3DOr/5Hgxg98=; b=gzeGYYg2I/yBoDbob/vtfSi+Ec
	TRww75DFA5G1XwQAsCBr7i7OS/hanajMlAlyZHiPBwuRx4LrIjiB30k6pZTJlowe
	FZwRvB0btsOigLvFth5Oxjw2n/NiBQdNCAyZfi0hzYJpF/JAkF6nP+2JmN0jpAgk
	IhlZBCUbmkO5pDc+edsfj/7alnplJ3iZJ/tnUyJofync6Ye6jvtbwPqDRnJlwjzb
	RA8GsrddShciB7LzmhhiO9bjoS/eMxTUyZdFNrRvlFsN9CYWLUu/MB7nZhnVKBk2
	Gd4SoXZv4bo3MUrcifH+6t1s52jIlN4B16d8NScocaoGtpxoCpOHfRge6hMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162743; x=1724249143; bh=VpZD48IYH/iZ5avU+FtTy+iY4+9O
	cKX3DOr/5Hgxg98=; b=eLjP4vAe6UAY34V2oh71HHkqiLziTlo8sKnRDo9rh26W
	NvVMlmjEovFRhGSeQXHF8u27EDzUnBjRPRhJytuAjv96ehcli+TzPw+qZRS0O+na
	AIrQ5K/bGUSQ1kTvPAYCmSAdh4uwHbtkbTi2SU4id9ZGqQxT7XR9KIvMzQvLiT89
	8W6e92OFQvhFDsSogCjHYFuB1Gf1rexTfQjwvTj+84wUBSZPf25D8uUCiZIknbsV
	VCq4/oZ0cwtxquUKjkDShP+8oyiAFSO4lu8Z/PHTc+x4KboK7d39M8Ki3vdN+0ie
	jlWVOr4fx0U8LjHEUdKSMsu22UCrmP+MDIET2BSxvg==
X-ME-Sender: <xms:t6LEZsuHr-vp7tqYjSxOQBOfKHACp8Lv4DaJRj8eoJjEH3KDSjfvCQ>
    <xme:t6LEZpdP147uD_Y0X3Ty3TMSmgboQysOUS6aZ1jWQ3rBzrQkC30SlnbRKWqa0gncU
    b90Nnrqmcvqi6pyag>
X-ME-Received: <xmr:t6LEZnzlwot5-iGRVlw5tkdTsAJ-ixbcbzZc7jo8OuGEC3mzxmp72M3K0BQtWoh1ygX7upgDpdeLlBW3BoRrjhuqrwbD473GuqZGy0udsfkW4o6qrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepjeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:t6LEZvOJXPc6RmzakAScNy3V3FvwDxCbcgJEdtAdlWUn-Pdv5XSOiA>
    <xmx:t6LEZs_SnpiRepn3f6YJyg0I_-0F12OfDvDQKKM3XogLmE965TXYDg>
    <xmx:t6LEZnVYwAbLWyATStMSU1H9mpJiCv_eS3ruNxnwjLUR7_zSnOufeg>
    <xmx:t6LEZldZ2CNhJ5WK9xBG3nzqvGiAIzketkmBr4Ml2yZp7eAERnQQ8Q>
    <xmx:t6LEZqnAEVV0j4uCvMJaUWXG7RgerCRtoMpCBnkVgtBRsjVaK9Smf3ba>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a056732a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:05:12 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 13/20] sideband: fix leaks when configuring sideband colors
Message-ID: <5d09959b6426e53a68e1bce547f9507bdf21bcde.1724159575.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

We read a bunch of configs in `use_sideband_colors()` to configure the
colors that Git should use. We never free the strings read from the
config though, causing memory leaks. Fix those.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sideband.c                          | 8 +++++---
 t/t5409-colorize-remote-messages.sh | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sideband.c b/sideband.c
index 5d8907151fe..deb6ec0a8b7 100644
--- a/sideband.c
+++ b/sideband.c
@@ -30,7 +30,7 @@ static int use_sideband_colors(void)
 
 	const char *key = "color.remote";
 	struct strbuf sb = STRBUF_INIT;
-	char *value;
+	char *value = NULL;
 	int i;
 
 	if (use_sideband_colors_cached >= 0)
@@ -43,15 +43,17 @@ static int use_sideband_colors(void)
 	} else {
 		use_sideband_colors_cached = GIT_COLOR_AUTO;
 	}
+	FREE_AND_NULL(value);
 
 	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
 		strbuf_reset(&sb);
 		strbuf_addf(&sb, "%s.%s", key, keywords[i].keyword);
 		if (git_config_get_string(sb.buf, &value))
 			continue;
-		if (color_parse(value, keywords[i].color))
-			continue;
+		color_parse(value, keywords[i].color);
+		FREE_AND_NULL(value);
 	}
+
 	strbuf_release(&sb);
 	return use_sideband_colors_cached;
 }
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index fa5de4500a4..516b22fd963 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -2,6 +2,7 @@
 
 test_description='remote messages are colorized on the client'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.46.0.164.g477ce5ccd6.dirty

