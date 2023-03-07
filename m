Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E816C61DA4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 00:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCGAnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 19:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCGAnR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 19:43:17 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A5C39CC1
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 16:43:16 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id l2so7619443ilg.7
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 16:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1678149796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X1a5tKSoT3CRUkx8kOsCuehNatDTvNV1swkY9ybSMA0=;
        b=AuJ3wIZ56+COK43YuWJYEo7ufJqM9aS5py2GUChIKHLAAcNxbBibP9Wb9vRfLaaAug
         JPANAEeWNgrfLWZqaBKLnjbSr/icV8ymtfpgvMx7nIUb8fjxpCTecfxML0TL8LBoeJ33
         DrYvnlNcerIQfk7Ocg7SpyKvv+3WmhBXf5bPrv+IBVkAbA8R12YerfS6PYoUOrrv+Zh6
         Gj3r7pwrk+0pFnttOdkWmeWNG1uOx0w/C/S8fUvZaINdY98wKoAB+nljIfOblvHTaXk0
         KvT8QfQG7PgH77RvmAO3XppeoY3yTjHPj/lh1S0pBr9g66SraGkcEQNr6B/0pBhxe1Oj
         I3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678149796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1a5tKSoT3CRUkx8kOsCuehNatDTvNV1swkY9ybSMA0=;
        b=dKAK4wVARWrn1yufAasNNCF4LVs2ueeo9A3qjfWeE7L203D4kpp2pI3ynLr01Gxl5M
         40vdOrehbDMZgi404P9UJafBbH2EA6K+Ap6Y3c2Ha35fiNKLIwvYTmnLhRd3v1aaMJ83
         p1Tr9Zto4xBcB401qDdk5Of2nZSGkDh3wBOTDecsudUVYb5JN7Eq88bwSa+okZ1EIm/x
         MjW/NsgqzRRzhpuYWl7OXBcBiRD7IHVk7GgfMSwnRJo4B36ZKkn7ph0VWhWCfVmQnnbF
         HEW7fMcuFu/7NHCpiW7ikGNLRAzPM7fca51MmOGO4aroXBse/6OqwBeBOEIq8msykQzY
         uEJw==
X-Gm-Message-State: AO0yUKVMOMhXn4cfC4I6ueekExU9k5XsqstDQVOKOSI6dmYxiltOMkhJ
        0lZMEGareUuO8gJZ1j3dq+Nkfg==
X-Google-Smtp-Source: AK7set+hGETrhQYWzuysBxnwZr9OAedNAj7RirXRL1R8YH+iYqUBPuuInFSPh5Jc0WyEozFraXwlCQ==
X-Received: by 2002:a05:6e02:c03:b0:318:a732:2b6f with SMTP id d3-20020a056e020c0300b00318a7322b6fmr8136541ile.20.1678149795744;
        Mon, 06 Mar 2023 16:43:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f5-20020a056e020c6500b0031593c8861asm3283602ilj.50.2023.03.06.16.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 16:43:15 -0800 (PST)
Date:   Mon, 6 Mar 2023 19:43:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/8] ahead-behind: parse tip references
Message-ID: <ZAaIojLkjw3hHGm+@nand.local>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <08fc0710017d4b6178a8c5772e0f15fc69c84ad6.1678111599.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08fc0710017d4b6178a8c5772e0f15fc69c84ad6.1678111599.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2023 at 02:06:32PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
>
> Before implementing the logic to compute the ahead/behind counts, parse
> the unknown options as commits and place them in a string_list.
>
> Be sure to error out when the reference is not found.
>
> Co-authored-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

This all looks reasonable (and forging my S-o-b here and elsewhere
throughout this series is all fine). I have seen most of this code
before at least in its final state, but the intermediate bits are new to
me.

And they all look fine and familiar, except...

> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/ahead-behind.c  | 39 +++++++++++++++++++++++++++++++++++++++
>  t/t4218-ahead-behind.sh | 10 ++++++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/builtin/ahead-behind.c b/builtin/ahead-behind.c
> index a56cc565def..c1212cc8d46 100644
> --- a/builtin/ahead-behind.c
> +++ b/builtin/ahead-behind.c
> @@ -1,16 +1,31 @@
>  #include "builtin.h"
>  #include "parse-options.h"
>  #include "config.h"
> +#include "commit.h"
>
>  static const char * const ahead_behind_usage[] = {
>  	N_("git ahead-behind --base=<ref> [ --stdin | <revs> ]"),
>  	NULL
>  };
>
> +static int handle_arg(struct string_list *tips, const char *arg)
> +{
> +	struct string_list_item *item;
> +	struct commit *c = lookup_commit_reference_by_name(arg);
> +
> +	if (!c)
> +		return error(_("could not resolve '%s'"), arg);
> +
> +	item = string_list_append(tips, arg);
> +	item->util = c;
> +	return 0;
> +}
> +
>  int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
>  {
>  	const char *base_ref = NULL;
>  	int from_stdin = 0;
> +	struct string_list tips = STRING_LIST_INIT_DUP;
>
>  	struct option ahead_behind_opts[] = {
>  		OPT_STRING('b', "base", &base_ref, N_("base"), N_("base reference to process")),
> @@ -26,5 +41,29 @@ int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
>
>  	git_config(git_default_config, NULL);
>
> +	if (from_stdin) {
> +		struct strbuf line = STRBUF_INIT;
> +
> +		while (strbuf_getline(&line, stdin) != EOF) {
> +			if (!line.len)
> +				break;
> +
> +			if (handle_arg(&tips, line.buf))
> +				return 1;
> +		}
> +
> +		strbuf_release(&line);
> +	} else {
> +		int i;
> +		for (i = 0; i < argc; ++i) {
> +			if (handle_arg(&tips, argv[i]))
> +				return 1;
> +		}
> +	}
> +
> +	/* Early return for no tips. */
> +	if (!tips.nr)
> +		return 0;
> +

...are we missing a call to `string_list_clear()` here on `&tips`?

Thanks,
Taylor
