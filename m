Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE43A205C9
	for <e@80x24.org>; Sat,  7 Jan 2017 09:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932223AbdAGJIU (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 04:08:20 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:33253 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754216AbdAGJIP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 04:08:15 -0500
Received: by mail-io0-f181.google.com with SMTP id v96so49261725ioi.0
        for <git@vger.kernel.org>; Sat, 07 Jan 2017 01:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8X/8El0/9fWq+dT26o5vLSHdrXxLR34wkMnkssARzIw=;
        b=k6QenJrtFaD4ptLVsQaij7dWVHpLA82q8IvOTw+ttYVshKgbQ5X9EWboCd9KBtgoh4
         6SpVq69xJuHa/DpIFBewhFaKTx4piGRttXmss8ra9NIiMsbV/dxSvKWXhmuK62xb0jog
         LlZxiFjMoPuZwr4qKgQP55nMnuCrvn7LnDMjDckwTXP9KaS9Ukhl99ifK0il8ao/tAxT
         baDhQQnBiS1a8TBulvjt20mcGDWLHzDO0owxa5om8mjJ+9rTAoYbb4dtiTelg5hwggml
         /PwMHtojOroxTvCzDJgVBaYFzyiMr3Ra9MfUzmYE6UCbqj1Og66xIc6CIzbJLlXBnVSj
         QGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8X/8El0/9fWq+dT26o5vLSHdrXxLR34wkMnkssARzIw=;
        b=pPqgZ1uCbbWdy5cHxbfB5btMkehvjFciVx2fkVlEkfGKOPUBo7YDLQRgA8xp4XUftG
         5X8Jt78bO5EJbjq8AcKt7V+78KBaE6u20PGoLqfRB4t86oQhqvoCJnvvuvtiib2Sc17e
         HESzurvSBRjUVcFmptj1thL5jZahgY6pgqPZDcPTfp1ooMt6GMIdKpiSG7WgbM4JsgLN
         s0p/y7jIflm2MJlxqPsuJezozDFid46RBLbNfST1p8o5iuHbnB4XNEvziuSG/5bP4Cpy
         PVrlS7Px542JfveD23u81NU/xhoqFWSE7Pa3nWNdYtW/uy5Lvs9b5C2Zp2yIP6TeAy64
         4ANA==
X-Gm-Message-State: AIkVDXKHlsIasb6WO5B9wl7HqLXOi+gzlJDTjF4po1a686HXEhUEXST7R9y0//8FNOl+WBXBTNXccnj7asSaaw==
X-Received: by 10.107.44.137 with SMTP id s131mr61198411ios.212.1483780094284;
 Sat, 07 Jan 2017 01:08:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Sat, 7 Jan 2017 01:07:43 -0800 (PST)
In-Reply-To: <20170107012223.c27toqr6ck44kfpj@sigill.intra.peff.net>
References: <20170107011445.3e4fv6vdtimrwhgv@sigill.intra.peff.net> <20170107012223.c27toqr6ck44kfpj@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 7 Jan 2017 16:07:43 +0700
Message-ID: <CACsJy8BL+THd62J9e4QxuJ7HozUDe05959mTXBMK6E5i6a7WRQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] execv_dashed_external: wait for child on signal death
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, Trygve Aaberge <trygveaa@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 7, 2017 at 8:22 AM, Jeff King <peff@peff.net> wrote:
> When you hit ^C to interrupt a git command going to a pager,
> this usually leaves the pager running. But when a dashed
> external is in use, the pager ends up in a funny state and
> quits (but only after eating one more character from the
> terminal!). This fixes it.
>
> Explaining the reason will require a little background.
>
> ...

I see I have exposed a bug and I'm glad you are around to fix it. Even
reading your explanation is scary enough, let alone finding it.
Thanks!
-- 
Duy
