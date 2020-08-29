Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2AFC433E6
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 18:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B9BA2076D
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 18:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+xHPKti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgH2S5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgH2S5G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 14:57:06 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFA0C061236
        for <git@vger.kernel.org>; Sat, 29 Aug 2020 11:57:06 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id j3so2052000otk.13
        for <git@vger.kernel.org>; Sat, 29 Aug 2020 11:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VC9ksbHw/PIq+6cqZoR+YCydUp+TbUuICLBz0s5NOKo=;
        b=C+xHPKtipWh26bPsgmH7T4oNPvlJNx52cNL7plFtRPpFgPz52uzfbsLhBL/tu+pCFF
         zp5NtKN0EUu6eQsQzAdZiG+P0E3LlRIsMdZ8532iZ1ZaSEcENkMCNz5sZ8HeU5WfrOtV
         RcOMAEbMesdi7NdtUlr0M6U/ICytHhSLVdOQwdVeQhgvRcqh0Yf6Yd8iRobes1zXI8Ko
         JHnaK92ulhWtQsMWSx/Kc6ZoCHzYgBGKKJaiS3un6suZLnsUpCUXnQHGaWaUTqnoY3W5
         Wxwp2t12tJbG1eONBE7rKNAjp0XnR4FOJRrhcUQNgKN/TsccJ6oE5TdceJz7EBlAAI9x
         ayFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VC9ksbHw/PIq+6cqZoR+YCydUp+TbUuICLBz0s5NOKo=;
        b=LJDjyFVc/WYdZxTmqlOIAD3QE3lhe1Mrhh1KoiRsB/zyVWLOGsiGKXbKyVdhdqWbov
         y1WFd1DlnwrL2HsKjIf7GGrYmHixrC8GcDfKCobKOgywu1aoW2HPCbdoPkfr8XYAuzj8
         rzmqh+mUdb8KgLDHjCz6l1iCxCGpjhSk0b4R+iUG9l0HLeNuJVK8Nv6o+efctOOJjRbP
         IHAj2uUsfZlzzSSddmv/z0YlOjKO7GPOiKdYsJEl8GD8jLdh10VMfdOBT3w6EGIK4uuU
         C7hCHJqlO3vLqftPyl1mk/4Rshh0MhrLLVZCG/tf3qxJyqsQGSOtPfOtSZ6XThUAHO9P
         F9uQ==
X-Gm-Message-State: AOAM531ZImrKxTOeHlp18eQVCG2KOYyfi9ZzC8wJnb2RqP5qgw46z3YG
        NJSPLJawKth3SwRbOprcSA4emhdiD3zEwnkYj+mP0llVoFM=
X-Google-Smtp-Source: ABdhPJxrygu9OYCHmlGZVKeeAy5EKjBc/b/jIu5DvHfWpfLrw/PIdJy/z8gGXDClvkQ8NOz7x6fsXWmEjruUpkFgXyk=
X-Received: by 2002:a9d:1c8f:: with SMTP id l15mr2807778ota.241.1598727424329;
 Sat, 29 Aug 2020 11:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh7snpxy1.fsf@gitster.c.googlers.com> <CA+CkUQ_=qm2x2zKvgHnvKLLA_A23gTNm8Q8CeWxLFGSBi=9gKw@mail.gmail.com>
 <xmqqo8muo5nt.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8muo5nt.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sat, 29 Aug 2020 18:56:52 +0530
Message-ID: <CA+CkUQ_kBo6YW0x3QWnF+w8N33howU1CEosCmdANBoytwN=5WQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2020, #07; Thu, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Aug 29, 2020 at 2:21 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Hariom verma <hariom18599@gmail.com> writes:
>
> >> * hv/ref-filter-misc (2020-08-17) 9 commits
> >>   (merged to 'next' on 2020-08-27 at c015fa6b0f)
> >>  + ref-filter: add `sanitize` option for 'subject' atom
> >>  + format-support: move `format_sanitized_subject()` from pretty
> >>  + pretty: refactor `format_sanitized_subject()`
> >>  + ref-filter: add `short` modifier to 'parent' atom
> >>  + ref-filter: add `short` modifier to 'tree' atom
> >>  + ref-filter: rename `objectname` related functions and fields
> >>  + ref-filter: modify error messages in `grab_objectname()`
> >>  + ref-filter: refactor `grab_objectname()`
> >>  + ref-filter: support different email formats
> >>
> >>  The "--format=" option to the "for-each-ref" command and friends
> >>  learned a few more tricks, e.g. the ":short" suffix that applies to
> >>  "objectname" now also can be used for "parent", "tree", etc.
> >>
> >>  Will merge to 'master'.
> >
> > I sent an updated version of the patch series addressing your comment
> > concerning new file format-support.{c,h}[1].
>
> But other stuff (like format-sanitized-subject having unnecessary
> allocation and unnecessary special casing of LF) are worth fixing in
> the version queued above.

Yeah, I fixed that too in the v4 of the patch series.

> Let's revert the above out of 'next' and start afresh using v4.

Just saw v4 in the `seen` ;)

Thanks,
Hariom
