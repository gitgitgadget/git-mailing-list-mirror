Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41AB11F404
	for <e@80x24.org>; Thu, 22 Feb 2018 20:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751165AbeBVUSs (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 15:18:48 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39121 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbeBVUSr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 15:18:47 -0500
Received: by mail-wr0-f194.google.com with SMTP id w77so11842307wrc.6
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 12:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iJo61SUHqO4yVB5hegx8NFnfxX6MOM/uglqx9cbxd9A=;
        b=f+R467v28b1wINzpdnoRzDQCgKZAZQOeLzRrkee83YJEFIyENh5xbRQ+fypiHkV9ep
         g1P3nWaRbvZmO3mqXBPXO/oM8WwZ0Pxqt8Zm//kxuty0YyKwyJ4iaGOGyCn5DEKp6Gsr
         11x73MK0PRysSdbVdwRtMIT5wt4mXdI/lgGebH5InX0BvUWUkpxt4jI/bIvXLXirEOHk
         SHqio/DT31mxq3nTFZX/2AGBjzlXmCcMufz0KFhngteSPG4la2lWB8cmLqpoGXAZEWfd
         JMVqSBgV0q4UN65DNj8sMH3CvUOt0Rc5quwcGDiMEiGU7STvs+Uv9kHMkm/pEUjZCiTW
         lKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iJo61SUHqO4yVB5hegx8NFnfxX6MOM/uglqx9cbxd9A=;
        b=TnCLtUlm81+ZkGFVhI39mIlN7zL1u2AWxdxGu+isMRNpYl8krFOmb1hQ31LPJ/r7q9
         kqZNHCQb+XW3ggcUu2/Rgol5ykCdpmiUfhMCNS/qFWxQxQ1RhFYN00DHPPutkhIgclbb
         KMIF2WzumZKtq+gvUPqZ1IDHHIY/TStMVnzT0Sz5DsWOaAqoR5E6xNZdV1gG23Znta/z
         bQk0rWVl4zXhCap9sjxwEpVbJnHcLQGJdbSOz/CeW0lTpAr4zifdZ/WBIMj+wot7K9nn
         ACtSAYP/bBVNVOaFqF/DY7ISjcg+j7Wo9EDm3XTTdIHhrJxJibsp0yfHmFOpUF5jOH3e
         FoKg==
X-Gm-Message-State: APf1xPApYVPkXENVpTwb4jHyplDXc4GoC8mj5Z6Te1PiO7V4B64UD1jY
        w3afGawrfdJu/FEQ5nG2MFU=
X-Google-Smtp-Source: AH8x225R4xAWfm09IfwNSvlwM5X3H81EMGOjhH9bctJipRhEgfWPjBMlcSW2zc902ThvkOjU8gVcEQ==
X-Received: by 10.223.178.206 with SMTP id g72mr7028517wrd.135.1519330725740;
        Thu, 22 Feb 2018 12:18:45 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c7sm956812wrh.18.2018.02.22.12.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 12:18:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] t: send verbose test-helper output to fd 4
References: <20180222064836.GA10719@sigill.intra.peff.net>
Date:   Thu, 22 Feb 2018 12:18:44 -0800
In-Reply-To: <20180222064836.GA10719@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 22 Feb 2018 01:48:37 -0500")
Message-ID: <xmqq371swzff.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is a repost of the two patches from:
>
>   https://public-inbox.org/git/20180209185710.GA23403@sigill.intra.peff.net/
>
> (now just one patch, since sg/test-i18ngrep graduated and we can do it
> all in one step). The idea got positive feedback, but nobody commented
> on patches and I didn't see them in "What's cooking".

Thanks for clearly explaining the change.  Will queue.
