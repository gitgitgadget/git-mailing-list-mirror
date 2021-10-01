Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C4AC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 02:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5626128C
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 02:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhJACdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 22:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhJACdl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 22:33:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF2CC06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 19:31:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id l7so5511016edq.3
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 19:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MmU4021zoE5wt41zXWrr/3RIXya3fg+O+6Zm+/0RRRg=;
        b=iHyACwc64DI0y6bNMQVnL92iK93Thk4Ftx9EJiJRgR0RaMImmlpt0j0pMGGs303YTh
         q0RbYTR7QR5YMCr0pEGX7yq6S0ec+uq6g8eK/VX0JB8jk6trrPBPqIadSFU3FyGeUD0W
         3iYuEHsg4WtKrMfuba4ZhysJ0hFYBcDedmZJZALsj2gRBGU/ix810eKxKVN3BEZhqF8w
         u5rezwHPFupm/YzIHD/vpTjj1dgu/dTOnoYv/ivBe2ReJIBgdM0damvuiBkF+jxJffef
         sw8JYJz9qkkkWgho8rWjS35RtlZ/Ep9OwrJyudCn60gM0N0tEQiy9E4/OCMhm3JDL7ms
         3YCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MmU4021zoE5wt41zXWrr/3RIXya3fg+O+6Zm+/0RRRg=;
        b=wzNOGGsYMWFpN1w7ruLCgOBwHOX+MQVUST+oGr1tu58dPftxEmzCVMP/7gGxS62Bib
         +8d568hXe7BW5ZQA+ng/Gp4fcqgNDWouo9UztYRYGY5jIJx4nEFqRysyBeD7BpH/V338
         yx4+W419XSLOtWyjcvITCzRoIF9TJoNvI8WWhhbf2nmQ9Ukn9GPQBerrq3/IVef8lVh2
         dzcwo3+J2G3ICsrTV+IPfmRtBOgUBD/J2daQ6e42zM/IrI4sSOP3v+E6x86Zj1JXTwra
         6vE6bVVd1qbCGGNSIwQlhnkiqIJgMGxjdqNnAQdKYB7z4ljUUXZcdlOInemLIuqT4qPa
         NdQw==
X-Gm-Message-State: AOAM530k1e7J9pFGO2pNk9XBhAU++BqNsQ6MwEDNlre15OwIDkJFh8nY
        OTMUHLMFkT7ueCncD40r/cAd1lkNSyslqDa0ik0T92EP2A4=
X-Google-Smtp-Source: ABdhPJzluHsF9f9FaIBbsuEMgU9P5paAssbrS2AG9m+sliTohwBYscs68EiymdJRgfNRFHsut42iz8t6rDPsp6nvrQI=
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr3337800ejp.520.1633055516532;
 Thu, 30 Sep 2021 19:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <YVOiggCWAdZcxAb6@coredump.intra.peff.net> <CABPp-BFuj3W20J-aKU4BL9cqgA-GPZ2prEbAebY_kR0adaGzHw@mail.gmail.com>
 <YVVmssXlaFM6yD5W@coredump.intra.peff.net> <YVVrY0/kXfWHCWJ1@coredump.intra.peff.net>
In-Reply-To: <YVVrY0/kXfWHCWJ1@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Sep 2021 19:31:44 -0700
Message-ID: <CABPp-BEqcq0wYqNP1xUJj8+E5HUTnip7+asadRoeFLAZ34rTdQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing primary
 object dirs
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 12:46 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Sep 30, 2021 at 03:26:42AM -0400, Jeff King wrote:
>
> > > > If you remove the tmp_objdir as the primary as soon as you're done with
> > > > the merge, but before you run the diff, you might be OK, though.
> > >
> > > It has to be after I run the diff, because the diff needs access to
> > > the temporary files to diff against them.
> >
> > Right, of course. I was too fixated on the object-write part, forgetting
> > that the whole point of the exercise is to later read them back. :)
>
> Ah, no, I remember what I was trying to say here. The distinction is
> between "remove the tmp_objdir" and "remove it as the primary".
>
> I.e., if you do this:
>
>   1. create tmp_objdir
>
>   2. make tmp_objdir primary for writes
>
>   3. run the "merge" half of remerge-diff, writing objects into the
>      temporary space
>
>   4. stop having tmp_objdir as the primary; instead make it an alternate
>
>   5. run the diff
>
>   6. remove tmp_objdir totally
>
> Then step 5 can't accidentally write objects into the temporary space,
> but it can still read them. So it's not entirely safe, but it's safer,
> and it would be a much smaller change.

Interesting.

> Some ways it could go wrong:
>
>   - is it possible for the merge code to ever write an object? I kind of
>     wonder if we'd ever do any cache-able transformations as part of a
>     content-level merge. I don't think we do now, though.

Yes, of course -- otherwise there would have been no need for the
tmp_objdir in the first place.  In particular, it needs to write
three-way-content merges of individual files, and it needs to write
new tree objects.  (And it needs to do this both for creating the
virtual merge bases if the merge is recursive, as well as doing it for
the outer merge.)

It doesn't write anything for caching reasons, such as line ending
normalizations (that's all kept in-memory and done on demand).

>   - in step 5, write_object_file() may still be confused by the presence
>     of the to-be-thrown-away objects in the alternate. This is pretty
>     unlikely, as it implies that the remerge-diff wrote a blob or tree
>     that is byte-identical to something that the diff wants to write.

That's one reason it could be confused.  The textconv filtering in
particular was creating a new object based on an existing one, and a
tree, and a ref.  What if there was some other form of caching or
statistic gathering that didn't write a new object based on an
existing one, but did add trees and especially refs that referenced
the existing object?  It's not that the diff wanted to write something
byte-identical to what the merge wrote, it's just that the diff wants
to reference the object somehow.
