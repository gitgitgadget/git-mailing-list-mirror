Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8160C1FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 07:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036043AbdDUHZy (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 03:25:54 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33511 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036040AbdDUHZx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 03:25:53 -0400
Received: by mail-lf0-f43.google.com with SMTP id 88so40394787lfr.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 00:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KhNhcDz3YUwKQGmdTOLwzdclHU5kDa7RlvQ4u6qZ7uQ=;
        b=XAkuiEHJmRR+1YMBqhNnBXdxOqS60zOHak97OhzKbXVUxQQwVveQGjL/RwSDnHmXrL
         WepQkY+/ijfHCf4sarEK8ajW43QuJPJumlMmGinF7CpHkbels8U9e33cYiZwECWlxLK9
         I/N66aTPmNMAg/fS3M7rXOHoanwz6zD/vA1G85Chj55NUmjdwkeKJYObZb1K9Llkt79y
         00d+jdroEaRAIkTvFm8kydhlX0ZNBQsF7XKcgqL3rgaondLjT/VY4pbq69j1qZABTT9N
         Udx7cHDjsv0JLwKJJ1fcwkCO/PPbpne6ACjCrODrbo49E4kBmGbsMIJv8GwpoxSaOxDn
         LYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KhNhcDz3YUwKQGmdTOLwzdclHU5kDa7RlvQ4u6qZ7uQ=;
        b=ICjq6syX0RkVKVSPRFzFIF9devnULZgYW1D3k3/3/ijWlzZCQYM/WHWYDFA2cbPCfV
         IGkciZtVDBIbwpe8lImEV1Le9tbvWvhZm2mWA1detC4BQKEQTpX1lGVzQf7qW7cO0uQF
         ke3fp6mig9t3PvdD2G4TLAo/RAk7Tb8BbisTMVn9TGJZxiJYg4bkx6VZPD0CnxGRZa23
         2GbKmgXnVSx0okiSFhPZrmB9hzTlysXMwYmQ1JVJzopMrS9Sudq4uSUlozqVGmr/sDE4
         KUznVGYao4trh+n2KUQf+yN/YH6PFZj6z+AvLvhnezj7Y/qyI4svrzUggnMPr7rBXM53
         qSJA==
X-Gm-Message-State: AN3rC/4Z8AJ9hV2CSFnu2WV7ty4Rrc0LPYlHGtGx26u6oXwns4YJmsB1
        e3M5s0ooDZHuxAO7JoHzrkpd3HAhB39j
X-Received: by 10.46.22.4 with SMTP id w4mr4385557ljd.123.1492759551323; Fri,
 21 Apr 2017 00:25:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Fri, 21 Apr 2017 00:25:30 -0700 (PDT)
In-Reply-To: <20170420201229.fxiylgp2v2v4sz3w@sigill.intra.peff.net>
References: <20170420201229.fxiylgp2v2v4sz3w@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 21 Apr 2017 00:25:30 -0700
Message-ID: <CA+P7+xr83+sGiRcfbmAvOGzxoR+BMVsjED41JY5P15Dw1qVb+w@mail.gmail.com>
Subject: Re: [PATCH] completion: optionally disable checkout DWIM
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 1:12 PM, Jeff King <peff@peff.net> wrote:
> When we complete branch names for "git checkout", we also
> complete remote branch names that could trigger the DWIM
> behavior. Depending on your workflow and project, this can
> be either convenient or annoying.
>
> For instance, my clone of gitster.git contains 74 local
> "jk/*" branches, but origin contains another 147. When I
> want to checkout a local branch but can't quite remember the
> name, tab completion shows me 251 entries. And worse, for a
> topic that has been picked up for pu, the upstream branch
> name is likely to be similar to mine, leading to a high
> probability that I pick the wrong one and accidentally
> create a new branch.
>
> This patch adds a way for the user to tell the completion
> code not to include DWIM suggestions for checkout. This can
> already be done by typing:
>
>   git checkout --no-guess jk/<TAB>
>
> but that's rather cumbersome. The downside, of course, is
> that you no longer get completion support when you _do_ want
> to invoke the DWIM behavior. But depending on your workflow,
> that may not be a big loss (for instance, in git.git I am
> much more likely to want to detach, so I'd type "git
> checkout origin/jk/<TAB>" anyway).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is flexible enough for me, but it's possible somebody would want
> this on a per-repo basis. I don't know that we want to read from `git
> config`, though, because it's relatively expensive to do so. People who
> want per-repo settings are probably better off with a hook that triggers
> when they "cd" around, and sets up their preferences.
>

I would use this. Completing these can get quite cumbersome to use
when I have only a few local branches but many remote ones like in
git.git

Thanks,
Jake
