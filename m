Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5857EC433EF
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 22:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhLaWZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 17:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhLaWZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 17:25:58 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD99AC061574
        for <git@vger.kernel.org>; Fri, 31 Dec 2021 14:25:57 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x15so112755045edv.1
        for <git@vger.kernel.org>; Fri, 31 Dec 2021 14:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=96aItz+XaQ+egzMd5Tj7DNXDYV0/WPeTZfgzIOjxA2U=;
        b=XDha/mcr3mNSdNG9sIs7xW2pAt7YNED5LsNyBE359Y3C28serVvIOsofWSkN0LgsIY
         WlXwlV0AD1fpuK2dF/84mw/JjpGWR8KfC3/8UnWYc+iqm8HsVqKb1YtWizmbcYseiaX8
         meGFsouYaWb4dfrEgJZ9yYW1uJ8fZQxlxASbWnZPTtSC7WwR5SyWMs5DlF3BaJzjpUVp
         NM6iIqyLzvm4Hpkt9fnaqGNTOKQzNRoAx9MPlzuYA8BDAxMeVJTjiVVqhf8xuBsJUq8Q
         3ByvCYu97row7eIiK38Mn7K4/tSDLcDocG6EFR3dZ98XInJtEza6w90DUjBXMuQeUx6A
         c3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96aItz+XaQ+egzMd5Tj7DNXDYV0/WPeTZfgzIOjxA2U=;
        b=y0jnZ37B62tkRDIl8DWXdzM7yWVBTm3cbHp3NOrSS2X9NrOvFrqT1PSantnx18bT3l
         sfr25QL7RcHL7iDyJDcsppdK/vqLtG6W5mKVrCeo9ozjMtSxL7HJuKbLjpapMsNfwqnY
         SODz1f5+9gq5aR6ml5JvOyRAFUTud4ALeb130fKLvDrDPFUqK8kaMvu2g2YmeT7G/kXf
         G9sMkH/mBsTihbS1GjPAWBAwd4IJmmaU2eDNSC+0YkpBZ7ukcvguQ2Cge2jUIz893ddc
         N01wYwPLL9VQvurZrqFWouj0R0zRa8bcP44QAznPVw3d/iQSLu44mMsnpXOSr3H6JOdz
         ipvg==
X-Gm-Message-State: AOAM530nP6P2UUmeiOwihjzg535TZ3zT5dvPsC2IaVVRQx6eqCcAuw1m
        XzikzjPoChjSlONsytQmfATRiVItoUqiZn1Qhb6wgkbfXvU=
X-Google-Smtp-Source: ABdhPJygL4CI2kfSWfZSV0pysEyHUpNwI82dlx7PZ8NemBicKVgwyAce5lRuy8GrzWO2Y2ICkThcb5OUqddtNlRXJ2o=
X-Received: by 2002:a50:da48:: with SMTP id a8mr34967413edk.146.1640989556158;
 Fri, 31 Dec 2021 14:25:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com> <955fcab00528464b5450bd22b45c89ffc2283e39.1640892413.git.gitgitgadget@gmail.com>
 <CABPp-BGdr54XgCXw8k1xRCgkwBtDonyODS3O+_nS_QY3SOEFGQ@mail.gmail.com> <xmqqy240l8l1.fsf@gitster.g>
In-Reply-To: <xmqqy240l8l1.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 31 Dec 2021 14:25:45 -0800
Message-ID: <CABPp-BGKtggHwXF-Xo6ryKCXNq9mgWDHiKz6VfCvrdKxvf0Uug@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sparse-checkout: custom tab completion tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 31, 2021 at 2:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Second, and this item is unrelated to your series but your comment
> > made me realize it....sparse-checkout unfortunately ignores prefix and
> > creates a bad .git/info/sparse-checkout file.  For example:
> > ...
> > I think the loss of the current working directory will be fixed by the
> > en/keep-cwd directory (currently in next and marked for merging to
> > master), but the fact that the wrong paths end up in the
> > sparse-checkout file is unfortunate.  It basically means that the
> > `set` and `add` subcommands of `sparse-checkout` can only be safely
> > run from the toplevel directory.
>
> You made it sound as if this is a fundamental limitation, but it
> sounds more like a bug that needs to be fixed (outside the
> completion series, of course) to me.

Oh, sorry, I didn't mean to imply that.  I meant the same thing you
say here: it's another bug we need to fix, in a separate series.
