Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E39B21F453
	for <e@80x24.org>; Thu, 31 Jan 2019 07:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfAaHvZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 02:51:25 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35142 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfAaHvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 02:51:25 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so2540264qtc.2
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 23:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CyUsk3jy9Dw98VdJnvlpoG8iP9l0zLF38pV+CQqVJ6w=;
        b=EvqAlwL3cQXXB6Lszc3SykaIY3b4iq6qQSMgIWKtP9fLZ6P/SQuF2w2KIeCZTd7CkV
         iZ6DDfDlyAZOFcyiKO3VqkCdMF65FwrC25d7AnoDYDGuZpPrShouITR4MjeVw73IAarI
         sWivTPfdy3NCLW6lwo950Ycizxh+GqRtplAvr5673u7M/x7lZkOXGExeeFasRm24f8io
         91DSJ99aB+Ln92F13KNJobrlrT/tAqN2Sm+qsgIVO5ENOe7sXDcOQVOPzBREjgFQfkjp
         njJ5ZamxFOANiN39P5Xx2oHjxL4ofGy8Zobt6ZHrikH07t0rLP1+NA2MaicJH4BdxIuI
         wCzw==
X-Gm-Message-State: AJcUukdUt+D6lvaWDmLM5fY+gvovzZgNIKp+N2Se2G87XOEjHW8eFltz
        Nk7DK5S34kJ9zy9Xu2gxyHlRaEz43/NyBWwvL9c=
X-Google-Smtp-Source: ALg8bN57OtInkldK0aLWO9oRUw8JMVyGAZjggU8l1xWYvHdz3JhbRS/516jNf5YS8lGWo3vYcuHJ8bmsNeRMHx8rxag=
X-Received: by 2002:ac8:90c:: with SMTP id t12mr32509194qth.335.1548921084778;
 Wed, 30 Jan 2019 23:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20190130094831.10420-1-pclouds@gmail.com> <20190130094831.10420-9-pclouds@gmail.com>
 <CAPig+cQ3L4NcMojWYV3spazJNzEa6yhBJQ0wwbwcLSzG3Vmzjw@mail.gmail.com>
 <CACsJy8BKxf6Q1Q-u92enPgw6a18XhAOvYSewZs-G+tB+-MSkNw@mail.gmail.com>
 <CAPig+cS4Dmgh+hCMXp8ND5DMy6QFVCJOgvDwpcbwZ0HV4MscpA@mail.gmail.com> <CACsJy8C2fx-+NxS+ahmmHDgLrwtyiCV6WEEfpmYwfcPM3kYVvA@mail.gmail.com>
In-Reply-To: <CACsJy8C2fx-+NxS+ahmmHDgLrwtyiCV6WEEfpmYwfcPM3kYVvA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 31 Jan 2019 02:51:13 -0500
Message-ID: <CAPig+cRpxXA1uv_OqX9R9h6auBWE5=iS8CsxdB4qS6VaEqUadA@mail.gmail.com>
Subject: Re: [PATCH 08/19] checkout: split part of it to new command switch
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 2:44 AM Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jan 31, 2019 at 1:25 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > I find, however, that the top-level git-switch "DESCRIPTION" section,
> > which talks about "switching branches" doesn't actually ever explain
> > what it means to "switch" to a branch. Even adding a simple sentence
> > stating that "switching to a branch means that a newly-created commit
> > will be a direct child of the current head of the branch, and that the
> > branch will be updated to point at the new commit" would help cement
> > the meaning of branch switching in the reader's mind (rather than
> > assuming the reader understands that implicitly).
>
> Thanks. How about this? I skipped the "update branch to point to the
> new commit" ...

I came to the same conclusion (about dropping this bit) upon
re-reading what I wrote.

> DESCRIPTION
> -----------
> Switch to a specified branch. The working three and the index are also
> updated to match the branch. All new commits will be added to the tip
> of this branch.

Yes, this is good. Simple and direct. A couple minor fixes:

s/three/tree/
s/also//
