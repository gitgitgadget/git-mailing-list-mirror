Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B7422256D
	for <git@vger.kernel.org>; Wed,  7 May 2025 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604497; cv=none; b=btI5ubDL/la9LxhgIg7wt8GdTWso/4aFjx0rbAxhRwNn4B2W9arkqZc/3zW3EBU8xObn+AEWhb1ExRBXu+mYrKGKTv9h/+QTBxEc9+xW6gxtA1UMt/Sf5vt/nprVbBuSiOjs4W41NXkrmo6qmzJu+0UAXxe2hyQby6+c1u81CHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604497; c=relaxed/simple;
	bh=RjVH2d+jp5omDpuDV9spRiRsND136UTo7q5bB/cuaqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5q8hCyUcFWJSNojxVqut+Gkg26K/z+asfP6c/e8KN3vfAxRwBnHID3BmtEjAXeHZxdi4AzEx+otoihCLH5eY8kxaJQtquC4b8bV4dR8DGzdyZPVDYq/s7aAHxriw8fLSd1yWNVNFoJtRoUBIe52KQRu7UZ77d2Ba+Q+IQgDO34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Di4f4LPr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YKuR0LSU; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Di4f4LPr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YKuR0LSU"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D5302540107;
	Wed,  7 May 2025 03:54:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 07 May 2025 03:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746604494; x=1746690894; bh=5I49t2w2S8
	MAXcBIEyQxMlNudw0v6zrk7PA4X9e02bc=; b=Di4f4LPrKMzEWRAN2Rvxt9f/GU
	/7MxXLRXzcEjmEmivtmJ7Su8ZqwjaoIhzwn9KSApcdrvi40Gi15uOF/51EmR+n5b
	Ocm5eKVSHgwa/vg3Hj855BCq0inm/TypBc2HxWKDg2x9M2WGY5x0gqIHiqQUcXmW
	G0Jh9aAkISylnxQjXOSo8icEqsF1LMn4LD8gkl3fwr7TTQX9myY+ZSOTO+vUMRaB
	A5BX5UQHS+wJDWLfzxdxcjpx6yPsIag2miVHr9iq7GQtmdHEQqJzSbI0NQqA+08j
	GlsFv24r4ajkF0I6PNI2FEtGuXq0eQTQvyrTIAzSnSlQbJhsV8ra4rye8A5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746604494; x=1746690894; bh=5I49t2w2S8MAXcBIEyQxMlNudw0v6zrk7PA
	4X9e02bc=; b=YKuR0LSUsEb/xsVAIuBySdciUGoye4LU+DTiGTQRUSv7Z5LttpN
	l1QQAbONnoLiLYoSQ0CpckVuD9V5okRkn/FkJjlB3T401KI4VDHYsai26Zw8RmnU
	UAxr/vMVl0d+zG1sUjWXEPfOBR/Nh+6Cb6/fn6eqxaI35mNquTg2CbKxdgIuVyOf
	RdKkYGL6YShv4HleT6+1xtG53CS3KDDamNnyrOZgDLB0SaML4/2Zxth2cVyyqDdL
	jB69ZjGX6oAFlPqHLDbXcdEBJgoTcdZPYdfSxSM7z/xqlnOMHF65Y7zTlaF0k6G5
	GV9LSzzBQ/s+QnEYSg5eh8obd422kpxLQVg==
X-ME-Sender: <xms:zREbaFbAg4B9uKh9a2smBaODQ1sTtJRNt6zRVSKqle6h8rxQ81V8Sg>
    <xme:zREbaMZEJELuR5JnydYQ7XzqVNb1zZhh5TYNmfn7zc42rA86d1P-PPDvCVxiX5ZsW
    a2gRlIIgmXZ882oJw>
