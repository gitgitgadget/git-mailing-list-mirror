Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFD4C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6689D610CE
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbhITPWj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbhITPWi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 11:22:38 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AF3C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:21:11 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so5202569otx.3
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jt1Dn3Q/bnftI0jqhpP9eG0owCtBSFCnlbQ7tL1fIQo=;
        b=TpdIrDpywXPN9R+erKme0X1H4r7DkUEloS78U+G7rBeooBDowuZaJ3cab8mPv0KVx9
         ZvAkTGbGh/kkt1fNU0RTfuHFQeRVyRIIgl1CmZdNxiyGUIlmqjqw+5Z/V975/ZaCL4rk
         IUTM9YvsJw39DLoxJu3AvZUQscTOCOVMSyHjqjI1Q3Y7axg1FTLBGRCVDLJwloFRMab9
         Z/TY39++pZraHdwizmi8+9hd00p4i1LD3KI8iUX5GS03WIqOP0mww++MdwPDsn6EgGZL
         h4aLuOh0JedDChdRv7mQ51HQtEXyiMNi+p00zlVfbO3kalJNiuR+c0ftSqZphTAGmPgF
         79pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jt1Dn3Q/bnftI0jqhpP9eG0owCtBSFCnlbQ7tL1fIQo=;
        b=3YvgS4VndIAaixMIV14WooWbgzFDpa5XNx5PU44GNvX9fTopMQdEqDYDeONRLFGQTI
         kS/XNrrBveNLYBQBmpz5nY79ZaD9mF0/PkwRNZqVkVBGHSdgr0Dr0ibbuk01bOEsKId/
         qE7xPv+lPQypGUBEfJlqs+2ODhfKNSkbrMUenh9WWK5L2dklaXEtV7dNAfObbUc+GLOi
         4tctyAn6yjK90cVj/NZ0UqeFHSpiyJc38ZJ2/yIF8JfEWNwRBvdX6nmKbqkWFF2k7RoR
         ljhKz2klrWM11VCptUJFke4R42ioqncD8g5YOW0DGVCEhnOs/KoKdZnfW4gLFrDQKaRD
         rhUA==
X-Gm-Message-State: AOAM531EXxzWaYl4MuiKlO5x235RWzpRJd3JIenZRWeFS7+NwpdrGWiU
        xPdRrBbnRbuyrZxJgnt/rRZLNYgrjxxivtPYISkG9T2MuAM=
X-Google-Smtp-Source: ABdhPJx3hkEVsmb01SCCQ4f6vukef1jH5Qqc+6IWhKBSwaUHyeJGshaF8S0WHFTuvseGzm4pYEw7JOirrPTZp1eJNoQ=
X-Received: by 2002:a9d:609e:: with SMTP id m30mr21239348otj.174.1632151271167;
 Mon, 20 Sep 2021 08:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
 <45bd05a945f034d03555f04a1ba85835482dc591.1632006923.git.gitgitgadget@gmail.com>
 <87wnncbrm4.fsf@evledraar.gmail.com>
In-Reply-To: <87wnncbrm4.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Sep 2021 08:20:59 -0700
Message-ID: <CABPp-BFiKuTi_uSmWXc4FF-zYzODhtVdv8AQbz_--bz6XZjp6A@mail.gmail.com>
Subject: Re: [PATCH 2/6] Split unpack_trees 'reset' flag into two for
 untracked handling
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Fedor Biryukov <fedor.birjukov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 19, 2021 at 6:51 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Sep 18 2021, Elijah Newren via GitGitGadget wrote:
>
> > -     opts.reset =3D reset;
> > +     opts.reset_keep_untracked =3D reset;
> >       opts.fn =3D twoway_merge;
> > +     /* Setup opts.dir so that ignored files in the way get overwritte=
n */
> > +     opts.dir =3D xcalloc(1, sizeof(*opts.dir));
> > +     opts.dir->flags |=3D DIR_SHOW_IGNORED;
> > +     setup_standard_excludes(opts.dir);
>
> Is the "opts.dir" free'd later somehow?

No, much like other callsites that set this up (e.g.
builtin/checkout.c), there isn't a place that frees it.  In copying
how they worked, I also copied their bugs.  ;-)

I'm tempted to move this code into setup_unpack_trees_porcelain() and
then free it in clear_unpack_trees_porcelain()...though not all
callers make use of those functions.  Hmm...

> >       opts.head_idx =3D -1;
> >       opts.update =3D worktree;
> >       opts.skip_unmerged =3D !worktree;
> > -     opts.reset =3D 1;
> > +     if (o->force)
> > +             opts.reset_nuke_untracked =3D 1;
> > +     else
> > +             opts.reset_keep_untracked =3D 1;
>
> In both cases opts.reset_keep_untracked is set to 1, I assume it's a
> mistake

No, it only sets opts.reset_keep_untracked to 1 when o->force is
false.  If o->force is true, it instead sets opts.reset_nuke_untracked
to 1.  There's no mistake there.

> >       opts.merge =3D 1;
> >       opts.fn =3D oneway_merge;
> >       opts.verbose_update =3D o->show_progress;
> >       opts.src_index =3D &the_index;
> >       opts.dst_index =3D &the_index;
> > +     if (o->overwrite_ignore) {
> > +             opts.dir =3D xcalloc(1, sizeof(*opts.dir));
>
> ditto potential leak.
>
> > +             opts.dir =3D xcalloc(1, sizeof(*opts.dir));
> > +             opts.dir->flags |=3D DIR_SHOW_IGNORED;
> > +             setup_standard_excludes(opts.dir);
> > +     }
>
>
> ditto (also more omitted).

Yep.
