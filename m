Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 176ED1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 20:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbeJWE6p (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 00:58:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43554 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeJWE6o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 00:58:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so39239406eds.10
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=nrKOSEkFrkMva0S744G4M6MnT/4N7hvsjEqGBR1htMU=;
        b=tEa6z1jhSFhUYt/EyQxDtvlXOsSMCeUDlTQQFxFn6wanjLf/0gdt4js/hphr83N6Az
         o+1kB+cROTm3MeHryG04bZKwTb41FRodyx2xm1SBDWSJPOtRCRHjmcymvtISme3jdiEG
         u5IU/q41oylgTqeCTri9Bh5P8WnjQTLTayBT1TJv7nqI5U3rinGMTC57hFCc9/BWk3vS
         t1ghZB0vA1yr0hzLF/6Q6HglM5qA4YF5HM7Gfld7rSbIk+xERhRC0W6WBXWl7WxDJoRZ
         qxyijb7XMztBUFePGzAWHeiupfVV0QdGnzIb+yq87mwAZLgTV6H04Ikbvv8To6ztLXjr
         4Glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=nrKOSEkFrkMva0S744G4M6MnT/4N7hvsjEqGBR1htMU=;
        b=OK9po0no+ffqIdb9Z7FEEpPTLeA6WqtlDgUyMQUHBH9ugb7siid1Pza70pjWnzZLql
         d8g4uAT461MIjJT5jYFspO7hJsN9o12WjXFu1CyY903wT8MTtugepTGeX0klRujvmdMU
         PEExKAhlLL8db8fHGXyB1g/EU2cfWZ0DBR0AK2r0fKQLog7hpGWSCKOd77mMZ2XuGgkK
         knU1xgPlnwHhU+pv8qv6gJQo1ZC/dMD5DQMraGE/bWT3MFFdPVnxCwZH//+jztvK/WMM
         cNEP/t4a6PexIB8Tm55xATb8dIUtQcs3sEh4OIjm8Lcw+lcYSGQ32H4PMn5Be5KllrE9
         2paQ==
X-Gm-Message-State: ABuFfoh34K/GeOkm4PolFWbwSESumgDft/UB3DPrdHP+h2X8CJKnpFxV
        9U7QtPBv4ic7W7dRt/0B62gGAK7L
X-Google-Smtp-Source: ACcGV61qtUcCzyNvAPulf7elbwBBEOxMDXqCalZ+BqIBHjsvCxOYVZMp59fKGtTAtvywPLO2+p01aA==
X-Received: by 2002:a17:906:1044:: with SMTP id j4-v6mr35557279ejj.75.1540240720114;
        Mon, 22 Oct 2018 13:38:40 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id b36-v6sm13836360ede.11.2018.10.22.13.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 13:38:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/8] gettext: don't poison if GIT_GETTEXT_POISON is set but empty
References: <20181022153633.31757-1-pclouds@gmail.com> <20181022202241.18629-1-szeder.dev@gmail.com> <20181022202241.18629-3-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181022202241.18629-3-szeder.dev@gmail.com>
Date:   Mon, 22 Oct 2018 22:38:36 +0200
Message-ID: <87a7n5d8dv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 22 2018, SZEDER Gábor wrote:

> This allows us to run test with non-GETTEXT POISON-ed behavior even in
> a GETTEXT POISON build by running:
>
>   GIT_GETTEXT_POISON= ./t1234-foo.sh
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  Makefile  | 2 +-
>  gettext.c | 9 +++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index ad880d1fc5..7a165445cd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -365,7 +365,7 @@ all::
>  # Define GETTEXT_POISON if you are debugging the choice of strings marked
>  # for translation.  In a GETTEXT_POISON build, you can turn all strings marked
>  # for translation into gibberish by setting the GIT_GETTEXT_POISON variable
> -# (to any value) in your environment.
> +# to a non-empty value in your environment.
>  #
>  # Define JSMIN to point to JavaScript minifier that functions as
>  # a filter to have gitweb.js minified.
> diff --git a/gettext.c b/gettext.c
> index 7272771c8e..a9509a5df3 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -50,8 +50,13 @@ const char *get_preferred_languages(void)
>  int use_gettext_poison(void)
>  {
>  	static int poison_requested = -1;
> -	if (poison_requested == -1)
> -		poison_requested = getenv("GIT_GETTEXT_POISON") ? 1 : 0;
> +	if (poison_requested == -1) {
> +		const char *v = getenv("GIT_GETTEXT_POISON");
> +		if (v && *v)
> +			poison_requested = 1;
> +		else
> +			poison_requested = 0;
> +	}
>  	return poison_requested;
>  }
>  #endif

Fixing this is good. But when the initial support for conditional runs
was added in 309552295a ("i18n: do not poison translations unless
GIT_GETTEXT_POISON envvar is set", 2011-02-22) we didn't have the
convention of using git_env_bool() for these, which a few recent
follow-up patches have also done.

So let's just use git_env_bool() here. It's less code, and consistent
with the rest. See 4c2db93807 ("read-cache.c: make $GIT_TEST_SPLIT_INDEX
boolean", 2018-04-14). Also makes sense to document this in the "Running
tests with special setups" setup that patch added.
