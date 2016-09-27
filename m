Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A2D7207EC
	for <e@80x24.org>; Tue, 27 Sep 2016 05:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbcI0Fmt (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 01:42:49 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36710 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbcI0Fms (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 01:42:48 -0400
Received: by mail-yw0-f195.google.com with SMTP id v2so145711ywg.3
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 22:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l1FlazjvVoG33KfJlXPWrP9CXRMOos6SuqjLWt7dKAE=;
        b=m6hPChG/No9snpC+OlXuc0Vwh+T57HjU07ntY1Zoqj9yslHofO3FM5EtAVmYhgksDQ
         doELRA3iIsjHTVU8bR3Ma7xzwbAxLryBn/abP62tWtB2RbKOkTFOiZ/V+ZJ3q8d+vY7E
         JLGzDEt0g15ZK0w/4i5s0+lU2zd/g+75VhocoFRpBdgbjysNjs3rKuTe7qeM5yXPr6jc
         8XB4DjhN2e+Fwgz25n7bZCeNnchumxguQFSPydysA1ekJCf67Inyh0q7MHxGyolc9iJ4
         IBraoQ/hRhUHgYg6EmW+dr06Qz8iPygg3pvC4IAhIf8i8sJjOHa9DvvBLdrXLGxcSY+e
         HmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l1FlazjvVoG33KfJlXPWrP9CXRMOos6SuqjLWt7dKAE=;
        b=k+qylS2juGd9Lp+RmxwMrT4jfAQYfm1Cp6wn27Pz7yF6/aVH53FnpFKEg6Mv4oCYtS
         UbNjkb5Kr2+SpX90FHYund660CBau46nqL/GDtYU6v/UGl+ABJY+pNBf3spD4L30xJGZ
         gF3um+wLvIqqgfoAkO/RYeAIQymGuEbAqrPDzpBYwpdadIYGeY+HqUtYcjp8avWtb9mW
         GNdej055yqZ/taGbC5bDnZcNypjKU6PWS0BW09YMB5790UwK4j552ijGsfC9cLe9O8d1
         8UXuK9E7XQ1T7ysKDDJ74/deuxgs24/83eSyE1zQgyi4vQR1zZhVL5wcKXetrJcuJETA
         5ADQ==
X-Gm-Message-State: AE9vXwPCc9uwe8xhs5/uXJQX7a+/0oaLc8qP07pT0MhUyv4kmhyzdSU8iiJV2Bu9ShZGbDgOFA1p5z1slH2VJg==
X-Received: by 10.129.76.6 with SMTP id z6mr21638929ywa.257.1474954967098;
 Mon, 26 Sep 2016 22:42:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 26 Sep 2016 22:42:26 -0700 (PDT)
In-Reply-To: <CA+55aFyfvvqq1c=hZcuL-yPavp2tjzx8r3bFJnMY7DAE7YcB=Q@mail.gmail.com>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
 <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net> <CA+55aFyfvvqq1c=hZcuL-yPavp2tjzx8r3bFJnMY7DAE7YcB=Q@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 26 Sep 2016 22:42:26 -0700
Message-ID: <CA+P7+xpQQpZECE=XFjPbv5x8rYvY9UY4JyeTMFkSwFqjHmO_vA@mail.gmail.com>
Subject: Re: [PATCH 10/10] get_short_sha1: list ambiguous objects on error
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 9:36 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> This looks very good to me, but I wonder if it couldn't be even more aggressive.
>
> In particular, the only hashes that most people ever use in short form
> are commit hashes. Those are the ones you'd use in normal human
> interactions to point to something happening.
>
> So when the disambiguation notices that there is ambiguity, but there
> is only _one_ commit, maybe it should just have an aggressive mode
> that says "use that as if it wasn't ambiguous".
>
> And then have an explicit command (or flag) to do disambiguation for
> when you explicitly want it.
>
> Rationale: you'd never care about short forms for tags. You'd just use
> the tag name. And while blob ID's certainly show up in short form in
> diff output (in the "index" line), very few people will use them. And
> tree hashes are basically never seen outside of any plumbing commands
> and then seldom in shortened form.
>
> So I think it would make sense to default to a mode that just picks
> the commit hash if there is only one such hash. Sure, some command
> might want a "treeish", but a commit is still more likely than a tree
> or a tag.
>

I'd think we would want to phase this in over a few releases if we do
this? Maybe at least sort commits first in the list so that they are
faster to spot.

I am trying to think of what problems we'd cause by having the
behavior be this aggressive...

Thanks,
Jake

> But regardless, this series looks like a good thing.
>
>                         Linus
