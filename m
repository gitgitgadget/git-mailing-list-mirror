Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 035071F453
	for <e@80x24.org>; Thu,  1 Nov 2018 15:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeKBAwd (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 20:52:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38534 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeKBAwd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 20:52:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so20551235wrs.5
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2wUol18NPlIVyWZtTp7SQUEemAJ6Da7kDTjPZHVnhs8=;
        b=Aa+94iNWJnlG8oyMWBJCnu28guDFJWtyUGiT9NEOuavVEtk6gNdjwgf9Pitf8oawRU
         /h9v8JnnsRtpJBf2PQtHH6w5bHbzhLxHOtRYDVqqDje4Zbf7qo1dx4BbskkCQW7uik+v
         OfuT2DiGUq+X3c/fWMIj0BmiuLpfDLHgg2EmwLsPztMqRlC6vZ1znjj02TkfectHWEhe
         3iqIMQtmrxRG/OnppPZPxRSM+LsMjxYWrLMvZEhkFoqV6k1Bwv8fYtrWAqNHPr8dJTJP
         VOve6/LcU4iy8mVQ6xtPZqBgq/u5KW6HFK9Ub8jl809o/0wjOr0wP/Ena6FkPXDnLgx/
         60lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2wUol18NPlIVyWZtTp7SQUEemAJ6Da7kDTjPZHVnhs8=;
        b=AJALrLBJoXHiVJ74uceif4q8l8ByexClxdA0LetO1m2NhGUjRnLgin5mEqXoeeY32x
         89Gdj6NVitYk2d+2HEU5urvohSpYOTR3L3xfzOAJtiKw49ICaWWH5Ld/g8oXRb6XIAao
         yxMG6bCt4caVtiyjpABlFQd4893z5/Bvdf2eEMm9GMkj1vJ6Ot1viJvwFd6kQyus+UL1
         q1/wPbq+9c+4cpczhJWMucTOytg3F5/NlfR3VXiI4nrd8podhnhXdek6vqk56NpBiQzu
         wr9//BE0uqZ5MkOm1s4F8/m6SuUScfVxSAwq61SZvz6hoygrU4ihs6QPNAJ9kNO9YCUo
         JHsQ==
X-Gm-Message-State: AGRZ1gIgprkNEhS+vEBeTLEG0fxnsI6C6eiao8N7qwSjR+VvyruEE2Ob
        xDaXmakby5iWvReAyf3bBMk=
X-Google-Smtp-Source: AJdET5fYYK6x/TW8hi366XUZuI2pP6G0U3mQAvTNjkuCYyBPscy99Es+bxhZUqsV+fvs8vXTP37XrQ==
X-Received: by 2002:adf:9245:: with SMTP id 63-v6mr6814606wrj.130.1541087340599;
        Thu, 01 Nov 2018 08:49:00 -0700 (PDT)
Received: from szeder.dev (x4db12d59.dyn.telefonica.de. [77.177.45.89])
        by smtp.gmail.com with ESMTPSA id 21-v6sm14058544wmv.5.2018.11.01.08.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 08:48:59 -0700 (PDT)
Date:   Thu, 1 Nov 2018 16:48:57 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        peff@peff.net, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 6/7] revision.c: generation-based topo-order algorithm
Message-ID: <20181101154857.GW30222@szeder.dev>
References: <pull.25.v4.git.gitgitgadget@gmail.com>
 <20181101134623.84055-1-dstolee@microsoft.com>
 <20181101134623.84055-7-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181101134623.84055-7-dstolee@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 01, 2018 at 01:46:22PM +0000, Derrick Stolee wrote:
> 1. EXPLORE: using the explore_queue priority queue (ordered by
>    maximizing the generation number)

> 2. INDEGREE: using the indegree_queue priority queue (ordered
>    by maximizing the generation number)

Nit: I've been pondering for a while what exactly does "order by
maximizing ..." mean.  Highest to lowest or lowest to highest?  If I
understand the rest of the descriptions (that I snipped) correctly,
then it's the former, but I find that phrase in itself too ambiguous.

