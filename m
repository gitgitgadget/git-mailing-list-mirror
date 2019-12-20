Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1622CC43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 10:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82B52467F
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 10:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brightrockgames-com.20150623.gappssmtp.com header.i=@brightrockgames-com.20150623.gappssmtp.com header.b="Kn+0P1fh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfLTK7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:59:01 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:36089 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLTK7A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 05:59:00 -0500
Received: by mail-wm1-f52.google.com with SMTP id p17so8774556wma.1
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 02:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brightrockgames-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=wKBhLHATKV/iHpYra/bvMdgyXAeyF/bXoJJjWpZZCf4=;
        b=Kn+0P1fhSFB5M4jZAxsTwTdsss9R5cEHg/aRulhjQc511yEjD7ZTnFbDnuTLHz2KwO
         4xQ2m5a2jG1Ew/+nuWAtHJFGC6W6lq9PVHwI0orhZMY/9U/rRQO0OdOPPEfytaLb0cet
         aT57eCqb+yF4TQQmILthIEhXFvj6PApESEi0n/kp7I1cHcA3abUACMve0OuLi49UOe+8
         dJ6XORBoHZIRG5aApnoKBufiGisCFwP1VumOI9fRB6j0i76AkHuw8JKS5eqX9RyRvkbi
         1sdAx8SUF4SMYY6eRtAVIH4sVy/GZMmIntjHWZDDyqkxF6LRaaCttygzXTi8mYQwVcai
         PU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wKBhLHATKV/iHpYra/bvMdgyXAeyF/bXoJJjWpZZCf4=;
        b=Cb57r6GrQCBozKOA7JfI4xsJzQFormj1tarcPAg24apaMbs+ydx5zaRrkwuw9JwyMj
         Kax8R1iIgSBEVn8wciX8TCicWkvdtc18SvKVWTEjVZ0nrpM/ISc4ko0PdQGvTMkRgywI
         naGj5RK/GD2K4nrTO8clogW5fydDOC2i8vU4kpIMoYr3unBySU7eLXxpgcgjkYo7eCH/
         ur7+HWFSIzFTSNPGAK6lwWkDpX8tFr/xx27zKZ365x/ihrc5rZ7ide4zBfIqTxZ5H8Hh
         a362NEe3WvrevKGDxf30trSQxU7qF9Os6Zm+1/130uukm4EsTj/yyFxVy0sbgi1LmtJp
         TGyA==
X-Gm-Message-State: APjAAAXs9yG5EO7qgS8I3uetZ0kYdRtYbsCwOORSQK4yvnIjGd5x62Ld
        nXrbDlmftslS1Xi/KDt4ooLU8wd0caDU0f5vDGR1sA==
X-Google-Smtp-Source: APXvYqx/5yG3m2XsN0dspmcfmsIWKly5Phm1icVexDnAD5MC8s9OJBubqzb5kWnExRXA6BnVQx58GFqE1rMY/mUHRpY=
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr15503194wmh.35.1576839537500;
 Fri, 20 Dec 2019 02:58:57 -0800 (PST)
MIME-Version: 1.0
References: <CAB1T5w2GyfERoaCyFZeKaui_xuXd0r6J+Zvq4pecstBJ9UyRzw@mail.gmail.com>
 <20191220030259.GC163225@camp.crustytoothpaste.net>
In-Reply-To: <20191220030259.GC163225@camp.crustytoothpaste.net>
From:   Scott Richmond <scott@brightrockgames.com>
Date:   Fri, 20 Dec 2019 10:58:47 +0000
Message-ID: <CAB1T5w0_Dp5u9JYRqGnQbuaL_pV2VN2ZTpXkDEJrEyHR2WJ3yA@mail.gmail.com>
Subject: Re: Ability to ignore EOL changes for certain projects
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Scott Richmond <scott@brightrockgames.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'm not sure this syncs up with your statements below...[snip]

Unfortunately it is the latter case where certain dev apps, or plugins
within dev apps, that can occasionally write incorrect line endings.
We don't have configurable control over these things unfortunately.
If I widen the scope to all the scenarios you presented though - My
feature request could still have value as another way to alleviate the
pressure EOL changes create on a git repo. I would agree that it would
be best to solve the problem at its source where possible, but it is
sometimes not possible.

