Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A0DC7EE24
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 15:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbjFEPsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 11:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjFEPrs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 11:47:48 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B1BE5D
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 08:47:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f7e7fc9fe6so3320925e9.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 08:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685980039; x=1688572039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/8kMYewY4dOgl21ycHWcLzC3hwKRTFdLCNObU6KbMiM=;
        b=LkK27cubvZOikOGd7QWzHxI5fylY9RS6Zb8DHM7HEO/KOXEck740bZOMUvc+MgJkkK
         2tZ0pzBfBuR51LqUtKyVK1Hn9k+WcyuWy4DBbMuZb2x+oHQNy0MX9c6Z51dpoQQ1LEHX
         coDxtav9Tecd+/BrVjl8rt0FwTY/XnTYJGdPG4/kF1P7CxpJw5SR2IvepbjSzCk65Vym
         elMwz9ARjNODqTncWha9M3LhSZGhH2ZzS8uYKjtK6nTOEENVXAyOVI1/zhrRrD7a92L7
         tw1yyEN8+qtvznpA1EJWpyIIXjpnKpzdwZmmhNbnGuZniqg98pQ+jkCElIH7hRaAg4TR
         TixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685980039; x=1688572039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8kMYewY4dOgl21ycHWcLzC3hwKRTFdLCNObU6KbMiM=;
        b=T0SIYKMOZ4M3+eblM7b5m5a4V8Ctqs0j1XH6O18AAsfE78PinqMEfRHeb9Bo9E+zeZ
         DU0tOC/cdgxZrOJ5kXMSYYMiA0Y016qKthUBJeRQLkJGvunMe681HZUcS0U6z2qCdDUn
         7qSLd2Yg18z/DL2WSawOsCU6SvarfJAq8DOJp/fCXRQ+FhltNW8EWFzcN6JK78Lzpi2M
         dXWXib3EacbIXuLMv3NX7ygykqLJoljTxuuD7uS6gFkGa8WCYL16eUf6PJdXR0q/x3ZG
         MGu6HhDp3j+icwoXKc03PmRSkl2hblUpN4Q5I4mNaERxNUKB7qq+28BbgRW4dkqg+Fqe
         3n4Q==
X-Gm-Message-State: AC+VfDz6Xf5WpquN3F1+LIWLyDDhaTYq8KcJV0Pb6fizLgzfYdmcy7VY
        dtyc7v30N1M4fexa9F8uyuGOQ5iZZtM=
X-Google-Smtp-Source: ACHHUZ70rUhEFBo3tgJyv1VJkTc5J9CCU9pQvBSqrboroJzbnzJIZPs0VP14063sh8Mv0fbn/YqvTA==
X-Received: by 2002:a1c:7512:0:b0:3f6:af2:8471 with SMTP id o18-20020a1c7512000000b003f60af28471mr7824846wmc.26.1685980038732;
        Mon, 05 Jun 2023 08:47:18 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id l24-20020a1ced18000000b003f31cb7a203sm11380320wmh.14.2023.06.05.08.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 08:47:18 -0700 (PDT)
Message-ID: <9900512f-b0da-2e47-f1ab-ed51ec2c78ff@gmail.com>
Date:   Mon, 5 Jun 2023 16:47:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/5] cat-file: Introduce new option to delimit output with
 NUL characters
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1685710884.git.ps@pks.im>
 <07a7c34615ec68fa42c725fd34d6144b6b191f03.1685710884.git.ps@pks.im>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <07a7c34615ec68fa42c725fd34d6144b6b191f03.1685710884.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Patrick

On 02/06/2023 14:02, Patrick Steinhardt wrote:
> In db9d67f2e9 (builtin/cat-file.c: support NUL-delimited input with
> `-z`, 2022-07-22), we have introduced a new mode to read the input via
> NUL-delimited records instead of newline-delimited records. This allows
> the user to query for revisions that have newlines in their path
> component. While unusual, such queries are perfectly valid and thus it
> is clear that we should be able to support them properly.
> 
> Unfortunately, the commit only changed the input to be NUL-delimited,
> but didn't change the output at the same time. While this is fine for
> queries that are processed successfully, it is less so for queries that
> aren't. In the case of missing commits for example the result can become
> entirely unparsable:
> 
> ```
> $ printf "7ce4f05bae8120d9fa258e854a8669f6ea9cb7b1 blob 10\n1234567890\n\n\commit000" |
>      git cat-file --batch -z
> 7ce4f05bae8120d9fa258e854a8669f6ea9cb7b1 blob 10
> 1234567890
> 
> commit missing
> ```
> 
> This is of course a crafted query that is intentionally gaming the
> deficiency, but more benign queries that contain newlines would have
> similar problems.
> 
> Ideally, we should have also changed the output to be NUL-delimited when
> `-z` is specified to avoid this problem. As the input is NUL-delimited,
> it is clear that the output in this case cannot ever contain NUL
> characters by itself. Furthermore, Git does not allow NUL characters in
> revisions anyway, further stressing the point that using NUL-delimited
> output is safe. The only exception is of course the object data itself,
> but as git-cat-file(1) prints the size of the object data clients should
> read until that specified size has been consumed.
> 
> But even though `-z` has only been introduced a few releases ago in Git
> v2.38.0, changing the output format retroactively to also NUL-delimit
> output would be a backwards incompatible change. And while one could
> make the argument that the output is inherently broken already, we need
> to assume that there are existing users out there that use it just fine
> given that revisions containing newlines are quite exotic.
> 
> Instead, introduce a new option `-Z` that switches to NUL-delimited
> input and output. The old `-z` option is marked as deprecated with a
> hint that its output may become unparsable.

