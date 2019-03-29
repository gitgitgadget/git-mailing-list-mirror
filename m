Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FEA920248
	for <e@80x24.org>; Fri, 29 Mar 2019 14:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfC2O2I (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 10:28:08 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37098 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbfC2O2I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 10:28:08 -0400
Received: by mail-it1-f194.google.com with SMTP id u65so4156872itc.2
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0pkVNwhMrpMoYRGbEdTbiLveyuyYLyR/EDXOD0z60PY=;
        b=EdIt9Q4DdJZCv6PaeJQxQhxJ0iR+3ifFZ254HJaX3GtGKDIMtQZxz7UJpvtb6R4T8c
         q2nca9pit+G300OtVLJ6y55IUMIC3D8tOpwxlMSxR3Yvk9dqZACD/LFbJplbxY/Paq3o
         9lFj5N3kLnaMg3wKDR8UZVFqD/0+YIszq0xSguyY2HKYdTUg+rI0K63atr0fNDKO3OK6
         L7plCxGmMLgdr5zyqGqBUggaJ6LbfH/hXTEfCDzS1uPgf5eCvvNRnvrYMLRlXYkScH1v
         YcZwZTNCU2m/lJJq0jjI3SSQhAUQvWgbg20/UNS3cZ8KxpZsmHLDzxIyRTsj2/P4Yaf+
         eM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0pkVNwhMrpMoYRGbEdTbiLveyuyYLyR/EDXOD0z60PY=;
        b=UbKAJoGUAwDNyrfs3mr1YOyegd4jSfAhYOi16UoYyxEP00uti6VRxO77k+zxjwSlS6
         UdudT8s8DzxNzPlHYEXxMuwj0lCEh/mgS+Ol9n0rCXfgCRIkBlwX/fxEF3xayzyVir4W
         L5azASq8LvTa7MCkPywPcl8QLU7qoEaFN7rH4Hj/WcGSS8y1By1A5XkJ9sqwnmfOpw7B
         J4zmpw56GtBwpj0X27Xv8SSOWyfXIRTiY88Id8y7lxg5ZIF8CoH50F3amFOj7hBIh3hA
         jnhMHPVTa15rqI0LWzUxx0PIlUPks/rUaR1LX3KhfZsxiVt4GQtlov+Xl3fjKmjTmnro
         PDlw==
X-Gm-Message-State: APjAAAXr3i8ga9JdgA+USvhYtL0IY7pkWy7A8q6Jgy30pkTeY4ZVD1W/
        3ctzB1CuiRV7Ij2OH5JUyN0CBh8tPakMdzoPO0afYw==
X-Google-Smtp-Source: APXvYqwZ6Qq2UNgiS+Z6YaEdNYoEStcpc32yDwJeHjiO5XZm6CTlEkvJsBrC2wqIxCKyyXUwaWFqFf+pHPDkbCh2Eq4=
X-Received: by 2002:a24:4682:: with SMTP id j124mr1234668itb.90.1553869685776;
 Fri, 29 Mar 2019 07:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190226122829.19178-1-avarab@gmail.com> <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190322232237.13293-3-matheus.bernardino@usp.br> <20190328221049.GK32487@hank.intra.tgummerer.com>
In-Reply-To: <20190328221049.GK32487@hank.intra.tgummerer.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 29 Mar 2019 11:27:54 -0300
Message-ID: <CAHd-oW78Cwhq8sFFjOX4c6kS8JsEUUd_RGgheJhdN6MLAr+G2Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4 2/7] clone: better handle symlinked files at .git/objects/
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Kernel USP <kernel-usp@googlegroups.com>,
        Benoit Pierre <benoit.pierre@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 28, 2019 at 7:10 PM Thomas Gummerer <t.gummerer@gmail.com> wrot=
e:
>
> On 03/22, Matheus Tavares wrote:
> > There is currently an odd behaviour when locally clonning a repository
> > with symlinks at .git/objects: using --no-hardlinks all symlinks are
> > dereferenced but without it Git will try to hardlink the files with the
> > link() function, which has an OS-specific behaviour on symlinks. On OSX
> > and NetBSD, it creates a hardlink to the file pointed by the symlink
> > whilst on GNU/Linux, it creates a hardlink to the symlink itself.
> >
> > On Manjaro GNU/Linux:
> >     $ touch a
> >     $ ln -s a b
> >     $ link b c
> >     $ ls -li a b c
> >     155 [...] a
> >     156 [...] b -> a
> >     156 [...] c -> a
> >
> > But on NetBSD:
> >     $ ls -li a b c
> >     2609160 [...] a
> >     2609164 [...] b -> a
> >     2609160 [...] c
> >
> > It's not good to have the result of a local clone to be OS-dependent an=
d
> > since the behaviour on GNU/Linux may result in broken symlinks, let's
> > re-implement it with linkat() instead of link() using a flag to always
> > follow symlinks and make the hardlink be to the pointed file. With this=
,
> > besides standardizing the behaviour, no broken symlinks will be
> > produced. Also, add tests for symlinked files at .git/objects/.
> >
> > Note: Git won't create symlinks at .git/objects itself, but it's better
> > to handle this case and be friendly with users who manually create them=
.
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> > Co-authored-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
> > ---
> >  builtin/clone.c            |  2 +-
> >  t/t5604-clone-reference.sh | 26 +++++++++++++++++++-------
> >  2 files changed, 20 insertions(+), 8 deletions(-)
> >
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 50bde99618..b76f33c635 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -443,7 +443,7 @@ static void copy_or_link_directory(struct strbuf *s=
rc, struct strbuf *dest,
> >               if (unlink(dest->buf) && errno !=3D ENOENT)
> >                       die_errno(_("failed to unlink '%s'"), dest->buf);
> >               if (!option_no_hardlinks) {
> > -                     if (!link(src->buf, dest->buf))
> > +                     if (!linkat(AT_FDCWD, src->buf, AT_FDCWD, dest->b=
uf, AT_SYMLINK_FOLLOW))
>
> This line is starting to get a bit long, might be worth breaking it up
> to keep to 80 characters per line.
>
> I notice that we are currently not using 'linkat()' anywhere else in
> our codebase.  It looks like it has been introduced in POSIX.1-2008,
> which sounds fairly recent by git's standards.  So I wonder if this is
> really supported on all platforms that git is being built on.
>
> I also wonder what would need to be done on Windows if we were to
> introduce this.  I see we define the 'link()' function in
> 'compat/mingw.c' for that currently, so I guess something similar
> would be needed for 'linkat()'.  I added Dscho to Cc for Windows
> expertise.

Ok, what if instead of using linkat() we use 'realpath(const char
*path, char *resolved_path)', which will resolve any symlinks at
'path' and store the canonical path at 'resolved_path'? Then, we can
still keep using link() but now, with the certainty that all platforms
will have a consistent behaviour? (also, realpath() is POSIX.1-2001)
Would that be a better idea?

> While I agree with the goal of consistency accross all platforms here,
> I don't know if it's actually worth going through the pain of doing
> that, especially for somewhat of an edge case in local clones.
>
> If the test in the previous patch passes on all platforms, I'd be okay
> with just calling the behaviour here undefined, especially as git
> would never actually create symlinks in the .git/objects directory.
