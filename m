Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504A4C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 16:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B2E61059
	for <git@archiver.kernel.org>; Thu, 20 May 2021 16:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhETQmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 12:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhETQmG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 12:42:06 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49D0C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 09:40:44 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u11so16972182oiv.1
        for <git@vger.kernel.org>; Thu, 20 May 2021 09:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k76pbsnrLjLv7WBWz2yDYqv9U6cmkgcWmuKtjKPDng8=;
        b=bg4/2KV2Jyrc+8v/vIntuyMgefEWPizbXnnKJIw9SqvveuaBOIR3HuQC1BNwKsaYa1
         48Q7WLceDT/1kqha67ujcyTbulmF2Wth8SuESKYbJ3DdBA+mrGSpQ/kLLU1SR3ieHBVr
         EB+xg+qBbsogAffjJzYQeJpq7WK+94IIpYtDSuIbZRbEIsUtwZljY05ulTiZCdoG0BQX
         JYk4AXQxrQYNfoVi8z3x3fUuCRPCM3kQHa7MT8Bwr3GP/zd489RufM4f7xuI+742bReq
         NafHO9oM7xxHDZbp43U9yiAZWG2i6y/hc9CImlGQJl/8/iLJVi/wRqce7n3y7Z1nP7V0
         BznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k76pbsnrLjLv7WBWz2yDYqv9U6cmkgcWmuKtjKPDng8=;
        b=JkgUAN02+VOXSYRHIM+HXZpFqtH/iFDyx9cOF+C/j0SScqI3SqV7pt5ISIwdDZoZZE
         SoAi+86ymQjgwHnAXBtQgHwsSukAcp7k/wtCPgZNnOTZn4YvS5xcdZXyXs4DK5jEwrBT
         qCAIddriKteEpcXxCBD+IIm6dhuzsO1bpf138YnciurAvhQ5khXIS5dTA2kT/tix29gw
         i16Bb0t09U/dNrOWxicnEnGrNiX3YTejjuqroDmD8s3Fx4vApDsSu1S/jWWK5PZId9MJ
         7/ug6jCykU+E9RNxe5y7eFEwySPKUIJaEgbkcgfws+0hCCmZ/gjx3+QCHqwHuH1FBiRb
         zMcQ==
X-Gm-Message-State: AOAM530yaqLRej1YBewj6w6xoLXAnrtyUFOaKwBkrhZTpA488bJl36yI
        6mc+lL3Yn6bvn+u8gaBYdx6QRD21a1gh2BhZ3qg=
X-Google-Smtp-Source: ABdhPJxW1trfb8ydjhC8RY34UTrcK0/RXG4nva7dp3ZoqdY/DatnWdY9tr6DERdmiI7cUd/JGp/fSsJz/74JrtkZAfk=
X-Received: by 2002:aca:30cd:: with SMTP id w196mr3913199oiw.167.1621528844285;
 Thu, 20 May 2021 09:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqv97g2svd.fsf@gitster.g> <ab2d8b16-42db-9675-083a-efa7cfca6e4c@gmail.com>
In-Reply-To: <ab2d8b16-42db-9675-083a-efa7cfca6e4c@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 20 May 2021 09:40:33 -0700
Message-ID: <CABPp-BFhsw7jMZa9TcLSKz12=0H40froS-DTRXSvMR4q006Jyw@mail.gmail.com>
Subject: Re: [PATCH] revisions(7): clarify that most commands take a single
 revision range
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 7:28 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 18/05/21 18.17, Junio C Hamano wrote:
> > +Commands that are specifically designed to take two distinct ranges
> > +(e.g. "git range-diff R1 R2" to compare two ranges) do exist, but
> > +they are exceptions.  Unless otherwise noted, all "git" commands
> > +that operate on a set of commits work on a single revision range.
> > +In other words, writing two "two-dot range notation" next to each
> > +other, e.g.
> > +
> > +    $ git log A..B C..D
> > +
> > +does *not* specify two revision ranges for most commands.  Instead
> > +it will name a single connected set of commits, i.e. those that are
> > +reachable from either B or D but are reachable from neither A or C.
> > +In a linear history like this:
> > +
> > +    ---A---B---o---o---C---D
> > +

Why did you snip off the immediate next part of Junio's text which said:

+because A and B are reachable from C, the revision range specified
+by these two dotted ranges is a single commit D.

Is this sentence hard to parse or confusing in some way?  I thought
this sentence would have made it pretty clear that the answer to this
question:

>
> So "git log A..B C..D" is same as "A..D", right?

was 'no', so I'm curious if that particular final sentence's wording
could be improved.
