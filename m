Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC017286D76
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049023; cv=none; b=qM8J8KnXiDxxLgW167mW/fWAQOalOZphp1ih/lfjUcuccO63GW7qaTrYkXauSzX7A6ExrDAZXtRrvhTKpznF58pQ+D5ukCffRMwRstLGwJqNM/UUH4bj+exY8fWX3cyE4qAHMBQ0oPz/RWj5LPA3R86C9OTiqBdEKa4NZTtskgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049023; c=relaxed/simple;
	bh=Y5hoHZDCqDOWFQTQcmoc5JUs4Sy5ALAOwn0DF5npA+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SQhUS07F+JBqg5Q20T625wLLAF+1ioq5H6RLWiQqsIaX54NtEd846lP8n5lA+m4CZ92HXp+EP1mw3ib0ufXJTPdZ94ncTfAUHZLcWFh+cFuyH8KEczSDXtF90HJK1XkhJAUoim48xrMpX5/KBGEmihqJ/uJ0QjpcO0GUrR+mCbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UVWZxNFk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IMGmCOfV; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UVWZxNFk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IMGmCOfV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DA6A0EC0129;
	Thu,  9 Oct 2025 18:30:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 09 Oct 2025 18:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760049020; x=1760135420; bh=6VYFDYG1bC
	DFYLJpp2v669BI9qgKpsdiDyFxo2D63Zg=; b=UVWZxNFkWf8yW+LOor30MfJOLN
	si0NiN9tpha45rHChElSBZG5ZRtJ/nGrz5y/aAF2DROrPOEVmOabZOsLQlFGycpr
	suhA2xqZuFiicb4HyUXqk2ITTU3ZQ87kAvjMXSbrNgJV9Ku/sM3WUVfsPWqKc/Rt
	fIuru/zJDK4QvG7ydOpixAc768/3aIw2y28YtvGPEX3M2SeDFnd6v1HLxuMa5vR+
	vfFVnbi/54Yf78HeQCsDahv0bdzGUH16s3b/GRrgOHPYn3PDwwh1HYrxeIIIRRUw
	x8DP9TVFacmIUvUvQHD61+XfCVlzAw1QObmlHg8nCVck4xx2vEegMk3/eGmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760049020; x=1760135420; bh=6VYFDYG1bCDFYLJpp2v669BI9qgKpsdiDyF
	xo2D63Zg=; b=IMGmCOfVIIH30uxUoNo72s3X7fhjo2UKtKN4MWR3juhtf8bIiRa
	jhDo0zNKJw0YP9TrdbIanmeTLfyNLNWwWSFREdnk09Ab6YWuAlVQYJM0f2NB+HeQ
	LJFYDgX7Vso2mmEZ7haVBMZ1MKj+WkWng394LtDNLTrq4EheAN2NVf2aJLxzNVV7
	7UXtpue7A1zE1d3RH2zqIEb8ANKXwrfCSbp+wSgPRzx6MNEyvoKswtfnDJP2IStl
	h3fnz7cHK/Y3LL6Cj38bLEmVBpiUQR1i7PieknF+JF09nTosJIf5cl/KDPemHtOz
	f9VIW4dY9DmSsiN/JWKRg0ZlHhcJpsroiYg==
X-ME-Sender: <xms:fDfoaMXrhyn5KqRMvVTgxNo2lONKFJzbDJGD8VUS-UthB1mf1UjB3A>
    <xme:fDfoaNge248xewWKUjcHuD85Y3xfaUm-ij4QkF7hyNBXYAa7Hyl0yrK3fmSHXHjou
    1AzcqJASFU8IiiQqXDE6qQDnBEksmswcamizUcEL8FPorgrelO4FA>
