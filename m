Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C70CC433F5
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 22:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379967AbiBEWgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Feb 2022 17:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiBEWgM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Feb 2022 17:36:12 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9079BC061348
        for <git@vger.kernel.org>; Sat,  5 Feb 2022 14:36:11 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ka4so30465300ejc.11
        for <git@vger.kernel.org>; Sat, 05 Feb 2022 14:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fq5X/MFVlLFMffx/FhsIDNFyop3RgLI3h6u0AmwuyuE=;
        b=Jd9cgJ7r6TllGyCBWw43Qy5cidIR89eztBmDSV8fJItR6/JKT0mEQT4GfpfKhGBp2M
         DekRhLCXOs8wENSVA/lRLjxqaSLbFvvy209OZ/f0dYfzA2YSn/YA220IEd6MOjfLOWwi
         KVt+8S/apCUQBBk39w5PTe2IaJZPLEfk0ACN4NUtEmzQKubDzCxxeq2mC2PYKQ8TO8fz
         bjO9fjpQ0NcsDyg6BqGQPtubNDjvSeAwjMbMXWUkkh9VQBKjrmOvnDH4yNIz3MJv1aVZ
         7ct/SHqKMH5Rbr9pV7yDZf5HN4KT0gBOXvCYasCvcHAkljteqUE6kzoPGS9VnrW3ierd
         IRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fq5X/MFVlLFMffx/FhsIDNFyop3RgLI3h6u0AmwuyuE=;
        b=mGlTSEmWaxBQ6kQGzMQRy7kPGjc9S8FSAitAY9EQqlXJ40Tk4JDjB5+0+Qmy5kCg8J
         ReNOf8ApVe8IFTThycDeUYIw3MZky4kLJWTFCWBiLl2IcNB1ZYy/6j9TtG0f1qysEWqF
         bcnG5o4AE0QiEKYPJ2/COqQlX49YptBDSOBWM9Abg+J7q3WBB1IDX8KSIcsJbZRtgcp3
         op938mLi0caWoCyJ1z+ORYUg+QCsrwsfHdvcgICH/fIMAHMZ5W9kXZiG0TcJyVsWc/TZ
         YHXFEBLIgld5o5MI6ks6+i7nbHNJa4u8Wvgg2xdtlRW5pKxBLfJJh52P55dfV+CGnVEY
         EYfA==
X-Gm-Message-State: AOAM532d4PKXbwIMHbL7Yo5XLyxT7zXjoluI2zRv9dzjaJ0ApRs+xFcG
        I4zLoxXlOINbpx+EJKfV637GlgHEmKEfOTimBbg=
X-Google-Smtp-Source: ABdhPJzz77G0jCE/hY58N+4R6OgHVvYmVajONgHJOYVDfxtoRQ+o9sVNH9+6ws1B59IYbweRzYsJKWrYF1P8uYJNe3s=
X-Received: by 2002:a17:906:4793:: with SMTP id cw19mr4478490ejc.100.1644100569934;
 Sat, 05 Feb 2022 14:36:09 -0800 (PST)
MIME-Version: 1.0
References: <CAPig+cQVNdmHQnhORqh2XtJSMhcOymR99pmKTWOAyhoQ10khSw@mail.gmail.com>
 <20220127200341.333996-1-newren@gmail.com> <CAPig+cSi8_90=-Fvt_fq=VtOW_HzifNhrk1gaa6F1GrEonng+Q@mail.gmail.com>
 <CAPig+cRCN=QQHupg1eOx9YvsLhgn+dDN6eYvQL6JhzknCa_3=w@mail.gmail.com>
In-Reply-To: <CAPig+cRCN=QQHupg1eOx9YvsLhgn+dDN6eYvQL6JhzknCa_3=w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 5 Feb 2022 14:35:58 -0800
Message-ID: <CABPp-BEd6ZoOSaA1agmaDX8q2Q7fAvoDfiPPTbKv6AatLvsHaw@mail.gmail.com>
Subject: Re: [Bug] Rebase from worktree subdir is broken (was Re: [PATCH v5
 07/11] rebase: do not attempt to remove startup_info->original_cwd)
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Glen Choo <chooglen@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 5, 2022 at 3:42 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sat, Feb 5, 2022 at 6:23 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Thu, Jan 27, 2022 at 3:03 PM Elijah Newren <newren@gmail.com> wrote:
> > > Some comments on the various code changes:
> > >    * clone/push/fetch related:
> > >      * there are *many* subprocesses involved in fetch/push and friends,
> > >        and they typically need to know the GIT_DIR they are operating on
> > >      * this involves: fetch-patch.c, connected.c, bundle.c, clone.c,
> > >        transport-helper.c, receive-pack.c, upload-pack.c
> > >      * this accounts for the majority of this patch
> >
> > It does feel a bit like a bandaid to insert new code at these
> > locations to set GIT_DIR manually. It's not clear to readers why
> > GIT_DIR is needed for these specific cases, nor what the impact is
> > when it is not set. Thus, one wonders if such a blanket approach is
> > indeed required or if a more narrow and directed fix can be applied,
> > such as calling subprograms with an explicit --git-dir= rather than
> > setting GIT_DIR with its potentially more broad and
> > difficult-to-reason-about impact.
>
> I meant to ask here what was the nature of the various failures you
> were seeing without GIT_DIR being set, and whether you had considered
> tackling those failures with --git-dir= instead of GIT_DIR. If so,
> were the problems too difficult to overcome by --git-dir= alone?
> Fleshing out the commit message with such information might be
> worthwhile.

clone, receive-pack, etc. will often spawn subprocesses such as
repack, or index-pack.  Those kinds of commands will not have been
invoked from within a particular git directory, so discovery in the
subprocess either doesn't find the git directory or finds the wrong
one (e.g. testcases where you're in a repo and do `git clone .
my-clone` would cause subprocesses to use discovery and find the outer
git repo rather than the 'my-clone' they are supposed to be working
on).

I didn't look at just --git-dir=.  I probably could have, but since I
was just trying to get a feel for how big of a change it was, and
there's the possibility of nested subprocesses (clone forking some
http-fetch thingy, which forks an index-pack subprocess, etc.), so I
just did the environment variable to save the work from diving down
the hierarchy.

I agree that if we want to make this kind of change, a better commit
message would probably be in order, and perhaps trying out --git-dir=
instead of setting the environment variable.  However, after seeing
the patch myself and thinking about it for another week, this just
doesn't seem like a change that's worth it to me.  If someone else
wants to pick up the patch and run with it, they should feel free, but
I'm not motivated enough to do so.

> By the way, I also didn't mean to imply that the
> "difficult-to-reason-about GIT_DIR interaction in relation to
> subprograms" problem is new to this patch; it isn't. That problem has
> been around for ages (at least since 2007-08-01) but it wasn't as
> obvious since the setting of GIT_DIR was so far removed from other
> code which runs subprograms, thus readers likely wouldn't be thinking
> about GIT_DIR when reading the code which runs subprograms. This patch
> only makes the problem more obvious since readers now see the
> sequence:
>
>     (1) set GIT_DIR
>     (2) launch subprogram
>
> So, a reader is more likely to wonder why GIT_DIR is needed for the
> subprogram and what possible wider side-effects it might have.

Yes, well put.
