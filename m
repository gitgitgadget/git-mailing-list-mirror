Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC3DC433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47FC23358
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391449AbhATQiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732795AbhATQd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:33:28 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF207C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:32:29 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id gx5so15136990ejb.7
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=89bRz18XJHbBhAfHXy2C/5AChJri1TvYplA2GTl8/gQ=;
        b=T0raiuDGHogbQ0wLzyVPp8PbKb8FMjI+ZaDu2hWeF/0AJyEJrWTTDE6reiPnNWA+cU
         X/wmwFfRuK/e1pyOC6gXNFOfDyY14Hnuzq/CjpIr+9N3UnCQbO6O1OCgrlmzefYQP+3c
         qIetL5OkP8oKEZJhcZ5AcbenDLzEAg6Sjmdlw75Z8m5fY7iZTZxlQyh69K+lA+/GNfwn
         xMISWsze82zXB2lZqZQsW7IYWSvja0tU6knhy4z0ZOui1nLaBKOTWo5OGxxWnAYidBjY
         cnQ/8UeHzqsFu0Cei4Nh00ZsehNx6HgnEqqQQmxWq2Vd+AIJH6XXwEoUscT0gFBAgzCO
         PVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=89bRz18XJHbBhAfHXy2C/5AChJri1TvYplA2GTl8/gQ=;
        b=QkQZ4b/y6FCgCLXp/ICbxwhxp2+zK/hypM5a9J3aZ2yba3fqogeX6MuPNed96jvqBv
         cNS48epTL29uF6H+Ry+K1cbrUvabA1abqwYbDfRFe09bS1lsBXktkpdh37HdI3x354f8
         SCat4omNRKbfmLdiit0ZAY61HdTxDtQ92yYGf/ODLAxsbM5KV5vlJBdm7EIB7Dld6XNC
         uAd6dVnTJl6ijpJJqUU07qr3pUIqShA5NJncB6axwfqWrgIGq/zX4Ffxayy2dFfYkxjZ
         Ong3QkeubQTd52aVE/QFdl8lDXEpziuEjbK/yTPCVNmbP607aum9uTkeEOtFrydAEUrX
         tlNQ==
X-Gm-Message-State: AOAM532Id2qPdSujvOMpRgQ7rfMUh889xvNvpF8RiWDc19VnlzJDtEh0
        /fQpR25H+q1wXQ99NJ1XNj8=
X-Google-Smtp-Source: ABdhPJx8HmytelLJnlagrtM3vNfUBHNEqfUk4BN+HTsnGBkiUAvlBfTHlBlvABzjVTgXbC302BnyNg==
X-Received: by 2002:a17:906:7f8e:: with SMTP id f14mr6485237ejr.198.1611160348348;
        Wed, 20 Jan 2021 08:32:28 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id n2sm1126588ejj.24.2021.01.20.08.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:32:27 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] builtin/pack-objects.c: avoid iterating all refs
References: <20210119143348.27535-1-jacob@gitlab.com>
 <20210119143348.27535-2-jacob@gitlab.com>
 <87lfco801g.fsf@evledraar.gmail.com> <YAhF7HfOdu5AR42Q@nand.local>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <YAhF7HfOdu5AR42Q@nand.local>
Date:   Wed, 20 Jan 2021 17:32:27 +0100
Message-ID: <87czxz8t7o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 20 2021, Taylor Blau wrote:

> On Wed, Jan 20, 2021 at 09:50:19AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> It seems we might just be able to delete this code on the server-side,
>> per protocol-capabilities.txt:
>>
>>     Clients MUST be prepared for the case where a server has ignored
>>     include-tag and has not actually sent tags in the pack.  In such
>>     cases the client SHOULD issue a subsequent fetch to acquire the tags
>>     that include-tag would have otherwise given the client.
>>
>> I.e. in the case where the server isn't playing along and I haven't set
>> "+refs/tags/*:refs/tags/*". But as the test shows we don't do that
>> following ourselves unless refs/tags/* is in the refspec (and then it's
>> not really "following", we're just getting all the tags).
>
> Reading your email, I see no reason not to do it, and that snippet from
> protocol-capabilities.txt makes me feel even better about doing so.
>
> I'd be happy to have Jacob's patch picked up in the meantime, but I
> think that this is a good direction to pursue.

Oh yes, none of this is commentary on not accepting the much smaller and
obviously correct change in the meantime.  Just musings this general
area of fetching & ideas for further optimization.
