Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021C217DFF5
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318241; cv=none; b=dMuJWuMpUPFOSQiYqqkxNOZzZpqUrSuEA2PJfA5mTR5jLTdIE9VMMFB+fdVczl0ONjSENOrrXTRALcqiSVdlFYnEWbkqz5mrLcaHdnypFnBa18CwFwuZq1w946U9lltANIpHWIeNrTnxMdm2bdfzK22iHG2yaTwQ3PlOgQsPFKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318241; c=relaxed/simple;
	bh=pBE8DpSvADQS90zjfMIk60gizQly99VD9eNn1SMkJpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umpBGUcQ2/gDnn/ilmf5nKwgoqwmZxGBOCLmYP8RPys2KwC+quElhvtnA5L0FT4YV4daAGGXqbE5+1mO2qeNbpuevSdjz35t/juRtiXl+sICor0qUky0j1rass849TD5kTfmDHoTf9Y1CcAR7NdYO1gJCeKlFR4OFvMblR6A+hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oImLs3Mn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EafBKEk1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oImLs3Mn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EafBKEk1"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 24231138FF3B;
	Thu, 22 Aug 2024 05:17:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 22 Aug 2024 05:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318239; x=1724404639; bh=5seFfBAru9
	++D3GpBhHiohA0nwaxb4Q0IbTVGtzw/kQ=; b=oImLs3Mnm7elu8Evmer2Hk2tLW
	LN3ktsZEWcoTX3ZP98hnVr9TL8b64PeSIuvoU+OKyZvppEfXxUUoZ+jP7wnCCiWg
	Gwo7bt8U8gMP5BdBXY6gRAcF0EvQqQd+Lb4V06QDg0GyoZtAIy9+xv+ZhXqzdtYJ
	NmEYwgRywyvguEQCZqVEx2z7utNaH14fnpAOHg9LfgUvYG0Bc3HaONWpzNNKElfG
	sVxpVNgoYUIGjZEcY+7vPdLbDNUebXGmp80bNGPSq1WupIkr2vzBy4v7GwWu17ej
	Eg64xcNmK1vP3TSWklyyDZ876xmn66jKoXBBpp8GglB8MGR/7UK7d2gOKkUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318239; x=1724404639; bh=5seFfBAru9++D3GpBhHiohA0nwax
	b4Q0IbTVGtzw/kQ=; b=EafBKEk1PoWzofMVAFTgHbe7V3M8BtxLZm5sKdUekx4I
	2IECCIhhscg+0kKrbMvWatcpIQf91/CqYwwyg+XZR1AQH0KOcnLYaFaSezloiZrg
	jzLD54r1rEGGL3LUHHT2XwrbvnCbsWsrnHQP9rEOV38lnV0lnP7n4d1b+sHkNNFk
	WYFuChtLbOkIVb7TA3NhED2FRaodKA2xh9fiQpvxDTDMosvgvNdhBs/nsr9SUKXS
	SHcB6f2bKm/licihIsnl/1taIOp99Sp9zoIV1R7fPIBbQVdc5LyQwzhwKdsnBM0X
	Q/04MBxTGBo+vVxTfB5hQTyAHlFS7Vy9EDONXtT6sA==
X-ME-Sender: <xms:HwLHZm4PqRz8qxrWf7W4CfGoGVjlIZcCZthkuY1WwtmzEoLX87RTcg>
    <xme:HwLHZv6BNv1Hsb2xWuPBk0kMfSIfaDw4iayK1DGJizpzBh0EARmwOy8IjFxOk39n4
    jtV3OpjSS6CfBOBpg>
X-ME-Received: <xmr:HwLHZlflh9rDviv59YrYEygTqo8L5JzdHjfoqCu7Ngn3bdxQBsvxp9kPVGY4d1YyTk9_6XVVE9xzXpBSOVUwQoXsio9TbxdKfDUlZqiRcKqNJAE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:HwLHZjI8AEeFQ3q0BMHowqmdh8w4s-Z7eZfOcwUV8L8DhwUOvyN_IA>
    <xmx:HwLHZqJRiocyaS2Fz5ibTeqNUe1nMvaDjT9KOysu9Gq43ZkssOQ8BQ>
    <xmx:HwLHZkzqejmbBqurBx8vDDkugapW1APGdTndOupO8d81ol26gZzpog>
    <xmx:HwLHZuKbg0D5VLlWdQ-y1NP2fnNcfa7uRNRPM2FkDj4TftQLxk8P5Q>
    <xmx:HwLHZhUxvYi8CxZHl2N_ewlcVmc6dOYnxUgGvBSsE3r1ncIO13RPdYw3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:17:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id df486a15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:16:43 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:17:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/20] pretty: fix memory leaks when parsing pretty formats
Message-ID: <8a1963685e73fecb64bebb1154ad6205caf09a8d.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
 <cover.1724315484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724315484.git.ps@pks.im>

When parsing pretty formats from the config we leak the name and user
format whenever these are set multiple times. This is because we do not
free any already-set value in case there is one.

Plugging this leak for the name is trivial. For the user format we need
to be a bit more careful, because we may end up assigning a pointer into
the allocated region when the string is prefixed with either "format" or
"tformat:". In order to make it safe to unconditionally free the user
format we thus strdup the stripped string into the field instead of a
pointer into the string.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pretty.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/pretty.c b/pretty.c
index 44222fb83c6..5e162d7204d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -63,7 +63,7 @@ static int git_pretty_formats_config(const char *var, const char *value,
 				     void *cb UNUSED)
 {
 	struct cmt_fmt_map *commit_format = NULL;
-	const char *name;
+	const char *name, *stripped;
 	char *fmt;
 	int i;
 
@@ -90,15 +90,21 @@ static int git_pretty_formats_config(const char *var, const char *value,
 		commit_formats_len++;
 	}
 
+	free((char *)commit_format->name);
 	commit_format->name = xstrdup(name);
 	commit_format->format = CMIT_FMT_USERFORMAT;
 	if (git_config_string(&fmt, var, value))
 		return -1;
 
-	if (skip_prefix(fmt, "format:", &commit_format->user_format)) {
+	free((char *)commit_format->user_format);
+	if (skip_prefix(fmt, "format:", &stripped)) {
 		commit_format->is_tformat = 0;
-	} else if (skip_prefix(fmt, "tformat:", &commit_format->user_format)) {
+		commit_format->user_format = xstrdup(stripped);
+		free(fmt);
+	} else if (skip_prefix(fmt, "tformat:", &stripped)) {
 		commit_format->is_tformat = 1;
+		commit_format->user_format = xstrdup(stripped);
+		free(fmt);
 	} else if (strchr(fmt, '%')) {
 		commit_format->is_tformat = 1;
 		commit_format->user_format = fmt;
-- 
2.46.0.164.g477ce5ccd6.dirty

