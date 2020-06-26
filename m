Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15786C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 10:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F7720EDD
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 10:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpMmYK3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgFZKIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgFZKIn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 06:08:43 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4ECC08C5C1
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 03:08:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b6so8894350wrs.11
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 03:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PWiPRZqE1211neQKS9wgvOnrqsTqfqcVhsew0/4vIfw=;
        b=HpMmYK3hjlj9275cGn++Xh/YU6XvziCDUB+vZHhwgR9HbCOmnTfEr3rVdzmVYx9Lzq
         BH80l3oEJomdaOfUD9tw9m/k22BdaSWe8MLF78fK4Avv7sd5I9CQLylFbc058be8aK9C
         QyJt95XC+SEneH5h4X0ki8jGng8my/NVIuFk6ALHE/uAmSypmrCiQU5+FCQq36Agh3gj
         kEiloFS14bqfofyDUaD/ajRWAPszvNEqZ42VIaWmG1aEEIfZbyP6rz1QjZOLVWLvafRo
         IDNmjIm5W/Q0dlIhEcawwQvyegB+yin8TT9dwHcrhW3aDCa20u3u5dzFqvzqDBKmzCjI
         Q5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PWiPRZqE1211neQKS9wgvOnrqsTqfqcVhsew0/4vIfw=;
        b=L3DYdZW5fCVgeAYxOYjWqmMRE+46ZTiMUiM66gMIw9u9vklPEQNDjwqO00V7LOOm/z
         Mgjs4/S0DdpXdEB4DCkoLYJtJDkDqowl2RkN5QfmfuuaKmHL/HreTAnHv8iJ3m5hrFVY
         qXQxsL2oX6+Ic0e0+LzWbFgITJ6b66OO42/fBquGR4xAUyyLaanjcqxtEIejSjW/Vw5r
         z3PIZxz1JrZuR0zxf+MhZuT+VKBrbq2vb886MyFAHys2Kt0DQJgYVk8HArDDN6jxQHbn
         1rjoOa6dX2vgK7Tk4gi+EDdhq+20WGB5SgtGZ8Dr3XWaDwr/MaoIRt+TORJy2cIW2Xay
         k6Eg==
X-Gm-Message-State: AOAM5312bbJWaBoAsIpwOx4idOEUpc0Ag4XiXZyovQISPraNSEC26/Dq
        +6t+A7Cu88oOe8X3JZwyFMKr+tzypk+zP3+Sni0=
X-Google-Smtp-Source: ABdhPJzYSvv2XAapTXa9H+K88mp3ksJ75FvtonQN3ZHYt0Z3I2mdbXz8o2ugQkUD77/tWD8iCBWMoPtGjC0uc+oLexQ=
X-Received: by 2002:a5d:4b44:: with SMTP id w4mr2901529wrs.275.1593166121756;
 Fri, 26 Jun 2020 03:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <CAAOnFsNUB_+NZMGnu2yasL8tk_KTfqPY6JiHOpvYHiyY_Lytrw@mail.gmail.com> <20200624081907.GA32753@legohost>
In-Reply-To: <20200624081907.GA32753@legohost>
From:   Gunnar Liljas <gunnar.liljas@gmail.com>
Date:   Fri, 26 Jun 2020 12:08:30 +0200
Message-ID: <CAAOnFsM9cruRPV9mNgu=ANk+5xG6Q77S6pW+ZBQJOZewjw0yiQ@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     lego_12239@rambler.ru
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 24, 2020 at 10:19 AM <lego_12239@rambler.ru> wrote:
> Yes. That's sad. This is the real problem. Devs of some projects, whether
> they understand this or not, work as provocateurs and incite hatred between
> people. Their actions hurt black people. After that, black people will
> feel that almost everyone hates them(because it was done "for them").

I don't think many would feel that. More like that everyone ignores
them and their opinions. But that's just the thing, I can't and
shouldn't presume to know what others are thinking and feeling. If an
action is to be taken, I should at the very least do my best to
acquire this knowledge.

/Gunnar
