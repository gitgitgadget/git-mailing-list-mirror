Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D9E22D781
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660975; cv=none; b=ZyYQNb5iS3VN6LBAOuJ5VaxkgNL49r/V+kwG1n9piS2OttzJpS2hUxYbdOb54syhqGOgg2BTjtTeSa4k3uiGOIpi5oS8h4ZO14AEdOQ9FN6fCLVxbqAtUtkzcUgsSMtf6DGim4J/2XAzZX5paCx8vF/oCoeUZ3tjQZp4R67C3+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660975; c=relaxed/simple;
	bh=XlZ1ZLu6mcryG5tYFt9GouYLpvZfpvzzjn+fVs9eKTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7pA/rzaTjj6z/doW4b99i3zW1rSEUiMCliIHduALKUvZCe1Z8HMXDIbNXtoxWXbCUjUCgYelhynYBk/IAAObDOTrlleYZiRZz5zt5QFfv2l6vwpsH/EvCrgMYEnsvMdqdRwZbmTf6rfb8UyFpOyCxjPCGhCShJ4LNqGwTaYDmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aubSCaLL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kmH1fdIR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aubSCaLL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kmH1fdIR"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 71BAE1140B73;
	Thu, 27 Feb 2025 07:56:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 27 Feb 2025 07:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740660971; x=1740747371; bh=Of3gIKXpk3
	dLTum7oA2j1zMDI+LGuCCvM0YfbkcqIjQ=; b=aubSCaLLs8fYRTvUvDK95tXzOY
	axIO2wOrg8KjY8nDjDcpBhXg5mxMWeq87fivX/R38jYE1yry9WD3iPezQTh/61B+
	Kej7TTv9+xRqUbrEdz3B5RA7YldsGoGlCMw5Okiuc94UT+hWGwW/YBwtBgmvrGXz
	rwSHhWmztjHo8Me8CtgOg1YHlEqzDPauOTNhmvWSaYXLyChDH20pZcO+OGJ3jJFV
	tHX6KJrQjct4BWsOvd0br0Nd3bZlGVopxrMqkVF+/DhEwTTUB2T60yRG/e92azXu
	xkfIQpTJuJq+g/NuJhoO9Bd+GM/a1cMH0rsj/SR0Y3frfi6hOWlCVnLbiZeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740660971; x=1740747371; bh=Of3gIKXpk3dLTum7oA2j1zMDI+LGuCCvM0Y
	fbkcqIjQ=; b=kmH1fdIRCnpD3tkT3rzwf3MQurpZHPMCSjfBB3GHOPQGVhrLJla
	XWj8rQoDtEKGFW2T/revb99sQBnBFiCuyBHiENW9QTYRQ3l5On8wfxHRayf77pva
	+u/Qx2X3W0gk72+khUClycmxz7Xxc3FD1Og+9b9HBfIK3oFtFJjrYeQMQRLBEqMZ
	+NKgDXEgSvkd2lXHqnJsKM7BbC/kEZz9/ZThRbkJK3d9s1oXD/4HtzoJOUYPfSAj
	drg3nBCv5X7jJlcF65t7yzR8A3scUp4uM14fmm7PSmkuM08+eThSuQwlPhjtPAeA
	juySkbPFSw7Awhxm9OLATe83+ePdqOzAS4w==
X-ME-Sender: <xms:62DAZyUEoduptXrREAcw3Qsz8SVuSTfR9Gx3rebyahKFYAxTLgVH3w>
    <xme:62DAZ-kdWl1LHXlyatnhH4cVbACt_RmOHhn9kHD52p95qP11AUm848rZD1zg68Veb
    tgyLykaAk6-_S2-gQ>
