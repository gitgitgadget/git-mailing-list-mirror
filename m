Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4F0C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 22:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbhLUWSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 17:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbhLUWSj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 17:18:39 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AB2C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 14:18:39 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z29so762057edl.7
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 14:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f1hWsr/bQmT3RIOof8mgK0tRLEuieZ9rImHzCf+EKbQ=;
        b=hG22IyODZn/Oz6pbDqTFCf/A40VB5ET7VNcRoDjD4RYs2/wWSj48OaXenln83emr/+
         uFoVIUmuW4qUs5qERpoKfp96d1vWX3yc1xJviV81lY7GQkn7OSgd5ENNe0Pf2BglS8VX
         bsl7tZ1Wc4BoH85TvDJRCIU2D333DrxgSC+g9qvr92vZAnTfJMhrTOhWhKbQP7+Zs0Qc
         Qd+zog8Pwfr5xyVRHvmAG/2vL9dQfyooLC9VrzGXX0kN6E/3mQgU/qFcfg7+6mV8Ve83
         oGznXc/cpsKlE6BXJ3xMV3sM23E9ao+/FRVmhf0Ii/HsHC9Yc8CF4SNr2qSqHYAmEd2B
         fQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f1hWsr/bQmT3RIOof8mgK0tRLEuieZ9rImHzCf+EKbQ=;
        b=SjB1RyDHz9mVaUpnI0ivV8LXnQ3hDPrLRT+L9FQbjHqGADa9upMHghPP8wvYhVF710
         EGXeW1L3slkBIIQFPCjrNf2nlkh75tiLf2rYwGFAG+zJgjiyesRP3FEYmToc7u9uCclJ
         u3kTa06XeSY36991JVY8WjM5hhwp0XXdt/qoL1fuWDfyKykxbucio8G6uy93m1FBnjsM
         5+7CXbqEqn+6qaOvDHaLrqU7q+b5dksSRswKuZVgtRAsY8GFEEy2Fwr9XuEjYBf/ND+h
         g2Kg9ptLviF53H7XNehDvCoHZUc7QhEmOrsogyLZ1yOe4c1vmafnVbiJxMGohIwetFro
         9vOA==
X-Gm-Message-State: AOAM530fnsk2DH0o74DWpvjWl/nfI1ECfGgx9PVv6rb9h/u6ZfQxqeH+
        bqtT9q6o0UMez2Mvw2W11971EnB4RST4u2KE/uNDpy54CoM=
X-Google-Smtp-Source: ABdhPJzjh8f80ecJo/SG3AmGIqp/SZiRwZ4ADxkQPVBxej6MyunnYk5VJfBqNJZDR5wRSsVz/HhVMOGPkFTGTlhV4sc=
X-Received: by 2002:a17:907:60c8:: with SMTP id hv8mr292453ejc.192.1640125117601;
 Tue, 21 Dec 2021 14:18:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <5d5846be0bd67b8fd850ef2583beef064481a67d.1640109948.git.gitgitgadget@gmail.com>
 <211221.864k71r6kz.gmgdl@evledraar.gmail.com>
In-Reply-To: <211221.864k71r6kz.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Dec 2021 14:18:26 -0800
Message-ID: <CABPp-BFuZbLKLf8VnNxLAuF0NaSg=2Nut++YxhHsCxr3n1jwJg@mail.gmail.com>
Subject: Re: [PATCH 8/9] show, log: provide a --remerge-diff capability
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 21, 2021 at 1:28 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Dec 21 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
>
> > +     if (rev->remerge_diff) {
> > +             rev->remerge_objdir =3D tmp_objdir_create("remerge-diff")=
;
> > +             if (!rev->remerge_objdir)
> > +                     die(_("unable to create temporary object director=
y"));
>
> It looks like the tmp_objdir_create() API is rather bad about mixing
> errors that would come with an errno with others, but shouldn't this be
> die_errno() in the case where it would fail due to a syscall? Even
> better would be passing a "gentle" to it and have it emit the
> appropriate errors.

I can switch to die_errno().

>
> > +     if (rev.remerge_diff)
> > +             die(_("--remerge_diff does not make sense"));
>
> s/_/-/

Indeed, thanks.

> > +     struct merge_options o;
> > +     struct commit_list *bases;
> > +     struct merge_result res;
>
> nit: could use "=3D { 0 }" instead of memset below.

Sure, I can make that change.

> > +     /* Re-merge the parents */
> > +     merge_incore_recursive(&o,
> > +                            bases, parents->item, parents->next->item,
> > +                            &res);
>
> style: odd not to have arguments that fit on the line on
> the line, i.e. "&o, bases, ...".

Yes, but this groups all the ancestors so nicely as opposed to the
typical happenstance of whatever fits on a line.  ;-)

> > +     /* Clean up the temporary object directory */
> > +     if (opt->remerge_objdir !=3D NULL)
>
> style: if (!x) not if (x !=3D NULL)

Ok, will change.
