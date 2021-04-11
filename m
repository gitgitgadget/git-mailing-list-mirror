Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A902FC433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 21:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555096101B
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 21:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbhDKVJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 17:09:32 -0400
Received: from avasout03.plus.net ([84.93.230.244]:46285 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbhDKVJa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 17:09:30 -0400
Received: from [10.0.2.15] ([195.213.6.1])
        by smtp with ESMTPA
        id VhKHlxxXautR5VhKIlEFEX; Sun, 11 Apr 2021 22:09:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1618175353; bh=MdAJUCtfnjiLa4M7A+323982nYvu0C4fJ2wIb972128=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=K+DsfAMCbJ46bb1smHAKamfYwtTH+yR+SZrKZIXIeF7PAGTxw4CO3sfFVIGqaCK2M
         QTqEN+RgXFp4yzJDyUdL0D6dkE8TuLguINEXVcI3j9dREQzvw5tZ1QuvSjoMAcBCoq
         295KEIrYxTjQUZTozsiQu+vc1f4LucpgFl44+ZyxKkaj/Vm7HmP/8rAp/HuuS2k7lQ
         kYExuBMq92mQR+azzfP2h2v0XlFMbLPEoOtTSN3myD6YPmc8skoWzHy4aFPEUMcJNK
         qCnioI4MOcvooy8ZnPt/Z0HRa7R77du6sXn7Yj8s9bUxicuEGkjKkj33QIkIx5mZqF
         en22Ak6z6QPKA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=KZJJTTQD c=1 sm=1 tr=0
 a=v1fZ9eGmBRQ2oAddCs0ezw==:117 a=v1fZ9eGmBRQ2oAddCs0ezw==:17
 a=IkcTkHD0fZMA:10 a=yMhMjlubAAAA:8 a=S7MiIPnbAito0uZNluUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3 2/3] fetch: add --prefetch option
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
 <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
 <7f488eea6dbdd93ff1a97a2572de7ddb0d65b7e0.1618020225.git.gitgitgadget@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <9e009c7e-a2bf-1740-ba43-c64a97f1dc28@ramsayjones.plus.com>
