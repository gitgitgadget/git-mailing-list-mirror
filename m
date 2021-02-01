Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92A0C433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 20:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DE164E9E
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 20:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhBAUb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 15:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBAUb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 15:31:58 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B72C06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 12:31:18 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 2so8850962qvd.0
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 12:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AZryl5O1V1bipzCqVdmEMJJmBwbRth6RMdBX3pGZ4aA=;
        b=WUPL9x2jzktRe+jVEpDtGnSQnTwQwG7q1RdEV+L4l45srSB2c6kh+yTiNrRxI/hmSa
         lIEVRrTajRw/IfvJNDlnFOVwnr2HMYmnTSa5hA+EKkzvHUysKqtcRuIGcMvu6hmLAHpB
         WANRnGwwX4+9j8mCXWctSqNE+bZqMGgjWi3bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AZryl5O1V1bipzCqVdmEMJJmBwbRth6RMdBX3pGZ4aA=;
        b=nZj4VJpQNsHcAGdq2N003UNQkuICXzOyUftD/yhMLyAgiQD8bt5Dchag2ajkrfqSyM
         bdvlT14oQuRgNbQzeqaJk8W+a0GdMW6J6xwPnEc7kLnfVlyWyBjJGwKPDNpfJEnriSVq
         aP2P6THBr0qBVo1isfNxPqazpXfnxZ+Yx+BNg+LW258zBj4GyNv+2c9Tr8q+MtpD4m4w
         AndGf64LvwZkH7TgHmbb55Agh9AAo1uenZjz0vxwiQoFRq0JzZqRgVOC5Uh0yMuTeppA
         5cFEagwfqT0RxejaVAbVey5GdkD8aEjgUACacn6EKEl3ZQ7T/BL9UxEGbl/6b3CTv4rF
         SO/w==
X-Gm-Message-State: AOAM533TcyjK8PZV6R3i9ccdCMXKIF1u+3MrsjdoL+d/Ktjlf/yd1vMZ
        uKycYKz4E5T/+tuuXqjw7iNqTubaPCZtS/VpFbYByA==
X-Google-Smtp-Source: ABdhPJwnj80KfjLxwv8AaEb7D2zLfoOlzG74Ug0DbzTp+rJod5C1OcS6kTKxtX4tja/uKal7/4+ZcE5XsGF3eClVCZ0=
X-Received: by 2002:a0c:b741:: with SMTP id q1mr2995427qve.26.1612211477352;
 Mon, 01 Feb 2021 12:31:17 -0800 (PST)
MIME-Version: 1.0
References: <YBCFBivBLgqEAUr1@coredump.intra.peff.net> <20210128160453.79169-1-jacob@gitlab.com>
 <xmqqmtwsx4d9.fsf@gitster.c.googlers.com> <CADMWQoPgscKm2wVOo4uEqSSwgrZQTp7_eoMJpG=pdDmc1bJr=g@mail.gmail.com>
 <YBMx7yuBit8TecYp@coredump.intra.peff.net>
In-Reply-To: <YBMx7yuBit8TecYp@coredump.intra.peff.net>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Mon, 1 Feb 2021 21:31:06 +0100
Message-ID: <CADMWQoMap_wRTtcTbR8NeDWR6pKq876FEy3WdpFQwEkOR6E+mg@mail.gmail.com>
Subject: Re: [PATCH v4] upload-pack.c: fix filter spec quoting bug
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 10:51 PM Jeff King <peff@peff.net> wrote:
> I guess the argument you are making is that now that it's fixed, it
> _isn't_ different, and we're unlikely to reintroduce the bug. I can buy
> that, but I think we just do the "test the fixed bug" thing on
> principle.

Makes sense, thanks for explaining!
