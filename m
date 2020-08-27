Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7412DC433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 20:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A02D20825
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 20:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQWlDjDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgH0UdE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 16:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0UdD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 16:33:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36982C061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 13:33:03 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o21so6232437wmc.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 13:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QizZvYNSYlECH+tra4ITyh+FwZQ3DickBG+Yb536ahQ=;
        b=RQWlDjDkzuXlbat3XNUxwKuMKskf50hIKa3Oi/siumW8+jjJLMCiLb/wHGrSw1Sh13
         ECsevco1A8eWzbSJ6Z29Five4qAEF2b0fLkVkoGfu8tnj3HV0I7sP9Nd9eD1Z/ciIYU6
         t0jtc1lhenLkEzV0gSp2b5HQLFIA8xGZI9YV2UynpnilpDVOtH47iR2kDySdyhm2fa/K
         7hwS6Jv+QRREqPGhDERPTZCY22xPl5j4pGxtOo44Y529xb6WIeGpe0n55DG0V60TTlPI
         FaybeY5E2OL1R+EFjgpJ+8vY6BSbmESCo0t482g1vqlVSiKGu4FbLfd8xNOxI/Lww2mK
         d/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QizZvYNSYlECH+tra4ITyh+FwZQ3DickBG+Yb536ahQ=;
        b=RnqiL52zyZguP/3Q0lkR/WYR6ormRrNh3zMLs76EkoJejcq3MmGpgQd/3RXg0P3GIM
         lYgCPYvpF049XHGxuejwa46jbkU4SNl7IVVEKoZhj2jbL1V1GMAyisXBa2iXRjwNLUv5
         2cqotBV+t29jtlkPCXlReIakgcuuZCPK/FAWHNMX+PfvJQoCSagRI4XYH1tMERTCisPu
         Wei61zYo6el0tkf/o/1I/M3+qoXGdvgbwARdy+kvdqTp4t3uX/rq5HYnS2QuEfVZUD0d
         ovYFCE5SV5aeLYNgasM9qQhrYQLcoQ/r+Vg/QT3h8D1QbEeSxYJ9M3SOxptAG84ECZAw
         fE4w==
X-Gm-Message-State: AOAM530AhRYus7X7mt99m0EBC6vR39lpDgJ029p3CNChaBWkGJ1OKgh9
        BuYiIXLRdo++1i1Q/ItI8w0xzYZ5FM3rqX7fayE=
X-Google-Smtp-Source: ABdhPJxIcT2yHUZ+q6XsMWa3j53yWVXEZnUaMdFz5nqgmFTRw03hh0S0trI0J2z32zu3vnwhKuv0TraqeQHW6h8hcXM=
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr583640wme.171.1598560381752;
 Thu, 27 Aug 2020 13:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com>
 <xmqq7dtlt080.fsf@gitster.c.googlers.com> <xmqq3649szs8.fsf@gitster.c.googlers.com>
 <CAHr-Uu8umDQJ=LORaBNJX+wnmaeM1hHxxpG7xROPgCqgEPrwdw@mail.gmail.com>
 <CAPx1GvfSt=s5VP9_+ZtndHWaBZ5W7nFxAf8bTF2tXnJkS95Dfg@mail.gmail.com>
 <xmqqzh6gqe7i.fsf@gitster.c.googlers.com> <CAPx1GvfXOMFDsXE74LiG_BG5Bqb+seHDWX69xGe49C240ORi6A@mail.gmail.com>
 <CABPp-BEEmqdt2_OuNQFxyf6pkppBWptkcvuAYhWX8r+_Wr8-2g@mail.gmail.com>
In-Reply-To: <CABPp-BEEmqdt2_OuNQFxyf6pkppBWptkcvuAYhWX8r+_Wr8-2g@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 27 Aug 2020 13:32:50 -0700
Message-ID: <CAPx1GvdQKw-4yjNMfqZtDQUBg3-dGbkPpV+0FyjJx-a3bQaQ-Q@mail.gmail.com>
Subject: Re: post-checkout hook aborts rebase
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tom Rutherford <tmrutherford@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Thu, Aug 27, 2020 at 12:07 PM Chris Torek <chris.torek@gmail.com> wrote:
> > The *last* checkout from the finished rebase perhaps *should* [invoke
a hook]

On Thu, Aug 27, 2020 at 1:11 PM Elijah Newren <newren@gmail.com> wrote:
> What do you mean by the "last checkout"?  I believe a typical
> non-interactive rebase of N patches has only one checkout, and I don't
> see why running hooks for the starting point is relevant.

I meant for the final state after rewriting the commits -- but that's
actually the post-rewrite hook, not the post-checkout hook.  I had them
conflated mentally when I wrote the above.

> If hooks are wanted for rebase, I'd still want to have rebase-specific
> ones, because most people who think of "checkout hooks" or "commit
> hooks" probably aren't going to think of them the way rebase or
> cherry-pick happen to use them.  (And that might even be more true for
> --interactive and --rebase-merges cases.)

I agree with this.

Chris
