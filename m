Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D66DE2018E
	for <e@80x24.org>; Sun, 10 Jul 2016 21:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757287AbcGJVF5 (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 17:05:57 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35307 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757207AbcGJVF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 17:05:56 -0400
Received: by mail-oi0-f54.google.com with SMTP id r2so123911966oih.2
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 14:05:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1m6yAs0XR19MumAZLFSYBDxGUjdPXv9Kc5VJMFuyo0k=;
        b=cicI6bEMOBfEfJ2R0MhkTVI+UQ689yW6PcjdqskXIFNmLu+lkNwZYbozFMwQYCnpwL
         +uoSMjm60e0HRrR0UVvLymAVKLU8A+vnhkmqswqJ2P7Aw+0SdWJt7sHg6lwehlWdXPEO
         PFQ8XL0SCY5V5Rb09DJPcU1CtQsdewffTrVAEcqMAtZg58IYORYF6E5J6pXIH3BUYp/2
         8oq6rlarnmHyWRq66XyCeqVxx6BfOOmDhG1nG76dSz0KDk8sVMSx5GoOTAvoqBc1MQWJ
         QLqtqewDZ4Uc5G64wlK+jBS5Ac0o8BXjavj45aOTmvw7RBb6c86wCS9QEiORWUz54XRG
         pT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=1m6yAs0XR19MumAZLFSYBDxGUjdPXv9Kc5VJMFuyo0k=;
        b=P4ByLBnzIpjes+IL2qKAoMOWD7JG3QTGUFYld63zrYO/5D0wWl2HGbZ/DDevkRVJJL
         lQ5rc4mgJlGJKHFqjXRAVrGOEvk71Dp4zwwJgp6qzr8VSrXTG+QuQsQnvKNnehSE0LOg
         V/oDPlzFvBSZWQacaVLeh6CYXvTvoiMBKsYIUlxBKH0l4CGKrezVxcnV27q4U4UL9zV+
         uBhcRPZr4HKEfV0wFj96P6FMr46TGS2Z8iJaixrzOsI/QLDKgJ/LrlhB9QCvy9k4BQwb
         GlnHe3ehHXWBEDXs9NKtShQOoqcj6raQLYJfe1obOLKaSOpdV+B069tTFY6e7Xe/pP/d
         nl8w==
X-Gm-Message-State: ALyK8tLpZRvxq1FmK68MNVw5lJwsL3QLpPhs65lyMiYMJgEbT8ZtU02l9PoKiFv6mAUtRMjriPXwFxpydlQb5g==
X-Received: by 10.202.73.205 with SMTP id w196mr7473239oia.121.1468184755606;
 Sun, 10 Jul 2016 14:05:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.221.68 with HTTP; Sun, 10 Jul 2016 14:05:55 -0700 (PDT)
In-Reply-To: <CA+55aFyJP8FLaBtsMekzQDsCjDbFPa-qUZNHZNpvva2vZTRGgQ@mail.gmail.com>
References: <CA+55aFz=sZnABJr6F2yF_xvx6J6fZod6BbiL2OwszEnjjn-dEw@mail.gmail.com>
 <87eg712v5o.fsf@linux-m68k.org> <CA+55aFyJP8FLaBtsMekzQDsCjDbFPa-qUZNHZNpvva2vZTRGgQ@mail.gmail.com>
From:	Linus Torvalds <torvalds@linux-foundation.org>
Date:	Sun, 10 Jul 2016 14:05:55 -0700
X-Google-Sender-Auth: -GVb81-YmJvF8HFZp2niEzzahKE
Message-ID: <CA+55aFymKO5Bi2qZ-zaiZKQAk7RxusEMJ9Y0Gw6ywdznK+TaRQ@mail.gmail.com>
Subject: Re: Odd git overrflow bug?
To:	Andreas Schwab <schwab@linux-m68k.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 10, 2016 at 2:01 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll try to figure out why git-2.9.0 fails.

I'm getting "extra" being -1 in strbuf_grow(). Let me dog deeper.

           Linus
