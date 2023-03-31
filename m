Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6977C761A6
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 16:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjCaQhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 12:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjCaQhU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 12:37:20 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0B9E053
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 09:33:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n19so13262400wms.0
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 09:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680280418;
        h=content-transfer-encoding:in-reply-to:cc:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OsyYy+0cTfu1rPvUkuwimZG9WIDFSE5AR0qKUTdmbWg=;
        b=BpW7Oi3Ldt25oT/tcNvDaibsUsU7t1NRVGYuF0x3+qRxHkDeYUWjCYLwubATyfO1QT
         knJZBpRT9lyM6w8eNR4GnVI0DtsS4d3n3+7h9uXlgKgB/oOkHB56lSzKBJyWxjETdB3T
         e3ZH6BwLBE7PBWiKZtKl2nf0D7yGXAgL0Rmqpy+dgUwG2k9tZRBO517XQD1f3K9Fnva2
         Poew7CIeU/0GuqtVp6ctuWOyRD7NTjI7h0cT0TQeMnmevTAcDRAXKI4VkbiRtxxU3PQB
         r4SqO5kry5z9m5VA5RlntDMQ7CeXRNLJS+LicAzeYBSacGaD5PGpe6fffEfbsw586XJN
         0Llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680280418;
        h=content-transfer-encoding:in-reply-to:cc:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsyYy+0cTfu1rPvUkuwimZG9WIDFSE5AR0qKUTdmbWg=;
        b=Nx5mij8zMsIdIt0kbIifYX8gKo98Y3vfJ6mv0Y0BtN5OdCuUmRpY40IFot4deBCy1f
         s0P4ZWbMTRTa9xyARSdSupN3VAaAqXTbqocTh0Kx+TzSXIt6XCZFYn0BeEE31gT010b6
         9OxRf84bgWOWbgO4EzsJQCAoQCxdljrFEo7OCLgeLjMswIjc6lijZTMm5H6I1svVoa8g
         8fFGbhzMQWIo/BBQ6UMPa2jQI+ZViTtYhtyMXlWWBlxAlBQJ7atHLFKlw2Tm8K8g9q7k
         u13vZdilhRzAKjT9ZJ8MZ8PP8uSpfTtBo5uNhd1jnX2x2vfPUN3y/HtNZJkOZj0TXNBy
         f+MA==
X-Gm-Message-State: AO0yUKUZkk6WQTek0YGtDSa492HeiTAgmz7NVGv7cg2kOpQ6eNBxhypR
        VMdoSVsBBtvBAb98vSOmTBw=
X-Google-Smtp-Source: AK7set9sz2ii75u8OpF3FdyCyj3yDfSj/vXs6se3eY7tYEuAWCuhDr2uwXM632utOoX0YnwK7mpRaA==
X-Received: by 2002:a1c:cc19:0:b0:3ed:4b9b:f0a1 with SMTP id h25-20020a1ccc19000000b003ed4b9bf0a1mr20839734wmb.27.1680280418472;
        Fri, 31 Mar 2023 09:33:38 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id q3-20020a05600c46c300b003ebf73acf9asm17764521wmo.3.2023.03.31.09.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 09:33:38 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <44e7ac0f-2fd9-fd01-89da-a8d036d2e400@dunelm.org.uk>
Date:   Fri, 31 Mar 2023 17:33:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] branch, for-each-ref: add option to omit empty lines
Content-Language: en-US
To:     =?UTF-8?Q?=c3=98ystein_Walle?= <oystwa@gmail.com>,
        git@vger.kernel.org
References: <20230330112133.4437-1-oystwa@gmail.com>
 <20230330112133.4437-3-oystwa@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
In-Reply-To: <20230330112133.4437-3-oystwa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Øystein

On 30/03/2023 12:21, Øystein Walle wrote:
> If the given format string expands to the empty string a newline is
> still printed it. This makes using the output linewise more tedious. For
> example, git update-ref --stdin does not accept empty lines.
> 
> Add options to branch and for-each-ref to not print these empty lines.
> The default behavior remains the same.

