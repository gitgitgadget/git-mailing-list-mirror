Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA693C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0CB961206
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbhHXWLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 18:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbhHXWLL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 18:11:11 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523E3C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 15:10:27 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id j18so28236412ioj.8
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XmdFsDSt9v0UH51iG7dBDi27CF4ApgRuH1vOlkgga84=;
        b=1izLwmJRwihGu6PKfxXS942YODpPT1P972APjqL6VCffoBnefZt0BQFLSkWM9iJnvh
         64sPLWMoE4WnS3LbywsaogAedj1T8iXYXEd/fM2fiMtHdMMXJL2by29iBM7i7Kg5Fd2P
         Q7WwjZNViib+vBwV7tEldpsjQMmYt6+e7d74vksJYHo9zzeU91GxLHaM1dHT9TnhDvEd
         yRCFi0HRseCPG06T8uL3q0oPY2Yk6gN6t8HhinM/z3Hr6T/G/qbUomAgBOiHRThfBtpa
         HBft6YoyPtUVZo/GmFgnypyrVFcXEhSKzGa4AdDULJ3CgeWAA2ZhnpkS08AMfDOX4Qhs
         XMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XmdFsDSt9v0UH51iG7dBDi27CF4ApgRuH1vOlkgga84=;
        b=pJrZI/o4ttc/nUTM1WxO2UMXhYSKn3ENk11xjLY7dWBdbj2ZWxogTi+4uarfQZlkk9
         bH1orymInG4a4TLQpQerwlWVGFq1f6eM14wNQjKl9JbTqnznW2wV6HrYiyK0J9d2J+ym
         mPHspUX5OEK5D1eNGyFlJ4zm08NzEKtM+E7xBkBoQfzCtXDrlovkAggD/1ED+DHjJdsf
         hHyR1XHDWe5aEF5bx50/Fo2aPoP+r9vM9W03Y8QAChSsDOpGJg/2NF0woYXUP/0wCatK
         QqjORzijj4BM2/VaTTPcYa3kRoriYb5h057B6a8JYZyidKT6UgXbcfE5QTvFF44YbOuT
         7Sag==
X-Gm-Message-State: AOAM5314GX+/ZBthKsE3HVSN/QYAot63z2qsx8QG18l9LI5u/4CG5hDC
        ZOmxX+DlUHcdFQQPyGyCpiA9rg==
X-Google-Smtp-Source: ABdhPJy4I8dOSSlAUcwj9mNlFJz0yAmRjV4yUJgTYRMCJE7YbRJrtWbjBMZfbPTFzkCg1lTM3bdCnA==
X-Received: by 2002:a05:6638:5ae:: with SMTP id b14mr36809608jar.80.1629843026808;
        Tue, 24 Aug 2021 15:10:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c23sm10719882ioi.31.2021.08.24.15.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 15:10:26 -0700 (PDT)
Date:   Tue, 24 Aug 2021 18:10:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
Message-ID: <YSVuUYFh7lmhNlEy@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
 <771741844be3570395abfda813ed5ef2fa78332e.1629821743.git.me@ttaylorr.com>
 <xmqqa6l6oafd.fsf@gitster.g>
 <YSVX18UXh9vX+Zhp@nand.local>
 <xmqqr1eimtrp.fsf@gitster.g>
 <YSVjnSDaBXgXvT9W@nand.local>
 <xmqq35qymrcn.fsf@gitster.g>
 <xmqqy28qlcow.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy28qlcow.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 03:06:55PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > FWIW, here is what I have somewhere in 'seen' where two topics meet.
>
> Oops, one change missed.

Thanks; that matches my own resolution. I noticed that it does fail the
new test in t5319, since writing a MIDX wants to make sure that we are
only touching an alternate's object directory (which will fail if we are
running `git multi-pack-index` from outside of a repository).

My opinion is that we should require being inside of a repository to run
the MIDX builtin. Otherwise we're allowing that command to modify any
old MIDX, which doesn't make sense.

I think we probably need a single unifying topic, so I'm happy if you
want to discard one of our two topics from seen in the meantime.

Thanks,
Taylor
