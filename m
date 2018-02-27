Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E82D31F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeB0VDr (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:03:47 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38548 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbeB0VDq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:03:46 -0500
Received: by mail-wm0-f67.google.com with SMTP id z9so1148498wmb.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 13:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=sUERdREaVTuLjddA15RNEr4IjMIOvdV1D8X8e8Rrb3g=;
        b=KBUwOW0yUNmvtmEAtlJCsYN8weQfRYC5+7coSwsAEeHw3xa9rfQZnE9etAZH9lMpUU
         IpcbppJzYQlOHEO7/o3p/jbdEbGfdEhpqnlY2VE0diyenPnmTuWIGuKLwm6FzV8r2nLW
         RXOhhUKDZA13kweI6zTIQt255VlRI7sZh4T2/axM+BXJExeoNxWN66knOzr0hKBSfx+e
         g83pYbZcI8YQ3LJzG8JhQnjZs/9TxcL4SFl4T7ggvRG5Q4EjGa7y9H2tKu7vql+kIKVs
         yZy2ix4fRZK9q5yWreAqSnnzC2UxqTKGo/0VqvMltsJlVPK+Ie40MYxnIOqBBsICZVCu
         Da9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=sUERdREaVTuLjddA15RNEr4IjMIOvdV1D8X8e8Rrb3g=;
        b=WBPFgRM6rPlWUUI2pbGlhlcTi6tkEjEqRQp64H2CrS8iWtmS4sN+ctHml8iHikW2gE
         A731kHkkwXLcHpVn37LXRFyz0pNfTjJnotALqmrn8N10uroWC9X78KnwdPXS50KxkERL
         cwJ/edXBaMextbMHdkXF4/coPxxI1qXpfVtZB4p0ByOXUUs9Ugq/Xga6TS6WKiBXUZx5
         36OSlb8kFxjPhgZ9J+SXbIsNhRJp580cBDmjjB84c9gB8URpc/jB4VK9V8gC1pdjACr+
         4LUdM3uTh7glfJ2+TWvFwLf2F3YfTjV+OazxpAZUyrK1Zg9hk24VAdzmV7FfwsG0+67p
         opvQ==
X-Gm-Message-State: APf1xPCFc+Gr5/+ze7j2u1wd7SUvGftqDgQVfmd+uF7KPGLngN1Gu92Y
        2LGYCVJeg1/XTd8XyLrGhp0=
X-Google-Smtp-Source: AG47ELtkUCI9DDyJGQNin+iDL/SYCVOhidBblJZ3sPEvWorC78Ml88c57Psrc5XQLDhYy0yxVv7rwA==
X-Received: by 10.28.15.4 with SMTP id 4mr3300829wmp.33.1519765424527;
        Tue, 27 Feb 2018 13:03:44 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t4sm459540wmt.16.2018.02.27.13.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 13:03:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/11] t3030-merge-recursive: don't check the stderr of a subshell
References: <20180223233951.11154-1-szeder.dev@gmail.com>
        <20180223233951.11154-5-szeder.dev@gmail.com>
Date:   Tue, 27 Feb 2018 13:03:42 -0800
In-Reply-To: <20180223233951.11154-5-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Sat, 24 Feb 2018 00:39:44 +0100")
Message-ID: <xmqqtvu2p2kx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> The two test checking 'git mmerge-recursive' in an empty worktree in
> ...
>  		GIT_INDEX_FILE="$PWD/ours-has-rename-index" &&
>  		export GIT_INDEX_FILE &&
>  		mkdir "$GIT_WORK_TREE" &&
> -		git read-tree -i -m $c7 &&
> -		git update-index --ignore-missing --refresh &&
> -		git merge-recursive $c0 -- $c7 $c3 &&
> -		git ls-files -s >actual-files
> -	) 2>actual-err &&
> -	>expected-err &&
> +		git read-tree -i -m $c7 2>actual-err &&
> +		test_must_be_empty expected-err &&
> +		git update-index --ignore-missing --refresh 2>actual-err &&
> +		test_must_be_empty expected-err &&
> +		git merge-recursive $c0 -- $c7 $c3 2>actual-err &&
> +		test_must_be_empty expected-err &&
> +		git ls-files -s >actual-files 2>actual-err &&
> +		test_must_be_empty expected-err

Where do the contents of all of these expected-err files come from?
Should all of the test_must_be_empty checks be checking actual-err
instead?