X-ME-Received: <xmr:fDfoaMBPC1Jg3Xn3O_s65-RaKxp4yRaiTNCvsmJLn7tMQz4dOk0Z4wlUP2IGwv8E7_kWboDrb3sNyC3Q1oEBPDQom-GgMLpHIzoi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepvghmihhlhiihrghnghdrghhithesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fDfoaDsDtkWJKKS9jo-qPD09u2Urm4KSr3l3PWmW_IaSfzOamJcHlg>
    <xmx:fDfoaAdggjqMfVvHAFvbwkqljk37xr37nln0IsekLq12fIc_EL3Blw>
    <xmx:fDfoaI99ACeadyvTKKwQ2AGoRNSqRJZ9F240A2SjGPhtMe-N72USDA>
    <xmx:fDfoaDTQiwCddXu_nmVdFwjs1cXnIqxcJd2L-JJx5PDAMIZDWqwaFA>
    <xmx:fDfoaMhjWRQIcrX066sqXOdN9K1lVDgNp5swirLxyvbJbunDF_GbBXD3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 18:30:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Emily Yang via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  stolee@gmail.com,  me@ttaylorr.com,  ps@pks.im,
  newren@gmail.com,  Emily Yang <emilyyang.git@gmail.com>
Subject: Re: [PATCH] commit-graph: add new config for changed-paths &
 recommend it in scalar
