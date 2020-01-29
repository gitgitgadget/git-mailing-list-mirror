Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E6DC33C9E
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 02:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38CD2073A
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 02:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEarB+22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgA2CEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 21:04:31 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41103 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgA2CEb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 21:04:31 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so16909482eds.8
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 18:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2iD0QaF8fJDPlRRelMbnikHqLfBRiZHHpD+/Cl5cqDA=;
        b=kEarB+22Iyy3XTfPmzPH4QTftrWmHoibbi1n9/o1HEFhBO0JVjfX/6oUZzSisk9tKj
         EN75LAqxDn/Q0NiWGUo6Rz/7WEQm+xjSjDLYmTpAIOvMDZ+olKc9Z7gFaJfRdePUTQhv
         J6HNePZ0E7NlsxOJdi5sqc5bA7nwrFg0ouHhqc4N7lgwjKl19TxYWMjYHK8PNuhXaHrT
         8/XoTXf97kR124b1STlwZ861PNuycStuh/LqfW6qV/G1EOPkKB8sZTV8ShP8zVcR3Uc4
         ZuEv2wBmKpcvsYvz6VyPFYkiOiGmqsbx0gS9xt0RsFPgUevAh7jf2iyG2fAKsu3oObGA
         mlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2iD0QaF8fJDPlRRelMbnikHqLfBRiZHHpD+/Cl5cqDA=;
        b=LS+/Rxqv9tS0aYomGJETQ+VfEEkJGLH2X2KSzCYNQcHfSHuikadfW3eIrS1NzotPFh
         KKjnJm1dNRzw0bf74XzlG44Ur0q3xnObg8uNKSI+sGzWfZGUCW4IRVg0UE5+qNH/8EPG
         2WO8LahXN28Z4q/o9gj9rNRLZu9ya8/kYeVhO2KJ/9JegrfPAMQ8jXf137js+cQW1GMx
         nhkRS2bNzyE8Ryl3OhF7GNBLua9/HiFxIxbYsSZnBlXbLxhJci3MVeIWXmpI8ksM+/hN
         KgpQqjQ44NeamWooJTo1AdKVsJuDlFLCEA85alAAfgdSVnPI/mrPxCu2ODyX5X2w3lGh
         GOyQ==
X-Gm-Message-State: APjAAAUpMh/mDVarvFx7M+dJS55QD/i/oLuccdCzBSqd+NhnCwFrncDN
        ihDIE/L9sLSOdBV7BLoIXf391aRnvmV+PXfEgQ8=
X-Google-Smtp-Source: APXvYqzskOumHDBUCZazkPlhfFr0gwpRwZ7juDNK65xaxYZuRdymKXIkm2cGbBhxOHEoAVI5VyiGP3bXs1WyreMkFZU=
X-Received: by 2002:a17:906:1956:: with SMTP id b22mr4567103eje.276.1580263469147;
 Tue, 28 Jan 2020 18:04:29 -0800 (PST)
MIME-Version: 1.0
References: <9f9febd3f4f7f82178fceac98fcc91cb28a1b3b9.1578438752.git.gitgitgadget@gmail.com>
 <20200128000047.176372-1-jonathantanmy@google.com>
In-Reply-To: <20200128000047.176372-1-jonathantanmy@google.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Wed, 29 Jan 2020 15:04:17 +1300
Message-ID: <CACg5j25fi0nSMe2nH+iJ184ouk2VsrBWSZmEv-C_PrY8qfq4Sw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] add: use advise function to display hints
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 1:00 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > Use the advise function in advice.c to display hints to the users, as
> > it provides a neat and a standard format for hint messages, i.e: the
> > text is colored in yellow and the line starts by the word "hint:".
> >
> > Also this will enable us to control the messages using advice.*
> > configuration variables.
>
> Firstly, sorry for getting back to this so late.
>
> As written, this gives me the impression that advise() is what enables
> us to control the messages using configuration variables, but that's not
> true - that's done by a separate mechanism in advise.c and .h.
> Paraphrasing what Junio wrote [1], the commit message might be better
> written as:
>
>   In the "add" command, use the advice API instead of fprintf() for the
>   hint shown when nothing was added. Thus, this hint message follows the
>   standard hint message format, and its visibility is made configurable.
>
> (Note that I mentioned the "add" command and called it the advice API
> instead of the advise() function.)
>

That makes sense.

> (Feel free to use this or write your own.)
>
> [1] https://lore.kernel.org/git/xmqqpng1eisc.fsf@gitster-ct.c.googlers.com/
>
> > diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> > index c325167b90..a649805369 100755
> > --- a/t/t3700-add.sh
> > +++ b/t/t3700-add.sh
> > @@ -326,7 +326,7 @@ test_expect_success 'git add --dry-run of an existing file output' "
> >  cat >expect.err <<\EOF
> >  The following paths are ignored by one of your .gitignore files:
> >  ignored-file
> > -Use -f if you really want to add them.
> > +hint: Use -f if you really want to add them.
> >  EOF
> >  cat >expect.out <<\EOF
> >  add 'track-this'
>
> Also add a test that checks what happens if advice.addNothing is set.
> (It seems that we generally don't test what happens when advice is
> suppressed. If we consider solely this patch, I'm on the fence of the
> usefulness of this test, but if we plan to refactor the advise()
> function to take care of checking the config variable itself, for
> example, then we will need such a test anyway, so I think we might as
> well include at least one such advice test now.)

I'm tempted to say let's worry about it when refactoring advise(),
maybe then we'll
find a more suitable place for this test. as it'll be advice-related,
not caller-related.

Thanks,
Heba
