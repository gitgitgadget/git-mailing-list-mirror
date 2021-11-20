Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3CDC433F5
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 22:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbhKTWpC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 17:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhKTWpC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 17:45:02 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22967C061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 14:41:58 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id k37so61298839lfv.3
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 14:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OONHOq4FaDan6LmpIoqs+M0ug/VUdlQf/uMXHEeWIA8=;
        b=YW1Soz1JTedHdlzo0KP2wanz5fsMVk0Go0tEgOyY9z5gNARxnQ99YZjmRBk+zR7Sha
         2gUxZaN3nK6/VY3m+M1TST55JFgFnmYvnqpA+BvV1wmxrmIl9WV7nzp7mxV0j+5COTj7
         HIdsYS5WOy+AnzK7E8t8OGRSs2CBifG6wPFBa/BYJEmyvQQbDzocl0V+tUE+C2JkJvya
         +ZUuoicNqBarhh770lrRtdeRSDu9nP04CbX//vJd+gy2r/RdkSgg2VHkSnop7ovEz9ih
         KIjZWUJ4ckdahnTeqRgvFP+SlPydNdxj9dbmIn2Prs8HkOnfeLrNQTDSMG6U7a853of3
         nI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OONHOq4FaDan6LmpIoqs+M0ug/VUdlQf/uMXHEeWIA8=;
        b=e8onahgiZfKxS/Vuu5qY6YqwdR3Jsm0Ubp8nL03mEsCSxnoF9JvA9bj0Gpqq4riDla
         0fpSZxNggkDhRy3p/xDzfWNwrA5M4DwXS4TgivgHL8Bxx1e1kKqWt+uH/VKzd3QdkU5b
         NQfLms9QwiiqmoJDmkGKdx15Kr5YmBpEyG6Ini/wNCYg/xRXpHU2g/4kPHGzitjYT8cQ
         AbxvAFz63k0ux+qeS793RTaGH0CzjQ3kpy1I550866BAi/byOHjOZ4wp1F/CpMU2S0NN
         0BucNWA6TITFjZpvJus6n+XMpzMmkUArViCDMz269Fbv82LloIbP/ND9QQ+7ZBKc1xSE
         p9SQ==
X-Gm-Message-State: AOAM53094K9Bafi7QTvg/SsLXVWk+FUOreZgaafgq9joEUvx1s5s0wgY
        QHEVq6SLSlC5ykx10m44ZQEJ/rsaoe9Npb24lqs=
X-Google-Smtp-Source: ABdhPJynd35ZfkQaDMux6xStfLAoO5CfLNwdtgUnjizY1lJnNmXE4ufvSbegW+uleWNMI5akANagIT3Jw6/1BsLGR9o=
X-Received: by 2002:a05:651c:a0d:: with SMTP id k13mr38513208ljq.329.1637448116268;
 Sat, 20 Nov 2021 14:41:56 -0800 (PST)
MIME-Version: 1.0
References: <CACLOEFZz7bunO2S5-ec1K10B9AJU4-m50j3j9c=12R6d1D+-dg@mail.gmail.com>
 <YZaHpJKeyDEY8qKW@coredump.intra.peff.net> <2bd2269f-c7f1-7afb-7052-48fac148dffd@gmail.com>
 <CACLOEFbY3LwMa2uhc=9jmcGFf0mvWzEM=YityLyFcuGWXVmqbw@mail.gmail.com>
 <72fffbff-16f7-fa17-b212-67aae9e1b034@gmail.com> <190a1fea-124d-2e85-38ea-9dab87f3e377@kdbg.org>
 <429375f7-ec3e-596f-5f79-c724570c8397@gmail.com>
In-Reply-To: <429375f7-ec3e-596f-5f79-c724570c8397@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sat, 20 Nov 2021 14:41:44 -0800
Message-ID: <CAPx1GveHusi8n8n03hUwBu6B3=_j0ZY6FWXWKDs8mLGwHEN-Qg@mail.gmail.com>
Subject: Re: git 2.34.0: Behavior of `**` in gitignore is different from
 previous versions.
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Danial Alihosseini <danial.alihosseini@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 12:44 PM Derrick Stolee <stolee@gmail.com> wrote:
> So the problem is this: I want to know "I have a file named <X>, and
> a certain pattern set, does <X> match the patterns or not?" but in
> fact it's not just "check <X> against the patterns in order"  ...

Right.  You're starting with the wrong problem by assuming that
you *do* have file named <X> in the first place.  You would not
have it at all in some cases.

I've always found this somewhat puzzling, or at least very tricky
to explain, in the presence of a file that is tracked because it's
already in the index, despite having a parent directory that would
have caused the file to not have been found.  So the standard
explanation -- at least, the one I use -- is this:

 * Git opens and reads the working tree directory.  For each file
   or directory that is actually present here, Git checks it
   against the ignore rules.  Some rules match only directories
   and others match both directories and files.  Some rules say
   "do ignore" and some say "do not ignore".

 * The *last* applicable rule wins.

 * If this is a file and the file is ignored, it's ignored.
   Unless, that is, it's in the index already, because then it's
   tracked and can't be ignored.

 * If this is a directory and the directory is ignored, it's
   not even opened and read.  It's not in the index because
   directories are never in the index (at least nominally).
   If it is opened and read, the entire set of rules here
   apply recursively.

This works, but skips over files that are in the index and are in
a directory that won't be read.  So I add one last rule, which is
that already-tracked files are checked despite not being scanned
during the above process.  (That's because the process above is
only used to determine which files to *complain about* at `git
status` time, or auto-add with `git add --all` or the like.)

So: these files are not ignored ... but is their directory ever
read?  The actual answer, per testing, is "no", which matches with
the parenthetical in the paragraph just above.  But no
documentation says this, explicitly, one way or another.

Incidentally, while I have no patches to contribute at this point,
I do think it would be sensible for Git to read a `.gitignore`
that says:

    *
    !a/b/c

as meaning:

    *
    !a/
    !a/b/
    !a/b/c

That is, declaring an un-ignored file within some ignored
directory should automatically imply that we *must* un-ignore the
parents.  It doesn't seem like it should be that hard to insert
some extra rules internally here (though without `*` we'd want
to ignore `a/*`, i.e., the above is optimized beyond what I
would expect from automated rule insertion).

Chris
