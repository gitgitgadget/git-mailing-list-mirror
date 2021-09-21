Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258DAC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 23:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04EC460FE8
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 23:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhIUXyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 19:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhIUXyl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 19:54:41 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96CFC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 16:53:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id dj4so2844374edb.5
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 16:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KERvvu6M7lypvqvYFMd164E4bZYYHtDNbLevn55Tf0Y=;
        b=IUMg1pNCZszj/pO+d0OJPP/Dil0PrBi5j8r6p9qz7HafZaHyVA9Oz/L4diD0MP99TK
         Rfv2AIQEWGjPx6Vb3LlilhI3nGsywGFS9UBva03Jdp50Dp2olUZXvtA3fxDOXigaD93u
         Gh+pG0rfHIKmUHhTiC7+X56/HEciLnZyXLwTetI7Wm2QgnDrEepgQf280izyqoJw5N20
         hsvH8wBoMg4VEnKUB0Bs5IRQFQ/Yw4CrpmUIo8XAsObNpekp9o7mbPaVUDrenu+F+HXQ
         pm7hxCc+28OcUirs5f3HGN2Z18yWIMgTGFVPIvkQtpMicFIPLazlpFL2XY9UcQw8Lf4o
         lTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KERvvu6M7lypvqvYFMd164E4bZYYHtDNbLevn55Tf0Y=;
        b=UzQS5+OOBD5msFeVpBRe2o03rUlMCTxmePlHwNFRFi3/9/dDgCnMmDaEznmvmljpL4
         Td99PYiu9/Wi/Q3pJpEcSTxnGHiPci12QfCm2mwwLztex21j/eexqfYR/I3QZP57QUMy
         I7AosSNX9Qd4JumS2L0l3zaxAeQ6WOfft89L6zyQrqEyEimNqHDmD50xl5y8R/h+9w4H
         v1Na/NOUOnc3TYX1Jr9XGzLiGueWzlfspyF5lNYieJjtysFmnVXMQAK+neEJ+eepsDCt
         znr5+3t9OmK2GlBJeVRFtPFx9TcELa8+spkm5ywp6UVksu+ABm8vjRDlbdyo2p3eEyJ7
         oP9A==
X-Gm-Message-State: AOAM532sdCamHAJoDqKOIvtw+omDS091Hm4FuPBA+LCIjOJwCMLyU5xq
        aw5nshpykrPQhCwuRzAzyVEm0apQtz33Jg==
X-Google-Smtp-Source: ABdhPJzVqDTh2UX8bW5YQnZvlQcnPDIipI0xLi/TOimC/QzgNnNif+2GWzsdRhOZ1HP9RkwMARof/g==
X-Received: by 2002:a17:906:1615:: with SMTP id m21mr39133273ejd.279.1632268390286;
        Tue, 21 Sep 2021 16:53:10 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y4sm164957ejr.101.2021.09.21.16.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 16:53:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 4/6] update-index: use the bulk-checkin infrastructure
Date:   Wed, 22 Sep 2021 01:46:57 +0200
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
 <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
 <f7f756f3932cdbca587de397598758c685bac29a.1632176111.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <f7f756f3932cdbca587de397598758c685bac29a.1632176111.git.gitgitgadget@gmail.com>
Message-ID: <87ee9h8p0a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Neeraj Singh via GitGitGadget wrote:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> The update-index functionality is used internally by 'git stash push' to
> setup the internal stashed commit.
>
> This change enables bulk-checkin for update-index infrastructure to
> speed up adding new objects to the object database by leveraging the
> pack functionality and the new bulk-fsync functionality. This mode
> is enabled when passing paths to update-index via the --stdin flag,
> as is done by 'git stash'.
>
> There is some risk with this change, since under batch fsync, the object
> files will not be available until the update-index is entirely complete.
> This usage is unlikely, since any tool invoking update-index and
> expecting to see objects would have to snoop the output of --verbose to
> find out when update-index has actually processed a given path.
> Additionally the index is locked for the duration of the update.

Would you really need to sniff the verbose output? If I'm streaming data
to update-index now it looks like I could assume before that
update-index would have done the work if I managed to fflush() to it,
since it's processing a line at a time and doing the work in that
line-at-a-time loop.

I.e. you could print lines to it, and then do concurrent object lookups
knowing the data was written already...

I think this is probably fine, but that case seems way likelier than
someone sniffing back the verbose output, presumably for the "add" in
update_one(), but that's called in the getline_fn() loop...

All of this makes me wonder why this isn't using tmp-objdir.c, i.e. we
could have our cake and eat it too by writing the "real" objects, and
then just renaming them between directories instead. But perhaps the
answer has something to do with the metadata issues I raised.

And well, tmp-objdir.c isn't going to help someone in practice that's
relying on this "update-index --stdin" behavior, as they won't know
where we staged the temporary files...

