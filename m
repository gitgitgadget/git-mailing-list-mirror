Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979B3C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75FC060C3D
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhFGQof (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:44:35 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:36446 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFGQoe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 12:44:34 -0400
Received: by mail-ot1-f46.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so17367437otl.3
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=QsKzDIWW43nBg7CYYPAKseRBmWPzO1ZCY9NYMJACYpY=;
        b=MpCLw1vsuQRr3z85xrhBs530ajksQESDuVVA1GUwEcOzoAdjZ5+GxCR8eP77pMC7iP
         09wQYjFaj9B9+AX27f35eHF3pHLWpb6edaGIdWo5zikHSHC3OydNLuNFn79f8OcYehSU
         cwMtyMewq/L3GvyZGNe5dTwTtAcKpz0TlPNoafCMDCEOT2byF7aonnkvgwSiOLOA7WSD
         wkNC7rgcoGuxzvtZQcmHvyPbAh5r/P+MovHuSHd/VId0QRZVNWkr4hMQ2XdiPMLxiu/A
         8UNo+yIQNkAS77DkCD3zCrCOuVbrDC4EDXoxXnILFdj/kQsKo0ISgNWsnr3DHplvDDZH
         fRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=QsKzDIWW43nBg7CYYPAKseRBmWPzO1ZCY9NYMJACYpY=;
        b=c6sm0UZYR1O0BCSN06v+mVy05ybDpawEbRvxEPbrPsOSRTa72aka5HG8msxvEPhuct
         rlFkKqa6z45xcG+xydNQdY91s3eGQgoRinQQBxT7WTw0aUiF2BDzlaR37SrU9D4Hv66W
         qJ2dxCrPBPYdAdtsNBARaGgQUlJdNJE6vZNWjW990C802q+OTODP8szc11x2igsdfuh0
         retcjntgZdQJlqD4wMKqtRJqok1JeeiRxm7AmoS/Q+Nt54UIrvq4tOJMuLh2oANlWrfE
         2bj915cFw0e672uloTnA1DvKZjMUcKcq55MbihaKA5Rnh3tnlygTJHXy2/th0TDMbb33
         r4AQ==
X-Gm-Message-State: AOAM5317Rl7wbHdxLfQwQUXu4vh4xbRcG+xeunH4ZMyzvCGdNIpu66rC
        zk4bkddPqWGhnEd1uCgFpyKfXSfr9+iHLA==
X-Google-Smtp-Source: ABdhPJzRjQ7pumFTK8jbsXe35UGB5gfU83JgS6gsCpzrt8uA03pMqafoH6eHW9vVmv6HeV/u/zTtnA==
X-Received: by 2002:a05:6830:348c:: with SMTP id c12mr14010936otu.344.1623084103183;
        Mon, 07 Jun 2021 09:41:43 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id z22sm134758ooj.6.2021.06.07.09.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 09:41:42 -0700 (PDT)
Date:   Mon, 07 Jun 2021 11:41:36 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60be4c4071b80_39c0a208ac@natae.notmuch>
In-Reply-To: <xmqqfsxvxjj2.fsf@gitster.g>
References: <xmqqfsxvxjj2.fsf@gitster.g>
Subject: RE: [PATCH] rerere: enable by default
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> By default, the rerere machinery has been disabled since a bug in
> the machinery could screw up the end user's data at the most
> stressful time during the end user's workday (i.e. during conflict
> resolution).
> 
> It however has been in wide use without causing much trouble (other
> than, obviously, replaying a broken conflict resolution that was
> recorded earlier when the user made a mismerge), and it is about
> time to enable it by default.

That is a good diea.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>

But did you really come up with it all by yourself?

Could perhaps this mail [1] sent 5 days prior have anything to do with it?

> If the defaults make your life hard, then shouldn't we change the
> defaults?

> But, if we are already on this topic... who wants rerere disabled by
> default?

Cheers.

[1] https://lore.kernel.org/git/60b61089ba63d_e40ca20894@natae.notmuch/

-- 
Felipe Contreras
