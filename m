Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A11C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 03:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAAA120674
	for <git@archiver.kernel.org>; Tue, 19 May 2020 03:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+aX3qOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgESDEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 23:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgESDEo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 23:04:44 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F875C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 20:04:43 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f6so5756510pgm.1
        for <git@vger.kernel.org>; Mon, 18 May 2020 20:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fcshJqkqdPdGBzGN6QABva/0vS7NjSjoOUBhQqRsFog=;
        b=G+aX3qOCzAErXVxAwbuv9dO4RnJAJMeRaYEc3vLPfVceVyZ4GIgRFgSytHZ++W/UIP
         UNDlT9Sh8dL+zEUKNRc/Gi7fSJ/O38Dv37nKmltOtk0Yg7sDmhOq7f13DK063fbGDZ/C
         6380+IGZAZgl4vpgTzt+OJnGZ8pJ5S8/CbUMtNp9xTuA7U8Dvt1p3pHq3tHedmHcWhFd
         SqH8CT4Oytvfflzj+xq3Z1PiYXDuD/nkBViFpcVugLYJV+7uSqaSIsio/7lab++GaIm6
         kTV79vJc0HkDkQgNUlGcligRsHZDTKeo4yzBv7IUcNTdFcRgb4TQDzpd7SF4xVmej2J0
         BvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fcshJqkqdPdGBzGN6QABva/0vS7NjSjoOUBhQqRsFog=;
        b=Ueq2ie7DslTdOoQDWEQONS/hMkrWxx6vVPxOfbDmPp4Ae7k99siPrroKJ0wLDXoDP+
         qZM5Osmf7m0Te6EMYiGe/2dq5kBLtOS42HPnPuv+HyqT1vxM55klmegEVZuEUJ8Pr9ih
         s7MNlN9+8b1lsu67IfNhVltu00YC7/OUibyjhM25CeYR7ZbW5fHeVN2pFM/Q65ArUvhT
         nsB8ei2cCGxX7p2kLDfXpElvzzadysl398HkUTM4VUA5wKjvSAHrrMw6afTTu5FdfxbP
         CQLHMwRmVqp1rlIDgE1+vwj8KfCfrFK5rk1jXTDBS9hrlLG/Z71gTZfXgKelYXaPyLXc
         oitg==
X-Gm-Message-State: AOAM530PaYkNsHNuz2X6TVCAHS0ACWlxRS4cgY5/Qb9koUEzrgTiBJ4L
        PUsPjCHk82rQ3GCX0hnxwPbIHgSD
X-Google-Smtp-Source: ABdhPJycAULhcqLmmUNK9lrW2HGSutyxn2C7eZDHj4tTBrboTieOWQnXITxcunWTU3rRODuEd7OIBw==
X-Received: by 2002:a65:4947:: with SMTP id q7mr17955624pgs.23.1589857482290;
        Mon, 18 May 2020 20:04:42 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id r31sm741373pjg.2.2020.05.18.20.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 20:04:41 -0700 (PDT)
Date:   Mon, 18 May 2020 20:04:40 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     "Daniel Richard G." <skunk@iSKUNK.ORG>
Cc:     git@vger.kernel.org
Subject: Re: Minor portability issues + fixes
Message-ID: <20200519030440.GB20332@Carlos-MBP>
References: <7422404e-7fc8-4961-aae4-3f0adb71bb3a@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7422404e-7fc8-4961-aae4-3f0adb71bb3a@www.fastmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 09:15:58PM -0400, Daniel Richard G. wrote:
> 
> I am building Git 2.26.2 on AIX. A few compilation errors arose, but
> they are resolvable with a few minor changes that will improve overall
> portability.

which version of AIX is this?

> There were a few errors of this form:
> 
>     sha1-file.c: In function 'mmap_limit_check':
>     sha1-file.c:940:12: error: 'SIZE_MAX' undeclared (first use in this function)
>     sha1-file.c:940:12: note: each undeclared identifier is reported only once for each function it appears in

we include inttypes.h which is supposed to include stdint.h per POSIX[1]

could you take a look at that header and see if there is some macro definition
preventing that to happen?

Carlo

[1] https://pubs.opengroup.org/onlinepubs/009696799/basedefs/inttypes.h.html
