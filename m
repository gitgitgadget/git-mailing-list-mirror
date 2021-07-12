Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C4EC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C43461154
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhGLQrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbhGLQrC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 12:47:02 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33970C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:44:14 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id s23so10406730oij.0
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=gIvqWhl/NIRPK9SI0SY5VyUH80Bh25EJXGthMC+aMJ0=;
        b=JDK62my08VmxxpNJplaBCitqaSd0N7ZASOtLoZwR3l5ohRWWJSZWMb6cKNuHBxzWFJ
         IvsHVtoXCng8t6fQru9wntNUYEWTLC5O+3PiOSH2LKqhSl9khOXuF6bHcw4Qad634mjl
         EUJv1G+jONx+NfrVzgDhszz6HOOXdu3uyRgyPMQo/SIM8qtxwZzo8XeIUjrZGd3OE85y
         SHBLJfk1OL4pN2EhnlqFBQY3C5SOKrm78K9CgmcY7WTN/j3GQT6LaSMVCyhko+pcC1Io
         Nw0Jp7VmJZ/8wUayArJ2i3ts6qW1Q6zuvHYa+f4LeOIeg183mgEMbpc/U6vndzyENfNa
         167g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=gIvqWhl/NIRPK9SI0SY5VyUH80Bh25EJXGthMC+aMJ0=;
        b=d1A0NmimqSNXkp/FQApO6W6gafMc/wK1bltaCcXNrKD02TeQ+l1F6NeUTnh0pnAEOa
         CzkYmAbXGmz8ENxq3Pf4E62AwVtrkHuJQLOxyEpZq1wVFs8j3iFP5QQgMcAITN6jwp+V
         GTv+t6E8NwfBVMZkUDaCYMhE00KbH3h8gqfofO41OfaWroz1isohElQinLbTlZoPLadG
         yc8VRYmY7I5+R59MaH/D4+l+YVMpsY90yx37KA3Z7nrmQ2NGEiWs5WPyTZxq/cry23ez
         shKTDIxZMU36+xB3h8VU9bWMTH+Ob9EAA3999fAHmALU0h4dpts4xKgO1Xi5+lZbrNuB
         tFjg==
X-Gm-Message-State: AOAM532na+6t/zUqXSAcHn6fv0OoEWJ8ZmFV9rVlB9LdoNDY4ZspfoHF
        0SZ8buArLBtVwH3mIkF7p1k=
X-Google-Smtp-Source: ABdhPJz/RBlnVCPfe+sOTTj/MH7v9WyhahJ3tm/qgRYgGPOAlF24ppKkU7CigaWJY2/HAK48u64ErQ==
X-Received: by 2002:aca:e046:: with SMTP id x67mr30941247oig.117.1626108253591;
        Mon, 12 Jul 2021 09:44:13 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id p5sm3269689oip.35.2021.07.12.09.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:44:13 -0700 (PDT)
Date:   Mon, 12 Jul 2021 11:44:12 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Message-ID: <60ec715c8338_a452520896@natae.notmuch>
In-Reply-To: <87im1hfa8r.fsf@osv.gnss.ru>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
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
 <60e9fa5132e14_7ef20849@natae.notmuch>
 <87im1hfa8r.fsf@osv.gnss.ru>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Sergey Organov wrote:
> 
> [...]
> 
> >> Creating (a branch) is fundamentally different operation than switching
> >> to (a branch), and that's why the former doesn't fit into "git switch".
> >
> > Not in my mind. Instead of switching to an existing branch, I'm switching
> > to a new branch, which is easily understood by
> > `git switch --new branch`.
> 
> To me:
> 
> "create a new branch" is basic operation.
> 
> "switch to another branch" is basic operation.
> 
> "create a new branch and then switch to it" is compound operation.

Compound operations soon become basic operations in the mind of an
expert.

Lifting your feet, and then landing your feet might be basic operations
when you are 1 yo, but soon enough they become "walking".

Similarly checking out a commit and then cherry-picking a sequence of
commits while resolving conflicts becomes "rebasing".

In my mind I'm not doing two operations, it's one operation with a
modifier:

  git switch --new branch

--new is an adverb, not an operation.

-- 
Felipe Contreras