The commit message explains the problem well, I agree adding a new 
option is the cleanest solution.

> Co-authored-by: Toon Claes <toon@iotcl.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   Documentation/git-cat-file.txt |  13 +++-
>   builtin/cat-file.c             |  55 +++++++++------
>   t/t1006-cat-file.sh            | 123 ++++++++++++++++++++++++---------
>   3 files changed, 137 insertions(+), 54 deletions(-)
> 
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index 411de2e27d..b1f48fdfb1 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>   'git cat-file' (-t | -s) [--allow-unknown-type] <object>
>   'git cat-file' (--batch | --batch-check | --batch-command) [--batch-all-objects]
>   	     [--buffer] [--follow-symlinks] [--unordered]
> -	     [--textconv | --filters] [-z]
> +	     [--textconv | --filters] [-z] [-Z]
>   'git cat-file' (--textconv | --filters)
>   	     [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]
>   
> @@ -246,6 +246,12 @@ respectively print:
>   -z::
>   	Only meaningful with `--batch`, `--batch-check`, or
>   	`--batch-command`; input is NUL-delimited instead of
> +	newline-delimited. This option is deprecated in favor of
> +	`-Z` as the output can otherwise be ambiguous.
> +
> +-Z::
> +	Only meaningful with `--batch`, `--batch-check`, or
> +	`--batch-command`; input and output is NUL-delimited instead of
>   	newline-delimited.

The documentation changes look good. I wonder if we should put the 
documentation for "-Z" above "-z" so users see the preferred option first.

>   
> @@ -384,6 +390,11 @@ notdir SP <size> LF
>   is printed when, during symlink resolution, a file is used as a
>   directory name.
>   
> +Alternatively, when `-Z` is passed, the line feeds in any of the above examples
> +are replaced with NUL terminators. This ensures that output will be parsable if
> +the output itself would contain a linefeed and is thus recommended for
> +scripting purposes.
> +
>   CAVEATS
>   -------
>   
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 001dcb24d6..90ef407d30 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -492,17 +494,18 @@ static void batch_object_write(const char *obj_name,
>   	strbuf_reset(scratch);
>   
>   	if (!opt->format) {
> -		print_default_format(scratch, data);
> +		print_default_format(scratch, data, opt);
>   	} else {
>   		strbuf_expand(scratch, opt->format, expand_format, data);
> -		strbuf_addch(scratch, '\n');
> +		strbuf_addch(scratch, opt->output_delim);
>   	}
>   
>   	batch_write(opt, scratch->buf, scratch->len);
>   
>   	if (opt->batch_mode == BATCH_MODE_CONTENTS) {
> +		char buf[] = {opt->output_delim};

I found this a bit confusing, I think it would be clearer just to do

	batch_write(opt, &opt->output_delim, 1);

>   		print_object_or_die(opt, data);
> -		batch_write(opt, "\n", 1);
> +		batch_write(opt, buf, 1);
>   	}
>   }

> @@ -920,7 +927,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>   		N_("git cat-file (-t | -s) [--allow-unknown-type] <object>"),
>   		N_("git cat-file (--batch | --batch-check | --batch-command) [--batch-all-objects]\n"
>   		   "             [--buffer] [--follow-symlinks] [--unordered]\n"
> -		   "             [--textconv | --filters] [-z]"),
> +		   "             [--textconv | --filters] [-z] [-Z]"),

If we're recommending that people don't use '-z' then maybe we should 
remove it from the synopsis and add OPT_HIDDEN to it below.

>   		N_("git cat-file (--textconv | --filters)\n"
>   		   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
>   		NULL
> @@ -950,6 +957,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>   			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>   			batch_option_callback),
>   		OPT_BOOL('z', NULL, &input_nul_terminated, N_("stdin is NUL-terminated")),
> +		OPT_BOOL('Z', NULL, &nul_terminated, N_("stdin and stdout is NUL-terminated")),

> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 7b985cfded..d73a0be1b9 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -392,17 +393,18 @@ deadbeef
>   
>   "
>   
> -batch_output="$hello_sha1 blob $hello_size
> -$hello_content
> -$commit_sha1 commit $commit_size
> -$commit_content
> -$tag_sha1 tag $tag_size
> -$tag_content
> -deadbeef missing
> - missing"
> +printf "%s\0" \
> +	"$hello_sha1 blob $hello_size" \
> +	"$hello_content" \
> +	"$commit_sha1 commit $commit_size" \
> +	"$commit_content" \
> +	"$tag_sha1 tag $tag_size" \
> +	"$tag_content" \
> +	"deadbeef missing" \
> +	" missing" >batch_output

I think writing the expected output to a file is a good change as we 
always use it with test_cmp. As "-z" is deprecated I think it makes 
sense to model the expected output for "-Z" and use tr for the "-z" 
tests as you have done here. It looks like we have good coverage of the 
new option.

Thanks for working on this

Phillip

>   test_expect_success '--batch with multiple sha1s gives correct format' '
> -	echo "$batch_output" >expect &&
> +	tr "\0" "\n" <batch_output >expect &&
>   	echo_without_newline "$batch_input" >in &&
>   	git cat-file --batch <in >actual &&
>   	test_cmp expect actual
> @@ -410,11 +412,17 @@ test_expect_success '--batch with multiple sha1s gives correct format' '
>   
>   test_expect_success '--batch, -z with multiple sha1s gives correct format' '
>   	echo_without_newline_nul "$batch_input" >in &&
> -	echo "$batch_output" >expect &&
> +	tr "\0" "\n" <batch_output >expect &&
>   	git cat-file --batch -z <in >actual &&
>   	test_cmp expect actual
>   '
>   
> +test_expect_success '--batch, -Z with multiple sha1s gives correct format' '
> +	echo_without_newline_nul "$batch_input" >in &&
> +	git cat-file --batch -Z <in >actual &&
> +	test_cmp batch_output actual
> +'
> +
>   batch_check_input="$hello_sha1
>   $tree_sha1
>   $commit_sha1
> @@ -423,40 +431,55 @@ deadbeef
>   
>   "
>   
> -batch_check_output="$hello_sha1 blob $hello_size
> -$tree_sha1 tree $tree_size
> -$commit_sha1 commit $commit_size
> -$tag_sha1 tag $tag_size
> -deadbeef missing
> - missing"
> +printf "%s\0" \
> +	"$hello_sha1 blob $hello_size" \
> +	"$tree_sha1 tree $tree_size" \
> +	"$commit_sha1 commit $commit_size" \
> +	"$tag_sha1 tag $tag_size" \
> +	"deadbeef missing" \
> +	" missing" >batch_check_output
>   
>   test_expect_success "--batch-check with multiple sha1s gives correct format" '
> -	echo "$batch_check_output" >expect &&
> +	tr "\0" "\n" <batch_check_output >expect &&
>   	echo_without_newline "$batch_check_input" >in &&
>   	git cat-file --batch-check <in >actual &&
>   	test_cmp expect actual
>   '
>   
>   test_expect_success "--batch-check, -z with multiple sha1s gives correct format" '
> -	echo "$batch_check_output" >expect &&
> +	tr "\0" "\n" <batch_check_output >expect &&
>   	echo_without_newline_nul "$batch_check_input" >in &&
>   	git cat-file --batch-check -z <in >actual &&
>   	test_cmp expect actual
>   '
>   
> -test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
> +test_expect_success "--batch-check, -Z with multiple sha1s gives correct format" '
> +	echo_without_newline_nul "$batch_check_input" >in &&
> +	git cat-file --batch-check -Z <in >actual &&
> +	test_cmp batch_check_output actual
> +'
> +
> +test_expect_success FUNNYNAMES 'setup with newline in input' '
>   	touch -- "newline${LF}embedded" &&
>   	git add -- "newline${LF}embedded" &&
>   	git commit -m "file with newline embedded" &&
>   	test_tick &&
>   
> -	printf "HEAD:newline${LF}embedded" >in &&
> -	git cat-file --batch-check -z <in >actual &&
> +	printf "HEAD:newline${LF}embedded" >in
> +'
>   
> +test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
> +	git cat-file --batch-check -z <in >actual &&
>   	echo "$(git rev-parse "HEAD:newline${LF}embedded") blob 0" >expect &&
>   	test_cmp expect actual
>   '
>   
> +test_expect_success FUNNYNAMES '--batch-check, -Z with newline in input' '
> +	git cat-file --batch-check -Z <in >actual &&
> +	printf "%s\0" "$(git rev-parse "HEAD:newline${LF}embedded") blob 0" >expect &&
> +	test_cmp expect actual
> +'
> +
>   batch_command_multiple_info="info $hello_sha1
>   info $tree_sha1
>   info $commit_sha1
> @@ -480,7 +503,13 @@ test_expect_success '--batch-command with multiple info calls gives correct form
>   	echo "$batch_command_multiple_info" | tr "\n" "\0" >in &&
>   	git cat-file --batch-command --buffer -z <in >actual &&
>   
> -	test_cmp expect actual
> +	test_cmp expect actual &&
> +
> +	echo "$batch_command_multiple_info" | tr "\n" "\0" >in &&
> +	tr "\n" "\0" <expect >expect_nul &&
> +	git cat-file --batch-command --buffer -Z <in >actual &&
> +
> +	test_cmp expect_nul actual
>   '
>   
>   batch_command_multiple_contents="contents $hello_sha1
> @@ -490,15 +519,15 @@ contents deadbeef
>   flush"
>   
>   test_expect_success '--batch-command with multiple command calls gives correct format' '
> -	cat >expect <<-EOF &&
> -	$hello_sha1 blob $hello_size
> -	$hello_content
> -	$commit_sha1 commit $commit_size
> -	$commit_content
> -	$tag_sha1 tag $tag_size
> -	$tag_content
> -	deadbeef missing
> -	EOF
> +	printf "%s\0" \
> +		"$hello_sha1 blob $hello_size" \
> +		"$hello_content" \
> +		"$commit_sha1 commit $commit_size" \
> +		"$commit_content" \
> +		"$tag_sha1 tag $tag_size" \
> +		"$tag_content" \
> +		"deadbeef missing" >expect_nul &&
> +	tr "\0" "\n" <expect_nul >expect &&
>   
>   	echo "$batch_command_multiple_contents" >in &&
>   	git cat-file --batch-command --buffer <in >actual &&
> @@ -508,7 +537,12 @@ test_expect_success '--batch-command with multiple command calls gives correct f
>   	echo "$batch_command_multiple_contents" | tr "\n" "\0" >in &&
>   	git cat-file --batch-command --buffer -z <in >actual &&
>   
> -	test_cmp expect actual
> +	test_cmp expect actual &&
> +
> +	echo "$batch_command_multiple_contents" | tr "\n" "\0" >in &&
> +	git cat-file --batch-command --buffer -Z <in >actual &&
> +
> +	test_cmp expect_nul actual
>   '
>   
>   test_expect_success 'setup blobs which are likely to delta' '
> @@ -848,6 +882,13 @@ test_expect_success 'git cat-file --batch-check --follow-symlinks works for brok
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'git cat-file --batch-check --follow-symlinks -Z works for broken in-repo, same-dir links' '
> +	printf "HEAD:broken-same-dir-link\0" >in &&
> +	printf "dangling 25\0HEAD:broken-same-dir-link\0" >expect &&
> +	git cat-file --batch-check --follow-symlinks -Z <in >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'git cat-file --batch-check --follow-symlinks works for same-dir links-to-links' '
>   	echo HEAD:link-to-link | git cat-file --batch-check --follow-symlinks >actual &&
>   	test_cmp found actual
> @@ -862,6 +903,15 @@ test_expect_success 'git cat-file --batch-check --follow-symlinks works for pare
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'git cat-file --batch-check --follow-symlinks -Z works for parent-dir links' '
> +	echo HEAD:dir/parent-dir-link | git cat-file --batch-check --follow-symlinks >actual &&
> +	test_cmp found actual &&
> +	printf "notdir 29\0HEAD:dir/parent-dir-link/nope\0" >expect &&
> +	printf "HEAD:dir/parent-dir-link/nope\0" >in &&
> +	git cat-file --batch-check --follow-symlinks -Z <in >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'git cat-file --batch-check --follow-symlinks works for .. links' '
>   	echo dangling 22 >expect &&
>   	echo HEAD:dir/link-dir/nope >>expect &&
> @@ -976,6 +1026,13 @@ test_expect_success 'git cat-file --batch-check --follow-symlink breaks loops' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'git cat-file --batch-check --follow-symlink -Z breaks loops' '
> +	printf "loop 10\0HEAD:loop1\0" >expect &&
> +	printf "HEAD:loop1\0" >in &&
> +	git cat-file --batch-check --follow-symlinks -Z <in >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'git cat-file --batch --follow-symlink returns correct sha and mode' '
>   	echo HEAD:morx | git cat-file --batch >expect &&
>   	echo HEAD:morx | git cat-file --batch --follow-symlinks >actual &&
