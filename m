Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3AB20248
	for <e@80x24.org>; Tue, 26 Feb 2019 07:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfBZHIp (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 02:08:45 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35273 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfBZHIo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 02:08:44 -0500
Received: by mail-ed1-f65.google.com with SMTP id g19so9826517edp.2
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 23:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y60YCPLs206QPmBy8cm4MIkiShEGUvw1FDDjATZDDr0=;
        b=urJzCDj/5GKGppqgjr6OfpXkVIEZgchiVrwiiaRVzt/hJ5WGfYIxmusOYW6mgPjGR0
         k8X7NC0q16n05pEH7yAMX3hZOdJt1/4RFPMHECP5WYs3nre2eblfnVQZemWVfS7KAQkU
         m4cPKosyPrmjjTYeoZKFZgg6R0NwBaxMJ8NAdqSbcXQKS+0zkVc+KhrxBYs+Z0NjO7SJ
         PYI91C5IknthpgPAy0LmTnHxrm1JFMzWWEJwjvbL0wgubiEmjqUEKrZCekp2ekdO4Z1g
         6D3/O6aYmUL9rjlhVidE2XPQ3aUjoYZUi7i1AyaYEYnqJiYdfZGzi9KwPl2vyz0JST9v
         ATxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y60YCPLs206QPmBy8cm4MIkiShEGUvw1FDDjATZDDr0=;
        b=nhn0Z5uaT/qd74D1iWT1N/wYj99zBdfY9CpwHiJaKp6gUqRtPGzuhumQBtv6fDgN+P
         RV2EjedryVYNk5FXPfZ1Fx/OK0yhPZ2BgbmAhK3CayJts0oct8/0BjxCpsWJ4IoD4hSy
         +hi917NW6gGo7vI0d6P7VCJYL4C9vJJ3MxBB6eA8TR/oq8L/KkpcNIeKG6xcfJ/f24Er
         f0NbtmHZ/zITw2WVEVUhNDFP4ov9iPRidYPozS9skkD2dgPu1PXj1qwuvm/1Jdbg6dNV
         lDwcGM/AhzC6SxCynXAWUZqxDCSCw+zNQXtN8wahK0znxV/W+JBuNzUmHjMaljXKKUXU
         uwWg==
X-Gm-Message-State: AHQUAuaYCsWc1RvsZ9zKN+AlvQ9o+T9dJq39LBpHMRAV3d/6OIBTWn89
        cHT/sl01uv3DZsWvXnM0gk6nphW1qtECaGATmWpMqYmf
X-Google-Smtp-Source: AHgI3IYlXPhxTxRBZeuYqf52xgIFkHRf4WRrCnu6dyhRUVZcnai0T2yP7kqfhD12jTwN4xOG7WTC34eqC/1Ty4+NzEE=
X-Received: by 2002:a50:ae8a:: with SMTP id e10mr17989932edd.24.1551164923202;
 Mon, 25 Feb 2019 23:08:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com>
 <aae0f669627d7be45a967c6df464bf1ecdabce6d.1550963965.git.jonathantanmy@google.com>
 <CAP8UFD2RBU+f4=pB4CZHPHVO3DKXdGXVen=x3a8GvQHhGBG3aA@mail.gmail.com> <20190226015329.GE16965@google.com>
In-Reply-To: <20190226015329.GE16965@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 26 Feb 2019 08:08:32 +0100
Message-ID: <CAP8UFD2HvOriZyP6Dtx2Nvy3ZCi1aitk1-Xyk8fMPmZNJ6B4Uw@mail.gmail.com>
Subject: Re: [WIP 7/7] upload-pack: send part of packfile response as uri
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Feb 26, 2019 at 2:53 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Christian Couder wrote:
> > On Sun, Feb 24, 2019 at 12:39 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > Ok, so each URI sent in the packfile corresponds to exactly one
> > object. And when the client fetches one such URI it gets a packfile
> > that contains only the corresponding object. Or is there something I
> > misunderstood?
>
> I think it's worth separating the protocol and the server
> implementation:
>
> The protocol allows arbitrary packfiles --- they do not have to be
> single-object packfiles.
>
> This patch for a server implementation only uses it to serve
> single-object packfiles.

Ok, this explains things much better.

Thanks,
Christian.
