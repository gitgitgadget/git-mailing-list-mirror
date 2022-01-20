Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A3BC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 07:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbiATHxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 02:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiATHxR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 02:53:17 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9195C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 23:53:16 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l5so7874372edv.3
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 23:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PXMXVR1wnRp/3AaDE/bjLQzQRUdZE7GjBW6o3r93IEA=;
        b=oAQSeQABkPdctDrPfLW89eClh604THbLfgXUKpkP9AssFi+bXulkgT0eYzn4PbEjEG
         JgBg/qd+vrCPB4cc/l/ERy5+jpShzDIX9UWeTi5m487+XfJWzyqRXlipKqK4sn6zAwvv
         TDjNJ8eMSWv+830EcG6VcjD0NO4N15Qjogo49QGvqEzS7on04ZlRHcpOMZbGFDj+72wx
         3fDqPPMH7Dc1Ssrg96OjRIbNi69drJuDfZzF1jVsZst7AHS9PiMfeNRFNXmydhunOOTv
         37pxZkTcDPRIyhGXGcRpwLhFrqHm2vUlWDQKPUuZyOZBr1e0oViwPxYMDk+/tZAeNaDS
         Fr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PXMXVR1wnRp/3AaDE/bjLQzQRUdZE7GjBW6o3r93IEA=;
        b=hwasMTvF6C+1NcS1I1VOOWTqnNCf1mat/SSd2ixmmTIJNYc5mbxgoq/FrCIPC9VxvV
         xI2QmCEF2KoSfh3oHXjQy2EkViBHd9JOytonqi8GqWmY3+pr+CgcgtJdjajByCiIs1+Y
         ORN8wcHijpf17lirrLkTBISrgPgS3YKZwjWfyIadC74Pzk1N1dWtRERN8uxBooOsWdYO
         XDFZ0Sivx6XCnfkghR4lK6dT/rbuU/5nm11+JDKy4E7m6xNsqyFUME5bqxgfdLK48TVj
         t6JKCTw3iPhrL9aNhCyPB7Ln5i4A74cNjKrTWRnP3yFdFgp1IkDafhRzj51TtRyr9kqv
         po0A==
X-Gm-Message-State: AOAM5307fkRTKvlEyi/e5Hmj9zkRjH0di4gG53c6QiqMmo9ur+baJiDD
        6Ycp7yPof0R4M/MvjndpXzgxaQsgJh1S9TNyTiBfVe5qmHY=
X-Google-Smtp-Source: ABdhPJw5rveQC7tBAr23lFHRcCY2ksXm/Dx6j0Ni/gx00jIhNjFk8xQeSc6JQvJcDAev6L7ImaPCrr87XfibE1I4O2w=
X-Received: by 2002:a17:906:dc8e:: with SMTP id cs14mr27035307ejc.269.1642665195131;
 Wed, 19 Jan 2022 23:53:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
 <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com> <d57ae218cf9eaee0b66db299ee1bba9b488b69b1.1640907369.git.gitgitgadget@gmail.com>
 <220119.86pmonn2mb.gmgdl@evledraar.gmail.com> <CABPp-BGsf8pcEZrY3vuq0yszy9G57fVa5jMSjT3H+sgDe6hWGg@mail.gmail.com>
In-Reply-To: <CABPp-BGsf8pcEZrY3vuq0yszy9G57fVa5jMSjT3H+sgDe6hWGg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 19 Jan 2022 23:53:03 -0800
Message-ID: <CABPp-BFqmFp7rY+aB2oHb=4u2JHZCZzhg+tz5DETEM5fZknKEg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] show, log: provide a --remerge-diff capability
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 19, 2022 at 6:31 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Jan 19, 2022 at 7:53 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> > On Thu, Dec 30 2021, Elijah Newren via GitGitGadget wrote:
> >
> > > From: Elijah Newren <newren@gmail.com>
> >
> > > +static int do_remerge_diff(struct rev_info *opt,
> > > +                        struct commit_list *parents,
> > > +                        struct object_id *oid,
> > > +                        struct commit *commit)
> > > +{
> > > +     struct merge_options o;
> > > +     struct commit_list *bases;
> > > +     struct merge_result res =3D {0};
> > > +     struct pretty_print_context ctx =3D {0};
> > > +     struct commit *parent1 =3D parents->item;
> > > +     struct commit *parent2 =3D parents->next->item;
> > > +     struct strbuf parent1_desc =3D STRBUF_INIT;
> > > +     struct strbuf parent2_desc =3D STRBUF_INIT;
> > > +
> > > +     /* Setup merge options */
> > > +     init_merge_options(&o, the_repository);
> > > +     o.show_rename_progress =3D 0;
> > > +
> > > +     ctx.abbrev =3D DEFAULT_ABBREV;
> > > +     format_commit_message(parent1, "%h (%s)", &parent1_desc, &ctx);
> > > +     format_commit_message(parent2, "%h (%s)", &parent2_desc, &ctx);
> > > +     o.branch1 =3D parent1_desc.buf;
> > > +     o.branch2 =3D parent2_desc.buf;
> > > +
> > > +     /* Parse the relevant commits and get the merge bases */
> > > +     parse_commit_or_die(parent1);
> > > +     parse_commit_or_die(parent2);
> > > +     bases =3D get_merge_bases(parent1, parent2);
> >
> > There's existing leaks all over the place here unrelated to this new
> > code, so this is no big deal, but I noticed that get_merge_bases() here
> > leaks.
>
> Interesting.
>
> > Shouldn't it call free_commit_list() like e.g. diff_get_merge_base()
> > which invokes get_merge_bases() does on the return value?

...
> So, yes, I think there's a leak, but it's not due to this patch.  It's
> one that has been around since...the introduction of merge-recursive
> (though it originally computed the merge bases internally rather than
> allowing them to be passed in).  So, it's been around for quite a
> while.
>
> I'll look into it, and see if I can come up with a fix, but it doesn't
> really belong in this series.  I'll submit it separately.
>
> Thanks for the report.

Fix over here: https://lore.kernel.org/git/pull.1200.git.git.1642664835.git=
gitgadget@gmail.com/T/

Has a couple bonus memory leak fixes too.
