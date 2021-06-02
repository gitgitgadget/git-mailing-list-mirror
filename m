Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316DCC47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 05:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 093B56121D
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 05:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhFBFG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 01:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhFBFG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 01:06:26 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0189C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 22:04:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qq22so1873785ejb.9
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 22:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MArme3tWsF0EAjsAy+cMxAO2EHjOALcUXqpTfL90rmk=;
        b=l/PXo5GzE6EaJBJrYmtczMOdyUDPyjW/Tgz6lmO58g+PMBRw018cHPTWOji1BLKU4a
         NvWsy0KjvCl6fECx5Kgz8nRbVP3Y/Cj1RC5Q5QmJemCvqvZkFQWP7R2pR6ty6rDbSWVN
         5a1HKZlmuY5JuK+Jar7VJ+uWAYpxrrdWXKhyaXCY8hDrDRSz1cp+gEvmfCrcH/n0UuBk
         c+j7PxkNE1Sg2hjWz1A7TsncT367hsjImkro0ed2MA8U4WgdIC0RFTVCzSXS1TulagE4
         o//mOSTwe3ZEY2tx6Qvvcr7C70KiG2jIvAy0YVWEFTB27d56vsWUm60dmhaQjhmkkcUa
         R+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MArme3tWsF0EAjsAy+cMxAO2EHjOALcUXqpTfL90rmk=;
        b=AFHkkPNDDzA9da5ld3WWojX/Onw/1sG1cK0OxP10W4RCmFLYmdzAfhM1NY8ZO6fAKA
         tp90ssplamVqle/j9KLypavFgBgFLjskC+VSeLI8ugZqDO8jcBMzptbQuCHuPzSrrp9d
         zpFv93ItycOC+P5YaGUJXInb0z1B/Ng6MG4D9KslT+u55tpU56m4lOYyxxYNcSqTaiax
         aMw6ytn48j1Q4mjZdoBtK9mPBtPimeIWKxEowLU/MXTn3gj3ElS+ItgaZfGNaC2ioMVJ
         WAUQWNAyKhxqIseoGMgeIL5zIzp3Kr9KZNqpMDtOlV/oWj3pS/zsKPgTkXZrPgbS9r1V
         QEeg==
X-Gm-Message-State: AOAM532m95qLBgN3hEs8Q2FI2SWNJjLfDMtqXb2VU2fOkh8JpIXn0VzW
        2AwtEHa+y+mp9ignVMIDc0UBenGyNkDLQP/EbLdrOA==
X-Google-Smtp-Source: ABdhPJwnrbX6YbBi7YzSbh9yItsjpgDEJe+pNvneryfE66eh9BRkJ3u/sCvIHh+xdD3zuLnAUmgpvHByTQD88V8ntf8=
X-Received: by 2002:a17:907:6ef:: with SMTP id yh15mr8209753ejb.151.1622610281252;
 Tue, 01 Jun 2021 22:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoim38J3=4pd0_fM2h=DN_PrEE_Osg2duU5Ur8WUZ5S1Pg@mail.gmail.com>
 <032cabb2-652a-1d88-2e12-601b40a4020c@gmail.com> <CAPMMpohOuXX-0YOjV46jFZFvx7mQdj0p7s8SDR4SQxj5hEhCgg@mail.gmail.com>
 <0b57cba9-3ab3-dfdf-5589-a0016eaea634@gmail.com> <CAPMMpoi_XSLJXtxGD74r-uoao+Z6Xcg8xkXuZCYix4=tBWD8rw@mail.gmail.com>
In-Reply-To: <CAPMMpoi_XSLJXtxGD74r-uoao+Z6Xcg8xkXuZCYix4=tBWD8rw@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 2 Jun 2021 07:04:30 +0200
Message-ID: <CAPMMpoiReALTrn5R2VK6FK+15XgOJd-8r2rZsmQZXbH0R1kq+A@mail.gmail.com>
Subject: Re: Removing Partial Clone / Filtered Clone on a repo
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I understand replying to myself is bad form, but I need to add a
correction/clarification to a statement I made below:

On Tue, Jun 1, 2021 at 6:54 PM Tao Klerks <tao@klerks.biz> wrote:> >
it would be good to design such a feature to have other> > custom
knobs, such as:
> > * Get only "recent" history, perhaps with a "--since=<date>"
> >   kind of flag. This would walk commits only to a certain date,
> >   then find all missing blobs reachable from their root trees.
>
> As long as you know at initial clone time that this is what you want,
> combining shallow clone with sparse clone already enables this today
> (shallow clone, set up filter, unshallow, and potentially remove
> filter). You can even do more complicated things like unshallowing
> with different increasingly-aggressive filters in multiple
> steps/fetches over different time periods. The main challenge that I
> perceive at the moment is that you're effectively locked into "one
> shot". As soon as you've retrieved the commits with blobs missing,
> "filling them in" at scale seems to be orders of magnitude more
> expensive than an equivalent clone would have been.

As I just noted in another thread, there seems to be one extra step
needed to pull this off: you need to add a *.promisor file for the
initial shallow clone's packfile, because otherwise (at least with the
2.31 client that I am using) later "git fetch" calls take forever
doing something with rev-list that I don't understand, presumably due
to the relationship between promisor packfiles and non-promisor
packfiles...
