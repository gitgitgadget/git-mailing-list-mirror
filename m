Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E802C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 00:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58AF56113C
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 00:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhDTA2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 20:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhDTA2I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 20:28:08 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F33AC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 17:27:38 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id y12so27566023qtx.11
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 17:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gt/M8j2XodEQByduOeLlGNwmUR/rH7ZJlbUFxAXduhc=;
        b=DLCOiY2GqM8D7HGLdLxQ1h/d1AnbtQj6A9Tb472YP0Rby8By/PPAZokgLJTYUW8+lg
         kk2eizTofRgs/eXERKLtvliLcHMJCyo4C4xCA7enLMy2sDjI9C4tn/6NjdMy090t43dS
         KKDIDnIJyhOyZj8LSRQNFKXnsv7LeOFpo2HyxvsyxQHeiMHp/01SkDeiIT9i6C0f33tJ
         YfxwqldIlMCy2GN1/J7ZNWBt9YttRZTdYt10tMTpyV1HSAxJjQw/XoMRb4ekCNqqCbS6
         uGrQq7pnChkTXcjG7puvJ0McEfUZfty/4A3I3FT0FmwleGzBuuONeyfJQqbWbrZ5pLWf
         W8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gt/M8j2XodEQByduOeLlGNwmUR/rH7ZJlbUFxAXduhc=;
        b=IYEgh4kh3E5I3DmYQ5NUF6HuPt4BujSc5SsnIKD9RlILv2vlcKxO9+jHGzW+cYXLmT
         XuvYufUAtio6yZ+nMHvbeHc2Tulkfejtd8BWNtfY3hAYtGTGCoAbIWUOMRVCWvaD9BhH
         sC202kMsu8BMHWW+rXX1FyUT9O/5oZP1lqrSlgzKLH4vKmgCKV1o/U0gkzqHsPeuZH1v
         F5dBeC3JynkP5LsoiXI2YX38QOiu72QjctHv1TViQtNfxfyo1rMI8KQ3T6HMFRi1qNLW
         ZCGtrox7fvZG63huEHaEQ7hxhUBJxwRIevvXNlh/a2ByMK8TWXiP/wX9ht5asS099AqD
         QJtQ==
X-Gm-Message-State: AOAM531c2ggk6G9SontyINVKT58dUB0nj9wooeROuIlngXcPu3hpx6Ex
        3Ms/nrSoOzqsVHi5A9B3Vo5oQ2eg+01rQA0O
X-Google-Smtp-Source: ABdhPJw4UNB7nFi/wvZgR1pLMb2eVxAmVzntla5gShdhFUGiqczRaALgPq5ADBT12TK7dMn9fuc22w==
X-Received: by 2002:ac8:6b49:: with SMTP id x9mr8345001qts.193.1618878457187;
        Mon, 19 Apr 2021 17:27:37 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:6e34:2cc5:33ff:681d])
        by smtp.gmail.com with ESMTPSA id y9sm10677067qkm.19.2021.04.19.17.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 17:27:36 -0700 (PDT)
Date:   Mon, 19 Apr 2021 20:27:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] fast-export: rename --signed-tags='warn' to
 'warn-verbatim'
Message-ID: <YH4f97oreblENi3V@nand.local>
References: <20210419225441.3139048-1-lukeshu@lukeshu.com>
 <20210419225441.3139048-3-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210419225441.3139048-3-lukeshu@lukeshu.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 04:54:40PM -0600, Luke Shumaker wrote:
> From: Luke Shumaker <lukeshu@datawire.io>
>
> But still keep --signed-tags=warn as an undocumented alias.  This name
> is clearer as it has symmetry with warn-strip:
>
>                    action              ->                   action
>        +----------------------------+  ->       +----------------------------+
>   msg? |      verbatim |      strip |  ->  msg? |      verbatim |      strip |
>        |          warn | warn-strip |  ->       | warn-verbatim | warn-strip |
>        +----------------------------+  ->       +----------------------------+

This table is rather confusing to me. What's unclear to me is what
"msg?" and "action" are referring to. After reading your patch, I think
it may be clearer to say:

    The --signed-tags option takes one of five arguments specifying how
    to handle singed tags during export. Among these arguments, strip is
    to warn-strip as verbatim is to warn. (The unmentioned argument is
    'abort', which stops the fast-export process entirely). That is,
    signatures are either stripped or copied verbatim while exporting,
    with or without a warning.

    Make clear that the "warn" option instructs fast-export to copy
    signatures verbatim by matching the pattern (and calling the option
    "warn-verbatim").

    To maintain backwards compatibility, "warn" is still recognized as
    an undocumented alias.

> +test_expect_success 'signed-tags=warn' '
> +	git fast-export --signed-tags=warn sign-your-name >output 2>err &&
> +	grep PGP output &&
> +	test -s err
> +'
> +
> +test_expect_success 'signed-tags=warn-verbatim' '
> +	git fast-export --signed-tags=warn sign-your-name >output 2>err &&

s/warn/warn-verbatim ?

Thanks,
Taylor
