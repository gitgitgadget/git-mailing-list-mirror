Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B961A1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 23:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757448AbcJTXAp (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 19:00:45 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33065 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753959AbcJTXAo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 19:00:44 -0400
Received: by mail-qk0-f181.google.com with SMTP id n189so123354095qke.0
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 16:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4+fvhEJ9xvrddtJKwno4f1BjBvOyg1OQFaqpVNVa4n8=;
        b=cjUFJ4X6z4y1sZ228UgrKp01D4XbeHb4LNafPdMYEesCVI4Hijo2wht7WyrjrQuHSZ
         V9WewgUIRy/z1yGsRMjqbJIoC+oEjuBJRfYw9JAPTrjW7rc4MZeBLQMc1tP6dfDNBGKn
         jWdiPr39ZkV6ywjzgWJNu/9ISDrIfZw0Of2M8hqxcJmak1gpOaduPENfxGGMPIFPAji4
         dxzK47AX1C80NeLWt2PYLktQJZl5ZYJ723eRPu11xorDUSMcr2Hv6QB4O37T/mSkO+WC
         BsJx76yAkZCr+BBMycfm1yux6F7zM2BXMWiWEKRG4M4WRGUOwMr9O4q0AHuE/5v4O1r7
         3f9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4+fvhEJ9xvrddtJKwno4f1BjBvOyg1OQFaqpVNVa4n8=;
        b=i0LR61+EbmfI0RqnX4pm5Fm0xzLupz1O6lYz6JTVLuzKtb7ZzeqylLJYNlww86iCAa
         U7qP5JE4EpP66PL6Hfk1L0efaNV0DDRLhOioYgWhbTZBolF/jmHQy4X91ohMca76wo7u
         2Olvi4AteUl0Tia+SQ+JzEZUjnsCBdrEi0hLIZqbEklR7t+W609te0glgsqg/KQOK95G
         OK/QsOQ2FYeySUZFjzILJD3JXDn+N/jjIMVHe4bm/RYGgcyYrWUMNTPOjLaOm5Q7dPtO
         mF2+2O7+iXxMlRFK1rlS0wfibdGNOv6kbejQ0a9iXyl6V8FchxWgj7niZsEGMoAwzqt8
         5vFg==
X-Gm-Message-State: ABUngvexD88AiPVgjMRsMiTpJQGCuiEWceffORD75GD7Nzm2vx0Q8aXVvrb18HySurAXazS5KGAm1nnlp504455L
X-Received: by 10.55.22.105 with SMTP id g102mr2702899qkh.86.1477004443843;
 Thu, 20 Oct 2016 16:00:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 20 Oct 2016 16:00:43 -0700 (PDT)
In-Reply-To: <20161012131027.GB84247@book.hvoigt.net>
References: <cover.1475851621.git.hvoigt@hvoigt.net> <81bdbf6a1295c17c1b9233c91da6e5eb4583785e.1475851621.git.hvoigt@hvoigt.net>
 <CAGZ79kZ5CPTuW2fARDs3BUt89b8H_=P3otZv+Vm5nTV70NLWtg@mail.gmail.com> <20161012131027.GB84247@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Oct 2016 16:00:43 -0700
Message-ID: <CAGZ79kZi+7=5auvU90weSHje_DrtPyyMbUadOveKa-5MzjGQFQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] serialize collection of refs that contain
 submodule changes
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Thanks. So I do not completely get what you are suggesting: args or kept
> it the way it is? Since in the end you are saying it is ok here ;) I
> mainly chose this name because I am substituting the argv variable which
> is already called 'argv' with this array. That might also be the reason
> why in so many locations with struct child_processe's we have the 'argv'
> name: Because they initially started with the old-style NULL terminated
> array.
>
> I am fine with it either way. Just tell me what you like :)

I think it's fine as is here; I was just confused when first seeing this code.

>
> Cheers Heiko