X-ME-Received: <xmr:62DAZ2Zqak4xRJYtFwCvguLFT8fe_apfZJr7rxuKcOK8x398oNeyC9w7oDCbFpWHbImYJPgMEp83huAE4C1BUohUNuWU8Y8HSgM8tcU3drWO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeegkeejtddvvdehkeetlefgtdeiieffudfggeehleei
    udehleeivdevleevgedtjeenucffohhmrghinhepphhruhhnvggpuggrthgrrdhnrhdpph
    gvnhguihhnghdrnhhrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeek
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:62DAZ5Vd0s2jPqFp2YQwPBp-_OlhScEeN1RHS0eI5so9P0c0BkZ80A>
    <xmx:62DAZ8l6RVrjtSXA0cEamdc9lB0mYj2LrpPVXMy6mdCWOTunSwxISg>
    <xmx:62DAZ-d5GNxdjV90zRmkbvt1wuVr42xxzSwA6Y5yb5HsGp-vpSB2UQ>
    <xmx:62DAZ-ECg9npVGkvGyUzLbG2PimdV-6-DUz4scRA_53EbT1YgLD_Gw>
    <xmx:62DAZ7tqfFvhaOcMskpKrfc2SaevEBsJKFhEM0deRSnqYyR4RGyfUHOd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 07:56:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 34fe9324 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Feb 2025 12:56:08 +0000 (UTC)
Date: Thu, 27 Feb 2025 13:56:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, phillip.wood123@gmail.com,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] builtin: introduce diff-pairs command
Message-ID: <Z8Bg5EAArZVGPaAc@pks.im>
References: <20250212041825.2455031-1-jltobler@gmail.com>
 <20250225233925.1345086-1-jltobler@gmail.com>
 <20250225233925.1345086-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225233925.1345086-3-jltobler@gmail.com>

On Tue, Feb 25, 2025 at 05:39:24PM -0600, Justin Tobler wrote:
> Through git-diff(1), a single diff can be generated from a pair of blob
> revisions directly. Unfortunately, there is not a mechanism to compute
> batches of specific file pair diffs in a single process. Such a feature
> is particularly useful on the server-side where diffing between a large
> set of changes is not feasible all at once due to timeout concerns.
> 
> To facilitate this, introduce git-diff-pairs(1) which acts as a backend
> passing its NUL-terminated raw diff format input from stdin through diff
> machinery to produce various forms of output such as patch or raw.
> 
> The raw format was originally designed as an interchange format and
> represents the contents of the diff_queue_diff list making it possible
> to break the diff pipeline into separate stages. For example,
> git-diff-tree(1) can be used as a frontend to compute file pairs to
> queue and feed its raw output to git-diff-pairs(1) to compute patches.
> With this, batches of diffs can be progessively generated without having
> to recompute rename detection or retrieve object context. Something like

s/rename detection/renames/

> diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
> new file mode 100644
> index 0000000000..9472b10461
> --- /dev/null
> +++ b/builtin/diff-pairs.c
> @@ -0,0 +1,193 @@
> +#include "builtin.h"
> +#include "commit.h"
> +#include "config.h"
> +#include "diff.h"
> +#include "diffcore.h"
> +#include "gettext.h"
> +#include "hex.h"
> +#include "object.h"
> +#include "parse-options.h"
> +#include "revision.h"
> +#include "strbuf.h"
> +
> +static unsigned parse_mode_or_die(const char *mode, const char **endp)
> +{
> +	uint16_t ret;
> +
> +	*endp = parse_mode(mode, &ret);
> +	if (!*endp)
> +		die(_("unable to parse mode: %s"), mode);
> +	return ret;
> +}
> +
> +static void parse_oid_or_die(const char *p, struct object_id *oid,
> +			     const char **endp, const struct git_hash_algo *algop)
> +{
> +	if (parse_oid_hex_algop(p, oid, endp, algop) || *(*endp)++ != ' ')
> +		die(_("unable to parse object id: %s"), p);
> +}
> +
> +static void flush_diff_queue(struct diff_options *options)
> +{
> +	/*
> +	 * If rename detection is not requested, use rename information from the
> +	 * raw diff formatted input. Setting found_follow ensures diffcore_std()
> +	 * does not mess with rename information already present in queued
> +	 * filepairs.
> +	 */
> +	if (!options->detect_rename)
> +		options->found_follow = 1;

It's a bit weird that we set this over here. Shouldn't we have set it up
in the main function already?

> +	diffcore_std(options);
> +	diff_flush(options);
> +}
> +
> +int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
> +		   struct repository *repo)
> +{
> +	struct strbuf path_dst = STRBUF_INIT;
> +	struct strbuf path = STRBUF_INIT;
> +	struct strbuf meta = STRBUF_INIT;
> +	struct rev_info revs;
> +	int ret;
> +
> +	const char * const usage[] = {
> +		N_("git diff-pairs -z [<diff-options>]"),
> +		NULL
> +	};
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +	struct option *parseopts = add_diff_options(options, &revs.diffopt);
> +
> +	show_usage_with_options_if_asked(argc, argv, usage, parseopts);

Don't we also have to call `parse_options()` even though we don't have
our own options yet? Or is this all handled by `setup_revisions()`?

> +	repo_init_revisions(repo, &revs, prefix);
> +	repo_config(repo, git_diff_basic_config, NULL);
> +	revs.disable_stdin = 1;
> +	revs.abbrev = 0;
> +	revs.diff = 1;
> +
> +	if (setup_revisions(argc, argv, &revs, NULL) > 1)
> +		usage_with_options(usage, parseopts);

I think it's discouraged nowadays to use `usage_with_options()` as it
generates a ton of noise while hiding the actual error message. It is
instead recommended to directly call `usage()` with an error message.

In this case here we would say e.g. `usage(_("unrecognized argument:
%s"), argv[0])`, in the cases below we'd use the error messages you
already have.

> +
> +	/*
> +	 * With the -z option, both command input and raw output are
> +	 * NUL-delimited (this mode does not effect patch output). At present
> +	 * only NUL-delimited raw diff formatted input is supported.
> +	 */
> +	if (revs.diffopt.line_termination) {
> +		error(_("working without -z is not supported"));
> +		usage_with_options(usage, parseopts);
> +	}
> +
> +	if (revs.prune_data.nr) {
> +		error(_("pathspec arguments not supported"));
> +		usage_with_options(usage, parseopts);
> +	}
> +
> +	if (revs.pending.nr || revs.max_count != -1 ||
> +	    revs.min_age != (timestamp_t)-1 ||
> +	    revs.max_age != (timestamp_t)-1) {
> +		error(_("revision arguments not allowed"));
> +		usage_with_options(usage, parseopts);
> +	}

Okay. We restrict a bunch of usages, which makes your job simpler right
now, but by dying it keeps the door open to iterate on those in the
future.

> +	if (!revs.diffopt.output_format)
> +		revs.diffopt.output_format = DIFF_FORMAT_PATCH;

Instead of setting this conditionally, can we already set it up as a
default before calling `setup_revisions()`?

> +	while (1) {
> +		struct object_id oid_a, oid_b;
> +		struct diff_filepair *pair;
> +		unsigned mode_a, mode_b;
> +		const char *p;
> +		char status;
> +
> +		if (strbuf_getline_nul(&meta, stdin) == EOF)
> +			break;
> +
> +		p = meta.buf;
> +		if (*p != ':')
> +			die(_("invalid raw diff input"));
> +		p++;
> +
> +		mode_a = parse_mode_or_die(p, &p);
> +		mode_b = parse_mode_or_die(p, &p);
> +
> +		if (S_ISDIR(mode_a) || S_ISDIR(mode_b))
> +			die(_("tree objects not supported"));

I assume submodules aren't supported either, are they? If so, do we also
have to check for `S_ISGITLINK()`? It would be nice to have a test for
them.

Patrick
