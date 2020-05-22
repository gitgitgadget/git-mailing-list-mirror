Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56441C433E0
	for <git@archiver.kernel.org>; Fri, 22 May 2020 15:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C8A208A7
	for <git@archiver.kernel.org>; Fri, 22 May 2020 15:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkmIR0ST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbgEVPg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 11:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbgEVPg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 11:36:28 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2088C061A0E
        for <git@vger.kernel.org>; Fri, 22 May 2020 08:36:28 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id s198so9646532oie.6
        for <git@vger.kernel.org>; Fri, 22 May 2020 08:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/G3tt6aUljBwxvOkbpBdb61wsZnX7pwgWNdnrHe7okc=;
        b=IkmIR0SThjzyxVS66AfhCTVc7tZjitW/ORTjPiO3eQUj/T2lUN7EcPNvsW8LcKi3gZ
         ny7kNBTApsv0unlcJxYtellBb5tLGU2FwkZIs5yLNswKJm48r9SaWqhzP8JkHwGfQoUY
         Orz04+D2mjCvK5YdK6OjiT6N9tdNsAG3ugyJfKNjHXl1vM7JHn4GMPzMIgZjFJ5VNV+x
         BpUA1rVOPjXSnd38f9nq49E0yCW3E5I5COwFSWkYbWqofKgWzD0598ExHXx0dS3lKkFD
         1R2eH4QBdzHwPbxfbLqKAO8/2nf6L3rWL5qO9Bndr+Y/R69ZkkyiQwTGCurjS0EW0RWU
         5Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/G3tt6aUljBwxvOkbpBdb61wsZnX7pwgWNdnrHe7okc=;
        b=Mgd7nbKz9ypTgu3tnx90oUsyo+J5JEFN9gBEKC0FZ3SSY2bt/XCBrxPB2CjVhI3wYi
         VEaCcFfSRJvziiiKRpDKkwTVP6Y4R8qx+ZjS8OPhGG0E9tUgX+BYIvkovG4TZBKnMGII
         V2cdhq6oKHKs/RsPGVE6JuGABN1zBWBDfUzSd6sUu9xkFUkPHdA6UVmPsRDmLuuBM030
         16mGGZLXkIDTFmPcKtYp8qgFNf/7qqlJ70lCulHzz3N2KSOLHF1CICC+og1tkOpAzhNA
         Ha0dYUjw4iETW1G2MM/CdRRaUvY/20OqB09Mkv5e2vg3M7U3UbehhjUKjcxY48SCffrv
         BbMw==
X-Gm-Message-State: AOAM532SRggNYPueou2ho2NqLuujB/v3VMT8LXcs52CeaGBqFVm3Si9w
        bcZxXyfQyoG6YMsDgbwR3sIhjeGvba6r9WC8g9s=
X-Google-Smtp-Source: ABdhPJwsZU6w51W7yFAkxJ8eSmyTjTCZj8Mj8+UZbC0xNDjvxmtLrRYkgcp3MX1AzAOu0InSaOGkQsjRr2/J7gqd9+A=
X-Received: by 2002:aca:2b04:: with SMTP id i4mr3105277oik.39.1590161787811;
 Fri, 22 May 2020 08:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW7_6+Jv+SQG3qh8eRjwJmqnRJKs=_bAV3WaC4-SKkoywg@mail.gmail.com>
 <20200522142611.1217757-1-newren@gmail.com>
In-Reply-To: <20200522142611.1217757-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 22 May 2020 08:36:16 -0700
Message-ID: <CABPp-BE6M9ATDYuQh8f_r3S00dM2Cv9vM3T5j5W_odbVzhC-5A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 22, 2020 at 7:26 AM Elijah Newren <newren@gmail.com> wrote:
>
> Hi Matheus,
>
> On Thu, May 21, 2020 at 10:49 PM Matheus Tavares Bernardino <matheus.bernardino@usp.br> wrote:
> >
> > On Thu, May 21, 2020 at 2:52 PM Elijah Newren <newren@gmail.com> wrote:
> > >
<snip>
> > Does this seem like a good approach? Or is there another solution that
> > I have not considered? Or even further, should we choose to skip the
> > submodules in excluded paths? My only concern in this case is that it
> > would be contrary to the design in git-sparse-checkout.txt. And the
> > working tree grep and cached grep would differ even on a clean working
> > tree.
>
<snip>
> Anyway, the wording in that file seems to be really important, so
> let's fix it.
>

Let me also try to give a concrete proposal for grep behavior for the
edge cases we've discussed:

git -c sparse.restrictCmds=true grep --recurse-submodules $PATTERN

This goes through all the files in the index (i.e. all tracked files)
which do not have the SKIP_WORKTREE bit set.  For each of these: If
the file is a symlink, ignore it (like grep currently does).  If the
file is a regular file and is present in the working copy, search it.
If the file is a submodule and it is initialized, recurse into it.

git -c sparse.restrictCmds=true grep --recurse-submodules --cached $PATTERN

This goes through all the files in the index (i.e. all tracked files)
which do not have the SKIP_WORKTREE bit set.  For each of these: Skip
symlinks.  Search regular files.  Recurse into submodules if they are
initialized.

git -c sparse.restrictCmds=true grep --recurse-submodules $REVISION $PATTERN

This goes through all the files in the given revision (i.e. all
tracked files) which match the sparsity patterns (i.e. that would not
have the SKIP_WORKTREE bit set if were we to checkout that commit).
For each of these: Skip symlinks.  Search regular files.  Recurse into
submodules if they are initialized.


Further, for any of these, when recursing into submodules, make sure
to load that submodules' core.sparseCheckout setting (and related
settings) and the submodules' sparsity patterns, if any.

Sound good?

I think this addresses the edge cases we've discussed so far:
interaction between submodules and sparsity patterns, and handling of
files that are still present despite not matching the sparsity
patterns. (Also note that files which are present-despite-the-rules
are prone to be removed by the next `git sparse-checkout reapply` or
anything that triggers a call to unpack_trees(); there's already
multiple things that do and Stolee's proposed patches would add more).
If I've missed edge cases, let me know.


Elijah
