Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9480248863
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731377; cv=none; b=f9owUZ1zwJCfeJA+NirsXaCNr2R03XFFUUJ7dIDAGZwG4h6DimJu3951TIGlu3h1hdkt/JMp7qhLXF40asWmatQSuMbknBjZevGuNz90y/MDp2pZ0hH1PqaUj4NcGBaArMKByjw9W1K7ZVeFCeR6lI+w1sejtNR9t/+0BwYzavg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731377; c=relaxed/simple;
	bh=LLAn3VkXD6N93gBkxyb2pFUDfxc8G7hcJ4c9Q6xT4UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urgf2KsqTRS9YKr/hxrbQrjkt1bCSWdNnm2CyULRIrpcDyDUtIAiQT9yAw7O+TMFd5rUvPjr7Qw+MrLCWzOSWfgg3Vof3pJr5B1Rb4YWr55/HMjEijiyKSL0IAkYLJkFBcMd5hoLWlPKML6+3CsPzzRcr9mdMHJTGlkrCCMwFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pbxHS+9u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=axI2mUEv; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pbxHS+9u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="axI2mUEv"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id BC791138274E;
	Fri, 28 Feb 2025 03:29:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 28 Feb 2025 03:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740731374; x=1740817774; bh=Jxn1F5kYoR
	lttYa/i7VLNWcC3IGdUXYqWqY+gFiUl4Q=; b=pbxHS+9uiRwj8htRJihSvArvzk
	74a/tWunrly7XU0NI09DswKIdXXqNbamES5/nUO9I2M3eMWyaYjLoGCO4zMb6NOt
	3hybVfshkvIqfQ+LCH82Os4ikTJPOE7fL0TvcRk6ffkxCbe9///Y67GP59Ncjth3
	r72Ojy6HHva+plMHVRDkH4aWRTobffVi1bNg3aMswISDGvYlqXx/NrX6ztEnlhWS
	rthqcsabXNnHUWcegSd88NiRDnzwMNo+AXOxiaHkO8SAuESEth6yQrAv4kApDVQZ
	UndeIggP1LbKMHS43Jbdblpp8EjnNxReDRQ/3ae490LivAKHmQPTg9bluY5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740731374; x=1740817774; bh=Jxn1F5kYoRlttYa/i7VLNWcC3IGdUXYqWqY
	+gFiUl4Q=; b=axI2mUEvLByRU6dqvNG0pWjPY/DSLUcdf3KLEdK67E5LaC9Xfqy
	6ZW5QqUAiO0ZKbdbI/TvqPqWIBL6WtUal3LcPPTNHZ4kjPiY5GoKhm4902eOKXlL
	LPkx135rkh52UmslKp+U0VsH5132NwnOX7xaGK3Yuts7IwwXtv8+rVTsYK7wqpVg
	vdjn9pLFEvSiWpB1jZKwrYuPurgIV+nK08JUCEwQ2MRp8ib67qHoF34ESjSiZaRM
	algSqJeO2KnJvOID4n80WXurr8CKtG4TCV0aViLKKx2N3JhH47P81NtWWRQ/BjFU
	1parw33GLYHA21lWSmdTTmipuIyNjLGYBtA==
X-ME-Sender: <xms:7nPBZ720yK0snuug84YAptljff19Qr6F5kfukfvYdsphrEIyDeidhA>
    <xme:7nPBZ6HeCB2W2gOPQP-nNMD1r8JbN-HHjtyQVWmopU_RZdExziU_C8KKaoZMZeXGz
    oClkKVCzEchQHWf6w>
X-ME-Received: <xmr:7nPBZ77IlyadNLrCsECGTl75LjA8l8_ofTssxKDUcAZgac09JsY16F41BdmOCO4JVlZvIwAzQYHomQfFgHkkxXf87JuMtz8y--2o9mD_B6ui548M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekleeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:7nPBZw2ZBuW88o_44BdKBTeKgJqtOYqY01lBx2yfNG3R7lP2upY96A>
    <xmx:7nPBZ-GckAtNSYJo2xhwF1BX-P-PF3zAM9Dce3P2GZdRpyB3Ae9SZw>
    <xmx:7nPBZx-O1xd08PVNoLBQGmpI3rlXflr_go80YC7FekDLyOyo9ImJ1g>
    <xmx:7nPBZ7nuqCkmUrozLgmxOc3ITJ1mccbrstJNmjhpjATFXNnRtDxFqw>
    <xmx:7nPBZ7NMDX-qEeVMco4QyzcErRucIcKuh2vJRSfyOWIAZQk-Qdfve7z_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 03:29:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f7f91e79 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 08:29:33 +0000 (UTC)
