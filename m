Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CBA1DF992
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504289; cv=none; b=cpDBzKwtmGTTXigHsiGUa+YcVMYEymhyej2KKIvNObvQcfOfgj7w2hA6enBmL0j1jT/Yf+za6yKiPI6/ysX1LFgFtKvJNNT6zPdT7HPK16B4tD9d2V1c86zfn4EkmeU9JSjbHAO23k7Q5JUbR0wnDt51ghh5pIn2SGuVvIQ+vTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504289; c=relaxed/simple;
	bh=KsRMlEYNO7CcNvYSvIBl8pWbs25BikNATRf/5w/8Jds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Le4icofdCZoJKksieW148F7dSWWwrx+U9F80tKeTi8uvsoJjKCXu4kKZ5Yv3TITaNM3Zek8xsTcA6p8zvHOfplQdShlAeXFW50S8FWVn9Rd/PRiug23W3xnX8y96t/W3NAezQ5LSDqysiFwWwlbw6MhWPMyIWDepbw8r68AREN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QLPK9ET+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QfgiYtsb; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QLPK9ET+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QfgiYtsb"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 13168138028D;
	Wed, 13 Nov 2024 08:24:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 13 Nov 2024 08:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731504286;
	 x=1731590686; bh=GN8Yb6hUTA3Eo74DIUZuRdM6ylWU63idPe95vLlWB/s=; b=
	QLPK9ET+uCk4HDRU08SrKBfnsRRvSrHncBHO6ByA3DzK63rT/pH7/4OQC623ByKv
	p1xoMNqhbRHTga8bzGTp4HNnklZ3crQmCr9iVjD4yQXaVA605FVUky+JDqLX0cbz
	OrVAAsKXgFwx/Ros+nxjWEMZzEKzVrhn0Iak9LoNCJj0pj/v2/XVqLhfL8fPf3YV
	V4PPWfODXrfvsDlEBm2+EXiUqFgjCyUrfX/GNzzDXzlhd7aGBxy7puMCeDuYlwVH
	xuzmN7KDK7FLZAd5bvHFUvj+zS7Rp/LPjxKBRMjh/5Jh0QecL7L2Wsk32T4ywKVo
	Cfrlr7ylvGxK/Ap2UjDMbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731504286; x=
	1731590686; bh=GN8Yb6hUTA3Eo74DIUZuRdM6ylWU63idPe95vLlWB/s=; b=Q
	fgiYtsbx3i2kLsQOTcnBunJFyxBMw7rw7lC+y7IlefqSwRsMwKuUKROwuuqnSWLR
	xyxMl+vZy4QQms2f9kYvRE5ZSAtvxA3ULmV/7XuYrmQz47pGMX5K0MlodgtogKWT
	X+c7ni2mLOzIcQJUR/SkNB3DMnpDz/qziZRjSxkiT0Awr0wcy9hcy+FmxgcptM9X
	+As5XEBuSV3/xQJ0C3XUOo45MFaA7pGID21InWPojtcf3IOjWw66oqc2NMY2C0Gh
	bWFzoG+WjySduRnavmhW0wYknYyhSSyaNpJkWkrRzaMDTPpCnlAYLdMwQ2c87gxm
	miJ3ozycIDipiQhm8nuhg==
X-ME-Sender: <xms:nag0Z4ork4ree1mkzCAlYjHUgtmuNkeKtsE3_Zp3heTKtK3Xb45naA>
    <xme:nag0Z-qh9VDNQ3yEexZm0I-E47RlvbvRnc-dC26rRGnJmcfw5n08iWkIWRmDGWcHC
    _ti9JJ-7-3193B2nA>
X-ME-Received: <xmr:nag0Z9OEJk-BPR0cwua9Wp-nk4ET_bYEJVbMTpjbTYP_LNrWRZehR3_bYwS4vXeQMl3mQoNnaDf0iAZecym0rIM4tKd7x3kh9bB7L8AWjmr1JFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdevteff
    vdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
    dprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsuhhn
    shhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomh
X-ME-Proxy: <xmx:nag0Z_6LIwCf-mxrlGp4exWm29CmGPfXWV3MAxU9T4HntfElpnLesA>
    <xmx:nag0Z36TVI1SqdyWpsAMGK8RiXp9P0lAOvENgAjapu41ZvBBB0MXQQ>
    <xmx:nag0Z_iclOZsGT7JLCe7NyJTR3V6J2IWlnQtR5KukC-uV7zRFStEDA>
    <xmx:nag0Zx43i-l74s2lc06oY6-_gxZpfQTKZA13x05tFtuJtygXKRDOcQ>
    <xmx:nqg0Z0wBHzHHlQQYO-3XSUXBMekBugp3ZLnlftQ2AmgNza5KXASAIYIV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 08:24:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0f0f64dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Nov 2024 13:24:02 +0000 (UTC)
Date: Wed, 13 Nov 2024 14:24:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC v6 00/19] Modernize the build system
Message-ID: <ZzSokK7bJmfyNzrq@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <20241112-pks-meson-v6-0-648b30996827@pks.im>
 <CAP8UFD1qNyWbOvUm2q2ZTcV+Ut_=ZJkURYqF7PnJxyJsvkchEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1qNyWbOvUm2q2ZTcV+Ut_=ZJkURYqF7PnJxyJsvkchEw@mail.gmail.com>

