Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6289EC05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 09:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjATJf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 04:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjATJf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 04:35:26 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B596C122
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 01:35:20 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9so4833589pll.9
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 01:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cdqQ++0oDk8Z3WJS6/6EkzxUIGwigC86XyzWo5J0ldc=;
        b=XtVbLRiMUFL8ccM3rkmxyfcFFVG+sq4FB3tOiWkPiBOd48eVLRS8FHieySKa6pMPb8
         j5bt55Dj5ByZpD0PNq08RiefKJNnOz9GPmvM8FF3RkNfHLH/ujafL2G1g+yFJ0NQKeen
         nmUaZhS6gSmuWsS0RaFzb3R3AZVMo2gtsDw15n4wywzDQ3ApIYKW/wuy2UST7Qy5rrlM
         /n1DsyOiSdrrXZqnegOIMinsA/32Pxcct1BqZCIpd16pBfOjNCAEKA1d+jG6e+70atEG
         NNvM+LAbpV9YBkp5W1rRQM/838UH906xYi+sk3IAzaQjxIWgk33xN9OiVfLh1Vsxy21D
         j5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdqQ++0oDk8Z3WJS6/6EkzxUIGwigC86XyzWo5J0ldc=;
        b=TXdZ4EN0jtZgkO+TH5pJSawWWzEmbDuBMLV2Oxq0ca4FfcoD4r9bseem/K1JlY1C8R
         63UIpUDZNJ6zDV9dvjAClXydLys3uFDD2jI3Dj5wEwAd9k5Qcq8QP/FsBTr9WkcT8P6J
         cgOIYx/qz7BDs7TMCpreZOpKss/genmx89eJzq87+NbKXjlnIW8wcFjHMEdbdi/vHFx/
         5MNI1+U1N6OjZ+qO4IcfsTQaNlxnOoUNkF3HkqcTug0shz88O1LP4scGA+bl7MRphSco
         ZAe6XcFOe6POCzW1R/7XPft5yUnngszNIeRVW+WKDU1896l/R97kSxEbfPv9ZDrwIWp2
         K9SA==
X-Gm-Message-State: AFqh2koUekYDxZu9E1sjW9+6f4fk9qY5zmAbwL+sNG42ebI6qV5Z5H7e
        iDtKRJkN3M16cdknFYvMeBh2icjka5o2ysnopHY=
X-Google-Smtp-Source: AMrXdXvHbaVPq2nnaghJ7kh4pANOA3ybQZbk6AO+vtKNUs1k2wCUiHD4WYMO3ckrfbLqxZTzMT0O1sIzYSpjTZw9Ec8=
X-Received: by 2002:a17:902:cf0e:b0:189:7441:1ada with SMTP id
 i14-20020a170902cf0e00b0018974411adamr1369562plg.13.1674207319589; Fri, 20
 Jan 2023 01:35:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
 <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com> <cde4827da13a1391501057ee42655836f0ccd337.1674149666.git.gitgitgadget@gmail.com>
 <CABPp-BEC4PmQfYT=UhtbJ5QcXXMqwF1e-KvSVVDNjDy69bGH5w@mail.gmail.com>
In-Reply-To: <CABPp-BEC4PmQfYT=UhtbJ5QcXXMqwF1e-KvSVVDNjDy69bGH5w@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 20 Jan 2023 10:35:08 +0100
Message-ID: <CAN0heSoVguXpGC4PMsvh8CedwSvxu8A=iG2hT8Szxdq2ivh9rw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs: fix sparse-checkout docs link
To:     Elijah Newren <newren@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 20 Jan 2023 at 06:29, Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Jan 19, 2023 at 9:34 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> > So fix the format of sparse-checkout.txt, and link it in the
> > Makefile to correct that.

> > -0. Behavior A is not well supported in Git.  (Behavior B didn't used to
> > -   be either, but was the easier of the two to implement.)
> > +Behavior A is not well supported in Git.  (Behavior B didn't used to
> > +be either, but was the easier of the two to implement.)
>
> Why did you remove the numbering on this, though?  If asciidoc doesn't
> like starting with 0 (the only guess I can think of for why you'd
> change this), shouldn't the series be renumbered starting at 1 rather
> than removing this from the list?

It looks like the zero causes both asciidoc and Asciidoctor to emit
warnings (one per item, since each item's number is off by one). They
also helpfully relabel everything starting at 1.

I agree that there's a better fix here than dropping the 0. Either
renumber everything or, probably better, just use "." for each item
rather than "1.", "2." and so on. The right numbers will be inserted
automatically. This also means that if an item is ever added earlier in
the list, we won't need to update all the numbers below that point.

(The numbers being generated automatically means we can't refer to them
("see item 2") without potentially getting out of sync, but that is true
regardless if the numbers are corrected for us, as now, or if we just
use ".".)

The contents of these list items could be prettified in various ways,
but I'm not sure what the status and goal is for these technical/
documents. Avoiding warnings in the build process, as ZheNing aimed for,
seems like a good idea regardless.

Martin
