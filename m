Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC82AC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 14:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbiHQOM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 10:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237240AbiHQOM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 10:12:27 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977F341D01
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 07:12:24 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id w8so3695856ilj.5
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=rp58eXVgJb5GaiVkOkm1zg/FhD2E/sEfhkZm2pAMzq4=;
        b=Dw2sNAk46M4DKhzgN5PA4WE2KMBv3N4CKzCkhrnglUWJ0Qkdcl9xSp9wQUAC1x6aW1
         uysh4jnrcZyolj2d5Q/FaOGvi5H7UsHzQEDAvUXTWBUOSch9keZCpPqJJRF/VcCPUA9y
         UFbVleaHuhyWwYFh3T5JE/ngFVqW/bbMui9NhJUdgPkaSiSlOEiNhj8n0PGpRr5Me3GV
         D9NYfA4mdD0kAMEXg/qPZq7eH9XdWkPQBqp0aWmpyHGpkv6kENeJkHhar3wbRGm8cydK
         AZGj1ZuSaZi1IQanj5ObBF/LZILiToLsnE/MZBScSkVJEhHfqAjKeqHoXyRtx5muRH85
         Kt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rp58eXVgJb5GaiVkOkm1zg/FhD2E/sEfhkZm2pAMzq4=;
        b=cpxuyAL/RlEHlCyu9kt8rYIepfGohJKVFVoIF3fLwb2EOZdbmh0K0uGTtEr0YMVF9B
         hVVNwpJhYwZocvSOHPsKQdJmvooL3JnqUgGgCIr0QF7jGs00J8wBjEA/Ti9YytxJPuq3
         oiOOyHUIWdXwWmqPEMVXVV3AvFNNFeVfv4m2IscAmYQ7q99FQkBLOYH7bDeO2/KeiL05
         zK0+A+ZFtmephZabn7OSvlGSZu9FJfSdlp3XeKUNr+Y26NEC2zetlpECjDBZ3x9ZrS4r
         Q4fgX+tcC8l7wbOG+jJXRks62FLs2xkGvSnCV0v8GCx8wSFPjZFA9JsLfAvJ/ZdGZ5tc
         s8YQ==
X-Gm-Message-State: ACgBeo3FoDYdbQ5pZxemVXXvz48fhbkpcdycP34BzcpQE4Y4YAJ6Ti4F
        CrjN/Y+c7l+ESFdj74Dx0qFk6oTEgHxR
X-Google-Smtp-Source: AA6agR6m/nv5L4xAeFspOulb/IRVqiH9uTRers0/LCd2L9N8JUNyPNhsUJpYxNSjAsqiGQ66CSDnTQ==
X-Received: by 2002:a05:6e02:1566:b0:2e5:a1e7:7e15 with SMTP id k6-20020a056e02156600b002e5a1e77e15mr7616286ilu.122.1660745543844;
        Wed, 17 Aug 2022 07:12:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f8cc:7049:fd75:5ebd? ([2600:1700:e72:80a0:f8cc:7049:fd75:5ebd])
        by smtp.gmail.com with ESMTPSA id p18-20020a02b012000000b0033f11276715sm4568651jah.132.2022.08.17.07.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 07:12:23 -0700 (PDT)
Message-ID: <80f24382-1188-d450-d1e2-42f68c08e60b@github.com>
Date:   Wed, 17 Aug 2022 10:12:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 1/2] builtin/grep.c: add --sparse option
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220817075633.217934-2-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220817075633.217934-2-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2022 3:56 AM, Shaoxuan Yuan wrote:
> Add a --sparse option to `git-grep`. This option is mainly used to:
> 
> If searching in the index (using --cached):
> 
> With --sparse, proceed the action when the current cache_entry is

This phrasing is awkward. It might be better to reframe to describe the
_why_ before the _what_

  When the '--cached' option is used with the 'git grep' command, the
  search is limited to the blobs found in the index, not in the worktree.
  If the user has enabled sparse-checkout, this might present more results
  than they would like, since the files outside of the sparse-checkout are
  unlikely to be important to them.

  Change the default behavior of 'git grep' to focus on the files within
  the sparse-checkout definition. To enable the previous behavior, add a
  '--sparse' option to 'git grep' that triggers the old behavior that
  inspects paths outside of the sparse-checkout definition when paired
  with the '--cached' option.

Or something like that. The documentation updates will also help clarify
what happens when '--cached' is not included. I assume '--sparse' is
ignored, but perhaps it _could_ allow looking at the cached files outside
the sparse-checkout definition, this could make the simpler invocation of
'git grep --sparse <pattern>' be the way that users can search after their
attempt to search the worktree failed.

> marked with SKIP_WORKTREE bit (the default is to skip this kind of
> entry). Before this patch, --cached itself can realize this action.
> Adding --sparse here grants the user finer control over sparse
> entries. If the user only wants to peak into the index without

s/peak/peek/

> caring about sparse entries, --cached should suffice; if the user
> wants to peak into the index _and_ cares about sparse entries,
> combining --sparse with --cached can address this need.
> 
> Suggested-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/grep.c                  | 10 +++++++++-
>  t/t7817-grep-sparse-checkout.sh | 12 ++++++------
>  2 files changed, 15 insertions(+), 7 deletions(-)

