Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E73B51F461
	for <e@80x24.org>; Thu,  5 Sep 2019 14:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390111AbfIEOxT (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 10:53:19 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:43560 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfIEOxS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 10:53:18 -0400
Received: by mail-oi1-f178.google.com with SMTP id t84so2057612oih.10
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 07:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daedalean.ai; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HFsEUSS0BYbJcOsaTsmrGgHb5AMVovr4/8WtjrbaG9k=;
        b=eN6nVUpbdy2G65J5wP9oB8V86US2oy2Pdl+PpLJrlluZKikOoKskQrdvRmH5Ip+0LY
         Zf5MCxEpjeEd/70F8m5lSm2tHUSpZO/Kn2tWhPHyPK60rCUbRjrdbE0NUUFTWJFvSgIv
         +VktKTQkPi0/mMuhsqJsr1RRgzlCx7AMi2O58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HFsEUSS0BYbJcOsaTsmrGgHb5AMVovr4/8WtjrbaG9k=;
        b=stBg5LVnIFiPl42Vlgldt8q6+DAvWUOA21w+ZlIlMi2/u7q+CcNTacabtxjsP29QGy
         aVmcmr0NM6m0z4989Cwli6X3UftrvsinWGDarYtXekO0nrgExF1Q1O5tScbk19v+lBZ5
         UR7GClrx+1/PpDKlAuWJlutjjZyJsHLiAj4S9zlmdo3lgBsgCCwsXVmQR+pulfzGqAkw
         MWdOemY8UO2K/NpCKMbwAPLXP1MUhsoBFkFWCMxrOB0jxhRleF9sbBqFuIY/dozA3Aeu
         qMu8Wx9Kryovg7qVXQ187w6FxsfdJ+oIH9UUw6aXifEQa+AucXo4fFmA12Zbhp3/tW6j
         9fPQ==
X-Gm-Message-State: APjAAAWwWUVqKRIUmQYl97yOgevqHrSIQngpUvBRoAKuIqezv0GBImzb
        pXWhh8k55kyh7b+c7333LBahMJSjR9hZ9jNqzVfDUg==
X-Google-Smtp-Source: APXvYqzshO9SEC1td0s0B4La/jzEZsDIKnnF0JWCZMdU22m78iCFejTgjWT2qzgKp/keRJrF7M8qwDQfhjiJVLH+N/A=
X-Received: by 2002:aca:1006:: with SMTP id 6mr2914510oiq.72.1567695197481;
 Thu, 05 Sep 2019 07:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <CACfeHrrajM8_p0=N8ZPm9h7ObcvWT5EnVa-gLhtDODdG9GeyBw@mail.gmail.com>
 <20190904031426.GC28836@sigill.intra.peff.net>
In-Reply-To: <20190904031426.GC28836@sigill.intra.peff.net>
From:   Grigory Yakushev <gy@daedalean.ai>
Date:   Thu, 5 Sep 2019 16:53:06 +0200
Message-ID: <CACfeHrpfSJ8fEwqr66snRnc3pEk_jTrYHCRLtKFgaL9p4ZKthQ@mail.gmail.com>
Subject: Re: Failure to fetch submodule with --depth=1 parameter
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Jeff!

Completely solved the problem for me.

On Wed, Sep 4, 2019 at 5:14 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Sep 03, 2019 at 05:30:02PM +0200, Grigory Yakushev wrote:
>
> > $ git --version
> > git version 2.17.1
> >
> > Repro:
> > $ git clone https://github.com/PX4/Firmware.git
> > $ cd Firmware
> > $ git submodule update --init --recursive --depth=1
> > ...
> > error: Server does not allow request for unadvertised object
> > 22df9475ca0d157e2db066a20f64c35906bf7f25
> > Fetched in submodule path 'Tools/sitl_gazebo', but it did not contain
> > 22df9475ca0d157e2db066a20f64c35906bf7f25. Direct fetching of that
> > commit failed.
> >
> > The same line without --depth=1 flag works fine:
> > $ git submodule update --init --recursive
>
> I think what's happening is this: the super-project (PX4/Firmware)
> points to a specific sha1 in the submodule (Tools/sitl_gazebo). But
> there's no branch pointing at that sha1, so the client cannot ask for it
> directly.
>
> As a fallback we instead fetch HEAD from the submodule and hope that we
> got the sha1 we needed. But because we pass along "--depth=1", that
> fallback is not likely to work.
>
> IMHO one obvious improvement on the client side is to have a third-level
> fallback to do a full clone, and hope we get it then.
>
> However, there may a be an easier solution. In the v2 protocol, Git does
> not enforce any advertisement or reachability properties for items the
> client asks for. So the client would be free to just ask for the sha1
> directly, no fallback required.
>
> Try setting:
>
>   git config --global protocol.version 2
>
> which seems to make it work.
>
> -Peff
