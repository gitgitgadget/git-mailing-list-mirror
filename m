Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4BDC433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 12:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B4560295
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 12:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhJZMJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 08:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbhJZMJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 08:09:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07FDC061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 05:07:02 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v16so4793947ple.9
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 05:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=emgUZ659XKmn9glNQvbRMaM6M0ASrs2qCeOGqERg9ZY=;
        b=FtXDd9fgewrjMkpBGHQAVmfYxCG8POl9fXrGrbLAwGckotFBfRte0jge6xGtJyFEJ7
         VOihBSP+SXZVyW1WmKSCnOLdmKstlRZg0p+clNpCf3yo94VvCd9g4HejukERU0lHDTEb
         hTKhB8RidmUAKw3kh/ZelIaz5wskqGQGfcnfllI1EVY4h0BYSo9yDN6H7MF9Z1NekAMh
         h3UObmJoyxEVcekNhG25cXIwFKstProAJtkCmFf7TXcZb8kKErzpGYY4/WMk0dsjSPzh
         gwpvP02a4vRvKI+eHMlyTuuOBFpXin+Z8P6ctOtJozuS5BXskqkEJ2PRl2fL/MC/WubO
         BzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=emgUZ659XKmn9glNQvbRMaM6M0ASrs2qCeOGqERg9ZY=;
        b=jXZz3Nb4S25WGxU+7jC05l+CHk6UQQmsG5XtUUn9nJ7yHeICGO/m4mZ27D+VTG5pB5
         GHUSgRk71BkEPQkGbf/khsR0Fokr5CF/3+rEPR/DssSOx8fsI8AY0oKUjwfcnfqOES/1
         3FNgx+9tjj38u1pO6W7q7pZppAIj6nLlvSDBcVwvRsKtHEacoZXxeRdBIi2coCeCqtHR
         h3qPnX3RLVb49+KqOiWTfvbGSWBgrZSOORPW1YUjUo4g9E7i8lkHUonOXtzF9fbfSjL7
         yihFuM1LtD5D9h4NYzTEGEB2vKxNAnnTb0b/KIBKwn5tL0YbM6hqGRImE+cLyM3JKt8n
         8F3A==
X-Gm-Message-State: AOAM530RUFDZdCCBndnp+CVfJ2+9lCA8QnXRPjcFnvBWRXxMCERrxGAl
        8EFd/2pLJIupMvQBkd0sxCTSfZwayes=
X-Google-Smtp-Source: ABdhPJxlaUZuB8ym/31Ywta6agng6UHnlp05jCDWFJj1UqTvJFlRf5gbjDFntXMR9XPWM6bfiV4KYQ==
X-Received: by 2002:a17:90b:1c02:: with SMTP id oc2mr28186901pjb.128.1635250022214;
        Tue, 26 Oct 2021 05:07:02 -0700 (PDT)
Received: from localhost ([2402:800:63ed:4f9f:ab51:923b:a9aa:a7f3])
        by smtp.gmail.com with ESMTPSA id y17sm24114010pfi.206.2021.10.26.05.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 05:07:00 -0700 (PDT)
