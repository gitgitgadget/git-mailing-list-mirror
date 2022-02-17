Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82014C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 04:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiBQElP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 23:41:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiBQElO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 23:41:14 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94102860D2
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 20:41:00 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bg10so4190459ejb.4
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 20:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8lezMjDV2f4KgSWWDoAZfsGfM/DnXmvAICMoNdtpymk=;
        b=ptIszsoO8ueP4ss9IXVBPAwnN2x58c6H9TDWSOBPnpLtWuvgWbw4BY6C13ESjd2XvU
         WrOn+mHK73O8hOfyVh0q/3YuB4/z5lLCinhhT+u3+9d425Pfv5plGJ6JCLxww2dzrA2/
         ug3jz1V+Tq1sR+iByxzji5oicXyLEtFUlIS5JB7iXWWseS3XcDth5gnDLTbwrBLnufgD
         ot+hGEXr7O5Q4aJpjnOclG8EoGBwqzVMWulPbNx6Jyb4tQ+jRNgNASxeNQo0KPMc9fyt
         oaokMX0HCF5Rk/tXVHYQE+V3WmF/ddcAnfpC+4ylvZDLW2bPr96w+reYunVbdLuc71j1
         6Kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8lezMjDV2f4KgSWWDoAZfsGfM/DnXmvAICMoNdtpymk=;
        b=yvDzlkKBGYBDQ88D+ZGTpUAmoHfBwB2xaa4QosjZA9GN18ClZh8wp4iRSv5eG5qY4i
         EI7yhSCVhf0TmSl/xzVD6nbFYbCOoqzgQgbJ+NGdJzvd6ulkVE16fMUdeSzj//bzBFJj
         Jn2gosw7ZNAKEzb7HoAUUmxvU3KmMD8WcrfI74uKlDeSnee1eoM4L15sOzMPpkXjC/VK
         Loz8YKOoZTV2Pabzod2y4O7i2Fz6LUGeTLb1OCpsrqggUc07KgERjamnLihemp9g61L+
         tbAC1VnHjtbpahQ9xR4567rXkBgq4ZXGYB516YQmImo0tIyPGURP8t4MAAu4uYt4PM6e
         O6Yw==
X-Gm-Message-State: AOAM531V7f19XjtnmIUoEHR4a5ZhZFIz2GcMSZDeqa259C2P8KwWBZqr
        o8TNJRlKG5GMH/ws/Wq3fvPJxJlAma0MqRFtG/c=
X-Google-Smtp-Source: ABdhPJy2VYEErIVQknfLzhgEl0s/zZsUBXkRedhb++WQuksM7NEFbsJpvwE74VyoSSw2b1B973rv/ML7yyVQYpICpGA=
X-Received: by 2002:a17:906:64e:b0:6ce:36ae:7ab5 with SMTP id
 t14-20020a170906064e00b006ce36ae7ab5mr983036ejb.192.1645072859400; Wed, 16
 Feb 2022 20:40:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
 <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com> <05ac964e630a2e72eebaa1818a8807cd7a7d4f7e.1642175983.git.gitgitgadget@gmail.com>
 <220216.86fsojup82.gmgdl@evledraar.gmail.com> <CABPp-BEog_CBEjx3FBGdUAhjwrPPDuP54HWQssAWnGeUnr0cBg@mail.gmail.com>
In-Reply-To: <CABPp-BEog_CBEjx3FBGdUAhjwrPPDuP54HWQssAWnGeUnr0cBg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Feb 2022 20:40:48 -0800
Message-ID: <CABPp-BHbpO7CUXApVcEuv-Q-+_+oCTh_gmRO9UOwQPYPsbAH+A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Accelerate clear_skip_worktree_from_present_files()
 by caching
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 16, 2022 at 8:30 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Feb 16, 2022 at 1:37 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> > On Fri, Jan 14 2022, Elijah Newren via GitGitGadget wrote:
> >
...
> > > +
> > > +     /* Free previous dirname, and cache path's dirname */
> > > +     *dirname =3D path;
> > > +     *dir_len =3D newdir - path + 1;
> > > +
> > > +     tmp =3D xstrndup(path, *dir_len);
> > > +     *dir_found =3D !lstat(tmp, &st);
> >
> > In most other places we're a bit more careful about lstat() error handl=
ing, e.g.:
> >
> >     builtin/init-db.c:              if (lstat(path->buf, &st_git)) {
> >     builtin/init-db.c-                      if (errno !=3D ENOENT)
> >     builtin/init-db.c-                              die_errno(_("cannot=
 stat '%s'"), path->buf);
> >     builtin/init-db.c-              }
> >
> > Shouldn't we do the same here and at least error() on return values of
> > -1 with an accompanying errno that isn't ENOENT?
>
> If we should do that everywhere, should we have an xlstat in wrapper.[ch]=
?

Turns out we already DO have a file_exists() wrapper function, but
it's found in dir.c rather than wrapper.[ch].  However, it doesn't
bother to check errno either...
