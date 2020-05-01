Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5867C47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 10:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A250E2071C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 10:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVsNpA2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgEAKBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 06:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728119AbgEAKBP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 06:01:15 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89253C08E859
        for <git@vger.kernel.org>; Fri,  1 May 2020 03:01:13 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v26so7555114qto.0
        for <git@vger.kernel.org>; Fri, 01 May 2020 03:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k7sJb/JSOWUHC63bATOp3OBfqXIE2B7vLLJPh+EyW5Y=;
        b=XVsNpA2J29tOYkwBWUZ8THnHSvvEcyZAl1LGeeATyVxvDXaWYkbCC32mwYVXaFQWdV
         EyooeIsPWR1hB2DE4XAgmyLCij+7bkvTnig/4Cv3WxHuRfECVsyH59AC/ZMXRIbE/+st
         0WRJQcvR9XxPzOcMLc1oqxcynzPCmvzzFeY6sNzutYTpbVAf/DRv+qEatwZOq9A2A7yz
         ZNrm7eVH6bLKVbfi2wYYmuJXlkEKRNzggLuhrr9noS5hRhxR4SvpONBp10d3pUdi7hRE
         i+czrAgjnLPyILleo74nTnuxTrX2vuQ99lEkg+6m/s5pa8WFQBQKuVJAwQmgwJ8G+A5F
         ZMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k7sJb/JSOWUHC63bATOp3OBfqXIE2B7vLLJPh+EyW5Y=;
        b=pikJfBymowqh9Vfwg2yffjdhWAwSdT6MZyr1FSMEwLMRHBriB2p5ze4mrcOtS7dEQm
         42D29RKNSlKz1XWizb4YwieW0djNyDI7QbKxoeS4XhpTlFWyxWjJLr2wkohxKSxYD04B
         6rG/DxaddBdsR2/4X9+UU/VT+ZKJgrWFjmu1y/aQ1/tBDau4uBDd2TIpSs5yzEmXmAr/
         zzmfQgAiV3YNrIFxKAdKHsNs8V4WHu3yoQ5I2Qz/3IfBXE7bjZSUebFT4Tdq5dJpbKBW
         FySdxvE+b0JFJCUwC/0MOWAC8Il347fdTxmVPO2np1cMhihi0Pkt/lfqSqizO/3S1+CI
         pKSA==
X-Gm-Message-State: AGi0Pub5OBAKB98XbZPH+kVK4PUCLyppD2+mTMrkXlYDssRZymKo4Owk
        BUNSMcqjVzRX/F9A9AhbOeNfKnUg
X-Google-Smtp-Source: APiQypJwYWgyD6bkbyaxq1HxTHkVkT+f1bBATsiXlI8wovBSQU7rKhqcrC23sGamPCJnJuHuUH251g==
X-Received: by 2002:ac8:2db9:: with SMTP id p54mr2883520qta.125.1588327272594;
        Fri, 01 May 2020 03:01:12 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id p11sm2210939qki.25.2020.05.01.03.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 03:01:11 -0700 (PDT)
Date:   Fri, 1 May 2020 06:01:09 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, peff@peff.net,
        heba.waly@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2] submodule: port subcommand 'set-url' from shell to C
Message-ID: <20200501100109.GA55820@generichostname>
References: <20200501073232.18409-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501073232.18409-1-shouryashukla.oo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

I ran into a few whitespace errors when applying this patch. You should
run `git diff --check` before committing so that you can fix these.

On Fri, May 01, 2020 at 01:02:32PM +0530, Shourya Shukla wrote:
> This aims to convert submodule subcommand 'set-url' to a builtin.
> 'set-url' is ported to 'submodule--helper.c' and the latter is called
> via 'git-submodule.sh'.

Commit messages should be written in imperative mood. This could be
rewritten as

	Convert submodule subcommand 'set-url' to a builtin. Port
	'set-url' to 'submodule--helper.c' and call the latter via
	'git-submodule.sh'.

> 'module_set_url()' accepts the the user input, which is parsed by

s/the the/the/

> 'parse_options()', followed by the setting of the appropriate entry
> (i.e., the submodule URL here). Finally, the URL is synced, via
> 'sync_submodule()', with the upstream.

Others might disagree with me but I believe that this paragraph dives
in too deeply. It might be more helpful to give a higher level overview
than repeating what the code.

> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
> I finally fixed the implementation, was making a silly mistake.
> The test './t7420-submodule-set-url.sh' passes (both tests 1 and 2
> are successful now). I have deleted the function,
> 'update_url_in_gitmodules()' because I was able to suffice that
> functionality in the 'module_set_url()' function itself.
> 
> Thank you so much Christian and Denton for helping me :)

