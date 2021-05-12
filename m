Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39291C41602
	for <git@archiver.kernel.org>; Wed, 12 May 2021 16:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0451E61C43
	for <git@archiver.kernel.org>; Wed, 12 May 2021 16:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhELQIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 12:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbhELPvH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 11:51:07 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D799AC06175F
        for <git@vger.kernel.org>; Wed, 12 May 2021 08:24:49 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so20890029otp.11
        for <git@vger.kernel.org>; Wed, 12 May 2021 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZ41p6+TfUNGlHIw7SM76tgQFJ/Tojb1XwO1q/OBTLE=;
        b=J/jMZX/tDc5rb8ehXFvh04dlFJ0yJodgqXNyRpf24upFv5Fbkh0fuNHOkhO4nEQ1ow
         l8ZIXrW9YOPGE5gO2HzWHtA5f08l77gHViUbaPwuEsD2eas7FvyvGFimcpyoqjDokiEr
         7E64p+fn9iDOTLULfQ7ICwc5BZ76+5LT3pguMjCHki8Ebwn9TXXbfIVYCmmYJprR+DcV
         Ai7/HAIVFzlemgzJf9LxkJ/EXz40O6U2G7dfB03zJSA2aL2ziICrJqRv2YzKYDe+areR
         QwQfQuIBi/oh6iU6+7zFDRs+yDoerZFPPX4rTYBINLMhUrC8aP0roUKLc1OMvFsD8eO/
         W2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZ41p6+TfUNGlHIw7SM76tgQFJ/Tojb1XwO1q/OBTLE=;
        b=m5wSB0NLM4XSXSNpoq8gODKNtUS94jS0fnRlDIkCZz4VXFHD1/jjFDdokfdrzliICI
         Opwk1JVWGRsLY/bk9mDeqj2dxvexOR+tGULPm+ZcOBazEzPvFfT7plCYM12J4ZTz2Gr7
         MhgvP9VbmgdcGATWiEBYliydW5wNQlSdyQqxQmVkyOh0ez0JsOokB4JM6bczrQL+zCOm
         z7kQCYq/svR5WrziTyNJBzu7U5u364SWBYY+un0d6cTGPC8/nHZle4BOJQK4iVSsTc95
         wcudS/ySmLWDKaY2Px5maD4qcdPREMCVRLZwER/1XGXstDHEp7/+Wy9e0E7kAhdViDZy
         W0gQ==
X-Gm-Message-State: AOAM532sONCHXo1CU6BSbjxkPffa18wO/MqQwxs5mXhh87zGc1UHKr/q
        oTbG74xFe3E5LGF0a/kdJM4ujknsjXc5EkVrDV8=
X-Google-Smtp-Source: ABdhPJxjOD9B5+1xfxl/th3O3jwgGX9jxsjGiAPsemORu10L00cU+3MbPSkJ8+WISupvf9wkkXPup262KQZ/RV8yxvk=
X-Received: by 2002:a9d:7096:: with SMTP id l22mr23958106otj.345.1620833089282;
 Wed, 12 May 2021 08:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
 <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com> <9204e36b7e9035c4cdda018d7ced8e8ca7acc8bc.1620758049.git.gitgitgadget@gmail.com>
 <df3695ad-5ba7-df22-2a2a-ca799c5d16d8@jeffhostetler.com> <CABPp-BGeOUOvYRD+gX4jVR0kN8O5_icKtT18F9BdeR424DjUmg@mail.gmail.com>
 <a01ffeaf-31de-fdf5-3992-bea40feb1213@jeffhostetler.com> <CABPp-BF9ptJio+NSi-i-sQJqjsOiKfFxzVHQ=RTPQkV9hjPrMQ@mail.gmail.com>
 <d9690dfc-2883-6f0a-e66b-89066b660c8d@jeffhostetler.com>
