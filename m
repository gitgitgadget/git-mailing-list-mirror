Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CF6C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 22:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BFA76112F
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 22:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbhIGWtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 18:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhIGWtl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 18:49:41 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1985C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 15:48:34 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v2so519414oie.6
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 15:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7R4ymXiw5r3Btqjo+UolaUjyaiNjGtecADYcrLlAybk=;
        b=NQGWpWIGhLyMudYXKxD5Qa74kUduoookr48e8Za/UhR6rC526mRAdVKN9INpE3ho5K
         2wirPXPf9RmdP6z0XC2TjZM4wqhjFfFtZHaFLnwRbpAmhDftmhYyCmU7Di//2KhkbbQW
         1V5uzRlo1Ux6OYbRt61jRI2GKr7EgUt77jv/ZnQaKjbW2mgEORawJ72oKTKQbPClGQxc
         tmLLEUFXZdbLt3uYtaDAw9NdPlVhv2NaOJe+h9dtB9d5l2l7HKwab1bkrXMU7JelZTG9
         75LPUDJkHR93z0djuNSDmlUjAiR9aJZZ/yoMDhd/dbEEkYhI+MYgGZJFIEw4BjebbuZg
         +rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7R4ymXiw5r3Btqjo+UolaUjyaiNjGtecADYcrLlAybk=;
        b=onmuDkUOsdQtP6aAsFscwh2Io+mhm41qOy1w/QbHz7Si0HM5btIn96X1sqKfmNSP11
         rMnII2CWsV1khHJIdUvv3rtvgnkDB0s9bodWtkznj/k1CY7edBet3etnos8TG3VKDqoW
         3OD4g8wYLcOXHIqF1oshAI/T0xxh2pE+1OEE31xCU4L1K7iZnKvCybuaHVyF0Ivda43a
         RsXApR6Of380TZK74H2I2DoTm4MGjwg6Yiii3w3owbtsrl8y2qivwSfhm2efrkzfIJ1J
         UdYeMj4Et6mnhFhyjFCHphP/bSFT8yS1C2DA+k28yJdEjlDcHVToMEqdSyt4Stpf0Vj8
         Uk0w==
X-Gm-Message-State: AOAM531vqHL6PfZgZYoZIi2+IRoLL7ukVLluEAP2BbyKMdum8n0BRSwg
        UuVQJF5xsCCtdcODs9GOw5unuOhaCuhO6W1UXiw=
X-Google-Smtp-Source: ABdhPJw0bx/kOr6BN+YsmPqHbqqzHtOuPkXQ743izEeRuruS6GmLH1snFECrKVenwyetEcU5AWbHR0ZFVlbTg5rXsXo=
X-Received: by 2002:a05:6808:2084:: with SMTP id s4mr316211oiw.31.1631054913924;
 Tue, 07 Sep 2021 15:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> <xmqqk0k0ndbq.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2109021616300.55@tvgsbejvaqbjf.bet> <4e998676-4975-8ac2-35a0-34416938b62e@kdbg.org>
 <nycvar.QRO.7.76.6.2109071930080.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2109071930080.55@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Sep 2021 15:48:22 -0700
Message-ID: <CABPp-BFZfa7cchRTycdyMbnwb_f=vHxQYLA5QswuM0ExfxeMAQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Drop support for git rebase --preserve-merges
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 7, 2021 at 11:51 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Hannes,
>
> On Thu, 2 Sep 2021, Johannes Sixt wrote:
>
> > Am 02.09.21 um 16:18 schrieb Johannes Schindelin:
> > > On Wed, 1 Sep 2021, Junio C Hamano wrote:
> > >> A good goal.  There is no remaining use case where (a fictitious and
> > >> properly working version of) "--preserve-merges" option cannot be
> > >> replaced by "--rebase-merges", is it?  I somehow had a feeling that
> > >> the other Johannes (sorry if it weren't you, j6t) had cases that the
> > >> former worked better, but perhaps I am mis-remembering things.
> > >
> > > I think that I managed to address whatever concerns there were about the
> > > `--rebase-merges` backend in the meantime.
> >
> > That was either my suggestion/desire to make no-rebase-cousins the
> > default. That has been settled.
> >
> > Or my wish not to redo the merge, but to replay the first-parent
> > difference. The idea never got traction, and I've long since abandoned
> > my implementation of it.
>
> Thank you for clarifying.
>
> Yes, I remember how that idea came up, and I even tried that strategy for
> a couple of merging rebases of Git for Windows' branch thicket. Sadly, it
> did not work half as well as I had hoped.
>
> The best idea I had back then still is in want of being implemented: sort
> of a "four-way merge". It is basically the same as a three-way merge, but
> allows for the pre-images to differ in the context (and yes, this cannot
> be represented using the current conflict markers). Definitely not
> trivial.

merge-ort opens a new possibility (since it does merges without
touching the index or working tree): Take the merge commit, M, that
you are trying to transplant.  Hold on to it for a minute.  Do what
rebase-merges does now; namely, do a simple merge of the desired new
branches that otherwise ignores M to get your new merge commit N.
Hang on to N too for a minute.  Now use merge-ort to auto-remerge M
(much like AUTO_MERGE or --remerge-diff does) to get a new merge
commit that we'll call pre-M.  If M was a clean merge that the user
didn't amend, then pre-M will match M.  If M wasn't a clean merge or
was amended, then pre-M will otherwise differ from M by not including
any manual changes the user made when they originally created M --
such as removing conflict markers, fixing semantic conflicts, evil
changes, etc.

Now we've got three merge commits: pre-M, M, and N.  (Technically,
pre-M and N might be toplevel trees rather than full commits, but
whatever.)  The difference between pre-M and M represent the manual
work the user did in order to create M.  Now, do a three-way
(non-recursive) merge of those commits, to get the rebased result, R.
This operation has the affect of applying the changes from pre-M to M
on top of N.

There's obviously some edge cases (e.g. nested conflict markers), but
I think they're better than the edge cases presented by the
alternatives:
  * the first-parent difference idea silently discards intermediate
changes from reapplying other patches (especially if other patches are
added or dropped), which to me feels _very_ dangerous
  * the current rebase-merges idea silently discards manual user
changes within the original merge commit (i.e. it hopes that there is
no difference between pre-M and M), which can also be lossy
  * I don't think this idea drops any data, but it does run the risk
of conflicts that are difficult to understand.  But I suspect less so
than your five-way merge would entail.

If the difficulty of conflicts in this scheme is too high, we could do
a few things like providing multiple versions (e.g. if either
pre-M:file or N:file had conflicts, or maybe if R:file has nested
conflicts, then place both R:file and N:file in the working tree
somewhere) or pointing at special commands that help users figure out
what went on (e.g. 'git log -1 --remerge-diff M -- file').
