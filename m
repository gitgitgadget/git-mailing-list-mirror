Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565EFC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B746112F
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345719AbhIGTsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhIGTsf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 15:48:35 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9390C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 12:47:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g22so15477708edy.12
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 12:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=fcMXcWDjWWXzfMnnVnnku3OReCcFKlOJNDmasnmi4Rc=;
        b=JzuMBxF3VyPx/D5GFlyxEfYVFWCFsL6ZMt+HeCG6Vsdz2luIXw529k+s+hHVk+xv1e
         YMisqhdu7HamvJSotdmmDZM4QF6X0IWa86vk+qlq+I+R3Qse3RjCHDSgl5lB573nIHkb
         ledNsIKIB5zLVlxSV3RhYrxeyh6aCAsTYmmipLOk5o1ahjt++faiJt/9GkJvjVItj/Iw
         Nl9y235pEeKDrscF/o3GJKS+t7HshM1zZI6Aei3cIWJ0FYjgPHYXk9GfFlJbBs1Hzy4u
         nN9DmxTnJkq0dwdJG83oScwryRJ98+xgIYQwRRlncPe7iznxOTBASBB85CA9Mi58HAbt
         QJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=fcMXcWDjWWXzfMnnVnnku3OReCcFKlOJNDmasnmi4Rc=;
        b=kuWfw2nLmDkj/lb4/z/JHtNEfb/HGA0eFqHQrE1JL4akWvehe7VX7WcqQtNY35CEBz
         +vAQDRYohDA4EXATwv9xqFbDHAOuBDMy1jl3bc9+026nXWRIeIvHMZ6pAlaolaJ7YEEI
         B++l0BILtGDAkifSRum87WiQW5EzjHZyg4HGw4HZ+HEeIe/aoOgUp4WPd7ABYlDg2Qaa
         5CQG11OqhFFTqFgCe3+CQ2gc4RlN/PJeJqaKxQp66D4zO6YlkZc8QISCHlNMWTSvVjjl
         I2VSGyq69prsECmL2cpLtDmtH0qtSZ7g0TgijSwj05iUfONe9co5shHmGUc2DZG+CksO
         czOw==
X-Gm-Message-State: AOAM532A3b49AfOmrL5ZRGo+VOlpAH020wTHxOj1rIQRYntI26DLuTFv
        fSzRs32i1fu+nH3JTjszYOqupRbe4xDFDw==
X-Google-Smtp-Source: ABdhPJwy72riilzkzFxtM9jsctUSVjUYqgt/96bfHvfL51qVYLqO0xFtBa31C1nmWv7TIhE5E3umKQ==
X-Received: by 2002:a05:6402:c05:: with SMTP id co5mr1181037edb.41.1631044047481;
        Tue, 07 Sep 2021 12:47:27 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lz19sm5922390ejb.40.2021.09.07.12.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:47:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: expired key in junio-gpg-pub
Date:   Tue, 07 Sep 2021 21:44:46 +0200
References: <YTerpXCxYx+f+8ws@coredump.intra.peff.net>
 <20210907182042.3ugoaicjt4e3h4fp@meerkat.local>
 <YTe77RPYavw9HAfZ@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YTe77RPYavw9HAfZ@coredump.intra.peff.net>
Message-ID: <87bl54kw1d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Jeff King wrote:

> On Tue, Sep 07, 2021 at 02:20:42PM -0400, Konstantin Ryabitsev wrote:
>
>> On Tue, Sep 07, 2021 at 02:12:53PM -0400, Jeff King wrote:
>> > Have you extended the expiration on it? I wasn't able to find any
>> > updates on the keyservers I checked. But regardless, we should probably
>> > ship an updated one via the tag.
>> 
>> You can get it from here:
>> https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/plain/keys/20D04E5A713660A7.asc
>
> Thanks! That fixes my problem. I do think we should update the in-repo
> tag. :)

Note though that when the in-repo tag is updated anyone fetching it will
need to update with --force, and anyone doing fetches of git.git will
see a non-zero exit code on their pulls and fetches without that.

This is due to my 0bc8d71b99e (fetch: stop clobbering existing tags
without --force, 2018-08-31). That change was meant to error on pretty
much this exact scenario...

But to be more gentle does anything rely on that specific name, or would
it perhaps be better to push a new junio-gpg-pub-2021?
