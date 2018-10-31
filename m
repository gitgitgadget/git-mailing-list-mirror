Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F9C31F453
	for <e@80x24.org>; Wed, 31 Oct 2018 05:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeJaOmt (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 10:42:49 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:38738 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbeJaOms (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 10:42:48 -0400
Received: by mail-vs1-f54.google.com with SMTP id x64so2546734vsa.5
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 22:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FtGv7BeToXFJhwr+L8yU5+GSmszsBVchUD3WMUVR9HQ=;
        b=FHYEl/u/mYIdTYc9TNUEgAzjmEDTLkwENkHLpSv29MM7m+TbTNKJK1kwEy65Z/+Lw9
         ZEGX7WzJ9QOidMCKVJnHyzqif+lxhgvp29b3G6zkyzZf5JDWJ3an12zkD7bCIaTMCrl/
         mDoA+c/e2njs9yfoEqZ2fHyfObedJun1WaKDPGc+4kUqwloP6jvU5pUAZRQ3/JeMiGH4
         Xnbfx0C5CbAALX61bf5+ESuO6kq7QGLmK8CPyU0flGY+ctZgPcHV0NguyGlw0XoqWtNq
         VO6fNsQrMmjsOxYCDMRgx2l/St9jI7N5griLQc2NgK1mSF9Q5ZdSw1xlGCVb1Z/QkRoh
         Ci7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FtGv7BeToXFJhwr+L8yU5+GSmszsBVchUD3WMUVR9HQ=;
        b=VKjrZ8EbTMkpzRml24Vkx5+4xv+GE7y/Wytdra2lGvcnMe61RvwKfkWUus6HRzTVom
         jIktuNcn72vkp1GeW4Q208LfvcF5po0tCfWfXbrCX9RAZGaSZFbxv5t2LL2BtB/BQb8/
         zE9rKaPemvSPm3j3zV+tWueSYNqCQ4ZS31Hv4ignz9DwWGK3klbVBQG22e4azvOE9Hyh
         3kSoJ2OYHamnysATxl2GxJASOx+LeA7NT3/JAyN2Lnq6068PegAVHJBqLIcSX20zRIXl
         mEPMoXrfH2R+nVYSTs9mpNkqjsZp5U1rjFzjWxWGj1ViPjWXj5mxlZfsJdyoNna5dskJ
         vjtA==
X-Gm-Message-State: AGRZ1gIYqaeCn4bzDIwXRtAficQwCVaSsLFC600jyjTknj9zwGi2KS10
        CfU1fapsvH07AMiu33OS1P/hLeSLVTDwgR+/HjE=
X-Google-Smtp-Source: AJdET5cI1TGag3az0A8anInu2EV1wjDVLJTjYpcrHjVQMf9c5zEXFv1rSy3Nko0YnHiLlIimLVYEev6gvrRUqoHqwp4=
X-Received: by 2002:a67:e44f:: with SMTP id n15mr736706vsm.116.1540964771945;
 Tue, 30 Oct 2018 22:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BECpSOxudovjbDG_3W9wus102RW+E+qPmd4g3Qyd-QDKQ@mail.gmail.com>
 <CACBZZX5=CGvYqe07a5yzxc-=U92oSR5u7tpzJDEBEMzY6NDovA@mail.gmail.com>
In-Reply-To: <CACBZZX5=CGvYqe07a5yzxc-=U92oSR5u7tpzJDEBEMzY6NDovA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Oct 2018 22:46:01 -0700
Message-ID: <CABPp-BF1JwtTCQ0EqSWZ-VaXJogtBDJs9HqFQFcWxHV3x0_SzA@mail.gmail.com>
Subject: Re: commit-graph is cool (overcoming add_missing_tags() perf issues)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2018 at 9:23 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Oct 17, 2018 at 8:41 PM Elijah Newren <newren@gmail.com> wrote:
> > (And in the mean time I gave the user a one-liner to nuke his
> > local-only tags that I suspect he doesn't need.)
>
> Just a note that you can usually set 'fetch.pruneTags=3Dtrue' these days
> to make that happen.

TIL.  Thanks for the heads up.