Date:   Tue, 26 Oct 2021 19:06:59 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Eli Schwartz <eschwartz@archlinux.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pretty: add abbrev option to %(describe)
Message-ID: <YXfvY3n9wEwctjUR@danh.dev>
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211026013452.1372122-4-eschwartz@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026013452.1372122-4-eschwartz@archlinux.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-10-25 21:34:52-0400, Eli Schwartz <eschwartz@archlinux.org> wrote:
> The %(describe) placeholder by default, like `git describe`, uses a
> seven-character abbreviated commit object name. This may not be
> sufficient to fully describe all commits in a given repository,
> resulting in a placeholder replacement changing its length because the
> repository grew in size.  This could cause the output of git-archive to
> change.
> 
> Add the --abbrev option to `git describe` to the placeholder interface
> in order to provide tools to the user for fine-tuning project defaults
> and ensure reproducible archives.
> 
> One alternative would be to just always specify --abbrev=40 but this may
> be a bit too biased...
> 
> Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
> ---
> 
> Notes:
>     With regard to validating that an integer is passed, I attempt to parse the
>     result using the same mechanism git-describe itself does in the abbrev
>     callback, just with slightly different validation of what we have at the end...
>     because of course here argval is the entire rest of the format string,
>     including the ")".
>     
>     While testing that this actually does what it's supposed to do, I noticed that
>     it doesn't validate junk like leading whitespace or plus signs... this is a
>     problem for `git describe --abbrev='    +15'` too so I guess it's not my
>     problem to fix...
> 
>  Documentation/pretty-formats.txt |  4 ++++
>  pretty.c                         | 16 +++++++++++++++-
>  t/t4205-log-pretty-formats.sh    |  8 ++++++++
>  3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 86ed801aad..57fd84f579 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -222,6 +222,10 @@ The placeholders are:
>  +
>  ** 'tags[=<BOOL>]': Instead of only considering annotated tags,
>     consider lightweight tags as well.
> +** 'abbrev=<N>': Instead of using the default number of hexadecimal digits
> +   (which will vary according to the number of objects in the repository with a
> +   default of 7) of the abbreviated object name, use <n> digits, or as many digits
> +   as needed to form a unique object name.
>  ** 'match=<pattern>': Only consider tags matching the given
>     `glob(7)` pattern, excluding the "refs/tags/" prefix.
>  ** 'exclude=<pattern>': Do not consider tags matching the given
> diff --git a/pretty.c b/pretty.c
> index 16b5366fed..44bfc49b38 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1218,9 +1218,10 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
>  {
>  	struct {
>  		char *name;
> -		enum { OPT_BOOL, OPT_STRING, } type;
> +		enum { OPT_BOOL, OPT_INTEGER, OPT_STRING, } type;
>  	}  option[] = {
>  		{ "tags", OPT_BOOL},
> +		{ "abbrev", OPT_INTEGER },
>  		{ "exclude", OPT_STRING },
>  		{ "match", OPT_STRING },
>  	};
> @@ -1245,6 +1246,19 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
>  					found = 1;
>  				}
>  				break;
> +			case OPT_INTEGER:
> +				if (match_placeholder_arg_value(arg, option[i].name, &arg,
> +								&argval, &arglen) && arglen) {
> +					if (!arglen)
> +						return 0;
> +					char* endptr;

Other than the question pointed out by Eric,

with DEVELOPER=1, -Werror=declaration-after-statement
We'll need this change squashed in:

------- 8< -----
diff --git a/pretty.c b/pretty.c
index 289b5456c8..85d4ab008b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1249,9 +1249,9 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
 			case OPT_INTEGER:
 				if (match_placeholder_arg_value(arg, option[i].name, &arg,
 								&argval, &arglen) && arglen) {
+					char* endptr;
 					if (!arglen)
 						return 0;
-					char* endptr;
 					strtol(argval, &endptr, 10);
 					if (endptr - argval != arglen)
 						return 0;
------- >8 -----

> +					strtol(argval, &endptr, 10);
> +					if (endptr - argval != arglen)
> +						return 0;
> +					strvec_pushf(args, "--%s=%.*s", option[i].name, (int)arglen, argval);
> +					found = 1;
> +				}
> +				break;
>  			case OPT_STRING:
>  				if (match_placeholder_arg_value(arg, option[i].name, &arg,
>  								&argval, &arglen) && arglen) {
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index d4acf8882f..35eef4c865 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -1010,4 +1010,12 @@ test_expect_success '%(describe:tags) vs git describe --tags' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '%(describe:abbrev=...) vs git describe --abbrev=...' '
> +	test_when_finished "git tag -d tagname" &&
> +	git tag -a -m tagged tagname &&
> +	git describe --abbrev=15 >expect &&
> +	git log -1 --format="%(describe:abbrev=15)" >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> -- 
> 2.33.1
> 

-- 
Danh
