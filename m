Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE68C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 02:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1EF611C2
	for <git@archiver.kernel.org>; Mon, 17 May 2021 02:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhEQCO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 22:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhEQCO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 22:14:56 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD00CC061573
        for <git@vger.kernel.org>; Sun, 16 May 2021 19:13:39 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e14so4706595ils.12
        for <git@vger.kernel.org>; Sun, 16 May 2021 19:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nWHHmYGdDnqK+rVGl/VqG+uBLv6HjXXu1jxTnM1RL3E=;
        b=rLZLySi0rKBGJUuK5tfNmrPyysQI+KZWBox2jBJRK92ytLd0zwT96ABkHOXdFAxiXS
         rf2z0afnrA8ahZ1/nd2lMQAxh87ka+n9t4EfzPKLSwcT2QP79JrdB4Ec1wD7NrViUGVw
         RLt1tcLJwcqr2sYgfPk2hwuxT6zDgHSbKgCzNcYwUC1Jnq4i3wSzRJGMZL6rcn95XpPS
         2/soT8yfKSquWxN4ae+hsYkVH+aRiVmZkCXWNcMu5N+hjQn4g4b62KU+PvBcRd9ZvBZt
         9AY20ZztypOoJ7ujSRNFNHomJhU6Xpt+Y2RVzSfKCxdLcogW7u4X4yuAQiMXqTR2GMnw
         v/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nWHHmYGdDnqK+rVGl/VqG+uBLv6HjXXu1jxTnM1RL3E=;
        b=PAhb4S6aoZqY+ClWsi1neDdQHb9T2V5h+Cb/3CygvUVlgD39CD7dERoD1k/SGXuFDr
         1JxKVLhOIj1aMeB8vC9w9BZ+cEjXP8B4WGQ+USjyXTNHuvVNs5SkBFV8dICJWY/BTHXK
         ueBzDkImgd9MpPKMLCIWBBQHRGl1vKgDTPL78N/Ecaz7NskotkTCXTJJFS3R+Kqchq09
         iYiCex9k5LI7SDDzZoFO0oSNUI5wEKfE5D/ETzQrke/jqfnJga95yE5121ZNubcaeIrB
         KfZxpZJZod3IjMikXSRapZyTjK43DssovDTpSeRoRG5YKkVjLPbVZWCFp0kcm/snIN2d
         rn7g==
X-Gm-Message-State: AOAM531BVbm+mj+ZtbKiqeXsMEimAah/VkpNFWbnr4Mf6/CVwwCbXQeP
        euhMUUnPtevzg4UhN69T2D2mwpyVUpIechWRLvo=
X-Google-Smtp-Source: ABdhPJySQ2TU4zuxqHMDvspiqhONkG+upoKLiA5ViPRA0KBMCaqIDJzhJ6MxNBPIT+wpHAJlU7Zm6O4+ny1EsNukU/g=
X-Received: by 2002:a92:c54b:: with SMTP id a11mr36379157ilj.174.1621217619098;
 Sun, 16 May 2021 19:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QBOgcz+Q_ODnbGq5r5CzrSdX+=DMT0pJS6iPTcP0VRjA@mail.gmail.com>
 <xmqqk0nz72on.fsf@gitster.g>
In-Reply-To: <xmqqk0nz72on.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 17 May 2021 10:13:27 +0800
Message-ID: <CAOLTT8SKF2whzSgqMO9pYPfehbnU=E4SDYR6B+aMV=fC2qihOQ@mail.gmail.com>
Subject: Re: [QUESTION] ref-filter: how to support atom like %an
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8816=E6=97=
=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=8811:55=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > My current thinking is this:
> >
> > First add a new member `short_name` in `struct valid_atom`,
> > Then we can share a valid_atom item for the long name of
> > an atom such as `%(authoremail)` and the short name of
> > the atom `%ae` (%aE is not considered at the time).
> > Something like:
> >
> > [ATOM_AUTHOREMAIL] =3D { "ae", "authoremail", SOURCE_OBJ, FIELD_STR,
> > person_email_atom_parser },
>
> My assumption has always been that when enriching "--format" of the
> "log" family (e.g. "status", "show") with ingredients from the
> "for-each-ref" family (e.g. "branch", "tag"), we would adopt the
> notation the latter uses, i.e. "git log --format=3D'%s %(notes)'",
> with the full intention that eventually users would choose between
> the synonyms to make it "git log --format=3D'%(subject) %(notes)'" for
> consistency, without wasting brain cycles to come up with and to
> remember two-letter shorthands that will not scale.
>

Well, it=E2=80=99s truly more useful to provide long name atoms for the "lo=
g" family,
But if we need to establish a unified interface for --format, shouldn't
we extend it base on `ref-filter`?

At present, the scalability of the implementation in `ref-filter` is better=
,
but it does not support two-letter shorthands atoms...

--
ZheNing Hu
