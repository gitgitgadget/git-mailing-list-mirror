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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C7BC433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 19:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6104221F4
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 19:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgLCT47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 14:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgLCT47 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 14:56:59 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19844C061A4E
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 11:56:19 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 11so2951052oty.9
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 11:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3bvFsmzNOT2p9WXil76WdI8nJWVImHRwKM7wSt1Ch0=;
        b=gmeKCrNfFpjLudDZQcR/gUnScOtfFNzmBEOgJFYYZX9lOJerbGxk+V+rJVUtHzVKVM
         exVDGnD3L3m+o1eq4JBQe1YLLGCP3LaRh95RObsaA6+FoEZy40q7qFUop7sULQDYBJaX
         ikX/M7WYZuNZnLO+rS8R0uECVDvnucj1ufV3+zV+Jzu5TnheipCBSIl42NfTuag/gzQ9
         q7kgOO7qJNvNiEh9/wUe7M2IeNFY0dncgoRVlDpfFf6Bg/A/CgZbiv+IiEELFEPyDljr
         ZKoiZaWa7uAh0H39sMvzpKF/WoLRoHvPWeEteT2Cyn6PJzthGhAPNnpj68m9AxMVFgmp
         LtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3bvFsmzNOT2p9WXil76WdI8nJWVImHRwKM7wSt1Ch0=;
        b=FWOMOhPlOJzJDU91eTFyYv/R8Tdwq0BJ0QmQPKr8Y4Hlf+WERwTef5xSjgzBIwr0ic
         P5doQOTVWjCf/l1F49ug/W7RwxD1dTSU3MObls2EGSqy+Er/Xmc9Hs0HtOqi1BI+7YDm
         DWMPPMqRok4bgRKabPZfeyu7fSpGpeCmrKRdGA/zb2hhsU2pmFMFzfH3kWCKx99lCEcY
         CcfejHjbU8iKlVlyv8npilITK2JSWV2p/mAqTq6bb+SBlJAPSWD+/734iQy9i1YehKMu
         3NYMjlkjw1Vlr/Sp2V/YGmGcR+WdrTZStKlOSBk9DbVYlghONrjGdLjj2WXSthMOh95c
         /kug==
X-Gm-Message-State: AOAM531ylXSayJF8JMWzTXVhpvKc9dfok7yQM4Zttpk2aPCnqqgDu63S
        sI2YmXE0AxnKZY0s5KVcXA3+vXin4XaiZwVchXc=
X-Google-Smtp-Source: ABdhPJyqGOEsctZqzaYFJt8r9pV0lpCUL4bE2q8NFm7XNve8uJtKeL+WVA28x7inkR/t9azelliaNPeBamWPqexJFNk=
X-Received: by 2002:a05:6830:1002:: with SMTP id a2mr717628otp.316.1607025377976;
 Thu, 03 Dec 2020 11:56:17 -0800 (PST)
MIME-Version: 1.0
References: <pull.803.git.1607011187.gitgitgadget@gmail.com>
 <9f1ac20e31886ad7cd56ff582c58cce4ee743fa1.1607011187.git.gitgitgadget@gmail.com>
 <8e861bc8-4da1-01aa-7de6-c6c128590170@gmail.com>
In-Reply-To: <8e861bc8-4da1-01aa-7de6-c6c128590170@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Dec 2020 11:56:07 -0800
Message-ID: <CABPp-BFytQ5d2s8VpMbNXDGzG3=Jd2Tm2=G_mh+OBYqzhDeHBg@mail.gmail.com>
Subject: Re: [PATCH 6/7] merge-ort: add die-not-implemented stub
 handle_content_merge() function
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 3, 2020 at 10:40 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/3/2020 10:59 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > This simplistic and weird-looking patch is here to facilitate future
> > patch submissions.  Adding this stub allows rename detection code to
> > reference it in one patch series, while a separate patch series can
> > define the implementation, and then both series can merge cleanly and
> > work nicely together at that point.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index e653ba35ea..e7220cbbb4 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -523,6 +523,18 @@ static int collect_merge_info(struct merge_options *opt,
> >
> >  /*** Function Grouping: functions related to threeway content merges ***/
> >
> > +static int handle_content_merge(struct merge_options *opt,
> > +                             const char *path,
> > +                             const struct version_info *o,
> > +                             const struct version_info *a,
> > +                             const struct version_info *b,
> > +                             const char *pathnames[3],
> > +                             const int extra_marker_size,
> > +                             struct version_info *result)
> > +{
> > +     die("Not yet implemented");
> > +}
> > +
> >  /*** Function Grouping: functions related to detect_and_process_renames(), ***
> >   *** which are split into directory and regular rename detection sections. ***/
> >
> > @@ -919,6 +931,8 @@ static void process_entry(struct merge_options *opt,
> >               ci->merged.clean = 0;
> >               ci->merged.result.mode = ci->stages[1].mode;
> >               oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
> > +             /* When we fix above, we'll call handle_content_merge() */
> > +             (void)handle_content_merge;
>
> I'm not exactly sure what the value is of this line. Is it just to
> make sure we have a reference to the 'static' method without actually
> calling it anywhere?

Yes; without the reference the compiler fails with an unused function
error message.  I know it's not used yet, but I really need it there,
so I have to fake the compiler out with a lame expression (take the
address of the function, cast to void, and discard the result since I
don't assign it anywhere or anything).

> "weird-looking patch" indeed! I'm more confused than anything.

In general, rename detection occurs before process_entry() and thus
process_entry() can handle the content merging.  However, some unusual
rename conflicts require multiple content merges (and possibly result
in nested conflict markers) and so the rename code needs to be able to
call handle_content_merge() for the first of those.

I really wanted to split apart the series for rename detection (12
patches), and the one for more conflict handling (10 patches),
especially since the latter series includes 6 patches for building up
handle_content_merge() (3 for regular file content merging and another
3 for submodule "merging").  The two series are nearly orthogonal, but
I had to somehow allow the rename side to call handle_content_merge()
without having both series try to introduce the same function.  Hence
this patch.
