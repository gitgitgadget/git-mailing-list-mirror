Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A7AC4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 11:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiLSLEa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 06:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiLSLE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 06:04:27 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2871D9FF6
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 03:04:26 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vv4so20620299ejc.2
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 03:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJrGHJUxI+ENbH+1VaWjbfNmBiq1iZmn/HlqT3hpjZg=;
        b=lMULT3BwbMTm5E3l4L6PJhLWiS9deQjMVECjtMZNSt7QRxBKvhP2h/I3LdcbXreLqT
         Sl57I5LCxFjp4Gb22y+mvraWwIYker2o71Y2yn2MmQYFSyTo7aVMwjxacwRjcklVfEpF
         vD2OLMGEZGidwna8xY6vLkpH1My5+JsFSsnxgbcowEdoun1mYkUBKvVwQ5fd1WwUHQMw
         gd009ZzvV/DSPlSgRyBTvJ99DJM/ErvIWGRh5evMpYrzUeqRrVA9ZjJePxUlyq9BADQ/
         Mghi2nx70SSvhySa61T56gxxooZlM16zyNFn1CrejEpjMeRdQdm3dq5T65vrtPR2L+as
         zq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJrGHJUxI+ENbH+1VaWjbfNmBiq1iZmn/HlqT3hpjZg=;
        b=DqRUnk8s672HuRKJ0yrzK+yk4gfj/hBh5zWOwBtjF9KDzZauqsI6VDmxgPITGb9h6e
         gDq7r6vPXZn4igyHlagZqyX1R0qwUPND5dQ8unkpdR3JeWr7LJGtdrqTdHZ0j1C8Ye2G
         NjiZRsW5IegpAh9Y263Rida1D+C+Tmw+qj3ii590lgmiVmBT9+d97b939isLrVaY4Xaa
         otbpS1hZlvd0Jc5WpyWp9J30Y5qnD+ABO0XpNv/379YtcTtsUknC2bL+kauXhADm2ILT
         sGTMTYtF8FMAhDEazHSxNMBwsEs0IQx7SGPDUw8VgIm/32yzUYGe46v32E3TrtA7LbcV
         Gkkg==
X-Gm-Message-State: ANoB5pl1YqY4OqA2VVOtl+VCF1TE7/jFTcO10QFwcfEZZFr//q+65DSj
        RUVBT0okeBcHRvTWnqiWDkk=
X-Google-Smtp-Source: AA0mqf5goQJwDr7+fdFHf+T2/2HHSOqcgASaJMBEwINY3iLfoUYHPSwZs0J4O6sDNqodRGlvTzc9mg==
X-Received: by 2002:a17:906:351b:b0:7c0:a6a9:64e9 with SMTP id r27-20020a170906351b00b007c0a6a964e9mr46736500eja.36.1671447864557;
        Mon, 19 Dec 2022 03:04:24 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id wi18-20020a170906fd5200b007c0ae137404sm4279571ejb.97.2022.12.19.03.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 03:04:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7DwV-006Y2n-12;
        Mon, 19 Dec 2022 12:04:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, vdye@github.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/3] bundle-uri: drop unused 'uri' parameter
Date:   Mon, 19 Dec 2022 11:57:17 +0100
References: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
 <d17f08ed4b68d711b452b5cfb54a949845bdea81.1670866407.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <d17f08ed4b68d711b452b5cfb54a949845bdea81.1670866407.git.gitgitgadget@gmail.com>
Message-ID: <221219.86tu1rzmbs.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 12 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The 'uri' parameter of fetch_bundle_list() was added early in
> development, but is not required since the 'list' parameter includes a
> 'baseURI' member. Remove the 'uri' parameter and make this expectation
> explicit.

Makes sense, and this is a straightforward commit, but...

> diff --git a/bundle-uri.h b/bundle-uri.h
> index b2c9c160a52..29b0c98ee65 100644
> --- a/bundle-uri.h
> +++ b/bundle-uri.h
> @@ -68,8 +68,8 @@ struct bundle_list {
>  	 * In the case of the 'bundle-uri' protocol v2 command, the base
>  	 * URI is the URI of the Git remote.
>  	 *
> -	 * Otherewise, the bundle list was downloaded over HTTP from some
> -	 * known URI.
> +	 * Otherwise, the bundle list was downloaded over HTTP from some
> +	 * known URI. 'baseURI' is set to that value.

...here we have a stray typo fix, not called out in the commit
message. I think that can pass, but if you're re-rolling I think any
such "while-at-it" would be better split into their own commits.

But more importantly:

>  	 *
>  	 * The baseURI is used as the base for any relative URIs
>  	 * advertised by the bundle list at that location.
> @@ -112,10 +112,10 @@ int fetch_bundle_uri(struct repository *r, const char *uri);
>   * bundle-uri protocol v2 verb) at the given uri, fetch and unbundle the
>   * bundles according to the bundle strategy of that list.
>   *
> - * Returns non-zero if no bundle information is found at the given 'uri'.
> + * It is expected that the given 'list' is initialized, including its
> + * 'baseURI' value

At first sight this seems like a regression. Why have we stopped
documenting the exit code?

But looking again is this because in 7cc47a980ac (bundle-uri: download
bundles from an advertised list, 2022-12-05) you accidentally
copy/pasted the documentation for fetch_bundle_uri(), and this was never
applicable to this function?

Even then, not documenting the code we return now is a regression. If it
was wrong before, let's make it correct, not stop discussing it
entirely.

In either case this is another while-at-it entirely unrelated to the
$subject here of dropping an unused parameter.

The same goes for the added docs, that we "expect [that] 'list' is
initialized" may be true, but that would have been true before we
removed this unused parameter, so let's not stick that in this unrelated
"UNUSED" change.

>   */
>  int fetch_bundle_list(struct repository *r,
> -		      const char *uri,
>  		      struct bundle_list *list);
>  
>  /**

