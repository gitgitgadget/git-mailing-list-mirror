Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC462C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 22:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E96610CF
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 22:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhHYWJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 18:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhHYWJY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 18:09:24 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E96C0613C1
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 15:08:37 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id r9so2080720lfn.3
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 15:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5rhA1rwChuabhvblQpM+VeUVrEot8hJKovvkY+fa5w=;
        b=POQaE/fES3FAj78wNOA/i1pTNEFaE4PZhoSQzoVvP2C+P4AG5YnTASkb8c9/oR3kQ5
         U4wCy/DXHap0kA9KIW8WZtwL3cCMfC8qqorHIr2EUubKLEVlzM3yPb0UC8IV5IEqgV9A
         cgtCm+Sa7LPg6G2Lp4QdYs7wLUMqnT70Gx/aYutAfggqUlohxvDMnbzeBMzDaUYlThAD
         FY2dU3tLzW3ECw0aG383Nr+sYX0xdPmmmsEd8cAgRGD/f28FBFBelNJLdeyA1YgFC2I4
         e7u4fZUySA5N22VEnyzR+8BGed07ksEL4lkhulPdYdZIMLcLF/kTnVhxR+kT5RR41fIa
         c8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5rhA1rwChuabhvblQpM+VeUVrEot8hJKovvkY+fa5w=;
        b=g4ft/1yCk4y48jSpnT91ZtVd/0lbmyJJS2wfrtBjs2cwPqLmezv5hy7or5WtMObSeY
         gNbtGvvgSsdlz/IMiHCh+TTJIYW7wPxUPpRwHu1i2rKNSP3dxlBohJ0J1xX9CiUR83Cn
         xyXOOa2W61mU5FUYgg0Ez42dTFrGR9bZAXc+RspU1MDekhpqb2/92HapHIuI6z2bRW0d
         xZwWMCGSnulXKOuJbkHdxsrvRKsowzMT/Ksj2jZ4sobxNN+5iueH2BQqGyAapFb0Gzm9
         2ElXXSUYQ7blSRXb69WXXaeqgz4nvs5jsu39Kszb+SW8HdEjOgatvhX3vcqWSSgKBbrl
         9c8A==
X-Gm-Message-State: AOAM5337LShmpK5r5L6+Bhn690JBgvX0OOu2lzAKLAI9HaTIfa+r7qUq
        1HwT9mGSWjTzkwdW3SAPW3t4PAv99kBfsGX4XXeAE+kuXsKpfRys
X-Google-Smtp-Source: ABdhPJwjMVmiwHZMjkBEqUx1+62JcGGboLzROrlysh4bjP2o6BQxjemfwb0N/qnjTQAHyOaxYTFfknTel+DHeFRO0eA=
X-Received: by 2002:a05:6512:6d0:: with SMTP id u16mr248394lff.30.1629929316101;
 Wed, 25 Aug 2021 15:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
 <2c1ddef6057157d85da74a7274e03eacf0374e45.1629856293.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2108251530210.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2108251530210.55@tvgsbejvaqbjf.bet>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 25 Aug 2021 15:08:25 -0700
Message-ID: <CANQDOdfXBNABCgVsiqc2TJpctEgsJ2rJKHC5=u=q2P+mJWDYxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] object-file: use futimes rather than utime
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 6:51 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> If I were you, I would spell out "file descriptor" here.
Will do.

> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index 9e0cd1e097f..948f4c3428b 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -949,19 +949,40 @@ int mingw_fstat(int fd, struct stat *buf)
> >       }
> >  }
> >
> > -static inline void time_t_to_filetime(time_t t, FILETIME *ft)
> > +static inline void timeval_to_filetime(const struct timeval *t, FILETIME *ft)
> >  {
> > -     long long winTime = t * 10000000LL + 116444736000000000LL;
> > +     long long winTime = t->tv_sec * 10000000LL + t->tv_usec * 10 + 116444736000000000LL;
>
> Technically, this is a change in behavior, right? We did not use to use
> nanosecond precision. But I don't think that we actually make use of this
> in this patch.
>
> >       ft->dwLowDateTime = winTime;
> >       ft->dwHighDateTime = winTime >> 32;
> >  }
> >
> > -int mingw_utime (const char *file_name, const struct utimbuf *times)
> > +int mingw_futimes(int fd, const struct timeval times[2])
>
> At first, I wondered whether it would make sense to pass the access time
> and the modified time separately, as pointers. I don't think that we pass
> around arrays as function parameters in Git anywhere else.
>
> But then I realized that `futimes()` is available in this precise form on
> Linux and on the BSDs. Therefore, it is not up to us to decide the
> function's signature.
>
> However, now that I looked at the manual page, I noticed that this
> function is not part of any POSIX standard.
>
> Which makes me think that we will have to do a bit more than just define
> it on Windows: we will have to introduce a `Makefile` knob (just like you
> did with `HAVE_SYNC_FILE_RANGE` in patch 2/2) and set that specifically
> for Linux and the BSDs, and use `futimes()` only if it is available
> (otherwise fall back to `utime()`).
>
> Then, as a separate patch, we should introduce this Windows-specific shim
> and declare that it is available via `config.mak.uname`.

Thanks for taking another look at the man pages. I looked again too and saw
that futimens is part of POSIX.1-2008:
https://pubs.opengroup.org/onlinepubs/9699919799/functions/futimens.html.
If I switch to futimens and implement the Windows shim at the same
time, is that sufficient to
address your feedback? I'd rather not ifdef this one since the
codeflow is quite different
depending on the presence of the API.

> > +}
> > +
> > +int mingw_utime (const char *file_name, const struct utimbuf *times)
>
> Please lose the space between the function name and the opening
> parenthesis. I know, the preimage of this diff has it, but that was an
> oversight and definitely disagrees with our current coding style.
Will do.

>
> > +{
> >       int fh, rc;
> >       DWORD attrs;
> >       wchar_t wfilename[MAX_PATH];
> > +     struct timeval tvs[2];
> > +
> >       if (xutftowcs_path(wfilename, file_name) < 0)
> >               return -1;
> >
> > @@ -979,17 +1000,12 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
> >       }
> >
> >       if (times) {
> > -             time_t_to_filetime(times->modtime, &mft);
> > -             time_t_to_filetime(times->actime, &aft);
> > -     } else {
> > -             GetSystemTimeAsFileTime(&mft);
> > -             aft = mft;
> > +             memset(tvs, 0, sizeof(tvs));
> > +             tvs[0].tv_sec = times->actime;
> > +             tvs[1].tv_sec = times->modtime;
>
> It is too bad that we have to copy around those values just to convert
> them, but I cannot think of any better way, either. And it's not like
> we're in a hot loop: this code will be dominated by I/O anyways.

Yeah, the cost of this is approximately 3-4 cycles (load-to-use
latency), so no one will notice relative to the system call overhead.

> > diff --git a/object-file.c b/object-file.c
> > index a8be8994814..607e9e2f80b 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1860,12 +1860,13 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
> >  }
> >
> >  /* Finalize a file on disk, and close it. */
> > -static void close_loose_object(int fd)
> > +static int close_loose_object(int fd, const char *tmpfile, const char *filename)
> >  {
> >       if (fsync_object_files)
> >               fsync_or_die(fd, "loose object file");
> >       if (close(fd) != 0)
> >               die_errno(_("error when closing loose object file"));
> > +     return finalize_object_file(tmpfile, filename);
>
> While this is a clear change of behavior, this function has only one
> caller, and that caller is adjusted accordingly.
>
> Could you add this clarification of context to the commit message? I know
> it will help me in the future, when I have to get up to speed again by
> reading the commit history.

How does the following revised wording sound?
```
    object-file: use futimens rather than utime

    Make close_loose_object do all of the steps for syncing and correctly
    naming a new loose object so that it can be reimplemented in the
    upcoming bulk-fsync mode.

    Use futimens, which is available in POSIX.1-2008 to update the file
    timestamps. This should be slightly faster than utime, since we have
    a file descriptor already available. This change allows us to update
    the time before closing, renaming, and potentially fsyincing the file
    being refreshed. This code is currently only invoked by git-pack-objects
    via force_object_loose.

    Implement a futimens shim for the Windows port of Git.

    Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
```

Thanks for the detailed and quick feedback!
-Neeraj
