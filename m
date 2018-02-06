Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E811F576
	for <e@80x24.org>; Tue,  6 Feb 2018 10:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeBFKRc (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 05:17:32 -0500
Received: from mail-ot0-f178.google.com ([74.125.82.178]:43760 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752854AbeBFKR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 05:17:28 -0500
Received: by mail-ot0-f178.google.com with SMTP id q12so1213418otg.10
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 02:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Tl0NWvf3TpuB1RS+Grg84lCZEhKl3cvXeNXnFGGt9DQ=;
        b=JzUtyJFSeYXdph9TZ7TkesLEhFsNYWJu/wa/z6a34p9XclO4In+5vzcHtXE8OaXfUH
         EcfpzpjO7W6ya4/pi8rVdXURYf8plg5/uo0TWb3iKkohuYXyIK84Pua4DNeXUWxmqEDx
         BwqTuIR0+12nHRJ5TKPY67YMChptSNaXZOB4OR/an5ynd7SbFKk3ncoeKpOTTKV6bCkV
         kqs9HXTdm5BRUg2kxo0aaRxJ31/K1qM6D/JZQ61UuEPS2gbKW0ukz5n685hMvhBT7a3j
         4deVTXd6Owm6ePhKUaD01nTy5LgHpktl54bUYcywzFdFiPjvEeIfhQvrDWotCbCMBq2E
         87GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Tl0NWvf3TpuB1RS+Grg84lCZEhKl3cvXeNXnFGGt9DQ=;
        b=fmz0TtmXqXvJoov3PDsiMyBPsKUA7q3ZIrovn4ny0L2BsnnvvqCXxMgrn/hEtrZbhj
         R5YjZuPKINlhPgFBMliGWjpxAB2KbaRhLymRK9ObwelVN4VevXlo7iOEfXZBRitt8SKk
         uoIQ3GKbGD2YUNmNDlFRQ7NviPaVxNXewe3/5oLAgNxIrib0ZQJKOstRsI6NbvssW1m2
         LJn5yHlYjbaI2/ZSa2K7ozBjE1iVMQL40NPU9Cq6gyaIaroT1WzdnEo81QYutdurBB9m
         sFTHgcpv40BzBNOuXrOvxqq5egabLnvj1UYHi7Xqx6aZSwVSu5lrc/YptcOrBGitsq6j
         RZ2g==
X-Gm-Message-State: APf1xPDmDevYTd90GmCWgANU29pDD6mu+ObB7i8emy26MTxKfOJANDrK
        ymzXZg8uLPbZHYTUq0QywySIAjjMxiFvzSdFh6g=
X-Google-Smtp-Source: AH8x227IkqR6HpZpd/sVD0AMf3//L4UrAiUAUf65l+aJlXidMCl19ELjtzcLJJyjeAnljpn/NtJlcNf0QgcCoGxBo/0=
X-Received: by 10.157.53.5 with SMTP id o5mr1218304otc.181.1517912247358; Tue,
 06 Feb 2018 02:17:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Tue, 6 Feb 2018 02:16:56 -0800 (PST)
In-Reply-To: <CAGUnuBHY9nQvGiROm4S_JvBWMrzieHC1FE50fJqxaauzZhH7xw@mail.gmail.com>
References: <CAGUnuBHY9nQvGiROm4S_JvBWMrzieHC1FE50fJqxaauzZhH7xw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Feb 2018 17:16:56 +0700
Message-ID: <CACsJy8Bhu6RvedKgOx8uExrJuo0-b66JvnZA9d9v4Uk6mSwPQQ@mail.gmail.com>
Subject: Re: Are concurrent git operations on the same repo safe?
To:     Ian Norton <inorton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 3:16 AM, Ian Norton <inorton@gmail.com> wrote:
> Hi all,
>
> I'm generally used to the idea that if a thing is not marked as
> "thread-safe" then it isn't thread safe, but I thought I'd ask anyway
> to be sure.
>
> Is it safe for me to do several operations with git concurrently on
> the same local repo?

Off the top of my head, object database access (e.g. things in
.git/objects), refs updates (.git/refs) and .git/index should handle
concurrent operations fine (or in the worst case you get "some
operation is ongoing, aborted" and you need to try again but not
corruption or anything else). I think we generally try to make it safe
concurrently.

> Specifically I'm trying to speed up "git
> submodule update" by doing several at the same time.  I've noticed
> some odd side effects afterwards though when trying to commit changes
> to my super project.

submodule is a hot area with lots of development lately I think,
perhaps you're seeing some bugs... CCing at least one submodule
person...

> Apologies if this is answered elsewhere, my google-foo is weak today.
>
> Many thanks
>
> Ian



-- 
Duy
