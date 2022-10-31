Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02C0ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 20:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiJaUv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 16:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJaUv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 16:51:28 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8561035
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 13:51:26 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kt23so32416756ejc.7
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 13:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bRTPjZO5BM9gLG+8HeeiKI3H0/rhguA/E8f5QMogsco=;
        b=PnyCL55NiftfDXKDeg0TwF99Zyh1PsvO4GpV2cDbALEZk29IS/7AfdHhfDPSb6N8wq
         1l2Glw6RAee2ZarSGY0R6FagnegIf2/F/eOlN7cwQtvNB07u/dl0UZAeYyFMN0zg8qOG
         912uI05opyCIbS7nrSUZtmG9MtAJFmwfGK/45R7054B/+qn8U5JJmjmC6qVIcV6xuPwH
         ByALThEfl0hD9gyhzB4di6V2E6/Yv+ImC7lEGWBCp1FzNEcjBytNR7jyEu9D8OQAvFoA
         i5NB2iBbI8ecQZewCp+PR2H5tHdeiTJsM0J0QcGQ7KKk6cPTL4b5TdAcsEPli8GG7nWT
         CFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRTPjZO5BM9gLG+8HeeiKI3H0/rhguA/E8f5QMogsco=;
        b=vDJII9eZtWnETVXqtOorMsV1eApzCpEYJpOGncdSU2nv9kIHKdY/CdepeDY6FIVftE
         0XppQG5azd3uypXNAwowiRYftbIxBWco/vnSXy84wx2PQ+GS6pgFq7pSTY1wS6yyIQsw
         0H/M6L+9OCj5+3gygvbkElCSo+S2AVPLJfXAv0fIuF0xTxmWMoVIccT0EjrN0nknDGTv
         c/1rYAkAlan1UKltVHpwktawacQXyME5JdzGDFY30DZG5EwJjbathj01jrhN39YXvFeS
         YyA7XE5AjN8yw+Qntl7nRGBMij9lLgl8QUv4W2otuyt7wOyLtxMjtCEMxz6GMyaScAox
         UHxA==
X-Gm-Message-State: ACrzQf058qgClplHx99fPDlXxV0WmcWo6TVmJNEfUo4aWDyaVqZgf4uV
        x/wCVrU626+mW2c19lXNhLk=
X-Google-Smtp-Source: AMsMyM4wo/4vkzykYAUq5GMb2ZtoYjst2TE65/xkTiBau7QGz1cQMzODIUVx0xVnRNEFR7dmVbHVVQ==
X-Received: by 2002:a17:907:970b:b0:78d:8d70:e4e8 with SMTP id jg11-20020a170907970b00b0078d8d70e4e8mr14210941ejc.614.1667249485116;
        Mon, 31 Oct 2022 13:51:25 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b7-20020a17090630c700b0078df26efb7dsm3378008ejb.107.2022.10.31.13.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:51:24 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opbki-00AqGv-0N;
        Mon, 31 Oct 2022 21:51:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t5516/t5601: avoid using `localhost` for failing
 HTTPS requests
Date:   Mon, 31 Oct 2022 21:49:55 +0100
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <25cc0f6d91a9d23eb1b755e1463d672e4958a4e9.1667245639.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <25cc0f6d91a9d23eb1b755e1463d672e4958a4e9.1667245639.git.gitgitgadget@gmail.com>
Message-ID: <221031.86v8nz67jn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 31 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 6dcbdc0d6616 (remote: create fetch.credentialsInUrl config,
> 2022-06-06), we added four test cases that validate various behavior
> around passing credentials as part of the URL (which is considered
> unsafe in general).
>
> These tests do not _actually_ try to connect anywhere, but have to use
> the https:// protocol in order to validate the intended code paths.
>
> However, using `localhost` for such a connection causes several
> problems:
>
> - There might be a web server running on localhost, and we do not
>   actually want to connect to that.
>
> - The DNS resolver, or the local firewall, might take a substantial
>   amount of time (or forever, whichever comes first) to fail to connect,
>   slowing down the test cases unnecessarily.
>
> Let's instead use an IPv4 address that is guaranteed never to offer a
> web server: 224.0.0.1 (which is part of the IP multicast range).
>
> Incidentally, this seems to fix an issue where the tests fail in the
> Windows jobs of Git's CI builds.
> [...]
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 45f0803ed4d..0b386c74818 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -72,19 +72,19 @@ test_expect_success 'clone respects GIT_WORK_TREE' '
>  '
>  
>  test_expect_success LIBCURL 'clone warns or fails when using username:password' '
> -	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
> -	test_must_fail git -c transfer.credentialsInUrl=allow clone https://username:password@localhost attempt1 2>err &&
> +	message="URL '\''https://username:<redacted>@224.0.0.1/'\'' uses plaintext credentials" &&
> +	test_must_fail git -c transfer.credentialsInUrl=allow clone https://username:password@224.0.0.1 attempt1 2>err &&
>  	! grep "$message" err &&
>  
> -	test_must_fail git -c transfer.credentialsInUrl=warn clone https://username:password@localhost attempt2 2>err &&
> +	test_must_fail git -c transfer.credentialsInUrl=warn clone https://username:password@224.0.0.1 attempt2 2>err &&
>  	grep "warning: $message" err >warnings &&
>  	test_line_count = 2 warnings &&
>  
> -	test_must_fail git -c transfer.credentialsInUrl=die clone https://username:password@localhost attempt3 2>err &&
> +	test_must_fail git -c transfer.credentialsInUrl=die clone https://username:password@224.0.0.1 attempt3 2>err &&
>  	grep "fatal: $message" err >warnings &&
>  	test_line_count = 1 warnings &&
>  
> -	test_must_fail git -c transfer.credentialsInUrl=die clone https://username:@localhost attempt3 2>err &&
> +	test_must_fail git -c transfer.credentialsInUrl=die clone https://username:@224.0.0.1 attempt3 2>err &&
>  	grep "fatal: $message" err >warnings &&
>  	test_line_count = 1 warnings
>  '

For this one one at least, it eventually gets around to setting up an
actual httpd server with cloning etc. from $HTTPD_URL.

Can't we just do that for both of these tests rather than the the
224.0.0.0 hack? I.e. the root cause is that we're cleverly faking a
not-a-server here, and now we're going to add another somewhat clever
hack on top.

but since the test coverage is for https:// anyway, and we have other
https tests against an actual server...
