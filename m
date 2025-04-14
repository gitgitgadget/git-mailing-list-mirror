Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0871B2580F4
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744617299; cv=none; b=MsjII+XHLhAhKPrTC6+VLyFbq1stoMfqKPf8oDrudZkqhJ/AIF1bFQcZZhFr4n8WMNGidL9l3EVScZt5q4NmeMGrMmPx8+gtTZcEhBu9alvIv5k6gKxeBhNEcfqvQESc6hq7H7f2ueLcjDrxBU6g4T5ECVwe0WRT5WX3G8yMxTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744617299; c=relaxed/simple;
	bh=VbNdDS1MZffyZQagv9wegmDtX0k92Jd/vTZihR62Gk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQqoGYEXGkfuxGEygrm95OITCR4t+mMCvxjYK2x5LSbkS+ugs6t373dXd+jQB2tEYFLsk7UNQPe8B0QY1kGLaRPj9mOtSKaxP7SVfS5PNbLjDwG10z7xf/jgbWHT/+SrzU5PsUaTC8Cpga2fG7t/bOKrynnljlepX5X2rGZGxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dVJSaXoB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kDwYOlhl; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dVJSaXoB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kDwYOlhl"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 21499114013C;
	Mon, 14 Apr 2025 03:54:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 14 Apr 2025 03:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744617296; x=1744703696; bh=gXz0rOphKL
	NVwOzFxbA720+RNrf3P1oDXtgem2/466s=; b=dVJSaXoBh49byg89xJ3VOCiW4b
	o1sNLPqr1N1S+wM6lo0o1mQDUSQCeIf6ycfkgjQeYOjsKFa+kPaHEHf2eaNw+39h
	r0bSvGZAJ5yiIq9uJoVVgA4jd/5bBdLx0VHwFGvOIyDMT7IawVx+BziB3EA/Hl+x
	fkhM57Zlo9ejyTQhnKHhpJ2i8OsTga7MiAwkKC82GaHJbcr5RTA/KX9fWfFU59Pt
	B9zJlxXzHDjeNdztQg5ahx5fSEUQ5YMDmLZnt4qN9J+LAg1nj27IxNbA0t3i4J37
	YBxjVYduBTTNFrzfkc5tJqy1vTlxubqYNj+iYQrvf3Dfeo5a5PZZduOE5ZSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744617296; x=1744703696; bh=gXz0rOphKLNVwOzFxbA720+RNrf3P1oDXtg
	em2/466s=; b=kDwYOlhlcxO8zecINiidCSn8PhOB/zPHvrULEHIL1p03/jGcxe/
	CRewRHsmu7XyqhgV2vl9Krt07M1nwmeA6NEGeTMxvCVgFxf4BCxTBP53hMHESPa1
	Pu47XRLggKujLoZajQ6XpEiHZMTGDn1gj+0LTDiol3hJB9s0DDKHCcu1EWPJ9U0N
	thXUI1x3p47WD7VaMNSUk5h2tATq09rum4r4cPR7ADwFbp7fwTT0vWtEw+zWZcaW
	jO/s3KEgwXgVJ3pD+E8YV59efqFCKL1uSJiSpMreaI3VBuSjtLPk2CgHAD6eqbLj
	H8BD60loC4XK9q27OSzVUNaoxFroThRRB+Q==
X-ME-Sender: <xms:UL_8Z7VHr_xTMXmWEsHPLzhvY_lhCmO_0rtwS4ra409l6IohsHu90w>
    <xme:UL_8ZzlC4GlIjRrMnfH9Zmj0kp1T2-rKZwAJjluhI_SAeIQhs-M3i0-PLq981j1Xu
    I40xgUvLaSdWiXI6A>