On Wed, Nov 13, 2024 at 11:45:41AM +0100, Christian Couder wrote:
> On Tue, Nov 12, 2024 at 9:42 PM Patrick Steinhardt <ps@pks.im> wrote:
> 
> >     ++#    The prefix into which Git shall be installed is defined when setting up
> >     ++#    the build directory. More on that in the "Configuration" section.
> >     ++#
> >     ++# Meson supports multiple backends. The default backend generates Ninja build
> >     ++# instructions, but it also supports the generation of Microsoft Visual
> >     ++# Studio solutions as well as Xcode projects. IDEs like Eclipse and Visual
> >     ++# Studio Code provide plugins to import Meson files directly.
> >     ++#
> >     ++# Configuration
> >     ++# =============
> >     ++#
> >     ++# The exact configuration of Git is determined when setting up the Git
> >     ++# directory.
> 
> Is it the "Git directory" or the "build directory"?
> 
> It might be helpful to repeat that this happens when `meson setup
> build/` is run (as far as I understand it). Maybe something like:
> 
> "The exact configuration of Git is determined when setting up the
> build directory, so when running `meson setup <build-dir>/`."

Good catch, this is of course the build directory. I've also adapted
in the spirit of your proposed text.

> >Unless told otherwise, Meson will automatically detect the
> >     ++# availability of various bits and pieces. There are two different kinds of
> >     ++# options that can be used to further tweak the build:
> >     ++#
> >     ++#   - Built-in options provided by Meson.
> >     ++#
> >     ++#   - Options defined by the project in the "meson_options.txt" file.
> >     ++#
> >     ++# Both kinds of options can be inspected by running `meson configure` in the
> >     ++# build directory, which will give you a list of the current value for all
> >     ++# options.
> >     ++#
> >     ++# Options can be configured either when setting up the build directory or can
> >     ++# be changed in preexisting build directories:
> >     ++#
> >     ++#      # Set up a build directory with optimized settings that will be
> >     ++#      # installed into an alternative prefix.
> >     ++#      $ meson setup --buildtype release --optimization 3 --strip --prefix=/home/$USER
> 
> It's not very clear if the above instruction should be run inside an
> existing build directory to modify its configuration, or if it creates
> a new build directory. If it creates one, it's also not clear what the
> name of that directory would be. Maybe "build", but then what if an
> existing build directory exists with that name?

Oh, that's because I forgot to add the name of the build directory.

[snip]
> >     ++#      # Disable features based on Python
> >     ++#      $ meson configure -Dpython=disabled
> >     ++#
> >     ++#      # Disable features based on Python
> >     ++#      $ meson configure -Dpython=disabled
> 
> It looks like there is some duplication above.

Ah, indeed.

> >     ++# Options have a type like booleans, choices, strings or features. Features are
> >     ++# somewhat special as they can have one of three values: enabled, disabled or
> >     ++# auto. While the first two values are self-explanatory, "auto" will enable or
> >     ++# disable the feature based on the availability of prerequisites to support it.
> >     ++# Python-based features for example will be enabled automatically when a Python
> >     ++# interpreter could be found. The default value of such features can be changed
> >     ++# globally via `meson setup --auto-features={enabled,disabled,auto}`, which
> >     ++# will set the value of all features with a value of "auto" to the provided one
> >     ++# by default.
> >     ++#
> >     ++# It is also possible to store a set of configuration options in machine files.
> 
> It's not very clear what a "machine file" is. How is it different from
> a config file?

It's not, the machine file is a configuration file. It's just what Meson
calls it.

> >     ++# This can be useful in case you regularly want to reuse the same set of options:
> >     ++#
> >     ++#   [binaries]
> >     ++#   c = ['clang']
> >     ++#   ar = ['ar']
> >     ++#
> >     ++#   [project options]
> >     ++#   gettext = 'disabled'
> >     ++#   default_editor = 'vim'
> >     ++#
> >     ++#   [built-in options]
> >     ++#   b_lto = true
> >     ++#   b_sanitize = 'address,undefined'
> >     ++#
> >     ++# These machine files can be passed to Meson via `meson setup --native-file`.
> >     ++#
> >     ++# Subproject wrappers
> >     ++# ===================
> >     ++#
> >     ++# Subproject wrappers are a feature provided by Meson that allow the automatic
> >     ++# fallback to a "wrapped" dependency in case the dependency is not provided by
> >     ++# the system. For example if the system is lacking curl, then Meson will use
> >     ++# "subprojects/curl.wrap" to set up curl as a subproject and compile and link
> >     ++# the dependency into Git itself. This is especially helpful on systems like
> >     ++# Windows, where you typically don't have such dependencies installed.
> >     ++#
> >     ++# The use of subproject wrappers can be disabled by executing `meson setup
> >     ++# --wrap-mode nofallback`.
> 
> I guess this will make the build fail if the system doesn't provide curl then.

It depends on the value of the feature. If it's set to 'enabled' then
yes, Meson would fail. If it's set to 'auto' then it would simply
disable the feature and continue.

Right now it's set to 'enabled', so yes, we'd fail.

Patrick