No problem :)

>  builtin/submodule--helper.c | 55 +++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            | 25 ++---------------
>  2 files changed, 58 insertions(+), 22 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 1a4b391c88..59334d4286 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2246,6 +2246,60 @@ static int module_config(int argc, const char **argv, const char *prefix)
>  	usage_with_options(git_submodule_helper_usage, module_config_options);
>  }
>  
> +struct set_url_cb {
> +	const char *prefix;
> +	unsigned int flags;
> +};
> +
> +#define SET_URL_CB_INIT { NULL, 0 }
> +
> +static int module_set_url(int argc, const char **argv, const char *prefix)
> +{
> +	struct set_url_cb info = SET_URL_CB_INIT;
> +	int quiet = 0;
> +
> +	const char *newurl = NULL;
> +	const char *path = NULL;
> +	
> +	struct strbuf entry = STRBUF_INIT;
> +
> +	struct option module_set_url_options[] = {
> +		OPT__QUIET(&quiet, N_("Suppress output for setting url of a submodule")),

I know that many options in the rest of the file don't follow this
convention but the help string should begin with a lowercase.

> +		OPT_END()
> +	};
> +
> +	const char *const git_submodule_helper_usage[] = {
> +		N_("git submodule--helper set-url [--quiet] [<path>] [<newurl>]"),

<path> and <newurl> should be mandatory arguments.

> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, NULL, module_set_url_options,

How come you aren't passing in the prefix here?

> +			     git_submodule_helper_usage, 0);
> +
> +	info.prefix = prefix;
> +	if (quiet)
> +		info.flags |= OPT_QUIET;
> +

Over here, you should check argc to ensure that we have exactly two
arguments...

> +	path = argv[0];
> +	newurl = argv[1];

...otherwise this may segfault.

> +
> +	if(!path || !newurl){

nit: space after `if` and betwen `) {`. Also, this won't be necessary
once you check the argc.

> +		usage_with_options(git_submodule_helper_usage,module_set_url_options);

nit: space after the `,`

> +		return 1;
> +	}
> +
> +	strbuf_addstr(&entry, "submodule.");
> +	strbuf_addstr(&entry, path);
> +	strbuf_addstr(&entry, ".url");
> +	
> +	/* Setting the new URL in .gitmodules */

I don't think these comments are necessary. It's pretty obvious what's
happening in the code.

> +	config_set_in_gitmodules_file_gently(entry.buf, newurl);  
> +	/* Syncing the updated URL */
> +	sync_submodule(path, prefix, info.flags);
> +

Make sure you strbuf_release() the strbuf here.

> +	return 0;
> +}
> +
>  #define SUPPORT_SUPER_PREFIX (1<<0)
>  
>  struct cmd_struct {
> @@ -2276,6 +2330,7 @@ static struct cmd_struct commands[] = {
>  	{"is-active", is_active, 0},
>  	{"check-name", check_name, 0},
>  	{"config", module_config, 0},
> +	{"set-url", module_set_url, 0},
>  };
>  
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 89f915cae9..ea72d5a5f5 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -783,11 +783,13 @@ cmd_set_branch() {
>  # $@ = requested path, requested url
>  #
>  cmd_set_url() {
> +
>  	while test $# -ne 0
>  	do
>  		case "$1" in
>  		-q|--quiet)
>  			GIT_QUIET=1
> +			shift
>  			;;
>  		--)
>  			shift
> @@ -800,30 +802,9 @@ cmd_set_url() {
>  			break
>  			;;
>  		esac
> -		shift

Hmmm, I don't understand why the above hunk and this line are necessary.

>  	done
>  
> -	if test $# -ne 2
> -	then
> -		usage
> -	fi
> -
> -	# we can't use `git submodule--helper name` here because internally, it
> -	# hashes the path so a trailing slash could lead to an unintentional no match
> -	name="$(git submodule--helper list "$1" | cut -f2)"
> -	if test -z "$name"
> -	then
> -		exit 1
> -	fi
> -
> -	url="$2"
> -	if test -z "$url"
> -	then
> -		exit 1
> -	fi
> -
> -	git submodule--helper config submodule."$name".url "$url"
> -	git submodule--helper sync ${GIT_QUIET:+--quiet} "$name"
> +	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-url ${GIT_QUIET:+--quiet} -- "$@"

This looks good, though :)

Thanks,

Denton

>  }
>  
>  #
> -- 
> 2.26.2
> 
