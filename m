Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 119E51F453
	for <e@80x24.org>; Thu, 18 Oct 2018 00:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeJRIYS (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 04:24:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34972 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRIYS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 04:24:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id 22-v6so22635596oiz.2
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 17:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VO7OZbSpIQd4Deol9pr7jMT1miXj6EkGlzx+GqvBQQg=;
        b=HWef2Yc6MXnanNm8fuUUL3Q2gCYqviWSK68195OfIMY7FI++fgH6tEKY+IuGseQ9w6
         P880dL/I/I6fxMHdF5vYofxvYhI+z+rXeRRg1gqUl2Xa/3is8UbMlILzCw8sFMPVLpMe
         vrRSu3I6flVm0K1GTyIS7iThG2BnxPu2Cu55ksUO53CGgNjLEscvK8O+gb8kBh9tpO+4
         O+fvrqGxv0fes2z+A6zw6CMVivl13IbR7m2f5IazF9mOJiPmdIOlJ246axxXJ5OitMgo
         RxnSbJeuc26WSyrkNdIgTpeBp+fcWtamDzmKvLsPfUJNJUIyqzl/A4nsV38hbL5yQOgq
         hl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VO7OZbSpIQd4Deol9pr7jMT1miXj6EkGlzx+GqvBQQg=;
        b=PRxUJctly/rjgQWOlhclI405ziu4zPXWn7rnMnRqg5fLCIkVGHwOqCqiRfEjZtgpSf
         lh4XwbN2e/PB89rVSDSt6UPeZYnSBWDBjxeBEgMqV/rMMZh0+J6oV6qQDSHKkDfhCwL3
         yL8N7T8pf6ZxY0ZpJOQ80fiatZjR4iPFj9NscwguKo8J2Ovzld0Ura0OVSSAj7qJWEhS
         f7kKnibmnweGNZaYvVEYh7CnI+hlosCrkWyYlSY5Cgzo0a8y16eNq0qkgJGT2THCQ6jd
         KyvXIXaeDNVx69T63skjnqWcLfF0ig5yI4FaHhMLrRw9i/NjHi8LNi6weCOf+wgTz9TX
         1pDw==
X-Gm-Message-State: ABuFfojSx4H7GogUHhuUD7u9OTVhyHyYrPIETDaqBQBypgxCDtpd7b3Z
        v6ujEF3DaQby/exBMbdkkll8dKQRhivvss6ZxKVI
X-Google-Smtp-Source: ACcGV62b5aD9ERl3FNOwhtQR5sDqYZmpNDP1rBJUxSV1tzgJR/k7LmahOAaOpQOMM4pIbswXVqTCe9jndZrtJzbNMqI=
X-Received: by 2002:aca:cc12:: with SMTP id c18-v6mr14728808oig.150.1539822363274;
 Wed, 17 Oct 2018 17:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539298957.git.matvore@google.com> <fe4cf0841d500a46ad8f10c00818b467023d0ffc.1539298957.git.matvore@google.com>
 <xmqqa7ng86i6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7ng86i6.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Wed, 17 Oct 2018 17:25:51 -0700
Message-ID: <CAMfpvhK=CgamUGTa9b308WRA1Dw4w0Qbt8a4LiKVLFaW6nMwBQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] list-objects: support for skipping tree traversal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 14, 2018 at 4:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> This step looks more like "ow, we could have done the tree:0 support
> that is in 'next' better" than a part of "here is a series to do
> tree:N for non zero value of N".
>
> If that is the case, I'd prefer to see this step polished enough
> before [2-3/3] of this RFC is worked on, so that we can merge the
> tree:0 (but not yet tree:N) support that is solid down to 'master'
> soonish.
That's fair. So I will prioritize this patch above the rest of the
patchset and send it separately in the future.

> OK, so "not collecting omits" is synonymous to "N==0, we aren't
> doing tree at any level", and at this point in the series before the
> support for N>0 is introduced, we'd always take this "else" clause
> because tree:0 is the only thing we support?
Actually "not collecting omits" and depth==0 are orthogonal concepts.
"Collect omits" is the logic needed to implement the
--filter-print-omitted flag on git rev-list. You can do this when
depth==0 (it will actually print all the trees and blobs recursively).
"Collect omits" is tested *with* tree:0 in test t6112 in the test
labeled 'verify tree:0 includes trees in "filtered" output'

IOW, both branches here are important even in this patch. If we are
collecting omits, then we can't skip the tree because omits collecting
is recursive. Otherwise, we *can* skip the tree.

But maybe printing omits should not be recursive? The decision was
never discussed. The code to not be recursive is simpler, because we
don't need this if/else. Recursiveness is counter-intuitive since we
would "skip" a tree and at the same time print its contents.

>
> Style: our modern style is to use {} around the body which is a
> single statement on the else clause when the body of the
> corresponding if clause needs {} around (and vice versa), so
>
Fixed, and I didn't realize I was supposed to be hugging "else" with
the curly braces. What you say is what CodingGuidelines says to do.
Thanks for pointing that out.

>
> Even when failed_parse==true, i.e. we found that the tree object's
> data cannot be understood, if we have skip-tree bit set, that means
> we do not care---we won't be descending into its children anyway.
>
Yes.

> > +# Make sure tree:0 does not iterate through any trees.
> > +
> > +test_expect_success 'filter a GIANT tree through tree:0' '
> > +     GIT_TRACE=1 git -C r3 rev-list \
> > +             --objects --filter=tree:0 HEAD 2>filter_trace &&
> > +     grep "Skipping contents of tree [.][.][.]" filter_trace >actual &&
>
> Here you are not jus tmaking sure SKIP_TREE bit is set for some
> tree, but it is set when base->buf is an empty string (i.e. the top
> level tree)?  Which makes sense, and the next text makes sure that
> between the two commits, the number of total "top level" trees is 2,
> but I wonder if it is more direct to also make sure that the code is
> not even seeing or skipping any tree inside these top level trees
> (i.e. the same message but for ""!=base->buf should never appear in
> the trace).
Makes sense. I added another check in this test for other "Skipping" messages.

Thank you for reviewing.
