Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6021F404
	for <e@80x24.org>; Wed, 29 Aug 2018 21:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeH3Bj6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 21:39:58 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43543 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbeH3Bj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 21:39:58 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so11830063oib.10
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/o3IIHQCG0CHInw8wuaKvyIE9xVj3kfYXcSS1ziwC8=;
        b=YO0lTw+xem4a2xYsZ45D7QA8FEmc15U2cqSFRcJcUkPLHaju07hE7zcxaZ1gBHaZ4w
         bd0FDRrw7lvXmWuLhZlk5qvlu37/lqIROujtg0Buq2yE7vhhln2fWuiFkoOO8ZZyGUNJ
         nu65MrGsWTOOmgLnVOM5rYQLoNjcSq83fOhk801lIVujcwoIzjgNKa6fxzQ7gF5+zJxP
         /QVkuhAQXJ/Ri9pkQjCbzawkFIoGElKUdIhogFCdnNz4wzqhBt+Hj4+7gedRt88J6JKb
         4EF9dmvIpLCbj3eGHzXbUQFbVJUe7zkYgD2986zKQyZGsA1nc1/PeF14pw+Mu+/MWCJJ
         XQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/o3IIHQCG0CHInw8wuaKvyIE9xVj3kfYXcSS1ziwC8=;
        b=A3YBQYhgUV4cEoSS+ArjNMUSGl7PJfEVuQBV+AjoEy5oFY9vZLNzFnAKtj0aCUdnoo
         Gdb90LzA7vzXup9Wb6a3oxUbiaYi4HVui/soDk0N9Ym5GhZGgfgbPqtVXYxxQgnVeR6N
         TovBfKF8PFLen9N3grdSBmRsKvDdtanBLhvnR+u0D+eAhjQeuT5val6dsJ9SuqSnkWsD
         hDGiDoyShQUi5+V9tpMHcRKS22+zpc2SvmuaM27BskzzF2CaSfo/njRPNcc2FXDCVpR1
         yda09NwnrBq01cvoWE4OORgol6/mAcwp5WrjDbCO1WHbaFYk0vtGir7nj0Mvb1SqVL4K
         NPbw==
X-Gm-Message-State: APzg51A9ZwQ39C7H2drdaAE5TMwaLFLTjikTd3kobrnlv8hpEZpJtlQ9
        KF5LiE9zWIDLWTAiQTY27mT3xFXbSZe5AVuBSFylE8cN
X-Google-Smtp-Source: ANB0VdYDDVSRmzGXjjxxj2If/KUsGKec4cL9sFHCLfkSLrsy5MZ9h1n3Ec0ws4OBzEoRU0IgrFJbq0OSjDW9LpQGTsA=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr4676215oia.229.1535578867561;
 Wed, 29 Aug 2018 14:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180829205857.77340-1-jannh@google.com> <20180829205857.77340-2-jannh@google.com>
 <20180829213433.GC29880@sigill.intra.peff.net>
In-Reply-To: <20180829213433.GC29880@sigill.intra.peff.net>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 Aug 2018 23:40:41 +0200
Message-ID: <CAG48ez2BL1fgP_FkUi=6EYAuA+ja3ujZFFqKkPQN50tRCEUJiQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] t/helper/test-delta: segfault on OOB access
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        pclouds@gmail.com, johannes.schindelin@gmx.de, nico@cam.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 11:34 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Aug 29, 2018 at 10:58:56PM +0200, Jann Horn wrote:
>
> > This ensures that any attempts to access memory directly after the input
> > buffer or delta buffer in a delta test will cause a segmentation fault.
> >
> > Inspired by vsftpd.
>
> Neat trick, but it seems funny to protect this one buffer in
> non-production code. Obviously you were interested in demonstrating the
> issue for your tests, but do we want to carry this all the time?
>
> If we want to detect this kind of thing in tests, we should probably be
> relying on tools like ASan, which would cover all mmaps.
>
> It would be nice if there was a low-cost way to detect this in
> production use, but it looks like this replaces mmap with
> read_in_full(), which I think is a non-starter for most uses.

I think even with ASAN, you'd still need read_in_full() or an mmap()
wrapper that fiddles with the ASAN shadow, because mmap() always maps
whole pages:

$ cat mmap-read-asan-blah.c
#include <sys/mman.h>
#include <stdlib.h>
int main(void) {
  volatile char *p = mmap(NULL, 1, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
  p[200] = 1;
}
$ gcc -o mmap-read-asan-blah mmap-read-asan-blah.c -fsanitize=address
$ ./mmap-read-asan-blah
$

But that aside, you do have a point about having some custom hack for
a single patch.
