Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0FCC4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 19:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8BD23136
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 19:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgLST6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 14:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbgLST6y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 14:58:54 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA84C0613CF
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 11:57:50 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id d14so5398929qkc.13
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 11:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1U+GV0l9RajrHvyksyNIO0Kj7OomkFpIhM/G28fFHw=;
        b=wdgw0kwDTjkR0jzxrKl837UXiSnwK8nCToXYuR5M0hb7vv7TxnNDbkFvs4eUO1hkz1
         tLK8zLLgu2a7eSV92MydK3QH2LKItzHJdv8u3Q3iS0UL0ePb5VxfnF+LBOMLOQtOXi2n
         UejFJoj+Yyetz81UJXAr7nKkUTKujK87CsbRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1U+GV0l9RajrHvyksyNIO0Kj7OomkFpIhM/G28fFHw=;
        b=HHdttNA/W/290q+qSsyEzG1iUWJMV14+4yKrgXsFcaCgKA5Q85c84Rm0qV6On/9Fh2
         ar9WhmqMa2wM4rLXvvKE8BEUIDy/i72OP0Va2cWFx7lzHS0qUonyLeRKOqCvEIDUE+FK
         9DQ4lqR6P55De7i5CGURwhfOsk9D/Pblyp9T29JBAT1u7JklrYdeDBugOPH3dP0DmHqW
         9qAXEnjtjQvQL8qQWyow6oBiztYFo6eN6PsLfC1iXHilBqTn5tnu7enSl5DN3etSLifK
         0XO9X9pL3Yiq2ugUmgduvWt1s1R7Z0R1kbjiuOuWDNZwRwv6s3Jiq1UqfRjnA1EVHV5T
         pxFA==
X-Gm-Message-State: AOAM532XJO2dag/ajNQZCKjKImHRklimY5bL08Cb77S0ieCijQX0B74v
        9qrNMTsai5kgxpSfHtz1BneRK6abTcacdZdRoDONfcFZSFulaw==
X-Google-Smtp-Source: ABdhPJwMXCYLt1iIyTBNmkEktI/pfyLhwY0ljpQR+3iaBjT90yLHJSfGQPH33JlyZRGSFg0iUWqepkfBqFAiy/DrzbQ=
X-Received: by 2002:a37:90c4:: with SMTP id s187mr11233173qkd.6.1608407869109;
 Sat, 19 Dec 2020 11:57:49 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpn3tqugm.fsf@gitster.c.googlers.com> <3f0403b84ab06b9deb7c5c189792bebe1db586a7.1606866276.git.matheus.bernardino@usp.br>
 <CA+kUOamDD_SDNLk3sPSwNAojrAAP+g38MjkfG4JMPRTGOVAKAQ@mail.gmail.com> <87y2ht4pfr.fsf@Rainer.invalid>
In-Reply-To: <87y2ht4pfr.fsf@Rainer.invalid>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Sat, 19 Dec 2020 19:57:14 +0000
Message-ID: <CA+kUOam3h859kK76QuS9OFojeavXO15JNpinUQ0vPrAXrcsCoA@mail.gmail.com>
Subject: Re: [PATCH] apply: don't use core.sharedRepository to create working
 tree files
To:     Achim Gratz <Stromeko@nexgo.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 19 Dec 2020 at 18:34, Achim Gratz <Stromeko@nexgo.de> wrote:
>
> Adam Dinwoodie writes:
> > To my surprise, the test fails if the worktree is under "/cygdrive",
>
> /cygdrive is normally mounted with "posix=0", which only affects case
> sensitivity, so that isn't the reason for this particular fail.  You
> should anyway not build a Cygwin package with that option in effect,
> instead create your own mount point for that directory (with
> "binary,user" options).
>
> > +++ diff -u f1_mode.expected f1_mode.actual
> > --- f1_mode.expected    2020-12-19 16:50:20.169378700 +0000
> > +++ f1_mode.actual      2020-12-19 16:50:20.249126000 +0000
> > @@ -1 +1 @@
> > --rw-------
> > +-rw-rw-r--
>
> You seemingly can't change the ACL and/or several mode bits and see the
> effective access that your euid / egid has instead.  It is possible to
> set up the (default) ACL in a way that removes the permission to change
> them while otherwise still giving you what is effectively full access,
> in which case the test fail is the result of an inability to remove the
> default ACL from the directory.  I suspect your build directory is owned
> by a different user than the one you're building with and/or has been
> moved or re-used from another Windows installation that has different
> SID.

Having done a bit more digging, you're (unsurprisingly) right that
this seems to be about permissions rather than mount points per se. I
see the same failure with a build in
/cygdrive/c/Users/Adam/Documents/git, though, where that directory was
created solely using Git commands with the installed version of Cygwin
Git (v2.29.2-1). I'm using a test VM here that was created from
scratch solely to run these tests, and where there has only ever been
a single login user account, so the permissions setup should be about
as straightforward as they possibly could be.

This seems like a scenario that Cygwin should be able to handle, but I
don't have a clear enough grasp of how Windows ACLs work in normal
circumstances, let alone when Cygwin is handling them in its
non-standard ways, to know what an appropriate solution here is. "Only
ever build things within the Cygwin home directory" seems like a
decidedly suboptimal workaround, though.
