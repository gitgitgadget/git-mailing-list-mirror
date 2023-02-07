Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4979C636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 11:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjBGL6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 06:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjBGL6s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 06:58:48 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1580C65F
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 03:58:47 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id x4so18252200ybp.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 03:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w8KyHCLWFrVtYVazaUOMox3xbidxfcTeZJ9qhBNXf8o=;
        b=iFS6tobG41L0aOg2naBdhBQ02DM5bd/12j33yU5VADX/xzS8E3QGUNTgKRwaCdyFAo
         rtT1vr6VXyyFHpyKAUFBYYU3xSswjNvnOfs6Z7/+euO0khFZhz9cYxdgk7MB+rGjPoJh
         LH0S33dAduSZFCLZFJC7UYAiMhvdVmYuYdHvf/BrU7S0K0d4vRJEiZNhUje1qlAjjQRW
         HLrjXT50jVJqUBMhvBa98rlcezkYndc5EkK4Fcjugd5hQmtZeGqjG2gPUKVe4i6fNKUz
         MdMZ+9WF7nPxYG3VkIXJNoHJ4waMIRDrbezpkl8uIRU2t6DU5gjPutt3bsnSP+Qx+Wbf
         z5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8KyHCLWFrVtYVazaUOMox3xbidxfcTeZJ9qhBNXf8o=;
        b=4ROa4Pl0hL+NYXK14E4WcJw+6PcbyZQIA/B5pvwCGRLVia2WC/aypxxCRCOaU8VLo1
         2OaTP+MRunMXXAK0K43elKNS5cHTwBUnbf9Qe5Qe70nWxx33WsI45DP2xM4oahGcZUOV
         RYQepH96P1SWrDWRkad+liQZlDeck3O9sirnaMh82XwpHXiB5gqO5dxrHhmOQyYNQ2AU
         y8wvvRYuDcYQ+EKOVzn2yPDUxaJm5mx5p8mzatAICg5uD2MXRHSODIEKwjV3Nhf0S4wL
         BUsJRSUX5OOx1h/546cjP4skthZ8/8MQatQEPsEgEZqxK9rGAyoZbUfMuOD0szL4RE+K
         AaBA==
X-Gm-Message-State: AO0yUKUuXwLJp9BxcMKAs5nyVeFk+lE3KH/nBy8eayDDAFufLmF4s7zj
        jJxauFgacscPZuNR3vp+heee+UqPT8l4HXzos+EZJZAZ
X-Google-Smtp-Source: AK7set/FYknKPtAqu/xyIWZbwpD1E7qo4L2Je0GxiTxWW7reIGB2/NmjaHOx/wlxjPTlkwWd0JnbGj2pfvyy7J5rMWU=
X-Received: by 2002:a25:8c8b:0:b0:802:4849:af69 with SMTP id
 m11-20020a258c8b000000b008024849af69mr386051ybl.13.1675771126895; Tue, 07 Feb
 2023 03:58:46 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD3jzX5zRRYKS5uES2X9vB4eKJruzT7o6+7KytqLSmmZRg@mail.gmail.com>
 <d8ce0159-c9dc-25c2-4180-70518bb31bfc@gmail.com> <CAP8UFD32nDLR8BrhmeTpyraX3QBrc=U1ody+qgyMVY+_-HrASA@mail.gmail.com>
 <CA+CkUQ-t3-jOaGE4yMHXxREBs3-t35NCAJ3VTSnMSq5072rsBg@mail.gmail.com> <35c20121-f9ea-295a-b840-5bf380b26b81@gmail.com>
In-Reply-To: <35c20121-f9ea-295a-b840-5bf380b26b81@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 7 Feb 2023 12:58:35 +0100
Message-ID: <CAP8UFD3685b=gvdV-m0zHMAxhf1xw767Cn7JvMncgtXK5cGqvQ@mail.gmail.com>
Subject: Re: GSoC 2023
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kaartic and Hariom,

On Mon, Feb 6, 2023 at 6:44 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:

> On 06/02/23 01:20, Hariom verma wrote:
> >
> > On Tue, Jan 24, 2023 at 10:08 PM Christian Couder
> > <christian.couder@gmail.com> wrote:
> >>
> >> I removed the "Reachability bitmap improvements" idea but left the 2 others:
> >>
> >>    - More Sparse Index Integrations (I removed `git mv` in the list of
> >> commands that need to be improved though)
> >>    - Unify ref-filter formats with other pretty formats
> >>
> >> On both of them I removed all possible mentors except me though. They
> >> are welcome to tell me that they should be added back.
> >
> > I'm positive that I'll be available by the time the GSoC contribution
> > officially starts.
> > You can add me back to "Unify ref-filter formats with other pretty formats".
> > I would be happy to co-mentor it with you.

Great, thank you! I am happy to co-mentor again with you!

> Thank you for volunteering. I've added you back as a possible mentor for
> the project hoping Christian would be fine with it.

Thanks for updating the idea page!
