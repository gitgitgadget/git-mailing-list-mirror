Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AD8C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 01:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 517EC61287
	for <git@archiver.kernel.org>; Wed, 12 May 2021 01:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhELBRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 21:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhELBRo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 21:17:44 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A386C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 18:16:36 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id i81so20836397oif.6
        for <git@vger.kernel.org>; Tue, 11 May 2021 18:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=qigpSMofsSlqkzzFI+3dwcGfMBMN8R4RyqepwM8I5pU=;
        b=SDI1WaXArEU+ShpGTqgbRjdkAPsI/IEovke3eVESUh+607/djriu1wquOx2v9jUh4s
         w0/tuIhON5c5UtwOjGeaSMiInHSafLY7UC4o7aJhec5U75RcRly2hPj7aMnGBQSdR9Jx
         hb7viGY03f05OnHJTegrCnI7FUXvvGdqAcrL40z1fRsyBuI0scs5WbI1QpLMpzwjUOtD
         ePnSHaNG2oX1dkV9PRlT/Y7JCjFns5rl74BHBYyVDF3XarV6lKNt6PSbDKos0fSUuse0
         Tg6pvpKQL8rEoMnkFn7fYPvuzY4uqwNAXjmKEieG2wvvp+CZD09i9WUHHsmPjYJZnHmA
         1Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=qigpSMofsSlqkzzFI+3dwcGfMBMN8R4RyqepwM8I5pU=;
        b=AsrC+QGV3h9g7Ipwl5EI7yKnVlih76lWNzPl66Q+FnjI8eNsYjYp9U1HA3yvoQ2PHB
         V9A/sG5hg0cee8/OwatlkpPGOG7UYEsYpv1hBPD48qJfDGyWm7XU/rCM4tgxz8uxE9Ta
         PSE6j0F0KrfL3fE2mGb4HWqG/PwTGFlMrBV0eHUsSk8hGlivj8ejHgVEBGhytXYl2ZHw
         To9+yl5b9CZuqVax6NzzUW9KqGk+bbgYx/ZUyfu7nL4oMfLMXDUlZv5Y/dVkRuxfvXGJ
         sn55k1SYkawXhBdWRcn4xKlAxTkoAQv85duAijewycdI71GMnDL3cTrRFLi6GX98XCrr
         BnBQ==
X-Gm-Message-State: AOAM5303ODody/72mu3ZtuYk3klrbM/gMrJ1TKxlCklVaRZo3cLet0UN
        2tdmBzOD75kfimi7oXu1ra5daMB6i9i5lg==
X-Google-Smtp-Source: ABdhPJzy/QMBaPrLwjFRM0ErRxDxdPyA6ZTdrWFQUbCxeBypgMnJRLuRVJ7G5vU/ncZ6DFliK5HYKg==
X-Received: by 2002:a05:6808:54d:: with SMTP id i13mr24674329oig.100.1620782195502;
        Tue, 11 May 2021 18:16:35 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id g5sm3569787oiy.24.2021.05.11.18.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 18:16:35 -0700 (PDT)
Date:   Tue, 11 May 2021 20:16:33 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Message-ID: <609b2c71c62ff_678ff208f7@natae.notmuch>
In-Reply-To: <87v97pnhi5.fsf@osv.gnss.ru>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210510153451.15090-1-sorganov@gmail.com>
 <20210510153451.15090-7-sorganov@gmail.com>
 <xmqqsg2toqik.fsf@gitster.g>
 <xmqqo8dhool7.fsf@gitster.g>
 <87v97pv04p.fsf@osv.gnss.ru>
 <CAMMLpeTL9ZOuHLhqonFOwMu8yC9bETMVzkCZ__F2JsR=0umL3A@mail.gmail.com>
 <878s4lqfbk.fsf@osv.gnss.ru>
 <CAMMLpeR0eeM1droa3sxeToxw+8ACtJM3+3=SkWR9qrWbK_9sDQ@mail.gmail.com>
 <87v97pnhi5.fsf@osv.gnss.ru>
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Alex Henrie <alexhenrie24@gmail.com> writes:
> 
> > I didn't know which branch the change came from. If the change came
> > from the first branch, it would not have appeared under the merge
> > commit with --diff-merges=first-parent.
> 
> The change in question either came from this merge, or it didn't. If it
> came from this merge, it will be there in --diff-merges=first-parent
> even if you have octopus merge and multiple parents, in which case it
> will be cumulative change from all the side parents.

Precisely.

The primary thing I care about is what is the status of the branch
*after* the merge. In other words; if I rewind history and I hadn't done
the merge, what would be diffent?

That in my mind is the actual content of the merge.

-- 
Felipe Contreras
