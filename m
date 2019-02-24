Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0089C20248
	for <e@80x24.org>; Sun, 24 Feb 2019 09:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfBXJlT (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 04:41:19 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38895 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbfBXJlS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 04:41:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id h58so5188702edb.5
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 01:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y+pXFvPLpqFFLA/0eal7fdedhUfx46Km3q6mHbCCSzw=;
        b=li1B7I1sOes41BI7E00PzzSwZZbV1OdaJGxU0P+u2uprdQ6ZjRca2hkYTKG/1OT/+3
         0c6tW3a+zgzg6gRymkdpOk6tomdLHaLduy7YrJbUEAL7gKIRdrbpFNO5Gwrl94fe5ebA
         MVlIJ6KCKz2PHDk1zI9w6OUggTHBDX3deb7m4i+NzDoPZ7z7WD6XKhE2sK99YoPcnjaK
         51tJtKghKRJRHXRgzZcuHxTlzDc0nJMunEgPcxoAlKeSmjW1vgultZStWijyo6HDzMcD
         WwPzjgirP4SkARgnFWXWaTsN9+NkOPgl9c8t4aUltGAVCTAYlh8jsH+lXoG4yQKpWYPZ
         CuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y+pXFvPLpqFFLA/0eal7fdedhUfx46Km3q6mHbCCSzw=;
        b=LmUGP33IzfOoY952oT8cfNQdp3stAjB30YtRLtQmC3V8PP2ArVXNP+hJY/R6wJEG0S
         msiPY0uqwh86uAHFzacJzirIJkNvkR1Pl+6CmP2oCArgE3rdReTNBaxD+uB1CY1u9YP7
         F8wZ9nITbJYjtRveO2OLOUYRBfImXIW0tHVcJ94MAB0MnWXz+PPP02+ysDr08w62K2jW
         3hW4VFn4DWM7nKiE1KAJIC3eT1al9KOXFiB6orM1zM3k7cdleV8RfjpYHNIGcPfXzYJI
         LdUahWBSzIsOQ+pd5iVuqL8k8cdOCU+qSHnpY8HpHtyiWMWltpjZfmmP+umurZWwp37/
         iCkA==
X-Gm-Message-State: AHQUAuYiq9SW6fQog95sqqfzEaILWDcZ0DRCd4RHTzCZXM1xJR6/4xKe
        XZdKliG8UKn0I8Q+5PprzCD3UvSoRzKrK5l46ec=
X-Google-Smtp-Source: AHgI3IZ2fLQvsXxJVesZaucrt1XY5tQx2dgHbv89AZaIjzARNKskRwu46Tb3/cjWY7uo8KoZJcSeVERjsW7ap58kyuI=
X-Received: by 2002:a05:6402:185a:: with SMTP id v26mr10163891edy.163.1551001275932;
 Sun, 24 Feb 2019 01:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
 <20190223190309.6728-4-matheus.bernardino@usp.br> <87va1a3z8e.fsf@evledraar.gmail.com>
In-Reply-To: <87va1a3z8e.fsf@evledraar.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 24 Feb 2019 10:41:04 +0100
Message-ID: <CAP8UFD2LLL+V54k3XmHzmg5t1zanpAvY_=7GqXL43vLPTTmuww@mail.gmail.com>
Subject: Re: [GSoC][PATCH 3/3] clone: use dir-iterator to avoid explicit dir traversal
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 23, 2019 at 11:48 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sat, Feb 23 2019, Matheus Tavares wrote:
>
> > Replace usage of opendir/readdir/closedir API to traverse directories
> > recursively, at copy_or_link_directory function, by the dir-iterator
> > API. This simplifies the code and avoid recursive calls to
> > copy_or_link_directory.
>
> Sounds good in principle.
>
> > This process also brings some safe behaviour changes to
> > copy_or_link_directory:
>
> I ad-hoc tested some of these, and could spot behavior changes. We
> should have tests for these.

I agree that ideally we should have a few tests for these, but this is
a grey area (see below) and there are areas that are not grey for
which we don't have any test...

And then adding tests would make this series become larger than a
typical GSoC micro-project...

> >  - It will no longer follows symbolic links. This is not a problem,
> >    since the function is only used to copy .git/objects directory, and
> >    symbolic links are not expected there.
>
> I don't think we should make that assumption, and I don't know of
> anything else in git that does.

I think Git itself doesn't create symlinks in ".git/objects/" and we
don't recommend people manually tweaking what's inside ".git/". That's
why I think it's a grey area.

> I've certainly symlinked individual objects or packs into a repo for
> debugging / recovery, and it would be unexpected to clone that and miss
> something.

If people tweak what's inside ".git" by hand, they are expected to
know what they doing and be able to debug it.

> So in the general case we should be strict in what we generate, but
> permissive in what we accept. We don't want a "clone" of an existing
> repo to fail, or "fsck" to fail after clone...

Yeah, but realistically I don't think we are going to foolproof Git
from everything that someone could do by tweaking random things
manually in ".git/".

I am not saying that it should be ok to make things much worse than
they are now in case some things have been tweaked in ".git/", but if
things in general don't look worse in this grey area, and a patch
otherwise improves things, then I think the patch should be ok.

> When trying to test this I made e.g. objects/c4 a symlink to /tmp/c4,
> and a specific object in objects/4d/ a symlink to /tmp too.
>
> Without this patch the individual object is still a symlink, but the
> object under the directory gets resolved, and "un-symlinked", also with
> --dissociate, which seems like an existing bug.
>
> With your patch that symlink structure is copied as-is. That's more
> faithful under --local, but a regression for --dissociate (which didn't
> work fully to begin with...).

I think that I use --local (which is the default if the repository is
specified as a local path) much more often than --dissociate, so for
me the patch would be very positive, especially since --dissociate is
already buggy anyway in this case.

> I was paranoid that "no longer follows symbolic links" could also mean
> "will ignore those objects", but it seems to more faithfully copy things
> as-is for *that* case.

Nice!

> But then I try with --no-hardlinks and stock git dereferences my symlink
> structure, but with your patches fails completely:
>
>     Cloning into bare repository 'repo2'...
>     error: copy-fd: read returned: Is a directory
>     fatal: failed to copy file to 'repo2/objects/c4': Is a directory
>     fatal: the remote end hung up unexpectedly
>     fatal: cannot change to 'repo2': No such file or directory

Maybe this could be fixed. Anyway I don't use --no-hardlinks very
often, so I still think the patch is a positive even with this
failure.

> So there's at least one case in a few minutes of prodding this where we
> can't clone a working repo now, however obscure the setup.
>
> >  - Hidden directories won't be skipped anymore. In fact, it is odd that
> >    the function currently skip hidden directories but not hidden files.
> >    The reason for that could be unintentional: probably the intention
> >    was to skip '.' and '..' only, but it ended up accidentally skipping
> >    all directories starting with '.'. Again, it must not be a problem
> >    not to skip hidden dirs since hidden dirs/files are not expected at
> >    .git/objects.
>
> I reproduce this with --local. A ".foo" isn't copied before, now it
> is. Good, I guess. We'd have already copied a "foo".
>
> >  - Now, copy_or_link_directory will call die() in case of an error on
> >    openddir, readdir or lstat, inside dir_iterator_advance. That means
> >    it will abort in case of an error trying to fetch any iteration
> >    entry.

It would be nice if the above paragraph in the commit message would
say what was the previous behavior and why it's better to die() .

> Good, but really IMNSHO this series is tweaking some critical core code
> and desperately needs tests.

It's critical that this code works well in the usual case, yes. (And
there are already a lot of tests that test that.) But when people have
manually tweaked things in their ".git/objects/", it's not critical
what happens. Many systems have "undefined behaviors" at some point
and that's ok.

And no, I am not saying that we should consider it completely
"undefined behavior" as soon as something is manually tweaked in
".git/", and yes, tests would be nice, and your comments and manual
tests on this are very much appreciated. It's just that I don't think
we should require too much when a patch, especially from a first time
contributor, is already improving things, though it also changes a few
things in a grey area.

> Unfortunately, in this as in so many edge case we have no existing
> tests.
>
> This would be much easier to review and would give reviewers more
> confidence if the parts of this that changed behavior started with a
> patch or patches that just manually objects/ dirs with various

I think "created" is missing between "manually" and  "objects/" in the
above sentence.

> combinations of symlinks, hardlinks etc., and asserted that the various
> options did exactly what they're doing now, and made sure the
> source/target repos were the same after/both passed "fsck".
>
> Then followed by some version of this patch which changes the behavior,
> and would be forced to tweak those tests. To make it clear e.g. that
> some cases where we have a working "clone" are now a hard error.

Unfortunately this would be a lot of work and not appropriate for a
GSoC micro-project.

Thanks,
Christian.
