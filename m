Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5334C433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 18:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E2E2225F
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 18:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQEU6cEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgJSSHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 14:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgJSSHP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 14:07:15 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4241C0613D0
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 11:07:15 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id m128so886681oig.7
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 11:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nlroJzyMO3kB9i196sEEi0L0IR9xf0eARj8w3tM1woQ=;
        b=sQEU6cEzbzJX06+pI3eVnt3SXG3aAd1A5YF4r6nOwZqe4NUerXwnGgRAsxwKPZcZS7
         oidnTZM6+BfU216yOS6v/gxVA0otD876ExMqAw4AyMQHBHeKuLNxlDEFpiGJ7Kpkey4R
         /qYqPO02GCblCWZMjNPsekmGQX6lSGO/wHFchTHgSOgVb5c+knnTKG90vYXuiaXNAeKQ
         Ca4nrLdw9dA0ejz6Ii30R3l6JtB8N6VUaVcVMTl5+Opo6M5wvWzDJP9K7V1baGYZM2Sq
         r3UM5Ppppxi3SMSqpdvK3Uf1QC+0Y4dRvpYX7/KhwocTd8NYMm2VwCoXS2WfmDvsKutq
         fZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlroJzyMO3kB9i196sEEi0L0IR9xf0eARj8w3tM1woQ=;
        b=eT2retqCTI68FmHzUylh7yMazFPsDk7e6MSDcDJ0oWOrNVSmDg1iXOzOeAKXqhBNIt
         ybUoaAYcMCueG1m4HvcY3LFsHqS0Fj08LDqOBsGdDdpid/CeT5/F5qWZOr+v2hmxGhHf
         p+SACuoLqSZCp0F3eiOD5j4mNkqPO9JZoU53zKqqFliYU/YNpWmCKXnL/BKZVpeKj50d
         HXLDsDbr88jJa8vfD+8t/WnqEfCGLCqf8MPfsoHv5xq7rqrnlcSwRC6gU6bEnU0SPifF
         7J4iSbOX7r9O2inGXTBo7yJXZExuKRvpN00WtuIXbEESkgE6UB71lsM37CKGmHO2A/0i
         qonQ==
X-Gm-Message-State: AOAM532KSLRaKN24Goz3BW+PEuaRInuTNrL77b1VMiN37B8qMO6ol+VM
        kRxnd40R5+Woj02oLAZraz94eMEFAkq5mg2LU8vL8/DLICEP5po2
X-Google-Smtp-Source: ABdhPJyakYts3rcmqm4tZ4rQgNWuIH7o7PX2NaFgbGBotGW/JT6rhDinVpbpfl6E2AeIcvIXoacA/C0WXmxhEqh1qWU=
X-Received: by 2002:aca:ec0d:: with SMTP id k13mr433926oih.93.1603130834929;
 Mon, 19 Oct 2020 11:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
 <13fd992a375e30e8c7b0953a128e149951dee0ea.1602968677.git.gitgitgadget@gmail.com>
 <xmqqeelw8p8i.fsf@gitster.c.googlers.com> <CAN8Z4-W=+D-P_qCYijGMnStY-EGwKFx-+AYzjACDPAXnLRAA8A@mail.gmail.com>
 <20201018041642.GB2262492@nand.local> <xmqq1rhw86ur.fsf@gitster.c.googlers.com>
 <20201018234344.GC4204@nand.local> <xmqqr1puuo35.fsf@gitster.c.googlers.com> <20201019173724.GA42706@nand.local>
In-Reply-To: <20201019173724.GA42706@nand.local>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Mon, 19 Oct 2020 19:07:03 +0100
Message-ID: <CAN8Z4-WyrhzeQGzNpQvCYYBSif_1NghFWwJvS1gXppQna6eC0A@mail.gmail.com>
Subject: Re: [PATCH 1/4] fsmonitor: use fsmonitor data in `git diff`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alex Vandiver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Alex Vandiver <alexmv@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It brings us back to the "overhead of how many lstat(2) takes us
> closer to the overhead of a single pipe+fork+exec plus reading from
> the pipe", doesn't it?
>

I will add a benchmark for a `git diff -- <pathspec>`

> Somewhat unfortunately, yes. Hopefully any user that cares to use
> fsmonitor has enough files in their repository that a pipe+fork+exec is
> still faster than however many lstats they would have needed otherwise.
>
> Of course, finding out what that number is is still interesting...

I can try to do some manual testing to figure this out. Doesn't seem like the
type of thing we'd want to add to the benchmark, as it would involve running
git diff on a variety of pathspec workloads

--Nipunn
