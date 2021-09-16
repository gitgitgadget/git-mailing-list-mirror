Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887ADC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D6A06113E
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhIPFix (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 01:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhIPFix (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 01:38:53 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E72EC061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:37:33 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i13so5467301ilm.4
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8rdl/UFRdcV5j5s6H398VXZ5IrQJEyt8IRZgaBMXyPQ=;
        b=U02puXHAfcSuJ+ma6FpFHA9yNdGPARfrcaW0+ajHUdL3b5A64Edl24ozTqh3RViqS5
         YD1DlH5YTKV5DS8i8anKs2eWxHVlNkJaMnQlZ34jpStMzh7Y8+mPMzUvS0vdBDSlugnf
         U92eOjq6iipxdZqLRBFHDz5a5ElKFUsHpzaO4cYXX3LA9mtqeM55BneRjmbc+kS/3SxS
         YZ2f6iK7nBtw0o/9/rhkd0TI8QyReuMJ3pgXgvoLmkIA4fLvuNY+L9Ci61STKa3EDhqR
         X6vkdi477D8dM0nQwnLmd7/BEMQkYjAzThIG9Q6lx4Vuyi9CvxfJ1z8JKIWvwAtENEVV
         9R6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8rdl/UFRdcV5j5s6H398VXZ5IrQJEyt8IRZgaBMXyPQ=;
        b=JWBX3raqyXv860PI/Au9wwTrqW9no8oXzQDZpRNWQVphinhpgK5cQWX5G3BJjStB6/
         5qN+9n9JGrk5AjwC5zrB1KaF+oQwaX3B9wO/RLj6t5S/Vfi8GurZY3z5MvCDD4Uj0TGS
         p8KSsg6G+DfB2a3RZogAfE/pX7Uvs9oka5aXOU0VSnUXYNkTs0QvyzkJLCgG9DWRv7F7
         /vr8T/9QZRkJMrm20Bd2ZgcLf68cjKt4sqQodqGDhnYd6WoiCvoEGvXnstaFUUAttfMy
         QfFrNxkVaIL+nwmf/1LzUC/PGnVFEyF9DCNWcG5eWCrM2OQxx/daw0qAZbDuZ7fbkCeU
         QToA==
X-Gm-Message-State: AOAM532GR+FcXRIElELZmqhb0pTwUF3CtpcQTf1lRlE5lMCDNWes7UOq
        eK3B2nsebFkSxV1XbxveFljoFgZTpRRHFdG+
X-Google-Smtp-Source: ABdhPJyph3Ow2Didrcs0KkNx5qNl21RmPDR0g1v55sul+GtiudL30JeV6se+fQCrB7lY2EmqDZP12w==
X-Received: by 2002:a92:cbc2:: with SMTP id s2mr2650041ilq.228.1631770652676;
        Wed, 15 Sep 2021 22:37:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b3sm1195131ile.37.2021.09.15.22.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 22:37:32 -0700 (PDT)
Date:   Thu, 16 Sep 2021 01:37:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Wesley Schwengle <wesley@schwengle.net>
Cc:     git@vger.kernel.org
Subject: Re: Possible git bug
Message-ID: <YULYG970Ltnbshdn@nand.local>
References: <30651e4d-10fb-8bc7-7f52-8fbabf042f4a@schwengle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30651e4d-10fb-8bc7-7f52-8fbabf042f4a@schwengle.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 11:29:14PM -0400, Wesley Schwengle wrote:
>
> Hello,
>
> I'm running into a weird issue with git at the moment and I'm wondering if
> this is a bug. I have a small reproduction path:

> $ git commit -m "First commit" file.txt

FWIW, I had to tweak this script a little, since file.txt is untracked
before it is added initially. (So a "git add file.txt" before this first
commit is required.)

But even after this, I got exactly what I expected from this script
(which was that your "foo" branch had three commits before and after).
Is there something else interesting going on with your setup that might
explain why I can't reproduce this?

Thanks,
Taylor