X-ME-Received: <xmr:UL_8Z3bA5wE6L8m7fQvseH5WMWKg6DJmpsmxzwZG4j5h7z5G0cqWTytvAFCVoZUNVQGS2DGZltadq1D4jX9BrONURWTdWbuTabxbtJcnrL-j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddttddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfffgffefudfhvdejudduieejtdffgfegvdekiefg
    keetveekgefhfeduueetvdehnecuffhomhgrihhnpehmvghsohhnsghuihhlugdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhgrmhhsrgih
    sehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtseguih
    hnfihoohguihgvrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:UL_8Z2ViQgyGlmJ_3OcdjA1214PPrjqELAePnJzvbsmgSqVCHBwtxQ>
    <xmx:UL_8Z1lnCmSq-VWHNYaO0ya9mo7_HnY6VKEYG9EKfWug6FIudR8FGA>
    <xmx:UL_8ZzeTOuZB7KJX8ZnNcjM55aa7CkgxSQ5ZZzLFdmudZyzj0vL2sQ>
    <xmx:UL_8Z_GphYInCaoOAs1bnt7YM2hTyVV_iHeHGaeAN4TM7HhrOg1r-A>
    <xmx:UL_8Z7_abpDnfx90gBMQc_TNeWJH4PJ3xrCuT9EMosf0bkHmmfslyFpd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 03:54:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7efa4f21 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Apr 2025 07:54:55 +0000 (UTC)
Date: Mon, 14 Apr 2025 09:54:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH v2 03/13] meson.build: only set build variables for
 non-default values
Message-ID: <Z_y_Tp5pfJ-gZLEF@pks.im>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
 <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <280363cd569a8c6e870107eb219597b42911fed2.1743859985.git.ramsay@ramsayjones.plus.com>
 <a5795bfa-cc02-4c9a-b7d2-4924a94cd0db@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5795bfa-cc02-4c9a-b7d2-4924a94cd0db@ramsayjones.plus.com>

On Sun, Apr 06, 2025 at 08:49:54PM +0100, Ramsay Jones wrote:
> 
> 
> On 06/04/2025 20:38, Ramsay Jones wrote:
> [snip]
> > diff --git a/meson.build b/meson.build
> > index 88a29fd043..efd0bd3319 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -693,10 +693,8 @@ endif
> >  # These variables are used for building libgit.a.
> >  libgit_c_args = [
> >    '-DBINDIR="' + get_option('bindir') + '"',
> > -  '-DDEFAULT_EDITOR="' + get_option('default_editor') + '"',
> >    '-DDEFAULT_GIT_TEMPLATE_DIR="' + get_option('datadir') / 'git-core/templates' + '"',
> >    '-DDEFAULT_HELP_FORMAT="' + get_option('default_help_format') + '"',
> > -  '-DDEFAULT_PAGER="' + get_option('default_pager') + '"',
> >    '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
> >    '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
> >    '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
> > @@ -708,6 +706,17 @@ libgit_c_args = [
> >    '-DPAGER_ENV="' + get_option('pager_environment') + '"',
> >    '-DSHELL_PATH="' + fs.as_posix(shell.full_path()) + '"',
> >  ]
> > +
> > +editor_opt = get_option('default_editor')
> > +if editor_opt != '' and editor_opt != 'vi'
> > +  libgit_c_args += '-DDEFAULT_EDITOR="' + editor_opt + '"'
> > +endif
> > +
> > +pager_opt = get_option('default_pager')
> > +if pager_opt != '' and pager_opt != 'less'
> > +  libgit_c_args += '-DDEFAULT_PAGER="' + pager_opt + '"'
> > +endif
> > +
> >  libgit_include_directories = [ '.' ]
> >  libgit_dependencies = [ ]
> >  
> 
> 
> It would be somewhat remiss of me to not mention here that this does not
> work for any but the simplest of values! :( If you set a simple single
> 'bareword' like 'vim' or 'more' (even '~/bin/vi') then every thing works
> just fine. However, if the value contains any of (at least) the following
> characters: single quote, double quote or backslash, then things
> stop working!
> 
> [I spent one whole evening (and a bit - always something else to 'try')
> trying to 'fix' this problem, without success]

Shouldn't it be possible to escape these values via `.replace()` [1]? I
suspect that you already tried, but wanted to ask anyway :)

Patrick

[1]: https://mesonbuild.com/Reference-manual_elementary_str.html#strreplace
