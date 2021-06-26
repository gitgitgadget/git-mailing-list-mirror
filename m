Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380C1C49EA5
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 10:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7A161492
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 10:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhFZK3T convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 26 Jun 2021 06:29:19 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:40743 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFZK3S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 06:29:18 -0400
Received: by mail-qk1-f179.google.com with SMTP id x1so18026319qkp.7
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 03:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gOnvvkNZi6L0Bxi/L8LeARixuIlYNsiYgbNIJ54VkM4=;
        b=J0s7SD0zAhB4x4XN4pI4ug6+x4iPUmQNP6VWqCCDrYSFKPd4XazK1h3ltuXXC82kn0
         s62jI+fzfGAq9PzWW/1aAyB0dLf8F2A/kYByTwftOJP3bZlw14ogr5XqSFPVm8BFEL0A
         T3KKjp3lB4XEN9D1SMLad1zFSa+XJZ/wq/L2csxMcDpmA6fXiwIqcj3zkU9uTIHDytZj
         aLqSEICXQu+dBiWUFB0Vgy8gBTjvZBUwb88DgJgmlLI+UGR0RgLxbRL+5Fdk6t08C3oj
         g52exMnuTNSu7YtOUSFRtWpZD/TyjcqQMh4ap/dWml1gbN7FEYGEATd2+fu4p5bBMUqI
         7pXQ==
X-Gm-Message-State: AOAM530wDDDKe0P4x6SthNOg6quy4sa93BX9VRh7++rdY9yIU31Lf6of
        DbfE3H5Nf40YggNlnqER4o5kJD2EP7N1Cw==
X-Google-Smtp-Source: ABdhPJx77q7Ft8lvUKm/2QWB4LwfPXDirxZBGdaAapjPox/ufgzIxhj42BgaToljS5euvaxuwn1k4A==
X-Received: by 2002:a05:620a:d42:: with SMTP id o2mr15367093qkl.233.1624703207409;
        Sat, 26 Jun 2021 03:26:47 -0700 (PDT)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id l14sm5567050qtj.26.2021.06.26.03.26.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jun 2021 03:26:47 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id bm25so22105342qkb.0
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 03:26:46 -0700 (PDT)
X-Received: by 2002:a37:ac14:: with SMTP id e20mr25863qkm.362.1624703206717;
 Sat, 26 Jun 2021 03:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com>
 <077d147c-c22f-6463-6545-3aa991e7868b@gmail.com> <b5462f20-5d9d-4775-ad5c-c8de686167af@gmail.com>
 <CAJ-0Osy9JhGD0=6eF3jgZuoHJEzymksCWZZZC+A4FtHxzOrdhA@mail.gmail.com> <87pmwazygf.fsf@evledraar.gmail.com>
