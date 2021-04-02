Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DC2C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 06:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A5D61029
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 06:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhDBGcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 02:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhDBGcD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 02:32:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18355C0613E6
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 23:32:03 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id bf3so4479604edb.6
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 23:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0X2m9IeYTqQbZjDjzEcVgZ6r9cNB1BZQVBHz7j6R3o=;
        b=I3oa2/46gZo6Ue5JgyA5P9EUAZB+5nZJZGdcHjk6PbEMKLsPbFpwgs0IiaF/m2LBL/
         Ts+nFbFwfwBzpWFa1phICvg3c3ChMWjFQiCRkVes9temjK5NzpKX3d5bsILOlrGX/Xlj
         QRxvB+Z2/POJeGe9I10aGWQ1t244KLdgQ039s9zTAHhGXZL6A1hUdxly42oJ97EvllAL
         Giv40xLJ5LdMZKAqTVBK02Nz1JCQF3TUW6Ul0qJ3xf/GLETcjE2I+5SxdKmI7OfYWR5/
         ZcmMxOVd4ZTA05bOkQDJzdIR8705/TY5wpNodpCF1guXjXylKCwfQCd9sJwWd1vSEDmy
         BFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0X2m9IeYTqQbZjDjzEcVgZ6r9cNB1BZQVBHz7j6R3o=;
        b=O6XK1T+4iIojv2f5SkXU+sS/SRS9N2HEMU4wRcYfu/6Xa5Y+yrTA1PRTWY/VZVOQ5w
         00i96oRcqGvSUzd8Yz8Uj32C5wRK+ESHrdjkb0N1ZpGS2jiiX0dtiAZfOUu/B2pj5ESZ
         87nilsn1neFPZ2jk1KVrzv1g4x3DBVUsH+JxcuA0yz3btPLBToVrXFe8Hik1tUyq0RFS
         sM2zsb5PC/duqk+X/aoCgT2T/GKZ7d2J2Pf33fQicOnNeifxR5W4Y4jrOi1OWJgtGaY0
         5qe3jcr4XWagW3MzNJEpwidEyF2Zq5s0MifGGh3GHoe0INQRuocqaeWAyPT9xZagExcP
         7YmQ==
X-Gm-Message-State: AOAM530CfcQSbL0RfVYFC6XpfN1Cm4fi3Cf7vyt+r+SHYfDaJ7xJn1sa
        OtG5iVUKwv/ZsFQtAViiOpYk31ZEb2zQ0hxxgcU=
X-Google-Smtp-Source: ABdhPJy8ZUjwIxreCxdWMaNNYuHWYPChH7VGZlq3BbMsbGESAF7SOJK3Ay9RJKCEa8VWYV06BWnL4534rr3DjSMucIA=
X-Received: by 2002:a05:6402:48c:: with SMTP id k12mr13914634edv.237.1617345121647;
 Thu, 01 Apr 2021 23:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <195bf718-6226-43c9-8c58-167388d3d99b@gmail.com> <f5b9ea24-e2f7-6c54-b4ff-86cef27527f7@gmail.com>
In-Reply-To: <f5b9ea24-e2f7-6c54-b4ff-86cef27527f7@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 2 Apr 2021 08:31:50 +0200
Message-ID: <CAP8UFD1PC=vQCXLLoECPzFc8BGGfQxptHE5+Et11F-=3-twZYg@mail.gmail.com>
Subject: Re: [GSoC] Draft Proposal (Convert submodule to builtin)
To:     Chinmoy Chakraborty <chinmoy12c@gmail.com>
Cc:     git <git@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 2, 2021 at 7:44 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 01/04/21 18.40, Chinmoy Chakraborty wrote:
> > Greetings mentors,
> >
> > This is my draft proposal for the GSoC project, Convert submodule to builtin.
> >
> > It would be really helpful if you could review the draft and present your
> >
> > views on it :).

Thanks for letting us know about your proposal!

> > Link: https://github.com/chinmoy12c/GSoC/blob/master/GSoC_Git_proposal.pdf

[...]

> Anyway, I copy-pasted the quotation above from your proposal in PDF format.
> but when I pasted it into text-only mail, it looks rather ugly.
> So next time when sending GSoC proposal for Git, I would like to see
> proposals in Markdown format (as well as PDF) for the reason above.

I agree that proposals should be sent to the mailing list in a textual
format inline. It's ok if you also send a link to a better formatted
version of your proposal, so that people who prefer to read the better
formatted version can do so. It's ok too, of course, if the final
version uploaded into the GSoC web site is the better formatted
version.

Sending the textual version to the mailing list inline could make it
easier for people who want to comment and discuss it, like patches
are, which will help you make a better proposal. Later it might also
help people searching the mailing list.

Best,
Christian.
