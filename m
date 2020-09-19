Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B155C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 12:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA09221707
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 12:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQ8Z8n8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgISMGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 08:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgISMGP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 08:06:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26476C0613CE
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 05:06:15 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z19so8991371lfr.4
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 05:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qEMxX0SO3UISiXxweFV6zCLX6f8zAnYAyc4dybH/HC8=;
        b=FQ8Z8n8Ff8gxGluWmuVJXKO/5AYVnXdDGNoIc7CsCQF7wlGZeSvhIQ5J3XDlrpQTJB
         PV0c9B8F8qk4EQwWZop6N4SUWASM6Sb1bMOuR7/6lxokRcTGb3e+Hr0QX/cfM7Ha63BC
         vybh5YIw0AgPfwlxwpvOkUoP32HPbPyjPmfk5/NlkKEox/jxDuAra07U/0GI+ZZ7Ip4z
         8G884iROO+jUerzqbgG/DqphSFzJnbWEZ/WHKt2oIS4E10s9bkU9mkHMJon3llSs37Wq
         E13WcKQNVI5pieoPBuHgXC8MOC0I/kZVxs0AIfjJFEB0VLDZSrn/7dDkFok45n76oTEW
         JAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qEMxX0SO3UISiXxweFV6zCLX6f8zAnYAyc4dybH/HC8=;
        b=l2bGT0M1VGx5kngxWiPv/gEGtw0KyCrL3qv1D2izpxHCOu06wnn8jsfqMUviS0pC9L
         Hy8WcuJa+C69nVq8990AuclregvyD1rsxoGLyl0rHkpOQLep6Sey4Ttt50WsYsEdBlUI
         wFDoPSFp7ESP+KUT1qRf1KFww/LCSJuk31fyTzC40rlyRMwXsOxKCKiKOc04QD5gF3ll
         azlGRZ9Q1Dq2CvZwiMqf3Q/vgPxySPXso9hyJJ/P9r/i7p9YOg1FP62QGmI352LLjbP4
         2lvKJNm28MgxS0RmEAdV3ACzSBnEFs2Zna0dVSjn2If0NnGJ0OrbxQQdCVux92KQxs5T
         Wzqg==
X-Gm-Message-State: AOAM531ILJk6/7l9HfgckGdyAW5OzIHKFYn3YpgHNbkP9VQRD5L1vTRg
        XXNlcgubGxkONPyU+XQGxqpChHFZfZGb7FkBHR0=
X-Google-Smtp-Source: ABdhPJyCGMRHnfjHWm4EQUH679FYKj6VXzhemCvlemtARIbI+skQOgB5sven74fVaSpItnRtQe0q3U2AWn5ana9NpU8=
X-Received: by 2002:ac2:48a2:: with SMTP id u2mr13535286lfg.391.1600517173216;
 Sat, 19 Sep 2020 05:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com>
 <CAMwyc-RCiEREpPsTb76LjhLc43Zr2qw-uxYVVPfuznexTTB+Tg@mail.gmail.com> <CAHpGcMJy=0deaByZ=jXHRiHgHH7utHc0JTG=BMq9Yf1DOKvuGw@mail.gmail.com>
In-Reply-To: <CAHpGcMJy=0deaByZ=jXHRiHgHH7utHc0JTG=BMq9Yf1DOKvuGw@mail.gmail.com>
From:   Thomas Guyot-Sionnest <tguyot@gmail.com>
Date:   Sat, 19 Sep 2020 08:06:01 -0400
Message-ID: <CALqVohesf8WA_+_EaZiheoQ=-JL2Lnh_P1GF4MOZV2usVM=-jQ@mail.gmail.com>
Subject: Re: Apply git bundle to source tree?
To:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 18 Sep 2020 at 17:45, Andreas Gr=C3=BCnbacher
<andreas.gruenbacher@gmail.com> wrote:
>
> Am Fr., 18. Sept. 2020 um 22:18 Uhr schrieb Konstantin Ryabitsev
> >
> > I know this is not what you are asking, but since you used the kernel
> > as your example, you can use the following to achieve the result
> > you're looking for:
> > curl --header 'Accept-Encoding: gzip' -L
> > https://git.kernel.org/torvalds/p/v5.9-rc1/v5.8 | gunzip - | git apply
>
> Oh, that's neat.
>
> What I had in mind were actually distro packages: most projects
> nowadays live somewhere in git repositories. When they're packaged,
> this usually results in a source package with a diff on top of a
> baseline release, so the commit history is lost. Friendly packagers
> include the commit hashes and point users to a suitable git
> repository, but that's not enforced or consistent. Including the
> actual git history in packages would be much nicer (i.e., a git
> bundle), but if that can't replace the patch as well, it's rather
> unlikely to happen.

Afaik a git bundle can do all that, and it's actually a neat idea. It
will be bigger initially than a single release, especially if the
project has not been good at keeping history tidy, but bundles could
be used for both the base release *and* patches, and actually when you
need the next version old bundles could also help downloading just the
additional bits you need.

Since you mentioned it, patches that are maintained by packagers are
best maintained in git already, so the patchset could be available in
a bundle (you can have a single bundle with multiple refs; the
release, the patchset head (each parent back to release HEAD is a
patch) or even each individual patches is that suits you). If you
maintain them as separate bundles, you will always need the release
one for the rest to become useful, but in the end it's easy to convert
between bundles and patches.

FWIW I've been using bundles since the very beginning - my use case
though was backups. I figured it was an efficient way to archive an
entire bare repo into a single file and ship it offsite. I don't think
I kept the script but it's quite simple; bundle just needs the
heads/tags - without a range it goes all the way through history. For
the restore, I would list the heads from the bundle then fetch each
back into the right head/tag in an empty repo.

--
Thomas
