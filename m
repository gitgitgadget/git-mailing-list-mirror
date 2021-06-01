Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90318C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 23:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8A461351
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 23:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbhFAXyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 19:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhFAXyu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 19:54:50 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A88C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 16:53:07 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so891908otp.11
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 16:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=eCmeDBFFkBS5JSOs0E290PsCd8CkoCOlN4LfsXC/f4k=;
        b=rO9qxl2ptyCGK7P4nynTeyZqwZsu2RY+ICIVV5+ZP8hoDJACuQq5ly8MkmXUzdTqKa
         2W7kADQSQYx9QXSA/ThF8d+O+lhbJLo2rCn8mEjS3ut5wsRK+/yczGg/ih4Sl1yeW96s
         7/NckxWtVnANQfWgSjfXA8MllsXlBkdin/SHx1gTIvPB8MgLFxBnO7tvdrxNdp41I5Dw
         n+lNS7hMw5cnfEwBJRFKMDWUmMLo4TaI8BGcxIk3wOK8M7ishn/vb0s3A0v2pieghtUD
         MHXvIRYM6S5nBhui/mdgVuGeqe4ObxKA3v32xvwy5gal2Vtil1qG8ehPGqnv9AdJWWLj
         ctbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=eCmeDBFFkBS5JSOs0E290PsCd8CkoCOlN4LfsXC/f4k=;
        b=Ot8Wf6mPZf4hq9T+1IETW84QDU8EdwhGt76JFDPAS1UkJWjAHgvGGdYX2ObCx5Kdin
         wU4ivvLBfATT5IMF1QlR8SfNHHZnxf6BopzTETe+tBiJuub55ZPYIrQirqgrG+Nga00o
         g+M/cnvnglFv6L9pODU8rlu6Tw2crD901/9O9uudOlOI8aRcTSxs9UIkYR2HLmG3+Qpf
         g+GbHFk2sGB5yPoGIqagmuWjtzTgFRg7Z9xaBNfqMAFeRn8XI7Le3T1nytUKENTmksgE
         rW2X65jDSXg3uLyNLRgIU4ICJvLs5jFc+zvVsYs52ql8ExFiq5lXnVST7gEwcc6NMfKt
         W6Zw==
X-Gm-Message-State: AOAM532bMtn1qPzWkyreOFoBwjUB3q6SbmarpP01QL39gk0IEL9VOvck
        IU7UDLmM3+Ab725rNxzQMsk=
X-Google-Smtp-Source: ABdhPJyOJ/JbQIvpc0puq6ETAXqTmvqrGAdA7OyYuCrUBD20B0vptLp2D+Rhin5++IbVpD39ruSokw==
X-Received: by 2002:a9d:738b:: with SMTP id j11mr3611193otk.228.1622591586756;
        Tue, 01 Jun 2021 16:53:06 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r85sm1594139oor.38.2021.06.01.16.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 16:53:06 -0700 (PDT)
Date:   Tue, 01 Jun 2021 18:53:04 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>
Message-ID: <60b6c860e4a4e_40442081d@natae.notmuch>
In-Reply-To: <819f7ed4-ef38-32d4-2a64-a38ac37a5736@iee.email>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529071115.1908310-7-felipe.contreras@gmail.com>
 <xmqqv96zwkl0.fsf@gitster.g>
 <60b49a3ae829b_24d28208fd@natae.notmuch>
 <xmqqfsy1udf0.fsf@gitster.g>
 <60b62420858c4_e409520828@natae.notmuch>
 <a385c279-5902-40af-f54d-85b950bbb497@iee.email>
 <60b661d5ee7cc_3c4208c1@natae.notmuch>
 <819f7ed4-ef38-32d4-2a64-a38ac37a5736@iee.email>
Subject: Re: [PATCH v2 6/6] doc: push: explain default=simple correctly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley wrote:
> On 01/06/2021 17:35, Felipe Contreras wrote:
> > Philip Oakley wrote:
> >> On 01/06/2021 13:12, Felipe Contreras wrote:
> >>> So it's more like:
> >>>
> >>>   centralized = ~decentralized
> >>>   triangular = ~two-way
> >>>
> >>> A centralized workflow consists of a single repository where branches
> >>> are typically two-way, but not necessarily.
> >>>
> >>> A decentralized workflow consists of multiple repositories where
> >>> branches are typically triangular, but not necessarily.
> >>>
> >>> So the triangularity is per branch, not per repository, and same_repo
> >>> means a two-way branch, could be a centralized or decentralized
> >>> workflow.
> >> My personal viewpoint is that triangular flow happens when you cannot
> >> push to the repo you consider as upstream.
> > It's not about permissions. Even if I had permissions to push to git.git,
> > I wouldn't do so. I do have permission to push to some public projects, but I
> > instead send patches/pull requests like everyone else.
> 
> I had it that if you don't have permissions then you definitely need to
> use a Triangular flow. Hence how I was presenting the view.

If you don't have permissions you have no option but a triangular flow.

If you are in a triangular flow that doesn't necessarily mean you don't
have permissions.

> >> A thought did come to mind that a Git serve/repo (typically bare) should
> >> be able to offer a 'refs/users/*' space (c.f. refs/remotes used by
> >> individual users) that allows a type of 'centralised' operation (almost
> >> as if all the users used a common alternates repo). Users could only
> >> push to their own /user refs, but could pull from the main refs/heads,
> >> and their own refs/users/ space.
> >>
> >> This would give flexibility to smaller corporate central operations to
> >> offer 'triangular flow' where each dev would feel like they have their
> >> own 'push' repo, when in reality it's really personalised branches. As
> >> usual the authentication of user names being handed off elsewhere;-). It
> >> could avoid some of the --alternate management aspects.
> >>
> >> It's a thought..
> > Yeah, and interesting thought. But it demonstrates what I said above:
> > you can have a central repository, and yet have triangular branches:
> 
> I see triangular being about repos, rather than branches.

If you have a feature-1 branch that fetches from origin, rebases onto
origin/master, but pushes to origin/feature-1...

Does that qualify as triangular?

-- 
Felipe Contreras