Date:   Sun, 11 Apr 2021 22:09:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7f488eea6dbdd93ff1a97a2572de7ddb0d65b7e0.1618020225.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAUX2FmNxRSyp6ecyn1//nHFFMXhUr14zmceWSEzVr0UYNSPTKmA7nV64U3O0pnTVqmxOD24pgeuf6ejuFkXkfpGz7ecyoflHYcSdUU4S736bGScSD7l
 LOh1euskCp0u3qZd9Fgqy5ASh0zsO/w2fTqAxBhbnPWt4NYrDh0h2pfg
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/04/2021 03:03, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The --prefetch option will be used by the 'prefetch' maintenance task
> instead of sending refspecs explicitly across the command-line. The
> intention is to modify the refspec to place all results in
> refs/prefetch/ instead of anywhere else.
> 
> Create helper method filter_prefetch_refspec() to modify a given refspec
> to fit the rules expected of the prefetch task:
> 
>  * Negative refspecs are preserved.
>  * Refspecs without a destination are removed.
>  * Refspecs whose source starts with "refs/tags/" are removed.
>  * Other refspecs are placed within "refs/prefetch/".
> 
> Finally, we add the 'force' option to ensure that prefetch refs are
> replaced as necessary.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/fetch-options.txt   |  5 +++
>  builtin/fetch.c                   | 56 +++++++++++++++++++++++++++++++
>  t/t5582-fetch-negative-refspec.sh | 30 +++++++++++++++++
>  3 files changed, 91 insertions(+)
> 
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 07783deee309..9e7b4e189ce0 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -110,6 +110,11 @@ ifndef::git-pull[]
>  	setting `fetch.writeCommitGraph`.
>  endif::git-pull[]
>  
> +--prefetch::
> +	Modify the configured refspec to place all refs into the
> +	`refs/prefetch/` namespace. See the `prefetch` task in
> +	linkgit:git-maintenance[1].
> +
>  -p::
>  --prune::
>  	Before fetching, remove any remote-tracking references that no
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 0b90de87c7a2..30856b442b79 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -48,6 +48,7 @@ enum {
>  static int fetch_prune_config = -1; /* unspecified */
>  static int fetch_show_forced_updates = 1;
>  static uint64_t forced_updates_ms = 0;
> +static int prefetch = 0;
>  static int prune = -1; /* unspecified */
>  #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
>  
> @@ -158,6 +159,8 @@ static struct option builtin_fetch_options[] = {
>  		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
>  	OPT_INTEGER('j', "jobs", &max_jobs,
>  		    N_("number of submodules fetched in parallel")),
> +	OPT_BOOL(0, "prefetch", &prefetch,
> +		 N_("modify the refspec to place all refs within refs/prefetch/")),
>  	OPT_BOOL('p', "prune", &prune,
>  		 N_("prune remote-tracking branches no longer on remote")),
>  	OPT_BOOL('P', "prune-tags", &prune_tags,
> @@ -436,6 +439,55 @@ static void find_non_local_tags(const struct ref *refs,
>  	oidset_clear(&fetch_oids);
>  }
>  
> +static void filter_prefetch_refspec(struct refspec *rs)
> +{
> +	int i;
> +
> +	if (!prefetch)
> +		return;
> +
> +	for (i = 0; i < rs->nr; i++) {
> +		struct strbuf new_dst = STRBUF_INIT;
> +		char *old_dst;
> +		const char *sub = NULL;
> +
> +		if (rs->items[i].negative)
> +			continue;
> +		if (!rs->items[i].dst ||
> +		    (rs->items[i].src &&
> +		     !strncmp(rs->items[i].src, "refs/tags/", 10))) {
> +			int j;
> +
> +			free(rs->items[i].src);
> +			free(rs->items[i].dst);
> +
> +			for (j = i + 1; j < rs->nr; j++) {
> +				rs->items[j - 1] = rs->items[j];
> +				rs->raw[j - 1] = rs->raw[j];
> +			}
> +			rs->nr--;

Hmm, don't you need to do 'i--;' here?

(Sorry in advance if this is nonsense, I am just skimming the
patches without reading the whole series carefully).

Maybe try a test which has an entry, which requires the 'prefetch'
modification, that immediately follows a 'tag' or 'empty dst' entry.
(I can't quite tell, just reading the email, whether that is covered
by the tests below - so please just ignore me if it already works ;)

ATB,
Ramsay Jones


> +			continue;
> +		}
> +
> +		old_dst = rs->items[i].dst;
> +		strbuf_addstr(&new_dst, "refs/prefetch/");
> +
> +		/*
> +		 * If old_dst starts with "refs/", then place
> +		 * sub after that prefix. Otherwise, start at
> +		 * the beginning of the string.
> +		 */
> +		if (!skip_prefix(old_dst, "refs/", &sub))
> +			sub = old_dst;
> +		strbuf_addstr(&new_dst, sub);
> +
> +		rs->items[i].dst = strbuf_detach(&new_dst, NULL);
> +		rs->items[i].force = 1;
> +
> +		free(old_dst);
> +	}
> +}
> +
>  static struct ref *get_ref_map(struct remote *remote,
>  			       const struct ref *remote_refs,
>  			       struct refspec *rs,
> @@ -452,6 +504,10 @@ static struct ref *get_ref_map(struct remote *remote,
>  	struct hashmap existing_refs;
>  	int existing_refs_populated = 0;
>  
> +	filter_prefetch_refspec(rs);
> +	if (remote)
> +		filter_prefetch_refspec(&remote->fetch);
> +
>  	if (rs->nr) {
>  		struct refspec *fetch_refspec;
>  
> diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
> index f34509727702..030e6f978c4e 100755
> --- a/t/t5582-fetch-negative-refspec.sh
> +++ b/t/t5582-fetch-negative-refspec.sh
> @@ -240,4 +240,34 @@ test_expect_success "push with matching +: and negative refspec" '
>  	git -C two push -v one
>  '
>  
> +test_expect_success '--prefetch correctly modifies refspecs' '
> +	git -C one config --unset-all remote.origin.fetch &&
> +	git -C one config --add remote.origin.fetch "refs/tags/*:refs/tags/*" &&
> +	git -C one config --add remote.origin.fetch ^refs/heads/bogus/ignore &&
> +	git -C one config --add remote.origin.fetch "refs/heads/bogus/*:bogus/*" &&
> +
> +	git tag -a -m never never-fetch-tag HEAD &&
> +
> +	git branch bogus/fetched HEAD~1 &&
> +	git branch bogus/ignore HEAD &&
> +
> +	git -C one fetch --prefetch --no-tags &&
> +	test_must_fail git -C one rev-parse never-fetch-tag &&
> +	git -C one rev-parse refs/prefetch/bogus/fetched &&
> +	test_must_fail git -C one rev-parse refs/prefetch/bogus/ignore &&
> +
> +	# correctly handle when refspec set becomes empty
> +	# after removing the refs/tags/* refspec.
> +	git -C one config --unset-all remote.origin.fetch &&
> +	git -C one config --add remote.origin.fetch "refs/tags/*:refs/tags/*" &&
> +
> +	git -C one fetch --prefetch --no-tags &&
> +	test_must_fail git -C one rev-parse never-fetch-tag &&
> +
> +	# The refspec for refs that are not fully qualified
> +	# are filtered multiple times.
> +	git -C one rev-parse refs/prefetch/bogus/fetched &&
> +	test_must_fail git -C one rev-parse refs/prefetch/bogus/ignore
> +'
> +
>  test_done
> 
