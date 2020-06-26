Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2BBC433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5678420791
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="ah+cg8Qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgFZQXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZQXG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 12:23:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949F5C03E979
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 09:23:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so10947664ljc.8
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 09:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dhf7mRdFF/WnIc1lJrUhR61Cse9xbV20yIIlujUEF3k=;
        b=ah+cg8QgVVFeM1yT2/l7NeYJu9AGUWqj/nnBC6dfwfAI/FB40XvOFf7oTBzzBdSeGQ
         GSQcSQfbuycKuZxU/YnnsDiSDGkyjHk1npSsVgLNwQPONQGNDV1Q/7mA9UvNqbggqvgB
         NIcTTSkbTC1wDqWPlqrJfTB9HTUfqa0xlCnC5sR7oNqDte0EKXI58rHdlIloO3GB0HvS
         wS09xo2fnqkPVc1y8IYzJy6ILWE7w/N6I2iSomeXuCbwrGqdkgBVTeAYX/q0cXZ+ZgFz
         0HT5GjtwUhoOQbA6RdTK9uQMXDrrAwlhQ+UseJDbNJZPKgmB2wcvYd8qoSIRR4hkvSdM
         ZuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dhf7mRdFF/WnIc1lJrUhR61Cse9xbV20yIIlujUEF3k=;
        b=BJlJOhffpLVTW64lsIGtiV6R7tTOh68F37AZkIFGMm9+3S9zIqyv3G4+I3v9qq5MZs
         6ATPvieXf5ZinXD7h6klauWJsno+5aEvIRWYg3f9ijK4zFAJn2zcsRxnqTaHAkjltAZS
         AA6Ow3FuqLHPbVFVul5Ftu2PoDdDWRgWK1SOYPzfTdquCSI7pqZog6cpBhDlpxFeXTCX
         0nyJGZGAtoLbmSW7oR8YSW1mLD06gYWZWCreQRHRtbhscwKcN973xw30ud3Oy5U0kd+y
         E9vW4Y5xPb/hitEgoJ4Vai1BJrVa1RkWwNE6Xw+IpKS1J4qOoa+ojV6oOXCN6WSjCd6m
         btTg==
X-Gm-Message-State: AOAM531QRPLlHOOh9UvA6MAeYmLFjRIULejiUm0ipKVAfaM9pKUhx8kL
        bZX6B9hvPfziiOZ+bTkOoJnx8NCRxGV+4Z2gTSboPA==
X-Google-Smtp-Source: ABdhPJwadqUWTrpD6HrbWAfiv5WJydjzeQoDc6T5QIp6nb8KDQsFU4kRPhrs+OUfd10+zZ4xy0wnHzcTVRwBo0ku0I0=
X-Received: by 2002:a05:651c:11c7:: with SMTP id z7mr1868576ljo.29.1593188584067;
 Fri, 26 Jun 2020 09:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200625013851.GA9782@camp.crustytoothpaste.net>
 <cover.1593115455.git.matheus.bernardino@usp.br> <CAP8UFD0oWuoYLwgYLbkSvDjV1Ymedd_E2j8iv3QGGitgRVq6=Q@mail.gmail.com>
In-Reply-To: <CAP8UFD0oWuoYLwgYLbkSvDjV1Ymedd_E2j8iv3QGGitgRVq6=Q@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 26 Jun 2020 13:22:52 -0300
Message-ID: <CAHd-oW4bgEv7w2e-wD5aqje_esHA8-_ZgR9trbJXYJ8-M_4F4g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Make oid_to_hex() thread-safe
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Christian

Thanks for the feedback!

On Fri, Jun 26, 2020 at 5:22 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Jun 26, 2020 at 1:35 AM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > My idea was to implement a xstrerror() wrapper which calls the
> > appropriate thread-safe function (dependant on the OS),
[...]
> > We could also set a thread local buffer array, as in the second patch of
> > this series, to excuse callers from allocating/freeing memory.
>
> I don't think caller allocating/freeing memory for error strings is a
> performance or code simplification issue.

Yeah, I agree that passing a buffer to xstrerror() should be fine. The
problem is that we already have many uses of strerror() (98, according
to git-grep), which expect a static buffer in return. So the change
would be too big :(

> > Finally, should such change also come with a coccinelle patch to replace
> > usages of strerror() with xstrerror()? Or better not, as the change
> > would be too big?
>
> I would agree that it's better to avoid too big changes. I am not sure
> how much we want to automate and check that though.

Another alternative would be to replace the definition of strerror() with a:

#define strerror(errnum) xstrerror(errnum)

This way, all the 98 current strerror() callers would start using the
thread-safe version without the need to change them.... However, I
don't think I've ever seen such a replacement in our codebase before
(besides the banned functions in banned.h). Also, people might expect
strerror() to refer to the system version, and perhaps make wrong
assumptions about it? I'm not sure which is the best alternative, it's
a tricky issue :(
