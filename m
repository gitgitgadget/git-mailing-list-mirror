Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F01FC1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 09:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932353AbeFZJUm (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 05:20:42 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:39800 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932189AbeFZJUk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 05:20:40 -0400
Received: by mail-ua0-f194.google.com with SMTP id n4-v6so10478622uad.6
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 02:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tAo2Xp/Um7CICn9SAeNHnMb2iObyewlcYGUrcsGjaII=;
        b=elSDLHzCMpCr0VuYm7/XbsACPIbsos6ncvMUt+ZIq5tX47hY3qpOQxnTQU7nbERHpP
         Dufs/79zLTy17fnRgQN/iySFm0/m9sYnVG0rc139azPhIptQtrlgjFUZmSwt92eP/TG9
         PU9UdUVkmMNmUiJrc4jMS+0XARBA2Ns6gtv9OJLMYoMsaBsZ+RvXN4OwVog20hGcoKZe
         jzvSzgttQEDaoZTs6GD7+qkKmSdBKOZP8zWzWNcIp20XjvtncJLOfVumRJsby5AxR5bt
         ijko6IND6d0bGJaUSBqqO4dDaZcClPryEuYYnn09onMbdR+F/iaZXrpoDiJaR6hA4tVM
         zuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tAo2Xp/Um7CICn9SAeNHnMb2iObyewlcYGUrcsGjaII=;
        b=QsvR3DHuJbUcbFneCh96+DXA2nMuv4kB37U1NIQ2vZWDF/xmnS/0/u48PyiPeefP0w
         /4+CbymCKbabJPx3UhyIBLJVDq8WZASEsvbjkxdnaGlw7aTMmhufvrVkswWPkBwT6Txs
         csEdIPNCCseW8+r1lNyuwvLbbxnMCTYf/lXvwJUqFzM3DeYiDdZFCCN2VvJXyKYlI5IS
         BrqlS87qgl7zGAnubZONwFBY4fkSgfW1PR1KldMgN8rPrt5h2CoPurmxTY+XxBombfPg
         ZLbBOl1/RSZ776pfrO8inxRTTICnjF+k8cxrVLp1gBRO1q0tt63KCP3qKt+33GAIPLL1
         jzuA==
X-Gm-Message-State: APt69E0RhETwKmoVK00MFQr48tJfEI/KZ7ckhacwZfImkYVVDuzxvyHs
        FP2moQcNZl+UvAMz+3ifM+qABqMLkclWEtvwMrMhoA==
X-Google-Smtp-Source: AAOMgpcJUk3wd7QwHZrsuuEKyD10p1f+mxxV+vEiMcST3+xt0g5wABtNPybDHuDux6RXyew+sCm2ZRB4gv/GRd69SgA=
X-Received: by 2002:ab0:57c9:: with SMTP id u9-v6mr443808uac.94.1530004839720;
 Tue, 26 Jun 2018 02:20:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2310:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 02:20:39
 -0700 (PDT)
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Jun 2018 02:20:39 -0700
Message-ID: <CABPp-BEz=mLHsg1NizJUKxOKM=dKFSAVec=x0mcs=4cJ73k_+Q@mail.gmail.com>
Subject: Re: [PATCH 00/29] t: detect and fix broken &&-chains in subshells
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 12:29 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> The --chain-lint[1] option detects breakage in the top-level &&-chain of
> tests. This series undertakes the more complex task of teaching it to
> also detect &&-chain breakage within subshells. See patch 29/29 for the
> gory details of how that's done.

This is awesome.  It'll replace a hacky script I had that attempted to
remind me when I messed up, and fix its false positives to boot.
Plus, I won't forget to run it.

> Aside from identifying a rather significant number of &&-chain breaks,
> repairing those broken chains uncovered genuine bugs in several tests
> which were hidden by missing &&-chain links. Those bugs are also fixed
> by this series. I would appreciate if the following people would
> double-check my fixes:
>
> Stefan Bellar - 8/29 "t7400" and (especially) 13/29 "lib-submodule-update"
> Jonathan Tan - 10/29 "t9001"
> Elijah Newren - 6/29 "t6036"

Commented on the patch in question; 6/29 looks good.

I also looked over the rest of the series.  Apart from the ones you
specifically called out as needing review by others besides me, and
the final patch which makes me feel like a sed neophyte, all but one
patch looked good to me.  I just have a small question for that
remaining patch, which I posted there.

Thanks,
Elijah
