Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB72D2F548C
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756235927; cv=none; b=lm4vs4OzNqHSfxS/AlsD4F79+HCngK0XWW3UYj/Z7wB0IHS/urtVmrmZVGmJ0GnTByxnXVkq8o0nob04UM+kOlJ6R8yUwgZGemoUnlNwDurxP0lHjAxGQST6uceORXmVLju4IK9j9hc/CGktUJriDemtPvRHAfd3sfYyBsljuxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756235927; c=relaxed/simple;
	bh=sT0un7qSR+d55/HNYYsdvzWAzZiSrsB23DYIWVu5mgk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bi77qR7i+aoNNHqjLsz1FPqL26PjDDAaDttzQNdqB8o2yYvAOd0DrgWx+psWHcFr6nK61uvQy3bF5LZa0I+uhKQH74LfCRemckNylcZkp+fXPqrh6/IHpYxhOetxAZcM6JUEIm2xhaeniMN9+x/ht4bL3Nyo46etVf/CAFW+OdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wN7I9nph; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M2laIQV0; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wN7I9nph";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M2laIQV0"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA9AE140005F;
	Tue, 26 Aug 2025 15:18:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 26 Aug 2025 15:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756235923; x=1756322323; bh=CQXR1KzLKh
	2N109f9rDzWO4UMyE4ayx260qmf11ZPFk=; b=wN7I9nphX4nJknEmox1KP5hfJC
	7RoyOlYdeKFpP7+205eong1E5EzMUds/UhTUEhpXwmo8rCR5UGWq+jrotTJYaIyN
	Ln8PbYkT4Jx/pzdihMLoA5FiKn+n+HAF6hDZZ/0FjBoJihtA6k2SfPfBcaUQxfQI
	0JGGbbqvl3FjxnG5cL8NqwHdl6Uh6EicB5XiBa8wOKUvdVbTaE3vqQKsdBrJj3dd
	t7VSA131Wf7DJ+JMuSAJbe22bPeu/t0pOK5vi+56fOCcqRWrL86EPhf1N5NbHgsK
	KI7WzVDkLf8763q+LI9EGJCEo57N9x72Dj7jvlNvUS5hzuFWDpF1Mf6I6f1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756235923; x=1756322323; bh=CQXR1KzLKh2N109f9rDzWO4UMyE4ayx260q
	mf11ZPFk=; b=M2laIQV0tnojV7iYFLkcW2jTF83JymM4/p+oQapdCLhis86T8FK
	j1z4U9GTBeV2dCZyQQ8jnK5xNMexPTkGUvJIz0aeyIWuLXFNdMQfYZRcj9s4YxER
	6spMQzndse5V+ZDco7fej2Nl+noT0azV6kmtoeYI+Oc3nhknuVXJ6c739VerfBLE
	MNXCq0VtPuGAMeCnkoUM0pkWk6OdpPTZgFCAXLO3UZsLbYTJgeFz16GwUVeuNp02
	/U3zVhSZjux55aMcd8UqOzWmUifWjY5Yj7K1zMPBpEmFs2l+hJTy3UPlwe33l9tC
	T+xNBH9XD504sP4keCJ1SPsKecPldq6ZWhg==
X-ME-Sender: <xms:kwiuaCaQrf6N1jtekdV6D3Tof2TLTW9sLNNsW33wc0yNkpc_NzxQ1Q>
    <xme:kwiuaA4Xg9nWu6b6AVz25AMlDNBHiHxR1TyP4dS0iWuN5Qh3giTDxoSMFNPJvFmGx
    Hss81_gyiteYb8Mgw>
X-ME-Received: <xmr:kwiuaDaPEE53eyQCq7DTABahaDjkgFxR04EWdzTuGrAcAB5bfhVzLpj9uhoiEo1laCR-HK3zknGnIpz5Mf_9FePD4IdyFHKhLqoieSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeitdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehptggrshgrrhgvthhtohesghhmrghilhdrtghomhdprhgtphhtthhopehprghulhhord
    gtrghsrghrvghtthhosehshhhophhifhihrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kwiuaPg6lSzZD93jwn-jkaz1w6DVn-B-xAYzRPIutJ5X74bsDBw-qw>
    <xmx:kwiuaE9FIX_Dt-9hnckfI0qjREQkJe8ggTNRat6cdZeqOlROUYY6YA>
    <xmx:kwiuaKrEfMLzNGMSHyvixlKg0nfakfzGTumlZWnhT1pflxj7F1PWOg>
    <xmx:kwiuaMW5-Zf54dX3_ysYF45BE44LWqOseAJuutR7WCCrY-5N52drCw>
    <xmx:kwiuaCtt-oBAOH27WleoZbhSaPVE1ikcWkSt4pzGt11ktErSDFwWat-0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 15:18:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Paulo Casaretto <pcasaretto@gmail.com>,
  pcasaretto <paulo.casaretto@shopify.com>
