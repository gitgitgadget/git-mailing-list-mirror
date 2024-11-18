Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E6E170A26
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922218; cv=none; b=npy19LdKimNXCMSl9rZnFXEGdA1yTP2scn3l9ATp+UKt+D7weRO1XnIRO+rSJVovCCRklS+NIH1xHQL4Jj1derL1c18aa0BHqcaDwDeniNBluhn3psVdKxmGm770icfPcOaBEM4HVt5i01NtxDNaeoe93qmnkLQCqlivHgCD11Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922218; c=relaxed/simple;
	bh=ZdIJO7x2aajhvOyJZCz976jnDDTxzJmiXy1KEWvaeD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2P+UoEzsU3NzZgzU7NVDL94s+ZmBrQXi8moQTLYXwBGafEKXu8humdpab/qP8zr8D9SZr55HFza8cXxKpcwS9OYMyjLW4mK5TuyPLM6IHLWnGNGHngQEg799ZKuG6IjeI1iedfL5ajpdVja6tIcexwGex8l5tyjTjEalMy++XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CY9dk4ri; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KnS6DLOq; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CY9dk4ri";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KnS6DLOq"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A5132114017D;
	Mon, 18 Nov 2024 04:30:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 18 Nov 2024 04:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731922214;
	 x=1732008614; bh=YSrvRggIVWhRPkeEOOGM4h6IeWjdA+v/Gaoh/slJtH8=; b=
	CY9dk4riyknkwV1OyOoHtJE/OI+y+NWyLhEd4dDK+MltS6tHN+/AAkYj6WV2knid
	NT5kXMQSpK/k2+S1S4sBuZrqK2/G6CHcwwKE1HMcbeXE7zgw2gD/0pG+oIVvmzhi
	loZyECGIOboQFA8ZgoJQDtlVL4tm7rISUorEN2AeXeikgOHv/VJ1MUrVZNIQTYiy
	8H9A1Ho+bJZqs2R9gpMNJY49hAoyOCt9vIY+bvOLDGfynQLQGy0mHEjMC64nIdEt
	yGJW0BunhHQO1R7rxzJYZi8zXonrayOEHRH9zztgGt0GZ1rvrXHvt5IcImFj8g93
	cO9audVI0EW96CQL/fbhvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731922214; x=
	1732008614; bh=YSrvRggIVWhRPkeEOOGM4h6IeWjdA+v/Gaoh/slJtH8=; b=K
	nS6DLOqBjsDSWOIFT0mRyU10jNvOsasTgP5pTTHOZgtCvF7k2XjyWjrX3Nz6/zmy
	7RIBF7eEyDn2BRJSwf0HuRDAwH0VI+Yf6fDPMxYiq+DpKKKwF6COkI2w+tnzt9KZ
	f1e6Go057i67GdYVrDPDpac1ea30l7R3wupNFxnuq3JmsYJ0FdJVEvyVZc/kS/ai
	sp3TENAzUUJK6Reer8m+YCwDtMxvV1ArqUUhgHjZJFag6GWRn7yO+iFLdDRMN52M
	Lf1L81Eg91H6H6SXJAhJeunH9xADDfKWvsjmwJ8hbUt5X3yNXfbYCMiQqnhQUrak
	X+95X6o6+K+xdrDizqaVQ==
X-ME-Sender: <xms:JQk7Z5rGT3tqBwajdrZ9kmRJBHAeXcuCkpA8jsMIxX8T9O1BrnhtMA>
    <xme:JQk7Z7oHVBfLNJ_qHRZtTjecKH_RCUage8xkWKKfiRfBaOO4VnwtMtyiW7MnfLHJP
    2pO6aIv_bYdlyxntw>
X-ME-Received: <xmr:JQk7Z2O-kNC8lq1fKAwW1PScoPypNi9GQWgsIVjGCzD6eSDIBpLU_ArvNdGSoIRRnNw3wFcO-Drr53LqUy34Bj7K_x0k8rBNLLTFgkGs-8N4CKcd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdevteff
    vdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtoheptghhrhhi
    shhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrg
    ihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:JQk7Z05u1Xo-9IbslFhm4uaNt30_0Ddy42nlvnoYoFC567hm3x0Ibg>
    <xmx:JQk7Z47PJZ7q5_vO31oQfpcWYU-4ThQ8Oq4SHPgm7xgqqcS98AsyGA>
    <xmx:JQk7Z8iPYUqoPT8oeuScA6QEzz2IapatAH6zWSoBH7bAYk1y-2iApQ>
    <xmx:JQk7Z655tcHyLYSkWCwnaODoJnDtgmSytbbMBx0cwJi_I3x3wsgIKg>
    <xmx:Jgk7Z4gkGwsE-dbpDl7HA6rggFpSKAwU0gPV3n2Tab394ZKax-hzFrE_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 04:30:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5cc36ad5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 09:29:20 +0000 (UTC)
