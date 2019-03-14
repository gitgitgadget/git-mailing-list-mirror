Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C66F20248
	for <e@80x24.org>; Thu, 14 Mar 2019 02:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfCNCSp (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 22:18:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37310 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfCNCSo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 22:18:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id x10so1151315wmg.2
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 19:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9+NCetJ5FT9jJ0X8mxknHlkj7tGqE6cZnHaUdBIAA8g=;
        b=GHeH/2FTLX4IxhZsB2qud2M3tmOYEiEBkNN0FZ0Y0vsSEFL1LfYdSPfUVHkIpgLYVf
         i43RFiiAXGIdSF93jVDnQrlmLxj++z86kU/GgnB1hSvLYasetM188lVEGO514FuJbTrg
         uEmZ10+r3tFdJcJOR4xmN7mSe6UcvFXNnP1hsEjCU7qPqHf9UYiny/93k6svag1jdg0R
         mbXrrdtHua+lr5DCUvtl1I0a+UhqMFJT38zA34Fab5SqYt3qgezjZ+Vp6B7Xj/cexFMn
         x4jjhdtPcFzRs1XtPq0aYFStdCt0/WdIpEUAOcCVKpO+BqwuYHfP3PXap1OZWvqFqkcP
         eLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=9+NCetJ5FT9jJ0X8mxknHlkj7tGqE6cZnHaUdBIAA8g=;
        b=kcnZMCk0ebRk0rZ2t/onpSZl59lgGdYVdk+XSUQwSPPj3iOZoAIzSONrvh3tl+Gji3
         pM1MujjHR3phaLc2eswm/MRgI5vkD8KO3ZKoXraTvPXiLWPAV5CtPcoSJKmb6HsaOOWx
         BS3Q6ligLeIMRlhoACFn2BQ2wC3PWVBvCUneBpNs9IUCWNHfrFGTNdtaajENw8EO9z9L
         qqo25tYueQN426TFbbvyWvYzdj9w7Pm0t3B6d2szdaYbQCW41Kk8+T1x06mTokgphAAh
         daTdv3+ydH50e6Jn4lbP54131PQWLFFBAeTNnG9Zg/wGVhDXfb3CdH4wrWPHpGCn39Hj
         qxCQ==
X-Gm-Message-State: APjAAAWmUO7QcdFX4Xp4Y8MvTfQQ2CqtAR9ji0qrTaMAmLK2c7Ml+TKu
        /e/U/Gq0c2tLQ1T8twabbeU=
X-Google-Smtp-Source: APXvYqzDu+TTkc4wiqeZPfGN6yqblulX0QQ4+T9dLdw8vfFRM2ttnW3AFeV/KBvK0C4ypLWJxK7PYQ==
X-Received: by 2002:a7b:c7da:: with SMTP id z26mr695136wmk.151.1552529922768;
        Wed, 13 Mar 2019 19:18:42 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o18sm43413346wrg.40.2019.03.13.19.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 19:18:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 01/11] test-lib: fix interrupt handling with 'dash' and '--verbose-log -x'
References: <20190313122419.2210-1-szeder.dev@gmail.com>
        <20190313122419.2210-2-szeder.dev@gmail.com>
Date:   Thu, 14 Mar 2019 11:18:41 +0900
In-Reply-To: <20190313122419.2210-2-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 13 Mar 2019 13:24:09 +0100")
Message-ID: <xmqq1s3aci66.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Putting these together, when a test script run with 'dash' and
> '--verbose-log -x' is interrupted, then 'dash' tries to write the
> trace output from the EXIT trap to the script's original standard
> error, but it very likely can't, because the 'tee' downstream of the
> pipe is interrupted as well.  This causes the shell running the test
> script to die because of SIGPIPE, without running any of the commands
> in the EXIT trap.

So... the clean-up actions do not get a chance to run because the
shell that is going to execute would be killed by SIGPIPE because
tee that is reading from it goes away?

While I like the patch very much, I also wonder if it is possible to
tell tee to not to die upon seeing INT, TERM, etc.  When the shell
upstream of tee exits (after performing clean-up actions), tee that
is reading from it will exit, too, and will not be left behind (I do
not mean to say it that is a better alternative solution---I am just
trying to see if I read the problem correctly from the description
given above).

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 8665b0a9b6..db3875d1e4 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -631,7 +631,10 @@ die () {
>  
>  GIT_EXIT_OK=
>  trap 'die' EXIT
> -trap 'exit $?' INT TERM HUP
> +# Disable '-x' tracing, because with some shells, notably dash, it
> +# prevents running the cleanup commands when a test script run with
> +# '--verbose-log -x' is interrupted.
> +trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
>  
>  # The user-facing functions are loaded from a separate file so that
>  # test_perf subshells can have them too

Thanks.
