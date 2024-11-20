Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B46189BB6
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093018; cv=none; b=OJR+N0ZpJQzGbdSPLTinoAm0m+9/UdSMyGmWAQTC/A47iMRqEXb4PRAaltbSD/6NQT7sBT4YNqbIYjoRHaVWT70KKHfT5edkPU7sc3SI1yYc+A16T4gB98rWQ+VITt+LVgurTow3IyVl95mka4Xtx7cI6K+3A1AFTu3poq+ey1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093018; c=relaxed/simple;
	bh=N6seHVQKDEXYBrGKplAaWC/egWhiablQh31A5KKV2Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVXHBszOVh/0biFqVBrtl5vOFepJnfMF3wy12wR2+byb95z53x5dztRtRX8EOwswncdaGgdqODm3QV38ZqF3dPzPvYmrS5xhvjvrw5z3GRk9bcSzCxS3FbmKO+oWHPYUXkay5BghLOBmYHH0eqGnVWnmtDC3lmwQqRo25wLGSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GcKWhoci; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nv6v3jon; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GcKWhoci";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nv6v3jon"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D727313806CA;
	Wed, 20 Nov 2024 03:56:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 20 Nov 2024 03:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732093015; x=1732179415; bh=PvDJB0LWdW
	ZS7lEb3MScpVy9XH49hoMqMwhnBRpmGXc=; b=GcKWhoci3MPHwJ7zKgNCQjQux9
	pCksbM+I2CR0SdCPznfP60wrDnS192mzw5kdBAynKncMaShj0LNQMp+HDE1dvxU9
	fNX/IbzNDehuR/DERACOd4GOpFHr9jiGbse+hAGhtaj4umngJ+ZAHQnlYUsqX97U
	LYgVDnFlGnZ7Fv0/1RwT8dhpmoqqQ1ZHt/G22c/338VlWiuWDz+OIndMGcqL2lxQ
	HZBeq+/TmQoG8YnwxPE9MyIvxVtnWcOwlI8edbPgtkYsxtvC2+d9LB5QlbYZpPSg
	U2gqardGtFIp0q8mlxjaPnr7MOVjYCIuZT5196GvfbO+kkR21bmzcXeyksPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732093015; x=1732179415; bh=PvDJB0LWdWZS7lEb3MScpVy9XH49hoMqMwh
	nBRpmGXc=; b=Nv6v3jon20wQzfVGcJC+7wHpAaRqKINSTm1r2driyh0Q03ZIkp9
	qssEhWAIcnWzLNC0mL2ScIGaviB/2BZREAxptyECmRMeefP6tYVnuUKfp4j+sCvA
	xTI+y1xTbGnRnE/EzUKbQpWLG5zAguGQaswSW61VYRslshIERODc0wE4IxKKeFuL
	pp4ilTyDmQEIYxD3cdmRDe/Q+r2cKFYrCMj/ii1MfyieLluPM6IzAgrKjTBSMo/k
	heEj1JprY4rqQKdHRGcTR41L6GMzRH7thW3H0JA+eP6F3Kjtj0yg5BSvKPgiibCc
	8QQRX7AmDXHTYqhQfy5ChDEsDUaUBJpXWNQ==
X-ME-Sender: <xms:VqQ9Z_j9I94fOxJoAJT3rbhiXsErsldCnubRQy0L6BrOw20kEsmPDA>
    <xme:VqQ9Z8AOFmRRzBFLvX5ZXhd4AwWwd-JeCAsgaDlJAPCYJCSO3ZzslQEIOuijg_i13
    SWEGHO3WIBSqhtIYQ>
X-ME-Received: <xmr:VqQ9Z_EfBX8qymUDRBKDw86bkJy1u1gRBJDZHisalmpyQJLiGFl3fbe2WVKO60AMPUtrMsQsELzn6kSgC8gSPf6qMj7J-J1-r1zl17VddqPQ2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    fffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuuf
    htvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepgfdv
    kedtgfevveeiffelueeuvdfhtdekvdetiefgjeevkeegvddtgfdtgfdvieehnecuffhomh
    grihhnpehgihhthhhusgdrtghomhdpghhithhhuhgsrdhiohenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopegvshgthhifrghrthiise
    hgvghnthhoohdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurg
    hvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougdu
    vdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhih
    hnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:VqQ9Z8SL8GTIPVMQCss836cC0ls84WkaUzSaZz-N0LyB6sUcNEB8AA>
    <xmx:VqQ9Z8xe8SQcuX15-YQkECMda2fb-Pz3TPgJDGW6kxHI6_OiMF5h9A>
    <xmx:VqQ9Zy5B52JLRhX-Mxa1bhPZF1gk_qIyP0rzBOitQYuHU99yMjUI8Q>
    <xmx:VqQ9ZxymC05jjqX8awzkfUhYT6L-Ue2blE8owHzaNpzM22JkiaSbAA>
    <xmx:V6Q9Zxo83UhhOOPqJ99i2yHAW223O70qBUY7g4TUNEV69K2XLUiV4RUR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 03:56:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 71c6bd3f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 08:55:59 +0000 (UTC)
Date: Wed, 20 Nov 2024 09:56:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 00/23] Modernize the build system
Message-ID: <Zz2kQN4afY54PN8x@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
 <xmqq7c8y7aep.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7c8y7aep.fsf@gitster.g>

On Wed, Nov 20, 2024 at 02:15:58PM +0900, Junio C Hamano wrote:
> This broke the documentation build with the log ending with
> something like ...
> 
>     GEN asciidoctor-extensions.rb
>     GEN docinfo.html
>     GEN howto-index.txt
>     * new asciidoc flags
>     ASCIIDOC git-tools.html
>     ...
>     ASCIIDOC howto/keep-canonical-history-correct.html
>     ASCIIDOC howto/maintain-git.html
> gmake[1]: *** No rule to make target 'asciidoc.conf', needed by 'technical/api-error-handling.html'.  Stop.
> gmake[1]: *** Waiting for unfinished jobs....
>     ASCIIDOC howto/coordinate-embargoed-releases.html
> asciidoctor: FAILED: 'asciidoctor-extensions' could not be loaded
>   Use --trace to show backtrace
> gmake[1]: *** [Makefile:428: howto/new-command.html] Error 1
> 
> I think all my builds these days (including the ones that push out
> to https://github.com/git/htmldocs.git that in turn results in pages
> at https://git.github.io/htmldocs/ getting updated) use asciidoctor
> with "USE_ASCIIDOCTOR=YesPlease", if it makes a difference.

Indeed. I catched the other case where we rely on "asciidoc.conf"
unconditionally even with asciidoctor, but missed this one. This will be
fixed with the below diff.

Patrick

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 5ebc300ed3..9e6a55e0f3 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -375,7 +375,7 @@ technical/api-index.txt: technical/api-index-skel.txt \
 
 technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt \
-	asciidoc.conf GIT-ASCIIDOCFLAGS
+	$(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
 
 SubmittingPatches.txt: SubmittingPatches
