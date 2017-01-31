Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48F421F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 22:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbdAaW3y (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 17:29:54 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36106 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbdAaW3x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 17:29:53 -0500
Received: by mail-pf0-f193.google.com with SMTP id 19so29986677pfo.3
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 14:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nUiXIk2BwsxoWItyitfHLacL6opE0i0zHyhqb7aPgUY=;
        b=jQpV/aZ4WZtY6kcmdmxS90WHEoyzGSJJQmrmXIU5SKGexgsLiXTryXa41GEXTN2oSp
         HEuXUstDBdfC95d7/VumGkWzGAymR4wZpmDoSYcqzzGCcM1m1d1m4SJ+Gl0aIIRIQMMn
         JpYDkNHKQA0wjOs6/Mg891X1VbBJBQVJLtBlcjcdyU9SXV1j039hJ0QQfKfAUI0axpqc
         0MJAxGkk/eu0crhfMY1p2s1H3TFrjZ9DNnmiq8980XrzFUJSS7imZEI/iyGGoExMuCWA
         ajDIzJvXVLWOffvLm9HL4VO+YhmPe+p0uU8yyCxUE/V0OKx9qJ0KqU6/0ACtGm/fz3S6
         MCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nUiXIk2BwsxoWItyitfHLacL6opE0i0zHyhqb7aPgUY=;
        b=Fzwcg1yDxmBe8IQYRNxHgsZu176jSb8uFM3ei1PuaC38JShf72xNHV1HCyNrdvNKfX
         +Y9QHWOlL39daNz/Ah5oDXAztAmnnNVeZpjKVbe0apcdOSvxnKX8eGdY8TbuU6NvDtxH
         rcDH5O6J/QaCX23dpAcYcZXfov7Pk3Ojn7h87VOME9tLDZM7HQ/yQLZoig6PRc+GpWPm
         46dniOJBxBSFkw0DBJb82uD53oU1oBxYeW1XDU1Nd4dPe5BoNkK2nQkH5W11lCqMzcG1
         sRSAhsua3JSRKuy0mdbjHa/5F0M1T1PTUi7CDU4p6nDQRSiY+S+KiEX2FelQ/ibZiVT1
         ByLA==
X-Gm-Message-State: AIkVDXKfBAf3ap/a7qibqJ6TckANUdiiYMUuLro4WpDa3p0EwrnI4/rO2TplcwCAFg0WWA==
X-Received: by 10.98.23.207 with SMTP id 198mr32115226pfx.103.1485901792519;
        Tue, 31 Jan 2017 14:29:52 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a052:8a35:4bb5:b253])
        by smtp.gmail.com with ESMTPSA id t14sm43619740pfk.85.2017.01.31.14.29.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jan 2017 14:29:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Brandon Williams <bmwill@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/5] add SWAP macro
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
        <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
        <alpine.DEB.2.20.1701301643260.3469@virtualbox>
        <aa653d57-4a97-ac50-b20c-f94ed43a22fb@kdbg.org>
        <alpine.DEB.2.20.1701302158110.3469@virtualbox>
        <77098ac8-1084-a5c4-a5e6-fb382e3dc3a0@web.de>
        <20170130222157.GC35626@google.com>
        <8e94756a-c3a5-9b81-268d-d0f36876f710@web.de>
        <20170131213507.uiwmkkcg7umvd3f4@sigill.intra.peff.net>
Date:   Tue, 31 Jan 2017 14:29:51 -0800
In-Reply-To: <20170131213507.uiwmkkcg7umvd3f4@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 31 Jan 2017 22:35:08 +0100")
Message-ID: <xmqqy3xqq2w0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... I wonder if it would be more natural for it to take
> pointers-to-objects, making it look more like a real function (i.e.,
> SWAP(&a, &b) instead of SWAP(a, b)". And then these funny corner cases
> become quite obvious in the caller, because the caller is the one who
> has to type "&".

Hmmmm.  

While this looks very attractive in theory by forcing 'a' and 'b' to
be lvalues, it probably invites mistakes go unnoticed during the
review when the code wants to swap two pointer variables.  

For example,

apply.c:            SWAP(p->new_name, p->old_name);

is now a bug and will swap only the first byte of these names, and
the correct way to spell it would become:

apply.c:            SWAP(&p->new_name, &p->old_name);

The latter clearly looks like swapping the new and old names, which
is good, but I do not have any confidence that I will immediately
spot a bug when presented the former under the new world order.
