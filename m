Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA46C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 02:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF82420885
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 02:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FW66fmsO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbgFRCGl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbgFRCGi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 22:06:38 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE84C06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 19:06:38 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k4so3691057oik.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 19:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tWOMOCfPFoaxOnqyQzIxb7OmIaefEeGpowycq6EcIVI=;
        b=FW66fmsOeYj5FzNSO6cj5Ytc4XCAUzxZdmXw49LrsFGIUxaMYs874oENJ9WRHa5I9s
         Z8gKvx7Pb1hNYgL7EmQVnPWjfFFmZE92MD4f0E1KUEr4VhVVFZpJHyS3gF32dAK0mWzo
         Ft9CY10/L0juXvs9hCbdoOA0WWIvfqjus0vH5uNgZ9nSGfiLYWjJv3OdhWT0SnwmQRbr
         aNoJELLSD+TPStj1pDx27RNiIY3sYQ+zCUgjlotvApR26w5Q+CRbzOz//BUCv5b5w+Fp
         CjlQ8jGgI9czy8pWmm6yQV3LrJUM9kkNTJZk9VqmNX+fgD6BOO4etZ/2zTQoNzJ+hiGh
         TmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tWOMOCfPFoaxOnqyQzIxb7OmIaefEeGpowycq6EcIVI=;
        b=lInhjLdvrHsPy9L+iUOCiI0qSMGB+pyIVgHRpI0EYlI/5Y5qwtpoMIDJRNOQerVKXc
         v+Vf2MU8h8fUFFNv172a/p2/CFyGIm0ZCaXMf5ryOaUIZOn8nUP3bsdWKsv/XeKi7OmK
         B02zn7fYYTisFMnhwJXL2ixspZlcr4sr634qHFzfqtXLQ58j4hH1T53UeLG//1gW7yGp
         phxs1XveBhDaoYPgiY0m15RKw3GP3fEr+PsQoZ6GBf0pP6jQqhpCjYiEkxIHxx7jYIWR
         ROGxEg4jmjD77y9EZ2AQCVSPchAqHx++dAC/fD4LzSVAqo4SWopO6ay6Gy0h1RhHYcas
         EGyg==
X-Gm-Message-State: AOAM531LLmETs2ID2qy4oO7y8Cd41ruCecEp9JyVXeZfNNZDkOjiRMR1
        OOc5MdM3eLTPmVwxMT4R6Ojj0OfUfj6KjS53UodLM+zl
X-Google-Smtp-Source: ABdhPJze57fWaZcHIJFNpaCt3yoiSWzJIIvgchh0bpaTIhrc9lgoBmX2C8nMclbGxbEef+xm+tl1VmKLXXMEoC5UtjU=
X-Received: by 2002:aca:2b0d:: with SMTP id i13mr1321097oik.39.1592445997606;
 Wed, 17 Jun 2020 19:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <ebd10f73cd73a8fca84d1862e5a4b7b62a549bcd.1592225416.git.gitgitgadget@gmail.com>
 <20200616125833.GE666057@coredump.intra.peff.net> <xmqqmu51v9qy.fsf@gitster.c.googlers.com>
 <20200617212333.GB2809@coredump.intra.peff.net>
In-Reply-To: <20200617212333.GB2809@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Jun 2020 19:06:26 -0700
Message-ID: <CABPp-BETyMYm=5APqAA3D1JmkurDFNkKLDrcF4MUgEfqEuVKFA@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] fast-export: do anonymize the primary branch name
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Junio C Hamano via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 17, 2020 at 2:25 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jun 17, 2020 at 11:16:05AM -0700, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > > Of course that only helps you for _one_ branch. A more generally useful
> > > mechanism would be to teach fast-export to write the ref mapping (and
> > > perhaps file mappings, etc) to a separate file. Then you could convert
> > > any reproduction recipe to use the anonymized names, and share only that
> > > recipe along with the anonymized dump. But that's _way_ outside the
> > > scope of your series. This seems like a good interim step to retain the
> > > status quo.
> >
> > Actually, dropping this special case, and dropping the other special
> > case with fmt-merge-msg, we can do without the notion of the
> > "primary" branch.
>
> That leaves us in the interim with a "fast-export --anonymize" that is a
> little harder to use (you have no way to know which branch was which).

Why does fast-export special case on "master" rather than on HEAD?
Isn't it more relevant to know the active branch than what _might_
have been the initial branch?  It kind of feels like a bug to me that
HEAD isn't the special case construct.

(Speaking as someone whose company a number of years ago had most
their big repos and lots of little repos switch their main branch to
be named "develop", and in some of those repos deleted "master" but
didn't in others.  If I had needed some steps to reproduce a problem,
and hadn't been on the inside, any special casing from fast-export
would make more sense to me to apply to "develop" than to "master".)

> But I don't mind at all implementing the map-dumping feature to help
> move this along. As long as both make it into the same release, then
> fast-export only gets better, and never regresses. :)