Date: Mon, 18 Nov 2024 10:29:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH RFC v7 21/22] Introduce support for the Meson build system
Message-ID: <ZzsJFr6TAdlI5eb7@pks.im>
References: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
 <20241115-pks-meson-v7-21-47ec19b780b2@pks.im>
 <CAP8UFD17rBAg6xYdA6BsNCgYtqBv_gijWj3EG_JZV+RL8ZaNnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD17rBAg6xYdA6BsNCgYtqBv_gijWj3EG_JZV+RL8ZaNnQ@mail.gmail.com>

On Fri, Nov 15, 2024 at 01:20:55PM +0100, Christian Couder wrote:
> On Fri, Nov 15, 2024 at 8:21 AM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > +# Basic usage
> > +# ===========
> > +#
> > +# In the most trivial case, you can configure, build and install Git like this:
> > +#
> > +#  1. Set up the build directory. This only needs to happen once per build
> > +#     directory you want to have. You can also configure multiple different
> > +#     build directories with different configurations.
> > +#
> > +#      $ meson setup build/
> > +#
> > +#     The build directory gets ignored by Git automatically as Meson will write
> > +#     a ".gitignore" file into it. From hereon, we will assume that you execute
> > +#     commands inside this build directory.
> > +#
> > +# 2. Compile Git. You can either use Meson, Ninja or Samurai to do this, so all
> > +#    of the following invocations are equivalent:
> > +#
> > +#      $ meson compile
> > +#      $ ninja
> > +#      $ samu
> > +#
> > +#   The different invocations should ultimately not make much of a difference.
> > +#   Using Meson also works with other generators though, like when the build
> > +#   directory has been set up for use with Microsoft Visual Studio.
> 
> I think it might be helpful to say if the above commands are using
> multiple processes in parallel (like `make -j 10` for example) to
> build or not. If they are using multiple processes, it might be useful
> to shortly say how the number of processes used is computed. If they
> are not using multiple processes, it might be interesting to say if an
> option exists for this or not, and if not, why.

Yup, will add a note. Ninja and Samurai scale with the number of
processor cores by default. The number of jobs can be changed with the
`-jN` flag.

> If the above commands use ccache or can use it, or similar tools, it
> could be interesting to say so too.

Added a note.

> > +#
> > +# 3. Execute tests. Again, you can either use Meson, Ninja or Samurai to do this:
> > +#
> > +#      $ meson test
> > +#      $ ninja test
> > +#      $ samu test
> > +#
> > +#   It is recommended to use Meson in this case though as it also provides you
> > +#   additional features that the other build systems don't have available.
> > +#   You can e.g. pass additional arguments to the test executables or run
> > +#   individual tests:
> > +#
> > +#      # Execute the t0000-basic integration test and t-reftable-stack unit test.
> > +#      $ meson test t0000-basic t-reftable-stack
> > +#
> > +#      # Execute all reftable unit tests.
> > +#      $ meson test t-reftable-*
> > +#
> > +#      # Execute all tests and stop with the first failure.
> > +#      $ meson test --maxfail 1
> > +#
> > +#      # Execute single test interactively such that features like `debug ()` work.
> > +#      $ meson test -i --test-args='-ix' t1400-update-ref
> 
> How about executing tests in parallel? I am asking because it's an
> easy way to speed up test execution.

Tests are executed in parallel by default. Same as above, you can change
this with `-jN`.

> > +# 4. Install the Git distribution. Again, this can be done via Meson, Ninja or
> > +#    Samurai:
> > +#
> > +#      $ meson install
> > +#      $ ninja install
> > +#      $ samu install
> > +#
> > +#    The prefix into which Git shall be installed is defined when setting up
> > +#    the build directory. More on that in the "Configuration" section.
> > +#
> > +# Meson supports multiple backends. The default backend generates Ninja build
> > +# instructions, but it also supports the generation of Microsoft Visual
> > +# Studio solutions as well as Xcode projects. IDEs like Eclipse and Visual
> > +# Studio Code provide plugins to import Meson files directly.
> 
> So I guess it's not necessary to configure Meson to make it use a
> backend that generates VS Code or Xcode projects.

I've added a note on how to set the backend.

