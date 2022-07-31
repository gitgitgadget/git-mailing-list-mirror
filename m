Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD6CC00140
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 15:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiGaPup (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jul 2022 11:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbiGaPul (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jul 2022 11:50:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D32B49D
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 08:50:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r83-20020a1c4456000000b003a3a22178beso2810514wma.3
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 08:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iXyI/WX6POMZUuPNBtRk6z3mcMjamwdQPeu53HiqaXQ=;
        b=KNJbEncgKofMX6Z6kyIkxppoXz0PdijKRnik2JQ0b77OSlCBbM3ItbD9WlrzmZCXhj
         sUx+ZKsgY2UrEeBxxOtz6ryheUmsXeKhL2xQ7jGopeLcfHkVxHaqbq4NTyi4kDPb8VhU
         vLYgWNEYsN1ddE11Pbp12bhac0GBBW4Zfo/IUHRHkkdM5BjxKuzg2QfQMAQBDe8nliAF
         LuayRwjXkcTCBddUxs0EaQfyyudMuPWsw3Se8KwEMIOSrE4lsygglp6IHRaSjueoRhMB
         iAn8P0c0/0r89m6KhTjxB1LrqzH0Mh0h8pE5m8mMPR6OobHaLTX2reH4m9Hgr2Yr+gZb
         U4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iXyI/WX6POMZUuPNBtRk6z3mcMjamwdQPeu53HiqaXQ=;
        b=3VdXFHCQfDM1fJeXuT5PWxFTeebHBh4UeDTMx0ZWGQjPwrjIsLFXiY5UsKQvOnAtQf
         ggm/tAffLLL1442VmpFgMBTQ5NKw7Tq9iKn1teqpRtkWWkVaPWQgMY+8Sq3mIAaxksUC
         jI5WTaZgZuzMFL3GgQR8NfrJIA2l4jW/VgRuk0tJtUTvSQR19MfxEBQu+v8e+3nQv03g
         DmRe/xK60jaEPmJYfa1vjmLjvp84lqImVDJxRHERqSKVXKpdxHoJ0/sBGqPLqfm1QR5h
         qB45ZXoeQ+tdrrNiH/omwzaELlvd2uaAXQAR7MtPX6GojF1FJqUvD0geLy8UfAl/c9HQ
         RRMQ==
X-Gm-Message-State: AJIora/uIk7uoEIGzikL9G8FLaHOQ6k0pMWTWttzosexh4ChZuD1gCA2
        mcjtqPslc21tzCGLqmpsYF3EXSCG2bA=
X-Google-Smtp-Source: AGRyM1sLRlSpw/jtmlXU4paUfY4I/lfkLeObhnxWXLBYVAc96Hxeo5J7SCEpacjObkKK7snTXft8Fg==
X-Received: by 2002:a05:600c:4e94:b0:3a3:455b:a277 with SMTP id f20-20020a05600c4e9400b003a3455ba277mr8610580wmq.198.1659282638083;
        Sun, 31 Jul 2022 08:50:38 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id k12-20020a5d524c000000b002205ffe88edsm2085093wrc.31.2022.07.31.08.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 08:50:37 -0700 (PDT)
Message-ID: <66b71194-ad0e-18d0-e43b-71e5c47ba111@gmail.com>
Date:   Sun, 31 Jul 2022 16:50:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] builtin/cat-file.c: support NUL-delimited input with
 `-z`
Content-Language: en-GB-large
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <cover.1658532524.git.me@ttaylorr.com>
 <ed1583223f63cfde99829069f14af62e4f0f2a82.1658532524.git.me@ttaylorr.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ed1583223f63cfde99829069f14af62e4f0f2a82.1658532524.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor

Thanks for working on this, I've been annoyed by the lack of a "-z" 
option but never got round to doing anything about it.

On 23/07/2022 00:29, Taylor Blau wrote:
> When callers are using `cat-file` via one of the stdin-driven `--batch`
> modes, all input is newline-delimited. This presents a problem when
> callers wish to ask about, e.g. tree-entries that have a newline
> character present in their filename.
> 
> To support this niche scenario, introduce a new `-z` mode to the
> `--batch`, `--batch-check`, and `--batch-command` suite of options that
> instructs `cat-file` to treat its input as NUL-delimited, allowing the
> individual commands themselves to have newlines present.

I wonder if this should also change the output delimiter from NL to NUL.

printf 'HEAD:does\nnot\nexist\000' | bin-wrappers/git cat-file 
--batch-check -z

prints

HEAD:does
not
exist missing

If it was terminated by a NUL rather than a newline it would be much 
easier to parse.

Best Wishes

Phillip

> The refactoring here is slightly unfortunate, since we turn loops like:
> 
>      while (strbuf_getline(&buf, stdin) != EOF)
> 
> into:
> 
>      while (1) {
>          int ret;
>          if (opt->nul_terminated)
>              ret = strbuf_getline_nul(&input, stdin);
>          else
>              ret = strbuf_getline(&input, stdin);
> 
>          if (ret == EOF)
>              break;
>      }
> 
> It's tempting to think that we could use `strbuf_getwholeline()` and
> specify either `\n` or `\0` as the terminating character. But for input
> on platforms that include a CR character preceeding the LF, this
> wouldn't quite be the same, since `strbuf_getline(...)` will trim any
> trailing CR, while `strbuf_getwholeline(&buf, stdin, '\n')` will not.
> 
> In the future, we could clean this up further by introducing a variant
> of `strbuf_getwholeline()` that addresses the aforementioned gap, but
> that approach felt too heavy-handed for this pair of uses.
> 
> Some tests are added in t1006 to ensure that `cat-file` produces the
> same output in `--batch`, `--batch-check`, and `--batch-command` modes
> with and without the new `-z` option.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>   Documentation/git-cat-file.txt |  7 +++++-
>   builtin/cat-file.c             | 28 ++++++++++++++++++++---
>   t/t1006-cat-file.sh            | 42 +++++++++++++++++++++++++++++++++-
>   3 files changed, 72 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index 24a811f0ef..3515350ed6 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>   'git cat-file' (-t | -s) [--allow-unknown-type] <object>
>   'git cat-file' (--batch | --batch-check | --batch-command) [--batch-all-objects]
>   	     [--buffer] [--follow-symlinks] [--unordered]
> -	     [--textconv | --filters]
> +	     [--textconv | --filters] [-z]
>   'git cat-file' (--textconv | --filters)
>   	     [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]
>   
> @@ -207,6 +207,11 @@ respectively print:
>   	/etc/passwd
>   --
>   
> +-z::
> +	Only meaningful with `--batch`, `--batch-check`, or
> +	`--batch-command`; input is NUL-delimited instead of
> +	newline-delimited.
> +
>   
>   OUTPUT
>   ------
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index f42782e955..c3602d15df 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -31,6 +31,7 @@ struct batch_options {
>   	int all_objects;
>   	int unordered;
>   	int transform_mode; /* may be 'w' or 'c' for --filters or --textconv */
> +	int nul_terminated;
>   	const char *format;
>   };
>   
> @@ -614,12 +615,20 @@ static void batch_objects_command(struct batch_options *opt,
>   	struct queued_cmd *queued_cmd = NULL;
>   	size_t alloc = 0, nr = 0;
>   
> -	while (!strbuf_getline(&input, stdin)) {
> -		int i;
> +	while (1) {
> +		int i, ret;
>   		const struct parse_cmd *cmd = NULL;
>   		const char *p = NULL, *cmd_end;
>   		struct queued_cmd call = {0};
>   
> +		if (opt->nul_terminated)
> +			ret = strbuf_getline_nul(&input, stdin);
> +		else
> +			ret = strbuf_getline(&input, stdin);
> +
> +		if (ret)
> +			break;
> +
>   		if (!input.len)
>   			die(_("empty command in input"));
>   		if (isspace(*input.buf))
> @@ -763,7 +772,16 @@ static int batch_objects(struct batch_options *opt)
>   		goto cleanup;
>   	}
>   
> -	while (strbuf_getline(&input, stdin) != EOF) {
> +	while (1) {
> +		int ret;
> +		if (opt->nul_terminated)
> +			ret = strbuf_getline_nul(&input, stdin);
> +		else
> +			ret = strbuf_getline(&input, stdin);
> +
> +		if (ret == EOF)
> +			break;
> +
>   		if (data.split_on_whitespace) {
>   			/*
>   			 * Split at first whitespace, tying off the beginning
> @@ -866,6 +884,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>   			N_("like --batch, but don't emit <contents>"),
>   			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>   			batch_option_callback),
> +		OPT_BOOL('z', NULL, &batch.nul_terminated, N_("stdin is NUL-terminated")),
>   		OPT_CALLBACK_F(0, "batch-command", &batch, N_("format"),
>   			N_("read commands from stdin"),
>   			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
> @@ -921,6 +940,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>   	else if (batch.all_objects)
>   		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
>   			       "--batch-all-objects");
> +	else if (batch.nul_terminated)
> +		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
> +			       "-z");
>   
>   	/* Batch defaults */
>   	if (batch.buffer_output < 0)
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 01c0535765..23b8942edb 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -88,7 +88,8 @@ done
>   
>   for opt in --buffer \
>   	--follow-symlinks \
> -	--batch-all-objects
> +	--batch-all-objects \
> +	-z
>   do
>   	test_expect_success "usage: bad option combination: $opt without batch mode" '
>   		test_incompatible_usage git cat-file $opt &&
> @@ -100,6 +101,10 @@ echo_without_newline () {
>       printf '%s' "$*"
>   }
>   
> +echo_without_newline_nul () {
> +	echo_without_newline "$@" | tr '\n' '\0'
> +}
> +
>   strlen () {
>       echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
>   }
> @@ -398,6 +403,12 @@ test_expect_success '--batch with multiple sha1s gives correct format' '
>   	test "$(maybe_remove_timestamp "$batch_output" 1)" = "$(maybe_remove_timestamp "$(echo_without_newline "$batch_input" | git cat-file --batch)" 1)"
>   '
>   
> +test_expect_success '--batch, -z with multiple sha1s gives correct format' '
> +	echo_without_newline_nul "$batch_input" >in &&
> +	test "$(maybe_remove_timestamp "$batch_output" 1)" = \
> +	"$(maybe_remove_timestamp "$(git cat-file --batch -z <in)" 1)"
> +'
> +
>   batch_check_input="$hello_sha1
>   $tree_sha1
>   $commit_sha1
> @@ -418,6 +429,24 @@ test_expect_success "--batch-check with multiple sha1s gives correct format" '
>       "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
>   '
>   
> +test_expect_success "--batch-check, -z with multiple sha1s gives correct format" '
> +    echo_without_newline_nul "$batch_check_input" >in &&
> +    test "$batch_check_output" = "$(git cat-file --batch-check -z <in)"
> +'
> +
> +test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
> +	touch -- "newline${LF}embedded" &&
> +	git add -- "newline${LF}embedded" &&
> +	git commit -m "file with newline embedded" &&
> +	test_tick &&
> +
> +	printf "HEAD:newline${LF}embedded" >in &&
> +	git cat-file --batch-check -z <in >actual &&
> +
> +	echo "$(git rev-parse "HEAD:newline${LF}embedded") blob 0" >expect &&
> +	test_cmp expect actual
> +'
> +
>   batch_command_multiple_info="info $hello_sha1
>   info $tree_sha1
>   info $commit_sha1
> @@ -436,6 +465,11 @@ test_expect_success '--batch-command with multiple info calls gives correct form
>   	echo "$batch_command_multiple_info" >in &&
>   	git cat-file --batch-command --buffer <in >actual &&
>   
> +	test_cmp expect actual &&
> +
> +	echo "$batch_command_multiple_info" | tr "\n" "\0" >in &&
> +	git cat-file --batch-command --buffer -z <in >actual &&
> +
>   	test_cmp expect actual
>   '
>   
> @@ -459,6 +493,12 @@ test_expect_success '--batch-command with multiple command calls gives correct f
>   	echo "$batch_command_multiple_contents" >in &&
>   	git cat-file --batch-command --buffer <in >actual_raw &&
>   
> +	remove_timestamp <actual_raw >actual &&
> +	test_cmp expect actual &&
> +
> +	echo "$batch_command_multiple_contents" | tr "\n" "\0" >in &&
> +	git cat-file --batch-command --buffer -z <in >actual_raw &&
> +
>   	remove_timestamp <actual_raw >actual &&
>   	test_cmp expect actual
>   '
