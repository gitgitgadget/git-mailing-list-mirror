Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29292C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 19:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE27E611C0
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 19:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbhKETNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 15:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhKETNx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 15:13:53 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9ABC061714
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 12:11:13 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id i11so1235016ilv.13
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 12:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kEEL4L84xp19zILQM4IT//DX53eF8tLVyp+qu8Iz3oI=;
        b=3cK2ffO2z7QtIECycLY6Aos+Uc4rIItfnQp/xsJ8oDBe2pCOSc/gMa3gkbxv6nuapp
         YrRkLrfWF2+i08wUc6FXsQi85w7nOuvkFcxBANAUFZukQETcquCKgCj4GRG+lKfGSsCf
         iJPaiP/vAlps83QMXcwqJj8dCxJVbFTBpqxQuxKf/QS+6jNelrnc2v0vCivDN3kHTgU/
         qwPPmnjCZanC3HZwlUl3ZagKsuJniFAbxQ47SimhSFAX4RcykjZfiB+baZNIlCMyOqyP
         wa40ytOMDhZ4VXY9a23A6M1l76rG6kF/QhUWSoyDcvyLX6rbzDMXKo+KdDQTsaRBBUZs
         f6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kEEL4L84xp19zILQM4IT//DX53eF8tLVyp+qu8Iz3oI=;
        b=W9rUgE+UzSaJMzNEDMhK2yjKe4+JlcIuojQkdqV6KBhpR+BD6ljYuBxXnS/oDexNik
         4ZFq09F6W3qpsQ8FdvQygr5iCuapwkXDDuQOzMOrCTSMkqgmLiQsY9Hvjido8WsO7Pyo
         dIzMXG8H6B+o8gAl3WYLJKbyfEBEgraZcRUpjYWd+508taz/NnHlVDQq6LAiFLW7Tpc8
         C5Fmmokd1hPX70Ir05z2xyte19aEuT4hzlpxlamvY7G8SQodkkcfUs4R3t0x6RixDliV
         nSUTISp6tGVgiUacfFremDi1Go1KY/JgCGpb/VqmRt7raH6ferrVz3N7VNCV822mQZvx
         3fVA==
X-Gm-Message-State: AOAM531Q6CEbGJLPWd3sMnm1rQAfLEAzFTeTgZBCiMhm6GYnH7N32hgx
        rOxD6HE7GFHzVrTHGxPPmP4zJ5KdQO2pRw8x
X-Google-Smtp-Source: ABdhPJx0ka8VTX1JN/dCBv/5B6EqvtdU9KUjsWz8Uhvd9bMi22DZDUYuiP3E9HKfUyui/2oQ2jghJg==
X-Received: by 2002:a92:d706:: with SMTP id m6mr40512526iln.155.1636139472855;
        Fri, 05 Nov 2021 12:11:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y7sm4480685iov.22.2021.11.05.12.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 12:11:12 -0700 (PDT)
Date:   Fri, 5 Nov 2021 15:11:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] test_bitmap_hashes(): handle repository without bitmaps
Message-ID: <YYWBz6rjF+I+JkO3@nand.local>
References: <YYTy6+DG5guzJIO7@coredump.intra.peff.net>
 <xmqq35oaxwnz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35oaxwnz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 05, 2021 at 11:52:16AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > If prepare_bitmap_git() returns NULL (one easy-to-trigger cause being
> > that the repository does not have bitmaps at all), then we'll segfault
> > accessing bitmap_git->hashes:
> >
> >   $ t/helper/test-tool bitmap dump-hashes
> >   Segmentation fault
> >
> > We should treat this the same as a repository with bitmaps but no
> > name-hashes, and quietly produce an empty output. The later call to
> > free_bitmap_index() in the cleanup label is OK, as it treats a NULL
> > pointer as a noop.
> >
> > This isn't a big deal in practice, as this function is intended for and
> > used only by test-tool. It's probably worth fixing to avoid confusion,
> > but not worth adding coverage for this to the test suite.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > This is new in the v2.34.0 cycle, but it's so low impact it doesn't
> > matter much if we ship with the bug. OTOH, it's pretty low-risk since it
> > is only run by the test suite.
>
> ;-)

Yes, this looks obviously correct to me. Thanks for spotting and fixing
this, Peff.

I'd be happy to see it in the 2.34 cycle, too, but I agree that it would
be OK if it didn't make the cut (and certainly if it makes it easier for
Junio to handle the rest of the release cycle, then I'm in favor of
leaving it out).

> I wonder how you found it.  Diagnosing a repository that did not
> seem healthy?  What I am getting at is if we want a new option to
> make a plumbing command, other than the test-tool, that calls this
> function, as the latter is usually not deployed in the field.

I would not be surprised if this was discovered via Coverity, or by
manual inspection. Peff and I have been merging a slew of releases from
your tree into GitHub's fork and so have been reading code in the more
recently changed areas.

On the test-tool vs. plumbing thing: I think there are some compelling
reasons in either direction. There's no *good* home for these in our
current set of plumbing tools. E.g., the closest example we have is `git
rev-list --test-bitmap <rev>`, which is kind of ugly. When we needed
these new inspection tools for some of the newer bitmap-related tests,
adding them via the test-helper suite was a conscious choice to not
build on the ugliness of `--test-bitmap`.

But on occasion these test-tool things are useful to have "in the
field", as you say. It's rare enough that I usually just clone a copy of
our fork as needed and build it when I do find myself reaching for
test-helpers.

Thanks,
Taylor
