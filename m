Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D749EC433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 08:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C292053B
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 08:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5gjo7JK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgGGIkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGIkX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 04:40:23 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA87AC061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 01:40:22 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dm19so31437394edb.13
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 01:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KPzwSWn2/wgp15e3XwYNn7VQbY++zh5yF1KY+FV+Z8k=;
        b=b5gjo7JKPdZl8V2EdJc4kqbVkyOXWiPSUdQkzpX0VeU5DwzlAXN25tZSYLhJB8S7iN
         BnHEMLYQtD5nUfz1GoRmcZaqzGYPb4gPnRCppNbsidTO5j1bcyJhTenhErjwjG7rSII8
         1Hcdna4AEa0QTvh8RGz6GJQ4Nh37tncTPBpzmYgG3PreGUFvyt+P9/ZvhAlsvM0UfUgS
         P4GDPBEVd+ZXXFIh5uBpxqU0jebyQrpArTRsLqotRZ/ZEfpgwjhxwEiyWD+bBcjJ8lwg
         q9qKC7fqosBqGTUIVtPIqVpwBi0HoByf8UTGD+1IP99HXB6uI5XcFR9irBQVmft7u1LO
         samg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KPzwSWn2/wgp15e3XwYNn7VQbY++zh5yF1KY+FV+Z8k=;
        b=I1tcTfcMdxiq8OdkAXzSuXhEXZ2FlpL4TSPCoVExFiVPUf4d7g1ZFENYCTVNykMTAy
         +h8Wvb4Rh9fctVguylBQYX2BOgtqXI4/i8jIh2fKlu8FVPAn4g9lZzd8GRIUWlfWo0Cp
         vctARgT6bWLZ5hKVOhTlpeF1k1ukuX70njqFetMUSbdMLlgiOntGqTjQOcjzZr/jQ8Ub
         8zjWga9PuqpjxaSvGIsffgfyONHfgkltQTaieDYmdOjHrrsTqrApjYEZ7PrRfF24fOru
         cssfMyn7uB+rFEuqFufdpJRRDsCmdl0bI0ceO+LzPiVx1bhv43Ol8Io1Ghqd6kCHNRGQ
         0ofA==
X-Gm-Message-State: AOAM531JetGm20HGepdIuuUyDtxW2qQ0a3TMC/RdbHkz3IDdNhmaoPDR
        JxhvZDuTOhQVsLUy7R/NwJkpOCuDr45G9JZ2IQY=
X-Google-Smtp-Source: ABdhPJyy3GSI8Sz6MLQJWW+FV/u2Ikl+NIQNZXbaL+UEHZoTEyy24ugcks8lKIJe3ORfLoRbgk85joEQQkRK4gnAm+k=
X-Received: by 2002:a05:6402:1250:: with SMTP id l16mr61369521edw.362.1594111221416;
 Tue, 07 Jul 2020 01:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200702140845.24945-1-chriscool@tuxfamily.org>
 <20200702140845.24945-3-chriscool@tuxfamily.org> <xmqq5zb09v4e.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq5zb09v4e.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 7 Jul 2020 10:40:10 +0200
Message-ID: <CAP8UFD1JiBOhpXeADObFBgoGm292dxQ933TENrZNPnmSv+SbUg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ref-filter: add support for %(contents:size)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 6, 2020 at 11:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > It's useful and efficient to be able to get the size of the
> > contents directly without having to pipe through `wc -c`.
> >
> > Also the result of the following:
> >
> > `git for-each-ref --format='%(contents)' | wc -c`
> >
> > is off by one as `git for-each-ref` appends a newline character
> > after the contents, which can be seen by comparing its ouput
> > with the output from `git cat-file`.
>
> So that's off by number of refs that are shown?

Yeah, true. I should have added a ref as I mean something like the
following is off by one:

`git for-each-ref --format='%(contents)' refs/heads/my-branch | wc -c`

I have changed it to the above in my current version.

> > +contents:size::
> > +     The size in bytes of the complete message.
> > +
>
> Complete as opposed to what?

In the existing documentation there is already "The complete message
of a commit or tag object is `contents`. "

So yeah I could add another preparatory patch to change the above to
something like:

"The complete message (subject, body, trailers and signature) of a
commit or tag object is `contents`. "

> What happens when the object referred to by the ref is not a commit
> or a tag?

Right now %(contents) shows nothing (a blank line actually) when the
ref points to something other than a commit or a tag, and
%(contents:size) does the same:

```
$ git update-ref refs/mytrees/first HEAD^{tree}
$ git for-each-ref --format='%(contents)' refs/mytrees/first

$ git for-each-ref --format='%(contents:size)' refs/mytrees/first

```

I am not sure if it's worth updating the existing documentation or
just the commit message of this patch. For now I have done the latter
in my current version.

> I am fine if it just is silently ignored (which is consistent with
> already existing behaviour of other requests that do not make sense
> for the given type) if the thing is a blob or a tree, but we'd need
> to cover the case with a test or two.  It seems you only expect this
> with a tag object and do not have any test that checks for other
> types of objects?

My patch already adds 1 test with a commit:

--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -125,6 +125,7 @@ test_atom head contents:body ''
 test_atom head contents:signature ''
 test_atom head contents 'Initial
 '
+test_atom head contents:size '8'
 test_atom head HEAD '*'

There is only one test with a commit, because that's already the case
for %(contents) too.

I am ok with adding another preparatory patch to the series that would
add a few more test cases with commits, trees and blobs though.