In-Reply-To: <87pmwazygf.fsf@evledraar.gmail.com>
From:   Avishay Matayev <me@avishay.dev>
Date:   Sat, 26 Jun 2021 13:26:35 +0300
X-Gmail-Original-Message-ID: <CAJ-0Osz-1PPQR-_k3_Qf8e0hJ8c43XbK3tzS=rVsvgFfk83ptA@mail.gmail.com>
Message-ID: <CAJ-0Osz-1PPQR-_k3_Qf8e0hJ8c43XbK3tzS=rVsvgFfk83ptA@mail.gmail.com>
Subject: Re: Forcing git to use a pager without a tty
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 25 Jun 2021 at 01:31, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>
>
> On Thu, Jun 24 2021, Avishay Matayev wrote:
>
> It's interesting that your original mail didn't end up in our main
> archive:
> https://lore.kernel.org/git/CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com/,
> but e.g. marc.info has it (and it's in my mailbox):
> https://marc.info/?l=git&m=162440160200930
>
I guess the empty subject tripped it somehow, oh well..
> > On Wed, 23 Jun 2021 at 12:29, Phillip Wood <phillip.wood123@gmail.com> wrote:
> >>
> >> On 23/06/2021 10:05, Phillip Wood wrote:
> >> > Hi Avishay
> >> >
> >> > On 22/06/2021 23:40, Avishay Matayev wrote:
> >> >> Hi there!
> >> >>
> >> >> Fugitive[1] is a vim plugin that wraps git and many of its commands
> >> >> into the editor in a really awesome way, I won't meddle into it too
> >> >> much as you can read about it in its README, but as you understand, it
> >> >> uses git, a lot.
> >> >>
> >> >> Some git commands use a pager, which is usually a program that needs a
> >> >> pty to function properly (`less`, for example). Fugitive can't really
> >> >> use a pty for the pager as vim runs its subprocesses without a pty.
> >> >> Therefore Fugitive just creates its own pager (which is a simple
> >> >> window in vim) and pastes the git command output there.
> >> >
> >> > If I understand correctly fugitive is reading the output of the git
> >> > command over a pipe and putting it into a vim buffer?
> >> >
> > AFAIK, no. It could read the output through vim's jobstart API (that calls a
> > callback when there's activity on stdout for example) or by
> > redirecting the output
> > to a temporary file and reading it.
>
> ...
I might have taken the word 'pipe' too literally :)
>
> >> >> The only problem left is that Fugitive can't reliably know when git
> >> >> decides to use the pager, for example `git reflog show` does raise the
> >> >> pager while `git reflog expire` does not. Fugitive currently maintains
> >> >> an (very possibly) incomplete list of commands that need a pager but
> >> >> maintaining it manually isn't ideal.
> >> >
> >> > I don't understand, if as you say above there isn't a pty then git wont
> >> > use a pager unless GIT_PAGER_IN_USE is set which Fugitive does not seem
> >> > to,
> >>
> >> Sorry that is confused. GIT_PAGER_IN_USE only causes git to act as if a
> >> pager is being used (for example so it colors things as if it was
> >> outputting to a tty), it does not invoke the pager
> >>
> >>   so I'm not sure what you mean by 'Fugitive can't reliably know when
> >> > git decides to use the pager'
> >>
> >> I'm still confused by this - if there is no tty git wont use a pager.
> >>
> > That's the problem, git doesn't tell whoever calls it if it is going
> > to use the pager,
> > and that information is useful for Fugitive. Why? Because even if
> > fugitive just naively
> > reads git's output, it doesn't know whether it needs to open a pager.
> >
> > i.e If the user calls `git log`, the log is printed through the pager.
> > However, if a user
> > calls the exact same command through Fugitive. Fugitive needs to know
> > ahead if the
> > resulting command is going to need a pager (AKA a new window in vim) and prepare
> > accordingly. However, since git does not tell us when it's going to
> > open a page, we
> > have to book-keep commands and whether they are going to use the pager or not.
>
> Having read this thread it feels as though there's a missing description
> between the 2nd and 3rd paragraphs of your original mail.
>
> I.e. you never really explicitly said what you're going to use this for,
> and why it's needed, but I think I get it now.
>
> The "straighforward" thing to do would be to just capture stderr/stdout,
> which is what e.g. Magit does, which I gather is a similar thing to this
> "Fugitive" thing, except for Emacs (I use Magit heavily, I've only spent
> ~5m browsing the Fugitive page for the first time, skipping through a
> couple of screencasts).
>
> But what you're doing in this editor plugin is assigning semantic
> importance to if and when git uses a pager. If it would you open a
> dedicated window with the output, if it doesn't you presumably show it
> differently, just the exit code, in some "raw git output" buffer or
> something?
>
No, there's no semantic importance. If a command has semantic
importance, Fugitive will act appropriately. We want to know whether
git is going to use a pager to provide *correct* behavior for the most
simple cases, which is either open a pager with the output, or don't.
> > 1. https://github.com/tpope/vim-fugitive/blob/79e2bd381ad6e7f3d70ce4a8ec9f3f107b40f053/autoload/fugitive.vim#L2951-L2956
> >
> > This is the current proposal:
> >
> > --- a/pager.c
> > +++ b/pager.c
> > @@ -45,7 +45,8 @@ const char *git_pager(int stdout_is_tty)
> >  {
> >         const char *pager;
> >
> > -       if (!stdout_is_tty)
> > +
> > +       if (!stdout_is_tty && !(is_terminal_dumb() &&
> > git_env_bool("GIT_FORCE_TTY_DUMB", 0)))
> >                 return NULL;
> >
> >         pager = getenv("GIT_PAGER");
>
> So yes, I could see how this would be useful, and FWIW I've got nothing
> against such a thing, it just took me a while to understand what you
> were going for, and maybe I still don't get it.
>
> I will say that I think this approach is /probably/ not a very fruitful
> one in the longer term for an editor plugin.
>
The main problem this change solves is overriding git's decisiveness
on how to act in certain situations. e.g. If no pty is present, git won't
open the pager, i.e git will never invoke the command that is inside
the PAGER environment variable. If no pty is present, git won't report
its progress on a `git push` through a progress bar.

Forcing git to always act like it has a pty will allow fugitive to present
these 'advanced' features to its users.
> E.g. in Magit everything we'd invoke a pager for such as "log", "blame"
> etc. is a dedicated top-level command, Magit heavily modifies the UI, so
> e.g. for the "log" equivalent you can "click" on commits, fold them and
> their diffs etc.
>
> So "does it use a pager?" nonwithstanding I'd think any sufficiently
> mature editor plugin would end up having to maintain its own list of
> "this is an interesting command, and this is how I make use of its
> anyway. So the equivalent of piping what we'd send to the pager to
> another FD (or setting a flag or whatever) wouldn't be very useful in
> the end.
>
Yes, but not every command is an interesting one. You don't need a
special window for every command, and some commands don't even
have any output besides their return value.
> But hey, if it works for you why not :)
>
> What do you do about things like "git status" etc. that produce a lot of
> output, but don't invoke the pager even then (but perhaps should), ditto
> for all the plumbing or plumbing-like such as "ls-files", "ls-tree" etc?
>
`Git status` (or just `Git`) is special because it opens the fugitive status
buffer (just like the one Magit has).

`git ls-files | ls-tree` just create an output window that shows the output
of the command, that window disappears on any keystroke.


I'd also like to add that I am just a regular user of the plugin, I've never
committed anything to it and I just wanted to solve an issue that
bothered me, so what I write here's from the perspective of a user (and
someone who can read code), not from the view of a maintainer or
the designer of Fugitive.

Avishay
