Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12734C433E0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 19:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7CFA2077D
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 19:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2ayVyMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgFCTpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 15:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCTpy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 15:45:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF53C08C5C0
        for <git@vger.kernel.org>; Wed,  3 Jun 2020 12:45:54 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o26so2783595edq.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2020 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YOhwOY/7noEj4Ef+TeaHHYpCvLYjIkDlqoQWmq98ckI=;
        b=f2ayVyMjVBZb+++sJ72VzXeTJGG45aIyTt5gL55SSGulXHS3JHQqg5yVohFt0nOscL
         YCy4BDeAGHBllMBfUW2EAWxnB0F7yjOV38mKgroNoK67iApsGFfOOynd/wgFeYkdzHZZ
         V8yInlyI2raxlSmG32J6BnJLnJHRkFEhd+SjZoilljzLTejLarg15Hr1oUKYMLYkKgUs
         SvRD4BTIRBQgOa6fkwrBpt4LWJn3Aeos+jzEVYPN8IlwtNUuJ6x4JMkDZkjL19N7K7Yf
         5OhpdapboFt6yvaMXV1Cuk4uAgpugwTzDn3jMTO/cWWkSMfXUQNlgpD7yzJP+pvcIREU
         kCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YOhwOY/7noEj4Ef+TeaHHYpCvLYjIkDlqoQWmq98ckI=;
        b=VTP+SNrdLltZvZ0NLPj+vXTEcEA6kFkgjd1lv7ZU3fYS03m6qGIbM0s5Y0PqKNUgki
         mMMgfsLlMzCII2RZV8k04bTOeQlJqdwugAmtJUAB/E1EepMBFXAFVrPlYGShA/UBqd9U
         e4CC5lhVXYGYj4RXhN1gbo9KWRJ9s1mIBJsH3j8x2nl2SIl7l8qwUkXitvelT0uE+qLt
         ufvuag978DSCB3m8Dcg+yZ1V2EfwDEIM+odm/Km92DbtXm91u8QgShE5BdeqeM7YUG5c
         E9Krtd7GcyjDDnKG+nog7h1+MAsasAYI3BrmF/NUWkmO35lrUYQw2WYCmen57sexZzq8
         EXOw==
X-Gm-Message-State: AOAM531jJTJZlDRaeDqPR4pZnCjxo9FQci46VBPlymLPZGrg1UqYTGj/
        edJp7jza5SQnm84t3t+FP/zNNQxtRl/tfov7jZI2zNWg
X-Google-Smtp-Source: ABdhPJyGfGTa+RvQH0++//0EnFZfIJVNXt/uByWuNFwleUZdXi0+PM9nueVPC9wRcxmCdJ3cNcvwQ+khvqk3pl48R8M=
X-Received: by 2002:aa7:c910:: with SMTP id b16mr1107077edt.0.1591213552799;
 Wed, 03 Jun 2020 12:45:52 -0700 (PDT)
MIME-Version: 1.0
From:   Edua Vioz <eltipejoloco@gmail.com>
Date:   Wed, 3 Jun 2020 14:45:40 -0500
Message-ID: <CAGiZ90mZp5sKFBwFr5M4Zm2Z0GCWG=hCQuEUqKOLS0toO=x80A@mail.gmail.com>
Subject: Re: Questions about Git-Gui Makefile and GNU File Name and Text Functions
To:     paul@mad-scientist.net
Cc:     eltipejoloco@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2020-06-03 at 14:34 UTC, Paul Smith wrote:
>I'm not super-familiar with the Git build system so maybe there are
>mitigations for this there but: GNU make always treats whitespace as a
>word separator so it will apply the "dir" function to each word.  So:
>
>>$(dir C:/Program Files/Git/mingw64/libexec/git-core)
>
>is equivalent to writing:
>
>>$(dir C:/Program) $(dir Files/Git/mingw64/libexec/git-core)
>
>and the expected result is:
>
>>C:/ Files/Git/mingw64/libexec

Yeah, I figured that was the case after skimming over GNU make
reference sites online and reading as much. Still, I figured I'd ask in case
Git or Git Bash specifically had been built to account for this in Git for
Windows, or if anything had changed since the documentation I'd read
had been written.

>No.  Make in general, and GNU make in particular, doesn't expect to be
>given paths with whitespace in them.
>
>Again I'm not an expert in the Git build system but my understanding is
>that the install can be relocatable: in that case I recommend you build
>it into a location where there is no whitespace in the path, then move
>it wherever you like after building.

Ideally, yes. However, Git-Gui's Makefile was not written with this in mind.
It will append directories to DEST during installation that can (and do)
include drive letters. Again, the file can be modified to fix this on a case
by case basis, but ideally I wanted to learn if this was all already known
about this particular Makefile and if it was expected behavior.

I've actually already modified my copy of Git-Gui's Makefile to account
for whitespaces since I first wrote about it to the mailing list, but since I
suspect that it was automatically generated by software, I'd rather
learn if the tool responsible is open source and could be modified to
account for spaces in directory and file names instead of manually
fixing up every automated Makefile for each repository Windows users
come across until the tool is changed or no longer in use.

If I were to share it, should the patch by submit to a new e-mail thread,
or would it be fine to send it in as a reply to this one using the --in-reply-to
argument in git?

Thanks in advance for your time.
