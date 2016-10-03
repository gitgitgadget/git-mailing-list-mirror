Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6300220986
	for <e@80x24.org>; Mon,  3 Oct 2016 06:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbcJCGpW (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 02:45:22 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38330 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbcJCGpU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 02:45:20 -0400
Received: by mail-wm0-f53.google.com with SMTP id p138so132088839wmb.1
        for <git@vger.kernel.org>; Sun, 02 Oct 2016 23:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tGMwJ/BOb6JTlOva/0FLBEIRUGN2KIYfbDS/ef0IuDM=;
        b=tT6V32M79yDhySmLzZfSOmEV9vXuES4R1Iel7lT/htVj4VJUA31IBhNR6HuHGxi1YQ
         /nuvCCNdAl4wE8VGmyoBkF8nZUNKAJ5GONjYfAbDhBFKhazd4MGM/BJpRrko5M7QwtoQ
         kAtGQd7Ve/3i9sOl8pZFWVy02Pbw9WnO/+KiXsvbfR3CfRorCVcCZG02USumV8/3wGNd
         qCvG8TkgA8p8kOgmb8RJ83MGKMYoEOw1gYijioQixADjWlGZhgcPZbsIzyz7thlUsywv
         Z1nouUwMdNPgZd3jh+A+z8+cTN1jZgsI/AnDAOfKHvqL+EZTBy+L0kh5bFvPvNAc4MIx
         OatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tGMwJ/BOb6JTlOva/0FLBEIRUGN2KIYfbDS/ef0IuDM=;
        b=HERZ9WTF8WrnYx6dZtlATB4TKSfwkYhlLbJ31lt0ah7VgNAQq8q/vWLqhhoTLVCfEt
         +srtPJOJdgCZReLNyL653QTsFvWnBInnx7zXZ3v6vPuJra3HCr4zmKP3LWUYNuGapXb/
         49ukLAJdTAjtjnp0GpSLp9s2LYkaRwrO/jZfzl7PRtPOAglIbSjz3BJy4GuautIeX/UM
         gmFL/1vBobykn6IZiejJjphI/3m1skAo8cFnbtbp4G1ACrT3WXosRRzts0YYuBUQn5Em
         iugkesX40Z/4mAe0e4aZldYn0cfk8Kx5h/n9GwER3lImi/mWjVcSyJ4D7FO65R5PxEr4
         IL5w==
X-Gm-Message-State: AA6/9RlNujiMR5X55rapwVapQ/qBpFzqP9qsK2EqeaK31WZeJOLchfIMWfZ3hU51YNpnF1xaX/HrZCg58fhnww==
X-Received: by 10.194.101.131 with SMTP id fg3mr15957600wjb.33.1475477119156;
 Sun, 02 Oct 2016 23:45:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.38.132 with HTTP; Sun, 2 Oct 2016 23:45:18 -0700 (PDT)
In-Reply-To: <20161002130216.bburwjkx4dkzxiig@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
 <CAP8UFD3Y1du+L9DRgz01wgbsCYiebu2DgyePH41MaDhjV24oHw@mail.gmail.com> <20161002130216.bburwjkx4dkzxiig@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 3 Oct 2016 08:45:18 +0200
Message-ID: <CAP8UFD0FTe7P-0C_aqF3RVMMqVaa=s=Ld=pcoVyYirFw1h9Ogg@mail.gmail.com>
Subject: Re: [PATCH 0/6] receive-pack: quarantine pushed objects
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, David Turner <dturner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 2, 2016 at 3:02 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Oct 02, 2016 at 11:20:59AM +0200, Christian Couder wrote:
>
>> I wonder if the patch you sent in:
>>
>> https://public-inbox.org/git/20160816144642.5ikkta4l5hyx6act@sigill.intra.peff.net/
>>
>> is still useful or not.
>
> It is potentially still useful for other code paths besides
> receive-pack. But if the main concern is pushes, then yeah, I think it
> is not really doing anything.
>
>> I guess if we fail the receive-pack because the pack is bigger than
>> receive.maxInputSize, then the "quarantine" directory will also be
>> removed, so the part of the pack that we received before failing the
>> receive-pack will be deleted.
>
> Correct. _Any_ failure up to the tmp_objdir_migrate() call will drop the
> objects. So that includes index-pack failing for any reason.

Great, thanks for explaining!

>> >     These two patches set that up by letting index-pack and pre-receive
>> >     know that quarantine path and use it to store arbitrary files that
>> >     _don't_ get migrated to the main object database (i.e., the log file
>> >     mentioned above).
>>
>> It would be nice to have a diffstat for the whole series.
>
> You mean in the cover letter? I do not mind including it if people find
> them useful, but I personally have always just found them to be clutter
> at that level.

I think it can help to quickly get an idea about what the series
impacts, and it would have made it easier for me to see that the
changes in the patch you sent previously
(https://public-inbox.org/git/20160816144642.5ikkta4l5hyx6act@sigill.intra.peff.net/)
are not part of this series.

Thanks anyway,
Christian.
