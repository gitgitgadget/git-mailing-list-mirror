Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C601F403
	for <e@80x24.org>; Sat,  9 Jun 2018 08:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbeFIIpn (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 04:45:43 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34017 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeFIIpm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 04:45:42 -0400
Received: by mail-ot0-f193.google.com with SMTP id r18-v6so3954197otk.1
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 01:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8IlbqeXOr6hFXtvNxYQuyr5gBuQ4+o0Mz+MOo0PUmLU=;
        b=i5dXhL6NlfRtLddqOL0K/iHA3RKx0iogS87zoYt/Z7qXpaXvHX1JqsoNlB441qHxZK
         dcbe0Guc2WgsB6/45m/JGEFRib++sGa5Y7wcPJlms8X4MnWj5iHUDwuQpbgmjsQ65mQI
         ftUsR100tx+qI7RQ1tiU2a1BlQEUfL0b0Ui7g5KDPEomONlZyaZdQnycDAVh2Y/dWcvV
         Hj5XFd77DJxwHqDwOXfwxYHbebEFgSrn7yRUmHXmD1mtKzCMi5ljRndZ548/HaKK3aKw
         qEoqwBROvM0i1ICZLOrt6lXzv955JeLnPlc3dOmfF5jQ5bnhxDyfJkPZUyDPiMcdNrx1
         Bhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IlbqeXOr6hFXtvNxYQuyr5gBuQ4+o0Mz+MOo0PUmLU=;
        b=f3HkQedlFNyNYIdMemESp6Cx/isMGofQo9eaXJaG0b7ZUmkcZXIfsMSSFI7xBBu3Ka
         WnnohgDsrXs/my0M/HKSFPVwSSt8kvBveRaR1PxvpqyWdQMTx+t7lyqPOmGn3qptZoDc
         dh5M85hBr0SJXgKVoSLE96QrTD/TSPVVknhbBasLHGVQ3FPA1jNnfOxW1K28jpraEZ9x
         upQiyNK3V8FFtvvggC/7nGZYmSqHhz2GV5kkXhSVpgYctrTg/1PWWaO1Op4BgsBpgf2a
         PxkE1flHimM/vp592nN1WCFwAMKyPyLe7Ac4KAuBLPRoqnALYzc022e6M653CD/ylW3x
         R9qg==
X-Gm-Message-State: APt69E0IQyiIJF+51mGYDqcKgtbFMgf53/MxOdf1pOWARj1R2DpQBuUY
        VcPPt007a0fsu5OAuT4Nc9Dw450KTzDjDiT0+3I=
X-Google-Smtp-Source: ADUXVKKye83wTWMGxvOfb/rx9wBWzxlVw5jh8vctbcOOQAsOpgo2NFJT4tg9nEbf6EzqEajhTWkJYmuKfaLcuxXR/68=
X-Received: by 2002:a9d:55a8:: with SMTP id m37-v6mr5897508oth.75.1528533941710;
 Sat, 09 Jun 2018 01:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180609083159.GA6158@sigill.intra.peff.net>
In-Reply-To: <20180609083159.GA6158@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Jun 2018 10:45:15 +0200
Message-ID: <CACsJy8Cpd_0CR9F_xyQfcw0j8ceOf777KcWXLHuxY1NxmRnXqw@mail.gmail.com>
Subject: Re: [PATCH] fsck: avoid looking at NULL blob->object
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 9, 2018 at 10:34 AM Jeff King <peff@peff.net> wrote:
>
> Commit 159e7b080b (fsck: detect gitmodules files,
> 2018-05-02) taught fsck to look at the content of
> .gitmodules files. If the object turns out not to be a blob
> at all, we just complain and punt on checking the content.
> And since this was such an obvious and trivial code path, I
> didn't even bother to add a test.
>
> Except it _does_ do one non-trivial thing, which is call the
> report() function, which wants us to pass a pointer to a
> "struct object". Which we don't have (we have only a "struct
> object_id"). So we erroneously passed the NULL object, which
> ends up segfaulting.
>
> It seems like we could refactor report() to just take the
> object_id itself. But we pass the object pointer along to
> a callback function, and indeed this ends up in
> builtin/fsck.c's objreport() which does want to look at
> other parts of the object (like the type).

And objreport() can handle OBJ_NONE well, which is the type given by
lookup_unknown_object(). So yeah this looks good.

> So instead, let's just use lookup_unknown_object() to get
> the real "struct object", and pass that.
-- 
Duy
