Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47B861F404
	for <e@80x24.org>; Fri,  9 Feb 2018 18:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbeBISgX (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 13:36:23 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34263 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeBISgW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 13:36:22 -0500
Received: by mail-wr0-f195.google.com with SMTP id j19so2852257wre.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 10:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gGR/MV1a++qQpnhNP2FH4i2D/yH6qLe1Jtv6QE+UeD0=;
        b=QuZydxt1ebvV0nMmZW7momcUjvIah5Ua/sINwVSFMljiaLRP2w627QY15z/F4dfpAi
         1kXh7FcIFRn6/c01N6cGEuyxFdArlB+ztOfhou71X1falSJz2P0iDd0R4cm7Lbw14pBv
         12ZrJxoj86DHgZ5sOvVaeg3QwRjjg3eAORRdjT/pEqX4qD1Lr7xwrUM4TDaohdQdKssm
         XAOhyA5kocoEAQx5TUiwtwAtZcc9K0Kp26EZE2+4afu1avyBp1bWegeID2lEvpjsI7k/
         aGepve0GFrnlZPCRhOgzPDdpdOT7vEpnW1pH0G3q2lsNZVvNDa/eiVR/arGELwXV+wfI
         BhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gGR/MV1a++qQpnhNP2FH4i2D/yH6qLe1Jtv6QE+UeD0=;
        b=U0Ar3ABAxEegpmJM5jwg9mfjyuee8r4JrF703fYLiCVmFBbluxkuYhEILXLyK42g72
         7W/nPZXmQCBVAD7qb1iOfqEsxEJRdTMIHpaIOFSJ691qtYtItLbvvjEuRQvzMuVtFH/E
         odv9nBpDvSbyGs2020yv8Rrb2Mnen1gwhzh24EWzf3nFpDjBimRO9JJTNVD7dpoo7GNr
         3pHEmxPx1wu525gTvBDDtmCpEY2xNvT5jctu4YTk5yI/+OIFWxzD9xzDS4oAWAJ5llqx
         D31vfTTIqV63KzikyT70oFxt4H2/WZ8ds3jOuzmt5Qp8IUmPsPa6exHIPUEGDd81TiB8
         wiag==
X-Gm-Message-State: APf1xPCh8RBMAjkX5NUIjwFe8ztPzRyUafltLhemiB9zfiEcgCtCI+x6
        TyvuQXtynH0K8IGBhbqeseUm/Z5m
X-Google-Smtp-Source: AH8x226xucbgLdMKyYmnYU/ksyHl1HNn43w/6I75SOcUW/fkmcJEz+39pCFlF0G1LVfxusQcSBGjVQ==
X-Received: by 10.223.171.67 with SMTP id r3mr2959287wrc.80.1518201380690;
        Fri, 09 Feb 2018 10:36:20 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 39sm3320390wrz.85.2018.02.09.10.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 10:36:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/3] t: teach 'test_must_fail' to save the command's stderr to a file
References: <20180209024235.3431-1-szeder.dev@gmail.com>
        <20180209024235.3431-3-szeder.dev@gmail.com>
        <20180209142131.GA18701@sigill.intra.peff.net>
Date:   Fri, 09 Feb 2018 10:36:19 -0800
In-Reply-To: <20180209142131.GA18701@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 9 Feb 2018 09:21:31 -0500")
Message-ID: <xmqqd11exb6k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   2. The "-x" problems aren't specific to test_must_fail at all. They're
>      a general issue with shell functions.
>
> I'm not entirely happy with saying "if you want to use -x, please use
> bash". But given that it actually solves the problems everywhere with no
> further effort, is it really that bad a solution?
>
> For the error messages from test_must_fail, could we go in the same
> direction, and send them to descriptor 4 rather than 2? We've already
> staked out descriptor 4 as something magical that must be left alone
> (see 9be795fb). If we can rely on that, then it becomes a convenient way
> for functions to make sure their output is going to the script's stderr.

That sounds clever and rather attractive.  It isn't that much of an
layering violation for test-lib-functions.sh::test_must_fail to have
such an intimate knowledge on how test_-lib.sh::test_eval_ sets up
the file descriptors, either.