X-ME-Received: <xmr:zREbaH-EI9EunMIRyVBRtDDJKiUV8NpprPm3Xqdqjk7izz_SwyxEhEyjiwfQWAYuhtVeNIbjnim9_XS4I1_fIBlllzOd6SOT0OY7Qkir5-xAtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeifeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmhgrihhlrdhnjhhurdgv
    ughurdgtnhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zREbaDrwIIFLw_WkdtvT8xRngkiF34SXtAH_NB-npLKK4NLwpVkjJw>
    <xmx:zREbaAoplpDXz1O94_JuLfvz1-3Ek0C9B4scPHaIuuNPr9YyfyaElQ>
    <xmx:zREbaJQR7XrGMUyDxsE80v20VyyM4CHWHw_g2TtP7ncB91SMYTx1Cg>
    <xmx:zREbaIoFyVP1mJywIrwTuscK2vqO1eCyLEUFNU4Y8cEQmk5aiymrog>
    <xmx:zhEbaAEkpTFRFVyRmwVihFgQDj4IcpHMtTibVWyu50MFWzbaHEuuX3eG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 03:54:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c7562af4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 07:54:47 +0000 (UTC)
Date: Wed, 7 May 2025 09:54:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH 1/3] fix xstrdup leak in parse_short_opt
Message-ID: <aBsRxv9QkFTHeG3V@pks.im>
References: <pull.1954.git.git.1746585203.gitgitgadget@gmail.com>
 <b34445d166c9790e922c0fd6a7c4885031fb21bd.1746585203.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b34445d166c9790e922c0fd6a7c4885031fb21bd.1746585203.git.gitgitgadget@gmail.com>

On Wed, May 07, 2025 at 02:33:21AM +0000, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>

This commit is missing an explanation of the problem. When does it
trigger? Which subsystem triggers it? Why didn't we observe the issue
beforehand? And given that the solution seems to be a bit more complex
it should also explain how you're fixing the issue.

Furthermore, the subject of such a commit should be prefixed with the
subsystem in which you're fixing the issue. So in your case,
"parse-options:".

I'd recommend reading through "Documentation/MyFirstContribution.adoc",
which explains all of this.

