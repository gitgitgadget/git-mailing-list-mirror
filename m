Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48130C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 19:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4B920A8B
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 19:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZYsLGJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgHCTHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCTHb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 15:07:31 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391DDC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 12:07:31 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id i129so2420099vsi.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 12:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=93tFTORx7rvZuwQ/fx7FzXpPfdWTR692zSH47sKGQ6Y=;
        b=lZYsLGJEAblD5UuAFwHUtOt7NLJhM9fk1xqVwVKJN4lSD/dYXsTGhkAgSBaLyHXkoS
         uneDqL2Vw8jowYgGUTEp/PVLXW7pEr7iOgItgWVNS5c6pK7F8m0UIjp1ovKrdog1/H3A
         EvtNS7pbc/2AAvufbzL8ZeylveX6T4cw17pLyD8uhklvJDoOIV3CzBkWa4/mH7KqXxio
         kx1x2s3bdIigV2wl87L9byG2rlxucUKWk7z3zamD4VPF+f1funJoaa7Uqh66X5e2HfGw
         TWGJvCiR2RfMK3d7rgwLfGb6v3LTzKzV7zdPzDn7cu2g8oLhbV+Yy1guOlmamREGv9Jp
         68ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=93tFTORx7rvZuwQ/fx7FzXpPfdWTR692zSH47sKGQ6Y=;
        b=amab/coFHK3ZHhesgimyQngTrLxL2H12ly7D29yN2CZRfXykQO3mnzPFoDwEfEEYdn
         jhXi13tTz8ez2DCZBjvqK63hmmk6ns/U0fmcZXCnUpH+sLB7srxCCU7xif8DN5ikX69H
         b3VPRCQv8dg/fUt0Zg6NtJAwJTlbkKSsuq+iOOWP7RihrUXJ/Rz76NMIScUWN7VkX0ri
         69NoBf9HUSXQbhzIqpS14i8XROXFFPN8FRIhf73D4sx0/t6Z7J6fHBVfJJgdNeJJB2L1
         oXW1UmasU6msqCsLxe2vBz17Ombx1MRjjORcItgDy6iVNM4vyITGipIURAQeoFfJQGY0
         ijqg==
X-Gm-Message-State: AOAM532FbmBSOYpkSkZuShjuZwy5Vpi/Bc+vpjwoOyYUBugdFZHgnayx
        zpHitK21n+QO7xLxA3udPPPOFX1iZCglmRDfoagA1A==
X-Google-Smtp-Source: ABdhPJzhjYcRYqe7vgSj1DTvg+sNhQJ8wU1IRESt7vjttt+q0/s+FA7c+dnO0mMRnlAONs3zgegf1pKrFqvrH3925A8=
X-Received: by 2002:a67:61c1:: with SMTP id v184mr9023526vsb.56.1596481650247;
 Mon, 03 Aug 2020 12:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
 <pull.673.v3.git.1594925141.gitgitgadget@gmail.com> <xmqqwo33f6xb.fsf@gitster.c.googlers.com>
 <CAFQ2z_P+L5ystTA8MjSjnUJQyEoH5Q3QtnMd0ezJpKPv_ntrgA@mail.gmail.com> <xmqqpn8hgca7.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn8hgca7.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 3 Aug 2020 21:07:18 +0200
Message-ID: <CAFQ2z_O1sRm-_SNP=-GvgNLqB+qgf6k9YVfbF1XCAmFWdeX6Ew@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Remove special casing for PSEUDOREF updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 27, 2020 at 6:20 PM Junio C Hamano <gitster@pobox.com> wrote:
> > On Fri, Jul 17, 2020 at 12:10 AM Junio C Hamano <gitster@pobox.com> wro=
te:
> >> I reviewed some codepaths that deal with FETCH_HEAD recently.
> >>
> >> As the file is quite different from all the other pseudo references
> >> in that it needs to store more than one object name and in that each
> >> ref in it needs more than just the object name, I doubt that it
> >> makes much sense to enhance the refs API so that its requirements
> >> can be covered.
> >
> > I agree. Do we ever pretend that FETCH_HEAD is a ref today?
>
> "git rev-parse FETCH_HEAD", "git show FETCH_HEAD" etc. all should keep
> working, so in that sense, it is treated as a ref.

I added this to the last version of the full reftable patch series
that I posted,  as patches
"Split off reading loose ref data in separate function" and "Read
FETCH_HEAD as loose ref".

Which other refs that aren't really refs should also be supported? The
JGit source code suggests that MERGE_HEAD should also be special
cased?

It's not pretty, though. The entry point is read_raw_ref(), which gets
a ref_store as argument. ref_store doesn't have generic API to get at
the repository directory, so the implementation of reading the
FETCH_HEAD file has to be pushed down to the ref backend (which does
know the directory).

> It does not
> protect the history leading to the objects listed in it from being
> collected, though.

Is there documented agreement of how pseudo refs and GC should interact?

> "git merge FETCH_HEAD" is an interesting case---I haven't thought it
> through.
>
> What should happen after "git pull origin foo bar" attempts to grab
> two branches and make an octopus merge into the branch currently
> checked out, and then "git reset --hard && git merge FETCH_HEAD" is
> given?

I don't understand this question.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
