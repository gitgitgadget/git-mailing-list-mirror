Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377F5C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 23:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242567AbhLGXcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 18:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbhLGXcy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 18:32:54 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C40C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 15:29:23 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id j18so947635ljc.12
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 15:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJ9w0VFmBuJXW7NMcDA0Chaahk+15nA22LQq7LRdgwg=;
        b=azS6BkNrqYG1y9lV3T7bOzJWq4XI+VjIYwbF4jPgPIEYXdNRlwMTqKFA7AYi4WVx5w
         bzTuDaEPpuQqvb/P5NGuDrhPEN3TbyiakiHReSYiod0n61l15exD7ZzdfAlm2MuC7Af7
         cTgoW4euowGORzjceirFuh03zCWsZghqRgkm63eX+YO2wyY1qdqhv7aWOmCkQqo+RJrS
         SrWELmQ+3+uD2h577niEYaN+Y5nhP3llJCkB+vHpBwFqFEl9AJFDWn59dCOz//0ysmqO
         W0+zM6x6go/5kyoEanEm1ck6uaSFNUKbf3SAAgPHLJBPXiXKLrgbnZZh7af6SwdKjdUn
         ikXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJ9w0VFmBuJXW7NMcDA0Chaahk+15nA22LQq7LRdgwg=;
        b=RfW5R/mo6zIhetsJZphoiSB2+xUnNW6TQRR1qDPvFxfJRVb2V5vp57zVTZVHY7ISZt
         OwXtGCZsZ1LQtazWnaMnkKESZ1ORJFDsG1+AG1GtUj659PO01KEYXsQWG4neWJpoiBuh
         G7OUPq/9v9NaCJYgOrmidTC2tPwa6f5mT+eKeL7KzR0bNSTHnOX105EIPHwTW9g+a2Gv
         Lrvci/qAX5AfidITqkxAn6oBMqeUcUk1I7dPTZfvEDtgGS8XCDj/o65a8kSaSAysuP17
         sERxrLixF0pnBET0VTXq1dfzjo0xaEM8eIzuYT2DHI49FO+v+831mc6/IDQNRsoYB7zU
         jfyQ==
X-Gm-Message-State: AOAM531tRcJU9WwIi83t5lEcNLh9UcI3XsdP3jOIkTPocwq3UJ1fXgTl
        M2bx3F39hHY5YFLUuQ6ZZzO08CAt0QGI1QQAb6E=
X-Google-Smtp-Source: ABdhPJzBz2e/aJpIIibjUjNaqvvrp9B7lYn20GxP55acxgOrAYPkVRveGOfEjf0XU/t70zVwW4d4xf0YozQAy5tt+ho=
X-Received: by 2002:a05:651c:17a6:: with SMTP id bn38mr46077017ljb.413.1638919761423;
 Tue, 07 Dec 2021 15:29:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com> <e79522cbdd4feb45b062b75225475f34039d1866.1638845211.git.gitgitgadget@gmail.com>
 <Ya9JJlItvDJCLHqj@ncase>
In-Reply-To: <Ya9JJlItvDJCLHqj@ncase>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 7 Dec 2021 15:29:10 -0800
Message-ID: <CANQDOdd3uWh7SN=GDdG+=rtJA+ja+YdRLsodwSBYMH4JMKj9Zg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] core.fsyncmethod: add writeout-only mode
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 7, 2021 at 3:45 AM Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Dec 07, 2021 at 02:46:49AM +0000, Neeraj Singh via GitGitGadget wrote:
> > From: Neeraj Singh <neerajsi@microsoft.com>
> [snip]
> > --- a/compat/mingw.h
> > +++ b/compat/mingw.h
> > @@ -329,6 +329,9 @@ int mingw_getpagesize(void);
> >  #define getpagesize mingw_getpagesize
> >  #endif
> >
> > +int win32_fsync_no_flush(int fd);
> > +#define fsync_no_flush win32_fsync_no_flush
> > +
> >  struct rlimit {
> >       unsigned int rlim_cur;
> >  };
> > diff --git a/compat/win32/flush.c b/compat/win32/flush.c
> > new file mode 100644
> > index 00000000000..75324c24ee7
> > --- /dev/null
> > +++ b/compat/win32/flush.c
> > @@ -0,0 +1,28 @@
> > +#include "../../git-compat-util.h"
> > +#include <winternl.h>
> > +#include "lazyload.h"
> > +
> > +int win32_fsync_no_flush(int fd)
> > +{
> > +       IO_STATUS_BLOCK io_status;
> > +
> > +#define FLUSH_FLAGS_FILE_DATA_ONLY 1
> > +
> > +       DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NtFlushBuffersFileEx,
> > +                      HANDLE FileHandle, ULONG Flags, PVOID Parameters, ULONG ParameterSize,
> > +                      PIO_STATUS_BLOCK IoStatusBlock);
> > +
> > +       if (!INIT_PROC_ADDR(NtFlushBuffersFileEx)) {
> > +             errno = ENOSYS;
> > +             return -1;
> > +       }
>
> I'm wondering whether it would make sense to fall back to fsync(3P) in
> case we cannot use writeout-only, but I see that were doing essentially
> that in `fsync_or_die()`. There is no indicator to the user though that
> writeout-only doesn't work -- do we want to print a one-time warning?
>

I wanted to leave the fallback to the caller so that the algorithm can
be adjusted in some way based on whether writeout-only succeeded.  For
batched fsync object files, we refrain from doing the last fsync if we
were doing real fsyncs all along.

I didn't want to issue a warning, since this writeout-only codepath
might be invoked from multiple subprocesses, which would each
potentially issue their one warning.  The consequence of failing
writeout only is worse performance, but should not be compromised
safety, so I'm not sure the user gets enough from the warning to
justify something that's potentially spammy.  In practice, when batch
mode is adopted on Windows (by default), some older pre-Win8 systems
will experience fsyncs and equivalent performance to what they're
seeing today. I don't want these users to have a warning too.

> > +       memset(&io_status, 0, sizeof(io_status));
> > +       if (NtFlushBuffersFileEx((HANDLE)_get_osfhandle(fd), FLUSH_FLAGS_FILE_DATA_ONLY,
> > +                             NULL, 0, &io_status)) {
> > +             errno = EINVAL;
> > +             return -1;
> > +       }
> > +
> > +       return 0;
> > +}
>
> [snip]
> > diff --git a/wrapper.c b/wrapper.c
> > index 36e12119d76..1c5f2c87791 100644
> > --- a/wrapper.c
> > +++ b/wrapper.c
> > @@ -546,6 +546,62 @@ int xmkstemp_mode(char *filename_template, int mode)
> >       return fd;
> >  }
> >
> > +int git_fsync(int fd, enum fsync_action action)
> > +{
> > +     switch (action) {
> > +     case FSYNC_WRITEOUT_ONLY:
> > +
> > +#ifdef __APPLE__
> > +             /*
> > +              * on macOS, fsync just causes filesystem cache writeback but does not
> > +              * flush hardware caches.
> > +              */
> > +             return fsync(fd);
>
> Below we're looping around `EINTR` -- are Apple systems never returning
> it?
>

The EINTR check was added due to a test failure on HP NonStop.  I
don't believe any other platform has actually complained about that.

Thanks again for the code review!
-Neeraj
