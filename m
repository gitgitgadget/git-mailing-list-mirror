Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9917CC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 04:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7621A60F23
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 04:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhIOE5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 00:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhIOE47 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 00:56:59 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CCEC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 21:55:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p29so3384018lfa.11
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 21:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhqpyELSSL08oWdK5fTm0m3tGqMKMYG5Jn4lDToXwQY=;
        b=lMEqWYrGCpOOMvvP2yYLAUatajCmAsO0AcllwtBWjsZUlKk2UZ89VuMd5T/nqHydOi
         GoUz3e7aFPDgzzS21tQZgOBSy4nbzyQiMDk66MMG95xdT59UDDCcjjPxs0a2L0+zOKR1
         FGCJd4g0kxMaZlvhg3+SZ9uzFV9fDAF5ZXTEOFxSgLqNS+uBT6LdlFvl/Zcnl8dnkkh4
         SvLBBUfj966/CFViu+gehss4bFhnpzC+UyGUZc24BmqeBbZXJaWfra1g/r4VNNc/ULxZ
         IpkTAlygWmDcYfg8YajglDDM2WnXXgU0GRp+iuegpuJGX7TgjCcpW1N2xnT3J7GeNku2
         AZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhqpyELSSL08oWdK5fTm0m3tGqMKMYG5Jn4lDToXwQY=;
        b=AodNX+2VXHrw1q6tU1ym0aP2hwWKs6Ny1fvklQIesUVYxyK8KeEc+QpAsZwdF0U0/O
         K51qq+Xff7/VLiR7BNJD9+IMhDAtztEvm7h2/5Ru04TrNFgmHB+wNBQnoeh0BFz51j8e
         nnEzANG0M22S81mOSsIJ3cH2gf6bxYONUj2AIxH8A5g2vcsX5fbT9KZLZDYsszG87eFS
         Z1rOoGhn6PHVf4OrHX28D/OKYkHMtzWez+OMIPmUd9JjaapVKOi7dheF8ybcUU8DQJRB
         AeSUs8os5mR3Pr7pHLRKvr1Y2ucnn29w5dJjxCC/0rqdlbnZdg5DkJc/qAx0RQH7Wo+4
         qkyw==
X-Gm-Message-State: AOAM531ahwMH2MnY9WMzwbS4HD6OYaSFdf7idEVoLt7Z8n3EWy6Z6kx5
        HoGThRKHvMdQguWNdsU2vNq04gV/KkX+iSKXNoc=
X-Google-Smtp-Source: ABdhPJx3UWlyfhaLJlBNIZAaGn0JU7H7zNszOfywDf36OGL5kRQBn+jQIxk9MLU/W221GnO4DlcddIZ+BYFmpLSswXc=
X-Received: by 2002:a19:700b:: with SMTP id h11mr15557200lfc.180.1631681739519;
 Tue, 14 Sep 2021 21:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
 <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com> <f8b5b709e9edc363b2de7d4afa443deec0120ca0.1631590725.git.gitgitgadget@gmail.com>
 <xmqqfsu70x58.fsf@gitster.g>
In-Reply-To: <xmqqfsu70x58.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 14 Sep 2021 21:55:30 -0700
Message-ID: <CANQDOdfnWV3EMhumjtin9z2RB36Ew4vrLPZjzMNmvrJ3=RN20Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] core.fsyncobjectfiles: batched disk flushes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 12:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/config.c b/config.c
> > index cb4a8058bff..9fe3602e1c4 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -1509,7 +1509,13 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
> >       }
> >
> >       if (!strcmp(var, "core.fsyncobjectfiles")) {
> > -             fsync_object_files = git_config_bool(var, value);
> > +             if (!value)
> > +                     return config_error_nonbool(var);
> > +             if (!strcasecmp(value, "batch"))
> > +                     fsync_object_files = FSYNC_OBJECT_FILES_BATCH;
> > +             else
> > +                     fsync_object_files = git_config_bool(var, value)
> > +                             ? FSYNC_OBJECT_FILES_ON : FSYNC_OBJECT_FILES_OFF;
> >               return 0;
>
> The original code used to allow the short-and-sweet valueless true
>
>         [core]
>                 fsyncobjectfiles
>
> but it no longer does by calling it a nonbool error.  This breaks
> existing users' repositories that have been happily working, doesn't
> it?
>
> Perhaps
>
>         if (value && !strcmp(value, "batch"))
>                 fsync_object_files = FSYNC_OBJECT_FILES_BATCH;
>         else if (git_config_bool(var, value))
>                 fsync_object_files = FSYNC_OBJECT_FILES_ON;
>         else
>                 fsync_object_files = FSYNC_OBJECT_FILES_OFF;

I'll take your suggestion, including the change to case-sensitive.

> > +#ifdef __APPLE__
> > +     return fcntl(fd, F_FULLFSYNC);
> > +#else
> > +     return fsync(fd);
> > +#endif
> > +}
>
> If we are introducing "enum fsync_action", we should have some way
> to make it clear that we are covering all the possible values of
> "action".
>
> Switching on action, i.e.
>
>         switch (action) {
>         case FSYNC_WRITEOUT_ONLY:
>                 ...
>                 break;
>         case FSYNC_HARDWARE_FLUSH:
>                 ...
>                 break;
>         default:
>                 BUG("unexpected git_fsync(%d) call", action);
>         }
>
> would be one way to do so.
>

Will do.

Thanks for reviewing my changes. I've updated the github PR.
I'll wait for a few more days to see if anyone has more feedback
before sending out another round of patches.
