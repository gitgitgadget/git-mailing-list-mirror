Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B4318BAE
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107754; cv=none; b=F/+KJF6UjGdN4b124S1A1QQjljDFzhXT/GNcegTUmVLApiM22r7UJ9t4nZs9xraGU3iS5fJDEQqS++hikkVlG5DypHhgcZ/lVhmxk6D8yYOsqz7kXIP1o5TAxlCNsKWyN9n8uwAglI54O3Wz3hsZFngDXeNgiwdadnOgj/Uywns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107754; c=relaxed/simple;
	bh=F7Y5Bi5ga3FNl0gIIO7ZIIzixF8Em+ykZ03mwuLCR+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uvi8yNkwO8s8ebOuWyXpM60+dhGYqyMAeRVTR5oiDzHZuuG3FhrsUIXcjW+tGAC2k5ym6UphynWUJNM1ew3aRYy5G1BPMnuGj+P8y/7DQYhfdAlxve9dmDmSV7SuT03oxyjSuR7J3Bd5H65kuxCWFZqe2OTkYm1OA0V4AUYhiyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NgdruP8x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NnGMRzq0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NgdruP8x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NnGMRzq0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 37426EC00C0;
	Thu, 22 Jan 2026 13:49:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 22 Jan 2026 13:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769107747; x=1769194147; bh=5mUYhyV/nI
	ji0BkFwIyfJPchaIM5hf8Jt85Ns1c+VU4=; b=NgdruP8xY97Q/ZxwyY7uxCEoiv
	3eVIbMOeyNMKAmT6PPKKjymepfqoobycic/KlZJgx1zbA6kENfyM9a441ib4k8Bx
	m1pZSNz9pzKL53mawHgpk1jaEMWF9B3KjdmvEe3xF41O1CudAu/dBhv29GPYeVEd
	+wv/8LaKcpf0kZEXkLJNOr3YZdqFjzQL6eHnrNohAMdMasD1D2uXKd7dnPCPMKrO
	pUud0wibqnKosUM9t4CuTAcYudiU5ns7BrauHXtiI/ec80cSTXbR7AorQnsK47Jg
	Yz31AUyCTd0E3jFfozrnc042sh4juWdtESS5lyVCfvEEuqZpeGTSqxOEHciw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769107747; x=1769194147; bh=5mUYhyV/nIji0BkFwIyfJPchaIM5hf8Jt85
	Ns1c+VU4=; b=NnGMRzq04P2sbhRxnZ6w2IR599KWH5aBjtPTf89wPSVwTV5WfsT
	zX0WkKqeoiF04yY0uwYBnUV1OFRVaK//J4KnWu/Xu1nSSt6M5XULEkFjrFJJfvKC
	876hxPYPzc1fivrrLzmm8P9EqncktbBQLfYjnShmykPyLBTf1B3cXeeg57+hOBfV
	LCCAvpciQo7BDgYqIBlKT1NKmK9IY/TddGrWlQFVOGYQTw1xtpem1RN5w3mjlBJ8
	ysFsBRqpmje4dNC8Rnh1z5hnvgRHCobS3DiQ8lB1G+hpR/U1YVaytsKf9mmfRCr2
	8si6oBNXFuSuLANK+n7IgQPjFWsGIXgCUEA==
X-ME-Sender: <xms:InFyaYx5pA28PnsWU_xfx8wyhqn8mgLRNXokLQ4aQu1x2LVOkvynVw>
    <xme:InFyaVn4OO0XlMrRg5d3hmw7ZVdafKC_CcDkMPwIu5KzSbF9yf_JpR9h7VHf67spO
    2cvv7ImSqDTXQaM1cW8G6XQT9cL6FCwyZjxePdOBARKk-ehoqOmvQ>
X-ME-Received: <xmr:InFyaRmD47bfewLAsoxEI46JZ4WLok4BNwSctbaSmOuzSX4r671-dppfwt5b_UsV0vN44E8ja2y6PbVyyeHwVX_4r_oo69yVfhdHR-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeiledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgrshhsvghrrdhgrhgrihhnrgifihesohhsshdrqh
    hurghltghomhhmrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:InFyaXxm414CY93n0Hm9TeHUSHDQaVA409iR9TuBpJOE3KqgI8AF1Q>
    <xmx:InFyaWqBPsXNS6QgIGtlDpgcPJQ1WG8yAhqwc_Il5rFxkeyhoXMTPQ>
    <xmx:InFyaW5aaFy_69S6WJTxgONcq8zjv0ngsURMPkl4EMZ2pIJiR-hAww>
    <xmx:InFyadcwWcYKKvKqREmXN8FmF7E5fsnz85Yu_Omx3zIPLoTGdQKElw>
    <xmx:I3Fyad3bDqlBoV2NUI_VM4JO8kzyvGid8TWlbT-L6D3DSSAKFiMvCfrK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 13:49:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3] submodule: fetch missing objects from default remote
