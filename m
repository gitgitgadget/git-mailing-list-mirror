Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F75C54E49
	for <git@archiver.kernel.org>; Sun, 10 May 2020 09:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E26B5208DB
	for <git@archiver.kernel.org>; Sun, 10 May 2020 09:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgvkmy3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgEJJEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 05:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgEJJEL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 05:04:11 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A834DC061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 02:04:11 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id z6so398529ooz.3
        for <git@vger.kernel.org>; Sun, 10 May 2020 02:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ttQJvpIsac3tUfatultYbxgPPQIm0KxK4eYKH73ewwk=;
        b=vgvkmy3UrSCa15VPcDCxCGwOZD0Qv0eFFwrUFCI77gJHSFsvAbmz9ptCA9iNIWT9Rd
         JSHdWonr5aztsQYg6pQJ0FsPGtunEx/TCXQLJO2ruV2ZhGLkZWG/U9auSYDV5LoRGOmq
         ofMuHG84fNfcjHSqlpJbkRR8saV84IAIuFh4qKAxPYDZPChUcJPLhLKEGYgZclUpVeUM
         55MWiNujxujXxApbJZEd5qnCgU2odf2+IBGbMLX7xv0YQegqJpQwqZUJn1eQaR7d4sCH
         r6T/6WTU7+RUPetFZoQYq8NDm4mzT9w5aZNGigja+pJYr+1/pJzKROOK5OwjgP8r/g4s
         mf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttQJvpIsac3tUfatultYbxgPPQIm0KxK4eYKH73ewwk=;
        b=P4pvFSDs6xrxNQziAxjtztcs6T9ljfX+hAWdf1j7fxpB2n8iwGgk9XKvaFLHu5UfeH
         g5J7/wnqvG+OzvBli19Yp42eBP37yZoLP7geBvmhq8c0Ea7u7qD4L2vcXyf5/WDelqot
         7hq9qs8Tzg9Yf83zo9+6HsfOhKndGiZxjF05kzlMxkYWNGazQBHrPlAAVyngUIjxAMTs
         KNQ9Qw9VyPZ2yaUK9VyKK1M54QDacYPf7nwDhBU44zsPMtFkQW4aLXXM44laSKhHRAI/
         tGa0ZiLkq8QcoEExJquJaF9gXvLctE7UYOqJgNE1c22LYnGQPYS2vay1zxBJlXEtUA+P
         1gNg==
X-Gm-Message-State: AGi0PuYkQiEP1eq6gEtrtrGVb4GyeN6VfLv/UorAMsjpAnWTYXKEU5CG
        d/7ar5ZEeVnImLZd0bbMTQkYpF4bsP+edKwoQw+43V3Y
X-Google-Smtp-Source: APiQypJWBGDxWxQQq6tkpmFQagZoVQIOev1hrOreRFpNOPL/swJHDy1+cStVM6cyPcxjhdzPP9o2i+g5aAjq32J5nH0=
X-Received: by 2002:a4a:2fd3:: with SMTP id p202mr9402632oop.33.1589101450917;
 Sun, 10 May 2020 02:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAFKec1W0-OOQYypP-3VC=dJnuNDrykdQ2xibc=u4D=Zo6if-+Q@mail.gmail.com>
 <xmqqd07cvl9b.fsf@gitster.c.googlers.com> <CAFKec1Wj_uK-moVfin3XrTEmmBaAzaJKsh1f8q-3+RBs2-3Jdg@mail.gmail.com>
 <xmqq8si0vfp3.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8si0vfp3.fsf@gitster.c.googlers.com>
From:   George Brown <321.george@gmail.com>
Date:   Sun, 10 May 2020 10:03:59 +0100
Message-ID: <CAFKec1UGKbaV7wC78i8+uSEizjGkj2bDSfOeucvJORhORvc5KA@mail.gmail.com>
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I am not sure what you mean by "receiving lines".  Your patch makes
> the "git jump" command completely ignore configured GIT_EDITOR and
> refuse to invoke *any* editor.

Running "git jump" from a shell prompt works as before with this patch.

But now within Vim it can also be used to populate the quickfix list
with something like ":cexpr system('git jump')". Because instead of
invoking another instance of (which does not work well for Vim) it
just receives the lines as formatted by "git jump".

> > Would it work to set GIT_EDITOR to "cat" while performing the
> > "populating quickfix list" (whatever that is) operation?
>
> It would, though I considered this to be less elegant.

Just to revise this, it wouldn't actually as the editor is always passed
"-q" (intended for Vim's quickfix list). So overriding this to "cat"
causes as error as "-q" is not a valid option for it.

I'm aware the examples I'm giving are specific to Vim but it really
seems that "git jump" was intended with Vim in mind. That said I'd argue
most other editors would work better with "git jump" if when they
invoked it another instance wasn't created. I've tried find an
equivalent to Vim's quickfix in Emacs this morning but can't quite wrap
my head around it.