Date: Fri, 28 Feb 2025 09:29:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, phillip.wood123@gmail.com,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/4] builtin: introduce diff-pairs command
Message-ID: <Z8Fz7CQimWgzrvz7@pks.im>
References: <20250225233925.1345086-1-jltobler@gmail.com>
 <20250228002604.3859939-1-jltobler@gmail.com>
 <20250228002604.3859939-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228002604.3859939-4-jltobler@gmail.com>

On Thu, Feb 27, 2025 at 06:26:03PM -0600, Justin Tobler wrote:
> diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
> new file mode 100644
> index 0000000000..5a993b7c9d
> --- /dev/null
> +++ b/builtin/diff-pairs.c
[snip]
> +int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
> +		   struct repository *repo)
> +{
> +	struct strbuf path_dst = STRBUF_INIT;
> +	struct strbuf path = STRBUF_INIT;
> +	struct strbuf meta = STRBUF_INIT;
> +	struct option *parseopts;
> +	struct rev_info revs;
> +	int line_term = '\0';
> +	int ret;
> +
> +	const char * const usagestr[] = {
> +		N_("git diff-pairs -z [<diff-options>]"),
> +		NULL
> +	};

We tend to call these `builtin_*_usage`, so in your case it would be
`builtin_diff_pairs_usage`.

> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	repo_init_revisions(repo, &revs, prefix);
> +
> +	/*
> +	 * Diff options are usually parsed implicitly as part of
> +	 * setup_revisions(). Explicitly handle parsing to ensure options are
> +	 * printed in the usage message.
> +	 */
> +	parseopts = add_diff_options(options, &revs.diffopt);
> +	show_usage_with_options_if_asked(argc, argv, usagestr, parseopts);
> +
> +	repo_config(repo, git_diff_basic_config, NULL);
> +	revs.disable_stdin = 1;
> +	revs.abbrev = 0;
> +	revs.diff = 1;
> +
> +	argc = parse_options(argc, argv, prefix, parseopts, usagestr,
> +			     PARSE_OPT_KEEP_UNKNOWN_OPT |
> +			     PARSE_OPT_KEEP_DASHDASH |
> +			     PARSE_OPT_KEEP_ARGV0);
> 
> +	if (setup_revisions(argc, argv, &revs, NULL) > 1)
> +		usagef(_("unrecognized argument: %s"), argv[0]);

Okay, we now use `parse_options()` to parse stuff for us, and
`setup_revisions()` only really does the setup for us as we know that
all relevant diff options should've already been parsed for us. This
looks much nicer to me.

I wonder though: we keep unknown options when calling `parse_options()`
and then end up passing them to `setup_revisions()`. But are there even
any options handled by `setup_revisions()` that would make sense in our
context? And if not, shouldn't we rather make `parse_options()` die in
case it sees unknown options?

If there are, we should probably document this because it isn't obvious
to me.

> diff --git a/t/t4070-diff-pairs.sh b/t/t4070-diff-pairs.sh
> new file mode 100755
> index 0000000000..8f17e55c7d
> --- /dev/null
> +++ b/t/t4070-diff-pairs.sh
> @@ -0,0 +1,81 @@
> +#!/bin/sh
> +
> +test_description='basic diff-pairs tests'
> +. ./test-lib.sh
> +
> +# This creates a diff with added, modified, deleted, renamed, copied, and
> +# typechange entries. This includes a submodule to test submodule diff support.
> +test_expect_success 'setup' '
> +	test_config_global protocol.file.allow always &&
> +	test_create_repo sub &&

Use of `test_create_repo ()` is deprecated, as it is merely a wrapper
around git-init(1).

Patrick
