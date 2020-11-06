Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF1DC388F7
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 02:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DC920782
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 02:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSp5yZWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgKFCmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKFCmu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 21:42:50 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466D8C0613CF
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 18:42:50 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id v123so6143ooa.5
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 18:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rT+1lD0HAulJnE1Cph0NPrdc/nE4cM934lzyZzlGcwc=;
        b=oSp5yZWxlSE2+qn2Tl/Q/dHcrlHVxxx+aRnQlZbSjadST4putSGLOwY7N9BQmzToEb
         +6YQPuxXdD2KDlTIwVn6fCmKXeamxtULs9llrOT1q07wZ3ooat11/g2M2ny7KWM0DyJ0
         f9l0Gha6mBahMBGBG8hGL03oGD7pryCL0eqKnHjN4cRfcbXxqkoZ278910vXw4aYyyB8
         hXvBUWbjFB/liDvBuErhOcJJgokpXqgctTEjXRKBiM5tOfWaBaXs+pozaeh18f0tgVhM
         w4i2kV3mvLCXSENzqdgOeSXPEi2mpKpkfXtzDTJrdXMwuPFH1fdhiXbWWIXAM8TPLTy3
         BBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rT+1lD0HAulJnE1Cph0NPrdc/nE4cM934lzyZzlGcwc=;
        b=bWAEUGr8Qx5RwKluosAZ/BLgIBMD1Bw1wVvZCBnlSiUwgEOaw8vELL4y4kHFUxHxGp
         ilVR7J1V85EPq0Lk/4rwScrKvGezPmvsb+AZaAQrkpd/EoZXeFgttWHFnjWCfJ6rq6lw
         STpPzlfaoTc7GJOsl/PhmWvQSmoSHg9t+8ipCaC0PFHH3MmKaM4DGJWitAY5Cph1zjI2
         5M3VWJ6zg+PGjwF1zQB17FXbWYOupLbUZE9YYdQBRH8rC0nuk/zDRx70xQRInV9QRfgH
         vbJYQUtHuzLxAcr9EBmTlRAcO1uepWLQPbN7LQ5E3OkNYzBsc3upIicRjygCMh20FAD/
         KaXQ==
X-Gm-Message-State: AOAM5327g/DzmpUn6etgxCKFtZgI+oq1IBDqP9iBEtvRZBFdnGT+FCMr
        Z5vF3uSvywDkWsZ7W3nDXlbG3hpM9B5zrtQB0mA=
X-Google-Smtp-Source: ABdhPJxZNTdKQSN9G13P4QwrpVTKbHP5Na2LBAbZQwwlVif8Hu7O6RVK5zlR9AzBJq4qcImP3U6qiM/azJYWeCffbLg=
X-Received: by 2002:a4a:b308:: with SMTP id m8mr3896342ooo.7.1604630569458;
 Thu, 05 Nov 2020 18:42:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
 <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com> <xmqq5z6jgs6f.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq5z6jgs6f.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 5 Nov 2020 18:42:38 -0800
Message-ID: <CABPp-BHoaqGRbfM=5SZ4+s1hQa9eRQsi4kMAb3cZFrP+dqHM0A@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] Add struct strmap and associated utility functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 5, 2020 at 6:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Changes since v4:
> > ...
> >  * Add a patch which updates shortlog to use the new strset API.
>
> This makes my life so much simpler ;-)
>
> Would the implementation be very different from Peff's that you can
> take the authorship?  Thanks.

Yes; I didn't use his patch, I simply implemented what was needed from
scratch.  I'm not attached to being author of this though; the changes
were trivial.  Feel free to change as you see fit.


If more detail is needed...

There's only two things in my patch: (1) deleting a bunch of code, (2)
search and replace strset_check_and_add() with !strset_add().

His patch has three things: (1) deleting a bunch of code, (2)
introducing strset_dup() [which may have been a copy of my
implementation of strset_check_and_add() from an earlier round of the
series; the code is identical to my implementation, but it's only a
few lines so he might have just reimplemented it identically], (3)
search and replace strset_check_and_add() with strset_dup().

If I were to modify his patch into mine (which I didn't do), it'd
require two things: deleting the strdup() definition and still doing a
search and replace.  In other words, it'd be approximately equivalent
work to just doing the patch from scratch.

Further, I wrote a patch that was nearly the same as my current
submission a few days ago, but it used my old strset_check_and_add().
It triggered some weird windows bug that I think was an infrastructure
flake, but I was worried at the time that it'd require familiarity
with shortlog and its tests to address.  Since I didn't think my
series really depended on that change (shortlog could change to take
advantage of the new strset later), I just dropped it.  Then after
further reviews, the series changed a bit more, and Peff at the end
added a patch to reintroduce strset_check_and_add() with a different
name and use it, then you suggested to modify strset_add() so it can
just be used directly.

So, at the end, taking my existing patch that pre-dated his submission
and tweaking it was the easiest route for me.  I didn't actually look
at his latest patch until after you asked if it was okay for me to
take the authorship.  I see it as two similar from-scratch
implementations that were nearly trivial in either event.
