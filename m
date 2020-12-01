Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4794C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 18:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EEF5208C3
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 18:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="EhBJnPMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392264AbgLASfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 13:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392252AbgLASfV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 13:35:21 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D436C0613D4
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 10:34:35 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id v21so1602216plo.12
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 10:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5KUiZn07fiM7L5+Tmj0DNGuM7eN6CgFE0NqthSxBwcs=;
        b=EhBJnPMxRu3yen6o+nCWJR4YjcQTHR3D1C/htleEP9HgD8LhxsvSqNsoMJVPttvqVi
         047dU4blY+4s9yKcrpnFxLiW8Rnjb+a9e8c/Rs7hZG9zCzInGxjI+sX9p2IrMK9ysnVL
         4fkW8sKqIkUapu5aNxhr9522+LyUiNZn5b45dE6/zTI9UyUG3GEGE7enOlaGiiWegX78
         b4M+gbRgpqn7SJlZ72bK8vidgcg+gJkm38x5nFU43M+xqvR2KDhRuo/ntKINqY0mfISi
         HYp4MEtYSWpcavm2pz2MjzjJjMbbo+Zo+oubQIPDjnfYblvVuINtUXhHbYkSTRnCRV9E
         6H4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5KUiZn07fiM7L5+Tmj0DNGuM7eN6CgFE0NqthSxBwcs=;
        b=LMmiUhBNNsywQ4lec648RJ6fB0axdWi62uoE/CPF88JmN4sST6tyl0RWU6S26oWxOK
         o2HfeBg+0jNubZm60zC9rEUg8i1x6I+PP4337p4K/ynHzhReOPfYmUv5q99JBfF3z73a
         iBXwdFM4E4U2sUoL+TdOjo35N/EuFGZ0RhpsBDV5fHtL35nqOH1ay5ox4WNwvlVDt0xS
         qqal1jYC+l5qeiRpiYAoqvMigzhDYET6dQ4ZARnsBXp/rvb8aMnWr+CX4SL0yLMrGSO5
         TXYOCsiJ1LYf0E5g05f9T7XWGYHNL47GkNS/If18xFt+ccPCqPnh8xYYyRy2AWP7ill1
         hMyQ==
X-Gm-Message-State: AOAM533M8dEcX52DmpVR+Q1DoFpakcXEmxX2ROxUgubCTkeObPeLlnoD
        Mc6mW148yvmW64Q9ulg/jOLYSw==
X-Google-Smtp-Source: ABdhPJxcp2NzWw3N/o3fBY0treE5m+5waTn3jFWYUrmk/i+boNzxZxQOcYaKTHOjroTC3pTzj1nqFQ==
X-Received: by 2002:a17:902:b192:b029:d7:ca4a:4ec1 with SMTP id s18-20020a170902b192b02900d7ca4a4ec1mr4037230plr.76.1606847674593;
        Tue, 01 Dec 2020 10:34:34 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id z126sm464915pfz.120.2020.12.01.10.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 10:34:34 -0800 (PST)
Date:   Tue, 1 Dec 2020 13:34:31 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, emilyshaffer@google.com
Subject: Re: [PATCH v2] builtin/bugreport.c: use thread-safe localtime_r()
Message-ID: <X8aMt2LEiCLkdV9/@nand.local>
References: <27fc158339c91f56210f00dae9015da1d6c781ec.1606777520.git.me@ttaylorr.com>
 <73eb4965807ea2fdf94f815a8f8a2b036296ecca.1606782566.git.me@ttaylorr.com>
 <X8WqFynk23yWT6E3@coredump.intra.peff.net>
 <xmqqlfehqt4n.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfehqt4n.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 10:27:20AM -0800, Junio C Hamano wrote:
> I am not opposed to banning ctime_r() and asctime_r(), but I do not
> want to see our future readers wonder why they are banned by the
> commit whose title clearly states that we refuse non-reentrant ones
> in our codebase.

Agreed. Maybe splitting these into two (one to ban non-reentrant
functions, and another to ban ctime_r() and asctime_r()) would help.

Thanks,
Taylor
