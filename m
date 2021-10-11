Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A355C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5FF60EB1
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhJKQEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhJKQEc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 12:04:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F8FC061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 09:02:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c4so11644158pls.6
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f85vRKaK0zXI0wL5HCiec3liDWKSRjlLHTQESITNuLg=;
        b=MNUFd6mGn4rVFBhsTIzyyeeptVrrQVrNGmGlHejx4vK+wtHCsWqMXeFX+7Jr6NlaH6
         V/U9h9g1SVGoR0qFH/G2dDNdK/vjTwenNZT0uaMxnu1KviDZIsP+zP3Uszi580SGJx2x
         bJiMmZZNyp6dQq2CmjweXjZUSUoAFBOkn7k5gs5RTLPYBklTDVRgJHzSKAlcwAc6xj5g
         BrMhXqu7BdpaUvZFaI8XO2bMvhJkvVRS9QYAGVtrgRCQ7wPtMo5xf5ncPw/aQMgQkfy7
         j8EUIZ1XBKCqg1157lpp+rbFOwPY2daSco2Wj8EzA5nBzQbhpOyvrTp08hUGA+Pczqti
         d/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f85vRKaK0zXI0wL5HCiec3liDWKSRjlLHTQESITNuLg=;
        b=6opT+kpekpmoYv9hO2eDaVEy05Q7+bzgyzXf/762U9IfNDA8NzcILYY1TKkOZH/HT8
         vZB+vN+2Dogw9Q2oLGcY0ncawuGYNYQx8V313RsXvkB5yhRXNalcfSSR6Hj7x1Izw/9T
         L5pfbsF+IzyfDfD0royYdaO5hgO8GDc8n5yU+5VE3WRyqmZk89Lxczy+KcWwchEH1Zws
         pVoZXa4ffuez3yLAEq08hfbeec/IfTAQxQ45/j4tmKeZqL2/ojPNJm21gUPZ7Sht91zG
         uSy8kaiVwSxQWPVuCdNCXv4QrriuKofxjYGJ7nPequORk68i4+5jiH2tFIvmFNALu8An
         CSVg==
X-Gm-Message-State: AOAM533gVAVat+HHYg4zZGMnqvrnmBwaR+OtREbn7k2SZflhEhCTF3ON
        CW9Fg5TPVVeQLMcazb1PYjMuYPIXDCRC8Sp4BcFnlQLn6zI=
X-Google-Smtp-Source: ABdhPJwKVub6IEURX1pj3hSELC/Iz3/hoHsNCMjpCAZykupLhUZ5lRc+0wdQ3WhXaaaX2EQFveyLJzqOhMUZSuOlqYo=
X-Received: by 2002:a17:902:ea05:b0:13f:4b5:cda2 with SMTP id
 s5-20020a170902ea0500b0013f04b5cda2mr25251473plg.86.1633968151561; Mon, 11
 Oct 2021 09:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <e257c62e-edff-f559-95e7-374b623a3f61@zoho.com>
 <CAP8UFD1_2g84epP+qjP2QW2g2bzdWcepPE60rY2vdKpTZFdEDg@mail.gmail.com> <a12adb98-d8c1-cd36-1760-343360a9ba85@zoho.com>
In-Reply-To: <a12adb98-d8c1-cd36-1760-343360a9ba85@zoho.com>
From:   Daniel Knittl-Frank <knittl89@googlemail.com>
Date:   Mon, 11 Oct 2021 18:02:20 +0200
Message-ID: <CACx-yZ06b8drep=MqBS=9Vf2fNLmUXh69VpZg4pdxtHDb7cxrQ@mail.gmail.com>
Subject: Re: I just want the revision
To:     ToddAndMargo <ToddAndMargo@zoho.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That seems to be the commit subject. One simple way would be to use
git log in a clone of the repo:

    git log -1 --pretty=format:%s origin/master

You can also use git cat-file to get a bit more output (commit id,
tree id, author and committer info, full commit message):

    git cat-file -p origin/master

HTH
Daniel


On Mon, Oct 11, 2021 at 12:09 PM ToddAndMargo <ToddAndMargo@zoho.com> wrote:
>
> On 10/11/21 02:45, Christian Couder wrote:
> > Hi,
> >
> > On Mon, Oct 11, 2021 at 4:57 AM ToddAndMargo <ToddAndMargo@zoho.com> wrote:
> >>
> >> Hi All,
> >>
> >> I am trying to write a script to tell me the latest revision
> >> showing on
> >>
> >> https://gitlab.freedesktop.org/spice/win32/spice-nsis/-/tree/master
> >>
> >> which is 'virtio-win: rebase on 0.164", but I can only see this
> >> from a web browser, as the page is dynamic.
> >>
> >> I do have access to the git link on that page:
> >>
> >> https://gitlab.freedesktop.org/spice/win32/spice-nsis.git
> >>
> >> Does git (or some other) have a way of telling me
> >> JUST the revision without having to download the turkey?
> >
> > If you just want the commit ID, you can use for example:
> >
> > $ git ls-remote
> > https://gitlab.freedesktop.org/spice/win32/spice-nsis.git
> > refs/heads/master
> > f6ad44f35f5caeec51b7002169977272d85701a3        refs/heads/master
> >
> >> If I could get something that contained
> >>          virtio-win: rebase on 0.164
> >> I could dig out the revision
> >
> > You might also want to take a look at the GitLab API docs, for example:
> >
> > https://docs.gitlab.com/ee/api/commits.html
> >
> > Best,
> > Christian.
> >
>
> Hi Christian,
>
> I do not mean to be dense, but how do I get
> "virtio-win: rebase on 0.164" out of:
> " f6ad44f35f5caeec51b7002169977272d85701a3  refs/heads/master"?
>
> Perplexed,
> -T



-- 
typed with http://neo-layout.org
