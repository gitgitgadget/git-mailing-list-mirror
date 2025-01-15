Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A491D5CD9
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963789; cv=none; b=B99VBwqnXioiQKhB8yFkKAv0efFad7AEsG81eEvbTDjcRhexIY16F/UK8D9i3osh/YozoV5HgJVtfCe2v/JKfM8PAuUfe3iTxcyVg3JCdHrCYBYVcuVhLgNgYY6qEw8dauLobEcI+yQOPEp5qsCvrN2Ab9jGs5Jl0kb0tPHfkP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963789; c=relaxed/simple;
	bh=aVmFP8VWEHCNkV8VEC6eWa9VVO+Yj7r9TE2NU9ByX6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FsEPmelp2uJX6ItKud/xsrcNaovoAU07zF46C3IJqMCmwZJtc7RN6Me/YjJ41eKuuYYkxJPP3souhQ/d/6a7SeZk9YcpoKlonunw+SsgjHHAP5FueFhqRyz3eINO0D7X+6ApHi8vpgfn8oM6BLahmK9mkoedJ6UxB9MueG+UgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ng5o0wqJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WgVOOx7F; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ng5o0wqJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WgVOOx7F"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id D8A021140051;
	Wed, 15 Jan 2025 12:56:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 15 Jan 2025 12:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736963784; x=1737050184; bh=A3B/0nOxc9
	wrihZ0Tui+kTZQ+HKzYXveDdgxOTEzuRA=; b=Ng5o0wqJIlCNsQYY9U0kXAFBIC
	DigGxBo1tMvG5buwZ+0qWpHI0vZZbka+k3M+yPvXS+FqgViP1sdoP28vPnkGhIAb
	b1+gx76lxKBKeCP8w6qN9jZdRLr1in6HcYptFwbDDvLPIN9ADRON9qYzlJ0QP0BF
	cHpKAKk1gOIOzkInCVStLhV156ZBGHMlwDhCdrbpy3gEmlOYaGro3bYxgKJx0j8U
	cOD+10HidlYRttOdLWRSGZK7TwvmJkiCjaHBCXej40AIciLlOfJkTV5Adn8kLiAE
	kdQy4+WJJyloEUzBTkRFZs3IZhmsaHWYeY4NJZSnpK37amQ06MSWYwXYknVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736963784; x=1737050184; bh=A3B/0nOxc9wrihZ0Tui+kTZQ+HKzYXveDdg
	xOTEzuRA=; b=WgVOOx7F3Xrb+LYvoaiSLNlQbtAsOLLf1nJu3Ybvah+xTlUDLSv
	tmdk9ssZMraTwaiqdAYr/MMRtcVgSB4buI/DOcpwlwvDtLfdCGgBPLx+ASJ57k2r
	wLwPMfrGLusA8EsywwxLDqLWndWQ743P7yNNeVGtuzkP5snZmdLU4CuupaFTWkki
	5ojBGR4tHuzOdloHYfqVJPyV6ZiwByTn2U2SxOmExoYSLin/XnBoR1H9/fgq/6VM
	IsVpeLK/vImOmvmo48NmP1yga1GkOvKOhm2rEUddfFfqsrK8chePbnycIjJ0Nlfl
	71AeP9m3l1X+W4MtNKvXpjz22q9OkJUGR/w==
X-ME-Sender: <xms:yPaHZ6a4bNk3nMmfIBuNnzxUeAG4wOfPJyAHOidfcaYfFFpR2Cr6tQ>
    <xme:yPaHZ9beLbYGx9hc1KypMxnab-xh7SMB7FBgL3SeEglrNF80RrpPiF2gcWKKjRsFK
    jT-Pp1B3xNmoPymSQ>
