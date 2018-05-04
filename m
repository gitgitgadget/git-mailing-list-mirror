Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB890200B9
	for <e@80x24.org>; Fri,  4 May 2018 20:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeEDUHs (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 16:07:48 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:53132 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbeEDUHq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 16:07:46 -0400
Received: by mail-wm0-f54.google.com with SMTP id w194so5700519wmf.2
        for <git@vger.kernel.org>; Fri, 04 May 2018 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=lqKN4FF7DEIJGfvVzIXajWfFxeIvZFzQKgyeDwcO3KU=;
        b=XECAsbiSZiW3su42VUKwLQj6mnPQqIIdwE2tTPe+sO4cpeEi0S93oyjwIB5ITTmSPC
         vSTNbuOp7H90LhBY1Rz2IOwm/w2wEzuJ8lQ6i0ky+M2KpYF2axoMPsvwF9YDFw0aV2PC
         mPwGeQjo/CJ3LbiOPRbDK71o8SdpKkR06C4j7LkRJ4MxkUyDd0f70Hn9QV0rrNkK6UKX
         ZR++bGBx+hyP1MUHMAqzeONfSBEiCKDpYGohVrp4e6/sVctP/kIzNmFxysB59p88v5XY
         L+Wx97tizA00duosBaZKELCJQvFdysukRg1wPDxuI1N65oF1qTSyEYI3pAEzS+O1LRVw
         x+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=lqKN4FF7DEIJGfvVzIXajWfFxeIvZFzQKgyeDwcO3KU=;
        b=lG7IXgU5jA9BXD57qSjnGwtgug3Bc4RNzclYss0Giin5WxLyorQ5I4vFyVH/PPRk/B
         u0p7omvF8R9nRDu0cGRJr7WHoXJU8niTvzOTDTSvq35FNjwRk1TEVRmYX1lK1/HCLV5H
         vE+eRo56ELUBtLRdMNTQSGPk3OToWEnKT+4fMMllOOvYmOLu6dRPReJ4/vshjcefddVj
         MYlNxrwkWfAqKDvMABK1R7smWOX9S03qaCsTU6EPCE35ecNUO7TpNkduDCwc95CrIu9y
         YgdeSlYKKeB9mvQgY4T5FoJOsYjXVdAGob99QZJNAmWD7rVrbR5kvj7zkSAGx6ouLZjL
         l9Sg==
X-Gm-Message-State: ALQs6tCmYkiLBcy/94UD4dehCjRu6lYR7rsDanuc+fNnarA76QKhq59K
        WX6RYcQCI2RyNBbimfuxjGwcs7j/
X-Google-Smtp-Source: AB8JxZrUyTwS2C54FT4uaeel2Gw0t0G5GU3W08JPtcr5fIaTGaZGUr7gwm8JkKgk9M2Ax6jQ+8xrcg==
X-Received: by 2002:a50:902c:: with SMTP id b41-v6mr38060790eda.279.1525464464340;
        Fri, 04 May 2018 13:07:44 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id 49-v6sm8995331edz.87.2018.05.04.13.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 May 2018 13:07:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC] Other chunks for commit-graph, part 1 - Bloom filters, topo order, etc.
References: <86zi1fus3t.fsf@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <86zi1fus3t.fsf@gmail.com>
Date:   Fri, 04 May 2018 22:07:42 +0200
Message-ID: <87in83xjzl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 04 2018, Jakub Narebski wrote:

> With early parts of commit-graph feature (ds/commit-graph and
> ds/lazy-load-trees) close to being merged into "master", see
> https://public-inbox.org/git/xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com/
> I think it would be good idea to think what other data could be added
> there to make Git even faster.

Thanks for the write-up.

> 3. Third, it needs to be reasonably fast to create, and fast to update.
> This means time to create the chunk to be proportional to number of
> commits, or sum of number of commits and edges (which for commit graph
> and other sparse graphs is proprtional to the number of nodes / commits
> anyway).  In my opinion time proportional to n*lug(n), where 'n' is the
> number of commits, is also acceptable.  Times proportional to n^2 or n^3
> are not acceptable.

I don't think this requirement makes sense...

>   DS> If we add commit-graph file downloads to the protocol, then the
>   DS> server could do this computation and send the data to all
>   DS> clients. But that would be "secondary" information that maybe
>   DS> clients want to verify, which is as difficult as computing it
>   DS> themselves.

... when combined with this. If hypothetically there was some data that
significantly sped up Git and the algorithm to generate it was
ridiculously expensive, that would be fine when combined with the
ability to fetch it pre-generated from the server. There could always be
an option where you trust the server and optionally don't verify the
data, or where it's much cheaper to verify than compute.
