Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D6CC2D0E4
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 00:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1EF24199
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 00:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHvkmaGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgKRAva (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 19:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKRAva (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 19:51:30 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D0AC061A48
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 16:51:29 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b6so134714wrt.4
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 16:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=REsQu7s60hxfuqcOpxuTrkfNDD8QqfAZdy0ZPRsYgek=;
        b=tHvkmaGYmxHq3XetIaUJodezRHsH1gEh4e3FVBJaTdtwRiLJ+nzvFevWU/Ul/2OLF/
         SWx4De/n9a2JCqHPc+fT4fDATwoe01/LewHCgQuE7n9oWjtmG5qy9LCPmkt1v9VvO8mG
         /0b9ZvICJaP1ZcKCqNQ+JAIfz3hCIu7R1VjVSg5D0baGZ5mh3g6U7Ebo3ppL2Nj6FU3N
         c7t77sV90X3wUCfSankj5JQEL0JxU4vY5Z1wQlsDLd2aMJ4BzkMBdHAVnxP13bhDqUXC
         /FEw7SzCHdzc1t2IdUf7Zg0k5MapnqBI2Pao2jCaFemw2LEAHYxKxCLQBrHAWmMgM5Uw
         Bssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REsQu7s60hxfuqcOpxuTrkfNDD8QqfAZdy0ZPRsYgek=;
        b=cyOufKUaSvSDDS8kkBEnDXoja9BrwugMQCNeWLriR5v3/ZctwXQNqIuuQhSFafIhVJ
         fF6snDpUVazYP3bI5YFLMNnZVs4i2rHBsspdkG6qldP1fS4zQzQ44TKLfTD/mHldBFee
         PSJiHQiEMroz0J27cQSjogZCw3O+BY9NE+y1e1qRrRp4fpNRZ/g34zZ8WuB4XcWq7LM8
         YQlFguTjWluHYmslSBo63Gxp/ulD+EcrUl5TjQbd26BM4aOiOM5+6sPScp57OZEt11Yx
         +1JdEdA0urACou4uTDKlNT3BAVhmOm7eLTPlLpPnQ1/TP6CXEZPafLuB9TQzpcLLrPOC
         6O+A==
X-Gm-Message-State: AOAM531jk//qbrdVNdxo6Oy6qpMougCuDVEX1WdrQjcLdTyc/k0+jKh0
        gW1SXGNn34opqRLtUo0a4rj/1hRKBbT7aFpSbDo=
X-Google-Smtp-Source: ABdhPJy+DnP6OskWb4PNWm8FN2RAS7pS+A6W2QsBv4ZRoGnNYZlWylrkqtwOazptj+gips0JlqNycmYi1sVMIdZPdZE=
X-Received: by 2002:a5d:474f:: with SMTP id o15mr2099722wrs.100.1605660688500;
 Tue, 17 Nov 2020 16:51:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org> <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
 <CAMP44s3750bSdmw4A=KU=UgffOPiQwB8ECk9YRPe8mh50Og8Ow@mail.gmail.com> <xmqqmtzf4j96.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmtzf4j96.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 17 Nov 2020 18:51:17 -0600
Message-ID: <CAMP44s39fuHfJ5Uuywh05+S+fTzdhOb3f6ma-oqkW2T5gTG9OQ@mail.gmail.com>
Subject: Re: [PATCH 00/28] Use main as default branch name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 6:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > If we already know "origin/HEAD" is very likely pointing to the
> > integration branch, then why do we need to know what that branch is
> > called in that particular project?
> >
> > Just refer to that branch as "origin/@", or just "origin".
>
> "git merge origin" turns into "git merge origin/HEAD", I think, and
> we had it for quite some time.
>
> But repositories may not even have any origin to begin with.  The
> one I am typing this message in certainly does not.  And we need
> some fallback default when origin/HEAD cannot be used anyway, and
> that is where the convention comes in again.  You cannot escape from
> it, and ...

I did not say the convention can be escaped, I said the convention can
be minimized.

Since apparently there's already support for "origin/HEAD", a lot of
documentation can avoid the term "origin/master", and simply use
"origin".

However, we need to make sure users have a properly set up
"origin/HEAD", and at least in my case none of my remotes have set it
up. Looking at the code, it seems:

  git clone URL test

Is different than:

  git init test
  git remote add origin URL
  git fetch origin
  git checkout -b $favorite origin

In the latter there is no origin/HEAD, and I don't see why that should
be the case.

Cheers.

-- 
Felipe Contreras
