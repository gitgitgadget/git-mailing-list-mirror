Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E5221F453
	for <e@80x24.org>; Fri,  2 Nov 2018 19:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeKCE6s (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 00:58:48 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42320 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeKCE6s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 00:58:48 -0400
Received: by mail-ed1-f50.google.com with SMTP id h21-v6so2272151edq.9
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 12:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqX3laNON+S5SrGeVI6A56ZKDG7DR+7FkevDLt6mZ1E=;
        b=DF+CAGfi2f82jMyjkeitmVHN+SOAC+nLr/5XQ22uWpAvbDbt/b0keeQDxPw0u7TTer
         UqK94SVquTF33VppmL5+VtlmW/xZOuQfCaMVeVuM29bLRRF4Q3qh7AiIYSUNsQZRrxaC
         LFKPd+PmpP23MDUc8G1gcrxLstqswAalxLh9mm/y2siZ950NVHS+RmdHig4CEff2LCch
         4WW5ty1l5e8X2hoe24e/Cn35BYLKzZJtMg5oCa9g8OsQ/QcJ5gtXOE0GWHuVFKnWCGCJ
         EDEhRJadawLi31TKiOfjysaMqwgSkKmgzhtXrZzP8pF80H6RGX0K12lrzsehN9ODOx4s
         50Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqX3laNON+S5SrGeVI6A56ZKDG7DR+7FkevDLt6mZ1E=;
        b=Sav8vZSwh9Gh4wtap2Tx76ey7CKVWi/CtVvMq8dlSoqUT0/7A6y4oYeEzlbljdBV6C
         T83tj3PAaXIMnRCo55B/bKST95ooFgmp5vCYIJ8LdLrvHfWJTiMxoHO0vpoQDA05BjLO
         mbPmq+eXrbXVrucWGkv7aGAkvCbTXPvagcJA3AvPwpjtzAilcVTHZZoG/QXjihPC7XpC
         nEmyMQcJGI9d8bEQbIeJJ8WOTJ1NIyVxKK/eFB0mVEhAASBHel+F19ENxqWkRHxBVvAg
         m3JfE/AuH53DuUc9BvP/UJ6uhC6i4aSkyw+XmW1IpL5bUKoQ72zZi+BIPr8cpFPPxNFl
         T6Bw==
X-Gm-Message-State: AGRZ1gIRhKfUq7G1Cu/zkFKnxCdN8dS+JEGjToQJZspctxD2XLGUOoAp
        y1oy9DFdA4EAmAf53IFtGlLiU0nLexX+fRkR/WWSIg==
X-Google-Smtp-Source: AJdET5fayuMvMARoSbhgGI+e1JocQdjRBB0eg3IpInJwP3KniYsIAnm2UTy3fkhVcl/4CawF4l63qFpEecQgKCBaAa8=
X-Received: by 2002:a17:906:45d8:: with SMTP id z24-v6mr7403853ejq.19.1541188217085;
 Fri, 02 Nov 2018 12:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181102063156.GA30252@sigill.intra.peff.net> <20181102063606.GC31216@sigill.intra.peff.net>
In-Reply-To: <20181102063606.GC31216@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Nov 2018 12:50:05 -0700
Message-ID: <CAGZ79kZb7kMhkE=EWRtR8tpkQCY3v8rWugHvq24TFGHpBxmygw@mail.gmail.com>
Subject: Re: [PATCH 3/9] diff: avoid generating unused hunk header lines
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +/*
> + * Can be used as a no-op hunk_fn for xdi_diff_outf(), since a NULL
> + * one just sends the hunk line to the line_fn callback).
> + */
> +void discard_hunk_line(void *, long, long, long, long, const char *, long);

Recently we had the discussion on style and naming things.
On the one hand I don't know what these 4 different longs do,
so I'd wish for some descriptive variable names in here.
On the other hand the docs explain clearly why I don't need
to care (a no-op ignores all of the parameters, no need
to take care of their order)

So to revive that discussion, I would strongly prefer
to have *some* names there, for the sake of a
simply described coding style without many exceptions
(especially those exceptions that rely on judgement).

Today I read [1], which describes the analog in the
mechanical world: To evolve and have more impact
you need tighter requirements on some parts. And
I would roughly translate that to our use case as
not having to worry about style (it's ironic I even type
out this email... if we could just run clang format or
some other tightly controlling formatter/linter, I'd be
much happier as our focus should be elsewhere,
such as UX or performance).

Apart from that, I read the whole series, and found
it a pleasant read.

Thanks,
Stefan

[1] https://www.nybooks.com/articles/2018/10/25/precision-accuracy-perfectionism/
