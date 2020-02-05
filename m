Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B255C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 23:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3AC214AF
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 23:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0ff7AtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgBEXFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 18:05:16 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41740 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgBEXFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 18:05:16 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so3872012eds.8
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 15:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O3GjVrpOFNFcSuapARVLRBK3a+oxUEznNa2nRfB4eDA=;
        b=W0ff7AtDyUi3PmqFn9zVn9PFwxH9Og3yiHtqoNJNSGdYpdBv9SIyLgWoN+WOcqyCg3
         x461SmWDxuHJrYOApHx5nJNsFFpM/G1detAyrzOy5djeAsbEQ6k/J8voH58HbfR4ZT6C
         zq4ls+TqeayBqHeK3m887v2aGCEcGFxX/IP6xX34avQ4ApjoiQYiUpKrWnjtX49RmS1x
         m59E5/l8h0eino8ZOJ29/UQfBzA4563zpJ7KNiLQHoWfNnAC1vngvxxmRgMKjkJVU9qP
         +dCQ0KxhzotrJWOtM648/YPwMz66s4JiSZuId7oZvYCFJoMBBko5Bt4rsXbXZTaNDRkk
         rx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3GjVrpOFNFcSuapARVLRBK3a+oxUEznNa2nRfB4eDA=;
        b=MCxO64+yR5BYMn6WoawQnrLxf+FRaElAIIh8KAZWffl5bNFjTSpfdsglkjlOODpjbp
         Qr+qNRIH14i35PYHXefu0LR7IxIi16nKmTRWwoB2E3WvRRHlBmJuGaDTuoY/Qfru2ou/
         hjbEu6ckUC8PA3Pfxho5F1mpWxNhH2yOdhPUILf7ElwmW7pFYAhbZnmLdjdlUHSeXe4v
         xpdfqIDUCKVntQ7tpi87BAuAgPsbpoN1wr1FD8lykcwXWi0QNkRwwOrqeZjKnad+OdeJ
         2LR2QuEE0Jiqn2ehExGcUEDkxvGmoSbiTtELj8fCCWY5MP179vWI6DGYRZjp477R5ez5
         8A/w==
X-Gm-Message-State: APjAAAVn7c5httM4zx57hcERQl/mztkyXdHBiG5rdr3aIxKB9dZJgs+j
        e4pCOZA7mwt9cXBqCt/bTwkUag5rs+xwines5Fg=
X-Google-Smtp-Source: APXvYqy4wExBA4t7tuK3IJwVKcfRkTDg/oZvHLuxxWebdTAy9AhIdVV5DDNnZ9mfu/px+XMgD7pVgiImqtCgexVK95M=
X-Received: by 2002:a05:6402:70f:: with SMTP id w15mr408740edx.255.1580943914339;
 Wed, 05 Feb 2020 15:05:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.508.v2.git.1578438752.gitgitgadget@gmail.com>
 <pull.508.v3.git.1580346702203.gitgitgadget@gmail.com> <xmqqimksbo73.fsf@gitster-ct.c.googlers.com>
 <CACg5j27pTKuhZpZtgNUDNEkhG0+tGx5O=LJCr5E8+2q8v6Zu1w@mail.gmail.com>
 <xmqq7e10hgwn.fsf@gitster-ct.c.googlers.com> <CACg5j252=wKyh7Ar9vxTwxdYXgkjNvbMA=bJCKOc6UZRJfJmUg@mail.gmail.com>
 <xmqqy2tgfzk1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy2tgfzk1.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Thu, 6 Feb 2020 12:05:03 +1300
Message-ID: <CACg5j25YpyRbxmYccZZiG9m5a0DKm0RMD3ypy2JzhA-bmgB_9w@mail.gmail.com>
Subject: Re: [PATCH v3] add: use advice API to display hints
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 6, 2020 at 11:18 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Heba Waly <heba.waly@gmail.com> writes:
>
> > No, I agreed with my mentors to wait on this update until that branch
> > is merged in master.
>
> The users will first has to set advise.addnothing and then later has
> to set something different if you do so, no?
>

You're right, I missed that point, will send an update based on the
pickup branch shortly.

Thanks,
Heba
