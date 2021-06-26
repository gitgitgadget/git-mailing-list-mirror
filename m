Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BE3C49EA5
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 17:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2794B61C30
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 17:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFZRRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 13:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhFZRR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 13:17:28 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E797C061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 10:15:05 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id v5-20020a0568301bc5b029045c06b14f83so13019162ota.13
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 10:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lBfV3mTOtYRHEXx/WuXevQt6m68mlYBXdWUxJ9TIcZ0=;
        b=KcsjmGlkktSZyBcAFb0S3O6yF7fhYnTATyUuJpL+JcdkJ8e0oD1t8TCR3cPGgYHkS8
         I4PTikeW2notPMlPBU0pPyYgLY67Dx9KRxYEFE13qkZ3OEyeQD+06T5dUtj8mcCWevV1
         sdrujczh2CW1ysP0ERh6cOUW+PwMbCKPtFfO2mvyVySEzt46H6+AK+wphgTUngpeYdnX
         JyHGjtd9pgLa9TuPnFh1r6KY90U0YeiismCnPybdPQfJ9lPlcDV+SNJx2ol7M6XYzpHM
         nOc4yesy7a8OFASxhZ5ZXoJYUfIfyB3H4+enmiD0eFHAOVs0zRcpFNvnpfaUhdI99ldX
         oYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lBfV3mTOtYRHEXx/WuXevQt6m68mlYBXdWUxJ9TIcZ0=;
        b=qXSp8ESq3NI93uoveg3GnUy3Enj4hF836TmVMVD409cNG4fTTtOLBK9p+J/A3B6TX5
         uCj9VFt9HYxLkTGW+aSkc7/tZ+Cf/eL1/h1WrDXSxSLqX7/Y0ICcnVEBfT3tKNPRJzgJ
         syTan3VjLU8WdQvMHTpKjw9HaE5EQz6hK/hC20srGPwwBU56PPz7qH2D5VtGZL3vLstz
         S5M68dE/6PkpbE0WmiTKAlEdlreh+4VpB6HlQ8wiF3sRhXbEKaV87HSEnXbnP8jRgCFG
         l0sCYwyXbFtaNENSvStGXuSg3v7/B/Xgph/FUVac3U91tzRqdj5tYHnk+rT44xYnEWRZ
         iqQw==
X-Gm-Message-State: AOAM532WOxrQiV0s97Dto+jjRidDFboooyUPiOFAZXnnvJKtvozxB8db
        nPIfXxEMIg5+SpbGguLbWl9aSzyGL4ZxyPu0j3g=
X-Google-Smtp-Source: ABdhPJwfV51MooIvPLg0krfmyiijBkw/FyC3wTZRrBZS7vEvkorXvdyYMb2O9mrkF6FWKExNf76XPRPNntmhYpcRMIY=
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr14655746ote.316.1624727704779;
 Sat, 26 Jun 2021 10:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <148044c89c194a82aa15ab0ca016669d@oc11expo7.exchange.mit.edu>
 <CABPp-BGDfucqae=HNES_QmmsjpDbdHrR6CG=H3gtiDygHzquVg@mail.gmail.com> <9ef09567-d69c-0fba-a09c-70095a21a3a9@mit.edu>
In-Reply-To: <9ef09567-d69c-0fba-a09c-70095a21a3a9@mit.edu>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 26 Jun 2021 10:14:53 -0700
Message-ID: <CABPp-BFqpdjZVY6Jw4tz7z+4UdiPJpD+1Ymv=6QVBm_Apb3xbQ@mail.gmail.com>
Subject: Re: v2.25 regression: cherry-pick alters patch and leaves working
 tree dirty
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 13, 2021 at 12:45 AM Anders Kaseorg <andersk@mit.edu> wrote:
>
> On 6/12/21 11:57 PM, Elijah Newren wrote:
> > There's two bugs here, and they actually predate v2.25.  If you put
> > all your files in a subdirectory (e.g. 'subdir/bar' instead of 'bar'
> > and 'subdir/dir/bar' instead of 'dir/bar'), then the same bug
> > reproduces going back many more versions.  The changes in v2.25 to
> > support directory rename detection of a subdirectory to the root just
> > allowed this bug to happen at the toplevel as well.
>
> You=E2=80=99re right.  I=E2=80=99m sure you=E2=80=99ve already done this =
bisect, but for
> posterity, after that modification to the test case (=E2=80=98mkdir subdi=
r; cd
> subdir=E2=80=99 after =E2=80=98git init=E2=80=99), it reproduces back as =
far as
> 9c0743fe1e45b3a0ffe166ac949a27f95a3e5c34 (v2.18.0-rc0~2^2~20)
> =E2=80=9Cmerge-recursive: apply necessary modifications for directory ren=
ames=E2=80=9D.
>
> Thanks for the quick investigation!
>
> Anders

Patches posted here:
https://lore.kernel.org/git/pull.1039.git.git.1624727121.gitgitgadget@gmail=
.com/
