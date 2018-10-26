Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0EA91F453
	for <e@80x24.org>; Fri, 26 Oct 2018 20:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJ0F1s (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 01:27:48 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:49441 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeJ0F1s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 01:27:48 -0400
Received: by mail-oi1-f202.google.com with SMTP id m2-v6so1593448oic.16
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 13:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h8/USXwUMNVMS//Cbgz/wS7C/NdA/FEge3unpqPYfXM=;
        b=pqzjjpF+UdrV+CyNegxF41aju8MaoWV7gCHQ72OgQDpXwC4G/bfoGcTKahzLr6h0cZ
         n1tnBeMm8Q/XNopXPKAogk5VloPwMv/0FZT1gEJN7GqELh695IU7uCadaGs8MIL7B35x
         6gPiQDinNK8KaozKt+jvJaXDMFLsDrXKDmbOTnVUWKc0swkwV1m27J3kgTdTpoqu25Zn
         08CIBMjStKpgWNqEn96ovZZViHxY+pjauzw6qnDkhP8aEa/83CzUOH3oYPD0dMlT8lZ+
         fiLsR/RuAFRgj4WPQeB2wx6eReODVOmmXQMpszb89s0LNveV6aXCbPluPqCnEFXfC9wW
         Y1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h8/USXwUMNVMS//Cbgz/wS7C/NdA/FEge3unpqPYfXM=;
        b=qTiRum7yO1wwOsapGjK8Pr4zw8D3mQGAFaZmFylWprhE7wSUjYEgTbSyjZDiJgWTnK
         s5khmFoP+8y0C72L+PD4xMWNBv2apHIhKr/WURRYBSIH/+gGvTiWkATsWNPKRG1EucT5
         AAGRfnCEFwiGqyDPrFWGkEkLcjK548/RzvrpheoyFz/OHQFEUY3SmQW2mtrfLFkDx7f6
         eUbHcgxuqhr1ZHl1YhvKFvwexLFvRv/CnxbETct8jfmAQ58LQFFngHt7e64Jpo2MCDuX
         i2dSDVfpRBEsryyS7cAs//kkOUl5PPzUk47VLIng1p8cD1G1sAvCmE/G15WIbbTWEUmd
         vMzQ==
X-Gm-Message-State: AGRZ1gJR7bXmprHvg82FxHkXvIP4wCbBtzPZDcpf+ThGx9aPoO82lV4L
        XOWS8f44aK93Xuo/AiCQiYRD4IIGX2wegGfzxYnW
X-Google-Smtp-Source: AJdET5cPXGz3/6Ev9g9u3oUBmDTQ9WpwzZRVZlpLhA+37vikZwkvxxHGnKk+bQ8zPhAsD/EzA1wZRckRnxtz4dHQMNML
X-Received: by 2002:a9d:7157:: with SMTP id y23mr16278otj.33.1540586957784;
 Fri, 26 Oct 2018 13:49:17 -0700 (PDT)
Date:   Fri, 26 Oct 2018 13:49:14 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1810260956230.4546@tvgsbejvaqbjf.bet>
Message-Id: <20181026204914.134946-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <nycvar.QRO.7.76.6.1810260956230.4546@tvgsbejvaqbjf.bet>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v3 2/3] shallow: offer to prune only non-existing entries
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Johannes.Schindelin@gmx.de
Cc:     jonathantanmy@google.com, gitster@pobox.com,
        christian.couder@gmail.com, git@vger.kernel.org, pclouds@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Thanks for confirming.
> 
> So even better would be to use `is_promisor_object(oid) ||
> has_object_file(oid)`, right?
> 
> This is something that is probably not even needed: as I mentioned, the
> shallow commits are *expected* to be local. It should not ever happen that
> they are fetched.

That would help, but I don't think it would help in the "fast-forward
from A to B where A is B's parent" case I describe in [1].

My suggestion was:

> It sounds safer to me to use the fast approach in this patch when the
> repository is not partial, and stick to the slow approach when it is.

which can be done by replacing "prune_shallow(0, 1)" in patch 3 with
"prune_shallow(0, !repository_format_partial_clone)", possibly with a comment
that the fast method checks object existence for each shallow line directly,
which is undesirable when the repository is a partial clone.
(repository_format_partial_clone is non-NULL with the name of the promisor
remote if the repository is a partial clone, and NULL otherwise).

[1] https://public-inbox.org/git/20181025185459.206127-1-jonathantanmy@google.com/
