Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A24C33CB1
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 15:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69CF24656
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 15:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQxSTXxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgAOPmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:42:43 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43996 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgAOPmn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 10:42:43 -0500
Received: by mail-qk1-f195.google.com with SMTP id t129so16011903qke.10
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 07:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Re9YYLDLJ767X4LYyi7q0x1/XMj5lR/YgJV4hkxU3WE=;
        b=jQxSTXxN3povPV2kElZaxA5vYn+16Px33WBRlYmduP8xLbU8ax2kvfV18EitF9YeOL
         J724KxyXvTtpPw6ZMHwI8uG+C/9Mt4x8/8GN6FhOszw/GEHDqdZHNJqtmOMXNosIzk5b
         E990c8OYCh/jD8uFPlSJ9DpMrFE6g9O4d0EB58y+fTcIHy6uO1OmssT18u6PqDTLZjM/
         ViTrh9uQo1YRmKdery2Ajxn7XN5EFNbcKJidXG5nemJuh2I6+B8K+iUtAknXO80nLXn6
         VTIKU0Owk2SPeb6zvw+8JwX6mqH3jN3oiglwKIJ+wIXkkUGsQShmPLsQPrs6K/9Llt4/
         MzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Re9YYLDLJ767X4LYyi7q0x1/XMj5lR/YgJV4hkxU3WE=;
        b=JquNEIA4iWexnoQzZNQYkFcGRZ30ZnbJ/ziSXuYB4dCwVONkouymc46gvmRG3IR7CT
         UGYZV9Y48EbDS7LnAvW5Hg6WUJE2fKERBYYNf7d35WSa1rIiYlBouG+lDZ0FqdIZBt4R
         Jv5VfG8LNk89q4BAiDcQpcL44o4vBKIFXiH3gtQDwR+xi4sWGXmYoFYKehcD1MnejW6t
         RfvlqSFUxJ+lLh7UT/Ajr1i0KQzqPA29Kp8tTCUIyL0RGDekc35TUb7JQ60H/2XbDnY1
         V5iQ/q1Dd+uG2G5UhPAsLmOUJqHGxFMoKk0AdwVehIBjcEG62lLdRdbEUuls1i4nGGsW
         0DIQ==
X-Gm-Message-State: APjAAAV6rZNVMJZMfOxtvJrr8vyxr77Z33FNJbBmI5s3Wld0NB9yiA/g
        3c7fSgb8D2iVuiBMjOENCfkk2gM2
X-Google-Smtp-Source: APXvYqwLHtDCcaU50KcliiCc3c28+sQeE0w/c0nW771AJ3E1yF2dKNVhPOd0AWRY0vKRR/JvNXnmUQ==
X-Received: by 2002:a05:620a:84a:: with SMTP id u10mr27999126qku.182.1579102962255;
        Wed, 15 Jan 2020 07:42:42 -0800 (PST)
Received: from generichostname (wn-campus-nat-129-97-124-75.dynamic.uwaterloo.ca. [129.97.124.75])
        by smtp.gmail.com with ESMTPSA id l6sm9505673qti.10.2020.01.15.07.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:42:41 -0800 (PST)
Date:   Wed, 15 Jan 2020 10:42:39 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.25.0
Message-ID: <20200115154239.GA40131@generichostname>
References: <xmqqtv4zjgv5.fsf@gitster-ct.c.googlers.com>
 <20200114024938.GA17003@generichostname>
 <nycvar.QRO.7.76.6.2001142258130.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2001142258130.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 14, 2020 at 10:58:58PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 13 Jan 2020, Denton Liu wrote:
> 
> > Subject: [PATCH] .mailmap: fix erroneous authorship for Johannes Schindelin
> >
> > In 49e268e23e (mingw: safeguard better against backslashes in file
> > names, 2020-01-09), the commit author is listed as
> > "Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>", which
> > is erroneous. Fix the authorship by mapping the erroneous authorship to
> > his canonical authorship information.
> 
> Please note that 4c6c7971e0e42f0f1ce7e9472bc3aec8e0c96650 unfortunately
> has the same problem (albeit with Stolee as author), and it already made
> it into `next`.

Since 'next' is getting rewound in a little bit, can we requeue Stolee's
patch with the authorship corrected? Or would it make more sense to
submit a .mailmap patch on top?

Thanks,

Denton