> I'm not sure how such a feature would interact with how Git operates when it re-reads the index...

AFAIK git status does not filter the results, as that would push
writes to files (I think?) when the user wouldn't expect it to. So it
makes sense that actions such as git status are unaffected by
text/crlf options.
I agree the additional cost to run a filter or similar action with git
status would be a cause for concern, but maybe an optional and
acceptable trade-off for the pain it alleviates elsewhere.

I do not know the underlying way git works either, but I suspect it
would have to be a 3rd test after sha1 & oid against the files that
come out of git status. I'm guessing that is an area of git that has
little configurability and therefore very difficult to make changes
to. :/

Regards,

Scott Richmond.
  Director, Producer, Programmer
  Brightrock Games
  T: 07480795661

On Fri, Dec 20, 2019 at 3:03 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2019-12-18 at 11:10:27, Scott Richmond wrote:
> > The Problem Domain
> > In certain dev environments (Unity3D projects) there is (AFAIK) an
> > unsolvable problem where some files are often modified with line
> > endings that aren't the native system or not the committed line
> > endings for that file. Secondarily, in this case line endings don't
> > matter - Nothing in the dev environment "cares" which kind of line
> > ending is used.
>
> I'm not sure this syncs up with your statements below.  Typically,
> programs that do editing of text files either (a) write the line endings
> that the file started out with or (b) write the system line endings.  If
> you set the appropriate files with the `text` attribute in
> `.gitattributes` (or use `* text=auto` if appropriate), then Git will
> always write in the system line endings and convert internally to LF,
> and programs that do either (a) or (b) will work.
>
> Yet it sounds like you have development tools that don't do either (a)
> or (b): they write in some fixed line ending, and therefore care very
> much which line ending is being used.  In such a case, you could
> write (for example) `*.yaml text eol=crlf` (or `eol=lf`) if you always
> want them to do that and Git will convert to those line endings and
> store in LF.
>
> If the problem is text editor settings, you can use a `.editorconfig`
> file, which is a cross-platform text editor configuration that can
> specify line endings.  Most text editors can be configured to honor such
> settings, although it may require a plugin.
>
> If your problem is a shared Windows / Linux environment like WSL, you
> can set `core.eol` to `crlf` in the repository and things will work.  If
> you need settings like this, you can even set them up appropriately for
> the system using a make target or bootstrap script so you don't need to
> do that by hand on each system.
>
> If you do this, then your tools will write the same line endings as are
> checked out, and files won't appear modified.  You can see how Git
> itself uses this to set up files appropriately for different systems.
>
> The only case this wouldn't work is if the tools wrote some random line
> endings depending on an attribute other than the OS they're on, or if
> you had multiple tools doing different things.  If that's really your
> problem, then yes, you'd need a new Git feature.  It is of course
> possible to use a filter to strip out all carriage returns, but that
> doesn't prevent Git from showing the file as being modified.
>
> What I've proposed, of course, requires some setup work and
> configuration.  It isn't trivial, but it does work for a lot of projects
> already.
>
> > Solution Request
> > It would be fantastic if we could tell Git to stop caring about EOL
> > changes on a per-repo basis, with the effective output being that git
> > status shouldn't show changes for files with differing EOLs.
> >
> > I'm experienced with Git, though I am not expert enough to consider
> > creating such a change myself - It is unclear to me just how
> > complicated a change may be. However maybe I could look into it if it
> > was made clear that this improvement is possible and has no serious
> > side effects.
>
> I'm not sure how such a feature would interact with how Git operates
> when it re-reads the index.  It isn't 100% clear to me when data is
> filtered through various text filters such as EOL filters.  All the
> filtering I've used is one-to-one, and therefore any modification of the
> file contents necessarily means that the indexed contents have changed.
>
> If Git does apply such filters when refreshing the index (such as
> happens before `git status`), then such a feature would be relatively
> easy to implement, although you'd incur a performance penalty when
> changing the EOL of a file, even if the file were otherwise identical.
> I suspect it would make the most sense as an additional value for
> `core.autocrlf`.
>
> If Git doesn't apply those filters, then there really isn't a way to do
> what you want without fundamentally changing the characteristics of how
> Git operates on the index, since it would still show files as modified.
>
> Maybe someone else can comment on the feasibility of this better than I
> can.
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204