X-ME-Received: <xmr:yPaHZ099ZMC9N6pGXkN9EKVe6DJfEC8MegnmZJsPO81VHjDlNB3OCZjecW3nC_369_sX_kZY43OeKz40tfiumPgJsbzh7HoTXgWO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepteefvdeihfdvudekgeetleetgfeileejhfev
    gefhfeduudetkeegieegheeuhfevnecuffhomhgrihhnpehprghrshgvqdhophhtihhonh
    hsrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepmhgtvghplhestggvphhlrdgvuhdprhgtphhtthhopehjohhnrghsrdhk
    ohhnrhgrugesuhhnihdqmhhuvghnshhtvghrrdguvgdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:yPaHZ8rAFX9CA7xJYBLAKd3PIETVpjAAuVfEl0U6EvdYGBd1-vy6gA>
    <xmx:yPaHZ1pW9MkdWEx4jsLSonj1u8Dtxxzp_Airz5PgTIhwq-EzrAaELg>
    <xmx:yPaHZ6Q8fKosm1QNvkMDpF4pnzmtIypV-SXngIjcaW10T09_a-zk-Q>
    <xmx:yPaHZ1q7LscLt4a-Ix2uxTpThDZIXGs4yLbO22fibu_VUL1wRGAcNQ>
    <xmx:yPaHZ2eTsaSbrngLMGQG_UWdAwFSb2qJpoWtepxcFpZeHwifC_V1SfIU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 12:56:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?t=C4=9Bj?= Cepl
 <mcepl@cepl.eu>,  Jonas Konrad <jonas.konrad@uni-muenster.de>,
  git@vger.kernel.org
Subject: Re: Git branch outputs usage message on stderr
In-Reply-To: <20250115171423.GB57018@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 15 Jan 2025 12:14:23 -0500")
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
	<D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu> <xmqqed1414gt.fsf@gitster.g>
	<c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
	<20250115171423.GB57018@coredump.intra.peff.net>
Date: Wed, 15 Jan 2025 09:56:23 -0800
Message-ID: <xmqqmsfsx8oo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> use that everywhere. Possibly it could even do the argc/argv check, too,
> since every call site is going to be doing that itself.

It would look something like this; I am not sure if I like the "this
may show help and exit if the user requested, but otherwise it is a
no-op" semantics, though.

 builtin/am.c    |  3 +--
 parse-options.c | 10 ++++++++++
 parse-options.h |  4 ++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git c/builtin/am.c w/builtin/am.c
index 370f5593f2..c9571f605a 100644
--- c/builtin/am.c
+++ w/builtin/am.c
@@ -2417,8 +2417,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(usage, options);
+	show_usage_help(argc, argv, usage, options);
 
 	git_config(git_default_config, NULL);
 
diff --git c/parse-options.c w/parse-options.c
index 30b9e68f8a..9419b174de 100644
--- c/parse-options.c
+++ w/parse-options.c
@@ -1276,6 +1276,16 @@ void NORETURN usage_with_options(const char * const *usagestr,
 	exit(129);
 }
 
+void show_usage_help(int ac, const char **av,
+		     const char * const *usagestr,
+		     const struct option *opts)
+{
+	if (ac == 2 && !strcmp(av[1], "-h")) {
+		usage_with_options_internal(NULL, usagestr, opts, 0, 0);
+		exit(0);
+	}
+}
+
 void NORETURN usage_msg_opt(const char *msg,
 		   const char * const *usagestr,
 		   const struct option *options)
diff --git c/parse-options.h w/parse-options.h
index ae15342390..75a7493350 100644
--- c/parse-options.h
+++ w/parse-options.h
@@ -388,6 +388,10 @@ int parse_options(int argc, const char **argv, const char *prefix,
 NORETURN void usage_with_options(const char * const *usagestr,
 				 const struct option *options);
 
+void show_usage_help(int, const char **,
+		     const char * const *usagestr,
+		     const struct option *options);
+
 NORETURN void usage_msg_opt(const char *msg,
 			    const char * const *usagestr,
 			    const struct option *options);
