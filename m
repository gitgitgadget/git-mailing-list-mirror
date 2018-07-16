Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47F8A1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 18:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbeGPT2h (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 15:28:37 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36530 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbeGPT2h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 15:28:37 -0400
Received: by mail-yb0-f196.google.com with SMTP id s1-v6so15838295ybk.3
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 11:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20i8t2Q4kmWlCRfZrTuLxMKQx1rv3OehU2tbV+qjNnk=;
        b=UR/zjm1wiPQP9N0QV6s8BKgX5TI/hIo20g5J3yg2V5pamn5QgIbJjICLBLmucNjvos
         WW+QtYZ8JIRKN7qYOBNO94hNO3wHydnPxslU+8VEeqCUMoJr+tKAUGZOLzRIQVl1QWKd
         PyblBizgEu+uI1qoD90qmb+uPoSk+vnKQs/iH0aTlj53A+SJXWnaq5+Ol8BzCFlvinVR
         oGMP5kQ/13N8WW8eIQdy+I4nTHCm6BbDmGsVzpKYydUO/qg33rFLChuDUcobke0RJ43W
         RA1o+fyZa6Ki+JKbhDvgjbCkZEGFaf983N8l6Wo81Jfy/nB+ogL7XhTS6m7HuphF35xX
         lEug==
X-Gm-Message-State: AOUpUlHHxm1r67IYNfVwN4KlZfuR0qIcG5gC0W/ieyIaDQILJwxM2j0X
        +BjVQot3MpSCgJnvzdDMktGGyuNCUUXukQ8RYGg=
X-Google-Smtp-Source: AAOMgpfZ3/dXeffyVpVavBSb5RK5a2wXqEna/GjiJKDPAXV/LlZ/M/yzazPzlZ+C5NDx8P9WvIzvlXu/nIs5K1F2dVY=
X-Received: by 2002:a25:8b04:: with SMTP id i4-v6mr9206895ybl.12.1531767593266;
 Mon, 16 Jul 2018 11:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com>
 <20180716161821.GB18150@sigill.intra.peff.net> <CAPig+cTVP2kubTEZBms_x1FvnqjGcX3pjTRXfjBMfMtdpbJt=Q@mail.gmail.com>
 <20180716185618.GD22298@sigill.intra.peff.net>
In-Reply-To: <20180716185618.GD22298@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 16 Jul 2018 14:59:42 -0400
Message-ID: <CAPig+cQ0t8nDnE9fVbo_wgth_Y2yuYM1O9AD1y6kvyHTqD57Yg@mail.gmail.com>
Subject: Re: [PATCH 00/16] Consolidate reachability logic
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 2:56 PM Jeff King <peff@peff.net> wrote:
> On Mon, Jul 16, 2018 at 02:40:21PM -0400, Eric Sunshine wrote:
> > On Mon, Jul 16, 2018 at 12:18 PM Jeff King <peff@peff.net> wrote:
> > > git-send-email uses the current time minus an offset, and then
> > > monotonically increases for each patch:
> >
> > Junio pointed this out to gitgitgadget developers in [1], which led to
> > an issue being opened[2]. That issue was merged today.
> >
> > [1]: https://public-inbox.org/git/xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com/
> > [2]: https://github.com/gitgitgadget/gitgitgadget/pull/15
>
> I was going to say "oh good, fixed", but it looks like it just merged
> adding that line to the TODO list. :)

Erm, right. I actually knew a couple days ago that that issue was just
a change to the TODO list but forgot that important tidbit when I
wrote the above "was merged today". Anyhow, at least it's on the
radar.