You mentioned in Slack that you missed the documentation of the --sparse
option. Just pointing it out here so we don't forget.

> 
> diff --git a/builtin/grep.c b/builtin/grep.c
> index e6bcdf860c..61402e8084 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -96,6 +96,8 @@ static pthread_cond_t cond_result;
>  
>  static int skip_first_line;
>  
> +static int grep_sparse = 0;
> +

I initially thought it might be good to not define an additional global,
but there are many defined in this file outside of the context and they
are spread out with extra whitespace like this.

>  static void add_work(struct grep_opt *opt, struct grep_source *gs)
>  {
>  	if (opt->binary != GREP_BINARY_TEXT)
> @@ -525,7 +527,11 @@ static int grep_cache(struct grep_opt *opt,
>  	for (nr = 0; nr < repo->index->cache_nr; nr++) {
>  		const struct cache_entry *ce = repo->index->cache[nr];
>  
> -		if (!cached && ce_skip_worktree(ce))

This logic would skip files marked with SKIP_WORKTREE _unless_ --cached
was provided.

> +		/*
> +		 * If ce is a SKIP_WORKTREE entry, look into it when both
> +		 * --sparse and --cached are given.
> +		 */
> +		if (!(grep_sparse && cached) && ce_skip_worktree(ce))
>  			continue;

The logic of this if statement is backwards from the comment because a
true statement means "skip the entry" _not_ "look into it".

	/*
	 * Skip entries with SKIP_WORKTREE unless both --sparse and
	 * --cached are given.
	 */

But again, we might want to consider this alternative:

	/*
	 * Skip entries with SKIP_WORKTREE unless --sparse is given.
	 */
	if (!grep_sparse && ce_skip_worktree(ce))
		continue;

This will require further changes below, specifically this bit:

			/*
			 * If CE_VALID is on, we assume worktree file and its
			 * cache entry are identical, even if worktree file has
			 * been modified, so use cache version instead
			 */
			if (cached || (ce->ce_flags & CE_VALID)) {
				if (ce_stage(ce) || ce_intent_to_add(ce))
					continue;
				hit |= grep_oid(opt, &ce->oid, name.buf,
						 0, name.buf);
			} else {

We need to activate this grep_oid() call also when ce_skip_worktree(c) is
true. That is, if we want 'git grep --sparse' to extend the search beyond
the worktree and into the sparse entries.

>  
>  		strbuf_setlen(&name, name_base_len);
> @@ -963,6 +969,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  			   PARSE_OPT_NOCOMPLETE),
>  		OPT_INTEGER('m', "max-count", &opt.max_count,
>  			N_("maximum number of results per file")),
> +		OPT_BOOL(0, "sparse", &grep_sparse,
> +			 N_("search sparse contents and expand sparse index")),

This "and expand sparse index" is an internal implementation detail, not a
heplful item for the help text. Instead, perhaps:

	"search the contents of files outside the sparse-checkout definition"

(Also, while the sparse index is being expanded right now, I would expect
to not expand the sparse index by the end of the series.)

> -test_expect_success 'grep --cached searches entries with the SKIP_WORKTREE bit' '
> +test_expect_success 'grep --cached and --sparse searches entries with the SKIP_WORKTREE bit' '
>  	cat >expect <<-EOF &&
>  	a:text
>  	b:text
>  	dir/c:text
>  	EOF
> -	git grep --cached "text" >actual &&
> +	git grep --cached --sparse "text" >actual &&
>  	test_cmp expect actual
>  '

Please add a test that demonstrates the change of behavior when only --cached
is provided, not --sparse.

(If you take my suggestion to allow 'git grep --sparse' to do something
different, then also add a test for that case.)

>  
> @@ -143,7 +143,7 @@ test_expect_success 'grep --recurse-submodules honors sparse checkout in submodu
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'grep --recurse-submodules --cached searches entries with the SKIP_WORKTREE bit' '
> +test_expect_success 'grep --recurse-submodules --cached and --sparse searches entries with the SKIP_WORKTREE bit' '
>  	cat >expect <<-EOF &&
>  	a:text
>  	b:text
> @@ -152,7 +152,7 @@ test_expect_success 'grep --recurse-submodules --cached searches entries with th
>  	sub/B/b:text
>  	sub2/a:text
>  	EOF
> -	git grep --recurse-submodules --cached "text" >actual &&
> +	git grep --recurse-submodules --cached --sparse "text" >actual &&
>  	test_cmp expect actual
>  '
> @@ -166,7 +166,7 @@ test_expect_success 'working tree grep does not search the index with CE_VALID a
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'grep --cached searches index entries with both CE_VALID and SKIP_WORKTREE' '
> +test_expect_success 'grep --cached and --sparse searches index entries with both CE_VALID and SKIP_WORKTREE' '
>  	cat >expect <<-EOF &&
>  	a:text
>  	b:text
> @@ -174,7 +174,7 @@ test_expect_success 'grep --cached searches index entries with both CE_VALID and
>  	EOF
>  	test_when_finished "git update-index --no-assume-unchanged b" &&
>  	git update-index --assume-unchanged b &&
> -	git grep --cached text >actual &&
> +	git grep --cached --sparse text >actual &&
>  	test_cmp expect actual
>  '

Same with these two tests. Add additional commands that show the change of
behavior when only using '--cached'.

Thanks,
-Stolee
