Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8146C1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 08:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeIMNpI (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 09:45:08 -0400
Received: from mail-yw1-f53.google.com ([209.85.161.53]:47020 "EHLO
        mail-yw1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbeIMNpI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 09:45:08 -0400
Received: by mail-yw1-f53.google.com with SMTP id j131-v6so837685ywc.13
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 01:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dutyo17ukYqSXaxg6xJ3RMFID1qwpIMezAFfBMIcnl0=;
        b=oov/kSMu5gajEt2pnMQO/vVfl4pOvcUCKjDDxkmuEiGQZVeRHLDmXVwa73ldldEWE1
         55jwVXOCHSzch4aorajJtz3vSTMVBVRnlQUNDzDUfILh0sawUtEMpUY5WrsmauZ4KOLs
         u8wTdEeCMuSfStfE8j3How87OEUn2SHKZYEMi5zW/NlD4cXXX04ZwvSQF8kAIyOV3Oj0
         zRmvRJCwv34XudLgoz2PcbmNxGdykYYS85S2fOI+omFitqg8dogQvpViTe+enNZiY0pp
         +It4ypMurC7xgILfl78H8lyee90ZxTk34G1dt8TKkQqJ/3eQ67RT88EzckTjzcheNKo6
         Obng==
X-Gm-Message-State: APzg51BgNWkbdAAAkGqkMsPsdvmYw/zHbNx/1UBQxuLoYP68uUKxZwjQ
        wbmK+GBAzM3XdtWyUk6YtFJ6VcWmPyf/clCALzE79Q==
X-Google-Smtp-Source: ANB0VdYd4kC7MVc4tDdM0JT4yPLp215LpO+eMoUPeVsurXrc7/4DJ4Xl05AzL/Y8rylETOwyfvzRUkoMbuMlfZ4u3FM=
X-Received: by 2002:a81:2644:: with SMTP id m65-v6mr2862386ywm.327.1536827801798;
 Thu, 13 Sep 2018 01:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <CANT8FXRbep_32-eeMSa0C1e6q6MUvFddgTUiUgqv54J-2c+iXg@mail.gmail.com>
 <20180911190519.GA8396@sigill.intra.peff.net>
In-Reply-To: <20180911190519.GA8396@sigill.intra.peff.net>
From:   Michal Novotny <clime@redhat.com>
Date:   Thu, 13 Sep 2018 10:36:30 +0200
Message-ID: <CANT8FXSu9rqbw5D05LfcrD1GpenFGdB6TAcaHJGFJiouzctxJQ@mail.gmail.com>
Subject: Re: with git 1.8.3.1 get only merged tags
To:     peff@peff.net
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 9:05 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Sep 11, 2018 at 12:43:15PM +0200, Michal Novotny wrote:
>
> > I need to emulate git tag --merged with very old git 1.8.3.1. Is that
> > somehow possible?
> > I am looking for a bash function that would take what git 1.8.3.1
> > offers and return only the tags accessible from the current branch
> > tip. Could you, please, give me at least a hint how this could be
> > done?
>
> This is not particularly fast, but it should work:
>
>   git for-each-ref refs/tags |
>   cut -f2 |
>   while read tag; do
>     test "$(git merge-base $tag HEAD)" = \
>          "$(git rev-parse $tag^{commit})" && echo $tag
>   done

That works for me. Thank you a lot for help!

clime

>
> -Peff
