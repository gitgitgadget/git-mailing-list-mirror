Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0077C433EF
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 21:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiAZVAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 16:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiAZVAg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 16:00:36 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC53DC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 13:00:35 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x11-20020aa7918b000000b004bd70cde509so451870pfa.9
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 13:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HANCPIZmfbFDNekG3RRhAm3gmUtjIwIr7wZrU8vHihs=;
        b=QeqWY/DTcwqPZDEa+mtPVkzCsPZQpcU41RAxxXxu7sRgRNeE0w7To2SMlHp/qMpPOO
         n1ccn2V+Ft3gvOFpX3C3lc41ijVbdZeSBXVL9dO/jl2ycHHZxW/0OdECHfdunJZ/p47j
         VMLdGRkwTNZ8LpUUqwCy2ejpztMTzemqqjl2NaM/ciyvifXiMc+xxggGze3NkWF0XOgB
         1SzKvqjl/skBHHdKr+n1phlis64XTx3j/hXGPqQ2FhMXGbLxyLM6RaI/y0YfI1PZdltC
         TN5UtmDMbEKnCV6yFKgfHZllunDHLVjtYOgNHNLhBL8aIsljHMmPRBBDL1kptqFRhUgw
         dLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HANCPIZmfbFDNekG3RRhAm3gmUtjIwIr7wZrU8vHihs=;
        b=KLp70t/WnTmXvNAUu/8I6rmKT9bRw4oAQ/7gt0BZcz8d+6zkE5uPEpihCPx+5QDmQZ
         fez/8SZv8AQ8bVcXg3JKSUwFGkujd8W22melXmeTbNLKPT9xHT29xaGmJ+JdnzAVu5Qu
         NhGCv5BxsHqS5LI/cuK+iQbaok/AFljf2THyZRvGTTByTwpTahHIAPrKcd722BhJ4sDL
         nhrVrD+yMSR1wdlbXCgVX3KU8qg9MTPCWJis3MBO5bzcmLBvsiQFw1gJVY05iV0NNod8
         pb9rn3t0oxhXDOnIjBsgJbnTtVnOq6TstiDRZfWOav0+hgmf2e2D+gwmdxiU6PFW6HOj
         /GFg==
X-Gm-Message-State: AOAM5303utoYAdYDAVJHKWfQHq1FOAz+8wvgwopPFhQODf5+VuSVI/u0
        OO6JoMc+B2+yrPVcdZBk3kz1zwjbFlGPy83gZ9kn
X-Google-Smtp-Source: ABdhPJwI6yLlxc/JZCP/4vCOE51xdva3X+Zn7ETrwoYdxeRLPpNahH3aQAeOw/Qx6kq2rQWTtwwDmTPI43OjWEfsowvM
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:8218:: with SMTP id
 k24mr565235pfi.77.1643230835385; Wed, 26 Jan 2022 13:00:35 -0800 (PST)
Date:   Wed, 26 Jan 2022 13:00:31 -0800
In-Reply-To: <YfBuUBOjWpvVOE/9@nand.local>
Message-Id: <20220126210031.2855730-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YfBuUBOjWpvVOE/9@nand.local>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: Re: [PATCH v3 7/9] t/lib-bitmap.sh: parameterize tests over reverse
 index source
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com,
        stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> > In a separate commit after this one, we should do it for the other
> > blocks.
> 
> But I'm not as certain about this one. The tests are already separated
> into two different test scripts (t5326 for the in-MIDX .rev file, and
> t5327 for the external .rev file). So it should already be clear based
> on what test script you're running.

Ah, yes, you're right.
