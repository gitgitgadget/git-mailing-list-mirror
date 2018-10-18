Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12C941F453
	for <e@80x24.org>; Thu, 18 Oct 2018 06:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeJRO7A (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 10:59:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53879 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeJRO67 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 10:58:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id y11-v6so4252371wma.3
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 23:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WKQvzXfSlomfpOLzctc0ykaWkNWXJPjN9sG7HYt4OuM=;
        b=iY6pXlyQheyrZQyT5U6qSdoWuKachsdkTLILyhUf2SWacGnw+rRxPoXLZuQTENS+Mg
         JuJyChKAQwN6xGDwBM92Rlr3ELkmh2FNczfug7MyKRr43s1eVot4oNunv4gLOE4/gqet
         eXWeiY79I6pFm4j+o9Ln+lDjNwnRq0qIkzGw+kSVJ44BUeUW4a2TlGMyYATB7aE/ua3i
         zogj3kmT7/GpSU/kJAyboWGg0GU/yVkN3U5EoNdEROhbzISHctHRyt3tZmqvtjtIjLC2
         UlG+TM4UJdqpIfbty978S77YGCSmeVN9VO/y9wgJK68Yimpp0JjyBKaQGM2iCIKVHNBZ
         c+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WKQvzXfSlomfpOLzctc0ykaWkNWXJPjN9sG7HYt4OuM=;
        b=spyR5gkbXKV2cm1CVAEB3wSon1bANqj+///4ZCmrVxRPKREOWxkWy1PBh8T+U/c0G2
         aU/C+2rlz/gPoBKruUMyOTgDL6v+IDHmcBl/imX8Rqnw/zNLgWtQ8khpyBFTiVqkckwP
         vfT9XuwgBsL8xEw20FGib6TP97pqZKCiwrH3jcLPKG2behrfZz84jtqwS2ft6kUJiiGT
         rzD+KBSHfNX0xzH+ahHcVqdoTn6ROyGLnNNDFXhBIitS9UvnVxix5t7k0JjAxCea3X2n
         X8opTERvn2i8r02arJIfM0jSeTZor2En+vJEOlRHIYy7rNAtWzrFNMpMKCO3ZmwJeAGc
         27gQ==
X-Gm-Message-State: ABuFfohB25NxorciM2Xmc/LX3Ta2s/kSrcoH0U2fMyPpPNycoy/c0/L8
        h1lxxjna3JExj0VnKe+S9Pk=
X-Google-Smtp-Source: ACcGV62zc33qm8/sgKEzjigsgvSdKR+5l+k9N6E/FAGie5DZn8c4FswlyeIAgBDSnzrD5MqXpG961A==
X-Received: by 2002:a1c:cf4e:: with SMTP id f75-v6mr6048117wmg.81.1539845964839;
        Wed, 17 Oct 2018 23:59:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e14-v6sm19480585wrt.76.2018.10.17.23.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 23:59:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, git@vger.kernel.org,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [RFC] revision: Add --sticky-default option
References: <20181016212438.30176-1-agruenba@redhat.com>
        <20181017091215.GA2052@sigill.intra.peff.net>
        <CAHc6FU5mXL2j=jL=LqtRt30uBt8tGop350FnwK845fci-Qc=tg@mail.gmail.com>
        <20181017181350.GB28326@sigill.intra.peff.net>
        <xmqqva60uedt.fsf@gitster-ct.c.googlers.com>
        <20181018064845.GB23537@sigill.intra.peff.net>
Date:   Thu, 18 Oct 2018 15:59:23 +0900
In-Reply-To: <20181018064845.GB23537@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 18 Oct 2018 02:48:46 -0400")
Message-ID: <xmqqlg6vu4dw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Just to play devil's advocate, how about this:
>
>   git log --branches=jk/* --not origin/master
>
> Right now that shows nothing if there are no matching branches. But I
> think under the proposed behavior, it would start showing HEAD, which
> seems counter-intuitive.
>
> Or are we going to count any positive selector as a positive ref, even
> if it matches nothing? 

That sounds like an intuitive behaviour of the command, but I may
change my mind when I look at other examples.  

When viewing that "--branches=jk/*" example in isolation, yes, these
positive selectors that could produce positive revs should defeat
the --default, especially when it is built-in (like "log").  When
given by the user, I am not sure.  With something like this:

	git rev-list --default=HEAD --branches=jk/* ^master

clearly the user anticipates that jk/* may or may not produce any
positive refs; otherwise there is no point specifying the default.

But anyway...

> I could buy that, though it means that the
> command above is subtly different from one or both of:
>
>   branches() {
>     git for-each-ref --format='%(refname)' refs/heads/jk/*
>   }
>
>   # is --stdin a selector, too?
>   branches | git log --stdin --not origin/master
>
>   # here we have no idea that the user did a query and must show HEAD
>   git log $(branches) --not origin/master

OK, scrap that---just as I predicted a few minutes ago, I now think
that "do we have a positive selector that can produce zero or more
result?" is an ill-defined question X-<.

Thanks for a doze of sanity.
