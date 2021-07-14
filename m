Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE3AC07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16D36128C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbhGNAWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbhGNAWO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:22:14 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3651C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:19:22 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id w17-20020a4aca110000b029025dba2185a4so162066ooq.11
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLe8mUBJXMoMC+wsW/x1VLb93kVMgduwA35ZZ8Qt3p8=;
        b=aqgEtz7ulIxX/yBduEVK64jCI//2tJ6gS4WtEkg4PkzUBHN8GPYLQe4Hwu/bZ7717M
         EtRU02u+ZvRlKihltTu3544/17EtAUiGOnMLwzZ3jNx9S16ws/1ZVyBPgYuuuOeIuJQ/
         JzvjRuqKtTUFvE7s4KkYyadykM9NblE8VNdoTf46VGCKA1vV0H8+wisMLIiz/1a/P8mo
         UHqI4RAXMuJ83N1tgOT8oxkFuHwXqiPu0XI+OFfE6wvJ1jHtVaiMDekjsD0OfEagcTBH
         F4s7Ot/Q0gY7Q7aiNVjUJY9GG8ci9eNqyiHnveG8nNtVifklobgM6bOD0iQO3JYjME7G
         e03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLe8mUBJXMoMC+wsW/x1VLb93kVMgduwA35ZZ8Qt3p8=;
        b=CPiJgZJmevprzbZ+YbYY4zLR2VDFeR46RoAQQx6b0A9gu6dL552RIIsaf6mkQX6dRd
         eKuLCPAx+KqesRTemK+HRO1k05KvlxeeXBMoAEu0jsJG+a7UTBSW++5B6V3veIIRY4k/
         HbyoKThYb6uF1IfuTbtWVZAucTNdfSUVlWhsSq7C3s7cYuVw2fqmNmwmplErWpSxRmxR
         FlNi3P5X3Dh/cwfro5AgZYhrN1Jw0GiWEA1R9DNikpGrh7MaEDemEMPtB77Sk/FlQDas
         YwdksGgEHKC2oxkguKTWE917cGMqZXFe9AhKXrmmQMxcbWnifZMUgHP2cRWg/GlMH8px
         qkOQ==
X-Gm-Message-State: AOAM530dVLtzQlRoSPC9DEnL3b26wwdITLxoqYOJ7r36QLtFyzSucpZ7
        bCj1IE6zLFOnFcEnX1atTAH1LKMfqII+L1Pc98w=
X-Google-Smtp-Source: ABdhPJwvxaD6BQKtZ3Fp7fyyQxUmz3230dA5tI5UrltaCVf+r2z4g6Brtsxv3XVDU9G+lznN3ikDaVIOr9KwzgFupJQ=
X-Received: by 2002:a4a:1b82:: with SMTP id 124mr5686006oop.32.1626221962290;
 Tue, 13 Jul 2021 17:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
 <pull.988.v2.git.1626204784.gitgitgadget@gmail.com> <8aea3713902b7d006f527ccd76faf6f944529bdb.1626204784.git.gitgitgadget@gmail.com>
 <7f4fc9f6-9b46-6e39-1a66-b72e0c583f21@gmail.com>
In-Reply-To: <7f4fc9f6-9b46-6e39-1a66-b72e0c583f21@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Jul 2021 17:19:11 -0700
Message-ID: <CABPp-BFBgCHAq=zWVoPPsDx04agDunAb3vVSgfJs4B2xVpasLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] merge-ort: add some more explanations in collect_merge_info_callback()
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 13, 2021 at 4:34 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 14/07/21 02.32, Elijah Newren via GitGitGadget wrote:
> > @@ -1018,8 +1018,8 @@ static int collect_merge_info_callback(int n,
> >       if (side1_matches_mbase && side2_matches_mbase) {
> >               /* mbase, side1, & side2 all match; use mbase as resolution */
> >               setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
> > -                             names, names+0, mbase_null, 0,
> > -                             filemask, dirmask, 1);
> > +                             names, names+0, mbase_null, 0 /* df_conflict */,
> > +                             filemask, dirmask, 1 /* resolved */);
> >               return mask;
> >       }
> >
>
>
> Is df_conflict stands for directory-file conflict?

Yes, eventually propagating up to conflict_info->df_conflict, defined as:

    /* Whether this path is/was involved in a directory/file conflict */
    unsigned df_conflict:1;

> >       /*
> > -      * Record information about the path so we can resolve later in
> > -      * process_entries.
> > +      * None of the special cases above matched, so we have a
> > +      * provisional conflict.  (Rename detection might allow us to
> > +      * unconflict some more cases, but that comes later so all we can
> > +      * do now is record the different non-null file hashes.)
> >        */
> >       setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
> >                       names, NULL, 0, df_conflict, filemask, dirmask, 0);
> >
>
> So when none of special cases matched, we assumed there's conflict
> (although provisional), right?

Yes, the "provisional" adjective in particular is there because we
revisit each case in process_entries(), and resolve those that can be
via content merges, renormalization, etc.  The content merges need to
wait until after rename detection allows us to pair up different
files.  If the different file versions are still not resolved after
process_entries() then it becomes an actual conflict rather than just
a provisional conflict.
