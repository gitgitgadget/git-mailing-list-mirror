Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB7221F13
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462773; cv=none; b=SferoGVaEWf0FehWHTTpTIhF+VL46+40cok4VW/8G0/V+mev9KTfCeFdQhXvr46g3443E1XxSiK88J340UFkNSYL3fGTugfPCAmvNZXEw1t0RR0XHUvIHwIPQB3LQG+HLpXprBXwpsAfUvGYgbAztGnN20s/4wcTjvO3zTFYynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462773; c=relaxed/simple;
	bh=J1P9Fv5/tNk0ERZHAh2bK/+3bW67keewfcPbMFx2e6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZosbTNP+ukC5/PNv5wsCbvA1DoztpAmE7T9syqZaSRMhxYWwRc3veapy2cdghDgHqJyEC72K6wthjstVRw+x9RCI1ih+MwPJR6T3/s8w0zEJTx0mJVcorc0B3EMzk5N3VRCHmZo55SpD8sxIonIjeao40nVfruxsIEQUOaipCfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o2X7z3Xr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Imyp90CM; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o2X7z3Xr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Imyp90CM"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3E4842540099;
	Thu, 20 Mar 2025 05:26:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 20 Mar 2025 05:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742462770; x=1742549170; bh=WK8HIyWWqm
	VCpH1CXDJ16kC3k2b/rtjlNE5kTE46UKY=; b=o2X7z3XrtvUoAsYsXcdWRFfVio
	rgudQyi2zOpqZUyaBDBTDerT48OezdSbFh7iarbwfNtcT7+jB6toCH0rpO3IIfNT
	GHJhdjPRlN3drKIqOe0zeMgqAJ/820WYV5lHAENVhA/TPGOA3TankcuqUe0vZEVm
	Q/vTl1Ao0Ue1dYKOOnYIraD1SYkpMKZH9erJgT9mCv8mRfcCXL2TFp33q8GBWmPj
	8Tj7jN13Mje/1JAe3w6m2CStuTURPDzYyGOjpWQzIcIy6msS1G12l5D8agTALbiW
	Y+GHps9Vxy6+EcO0gJ8hQLGXbI1x5IaOBAeqzJsPhKYLJ0pxeYlXeRcGiiZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742462770; x=1742549170; bh=WK8HIyWWqmVCpH1CXDJ16kC3k2b/rtjlNE5
	kTE46UKY=; b=Imyp90CMVQAKz3vcNIVvhhOMGAzGpqJuGFPImej0wu5J/kP4fqD
	AMwDY6t8FGXhHAIjdgoecpAeUP8GtuWsPkAVyM4ai5umZlUGdoU2Il52QLIu2ewk
	BC7F2ZJvkWuft1t6l6bjbW+ieNPkKSfTk/6JVT0woTO3paZvsAGhkFxo1wPhKtAw
	TImPkzveCgs69rFEBRjfscZDb9DeydEI/QAZa55DB3Aedd2AdPv6Yt0LeJ6xy1V6
	g/0ls+UcZe40Se9tt0yl/HoxWf6PdsGyQyfEQ15sj0k3AjZaJ52FDtx97nxquRMo
	yplOsbKUNIy+/a7Pn1Bx7rb4ueuXiJpMsnQ==
X-ME-Sender: <xms:Md_bZydC36oerSIecj6aujGbak7hn5-giF4TdJUJRlBinK27UIFAfQ>
    <xme:Md_bZ8NQaGx_LaaKaU-NmYUfG7peh7nyspgKD6j6yU3RB_-taYcJGuOTJp6yAgJcr
    JQLZMPiYpbSrIA2bg>
X-ME-Received: <xmr:Md_bZzjtHWbPfytkyXIRiKIRMjLLMC9rLN-9jjSbPs-MOPgxsqHUIhzEoQHd7Ny8JR2-WaQFoey5rsL6vgjcO-EhX5uGbkyivdSOujKgBMwkMLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfffgffefudfhvdejudduieejtdffgfegvdekiefg
    keetveekgefhfeduueetvdehnecuffhomhgrihhnpehmvghsohhnsghuihhlugdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtseguihhnfihoohguihgvrdhorhhgpdhrtghpthhtoheprhgrmhhsrgih
    sehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:Md_bZ_-8YeL61LY2jBdUBH9Amtb7PRqYEYNbZ_DlzFALlmlCt8OLzQ>
    <xmx:Md_bZ-tWwsyz72nd5cg7Fo1sxDgaw6SuTU0_7sgLvghj8kc5wBHgqg>
    <xmx:Md_bZ2HAYDSGcYP95FNF9bTBIjdMTSVmOtW3leRqAFJbQ0lIV7NxJg>
    <xmx:Md_bZ9OgEiRYTivtf9BfAHzRYWDEdFVia7OT74eC81vLBK4LTrMlIA>
    <xmx:Mt_bZwJXuti6FElLwuBTpqSvNppILBnNoVcIWNBb4N4Aj811V1HXcwLt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:26:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1385fec1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:26:07 +0000 (UTC)
