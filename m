Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC46C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 04:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345924AbhLKEtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 23:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbhLKEtb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 23:49:31 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3894FC061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 20:45:55 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id l25so36247250eda.11
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 20:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bfy0Z56EO6rJBMOBQRKlWkK5Fwv8qboeTPOl+JRqve4=;
        b=EcNneJJsZKmeCqVK90TADLXUOBQ+j+YVhHMfWgiNZudtISLhz//gw/+WKwSjjjz+p2
         DbZuL58d/pTnYMJ93uQOQ+yaGV32IJte+gOn5+VNpAIPA/3+LEjNLZyVrA7Fda6Ao0G9
         JqjGwJ5hqVYVHHQDkz4aoH3SI43H75cD1LrFBgBXNSz3MxY7uebidDe3uwznCviqdMCW
         bggsAjqt43LgngNi+dBInt2BsnaULdFZA0MofYdiX9IEf8SHjKn9eNoscABi+CgCN/di
         sxVnXnVKLxKwFhy3w5aIrwV/NVTmglbpE/wWez0MAdG8YgQ+te9ktYAmis7EqbEDbuUX
         WyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bfy0Z56EO6rJBMOBQRKlWkK5Fwv8qboeTPOl+JRqve4=;
        b=1kZ3WIiYWXjnOETM+mUu6TL8L7uq7mhMuUTm+9MWTYehGpw644feX8zpq7WKOUGYzN
         PRTskGjgGQhmeKulG/Sl54PV4ocFDl5VlXa3I3TxpR5EBEfTGxkvNr+ED+/Ee+PtK7yF
         qg/OxerA0vEjOQ5/KmTTE8TTjAABOB4wXTiDRqmpECRXz5M4tFuxZYAm8uK74zwEw0I0
         whheGjKZW6GjWZ8O3Au9aQZTsJpWBcmCRFFGPIy5nsLD3NUR7fzv0akTv+ShDNLF++pI
         tMdYfimD7vTw4lHfBnjrQxJcCSxS6VfB0CtkoPjjNUQexRnYP2mM1GCul2wRN4oPrqwk
         xJ+A==
X-Gm-Message-State: AOAM532QUp08C3d0jd0v5cc4gAJ0uYtDkry1r/efvG8DVolKTJv/78xh
        qKatbcZp7t1iLXfwzuzkuM+HwwecQuh+m8LugZCDUIZ0M2c=
X-Google-Smtp-Source: ABdhPJz7akCn13/02ynZi9RSIiuX4PMfTZRRyu78Aaaz2eFBaTy2SfuHyDo3IeKETgMYbF+vUmoljw/dRYTjG9wMr9c=
X-Received: by 2002:a05:6402:d73:: with SMTP id ec51mr44402159edb.175.1639197953684;
 Fri, 10 Dec 2021 20:45:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
 <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com> <211210.86v8zwbev9.gmgdl@evledraar.gmail.com>
 <CABPp-BHLRUQmjEoO_eEvZWTrVFK_xdMoQH5Q9DAj7y=JrKDzig@mail.gmail.com> <211211.86ee6jc1t2.gmgdl@evledraar.gmail.com>
In-Reply-To: <211211.86ee6jc1t2.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Dec 2021 20:45:42 -0800
Message-ID: <CABPp-BFEayJvGytbsi76Nqe=tWj6zX5Aa+ErAxG=akC-yp1JFw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Sparse index: fetch, pull, ls-files
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 6:28 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Dec 10 2021, Elijah Newren wrote:
>
> > On Fri, Dec 10, 2021 at 8:31 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> > [...]
> >> So it's very nice to have the new diff test in 2/5, but would be much
> >> nicer/assuring to have that split into a trivial function followed by
> >> seeing how the diff looked in combination with each of the other optio=
n
> >> that "ls-files" accepts.
> >
> > There's no point testing in combination with flags that only affect
> > untracked files.  And I'm very dubious of adding testing for a case
> > where we would need to add an explicit disclaimer that "We have no
> > idea what the output should be but we are testing it anyway".  So the
> > options you suggest at least are things I'd rather not see us trying
> > to add to the testing here.
>
> This series is adding a new flag to ls-files, it doesn't error out when
> combined with other existing flags, and observably changes their output.

Ah, I think you had a misunderstanding here.  If what you say here
were true, then indeed we would need some testing and it'd suggest
some kind of bug.  But the combination here does not observably change
the output.  You were missing an important testcase for comparison.
Let me repeat your testing and sprinkle in some commentary:

> >>     $ ls -l sparse-index/x
> >>     ls: cannot access 'sparse-index/x': No such file or directory

Right, this is a sparse directory; good to double check.

> >>     $ git -C sparse-index ls-files --stage 'x/*'
> >>     100644 78981922613b2afb6025042ff6bd878ac1994e85 0       x/a
> >>     $ git -C sparse-index ls-files --stage --no-empty-directory 'x/*'
> >>     100644 78981922613b2afb6025042ff6bd878ac1994e85 0       x/a

Right, --no-empty-directory by itself is a useless option that won't
affect the output of ls-files; it only takes affect with --directory,
which in turn only takes affect with other options.  Since that
options is useless, the output is the same for both of these.

> >>     $ git -C sparse-index ls-files --stage --no-empty-directory --spar=
se 'x/*'
> >>     040000 aaff74984cccd156a469afa7d9ab10e4777beb24 0       x/

Here you added --sparse, but you neglected what it would show without
--no-empty-directory, which is a critical comparison point.  So let me
fill it in:

     $ git -C sparse-index ls-files --stage --sparse 'x/*'
     040000 aaff74984cccd156a469afa7d9ab10e4777beb24 0       x/

Now, this case I added in comparison to the one three above it shows
that, yes, --sparse does indeed change the output relative to --stage.
And it does so by design.  Now if you compare my added case to the
last one you showed, you can verify that adding --no-empty-directory
to that mix does not change the output further; --no-empty-directory
is a useless/ignored option unless you also include other flags that
were not involved here.

> I think erroring out would be fine, or doing whatever it's doing now,
> but either way the gap in test coverage should be closed, shouldn't it?
>
> I'd think the easiest and probably most prudent fix would just be to say
> that we don't think some of these make sense with --sparse and have them
> error out if they're combined, no?

ls-files offers several options that allow you to either slice and
dice or tweak the output, and function on two kinds of files: tracked,
and not tracked.  Several examples of such flags:
   * tracked: --cached, --stage, --unmerged, --modified, --sparse (and
I think --error-unmatch)
   * not tracked: --others, --ignored, --exclude, --exclude-from,
--exclude-standard, --directory, --no-empty-directory

Now, in particular, specifying any of --exclude, --exclude-from,
--exclude-standard, --directory, or --no-empty-directory is a complete
waste of breath and will do nothing unless you also specify --others
or --ignored.  None of these options interact in any way with any of
the flags from the --tracked category.

I don't think we want an n! permutation of all combinations tested.  I
don't even think an n^2 pair-wise combination makes sense when we know
that some flags have no effect on their own.  What would make sense is
perhaps adding a warning to ls-files when specified flags will have no
utility due to depending on other flags that have not been specified.
But that's in no way specific to --sparse and does not make sense to
me to make part of this topic.