Subject: Re: [PATCH] range-diff: add configurable memory limit for cost matrix
In-Reply-To: <pull.1958.git.1756228693233.gitgitgadget@gmail.com> (Paulo
	Casaretto via GitGitGadget's message of "Tue, 26 Aug 2025 17:18:13
	+0000")
References: <pull.1958.git.1756228693233.gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 12:18:41 -0700
Message-ID: <xmqqzfblj3hq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: pcasaretto <paulo.casaretto@shopify.com>

<administrivia>

It is usual to see a less human readable name embedded in the commit
object than the mail header when a mail comes from GGG.  

Just in case you want to be known to this community as "Paulo
Casaretto", not "pcasaretto", I thought I'd point it out that you
may want to redo the commit.  I do not mind what name you like to
use, as long as it is identifiable, and From: identity matches the
identity you add your Signed-off-by: with.

</administrivia>

> Acked-by: Johannes Schindelin johannes.schindelin@gmx.de

It is unusual to lack <> around e-mail address here.

> Signed-off-by: pcasaretto <paulo.casaretto@shopify.com>
> ---
>     range-diff: add configurable memory limit for cost matrix

> +static int parse_max_memory(const struct option *opt, const char *arg, int unset)
> +{
> +	size_t *max_memory = opt->value;
> +	uintmax_t val;
> +
> +	if (unset) {
> +		return 0;
> +	}

No unnecessary {braces} around a single statement, please.

> +	if (!git_parse_unsigned(arg, &val, SIZE_MAX))
> +		return error(_("invalid max-memory value: %s"), arg);
> +
> +	*max_memory = (size_t)val;
> +	return 0;
> +}

> @@ -33,17 +51,21 @@ int cmd_range_diff(int argc,
>  		OPT_INTEGER(0, "creation-factor",
>  			    &range_diff_opts.creation_factor,
>  			    N_("percentage by which creation is weighted")),
> +		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
> +				  N_("style"), N_("passed to 'git log'"), 0),
> +		OPT_BOOL(0, "left-only", &left_only,
> +			 N_("only emit output related to the first range")),
> +		OPT_CALLBACK(0, "max-memory", &range_diff_opts.max_memory,
> +			     N_("size"),
> +			     N_("maximum memory for cost matrix (default 4G)"),
> +			     parse_max_memory),
>  		OPT_BOOL(0, "no-dual-color", &simple_color,
>  			    N_("use simple diff colors")),
>  		OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
>  				  N_("notes"), N_("passed to 'git log'"),
>  				  PARSE_OPT_OPTARG),
> -		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
> -				  N_("style"), N_("passed to 'git log'"), 0),
>  		OPT_PASSTHRU_ARGV(0, "remerge-diff", &diff_merges_arg, NULL,
>  				  N_("passed to 'git log'"), PARSE_OPT_NOARG),
> -		OPT_BOOL(0, "left-only", &left_only,
> -			 N_("only emit output related to the first range")),
>  		OPT_BOOL(0, "right-only", &right_only,
>  			 N_("only emit output related to the second range")),
>  		OPT_END()

This seems to mix unrelated changes.  Please don't.

Or if the reordering of options do have a reason to exist in _this_
commit, please justify it in your proposed log message.  Even if
there were a good reason for reordering existing options, I strongly
suspect that the change would want to be done in a separate,
preparatory-clean-up commit (i.e., making this topic a two-patch
series), because it has nothing to do with preventing inefficient
cost matrix computation from consuming too much memory, which _is_
the theme of this commit.

> diff --git a/range-diff.c b/range-diff.c
> index 8a2dcbee322..6e9b6b115e5 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -21,6 +21,7 @@
>  #include "apply.h"
>  #include "revision.h"
>  
> +

Unrelated, unexplained, and unnecessary change snuck in?  Please
proof-read the patch yourself before sending.

> @@ -287,8 +288,8 @@ static void find_exact_matches(struct string_list *a, struct string_list *b)
>  }
>  
>  static int diffsize_consume(void *data,
> -			     char *line UNUSED,
> -			     unsigned long len UNUSED)
> +			    char *line UNUSED,
> +			    unsigned long len UNUSED)

What is this change about???

>  static void get_correspondences(struct string_list *a, struct string_list *b,
> -				int creation_factor)
> +				int creation_factor, size_t max_memory)
>  {
>  	int n = a->nr + b->nr;
>  	int *cost, c, *a2b, *b2a;
>  	int i, j;
> -
> -	ALLOC_ARRAY(cost, st_mult(n, n));
> +	size_t cost_size = st_mult(n, n);
> +	size_t cost_bytes = st_mult(sizeof(int), cost_size);
> +	if (cost_bytes >= max_memory) {
> +		struct strbuf cost_str = STRBUF_INIT;
> +		struct strbuf max_str = STRBUF_INIT;
> +		strbuf_humanise_bytes(&cost_str, cost_bytes);
> +		strbuf_humanise_bytes(&max_str, max_memory);
> +		die(_("range-diff: unable to compute the range-diff, since it "
> +		      "exceeds the maximum memory for the cost matrix: %s "
> +		      "(%"PRIuMAX" bytes) needed, %s (%"PRIuMAX" bytes) available"),
> +		    cost_str.buf, (uintmax_t)cost_bytes, max_str.buf, (uintmax_t)max_memory);
> +	}
> +	ALLOC_ARRAY(cost, cost_size);

Nicely done.

> @@ -351,7 +363,8 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
>  		}
>  
>  		c = a_util->matching < 0 ?
> -			a_util->diffsize * creation_factor / 100 : COST_MAX;
> +			    a_util->diffsize * creation_factor / 100 :
> +			    COST_MAX;
>  		for (j = b->nr; j < n; j++)
>  			cost[i + n * j] = c;
>  	}

There seem to be other unrelated changes indentation-only changes
mixed in to the changes to this file, not just this one.

As a style fix, 

		c = a_util->matching < 0
		  ? a_util->diffsize * creation_factor / 100
		  : COST_MAX;

would be easier to follow and read, but please do not do such a
cosmetic clean-up in the same patch.  Do them in a separate
preliminary clean-up patch before the "real work".

> @@ -591,7 +605,8 @@ int show_range_diff(const char *range1, const char *range2,
>  	if (!res) {
>  		find_exact_matches(&branch1, &branch2);
>  		get_correspondences(&branch1, &branch2,
> -				    range_diff_opts->creation_factor);
> +				    range_diff_opts->creation_factor,
> +				    range_diff_opts->max_memory);
>  		output(&branch1, &branch2, range_diff_opts);
>  	}

OK.
