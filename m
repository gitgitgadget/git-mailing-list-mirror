Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC1E20374
	for <e@80x24.org>; Mon, 15 Apr 2019 10:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfDOKhx (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 06:37:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35778 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfDOKhx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 06:37:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id y67so948840ede.2
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 03:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2Oy+p9z/OKqMGXZbF7DQiZ2twSYVGXjSJwXB+ionbE=;
        b=KlqYSK6TNqf5wXfM0lLmIXo8J516sEUFC1SkN+xn2At8ckxxZUJKYTMIPxhXqUXwFJ
         6REboAhYVNkaFXyWG203+/K+xeKDe91KaPDMdsEO0M3j6JKKzUWNyMq5jX4+yGA+CKed
         PPtJtuJSbYAt4JeZiJmHsfM6yLGziVlKoya3V+FKZJDd8CKqE7NNzfxfo8Zuo6bl9idB
         wL3Aj/JJ84yy0AH3ArqdCq79+/DT9+z5ZEJojDJjyPd7N/18QBYwcM+l0NnPX3UwlzWu
         rwGEXblLLu2efKpYfwGwdLfqUP5Q5xXnR8FstntwCTy82xkwnDUSla2A//ritcCeo4K3
         5dFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2Oy+p9z/OKqMGXZbF7DQiZ2twSYVGXjSJwXB+ionbE=;
        b=mqqwLXouAxm1PAr8IfDg9mAM8ot1YkJxYJtFadRAII8ne+tI/BNUV6zrO6cJg2JEdE
         wrSXBjbFtW2T/rXn4qYuXVUp1YYKIz1a/JYBtE8u5WFMYWKk0F1DHLhTadiEj5jX4rvu
         10G8lgjS7F+Ox02dDafAQIKlt3HahvAqRQ4sh4UZ4JPzEUbAkYJsnykN6wRgo447Hszv
         7WHBZu0ePbMDGzW7jZaNdZ0braaKruL4/clGYdXxRWB1xG/sav4FCP1iPjy9rmFg4K+1
         kp+VUt6wDHhK4K7DIvfp2EIpTDbt03K/OzuLSF4sw9TOU2Trd3DJ7uupXw/3o2vGBJjj
         hJOA==
X-Gm-Message-State: APjAAAXdM4s1zMJcg9Q2W6nGI7zElRY5MCYgJFJ0Apb6GeEaWjbhBxWU
        83Fff8ZUQ+tZWoFBtP3TCz0u+0ZBKHxlbbwsrPU=
X-Google-Smtp-Source: APXvYqwO6ZhlDVwpWdYA8fuI3Pps2ieB7TJggN/gMML5VU+n/kKnJa23aBpAfwi5wemKvw+P1OqXkJvf1Qah9zB08Gs=
X-Received: by 2002:a17:906:d503:: with SMTP id ge3mr39557696ejb.2.1555324671541;
 Mon, 15 Apr 2019 03:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190409161116.30256-1-chriscool@tuxfamily.org> <xmqqmukrr52m.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmukrr52m.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 15 Apr 2019 12:37:40 +0200
Message-ID: <CAP8UFD3p+usPw=xwW7TWBZSZNGJKBgGRDNAFUocSkhO5--dvAA@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] Many promisor remotes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 15, 2019 at 11:27 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > This patch series is based on:
> >
> > 763fb763b8 (Merge branch 'jt/batch-fetch-blobs-in-diff' into jch, 2019-04-08)
> >
> > to avoid issues with jt/batch-fetch-blobs-in-diff.
>
> Yuck.  As an experienced contributor, you should know better than
> that by now to do that.  A merge into jch/pu are rebuilt at least
> once and often three times a day, and in no way a good solid base
> to build on top.

Sorry if it creates problems.

> If you really need to depend on another topic or two, please base
> your work on a merge between 'master' (or some well known ancestor
> of it) and the tips of the topics instead.

Ok I will do that then.

> Having said that, I thought that the semantic conflict has been
> corrected and the machinery to rebuild 'pu' has been replaying the
> correct resolution ever since, so there was no need for such a
> rebase?  Isn't it the case and do we still have the breakage due to
> semantic conflict with JTan's topic in 'pu'?

There is one patch in the series, Patch 8/16 (diff: use
promisor-remote.h instead of fetch-object.h), that fix the breakage,
so if the series is applied on top of jt/batch-fetch-blobs-in-diff, it
will apply correctly and if it is not applied on top of
jt/batch-fetch-blobs-in-diff then the patch can just be dropped and
everything else will apply correctly. I thought that it might be
better to make the fix explicit than to rely on the rebuild machinery.