In-Reply-To: <pull.1983.git.1760043710502.gitgitgadget@gmail.com> (Emily Yang
	via GitGitGadget's message of "Thu, 09 Oct 2025 21:01:50 +0000")
References: <pull.1983.git.1760043710502.gitgitgadget@gmail.com>
Date: Thu, 09 Oct 2025 15:30:14 -0700
Message-ID: <xmqqecrbd7yh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Emily Yang via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Emily Yang <emilyyang.git@gmail.com>
>
> The changed-path Bloom filters feature has proven stable and reliable
> over several years of use, delivering significant performance
> improvement for file history computation in large monorepos. Currently
> a user can opt-in to writing the changed-path Bloom filters using the
> "--changed-paths" option to "git commit-graph write". The filters will
> be persisted until the user drops the filters using the
> "--no-changed-paths" option.

Makes sense.

> Large monorepos using Git's background maintenance to build and update
> commit-graph files could use an easy switch to enable this feature
> without a foreground computation.

Again makes sense.

> In this commit, we're proposing a new
> config option "commitGraph.changedPaths" - "true" value acts like
> "--changed-paths"; "false" disables a previous "true" config value but
> doesn't imply "--no-changed-paths".

The way the above is phrased is so unusual that I am afraid it would
confuse readers.

When a configuration variable gives an opportunity for the users to
override the hardcoded default (in this case, --no-changed-paths has
been the traditional default, and graph.changedPaths=true would make
us pretend as if --changed-paths were given from the command line).
So if we were to have this configuration variable, setting it false
MUST make it pretend as if --no-changed-paths were given from the
command line, and MUST continue to do so even in some future we
changed the hardcoded default to be "true" (i.e., unless the user
says graph.changedPath=false in the configuration and/or declines
with "--no-changed-paths" from the command line, we will record the
changed paths filter by default).

Setting commitGraph.changedPaths to true should mean that the
"git commit-graph write" command behaves as if --changed-paths
were given immediately after that "write", so that an end-user
commmand

    $ git commit-graph write

should behave as if it was written like this

    $ git commit-graph write --changed-paths

and

    $ git commit-graph write --no-changed-paths

should behave as if it was written like this

    $ git commit-graph write --changed-paths --no-changed-paths

i.e. allowing the command line --no-changed-paths to override it.

Setting commitGraph.changedPaths to false should similarly mean that
"--no-changed-paths" implicitly is added immediately after "write",
meaning that 

    $ git commit-graph write

should behave as if it was written like this

    $ git commit-graph write --no-changed-paths

As it is the default not to write changed-paths filter, this has no
effect, but I would say it still "implies" --no-changed-paths, and I
hope you'd agree once you imagine a hypothetical future in which the
default for "git commit-graph write" is to write changed-paths
filter by default.

> This config will always respect the
> precedence of command line option "--changed-paths" and
> "--no-changed-paths".

This is a bit unusual way to phrase this, but I think it makes sense
for the configuraiton variable to be overridden by the command line
option, as that is the bog-standard way configuration variables and
command line options interact with each other; it is so standard
that it is probably not even worth saying it.

> We also set this new config as optional recommended config in scalar to
> turn on this feature for large repos.

Great.  Yes, from the start of the description above, anybody who is
aware of the "scalar" effort would be anticipating this conclusion.

> Helped-by: Derrick Stolee <stolee@gmail.com>
> Signed-off-by: Emily Yang <emilyyang.git@gmail.com>
> ---
>     commit-graph: add new config for changed-paths & recommend it in scalar
>     
>     Hello,
>     
>     I'm Emily and I'm interested in contributing to Git. This is my first
>     contribution to Git, super excited!
>     
>     I'm from Microsoft and spend most of my time working in the Office
>     MonoRepo (OMR, one of the largest repos in the world). Recently I've
>     been working with Derrick Stolee on Git performance related topics. We'd
>     love to propose a small enhancement on the existing changed-paths Bloom
>     filters feature to benefit large repos like OMR. Please kindly review
>     the code and provide your feedback!
>     
>     Thanks, Emily
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1983%2Femilyyang-ms%2Fchanged-paths-config-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1983/emilyyang-ms/changed-paths-config-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1983
>
>  Documentation/config/commitgraph.adoc |  8 +++++
>  builtin/commit-graph.c                |  2 ++
>  scalar.c                              |  1 +
>  t/t5318-commit-graph.sh               | 44 +++++++++++++++++++++++++++
>  4 files changed, 55 insertions(+)
>
> diff --git a/Documentation/config/commitgraph.adoc b/Documentation/config/commitgraph.adoc
> index 7f8c9d6638..c540e8a43d 100644
> --- a/Documentation/config/commitgraph.adoc
> +++ b/Documentation/config/commitgraph.adoc
> @@ -8,6 +8,14 @@ commitGraph.maxNewFilters::
>  	Specifies the default value for the `--max-new-filters` option of `git
>  	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
>  
> +commitGraph.changedPaths::
> +	If true, then `git commit-graph write` will compute and write
> +	changed-path Bloom filters by default, equivalent to passing
> +	`--changed-paths`. If false or unset, changed-path Bloom filters
> +	will only be written when explicitly requested via `--changed-paths`.
> +	Command-line options always take precedence over this configuration.
> +	Defaults to unset.
> +
>  commitGraph.readChangedPaths::
>  	Deprecated. Equivalent to commitGraph.changedPathsVersion=-1 if true, and
>  	commitGraph.changedPathsVersion=0 if false. (If commitGraph.changedPathVersion
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index fe3ebaadad..d62005edc0 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -210,6 +210,8 @@ static int git_commit_graph_write_config(const char *var, const char *value,
>  {
>  	if (!strcmp(var, "commitgraph.maxnewfilters"))
>  		write_opts.max_new_filters = git_config_int(var, value, ctx->kvi);
> +	else if (!strcmp(var, "commitgraph.changedpaths"))
> +		opts.enable_changed_paths = git_config_bool(var, value) ? 1 : -1;

This is iffy.

Unless the way existing command line parser figures out if the user
wants or does not want to use the feature is so screwed up, you
shouldn't have to do any such thing.

Why do you need to special case 'false' this way?  The usual
practice is

 * First, you initialize the variable "enable_changed_paths" with the
   hardcoded default.  In this case, as changed-paths is not written
   by default, you'd initialize it to 0 (not -1).

 * Then you read from the configuration variables to update it.  If
   you see commitgraph.changedPaths configuration, you take its
   value (either 0 or 1 as it is a Boolean variable) and overwrite
   the hardcoded default in the "enable_changed_paths" variable.  Otherwise
   you leave "enable_changed_paths" as-is.

 * If you also have environment variable override, then you see if
   there is the environment variable you care about, and if so,
   override "enable_changed_paths" with its value.  Otherwise you leave
   "enable_changed_paths" as-is.

 * Finally you read from the command line options using
   parse_options().  If there are command line options given,
   "enable_changed_paths" would be overriden again.

If the way the existing parser sets up enable_changed_paths is
screwed up and does not follow the above pattern (I didn't check),
perhaps you'd need a preliminary clean-up patch before adding this
new feature.

Thanks.
