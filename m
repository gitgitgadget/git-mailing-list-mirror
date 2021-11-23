Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF8AC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 20:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhKWUg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 15:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhKWUg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 15:36:26 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E02C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 12:33:18 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id b8-20020a17090a10c800b001a61dff6c9dso214803pje.5
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 12:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qj9DDjF+mySAWg/v5UyWgXyne+T1Mdt24tJgJXRJFaI=;
        b=tPRfKp2g6NgHXZ5PWNfMLQPL1Es2/d1/wnhcsbx3qsGsPowHRNovxtjkZ4j24naQGF
         QjoanNe0FjdxubvShMeSMMENuVx4RyB+L499BhWxioOyMpIYkymFGfd5uqL+ZLO7+e2B
         TQOGwlZcvaMf31eWhPkddOk2DcOMJEIxptX2ABPBRQSdKZg4z/oY9T+uBLUyOc2upH1f
         fDW6V5trB6T+oojDn2yNe7eIfSXtBzDb/F3VXkXhjT4zCgpde3q6oI65bPSy5v6E/ckp
         Q4Y0RjHT8Gmli8u1DJjiQKvuLRkCe/esiv9WQ4T/ke5EkDnAozDJai+UjlkgSdREI4z2
         Xydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qj9DDjF+mySAWg/v5UyWgXyne+T1Mdt24tJgJXRJFaI=;
        b=eW2l59pXXPUIuaa7grkZs5HHyrp3tthCbMY7auCYC0+GfDTxGziIg+20zZePYsuMIs
         T+Pdsjv0ECR+N2ZBm2dl+7ct0WzNTHFkTp+OZk0URX+7+3yZThwtErson57/vV5IfJwN
         xI+ZkjOGyfIOzRpkaIQoPLcqXEdlsdYhSaKUVAlBrAqn2+tq/gqaT7xlEsM/B7k9Uc8L
         qTyiAJeqCoOtMCCJeIfw6Vn4/kuVDAyPFP3lq346rweA54mBQ4fMPXTxnfAqo6CVTLjI
         38+IYw/pG5Hdu3GlSqbIqb96XRm57ppsN29Bx0nr1H1jyIoIHw1kYnW4JX2WxMbPmzSy
         A3+Q==
X-Gm-Message-State: AOAM5317Sbzir940n9yJgf6hNDWnR757shIBVK6J4MFL4vEowTIUwfVs
        /Vi6ILaRvcbIdwgVJEOe8ubrk4xcH/BaSg==
X-Google-Smtp-Source: ABdhPJxbgdvFL9XXwaTESyzWUq4SurMVf8DiYEzGmMTdCqtZ1H99F+gfCA6Ilsxchdsi43szbHzs5lurbkFekA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:72c4:: with SMTP id
 l4mr6682414pjk.149.1637699597800; Tue, 23 Nov 2021 12:33:17 -0800 (PST)
Date:   Tue, 23 Nov 2021 12:32:43 -0800
In-Reply-To: <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
Message-Id: <kl6lzgputxxw.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
 <20211123003958.3978-1-chooglen@google.com> <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
 <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com> <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> I agree that most, possibly all, of our commands should prefer to die
>> than to remove the cwd, but that doesn't justify adding
>> application-level concerns to a general-purpose utility function. Even
>> if it sounds overly defensive, having an obviously correct utility
>> function makes it easier for future authors to know exactly what their
>> code is doing and why. And surely if we're imaginative enough, we can
>> definitely dream up some possible use cases for remove_path() that don't
>> want this dying behavior e.g. other applications that link to our
>> libraries, or some new merge strategy that may need to remove + restore
>> the cwd.
>
> Sounds like your objections here are based on a misunderstanding.  I
> totally agree with you that adding dying behavior to these functions
> would be wrong.
>
> My patch doesn't do that.

Ah my mistake, that should be s/die/'stop gently'. Even so, that is not
at the core of my objection, mixing of concerns is.

>> I'm not going to say that we'll *definitely* need remove_path()
>> in its current form, but mixing concerns like this is an invitation to
>> unexpected behavior. An (imperfect) example that demonstrates this
>> principle is https://lore.kernel.org/git/24bffdab139435173712101aaf72f7277298c99d.1632497954.git.gitgitgadget@gmail.com/,
>> where we made a change to a generic path matching function in order to
>> speed up unpack_trees(), but accidentally ended up breaking gitignore.
>
> There's no mixture of concerns; my patch is correcting this library
> function to more fully match its documented intent; from dir.h:
>
>     /* tries to remove the path with empty directories along it,
> ignores ENOENT */
>     int remove_path(const char *path);

I don't think that there is a mismatch; reading the implementation +
documented intent seems to make it clear that 'emptiness' is defined by
directory contents, not the presence of any processes using it as its
current working directory.

> Since the parent process's current working directory is still likely
> parked in that directory, there is a good reason to treat it as
> non-empty.  Thus the cwd should not be one of those directories
> removed along with the specified path.  No need to die, just stop
> removing the leading directories once it hits the cwd (much like it'd
> stop once it hit a directory that had files left in it).

This doesn't sound like a typical definition of 'emptiness' to me, but I
can accept it if others also find it compelling. IOW if your definition
of 'emptiness' is compelling enough, then I'll be convinced that there
is no mixing of concerns and there would be no objection.
