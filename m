Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D346EC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 18:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4C22072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 18:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZ7N4C72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgFJSGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgFJSGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 14:06:09 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAFDC03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 11:06:09 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id k13so1785885vsm.13
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 11:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bnGxVOndj5pgKXf3Ajw8S7dAyt92NNrbcmU1PObhlK0=;
        b=iZ7N4C72HWLBGLrlUxMHhLBEbj1YSHDroqM/Ga4Ik1Q+AnHd0Hyx/ws8GJ8GaiPG6P
         unVSXYtYU1v29kHvxKvwInUdsf9hkvg6MFNY3UJtX4cIywP26Hk0Xyp2KM9hkXcW1OWy
         xZQaS9fx4VfKdpMoN5baJk3YbG74TarhrUOQQ21gPRphTQ4VgDW6iJ0HcDIGP7xxvzGo
         90W7DLFMI3yJQCi0Vyds34X4meGPtZ0mRE9o0928WWG0RClwx0kmuExV+SVmway0oSzE
         VLZoYbcOIJ9m3StYtrLwEVBS5+WlrMBn1lxpZAAdk+Ezh9i498zG+XQKWkJ0mLwWg4Yw
         MEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bnGxVOndj5pgKXf3Ajw8S7dAyt92NNrbcmU1PObhlK0=;
        b=Kf3gEEe80rWj9NkjQfdw9jMzURmfOirP1iaV4kWv0uXTSTJPf75X5ItH1qPt9rjIRx
         T2l/h9O58w41sSs7ONlxpIKMfGmaZeHA0oYm6OMHlrbk9IhnwKUEkJ1GU5o8y8w3yp56
         Qu2BKRt8RJTNQfSY39YQujlp9D7+nqJnnLDUHr3XlebAB8jh5RvgY9FJJzkTU9b4zRVk
         aSIMtf0hGUI0JOOWmqloz3cUvQiUyXSpZrIsyc4bOWRQ+Dpy1AUzx4h+dPQ3biYGgqoW
         Nvw14EpDhkPut0ZPMFN5894ThKsGJENH1BkR0P+gVdmyG0Gk33eRhhI36IKoa/D2pXff
         tzhA==
X-Gm-Message-State: AOAM532K/MyWSx/9TO0H7L9sRBvHTZrEywNhLgUMu5WEnfT6M+yHEgCC
        V69zE18mDgqIAWST8r5M/8/tyAGYz9ERpTFHIvrOpA==
X-Google-Smtp-Source: ABdhPJz0fko9azl8eRcAj3w4vEwRbS9wtWRhH1+3hE5fuDXO1zSCu9qQ02P3DARNOQRKqV2uL84St0pUYIe/DRxk9Xs=
X-Received: by 2002:a67:ed4d:: with SMTP id m13mr2135953vsp.104.1591812368245;
 Wed, 10 Jun 2020 11:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
 <pull.539.v16.git.1591380199.gitgitgadget@gmail.com> <a4a67ce9635197d759a12a617711764c1df16b65.1591380199.git.gitgitgadget@gmail.com>
 <9a5c0243-115e-ce50-dd80-2be4c889f4ba@gmail.com>
In-Reply-To: <9a5c0243-115e-ce50-dd80-2be4c889f4ba@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 10 Jun 2020 20:05:57 +0200
Message-ID: <CAFQ2z_MDeiZshhmx=BjqCg7hTF04Fj7oM5dKs15qeESEPjjXEg@mail.gmail.com>
Subject: Re: [PATCH v16 02/14] Make refs_ref_exists public
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 9, 2020 at 12:36 PM Phillip Wood <phillip.wood123@gmail.com> wr=
ote:
>
> On 05/06/2020 19:03, Han-Wen Nienhuys via GitGitGadget wrote:
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> > ---
> >  refs.c | 2 +-
> >  refs.h | 2 ++
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/refs.c b/refs.c
> > index 12908066b13..812fee47108 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -311,7 +311,7 @@ int read_ref(const char *refname, struct object_id =
*oid)
> >       return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
> >  }
> >
> > -static int refs_ref_exists(struct ref_store *refs, const char *refname=
)
> > +int refs_ref_exists(struct ref_store *refs, const char *refname)
> >  {
> >       return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READI=
NG, NULL, NULL);
> >  }
>
> It is a shame that ref_exists() does not take a struct repository. The

I'm trying to follow the pattern that the rest of the code
establishes; you're right that the code isn't very consistent (the
fact that it uses unlink() rather than go through the ref store in the
first place is an indication of that). I want to avoid starting a
general cleanup tour of the code base, the reftable patch is hard
enough to pull off without.

> The existing code is inconsistent about its repository handling - we
> create the refs with update_ref() which operates on the main repository
> but when checking their existence and deleting them we use a path which
> depends on the repository. I've realized now the answer to my question
> about using delete_ref() in my reply to the previous patch - it does not
> take a repository - maybe it should along with update_ref() but that
> might be more work than you want to do though.

Why do they take repository arguments anyway? Is it because
rebase/cherry-pick supports recursion into submodules?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
