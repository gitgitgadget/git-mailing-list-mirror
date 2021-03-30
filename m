Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90834C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A55E619D0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhC3Nho (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbhC3NhM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:37:12 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2813AC061762
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:37:12 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n21so16443171ioa.7
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QCleCaLOjaopznQ+DYApEqjF1wD86igCPFYo2eL5n7g=;
        b=yimp0RSRaa4tYKAbIH5YHXiPTIA3a4buxfT6kdOFBmYehMCs1kcq1KcKoNMRCT0f5z
         H6xT2DLfdcev7PYUNmhcA/lDBE5BMrqbEaxNN3QkkbEcECB6xsbTBw0m3fRjMPmaWnWd
         IM/h+dcI1/3ZBYvg8DZ+O/I3bJRNFq2+YJfyAc/rFToD8ucRLBz6wfk5Tgu3q0EXmEHU
         yeGH+4m5YDU90NZcmuprEBOoye6KAq58fdqNxSqSQo41ma3xGYOQVC061p31T9usjYG5
         XrF+K7Tt8kjNHMTYQNYJdUSzxFJEiSD93lMrkRleMZYhsczqYvCqRAm5LDk3Qv3XhY9R
         /GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QCleCaLOjaopznQ+DYApEqjF1wD86igCPFYo2eL5n7g=;
        b=sl4C1/BRx9lCmD59+pBqNpdcgYwOx47Z+rZ+sGJ2TuWpW2Iar31dYOhcrTjdnAiEW/
         ajPFw2okgGrz4ROcfuhSUkR0zyq6GeUjzHfrpvupyKH/M0JTetUt3kUPdcPAKCTIHntQ
         eUqXV8H7iqyYGhfUK4w88q87Mk09QIwKX8aGUVg5gCIdvDYxoXWlPwYPd5Zu1YKQo/Tp
         ajcKQR2pmBFw1cbI0intGSeazifE/B02urW47UcNwyfOjXAxN62xwo4Y8zbKx5vLUrCp
         8IaJg/r6NNMxpXmUKGuL67JEjjxoVhhHZSCHxIwx7ZsL4fyntCDuSQAVRWloa+Ow44+C
         m2vQ==
X-Gm-Message-State: AOAM531mfvoQ7phZoBlbfi3K7TR4jtBVKlUCLfDVlzzyT95jxhnfSose
        CjGKA21/eCvLtXcbF5f2eyrLwQ==
X-Google-Smtp-Source: ABdhPJy2wZUzzxTEAqcqsopsHAYXwMRvUfWmED6Hc5Z/zfJ/8VR98qTyHhNLsmT4+9iSaE6Pp2TM0g==
X-Received: by 2002:a6b:3118:: with SMTP id j24mr24171980ioa.205.1617111431460;
        Tue, 30 Mar 2021 06:37:11 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id x20sm11396277ilc.88.2021.03.30.06.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:37:10 -0700 (PDT)
Date:   Tue, 30 Mar 2021 09:37:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 00/16] midx: implement a multi-pack reverse index
Message-ID: <YGMphbVWLp6X6TYS@nand.local>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <YGHQnQ9/ulXd+jgu@coredump.intra.peff.net>
 <YGJIfdyghSUrq/0I@nand.local>
 <YGLP9oE4HtgLudg4@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGLP9oE4HtgLudg4@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 30, 2021 at 03:15:02AM -0400, Jeff King wrote:
> On Mon, Mar 29, 2021 at 05:37:01PM -0400, Taylor Blau wrote:
> > (FWIW, I can also see an argument in the other direction along the lines
> > of "we may discover something later on that requires us to change the
> > way multi-pack .rev files work". I think that such an outcome is fairly
> > unlikely, but worth considering anyway).
>
> That would be my general worry, too, but in this case I am not too
> concerned because I know the code has received substantial exercise
> already on real-world production servers. So while we may clean up some
> cosmetic bits or respond to review as it goes upstream, I'm much less
> worried about seeing some brown-paper-bag bug that would be sufficient
> to make us want to re-roll these .rev commits. And hopefully the
> existing rounds have addressed the cosmetic/review bits.

Yes. Another benefit is that it should give us substantial confidence in
the correctness not just of this topic, but of the multi-pack bitmaps
that are built on top, too.

Thanks,
Taylor
