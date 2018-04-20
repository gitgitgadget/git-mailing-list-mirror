Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41DC01F404
	for <e@80x24.org>; Fri, 20 Apr 2018 22:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbeDTWQH (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 18:16:07 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38644 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbeDTWQG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 18:16:06 -0400
Received: by mail-qk0-f195.google.com with SMTP id b39so10243221qkb.5
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 15:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=YeGTNNTIIEDkWkmNQWcyqSCkqqxpl4fQGgNUHoN/Uz8=;
        b=nfh1NwV34zmmqePHEMRZ2ODSxy+jNZ5F7zmp7MavNEgldZJLSSTlLMYb2piYhCPhSD
         O16e5WUNm7sDtbrgfm2xVCXjCJRaGaG9JTlPgaNrHmRPFd4Vn2roz+AQ11C7JQejnhck
         ZqhhAbKF/IGOwDWB7u3FvzKn6FqqUEdbehjyJxM+5Mu+A0sGJppv2zqxTV/pa2dPtnFv
         G5W6RlGoMBAUbA/aPX6FMFvPvNNXgtcMd208alBouclo43UpXAw+rVXBqoCJHVq8O2Ln
         023sAjeBOgXiQote7CEf1e0trNa9NtWpwqRKkt3RlHP4Radp9B+ru483c+RZxECAHWxR
         xe8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=YeGTNNTIIEDkWkmNQWcyqSCkqqxpl4fQGgNUHoN/Uz8=;
        b=ShiZQ089a/2LC+6dGiHX6qNq48Dzi/zlGI69FwYUZbyN5HM2/lUPRC6c46x2lDPLjw
         nbDn7zpk8zf53UkkHd9bDjO/wioguBTN1/yHycN7uF67j26vVGJVMF+CHb9aMi3rPlzC
         mnvKLhDLgvBhulSixBIDcfZNEHSWatWeMwazuxyYXaYtCBwUYnmiJzxDcXj7h+KDEcsM
         j+0qpz4LWW1oGD76uc6JpH0c+xOoobdkVge0+DxB56PH5r2D0eI6u7ehb58qYO6WQ8pU
         QEcpITYMtPCg26KoO3VtMRibLjWjZRihSbVRvvjtkqBy+PIVfJcFlO+ITwAThgN99a8J
         ZjPQ==
X-Gm-Message-State: ALQs6tCso/o6KiDqMKD/XyCnqSg1hX19NMbBAZZy3trzpBYkfL6QedHn
        5K3RghgieZLtE2b4ry3mLKHK0PLKeaDK28koAr4=
X-Google-Smtp-Source: AB8JxZqeHBEcaeBv3pfnOM5YyCKLl1PTwY5qdGRwZ3i5qQCEqS+3kLlQ+tvRFmQEqDY0Lc1VCMgVMz5+MTacKiMfpBM=
X-Received: by 10.233.220.1 with SMTP id q1mr11882285qkf.361.1524262566036;
 Fri, 20 Apr 2018 15:16:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 20 Apr 2018 15:16:05 -0700 (PDT)
In-Reply-To: <20180420221231.4131611-1-martin.agren@gmail.com>
References: <nycvar.QRO.7.76.6.1804202258071.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180420221231.4131611-1-martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Apr 2018 18:16:05 -0400
X-Google-Sender-Auth: cNwL1tUAmTZo7G457qa5TUmFlt4
Message-ID: <CAPig+cSKBAq3h4CAe4phFoG+APDV_qzApJgCpYK6AZrjW-+xxw@mail.gmail.com>
Subject: Re: [PATCH v3] fast-export: fix regression skipping some merge-commits
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Isaac Chou <Isaac.Chou@microfocus.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 20, 2018 at 6:12 PM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> 7199203937 (object_array: add and use `object_array_pop()`, 2017-09-23)
> noted that the pattern `object =3D array.objects[--array.nr].item` could
> be abstracted as `object =3D object_array_pop(&array)`.
>
> Unfortunately, one of the conversions was horribly wrong. Between
> grabbing the last object (i.e., peeking at it) and decreasing the object
> count, the original code would sometimes return early. The updated code
> on the other hand, will always pop the last element, then maybe do the
> early return without doing anything with the object.
>
> The end result is that merge commits where all the parents have still
> not been exported will simply be dropped, meaning that they will be
> completely missing from the exported data.
>
> Re-add a commit when it is not yet time to handle it. An alternative
> that was considered was to peek-then-pop. That carries some risk with it
> since the peeking and poping need to act on the same object, in a

s/poping/popping/

> concerted fashion.
>
> Add a test that would have caught this.
>
> Reported-by: Isaac Chou <Isaac.Chou@microfocus.com>
> Analyzed-by: Isaac Chou <Isaac.Chou@microfocus.com>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
