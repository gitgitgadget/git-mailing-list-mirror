Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D70EC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 19:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E7061445
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 19:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242839AbhDUTdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 15:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbhDUTdl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 15:33:41 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B334CC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 12:33:07 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so34852503otf.12
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 12:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+BL8Yeo2JxIN6cxUqQpN+GzNXIJXbOrH04kIVNbl6E=;
        b=ULRLATSXFIIx0o13dlMNgrQ9ySJz58y9uFZEAhIwSLiS0pDK6CSTepX1DbxTtoAqWS
         6LHj20p23GQBebXyM5sNou34bnbwKv3LVKdkml1Oc4a9JjQQ6QMVcmVmHuI52OUuCL89
         l7snqaBeb1r4d3Y+GElkmSkWGO1GNl3gfQwt8WgleWPwk+aTFAStSLNwEbzdh9fbifGy
         OyNMUhfhT530F2u8wUqI9naSUOPXYFezhivlr/NhjLXOfROgHaqEryiASdKP/pYsa+eo
         iROGpZsJ8yUtwaG706nmNQiLmLbpIKNfr9c5JRUITRXZ8cPahqrRXcAQSRQL1TXzbSlY
         aZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+BL8Yeo2JxIN6cxUqQpN+GzNXIJXbOrH04kIVNbl6E=;
        b=SztEeb559FYMc84/wv+RiDshJEajk0HkcUMq6YQxqBBfAcVf7nLBKki2sqShgdPx2f
         tp7FweKaOrYwbciYxPHrLk9JIXn5sVY+xN2JhuUtwLHSxPsEYI+OssYZJGkpkdv+tdSL
         4wauYh/2i+5pd4s64naLObjEGUQLJoUb69jzVOsl9Fir/M3ePn7Zvn64dTa/u0rAI32p
         MTsmm9qiNPfMdGSHprEe5EPKwBds3pCv+IZehMHvLxGf6DLZn5ULLxtb4G0A34Kzo7G6
         tm54p45U8q1rMSi8OVmnVykF8gUAd2QiNWm+aZcoLDRFtzIlui8tjBCL6HaeMu6cVH+V
         xx7Q==
X-Gm-Message-State: AOAM530RbJ5HUrELdxSfiMnf1me2RvGxIk/nPlB/JJBt/MR0V5eelC56
        E54e1LvIvVMQgtEeMDrgr5inwwYKPqcy3WCM92E=
X-Google-Smtp-Source: ABdhPJwkdeqBi7vOUzjsBFkmCSnp0brzwt1v6HBAOxkZ9kKZrCEgo33qXaAlEmWxdk7dyFIMPGVn8o4ROmly8dKXkDU=
X-Received: by 2002:a05:6830:108d:: with SMTP id y13mr18790735oto.162.1619033587164;
 Wed, 21 Apr 2021 12:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210420190552.822138-1-lukeshu@lukeshu.com> <xmqqa6ps4otm.fsf@gitster.g>
 <CABPp-BF-rHnxvz0sAFAujXkiNwSjtpRQA4uvxT=a3z8v_sYbAA@mail.gmail.com> <xmqqy2dbxybn.fsf@gitster.g>
In-Reply-To: <xmqqy2dbxybn.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Apr 2021 12:32:55 -0700
Message-ID: <CABPp-BF373j2BbyTgTJbKzDP9Y5R2jZVNqWeOqLtypdz6VZRMQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fast-export, fast-import: Let tags specify an
 internal name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Luke Shumaker <lukeshu@lukeshu.com>,
        Git Mailing List <git@vger.kernel.org>,
        Luke Shumaker <lukeshu@datawire.io>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 11:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Tue, Apr 20, 2021 at 2:40 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> ...
> >> +The `<refname>` is prefixed with `refs/tags/` when stored
> >>  in Git, so importing the CVS branch symbol `RELENG-1_0-FINAL` would
> >> -use just `RELENG-1_0-FINAL` for `<name>`, and fast-import will write the
> >> +use just `RELENG-1_0-FINAL` for `<refname>`, and fast-import will write the
> >>  corresponding ref as `refs/tags/RELENG-1_0-FINAL`.
> >
> > Going on a slight tangent since you didn't introduce this, but since
> > you're modifying this exact documentation...
> >
> > I hate the assumed "refs/tags/" prefix.  Especially since ...
> > ... The special casing reminds me of the ref-updated hook in
> > gerrit
>
> Gerrit and fast-import?  What is common is Shawn, perhaps ;-)?

:-)  To be fair, though, given the number of things he created for us,
it's inevitable there'd be a few small things causing problems and
these are small potatoes in the big scheme of things.  ref-updated was
fixed years ago, and it sounds like Luke is about to fix the tag
prefix assumption for us.

> > broken given the fact that the name inside the tag didn't match the
> > name of the actual ref.  (To be honest, though, I was never sure why
> > the name of the tag was recorded inside the tag itself.)
>
> The name of the tag and the name of the object has to be together
> for a signature over it to have any meaning, no?

Oh, I guess if you treat the signature as affirming that not only do
you like the object but that it has a particular nickname, then yes
you'd need both.  I had always viewed a signed tag as an affirmation
that the object was good/tested/verified/whatever, and viewed the
nickname of that good object as ancillary.  I have to admit to not
using signed tags much, though.
