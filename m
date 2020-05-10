Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105F0C38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 20:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73A9206F5
	for <git@archiver.kernel.org>; Sun, 10 May 2020 20:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WauyXREG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgEJUUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 16:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728468AbgEJUUM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 May 2020 16:20:12 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606FAC061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 13:20:12 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id p67so1502931ooa.11
        for <git@vger.kernel.org>; Sun, 10 May 2020 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5VU5EYsWZ3+D9OpKkDiFVw8hxuFucSoefXZwLHBm/0=;
        b=WauyXREG01sHj7U0b2YwqXvXd4xGvJ/PlmA2jxghQJY59cKPEGyJGpT95jX0YY8zoA
         OgMJ2y4rVag1SjxcSsjG/nOCA8nAINhIII7Ijm8Oc3Yt3uV/wCEasjn2VWyx1S45aW1d
         bXx9RDdi9UJ37Kdez4WcRj1HQ5KGjlZNvNCeYjBQj75i1O24mhZTwDQe5UJMyXI/Td6B
         efm7dX2r4n7no+U36AXNS1+Y64qtICBYYKuIC0TttPCB3X2+eqvLkKf/5BWcnUaomJR4
         0YW4Bw170UZ78z+GeiHQM5EsL9m4vQugjzH2A4/Lwg3Gel+yriIvwDn3Z37MRYrpGiqd
         e8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5VU5EYsWZ3+D9OpKkDiFVw8hxuFucSoefXZwLHBm/0=;
        b=mEwrIvYmWyLTm9HZguHWWDd5LrG/Dehu3sl0gIvfxjaGQf+4J3+xTnyjrfz75f6aUD
         SimW6CmJkkhG+3qkIGls/JbtFuUWu3c3aF/1apDfsfVolK0DXYlTiBPvpmErpeTpjeNh
         YdBYCXDXTvltR3hx7D1kalYg/t9V53V3SahG4whT3TvP9A/hxDt6Ii9X6bv5i6nTTTZY
         NkqEkdng7R1KHKipimps2QgIY+0HtyuBAQqDl0lPa9/aSbDhPqcMZ6uzz6TR0AYDyqQh
         f5EB2PYFZzETj5oWVJes3wksNgvL/2qhFD0DMU7iU8IF/iXqYU6Nxq9LOpID1FkZxCVI
         /tBQ==
X-Gm-Message-State: AGi0PuYzcILNh6hG1XJh4CjTcSbf41Avi3jjCQdBLStNe9jXI2o764i8
        m65rsKBvqgLKkhS9gxiwK9er4CV1RDdD6SsvkdExb1iQ
X-Google-Smtp-Source: APiQypKk+R5B6tQ7DEEeBbD8SqcegJ+R2Ie7TduZffzWsDtyeRmw7bih9WMsDC6SOsk+Im/ikhsFZRLCT4/C+QZpxGg=
X-Received: by 2002:a4a:d64f:: with SMTP id y15mr1457159oos.90.1589142011784;
 Sun, 10 May 2020 13:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAFKec1W0-OOQYypP-3VC=dJnuNDrykdQ2xibc=u4D=Zo6if-+Q@mail.gmail.com>
 <xmqqd07cvl9b.fsf@gitster.c.googlers.com> <CAFKec1Wj_uK-moVfin3XrTEmmBaAzaJKsh1f8q-3+RBs2-3Jdg@mail.gmail.com>
 <xmqq8si0vfp3.fsf@gitster.c.googlers.com> <CAFKec1UGKbaV7wC78i8+uSEizjGkj2bDSfOeucvJORhORvc5KA@mail.gmail.com>
 <xmqqwo5ju47t.fsf@gitster.c.googlers.com> <CAFKec1Wy1iT8Z=gNDBn++XLxzGWr0UUiu3AKMU-qaR+jj2yoKQ@mail.gmail.com>
 <xmqqo8qvu0ao.fsf@gitster.c.googlers.com> <CAFKec1VGzpxVJV4zak46r_p2gGcw4UanFr7U4U4MSsG7t2A23w@mail.gmail.com>
 <xmqqk11jtxl3.fsf@gitster.c.googlers.com> <xmqqftc7twaa.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqftc7twaa.fsf@gitster.c.googlers.com>
From:   George Brown <321.george@gmail.com>
Date:   Sun, 10 May 2020 21:20:00 +0100
Message-ID: <CAFKec1VGMwn3_4AEuY8Vrs60UQbX-fvqCkzKd8VARAUScbA=rA@mail.gmail.com>
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I somehow doubt that users of vim types "!git jump diff" (or
> whichever submode they want) from within vim's command prompt;
> wouldn't they typically wrap the invocation in a vim macro?

Correct, in Vim parlance we'd create a command for this.

> If my suspicion is correct, with an opt-in feature like the above
> (which is designed not to hurt existing users), the vim users can
> change their macro definition to not just invoke "git jump
> <whatever>", but invoke "GIT_JUMP_AUTO_CAT=yes git jump <whatever>",
> i.e. tell "git jump" that you are opting into the "cat the file,
> instead of launching GIT_EDITOR".  So with just a one-time setting,
> vim (and other similar editor) users would benefit without hurting
> others.
>
> For that matter, instead of introducing GIT_JUMP_AUTO_CAT, the same
> mechanism can be used to run "GIT_EDITOR=cat git jump <whatever>",
> i.e. tell "git jump" that it is expected to run "cat" as its
> editor, from such a vim macro ;-)

Yes. Another version that someone else implemented used similar method
by unsetting "$GIT_EDITOR" when invoked from Vim and modified "git jump"
to use cat when "$GIT_EDITOR" was empty.

https://gist.github.com/romainl/a3ddb1d08764b93183260f8cdf0f524f/e1f548f6d96cd6ee97c3daadb4a1546fab7814ad

I can request the author submit that as a patch if it is of interest.
