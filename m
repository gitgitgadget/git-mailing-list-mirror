Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DA011F461
	for <e@80x24.org>; Tue, 25 Jun 2019 09:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfFYJGS (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 05:06:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39219 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfFYJGS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 05:06:18 -0400
Received: by mail-io1-f67.google.com with SMTP id r185so1363044iod.6
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 02:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vmowOcjB0lLEsVk61J9JjOMLKfD0cwv0FrCTnkj2R24=;
        b=f8X3qZXmx0VFJfEAszlmfd49ubTwvXcMJBlLmqLSJKHxZwORgy+xSDF9Q76swF5mjr
         y5P9QmINnEA3DKR9BdZIWVQ/Y1e/mHJ44pCnAVsbx8sTZKgP0qWFjE0Efyk0dY/E/3qT
         p8wpOAILNsOGTE/z6akQwmTDqNMjceRMCQNFmESJD0f0lvFNMnq0gL+wCNMROgt/sC+f
         6gkFbOhrNHibijsvnT0nBkm97EZcrGDoY0ZejW02yEqGeLo6u5q0hNpzikosM1lITBmM
         Y628BpOen+P5fKE9G6X88+59yzVB3qZmMqm+gONhDLDVQWfw3/QpuHzo0Kian8IxSKhq
         9CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vmowOcjB0lLEsVk61J9JjOMLKfD0cwv0FrCTnkj2R24=;
        b=cRl/rrCtR0afeyvclTbV3ZgzGtgKmEQ8dQmgJZG2H8fMsyMOrPk93ASerJD0nsDEXl
         A3MspCWd71krJZLDUUIufxr20V3yYc6oSHFbO0mIqfbbE4wlp3OSltkdavVjQVNtTNaC
         +vO3Bc9NhN+0pet4VzC5E9grUflL8xUuj+UHWvCqj9FkZecX561j/0XhlgXmWAfpAb2R
         Tx/c1av4u6/XhT+VrUplvyb4JMIkSpyC6HSr8ofjC26BlOsf/qfICerUnq0iLoXhG92S
         /kerXCLA6TD+QSOFlNiNOSgDWtt9PuqffMDuQxjry35MS/Fwdc3DNyWyJrU+bDzsgBrB
         KnDA==
X-Gm-Message-State: APjAAAUNqN+pv8NtpPG7mDkHDkUyG8G3sv+DYvTRKf6beljTCY/DWS4t
        SITbsvoVWB52+aX8WtvNQmxxjJL9Yp2jjnKeA20=
X-Google-Smtp-Source: APXvYqySEeCtOPl4+K+nZFnBdTq7E1itUrwFA53Oz2/bzHug4qPvazkfqroBLeGbwbQQPybAxgnkYx9gPCna0CZnfhs=
X-Received: by 2002:a6b:f80b:: with SMTP id o11mr2698215ioh.40.1561453577340;
 Tue, 25 Jun 2019 02:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190624130226.17293-1-pclouds@gmail.com> <nycvar.QRO.7.76.6.1906241954290.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1906241954290.44@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Jun 2019 16:05:51 +0700
Message-ID: <CACsJy8BsT-GaVvEmqfk5n1jGmkcLG_bRjqcU0M3yefBmNSxmnA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Add 'ls-files --debug-json' to dump the index in json
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 25, 2019 at 1:00 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> > - extension location is printed, in case you need to decode the
> >   extension by yourself (previously only the size is printed)
> > - all extensions are printed in the same order they appear in the file
> >   (previously eoie and ieot are printed first because that's how we
> >   parse)
> > - resolve undo extension is reorganized a bit to be easier to read
> > - tests added. Example json files are in t/t3011
>
> It might actually make sense to optionally disable showing extensions.
>
> You also forgot to mention that you explicitly disable handling
> `<pathspec>`, which I find a bit odd, personally, as that would probably
> come in real handy at times,

No. I mentioned the land of high level languages before. Filtering in
any Python, Ruby, Scheme, JavaScript, Java is a piece of cake and much
more flexible than pathspec. Even with shell scripts, jq could do a
much better job than pathspec. If you filter by pathspec, good luck
trying that on extensions.

It's the same reason why I will not provide a flexible way to disable
extensions. I'm not starting a JSON API for Git. I provide an index
file in JSON format. You do what you want with it. You have a format
easy enough to import to native data structures of your favorite
language.

> especially when we offer this as a better way
> for 3rd-party applications to interact with Git (which I think will be the
> use case for this feature that will be _far_ more common than using it for
> debugging).

We may have conflicting goals. For me, first priority is the debug
tool for Git developers. 3rd-party support is a stretch. I could move
all this back to test-tool, then you can provide a 3rd-party API if
you want. Or I'll withdraw this series and go back to my original
plan.
-- 
Duy
