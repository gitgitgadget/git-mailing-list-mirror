Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F200C433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 08:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 199E764F38
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 08:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhCRI7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 04:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCRI7J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 04:59:09 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFE2C06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 01:59:09 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id v23so1665953uaq.13
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 01:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lMgnEYyfpn7tBBKYtRpUAFVoWA0sqg/xR1wcI3eE9ng=;
        b=UwMG8GcChigjkcmGqXHD3iNsOINyZYuzNSvHw8peczamHWV4R1geBtqcsU9mu8cGXW
         L2x8YAoXO2fm3Ye8qJgamjCB9WQ9KR9hwB3nRXwKU6844PdqNtMexaJkgz1/09JSh+o7
         D8FyjQzR2qpnp5xLtcKyJ49vFvBlRWNl0j1S1PPqJKdjeIxVD5WdPsQIu95YsLOSAUUT
         xx5UVCCVXHSljpRspB4EhaP0gR6Y6iqyAdLFqV2cP52GM3fGu4hL3cj6cOS9YPZ7/7Fb
         nVEP9dJu2v4D3TstQb7Cyn0tltNGIO7bl/nEqwvgWGtX8WRwRLhlJz3BSxa16aiSUWAy
         VNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lMgnEYyfpn7tBBKYtRpUAFVoWA0sqg/xR1wcI3eE9ng=;
        b=tfRj0xU8/tg5swHL8mdoKsBVmFAwv0l2WhaUgmWS8S4XeMfoz427LCgCmLW/Ac6+cR
         iSnjpbGgj5Wb8BMBYj6xv0zU4iiavC+EbH9zp/G9PNnluP7sVBxSGZNCBt3Rov+fKzvl
         aleneZcb5onxNZQ7W3PzbHNsDirnPP5WY89xJIluGb/w9FZqguV3iWG3bRH65X04Dadb
         qzO177w0pc3bGR56tSE8RUidHPx3u+t6xfFJ+PuSVZ892XSHj5W6QGTfKMDuKJ2dTnYk
         GNxkbGGmd0Q+nmf0EZp8Cp7YP9qGmukUEInklfn82CbgQngKm+lia/bfxGcSvmC6ipb8
         75Xg==
X-Gm-Message-State: AOAM532Cs5tjFf/kydFL0R+37gaLeHAJvcxID2M1rikE9WH9vshTsUbw
        huI10XmaSE755NmezgFHzCTNgnJGay+s5ZvrzJ5HQg==
X-Google-Smtp-Source: ABdhPJwceROlM/J+gcX8bdiLPx6fB+dXVBx+SaQApC/tM6DP7THNOu8RiO/PGMgmQckhTPLPtliHgY5LOKs+6W4+K/Q=
X-Received: by 2002:ab0:74c1:: with SMTP id f1mr1418132uaq.85.1616057948112;
 Thu, 18 Mar 2021 01:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com>
 <5359503.g8GvsOHjsp@mfick-lnx>
In-Reply-To: <5359503.g8GvsOHjsp@mfick-lnx>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 18 Mar 2021 09:58:56 +0100
Message-ID: <CAFQ2z_MavgAGDyJzc9-+j6zTDODP7hCdPHtB5dyx-reLMSLX3Q@mail.gmail.com>
Subject: Re: Distinguishing FF vs non-FF updates in the reflog?
To:     Martin Fick <mfick@codeaurora.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 10:22 PM Martin Fick <mfick@codeaurora.org> wrote:
>
> On Wednesday, March 17, 2021 9:06:06 PM MDT Han-Wen Nienhuys wrote:
> > I'm working on some extensions to Gerrit for which it would be very
> > beneficial if we could tell from the reflog if an update is a
> > fast-forward or not: if we find a SHA1 in the reflog, and see there
> > were only FF updates since, we can be sure that the SHA1 is reachable
> > from the branch, without having to open packfiles and decode commits.
>
> I don't think this would be reliable.
>
> 1) Not all updates make it to the reflogs
> 2) Reflogs can be edited or mucked with
> 3) On NFS reflogs can outright be wrong even when used properly as their =
are
> caching issues. We specifically have seen entries that appear to be FFs t=
hat
> were not.

Can you tell a little more about 3) ? SInce we don't annotate non-FF
vs FF today, what does "appear to be FFs" mean?

But you are right: since the reflog for a branch is in a different
file from the branch head, there is no way to do an update to both of
them at the same time. I guess this will have to be a reftable-only
feature.

> I believe that today git can do very fast reachability checks without ope=
ning
> pack files by using some of its indexes (bitmap code or https://git-scm.c=
om/
> docs/commit-graph ?). It probably makes sense to add this ability to jgit=
 if
> that is what you need?

The bitmaps are generated by GC, and you can't GC all the time. JGit
has support for bitmaps, and its support actually predates C-Git's
support for it. (It was added to JGit by Colby Ranger who worked in
Shawn's team).

I expect that the commit graph doesn't work for my intended use-case.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