In-Reply-To: <20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
	(Nasser Grainawi's message of "Thu, 22 Jan 2026 07:27:22 -0800")
References: <20260114194815.1049888-1-nasser.grainawi@oss.qualcomm.com>
	<20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 10:49:05 -0800
Message-ID: <xmqq5x8to53y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nasser Grainawi <nasser.grainawi@oss.qualcomm.com> writes:

> When be76c21282 (fetch: ensure submodule objects fetched, 2018-12-06)
> added support for fetching a missing submodule object by id, it
> hardcoded the remote name as "origin" and deferred anything more
> complicated for a later patch. Implement the NEEDSWORK item to remove
> the hardcoded assumption by adding and using a submodule helper subcmd
> 'get-default-remote'. Fixing this lets 'git fetch --recurse-submodules'
> succeed when the fetched commit(s) in the superproject trigger a
> submodule fetch, and that submodule's default remote name is not
> "origin".
>
> Add non-"origin" remote tests to t5526-fetch-submodules.sh and
> t5572-pull-submodule.sh demonstrating this works as expected and add
> dedicated tests for get-default-remote.
>
> Signed-off-by: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
> Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
> ---

Thanks.  Jacob, this v3 is not exactly the same as v1 that you
reviewed (and range-diff relative to v2 does not capture what got
changed between the version you saw and this version), but I just
checked that they are "essentially identical" except for the
proposed log message.  Are you happy with having your Reviewed-by on
this version?

>  builtin/submodule--helper.c             |  38 +++++
>  submodule.c                             |  17 ++-
>  t/meson.build                           |   1 +
>  t/t5526-fetch-submodules.sh             |  52 +++++++
>  t/t5572-pull-submodule.sh               |  21 ++-
>  t/t7425-submodule-get-default-remote.sh | 186 ++++++++++++++++++++++++
>  6 files changed, 312 insertions(+), 3 deletions(-)
>  create mode 100755 t/t7425-submodule-get-default-remote.sh
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index d537ab087a..b180a24091 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -112,6 +112,43 @@ static int get_default_remote_submodule(const char *module_path, char **default_
>  	return 0;
>  }
>  
> +static int module_get_default_remote(int argc, const char **argv, const char *prefix,
> +				     struct repository *repo UNUSED)
> +{
> +	const char *path;
> +	char *resolved_path = NULL;
> +	char *default_remote = NULL;
> +	int code;
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +	const char *const usage[] = {
> +		N_("git submodule--helper get-default-remote <path>"),
> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
> +	if (argc != 1)
> +		usage_with_options(usage, options);

Hmph, I am not sure what is going on.  What are we getting out of
parse_options() here?  Would it be the same to see if we got
anything remaining on the command line by checking argc and call
usage_with_options() without calling parse_options(), or am I
missing something?

> +	path = argv[0];
> +	if (prefix && *prefix && !is_absolute_path(path)) {
> +		resolved_path = xstrfmt("%s%s", prefix, path);
> +		path = resolved_path;
> +	}
> +
> +	code = get_default_remote_submodule(path, &default_remote);
> +	if (code) {
> +		free(resolved_path);
> +		return code;
> +	}
> +
> +	printf("%s\n", default_remote);

Do we know that the value of default_remote has no funny bytes in
it, like newline?  In the end the name has to become part of
refs/remotes/<name>/HEAD that has to be a valid refname, so not
giving any facility to quote funny bytes and allowing the caller of
this helper to assume a LF terminated single line should be fine, so
I am guessing that the answer is yes, but I offhand do not know how
we know that we do not have to worry about such a situation in the
code path that begins with get_default_remote_submodule().

> diff --git a/submodule.c b/submodule.c
> index 40a5c6fb9d..6599657f34 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1706,6 +1706,8 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
>  	if (spf->oid_fetch_tasks_nr) {
>  		struct fetch_task *task =
>  			spf->oid_fetch_tasks[spf->oid_fetch_tasks_nr - 1];
> +		struct child_process cp_remote = CHILD_PROCESS_INIT;
> +		struct strbuf remote_name = STRBUF_INIT;
>  		spf->oid_fetch_tasks_nr--;
>  
>  		child_process_init(cp);
> @@ -1719,8 +1721,19 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
>  		strvec_pushf(&cp->args, "--submodule-prefix=%s%s/",
>  			     spf->prefix, task->sub->path);
>  
> -		/* NEEDSWORK: have get_default_remote from submodule--helper */
> -		strvec_push(&cp->args, "origin");
> +		cp_remote.git_cmd = 1;
> +		strvec_pushl(&cp_remote.args, "submodule--helper",
> +			     "get-default-remote", task->sub->path, NULL);
> +
> +		if (!capture_command(&cp_remote, &remote_name, 0)) {
> +			strbuf_trim_trailing_newline(&remote_name);
> +			strvec_push(&cp->args, remote_name.buf);
> +		} else {
> +			/* Fallback to "origin" if the helper fails */
> +			strvec_push(&cp->args, "origin");
> +		}
> +		strbuf_release(&remote_name);
> +
>  		oid_array_for_each_unique(task->commits,
>  					  append_oid_to_argv, &cp->args);

OK, this part is quite straight-forward.

> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 5e566205ba..a5a273b392 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -929,6 +929,58 @@ test_expect_success 'fetch new submodule commit intermittently referenced by sup
>  	)
>  '
>  
> +test_expect_success 'fetch --recurse-submodules works with custom remote names' '
> +	# depends on the previous test for setup
> +
> +	# Rename the remote in sub1 from "origin" to "custom_remote"
> +	git -C downstream/sub1 remote rename origin custom_remote &&
> +
> +	# Create new commits in the original submodules
> +	C=$(git -C submodule commit-tree -m "change outside refs/heads for custom remote" HEAD^{tree}) &&
> +	git -C submodule update-ref refs/changes/custom1 $C &&
> +	git update-index --cacheinfo 160000 $C submodule &&
> +	test_tick &&
> +
> +	D=$(git -C sub1 commit-tree -m "change outside refs/heads for custom remote" HEAD^{tree}) &&
> +	git -C sub1 update-ref refs/changes/custom2 $D &&
> +	git update-index --cacheinfo 160000 $D sub1 &&
> +
> +	git commit -m "updated submodules outside of refs/heads for custom remote" &&
> +	E=$(git rev-parse HEAD) &&
> +	git update-ref refs/changes/custom3 $E &&
> +	(
> +		cd downstream &&
> +		git fetch --recurse-submodules origin refs/changes/custom3:refs/heads/my_other_branch &&
> +		git -C submodule cat-file -t $C &&
> +		git -C sub1 cat-file -t $D &&
> +		git checkout --recurse-submodules FETCH_HEAD
> +	)
> +'

Hmph, these overly long lines are eyesore.  I wonder if we can do
something about them?

I also wonder if we want to make sure we are getting from the remote
that is given the custom name in a more direct way (instead of "we
see that our fetch succeeds, and because there is no other remote,
it must have gotten what is needed from the renamed one"), or is it
too much paranoia?

> +test_expect_success 'fetch new submodule commit on-demand in FETCH_HEAD from custom remote' '
> +	# depends on the previous test for setup
> +
> +	C=$(git -C submodule commit-tree -m "another change outside refs/heads for custom remote" HEAD^{tree}) &&
> +	git -C submodule update-ref refs/changes/custom4 $C &&
> +	git update-index --cacheinfo 160000 $C submodule &&
> +	test_tick &&
> +
> +	D=$(git -C sub1 commit-tree -m "another change outside refs/heads for custom remote" HEAD^{tree}) &&
> +	git -C sub1 update-ref refs/changes/custom5 $D &&
> +	git update-index --cacheinfo 160000 $D sub1 &&
> +
> +	git commit -m "updated submodules outside of refs/heads" &&
> +	E=$(git rev-parse HEAD) &&
> +	git update-ref refs/changes/custom6 $E &&
> +	(
> +		cd downstream &&
> +		git fetch --recurse-submodules origin refs/changes/custom6 &&
> +		git -C submodule cat-file -t $C &&
> +		git -C sub1 cat-file -t $D &&
> +		git checkout --recurse-submodules FETCH_HEAD
> +	)
> +'

Are we testing anything new in this test, compared to the previous
one?  Both update the submodule sub1 by adding a new ref under
refs/changes/ hierachy and have "git fetch --recurse-submodules"
follow the changes.

> diff --git a/t/t7425-submodule-get-default-remote.sh b/t/t7425-submodule-get-default-remote.sh
> new file mode 100755
> index 0000000000..b842af9a2d
> --- /dev/null
> +++ b/t/t7425-submodule-get-default-remote.sh
> ...
> +test_expect_success 'get-default-remote returns origin for initialized submodule' '
> +	(
> +		cd super &&
> +		git submodule update --init &&
> +		echo "origin" >expect &&
> +		git submodule--helper get-default-remote subpath >actual &&
> +		test_cmp expect actual
> +	)
> +'

OK, we have dedicated tests like these to ensure that when we say
"get default remote" we get what we expect, which is very good.

The "too much paranoia" question above is primarily about "are we
really saying get-default-remote properly at the place where it
matters?"  IOW, we guarantee that the lower layer works as expected
with t7425, but the way we validate that we call the lower layer
correctly felt a bit indirect.

Other than these, looking very good.

Thanks.