Date: Thu, 20 Mar 2025 10:26:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH 03/12] meson.build: only set build variables for
 non-default values
Message-ID: <Z9vfLjnfhqKBE9X4@pks.im>
References: <5d0112ae-98b5-46f2-91ad-35ed11358c3e@ramsayjones.plus.com>
 <Z9rIQlUtutWPiPgD@pks.im>
 <77f8930d-dcfe-4612-b10d-1904e7530f38@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77f8930d-dcfe-4612-b10d-1904e7530f38@ramsayjones.plus.com>

On Thu, Mar 20, 2025 at 02:22:22AM +0000, Ramsay Jones wrote:
> 
> 
> On 19/03/2025 13:36, Patrick Steinhardt wrote:
> > On Sat, Mar 15, 2025 at 02:46:59AM +0000, Ramsay Jones wrote:
> >>
> >> Some preprocessor -Defines have defaults sets in the source code when
> >> they have not been provided to the C compiler. In this case, there is
> >> no need to pass them on the command-line, unless the build requires a
> >> non-standard value.
> >>
> >> The build variables for DEFAULT_EDITOR, DEFAULT_HELP_FORMAT along with
> >> DEFAULT_PAGER have appropriate defaults ('vi', 'man' and 'less') set in
> >> the code. Add the preprocessor -Defines to the 'libgit_c_args' only if
> >> the values set with the corresponding 'options' are different to these
> >> standard values.
> > 
> > Hm. Does this really change anything though? The behaviour before and
> > after this patch are exactly the same as far as I understand, and by
> > explicitly handling the defaults we basically have to hard-code more
> > assumptions. So in the current form I don't see that this patch adds
> > much.
> 
> Hmm, I suppose it kinda depends on how you view it! :)
> 
> I have been looking at how the three build systems (well, mainly make
> and meson) differ in various ways, in order to try and determine if
> there are any significant differences and (most important) bugs.
> Reducing the differences allows me to more clearly identify the bugs. ;)

Fair.

> In this case, the original author(s) had clearly intended that the
> default values were included in the code, with the ability to override
> the values from the command-line/environment only for 'non-standard' or
> platform-specific uses. For example, on Windows and MINGW the
> DEFAULT_HELP_FORMAT is html, which is specified in the 'config.mak.uname'
> file. (I don't see this override in the meson build).
> 
> Also, the documentation (see git-var.adoc) has a statement of the compiled
> in choice for the default pager and default editor, *only* if they are *not*
> the standard values. I have a note, from several months ago, that says the
> meson build does not pass the 'git-default-pager' and 'git-default-editor'
> attributes to asciidoc. The make build only sets those attributes if the
> DEFAULT_PAGER and DEFAULT_EDITOR variables are *defined* (and they should
> *not* be defined to the 'standard' values or the docs would not read well).
> (see git-var.adoc lines 49-51 and 67-69, Documentation/Makefile lines 239-242
> and 244-247).
> 
> Also, I believe (ie I need to check) that the make build relies on the main
> Makefile export-ing DEFAULT_EDITOR and DEFAULT_PAGER (see line #2923) to
> make that work.
> 
> I haven't looked into all of that yet (it's one of the part #2 un-written
> patches), and I don't yet know how those values get 'transmitted' to the
> docs meson.build file.

Okay. I very much appreciate the work that you're investing into this
area!

> Also, although I have found some meson documentation (https://mesonbuild.com/),
> I haven't had the time to actually study it, so I have just used search to
> try and get some answers (it seems my search-fu leaves a lot to be desired).
> I was half expecting you to say something like 'hey, you don't do it like
> that ... do this instead ...'. ;)
> 
> [I tried searching for a option 'is_defined()' or 'is_default()' method or
> similar, but didn't find anything].

No, there isn't anything like that. What I'd do is to set the default
values to the empty string, which makes it easy enough to see whether
the user has overridden the value to something sensible. And instead of
having the default values defined in Meson, as well, we'd be able to use
the default as specified in code.

For the `default_help_format` variable it's a bit different as it's a
combo option. But what you can do is to e.g. add a third choice
'platform' and make that the default value. We could then check for it
and either set it to the empty string on non-Windows systems so that the
default defined in our code gets used. And on Windows you'd override it
to 'html'.

Alternatively we could also refactor this option so that the default
value gets defined entirely in code and then add an empty choice.

Patrick