In-Reply-To: <d9690dfc-2883-6f0a-e66b-89066b660c8d@jeffhostetler.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 12 May 2021 08:24:37 -0700
Message-ID: <CABPp-BHSoEqy2R=X3dRzPykMQH7Pie_bMqo79Y+CR1bUoYXLfA@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] dir: convert trace calls to trace2 equivalents
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 5:26 AM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
> On 5/11/21 8:44 PM, Elijah Newren wrote:
> > On Tue, May 11, 2021 at 4:12 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
> >>
> >> On 5/11/21 4:12 PM, Elijah Newren wrote:
> >>> On Tue, May 11, 2021 at 12:06 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
> >>>>
> >>>> On 5/11/21 2:34 PM, Elijah Newren via GitGitGadget wrote:
> >>>>> From: Elijah Newren <newren@gmail.com>
> >>>>>
> >>>>> Signed-off-by: Elijah Newren <newren@gmail.com>
> >>>>> ---
> >>>>>     dir.c                             |  43 +++++--
> >>>>>     t/t7063-status-untracked-cache.sh | 205 ++++++++++++++++++------------
> >>>>>     t/t7519-status-fsmonitor.sh       |   8 +-
> >>>>>     3 files changed, 155 insertions(+), 101 deletions(-)
> >>>>>
> >>>>> diff --git a/dir.c b/dir.c
> >>>>> index 3474e67e8f3c..122fcbffdf89 100644
> >>>>> --- a/dir.c
> >>>>> +++ b/dir.c
> >>>>> @@ -2760,15 +2760,34 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
> >>>>>         return root;
> >>>>>     }
> >>>>>
> >>>>> +static void trace2_read_directory_statistics(struct dir_struct *dir,
> >>>>> +                                          struct repository *repo,
> >>>>> +                                          const char *path)
> >>>>> +{
> >>>>> +     if (!dir->untracked)
> >>>>> +             return;
> >>>>> +     trace2_data_string("read_directory", repo, "path", path);
> >>>>
> >>>> I'm probably just nit-picking here, but should this look more like:
> >>>
> >>> nit-picking and questions are totally fine.  :-)  Thanks for reviewing.
> >>>
> >>>>
> >>>>           if (path && *path)
> >>>>                   trace2_data_string(...)
> >>>
> >>> path is always non-NULL (it'd be an error to call read_directory()
> >>> with a NULL path).  So the first part of the check isn't meaningful
> >>> for this particular code.  The second half is interesting.  Do we want
> >>> to omit the path when it happens to be the toplevel directory (the
> >>> case where !*path)?  The original trace_performance_leave() calls
> >>> certainly didn't, and I was just trying to provide the same info they
> >>> do, as you suggested.  I guess people could determine the path by
> >>> knowing that the code doesn't print it when it's empty, but do we want
> >>> trace2 users to need to read the code to figure out statistics and
> >>> info?
> >>
> >> that's fine.  it might be easier to just always print it (even if
> >> blank) so that post-processors know that rather than have to assume
> >> it.
> >>
> >>>
> >>>>           if (!dir->untracked)
> >>>>                   return;
> >>>>
> >>>> Then when you add the visitied fields in the next commit,
> >>>> you'll have the path with them (when present).
> >>>
> >>> There is always a path with them, it's just that the empty string
> >>> denotes the toplevel directory.
> >>>
> >>>> (and it would let you optionally avoid the tmp strbuf in
> >>>> the caller.)
> >>>
> >>> The path in read_directory() is not necessarily NUL-delimited, so
> >>> attempting to use it as-is, or even with your checks, would cause us
> >>> to possibly print garbage and do out-of-bounds reads.  We need the tmp
> >>> strbuf.
> >>>
> >>
> >> I just meant, "if (!len) pass NULL, else build and pass tmp.buf".
> >
> > Ah, gotcha, that's why you were checking non-NULL.
> >
> > However, what about the other case when len is nonzero.  Let's say
> > that len = 8 and path points at
> > "filename*%&#)aWholeBunchOfTotalGarbageAfterTheRealFilenameThatShouldNotBeReadOrIncluded\0\0\0\0\0\0\0\0\0\0"
> > ?
> >
> > How do you make it print "filename" and only "filename" without the
> > other stuff without using the tmp strbuf?
> >
>
> I was still saying to use the "strbuf tmp" in the non-zero len case,
> but just pass NULL (or "") for the len==0 case.

Ah, now I see what you were saying.  Sorry for not getting it earlier.

> Alternatively, since `trace2_read_directory_statistics() a static
> local function, we could move all of the path manipulation into it.
>
> static void emit_stats(
>         struct dir_struct *dir,
>         struct repository *repo,
>         const char* path_buf,
>         size_t path_len)
> {
>         if (!path_len)
>                 trace2_data_string("read_directory", repo,
>                         "path", "");
>         else {
>                 struct strbuf tmp = STRBUF_INIT;
>                 strbuf_add(&tmp, path_buf, path_len);
>                 trace2_data_string("read_directory", repo,
>                         "path", tmp.buf);
>                 strbuf_release(&tmp);
>         }
>         ... the rest of intmax stats ...
> }

Makes sense.

> BTW, could we also rename your stats function?  I've been trying
> to keep the "trace2_" prefix reserved for the Trace2 API.

Sure, will do.