> diff --git a/parse-options.c b/parse-options.c
> index a9a39ecaef6c..4279dfe4d313 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -638,6 +638,16 @@ static int has_subcommands(const struct option *options)
>  	return 0;
>  }
>  
> +static void set_strdup_fn(struct parse_opt_ctx_t *ctx, const struct option *options) {

Style: the opening brace should be on its own line.

> +	for (; options->type != OPTION_END; options++)
> +		;
> +	if (options->value && options->strdup_fn) {
> +		ctx->unknown_opts = options->value;
> +		ctx->strdup_fn = options->strdup_fn;
> +		return;
> +	}

It's not really clear what this is doing. Is the intent to only change
this this value for the last option? If so, why?

> @@ -981,7 +992,11 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
>  					 *
>  					 * This is leaky, too bad.
>  					 */
> -					ctx->argv[0] = xstrdup(ctx->opt - 1);
> +					if (ctx->unknown_opts && ctx->strdup_fn) {
> +						ctx->argv[0] = ctx->strdup_fn(ctx->unknown_opts, ctx->opt - 1);
> +					} else {
> +						ctx->argv[0] = xstrdup(ctx->opt - 1);
> +					}
>  					*(char *)ctx->argv[0] = '-';
>  					goto unknown;
>  				case PARSE_OPT_NON_OPTION:

Hm. I'm at a loss what we're solving here. All of this really should be
explained in the commit message to give context to the reviewer.

> diff --git a/parse-options.h b/parse-options.h
> index 91c3e3c29b3d..af06a09abb8e 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -388,6 +391,12 @@ static char *parse_options_noop_ignored_value MAYBE_UNUSED;
>  }
>  #define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), 0)
>  
> +#define OPT_UNKNOWN(v, fn) { \
> +	.type = OPTION_END, \
> +	.value = (v), \
> +	.strdup_fn = (fn), \
> +}
> +
>  /*
>   * parse_options() will filter out the processed options and leave the
>   * non-option arguments in argv[]. argv0 is assumed program name and
> @@ -496,6 +505,9 @@ struct parse_opt_ctx_t {
>  	const char *prefix;
>  	const char **alias_groups; /* must be in groups of 3 elements! */
>  	struct parse_opt_cmdmode_list *cmdmode_list;
> +
> +	void *unknown_opts;
> +	parse_opt_strdup_fn *strdup_fn;
>  };
>  
>  void parse_options_start(struct parse_opt_ctx_t *ctx,

Okay. So the intent seems to be that we start storing any options that
we don't understand?

> diff --git a/t/helper/test-free-unknown-options.c b/t/helper/test-free-unknown-options.c
> new file mode 100644
> index 000000000000..9d658115ba8f
> --- /dev/null
> +++ b/t/helper/test-free-unknown-options.c
> @@ -0,0 +1,35 @@
> +#include "git-compat-util.h"
> +#include "parse-options.h"
> +#include "setup.h"
> +#include "strvec.h"
> +
> +static const char *const free_unknown_options_usage[] = {
> +    "test-tool free-unknown-options",
> +    NULL
> +};

Can't we expand `test-tool parse-options` instead of introducing a new
helper?

> +int cmd__free_unknown_options(int argc, const char **argv) {
> +    struct strvec *unknown_opts = xmalloc(sizeof(struct strvec));
> +    strvec_init(unknown_opts);
> +    const char *prefix = setup_git_directory();
> +
> +    bool a, b;
> +	struct option options[] = {
> +		OPT_BOOL('a', "test-a", &a, N_("option a, only for test use")),
> +	OPT_BOOL('b', "test-b", &b, N_("option b, only for test use")),
> +	OPT_UNKNOWN(unknown_opts, (parse_opt_strdup_fn *)&strvec_push),
> +	};
> +
> +    parse_options(argc, argv, prefix, options,
> +	free_unknown_options_usage, PARSE_OPT_KEEP_UNKNOWN_OPT);
> +
> +    printf("a = %s\n", a? "true": "false");
> +    printf("b = %s\n", b? "true": "false");
> +
> +    int i;
> +    for (i = 0; i < unknown_opts->nr; i++) {
> +	printf("free unknown option: %s\n", unknown_opts->v[i]);
> +    }
> +    strvec_clear(unknown_opts);
> +    free(unknown_opts);
> +}
> \ No newline at end of file

Missing newline.

> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index 6d62a5b53d95..33fa7828b9f6 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -44,6 +44,7 @@ int cmd__parse_options(int argc, const char **argv);
>  int cmd__parse_options_flags(int argc, const char **argv);
>  int cmd__parse_pathspec_file(int argc, const char** argv);
>  int cmd__parse_subcommand(int argc, const char **argv);
> +int cmd__free_unknown_options(int argc, const char **argv);
>  int cmd__partial_clone(int argc, const char **argv);
>  int cmd__path_utils(int argc, const char **argv);
>  int cmd__path_walk(int argc, const char **argv);
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index ca55ea8228c3..773f54103fd3 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -822,4 +822,18 @@ test_expect_success 'u16 limits range' '
>  	test_grep "value 65536 for option .u16. not in range \[0,65535\]" err
>  '
>  
> +cat >expect <<\EOF
> +a = true
> +b = true
> +free unknown option: -c
> +free unknown option: -d
> +EOF

This should be done inside `test_expect_success` itself.

> +test_expect_success 'free unknown options' '
> +	test-tool free-unknown-options -ac -bd \
> +	>output 2>output.err &&
> +	test_cmp expect output &&
> +	test_must_be_empty output.err
> +'
> +
>  test_done

Okay, so the memory leak seems to happen when handling unknown options
indeed, as I started to expect after the middle of this patch. In any
case, this commit really needs to be polished to have a proper commit
message that sets the stage for the reviewer.

Patrick
