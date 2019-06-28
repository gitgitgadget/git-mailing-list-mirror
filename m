Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47DBB1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 12:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfF1MvG (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 08:51:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45684 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfF1MvG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 08:51:06 -0400
Received: by mail-qk1-f195.google.com with SMTP id s22so4636943qkj.12
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oq20PANyFr8yya8uxTBv+9FXHyBqHcKU4DAljW6O1qs=;
        b=e5VdzwhzLFSMttzMQsWcd+3m0BfF2g87LEQL2MTPq6EzEGRYAfSHfylezlfryWWx7B
         A4bVcFrbWT45fKVKJ6flgJaoz76vgDT0YR22FmMjiTj8hIboIlpTxiXYGuRhLS1vckee
         aztV3rdU6ocUpteFD/AZm8boRUwT8hJ0DT1w+7R0d4JoIqIIZ66OJO7/tsJE22v7FykJ
         6AG8N2fE79LBXcoObkW0lo1hSWXnSiSrEaIDWjhxYOidIFFewKw17bTuPi11DepAIPhX
         YCVOM0WWiCThLSWjEkDhN1UAk+IMI3GKVIbg7Hs3W6Csx10sm1ydjwIiY07LB887csAz
         t5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oq20PANyFr8yya8uxTBv+9FXHyBqHcKU4DAljW6O1qs=;
        b=guYJxlVfBVb9/AyrsRmNNbaozRttE7fmDzxe7Gze7h861NoCDR+U3eLAGl94mJyyTi
         lt8fKJv7ub/I7cSXkm5Uxgm/lhHgdAZpOPKlGkcOMf7dvCJUUXjNq2DAQO3HNjN3d1OX
         YMj7gmLP2yxmOatoMdhe7IJhL39KcFM/FwIJMgYcU61lWbczo3WS9qoPoXjQSEtpJGzI
         9b8UmAC9RofAftm3NH5xUMzU20OAEXDmR0wmZ4k8GZydRG03yElHSqn9f4q6rgK638qy
         3pU6hO3SPk+CdZsTGBKSCOplsM2ryutSGcSEzT4N9GksISTwUSvtCKMq7sSOHIv560FB
         9OTA==
X-Gm-Message-State: APjAAAWvcT55Uu1EQ+Xn8hYQ/fb93e6WeJLADQ/LyUmTRiHqsSi8tFp7
        6qkV7/esAEh1pP+zZcpQQjE=
X-Google-Smtp-Source: APXvYqz0DOghaekk+bAAENKfMIN+P+Hw/PFZPpNIAHgTxhxuMvBQZEtD3ZFSKPl3br46cRDfemZS1w==
X-Received: by 2002:ae9:ef4a:: with SMTP id d71mr7852225qkg.406.1561726265402;
        Fri, 28 Jun 2019 05:51:05 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:54b1:2872:57:b107? ([2001:4898:a800:1012:5e5:2872:57:b107])
        by smtp.gmail.com with ESMTPSA id s25sm889770qkm.130.2019.06.28.05.51.04
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 05:51:04 -0700 (PDT)
Subject: Re: [PATCH] check_everything_connected: assume alternate ref tips are
 valid
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
References: <20190628101131.GA22862@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <601d8561-6e24-559c-6fbb-fa25a7389fa0@gmail.com>
Date:   Fri, 28 Jun 2019 08:51:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190628101131.GA22862@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2019 6:11 AM, Jeff King wrote:
> When we receive a remote ref update to sha1 "X", we want to check that
> we have all of the objects needed by "X". We can assume that our
> repository is not currently corrupted, and therefore if we have a ref
> pointing at "Y", we have all of its objects. So we can stop our
> traversal from "X" as soon as we hit "Y".
> 
> If we make the same non-corruption assumption about any repositories we
> use to store alternates, then we can also use their ref tips to shorten
> the traversal.

I was confused by this paragraph, because I didn't know about
for_each_alternate_ref() and how refs_From_alternate_cb() will
strip the "/objects" and append "/refs" to check refs if they
exist. All of that logic is in transport.c but used by
fetch-pack.c and builtin/receive-pack.c. But now we are adding
to revision.c, so the restriction to "this helps data transfer"
is getting murkier.

Is this something that should be extracted to the object-store
layer? Or is it so tricky to use that we shouldn't make it too
easy to fall into a bad pattern?

> This is especially useful when cloning with "--reference", as we
> otherwise do not have any local refs to check against, and have to
> traverse the whole history, even though the other side may have sent us
> few or no objects. Here are results for the included perf test (which
> shows off more or less the maximal savings, getting one new commit and
> sharing the whole history):
> 
> Test                        HEAD^             HEAD
> --------------------------------------------------------------------
> [on git.git]
> 5600.3: clone --reference   2.94(2.86+0.08)   0.09(0.08+0.01) -96.9%
> [on linux.git]
> 5600.3: clone --reference   45.74(45.34+0.41)   0.36(0.30+0.08) -99.2%

It's really hard to argue with numbers like these. Kudos!

> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/rev-list-options.txt |  8 ++++
>  connected.c                        |  1 +
>  revision.c                         | 30 +++++++++++++++
>  t/perf/p5600-clone-reference.sh    | 27 ++++++++++++++
>  t/t5618-alternate-refs.sh          | 60 ++++++++++++++++++++++++++++++

Other than the high-level questions above, the code and tests look
good to me.

Thanks,
-Stolee 