Do the empty lines in the output serve any useful purpose? If not then 
it might be better just to suppress them unconditionally rather than 
adding a new command line option.

Best Wishes

Phillip

> Signed-off-by: Øystein Walle <oystwa@gmail.com>
> ---
> 
> The logic is more or less duplicated in branch.c and for-each-ref.c
> which I don't like. However I couldn't really find a "central" place to
> put it. Imo. it's definitely not a property of the format or the filter,
> so struct ref_format and struct ref_filter are no good.
> 
> I also started working on a patch to make update-ref --stdin accept
> empty lines. But that seems to be a much more deliberate decision, with
> tests to verify it and all. So I stopped pursuing that.
> 
>   Documentation/git-branch.txt       |  5 +++++
>   Documentation/git-for-each-ref.txt |  5 +++++
>   builtin/branch.c                   | 12 +++++++++++-
>   builtin/for-each-ref.c             | 15 +++++++++++----
>   t/t3203-branch-output.sh           | 26 ++++++++++++++++++++++++++
>   t/t6300-for-each-ref.sh            |  8 ++++++++
>   6 files changed, 66 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index d382ac69f7..4d53133ce3 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -156,6 +156,11 @@ in another worktree linked to the same repository.
>   --ignore-case::
>   	Sorting and filtering branches are case insensitive.
>   
> +-n::
> +--omit-empty-lines::
> +	Do not print a newline after formatted refs where the format expands
> +	to the empty string.
> +
>   --column[=<options>]::
>   --no-column::
>   	Display branch listing in columns. See configuration variable
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 6da899c629..0f4fa98b18 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -93,6 +93,11 @@ OPTIONS
>   --ignore-case::
>   	Sorting and filtering refs are case insensitive.
>   
> +-n::
> +--omit-empty-lines::
> +	Do not print a newline after formatted refs where the format expands
> +	to the empty string.
> +
>   FIELD NAMES
>   -----------
>   
> diff --git a/builtin/branch.c b/builtin/branch.c
> index f63fd45edb..1bbb36b442 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -41,6 +41,7 @@ static const char *head;
>   static struct object_id head_oid;
>   static int recurse_submodules = 0;
>   static int submodule_propagate_branches = 0;
> +static int omit_empty_lines = 0;
>   
>   static int branch_use_color = -1;
>   static char branch_colors[][COLOR_MAXLEN] = {
> @@ -461,7 +462,8 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
>   			string_list_append(output, out.buf);
>   		} else {
>   			fwrite(out.buf, 1, out.len, stdout);
> -			putchar('\n');
> +			if (!omit_empty_lines || out.len > 0)
> +				putchar('\n');
>   		}
>   	}
>   
> @@ -670,6 +672,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>   		OPT_BIT('D', NULL, &delete, N_("delete branch (even if not merged)"), 2),
>   		OPT_BIT('m', "move", &rename, N_("move/rename a branch and its reflog"), 1),
>   		OPT_BIT('M', NULL, &rename, N_("move/rename a branch, even if target exists"), 2),
> +		OPT_BOOL('n' , "omit-empty-lines",  &omit_empty_lines,
> +			N_("do not output a newline after empty formatted refs")),
>   		OPT_BIT('c', "copy", &copy, N_("copy a branch and its reflog"), 1),
>   		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
>   		OPT_BOOL('l', "list", &list, N_("list branch names")),
> @@ -757,7 +761,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>   	}
>   
>   	if (list)
> +	{
> +		if (omit_empty_lines && !format.format) {
> +			error("--omit-empty-lines without --format does not make sense");
> +			usage_with_options(builtin_branch_usage, options);
> +		}
>   		setup_auto_pager("branch", 1);
> +	}
>   
>   	if (delete) {
>   		if (!argc)
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 6f62f40d12..349c4d4ef8 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -19,7 +19,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>   	int i;
>   	struct ref_sorting *sorting;
>   	struct string_list sorting_options = STRING_LIST_INIT_DUP;
> -	int maxcount = 0, icase = 0;
> +	int maxcount = 0, icase = 0, omit_empty_lines = 0;
>   	struct ref_array array;
>   	struct ref_filter filter;
>   	struct ref_format format = REF_FORMAT_INIT;
> @@ -35,6 +35,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>   			N_("quote placeholders suitably for python"), QUOTE_PYTHON),
>   		OPT_BIT(0 , "tcl",  &format.quote_style,
>   			N_("quote placeholders suitably for Tcl"), QUOTE_TCL),
> +		OPT_BOOL('n' , "omit-empty-lines",  &omit_empty_lines,
> +			N_("do not output a newline after empty formatted refs")),
>   
>   		OPT_GROUP(""),
>   		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
> @@ -55,8 +57,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>   	memset(&array, 0, sizeof(array));
>   	memset(&filter, 0, sizeof(filter));
>   
> -	format.format = "%(objectname) %(objecttype)\t%(refname)";
> -
>   	git_config(git_default_config, NULL);
>   
>   	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
> @@ -68,6 +68,12 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>   		error("more than one quoting style?");
>   		usage_with_options(for_each_ref_usage, opts);
>   	}
> +	if (omit_empty_lines && !format.format) {
> +		error("--omit-empty-lines without --format does not make sense");
> +		usage_with_options(for_each_ref_usage, opts);
> +	}
> +	if (!format.format)
> +		format.format = "%(objectname) %(objecttype)\t%(refname)";
>   	if (verify_ref_format(&format))
>   		usage_with_options(for_each_ref_usage, opts);
>   
> @@ -88,7 +94,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>   		if (format_ref_array_item(array.items[i], &format, &output, &err))
>   			die("%s", err.buf);
>   		fwrite(output.buf, 1, output.len, stdout);
> -		putchar('\n');
> +		if (!omit_empty_lines || output.len > 0)
> +			putchar('\n');
>   	}
>   
>   	strbuf_release(&err);
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index d34d77f893..26bf0819ea 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -341,6 +341,32 @@ test_expect_success 'git branch with --format=%(rest) must fail' '
>   	test_must_fail git branch --format="%(rest)" >actual
>   '
>   
> +test_expect_success 'git branch --format --omit-empty-lines' '
> +	cat >expect <<-\EOF &&
> +	Refname is (HEAD detached from fromtag)
> +	Refname is refs/heads/ambiguous
> +	Refname is refs/heads/branch-one
> +	Refname is refs/heads/branch-two
> +	EOF
> +	echo >>expect &&
> +	cat >>expect <<-\EOF &&
> +	Refname is refs/heads/ref-to-branch
> +	Refname is refs/heads/ref-to-remote
> +	EOF
> +	git branch --format="%(if:notequals=refs/heads/main)%(refname)%(then)Refname is %(refname)%(end)" >actual &&
> +	test_cmp expect actual &&
> +	cat >expect <<-\EOF &&
> +	Refname is (HEAD detached from fromtag)
> +	Refname is refs/heads/ambiguous
> +	Refname is refs/heads/branch-one
> +	Refname is refs/heads/branch-two
> +	Refname is refs/heads/ref-to-branch
> +	Refname is refs/heads/ref-to-remote
> +	EOF
> +	git branch --omit-empty-lines --format="%(if:notequals=refs/heads/main)%(refname)%(then)Refname is %(refname)%(end)" >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'worktree colors correct' '
>   	cat >expect <<-EOF &&
>   	* <GREEN>(HEAD detached from fromtag)<RESET>
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index c466fd989f..eec9d45513 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -1374,6 +1374,14 @@ test_expect_success 'for-each-ref --ignore-case ignores case' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'for-each-ref --omit-empty-lines works' '
> +	git for-each-ref --format="%(refname)" > actual &&
> +	test_line_count -gt 1 actual &&
> +	git for-each-ref --format="%(if:equals=refs/heads/main)%(refname)%(then)%(refname)%(end)" --omit-empty-lines > actual &&
> +	echo refs/heads/main > expect &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
>   	# name refs numerically to avoid case-insensitive filesystem conflicts
>   	nr=0 &&
