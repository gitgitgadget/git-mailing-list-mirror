Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37ADC4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 23:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKTXwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 18:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiKTXwm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 18:52:42 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A83FD3C
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 15:52:40 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id i5so4983751ilc.12
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 15:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lWIiP6I2MR98eJfy8alROcZCs2fvzo9QPPHsUqvCTvE=;
        b=8HUhUrbCQBNanuGfLJXI/aPYn+/oizmMBzi7li9p3t7BfXfDWdD4+oPAcUtgh4lfHP
         xmhRYUrvAku4BRz2UUVj+YbIG1/smZ3z4+NOkDHM7Gk+wS0xjprx4ioFdngwVMgMXQDE
         ffZoysaJ3hBYEfSol6OAcIm6axn4Y+sb2AXAZM9DN+Zh0hsRRIOGY7eQob4he1g+bJuN
         PWm49zPS+Q2ydqc1fjFiCIjBWmTk2qlHT59YswWnpmqoVyScY4nkfq7oPGhcXg8QxoCd
         ti7ykdWQVKH249QU9gHXGDsAD/qeoQ3/eKl6OFcO+yZ0vnActJsMJU5keYbtVwZWFA5V
         zUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWIiP6I2MR98eJfy8alROcZCs2fvzo9QPPHsUqvCTvE=;
        b=B7P0SA1LYjjORl6uye3n6BJ7gtWnCo8sOk+NjXDhtzr76KtVkzSCfgljJ1U3ivY0Vh
         W+aZ3VJG7xrzvsIiLue4cEPbAotwI+OvDXdc/ZdQyHZpW0sOB0Ph4q1skZSzo/7F4ZZl
         Nd3V3Q3AKFhkWrX7RGXE7L6az0HEq7rNiT/35Pe0EWMY6p6FUn+6HIIvbDFP+u95xwaY
         nUF3Zq0MB+STSRbMacV1zcDu7hH17qUiq6m0DPB/vZwIJZAs+209wL73h6hcUCi0CCR9
         uY01QIFQWGHL4pWS9Rau7UbAy2xiZr4Gdd2vyS79u8yun3tJYYYSj938XruVc6PCBSIS
         zyvQ==
X-Gm-Message-State: ANoB5pn+aZgPzaLttHeYcQZsuwdL3U3E5crMk7hA5XG8Aj5RSrnGC18q
        qvvfzoCmqSt4t3iHBdDO7xuyxh04khyTyQ==
X-Google-Smtp-Source: AA0mqf6r2O/sEjzCt4kAb+8FvJlg6ZhduK9RfbTd9S3F3oBw2m+a1cznRvMC+KLXGtSWIMTe+ptE9A==
X-Received: by 2002:a92:cd0b:0:b0:300:b6ac:3919 with SMTP id z11-20020a92cd0b000000b00300b6ac3919mr67873iln.176.1668988360165;
        Sun, 20 Nov 2022 15:52:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d2-20020a6b6802000000b006ddf70e3ce8sm3686051ioc.7.2022.11.20.15.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 15:52:39 -0800 (PST)
Date:   Sun, 20 Nov 2022 18:52:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #04; Fri, 18)
Message-ID: <Y3q9xrq5u9YSuVQC@nand.local>
References: <Y3g95OYdwzq2OP3z@nand.local>
 <xmqq7czp1a6y.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7czp1a6y.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 08:24:21AM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > * ab/various-leak-fixes (2022-11-08) 18 commits
> >   (merged to 'next' on 2022-11-18 at 8828bb7161)
> >  ...
> >  (this branch is used by ab/merge-index-prep.)
>
> > * pw/rebase-no-reflog-action (2022-11-09) 2 commits
> >   (merged to 'next' on 2022-11-14 at 790dadc8d3)
> >  ...
> >  (this branch is used by ab/merge-index-prep.)
>
> The other topic referred to is not described anywhere, and not part
> of 'seen'.  Intended?

It was merged intentionally via 790dadc8d3 (Merge branch
'pw/rebase-no-reflog-action' into next, 2022-11-14) as you note, though
I'm not sure why the description from 790dadc8d3 didn't make it into the
WC report.

In any case, the description I went with is:

    Avoid setting GIT_REFLOG_ACTION to improve readability of the
    sequencer internals.

Thanks,
Taylor
