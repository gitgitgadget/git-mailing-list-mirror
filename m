Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30238C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7E160232
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhGLRMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbhGLRMN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:12:13 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B667FC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:09:23 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so19650256otl.0
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=t0phKG8tCSQ7AqO7TFiuUJb46pdauWhPmupVO62WxFo=;
        b=CxoHYCFQ/i0cuQM3j36dnc549m6u5j7gvOMyN1S3GJpD6mt/S/SZD+CQdrcTpequ+U
         j7j+Rs/8EJNq5sqkMXIklUOj6BNiz/2e1cTk0WT4stCReEYRw5DZ9O+4W6Ead9n+72R/
         Aqdfb+FJC7IQpQRBjSq7NCJd3hJdD1ET7VO8ww3/mNDDdRCQeMTKVzWgCuGo942cb1uX
         4LPaY8YAZB3wzI3L1OK1sv8VCSOKmLC6+xwNAR6wnspqPsAVIY5TpA80mRz82B3h9JlC
         LHQB13vva9BpUdQNJAb6I7ums4N1UOPXv0ZWCHxaycYU/7TbuC0xj0rwSNWxYEMDa0qp
         NiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=t0phKG8tCSQ7AqO7TFiuUJb46pdauWhPmupVO62WxFo=;
        b=pKnwWOTTvRrEg8OaybVUwBIWAhqb0ae2yEJKxixAm+yOvXhnn2fNKG+lbU9dlj7OjX
         OSz32aXFY7ErS2438Lpjf9C4jUMrwlFnbydxBUM/QonDLXfqEt+MR2PVdZtILteICyxE
         zBwjSqcPXnZ/R5OWfRQXK7DhEK/nbIymq+AA07FGxq3LSgmX7UKjK6Tup6oxHOppab0N
         LM+Yzl+t475A1f3vJKRNAlDQIaKvKB4uhid98PDmfos5xX7ARMPoZ44tTk481INPS00D
         YKdVFAzQUpfPi318R2dPAzxoshHcoYVWkbK7s07LJS9MUPss8f72otwDZ6aKm8OQRwa8
         NuXw==
X-Gm-Message-State: AOAM530AcwJfByxhWsXkKKzmsf5Q9o55wbTAWmypLTPD6Lv1wG7VdaEm
        a5jBXQEwHJmzhx6IKrtCrT4=
X-Google-Smtp-Source: ABdhPJxtlc5LogFB2wZB7nzRrS3I+5sjt6I4UK8fEK8qH1QA4J0NCgjIu58jXIaKZOdgcgGcMCoF6w==
X-Received: by 2002:a05:6830:4118:: with SMTP id w24mr57672ott.36.1626109763177;
        Mon, 12 Jul 2021 10:09:23 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id g20sm2593387oos.13.2021.07.12.10.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:09:22 -0700 (PDT)
Date:   Mon, 12 Jul 2021 12:09:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60ec7741640d5_a452520863@natae.notmuch>
In-Reply-To: <f0770358-be4c-a747-0851-b2fd73c1978e@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru>
 <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru>
 <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <87im1ieaba.fsf@osv.gnss.ru>
 <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
 <87a6mudt9b.fsf@osv.gnss.ru>
 <60e9ff4430c57_7ef20815@natae.notmuch>
 <874kd1gr0q.fsf@osv.gnss.ru>
 <60ec6cd622c4c_a4525208a0@natae.notmuch>
 <f0770358-be4c-a747-0851-b2fd73c1978e@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 12/07/2021 18:24, Felipe Contreras wrote:
> > Sergey Organov wrote:
> > Even standardizing `git branch` would be an almost-impossible task, even
> > if we manage to convince others. `git new branch` even more impossible.
> > 
> 
> Not sure but from the glance at hg that I took, they seem to use the 
> plural for nouns.
> 
> So then we could have
> 
>    git branch <new-branch-name>
> 
>    git branches new   // long version
>    git branches list
>    git branches delete
>    ....
> 
> However, standardizing to a fixed verb/noun rule will still be more than 
> a challenge.
> 
> The above would as guildeline be
> 
>    git verb
> or
>    git plural-noun verb

I don't see what's wrong with considering the second form a subcommand:

  git $subcommand $verb

Like `git bisect start`. That way you could consider `branches` to be a
subcommand, it doesn't need to be a plural noun.

> Yet try to do that with
>    git status
>    git log
> 
> I don't see how a better alternative for those can be found. One that 
> actually is accepted because it's better, not just because it follows a 
> rule.
> 
> status, is not a verb
> log is the wrong verb, or again a noun.

If `git branch` is a shorthand for `git branches new`, the you could
consider `git status` to be the a shortcut for `git status show`, but
since there's no other action to be done with the status subcommand,
then it's always implied.

-- 
Felipe Contreras
