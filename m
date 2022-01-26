Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BDFC433EF
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 20:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiAZUxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 15:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiAZUxa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 15:53:30 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EA7C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 12:53:30 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id e79so1077944iof.13
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 12:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oQP+9y5VeSVZ3+iO87JUtfQcrf/DEucm7H78Yygt/Nw=;
        b=WfHIsIIHW51++C3+kVk9D/MetIAlW76P4iAvFE73TO1ujA9ZXqk3bpA4HP5ox17x/S
         hS8YT3rEHNKyYv6oq/+7aOVstGU94v06WgErPEqDizRDakn2M33/oMST7P2opb0u1TzM
         St/m/ZUxo8NnluXNoDDDmZLlaS28/cLlV2DmiiSHDwZmSFhfqPTnyBEWOJn3m/hNUeFj
         O05IPvwA7vnzf1LKyXACABeBsxcWcGlUaZgxIrzbeJdx1iqA+vquPsReFm9pLRsPEXTr
         M2NP9/6Brk29L9vhNo1qkB5OBZqYgXRXwNgB1qKlryfbGgje4bR56r0LLosX7ZEteEWN
         ltNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oQP+9y5VeSVZ3+iO87JUtfQcrf/DEucm7H78Yygt/Nw=;
        b=D6AvjjDe4R0q28aMJeJJfrP1vBSF/Qjt7bhqOh6iR9mNRcMqUgbHR0CyZxIGFMcmdY
         a/bTMQ0NBRuN7Pw793ee+hIbQzdXuvwEJR05g9wvDRQ9klEcramF4Z1ElJdg+vrmKT/L
         YkJnxBAm73BdFFa2knWCq5mJvzWiO7GSPrFrt8PtKX1nJvdgRA+G7isoLP8yHiR3Mi2W
         xui7RPqYCULUqsp1jfKrtcFKVrYSzxvYm8wXbb/DQgEfNNeNc72TAtqhoV1z+zyYOhH5
         BDWs1G4ba2u0lf/LnhMkZrylPcSkoSM4Oj0ESZuvsbzeM0h/U/yO7zPPCe3gPze2BGNu
         GV3A==
X-Gm-Message-State: AOAM532EvWEAcxIrif0XEZxRa59fhx8nvMd9ZMxsGBCEAMuYnqSJw7yY
        Q7DmmZrpADXFDQ3ZEgp6+LG6Xg==
X-Google-Smtp-Source: ABdhPJzmztG2cjnMizPx1fbIVGQg7xQGvy9ViPWnq4557xKWLGO61GOH7pTdHndlHeqyjcT8ckTncQ==
X-Received: by 2002:a6b:4406:: with SMTP id r6mr221656ioa.57.1643230409922;
        Wed, 26 Jan 2022 12:53:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h16sm1775728ilj.13.2022.01.26.12.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 12:53:29 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:53:29 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] scalar: accept -C and -c options before the subcommand
Message-ID: <YfG0ybYOCwDzlbi5@nand.local>
References: <pull.1130.git.1643195729608.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1130.git.1643195729608.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 11:15:29AM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `git` executable has these two very useful options:
>
> -C <directory>:
> 	switch to the specified directory before performing any actions
>
> -c <key>=<value>:
> 	temporarily configure this setting for the duration of the
> 	specified scalar subcommand
>
> With this commit, we teach the `scalar` executable the same trick.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     scalar: accept -C and -c options
>
>     This makes the scalar command a bit more handy by offering the same -c
>     <key>=<value> and -C <directory> options as the git command.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1130%2Fdscho%2Fscalar-c-and-C-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1130/dscho/scalar-c-and-C-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1130
>
>  contrib/scalar/scalar.c   | 22 +++++++++++++++++++++-
>  contrib/scalar/scalar.txt | 10 ++++++++++
>  2 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> index 1ce9c2b00e8..7db2a97416e 100644
> --- a/contrib/scalar/scalar.c
> +++ b/contrib/scalar/scalar.c
> @@ -808,6 +808,25 @@ int cmd_main(int argc, const char **argv)
>  	struct strbuf scalar_usage = STRBUF_INIT;
>  	int i;
>
> +	while (argc > 1 && *argv[1] == '-') {
> +		if (!strcmp(argv[1], "-C")) {
> +			if (argc < 3)
> +				die(_("-C requires a <directory>"));
> +			if (chdir(argv[2]) < 0)
> +				die_errno(_("could not change to '%s'"),
> +					  argv[2]);
> +			argc -= 2;
> +			argv += 2;
> +		} else if (!strcmp(argv[1], "-c")) {
> +			if (argc < 3)
> +				die(_("-c requires a <key>=<value> argument"));
> +			git_config_push_parameter(argv[2]);
> +			argc -= 2;
> +			argv += 2;
> +		} else
> +			break;
> +	}
> +

All looks right to me based on a cursory scan. It's too bad that we have
to copy this code from git.c::handle_options().

Could we call handle_options() (assuming that it was available to
Scalar's compilation unit) instead? I'm not sure if that's a naive
question or not, but it might be nice to explain it out in the commit
message in case other reviewers have the same question that I did.

On a more practical note: is there an easy way to test this? Like I
said, I'm not necessarily worried about the code you wrote, just that it
seems like this sort of thing *should* be easy enough to test. It's fine
if there isn't, too, but again as somebody new to this area some
explanation would be helpful.

Thanks,
Taylor