> > +# Configuration
> > +# =============
> > +#
> > +# The exact configuration of Git is determined when setting up the build
> > +# directory via `meson setup`. Unless told otherwise, Meson will automatically
> > +# detect the availability of various bits and pieces. There are two different
> > +# kinds of options that can be used to further tweak the build:
> > +#
> > +#   - Built-in options provided by Meson.
> > +#
> > +#   - Options defined by the project in the "meson_options.txt" file.
> > +#
> > +# Both kinds of options can be inspected by running `meson configure` in the
> > +# build directory, which will give you a list of the current value for all
> > +# options.
> > +#
> > +# Options can be configured either when setting up the build directory or can
> > +# be changed in preexisting build directories:
> > +#
> > +#      # Set up a new build directory with optimized settings that will be
> > +#      # installed into an alternative prefix.
> > +#      $ meson setup --buildtype release --optimization 3 --strip --prefix=/home/$USER build
> 
> "build" is the name that was already given to the build directory
> above in this doc, so it might be better to use something else, like
> maybe "build-optimized/".

It's only an example anyway, so I don't think it matters much whether
the directory names repeat. Same with the following commands.

> > +#      # Set up a new build directory with a higher warning level. Level 2 is
> > +#      # mostly equivalent to setting DEVELOPER=1, level 3 and "everything"
> > +#      # will enable even more warnings.
> > +#      $ meson setup -Dwarning_level=2
> 
> There is no name for the new build directory in the above command,
> maybe something like "build-warning/" should be added.
> 
> > +#      # Set up a new build directory with 'address' and 'undefined' sanitizers
> > +#      # using Clang.
> > +#      $ CC=clang meson setup -Db_sanitize=address,undefined build
> 
> Maybe "build-address/" instead of "build".
> 
> > +#      # Disable tests in a preexisting build directory.
> > +#      $ meson configure -Dtests=false
> 
> What happens if we run `meson test` then?

Meson simply prints "No tests defined."

> > +#      # Disable features based on Python
> > +#      $ meson configure -Dpython=disabled
> > +#
> > +# Options have a type like booleans, choices, strings or features. Features are
> > +# somewhat special as they can have one of three values: enabled, disabled or
> > +# auto. While the first two values are self-explanatory, "auto" will enable or
> > +# disable the feature based on the availability of prerequisites to support it.
> > +# Python-based features for example will be enabled automatically when a Python
> > +# interpreter could be found. The default value of such features can be changed
> > +# globally via `meson setup --auto-features={enabled,disabled,auto}`, which
> > +# will set the value of all features with a value of "auto" to the provided one
> > +# by default.
> 
> "globally" here means for all the builds directories of the current
> system user, or for all the build directories inside the directory
> where `meson setup --auto-features={enabled,disabled,auto}` was run,
> or just for all the features in the current build directory if this is
> run inside a build directory?

The last one. I'll just drop this word.

> > +# It is also possible to store a set of configuration options in machine files.
> > +# This can be useful in case you regularly want to reuse the same set of options:
> > +#
> > +#   [binaries]
> > +#   c = ['clang']
> > +#   ar = ['ar']
> > +#
> > +#   [project options]
> > +#   gettext = 'disabled'
> > +#   default_editor = 'vim'
> > +#
> > +#   [built-in options]
> > +#   b_lto = true
> > +#   b_sanitize = 'address,undefined'
> > +#
> > +# These machine files can be passed to Meson via `meson setup --native-file`.
> 
> I think it might be helpful to say that "machine files" is the name
> used by meson for basically "config files".
> 
> Also it's not very clear which build directories will be impacted when
> `meson setup --native-file my-machine-file` is run.

As `meson setup` sets up a new build directory it is that particular
directory. I've reworded this a bit.

> > +# Subproject wrappers
> > +# ===================
> > +#
> > +# Subproject wrappers are a feature provided by Meson that allow the automatic
> 
> s/allow/allows/
> 
> > +# fallback to a "wrapped" dependency in case the dependency is not provided by
> > +# the system. For example if the system is lacking curl, then Meson will use
> > +# "subprojects/curl.wrap" to set up curl as a subproject and compile and link
> > +# the dependency into Git itself. This is especially helpful on systems like
> > +# Windows, where you typically don't have such dependencies installed.
> > +#
> > +# The use of subproject wrappers can be disabled by executing `meson setup
> > +# --wrap-mode nofallback`.
> 
> It's not very clear which build directories will be impacted by this command.

Reformulated slightly.

Thanks for your feedback!

Patrick
