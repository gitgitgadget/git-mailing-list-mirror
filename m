Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED5EC47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 16:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCFE61376
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 16:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhFAQhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 12:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhFAQhT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 12:37:19 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB13C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 09:35:36 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id c3so16036551oic.8
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 09:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=HE9j+xn86TM5BULJKbFcjL04QOFjz1RmMe1GewDIL4U=;
        b=aqp5EOO2mLNnrHA/+b+thFq/pTb+ph1De4dW7NJbgJrGmKz8RH+nRRIMkH/idnAiJN
         S3HUh9PAvhjal4ZJQ+l0XKe/iTsGRGkf0ZOicPzSsxcKBXOyhpflgTFSq2L3Hg2sWc61
         ZsOybTTZ/PgL7c0ksRs6Df+5Z4ZZWEfErMOWkoDyqj+Ee0tCd7qsNh4i9ni7nfV1AE+6
         QLw49AgXIB/gwLW2/uyBoGCpeD9GM9+A7LwHLmsxkoNojfyo/l73pOH5UchPEFTeOhG3
         1LAmFxh8JP89uDb2PJ45NDXfBwPNM220jR1HpYk6ZRuk2tZGp49tk0MuiKOMYhl6Dmpm
         QZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=HE9j+xn86TM5BULJKbFcjL04QOFjz1RmMe1GewDIL4U=;
        b=i2Hy3aQLAFlB9Cn+weajNbO7+05nNRiSz/jDa/xq/J357V2qDTT6oFmf9MzPz4Tay8
         eynLVQC1C0nrHUjAUAiTJ/6itS3nrqANaKVQ8wmZhqhmLc5sZIWVVwBK1HzmJfPFfyiu
         1RjSjaV2ffSJwHP15UlCX1xMGoAKAjNBMIAdDAWryv8B7ANIZQQdhOtod0GP8kqVwS69
         4DMP16eDDSKy2iD4Y7OidSMYM76KWVknfJFL8YPn/cSbfpICFbIOkwzTX5CO6vwMt3Iv
         b24XM9iNnCjKRVbH2IH1YIMr6O3NCyzxc0jO1L35uLEynRENrgYZRK7tQfSKKTbEMcgu
         PO0A==
X-Gm-Message-State: AOAM5301yplduQGURPgzeNkz96HHEd4Zn36dHvkS6LwwKH0GuuOhoVB0
        HiKUpxwOZeSAl7r8SqdRxzw=
X-Google-Smtp-Source: ABdhPJwDEpdeTdaGHFSWf2bl+zCZRLhOO1zMU16KCViOCSsOTPiANDkuyRnwH0+Re5mD59mkkPRlNQ==
X-Received: by 2002:aca:6501:: with SMTP id m1mr620118oim.0.1622565336156;
        Tue, 01 Jun 2021 09:35:36 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id i133sm3481070oia.2.2021.06.01.09.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 09:35:35 -0700 (PDT)
Date:   Tue, 01 Jun 2021 11:35:33 -0500
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
Message-ID: <60b661d5ee7cc_3c4208c1@natae.notmuch>
In-Reply-To: <a385c279-5902-40af-f54d-85b950bbb497@iee.email>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529071115.1908310-7-felipe.contreras@gmail.com>
 <xmqqv96zwkl0.fsf@gitster.g>
 <60b49a3ae829b_24d28208fd@natae.notmuch>
 <xmqqfsy1udf0.fsf@gitster.g>
 <60b62420858c4_e409520828@natae.notmuch>
 <a385c279-5902-40af-f54d-85b950bbb497@iee.email>
Subject: Re: [PATCH v2 6/6] doc: push: explain default=simple correctly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley wrote:
> On 01/06/2021 13:12, Felipe Contreras wrote:
> > So it's more like:
> >
> >   centralized = ~decentralized
> >   triangular = ~two-way
> >
> > A centralized workflow consists of a single repository where branches
> > are typically two-way, but not necessarily.
> >
> > A decentralized workflow consists of multiple repositories where
> > branches are typically triangular, but not necessarily.
> >
> > So the triangularity is per branch, not per repository, and same_repo
> > means a two-way branch, could be a centralized or decentralized
> > workflow.

> My personal viewpoint is that triangular flow happens when you cannot
> push to the repo you consider as upstream.

It's not about permissions. Even if I had permissions to push to git.git,
I wouldn't do so. I do have permission to push to some public projects, but I
instead send patches/pull requests like everyone else.

It's more about ownership. In my personal repositories I can push
whatever I want, but on shared repositories I have to be more careful.

> Rather you typically have a publish/backup repo instead (semi-public,
> semi-private - few are interested ;-).
> 
> That (can't push one way around the triangle) part of the flow is
> separate from the distinction between patch flows and merge (Pull)
> request flows.

I think it's not separate, that is the thing that makes a triangular
flow triangular: the flow of patches goes through a different repository,
and then they get picked and merged into the upstream one.

> E.g. My personal Git repo can be triangular with both git.git and
> git-for-windows, plus a few (what I view as) fetch-only repos from other
> collaborators/maintainers beyond the triangular 'golden' upstream repo.
> 
> I often consider GitHub as a centraliser, but I don't think it's what is
> being considered above.

GitHub is all about pull requests, you fork a repository, you push your
branch into that personal fork, and then you request a pull from
upstream.

That's triangular.

> --
> A thought did come to mind that a Git serve/repo (typically bare) should
> be able to offer a 'refs/users/*' space (c.f. refs/remotes used by
> individual users) that allows a type of 'centralised' operation (almost
> as if all the users used a common alternates repo). Users could only
> push to their own /user refs, but could pull from the main refs/heads,
> and their own refs/users/ space.
> 
> This would give flexibility to smaller corporate central operations to
> offer 'triangular flow' where each dev would feel like they have their
> own 'push' repo, when in reality it's really personalised branches. As
> usual the authentication of user names being handed off elsewhere;-). It
> could avoid some of the --alternate management aspects.
> 
> It's a thought..

Yeah, and interesting thought. But it demonstrates what I said above:
you can have a central repository, and yet have triangular branches:

 feature-1 <=  origin/master
            => origin/felipec/feature-1

Cheers.

-- 
Felipe Contreras
