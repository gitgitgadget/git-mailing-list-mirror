Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180EDC433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 02:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348691AbiBGCWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 21:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348679AbiBGCWh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 21:22:37 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C53C061A73
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 18:22:36 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id o15so7039505vki.2
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 18:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=90OlMBKyaqrgtmiKjxtutZDp1k6ivdhqDTXlnfxD75Y=;
        b=OTHBWKdT4XOmIHZPnYBxPqBdyXePky7p2J+uh4KJ7d0nlxnAAnrc6UwxVbpvUeQbSB
         TqK+20FSn5JcQ7iV6fxTxfYne8etBNlr1SY+434EYlxjbcB37kUL2FtUqDHVzSiIvRiH
         aSOEEmLfHcFFShDJH6aTuybzblvwNal0adL/YDQmuKP5lVjEdKPEJQNWbAJ1s6JVJzWp
         pSJGdspiGvmQ9J9MM8GFk3IRRAPnwfxPXSBctNunvNAhlRUDmSp/AWTfvUs20SJ1mkvA
         30j7gNJc2U4rw+9y97nPwY5UvbcVudAgdTj6bVZ6JJW30DbVU8v9WHZtyWgWfX9Jzq31
         JF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=90OlMBKyaqrgtmiKjxtutZDp1k6ivdhqDTXlnfxD75Y=;
        b=CX519CsTfSfSiCbeu8c8Di3gT6SsODlrjZWwECKU/amCQhCmjMerSAwuDQ/hDIFHI8
         +egQAMoAOHieERgd5v1r4ivlpxYmgQ82rZSxzS6jTP4KoGWalbUPgs4xm/xsZ0imdLxr
         eUOyRxIgKneMj2sCay5Iw7wliwX5V1lKZ1ZWHBR3SWvU7yi4Ps3X7cB/eCEKI6wDdTMN
         BB0gIvn/tFH6Q8qgqEbdwSu/ySBOI0Dd7tvyJwMmy09T9O4ne/i3BXyTb9WVHXrfUtDB
         bWQgseGwc+NpSWGLT8GusXfI826vH1rb8vXo0a3hIkwmbSymK4VrEzy1J9meFhzj60FC
         172Q==
X-Gm-Message-State: AOAM530d/orEBWTKzKw0fLowDIVYLgWqCIpFqreP8bQFtZrzSRkEne5d
        DJAYf9Woy4ICxHgNOnHKYM7eX77Jwm3dWF0ylHs=
X-Google-Smtp-Source: ABdhPJxL8Mqs77NIhOeZhgFnEXSBEBC2GjbETFBJdTVwn7iKpHwHfWJU9ETZXK7jx9c7CjyUsZU7jXd3uE5drtoHt0U=
X-Received: by 2002:a05:6122:130e:: with SMTP id e14mr4017504vkp.26.1644200554883;
 Sun, 06 Feb 2022 18:22:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641978175.git.dyroneteng@gmail.com> <bcfbc935b80b889273e3e54fec2a896e44acd2b5.1641978175.git.dyroneteng@gmail.com>
 <220113.86wnj4w228.gmgdl@evledraar.gmail.com> <CADMgQSQXLydvgpW+Vm_b-rkSWAuj9FezwveY-iRZnKfsGkOpCA@mail.gmail.com>
 <220114.86ilumttn2.gmgdl@evledraar.gmail.com> <CADMgQSQzqW9m1XM7_EE09eBhkheMj6QCZ+pVjtHWW2HY=u_o2g@mail.gmail.com>
 <220204.865ypu3hqm.gmgdl@evledraar.gmail.com>
In-Reply-To: <220204.865ypu3hqm.gmgdl@evledraar.gmail.com>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Mon, 7 Feb 2022 10:22:23 +0800
Message-ID: <CADMgQSSNQFHhf3=K+PiaoonBnheoDcoKpWy9-zjSu90d9rDY2w@mail.gmail.com>
Subject: Re: [PATCH v10 6/9] ls-tree.c: support --object-only option for "git-ls-tree"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, tenglong.tl@alibaba-inc.com,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 4, 2022 at 9:04 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:

> I'm not saying we shouldn't have that, but that in any case a sequence of=
:
>
>  1. Add a --format option
>  2. Add a --object-only alias for a --format (what my RFC 7/7 does)
>  3. Add a custom more optimized --object-only implementation
>
> Would make the patch progression much easier to read, and we'd consider
> the correctness of --object-only (1 and 2) separate from the
> optimization question (3).
>
> But maybe we won't need (3) at all in the end, i.e. is (1 and 2) fast
> enough for it not to matter (I think probably "yes", but I don't have a
> strong opinion on that).

Sorry for the late reply, I had a vacation in the last two weeks (Chinese
New Year).

I have to say it's a very valuable recommendation and at the same time
I recognise that
spending more time on organizing commits ahead is important and make
small steps(or commits) sufficiently.

> Now would be a good time :)
>
> I was reminded of this because Junio's proposed it for next at
> https://lore.kernel.org/git/xmqqr18jnr2t.fsf@gitster.g/
>
> I think per the above & other replies of mine (including not matters of
> code arrangement opinion, but e.g. the doc formatting bug) we'll need at
> least one more re-roll of this. Thanks for sticking with this & working
> on this!
>
> I'll indicate that in a reply to that "What's Cooking" report.

Thanks for mentioning that. I will back work on it this week.

Thanks.
