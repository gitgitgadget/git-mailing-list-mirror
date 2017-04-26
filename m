Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF481207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 21:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030207AbdDZVLI (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 17:11:08 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33462 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030199AbdDZVLG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 17:11:06 -0400
Received: by mail-yw0-f178.google.com with SMTP id 203so6776309ywe.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 14:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A2vBbTXoX7V8ZkqyoLvMssEt9f9+Oc3YouEk7W+HNTI=;
        b=ZZQ0neCv2yf1Esnin4b3Cph6f1brK/NjiSPFgtDFntFAJyiAeBbivJOgPvCiocqNP1
         R1QdHwT+yqdEq8rqz4Hf/Pyj+FRW99CPaEnEI7CmFGuzlkWtknIs9k3iTQWEBjgdfRtp
         IhiL8b/ev1/Jol7kXVkdLxdxVrONw6LL8S8hKG2cgki+1HomehcdKrZ+P6A/gQvnu6v5
         9VVqC6X4K6tyjXNKZogiJ5KNvzZQxWkCDV66zI//c+oULXmA57wTMF9axlZQZhb0CqA+
         MgPE+mfn9aYqFUflhvALsjdIlTY+OC75yRYaRz6T0llKEfRyv9mqTUSDjiDFBsoVcvoe
         L6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A2vBbTXoX7V8ZkqyoLvMssEt9f9+Oc3YouEk7W+HNTI=;
        b=nBhJr74n9XU0z63DInrdaNruwdH46weie0WP/gvLzOiALiPiydTxDLg6CZlGIHhVYD
         RqCIY0O5CHZuKbrrTaFXxEwoW9vosMy6sfr5KC3o9KWXcn1otP8UeOf2f01MyhHa7fWq
         vlxZKzsHGz8Y3N0Fz9aJ0iLJCdnIv4eep0MccNKAFDVnvnilIIBrheTfrappVgq5mHZu
         xBKEAcljVy7T2BwkL+q9tj/h9PoZ+g60dkBCFYPhn7o9RhJqqMhp/BqPRFqwT0VZxmZG
         qjO9m+rKTxVU56Cr0JEHI28D1mHwpxTCbWJwXdBsAjj7gbSJFM1lKUh5MO/h/3H4mKry
         0uhA==
X-Gm-Message-State: AN3rC/6X2BYUH8wnwiYrXTmKyBFXoGAblIBsgd6IoaqM2UI6p12axoIG
        yGJ28wL6iyv/F1cz7yvvwC0w/S6ZgXhA
X-Received: by 10.13.209.193 with SMTP id t184mr1595880ywd.293.1493241065869;
 Wed, 26 Apr 2017 14:11:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.52.135 with HTTP; Wed, 26 Apr 2017 14:11:05 -0700 (PDT)
In-Reply-To: <ffb8b1ddb7a8a22643d569565e1a4929b883fba5.1493234134.git.johannes.schindelin@gmx.de>
References: <ffb8b1ddb7a8a22643d569565e1a4929b883fba5.1493234134.git.johannes.schindelin@gmx.de>
From:   Steve Hicks <sdh@google.com>
Date:   Wed, 26 Apr 2017 14:11:05 -0700
Message-ID: <CAABDHWZdsbP_NYW36nXc7WwjZf53PeEQrfaCUQrDpU4Zd9R2ew@mail.gmail.com>
Subject: Re: [PATCH] rebase -i: reread the todo list if `exec` touched it
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2017 at 12:17 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> From: Stephen Hicks <sdh@google.com>
>
> In the scripted version of the interactive rebase, there was no internal
> representation of the todo list; it was re-read before every command.
> That allowed the hack that an `exec` command could append (or even
> completely rewrite) the todo list.
>
> This hack was broken by the partial conversion of the interactive rebase
> to C, and this patch reinstates it.
>
> We also add a small test to verify that this fix does not regress in the
> future.
>
> Signed-off-by: Stephen Hicks <sdh@google.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks for shepherding this through, Johannes!

For context on this "hack", I have a script [1] that allows passing
multiple branches at once (or all branches beneath a given root).  It
rewrites the todo file with some extra operations, like "branch",
"push", and "pop", allows editing the modified todo, and then rewrites
back to exec's.  The "branch" operation, in particular, appends an
"exec git checkout $branch; git reset --hard $commit" to the end of
the todo, so that no branches are moved until after all rebases are
successful.  I've found this multi-branch rebase workflow to be very
productive, and have been missing it the last few months, so I'm
looking forward to it working again soon.

[1] https://github.com/shicks/git-ir
