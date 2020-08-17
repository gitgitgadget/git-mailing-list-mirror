Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23BDC433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8747220760
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naeMI4w3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389931AbgHQRad (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387949AbgHQQ7F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 12:59:05 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A02C061342
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 09:59:05 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u63so15401433oie.5
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fMZEcFIH6s6yGIOetjsbqq5hJsY+picGRBfbPYJWUQo=;
        b=naeMI4w3Vno0x4RooAjj1DvC+cyYc3g66C7YRN1OreTOjXo86JtaA6eMgcAkqdfcYF
         9eWO0PphArJrpgIPw5Xj/Hl/SEODukQafv2IUFendF1cf0MagiSZlAg4FLW56ffTuzr0
         OaDF6iHsiCsEp3F0DFyYtGNnOhBfJQ21FSHwifAJ9o0+MM/ofi1LCItnCjs9W/d7140G
         FkJHa1pSnUYl2XsX2PXApIK6kghs4vXKsAg0W+TaNmPj1YorKszFVJCpxSPXNiJJD8Hu
         9rnfyuBIPBtGYhpNwo8vSIf3cPyVJiV7LW5iMRw7LDWW35LKtY+upcnsC0biJtnbU2aY
         nmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMZEcFIH6s6yGIOetjsbqq5hJsY+picGRBfbPYJWUQo=;
        b=s4QcmjQ1t04h5Kve98jUbYdVbXGv6KAJK/em3suI1BHjSpJXe45smzIOeBSaVgMOgn
         Er77XvmCeGmYP5Rb11iENc4piq7SrMpv/J8Ynv5bminAOy+Vt4ujsIY2ZQx0kojd/Dg1
         NML0XlYOQggLtWDxxdwegnvBeplyPsSAon8zeYBQymGjfN2Zg2CTN+CYJ8Y2XmuMJz4k
         XDUGPk2wFa1R88ZjT/MZJhBkO/wYxxzDnUhEXF8o9snbYBbp8FizuTsPxR9xDMeNmGdJ
         DtOzUhf0iHN6eHMN28F4Geo7AwYBdXkPDw/HnphvnKLeClCUq0fKSI6G6nztKUTKELg/
         sZ4w==
X-Gm-Message-State: AOAM530thAtHQl7Of2feULTeB3s4HT1FmgDS4pdEXX/MFw35Z4/SEmno
        vz0mw+AYjBX81nUwdCYqVPAUq17gCVianlxHxAM=
X-Google-Smtp-Source: ABdhPJzT6lB/d6coGsnLDcd84QPyQtjdhC4LGOqm+GnyYAcAIt+f8kCjXQ+M1EdE+Hcdm22tBvlu1jXlhsn45JDHhPg=
X-Received: by 2002:aca:d4d3:: with SMTP id l202mr10419123oig.167.1597683545012;
 Mon, 17 Aug 2020 09:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
 <068e097e22fa42b79e70b0346cc7460f1a3cbcff.1597561152.git.gitgitgadget@gmail.com>
 <20200816085406.GB1221900@coredump.intra.peff.net>
In-Reply-To: <20200816085406.GB1221900@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Aug 2020 09:58:53 -0700
Message-ID: <CABPp-BHUN=f-oGmjUpbRRs=h9OZ75jFZUZbQ7_sFO4cCKuVK_Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] dir: make clear_directory() free all relevant memory
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 16, 2020 at 1:54 AM Jeff King <peff@peff.net> wrote:
>
> On Sun, Aug 16, 2020 at 06:59:10AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > The calling convention for the dir API is supposed to end with a call to
> > clear_directory() to free up no longer needed memory.  However,
> > clear_directory() didn't free dir->entries or dir->ignored.  I believe
> > this was oversight, but a number of callers noticed memory leaks and
> > started free'ing these, but often somewhat haphazardly (sometimes
> > freeing the entries in the arrays, and sometimes only free'ing the
> > arrays themselves).  This suggests the callers weren't trying to make
> > sure any possible memory used might be free'd, but just the memory they
> > noticed their usecase definitely had allocated.  This also caused the
> > extra memory deallocations to be duplicated in many places.
> >
> > Fix this mess by moving all the duplicated free'ing logic into
> > clear_directory().
>
> Makes sense. I don't know the dir.c code very well, so my worry would be
> that some caller really wanted the other fields left untouched. But
> looking over the callers, it seems they're all clearing it before the
> struct goes out of scope. It's possible that they could have created
> other pointer references, but it seems unlikely (and I'd argue they
> should stop doing that and make their own copies of the data). E.g.,
> wt_status_collect_untracked() sticks names into a string_list, but it
> sets strdup_strings to make its own copy, so it's good.
>
> > @@ -3034,6 +3031,13 @@ void clear_directory(struct dir_struct *dir)
> >               free(group->pl);
> >       }
> >
> > +     for (i = 0; i < dir->ignored_nr; i++)
> > +             free(dir->ignored[i]);
> > +     for (i = 0; i < dir->nr; i++)
> > +             free(dir->entries[i]);
> > +     free(dir->ignored);
> > +     free(dir->entries);
> > +
> >       stk = dir->exclude_stack;
> >       while (stk) {
> >               struct exclude_stack *prev = stk->prev;
>
> In most of our "clear" functions, the struct is ready for use again
> (i.e., fields are set back to the initialized state). I don't think any
> caller cares at this point, but it may be worth doing while we are here
> as a least-surprise thing. That would mean setting these pointers to
> NULL, and probably a few others that you aren't touching here.
>
> Perhaps even easier would be to add a dir_init() call at the end after
> your next patch adds that function.

Make sense; I'll fix it up.
