Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0DDC07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 16:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E36A61153
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 16:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhGIQXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 12:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGIQXv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 12:23:51 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5DFC0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 09:21:08 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u66so7007875oif.13
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=De21ll1n9TBrqhHaXKiM4FeZHzfM2MAcxytdfWyJvCw=;
        b=TGjHi8KiSY9uL5fZpRtKmgMyCDZJJZrom+e3tgfiUrBzVP88Xd3DLtZNhBsHNUS0pU
         9G9L4x32fK7OtqiV7bDNZroJTD8Mx/D9KuLOBAAmrsfNMItK9p7V5EFs2ZLJ49/Q3Efv
         b0NqIk9mV+uuZTR7w5lfJTcuyUxFw0nvAzvoBtItTOlg8ibkdWPdzzFuXIZ/a2TBr/Z4
         hqBfR4ffUlXLd9tejsl/pYleTHf2g+9HMa9VMaCc8V8emo/ZiWHEZa1vCvxK8o0tv1fK
         s7Jj/I/vKqMHZ83Qry0Ybqq8t55s3MtenXa1ArVLTmqvjL6p/f9rmSUx17/bna66Hpte
         aqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=De21ll1n9TBrqhHaXKiM4FeZHzfM2MAcxytdfWyJvCw=;
        b=Z1K1AyNwgM9AFLLvE3y+MrNVsrxqoJC4IaLbB/7yp0lW6feeUwI+vYV6RmCaeWg5uo
         aiSq++fszn+cfuNCk0e/zyXpTa4AMiaYw/+m4T0VMc+a40s0BghwfgsyoYrC2XVK1ah1
         7/HcDbHsH03v2qQgY0ERzHYAnd6zAOGyKEhALwf1dyc3XEv4LYPXV4ZQo483Wpjwt/B7
         J9UwOrYxVMzkV9RuNX/U375rzLuKxmN494syQ6frsRUw0UUuInKlo0RfrmqixeIrN84G
         J3K4TKTKHXSgVldBoiFKCtEhX0bdyiON3iYHBn0VVi1Mkk+QTysm/QJ0wUFH5tiATw9F
         m3QQ==
X-Gm-Message-State: AOAM531wl8MjnSdpS03lAmvmTMdLddMMlk2crCg8vCfqQdqu3nCXhtJe
        relJLBTsh3mLk4V6ML6ODi0=
X-Google-Smtp-Source: ABdhPJxKimpojDBR912LgUSpnMT0S8VRWO9Xsinoae6QUFU5aPrzaSt5B/6ZFQysCAblN8h0dFniaw==
X-Received: by 2002:a54:4586:: with SMTP id z6mr9129348oib.71.1625847667662;
        Fri, 09 Jul 2021 09:21:07 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id p26sm1207280otp.59.2021.07.09.09.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 09:21:07 -0700 (PDT)
Date:   Fri, 09 Jul 2021 11:21:00 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60e8776cdc455_215320852@natae.notmuch>
In-Reply-To: <57f316cb-850d-706a-592b-4376f240e032@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
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
 <084a355e-95cd-5c84-2fa5-a901da3e0e49@mfriebe.de>
 <60e8666c8707f_2153208c0@natae.notmuch>
 <57f316cb-850d-706a-592b-4376f240e032@mfriebe.de>
Subject: RE: switch requires --detach [[Re: What actually is a branch]]
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> 
> On 09/07/2021 17:08, Felipe Contreras wrote:
> > and the fact that
> > `git switch` expects branches is one of the things that bothers me about
> > it.
> 
> Ah, good point.
> 
> I would word it differently though.
> "git switch forces the use of --detach if switching to a non branch"
> 
> Bit of a twist.
> It's a nice safety for beginners. I remember when I started, I kept 
> ending up detached. And I had no idea what to do next.

Yes, and that's a good thing, but there's no need to cripple advaned
users.

> But once you are a bit more experienced the need to add that option can 
> be bothersome.
> It's not common in my workflow, but I can see that it can be an issue.
> 
> So how to remedy?
> 
> - Drop the option / Make it default?

No. As you noted it has value for beginners.

> - add --allow-detach  and git config switch.detach allow ?

That's a good option, but another one would be to have a core.advanced
mode, you turn it on if you are an advanced user.

> I don't really have a preference.
> 
> I think its a nice protection, but even without it, the warning on 
> entering detached HEAD state is pretty good.

That warning olny appears with `git checkout`, not with
`git switch --detach`.

> There is also a curious side effect.
> 
> If you went into detached, you can go back to attached using
>    git switch -
> 
> but not back to detached by again doing
>    git switch -
> 
> Even though you had been there, and that means you had used --detached, 
> and therefore known what you did.

That's definitely a bug.

-- 
Felipe Contreras
