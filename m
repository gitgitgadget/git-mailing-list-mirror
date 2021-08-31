Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D857C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 14:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B31060E98
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 14:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbhHaORK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 10:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbhHaORJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 10:17:09 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB35C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 07:16:14 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id y128so24558825oie.4
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YshdiQKDrWFdM52nBZAJ5UNYExRN9lck75pcP4d6Kq4=;
        b=OwyTry3VtEolzTwhEKZrszugSRS3uTYF+MUJQ+9tBK7ejq7FDevQQj/dSyoshfX2EC
         e2/hle9+WTwGXcvteLHCQetHi7PqOiSJ58qZ9mLUuYzC65ICBMlFvtVMGGuCi5jgMl7c
         jyntC4uTJoFu4i7rPwP2wMeFZannlVfVNTIU28/m/j+PZsccVchiG2eSuIb7bpQy/1U5
         EHwpxNT9X3j7RM9+Xriv9L13xiPhbzNk9vbBdWVMfvFLLrmKOghqyCMCLBqpuTEj1GlT
         SJkJOLvf2sR9FrVqUeRX2XQMnjb3sh3AAVaoY5ytU+PgOTIHgCvGfYYHBo6KdLb9d1gT
         fc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YshdiQKDrWFdM52nBZAJ5UNYExRN9lck75pcP4d6Kq4=;
        b=U1l6YQmP8/PkOmBVyUU5qWdS+oEfHKhnbKO1B3/OHTHtY/sl4KmguZ74nsILrkyU+l
         FlP8hgkovzc2uf0IM90ijMJVGm05Rp688gBbNRbobHcNFg+xKiuu6AZK0CbszJ7eVhMP
         bM/tTQSyD6ZVuLCNEk4K0V965bhJG9pw4tf7sLyg/VLDSZXnh51fJQ5D198GJVAb9LkV
         TPVTKNnrIsN4S+DgCnoIUFloBTyhcfU+sP3dsEmEiCtajjghTLVurYF6UKfXxWuxMMpx
         RgogNecpPip8tK6i298exYuOI0e/QObjXVdAERuALPNvxJ1pLmiKkmSIgFVodrFYVOLz
         AaxQ==
X-Gm-Message-State: AOAM533Av/7wigzygY9lSPpf6ONuUsk1P+PEAxKU5nE+AsSJiJNWa98y
        xD795qulS3BpG1a7Jr78GAlwL0oaaoYKS5Q9W8vyOrd/szY=
X-Google-Smtp-Source: ABdhPJyu+0nMhe8B4RO+FtRxFdUbQi2YMCLJbkZAqCK+ijEK6oip02Iuk5f58xoi2LGvkFQ/AT7Hrr1bUwza8GjNVxg=
X-Received: by 2002:aca:5d04:: with SMTP id r4mr3299569oib.94.1630419374101;
 Tue, 31 Aug 2021 07:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAFSh4UzCWMCpOGZUYnrxwK79F6jN3irdNs=J7O6RMCeJbBxFBw@mail.gmail.com>
 <YPimnEtNgKD32r2o@camp.crustytoothpaste.net> <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
 <CAJDDKr7vXRxhwuTN=xFxqQkt_zt_Hpi3bYfc7rotcUAFjau9Sg@mail.gmail.com>
In-Reply-To: <CAJDDKr7vXRxhwuTN=xFxqQkt_zt_Hpi3bYfc7rotcUAFjau9Sg@mail.gmail.com>
From:   Tom Cook <tom.k.cook@gmail.com>
Date:   Tue, 31 Aug 2021 15:16:02 +0100
Message-ID: <CAFSh4UynPZ9YvS=_RZX2Grr38h=Ly2D830Q1XXJ0yqUj7z8GgA@mail.gmail.com>
Subject: Re: Bug: All git operations fail when .git contains a non-existent gitdir
To:     David Aguilar <davvid@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 1:38 AM David Aguilar <davvid@gmail.com> wrote:

> I hope that helps and maybe sparks an idea that you can run with. I
> certainly don't mean it to be a dismissive, "go change your setup"
> kind of advice, but it would be interesting to know more details since
> it seems like achieving correctness is going to require doing that
> based on the limited information in this thread about the specifics of
> the setup.
>
> Also, I wouldn't be surprised if, even after the "git ls-remote"
> robustness fixes are applied, you'll just stumble onto the next git
> command that can only be resolved by mapping in the parent repo's .git
> directory.

We map the source code into a build tree in order to build
executables.  We don't expect to be using git on that build tree.  But
one of our executables is written in go and uses go modules.  In our
situation, `go mod download` was trying to use `git ls-remote` to
inspect dependencies before downloading them with `git clone`,
swallowing the git error and then dying horribly on something else
that appeared to be unrelated.  I raised a related bug report on `go`
(I think I linked it elsewhere in this thread).  So for us, easily the
worst thing about these two related bugs was just figuring out what
was wrong in the first place, and the go bug was definitely more
severe than the git bug.

We could modify our build system to make the git local repo valid but
there just doesn't seem any point - we never do anything to the local
repo in the build tree.  The next engineer who comes along and looks
at our build system would inevitably ask why on earth we need to make
git work in the build tree and it would be a fair question.

As an end user, it still appears to make little sense for a git
operation that will complete happily with no local git repo at all and
which doesn't depend on the local repo in any way to nonetheless die
because the local repo is not valid.  As a software engineer I can see
why it's that way but as a user it's unhelpful.

Regards,
Tom
