Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE96C1B08C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C79661279
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbhGNTRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 15:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhGNTRl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 15:17:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5947C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:14:48 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x25so5407632lfu.13
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=MgYE6a1mZbtVTZw+uM1EjJCc4+UFKH9w6YCw7QhR4ug=;
        b=dt8ttDOa1P8OUghrWwCi3/krJu/Wjz164jruFD1P3aRRDlUgg8MIx4OF2xTZnNM4KD
         V+oJFyYB49ZS8iSwse//lskf/UQyZIM2GNr6zKaykQ/FaktlmGRYKEQOEdXo/AkN+yhY
         pKhUyglbgyOXV0oqJSlcArrzmdAHhJT3PPLGqeTgjAQ906UeVBn5tkqrQ1axaTFPXSa4
         DyPxj+FQPH7aDEXbA+nJ+q+6eksP9cIKoV6A8LX5O6XIyKXjMtw72B3PdUXQwXhiacGQ
         NXOUHkA7qKMiAPCrV9CH2cwQo28NOr3Gw0bLsK29rWFJbQPUcUeJYGZv2sU6KV/NAXrI
         Y+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version;
        bh=MgYE6a1mZbtVTZw+uM1EjJCc4+UFKH9w6YCw7QhR4ug=;
        b=EEZmG/R90TWkzoj4+dseKxZTu12rsgGv467Wyk8r91zA73mW2Rx2neuB6ILKbiKd9X
         1zGUiJy8yJd24ko1tZImF9qZzOkmcg7pgTf6M2DT3r21wQW9B7iRmPTQS9NTnba1fS29
         DAEtDBrW70s6fRowuxrVSJEpifMoFBxXm7TORzxIR19YqdOOxcP2SAN+kLQ1uoRDG9QU
         PagKFzQ4IEUv1hpvZUqp5MLWh5M2edR79Q5otnPSlhzblLxJxB27BVTGh0oLjGt9nFDo
         VGYCwidkJs4dZdv6S1IQrce8+QxpktVTTF55xjB2R613O41vsOK152Ovlev0L9V6Mtky
         xyZQ==
X-Gm-Message-State: AOAM5300mY+sjcjOTh5qioALwxiSGBmpKWvwAOITAv5CO3BtvLqDsP1s
        GGsks9npWEarpzrv9bf6h58gPQC3o0Q=
X-Google-Smtp-Source: ABdhPJzYGLLThHmZf8no7lf8uzCztLkSCDh1OEP+A42OihxaJpaeJblzlgfgw9zbPSP6bkOG8Y0huw==
X-Received: by 2002:a05:6512:308d:: with SMTP id z13mr8829654lfd.47.1626290086868;
        Wed, 14 Jul 2021 12:14:46 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f23sm334415ljn.98.2021.07.14.12.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:14:45 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
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
        <87im1ieaba.fsf@osv.gnss.ru> <60e9fa5132e14_7ef20849@natae.notmuch>
        <87im1hfa8r.fsf@osv.gnss.ru> <60ec715c8338_a452520896@natae.notmuch>
        <87y2aalbvq.fsf@osv.gnss.ru> <60edbaefa0208_ab6dd2081f@natae.notmuch>
Date:   Wed, 14 Jul 2021 22:14:44 +0300
Message-ID: <874kcwemhn.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > Sergey Organov wrote:
>> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >> 
>> >> > Sergey Organov wrote:
>> >> 
>> >> [...]
>> >> 
>> >> >> Creating (a branch) is fundamentally different operation than switching
>> >> >> to (a branch), and that's why the former doesn't fit into "git switch".
>> >> >
>> >> > Not in my mind. Instead of switching to an existing branch, I'm switching
>> >> > to a new branch, which is easily understood by
>> >> > `git switch --new branch`.
>> >> 
>> >> To me:
>> >> 
>> >> "create a new branch" is basic operation.
>> >> 
>> >> "switch to another branch" is basic operation.
>> >> 
>> >> "create a new branch and then switch to it" is compound operation.
>> >
>> > Compound operations soon become basic operations in the mind of an
>> > expert.
>> >
>> > Lifting your feet, and then landing your feet might be basic operations
>> > when you are 1 yo, but soon enough they become "walking".
>> 
>> [caveat: please don't take the rest of this post too seriously]
>> 
>> Yeah, using another name for a compound is yet another option indeed.
>> "git cretching"?
>> 
>> > Similarly checking out a commit and then cherry-picking a sequence of
>> > commits while resolving conflicts becomes "rebasing".
>> 
>> This is very questionable example. Please don't let me even start on
>> this.
>
> You don't need to validate the concept, but chunking is an established
> concept in cognitive pshychology [1]. It's how humans learn (and
> possibly machines too).

The urdge to dive into the muddy waters of psychology to support your
example, where pure logic should probably have sufficed, makes the
example only even more suspect.

Thanks,
-- 
Sergey Organov
