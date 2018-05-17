Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A27071F51C
	for <e@80x24.org>; Thu, 17 May 2018 21:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbeEQVsX (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 17:48:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36044 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeEQVsW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 17:48:22 -0400
Received: by mail-wr0-f194.google.com with SMTP id p4-v6so7138739wrh.3
        for <git@vger.kernel.org>; Thu, 17 May 2018 14:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xoII7LTtx0jXb2GsIvHmNQen9rZQzokC97eRU1jt96Q=;
        b=BE5K+rBI4RSwasyDgSEnuj5o6Awpe5jnPzSueVSvKNDL5Cg8i8SMm3DdsFzXVeE/Nn
         MLgqr+JVN/V8v5J5q2v5nnp9H7AelHvSGWy9y5IxrhLwWXXb0hEKmz8gOk47MEFeoK4P
         7IU9agei9TSS02bIqYEx9BHxB5t8KUJYHKI661W0p0zEMeCpGmmm65qprgn6d2MWR2si
         nGNFVcuNRACCC0CipW3jQg7q5E6F6UZJDyklfSuG9NY/KID94xi1o1I2ULn1qdHuGhhh
         q1PdWnc2RXaSESEgOxoz4i/LtD8XAitgcWowOkq4kAahliXJqWjK4mjrL+5GaEFYfioL
         PsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xoII7LTtx0jXb2GsIvHmNQen9rZQzokC97eRU1jt96Q=;
        b=QRAcG4wEDtc3XkTgEPVFpynCjbjiXcmKznBpDJtTGJNEJ/b28gB7HU77vMOZ9ZA8AJ
         gVqg+Fj6I8L5dZJfJzf/FmQD6UB6r3jsuxxEhK71J8P6RTOuD4wPvX9s+tCdg4wGrPcz
         +qE8QKp34HsyUg2lpJ6z6u9cuRAzm0GOF1Qe8Ek/KQxSydUxgBRPpOPpd2fEDFKUZ49I
         4DCws1l8wp69YXOiz/TfipU+RADfhibnylUR7PK21X0G1KLQJjpDX/oh/hulY8maYA1b
         GO2kTCTCbXAUrSKnf2PE0Ngh9gZsMpUH8i9h6I/VRZ+nj8Qkmd1uCaLoMLI2RfaRzneJ
         A1/g==
X-Gm-Message-State: ALKqPwfzPz+4nFq3N/FO3OYILz4QB/9ZbZ7Ncfp5uwcf/HMRLaJrxds8
        KCPUjG5kdH+60HodMybVfg8=
X-Google-Smtp-Source: AB8JxZpxh6Fa0W/8y9VKbESdKVyLb/+/ffG7dKjdjHGYGNdRngmihYpVtuWpIALpytFoLfaf7ydC6A==
X-Received: by 2002:adf:ce03:: with SMTP id p3-v6mr5388889wrn.110.1526593701257;
        Thu, 17 May 2018 14:48:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k23-v6sm7819253wrc.59.2018.05.17.14.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 14:48:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] merge: setup `opts` later in `checkout_fast_forward()`
References: <CABPp-BHm4B5vXZGHn_i6Aycvc_PDNWSFxLFo9s-ijb511VY9RA@mail.gmail.com>
        <cover.1526488122.git.martin.agren@gmail.com>
        <0b7440f21e9ff7a066802fe1e7cb3078cf4ed2b8.1526488122.git.martin.agren@gmail.com>
Date:   Fri, 18 May 2018 06:48:20 +0900
In-Reply-To: <0b7440f21e9ff7a066802fe1e7cb3078cf4ed2b8.1526488122.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 16 May 2018 18:30:58
 +0200")
Message-ID: <xmqqmuwy54yj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> After we initialize the various fields in `opts` but before we actually
> use them, we might return early. Move the initialization further down,
> to immediately before we use `opts`.
>
> This limits the scope of `opts` and will help a later commit fix a
> memory leak without having to worry about those early returns.
>
> This patch is best viewed using something like this (note the tab!):
> --color-moved --anchored="	trees[nr_trees] = parse_tree_indirect"

This side remark is interesting because it totally depends on how
you look at it.  I think "initialize opts late" and "attempt to
parse the trees first and fail early" are the sides of the same
coin, and the diff shown without the anchor matches the latter,
which is also perfectly acceptable interpretation of what this patch
does.

