Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D01C433E1
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 01:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A1BD20768
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 01:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oD3uktyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgGRBfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 21:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGRBfV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 21:35:21 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABA5C0619D2
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 18:35:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so12925666wru.6
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 18:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkCjAvNEvZReO66n2uxT1G+mVTSSEireu8EzsbqhLx4=;
        b=oD3uktyApy5rhVQtivDBLcstmNTD29z+ljjvZmmNB17sdWRihtfVfZagtCUpEf9aqg
         7IzEzIXkwIxzJrv+IIrZcrYibmTYELnAWeefXVxPGh1mW5ShzRcyyX7gdUVDd7F8oiqx
         aSW3lTX07iPrwAAUxVJydk6FgVDuDyXqa/VrYdkToApicG2/EljLDIeq3XmscvYHXSV2
         0eE8tQUB3OM+1QkyEXvgAidfrQSKN8C/iABmOLQ6lFkgY0ahuBfHCLiF9U35DBGqmNYc
         NTRJEZOLK8MJjptUNiE8FICnVo2yYCHIuNXZf1jUOkJPG2WQa4T+OwQTrxbktgppTMCE
         9j2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkCjAvNEvZReO66n2uxT1G+mVTSSEireu8EzsbqhLx4=;
        b=BFHRJT4/G5e6BO/4bXUyGOe8Xa9rsl5BaZhJqeL0Tj/aPXfN8o0YC9eG/kL0m+xn4q
         WluGllA3XCfvW0p1xRnXExWigyLpuyG0HfSRp6dwJwtL1tdGpPPKteFc/wmF0L0IGUgw
         /SnGxITCysvJpYFemba4QH/823sQrg07fAn+t4B+G+jEsKKK6WYKMQZ1L43JXI9u9T8I
         idxBNCK8mBQUQSqXchGG1ThfEBQCE4P8cgHag1iumJQuWIgRYytU9OEsbHJgI8nGYFbz
         1M+wwn+HgAkiEzXyjws+yN6rxntGNz1LjKg9Q0paacKY9VKFNc/fdR8lgMXL7M8CP+nJ
         7q3A==
X-Gm-Message-State: AOAM530HYAJXpvBW2u/43PQyHH9x43c4/qgoPmyJIEsP8FBzHM/YVmQc
        8zwBPSuLEuIkdi/AYKpVMHmoYwiCLumpnsRq/UVFpbB7
X-Google-Smtp-Source: ABdhPJyl/P811/geta+IDKW8IOyAyCB6hzHVw6TbKtLseUmWUfYteBkvFAKm2KTA2LFhpXibVYGqe2IWJO+DhFAt48Y=
X-Received: by 2002:adf:dc90:: with SMTP id r16mr12755148wrj.264.1595036120165;
 Fri, 17 Jul 2020 18:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.678.git.1595028293855.gitgitgadget@gmail.com> <CAPig+cQaqg7MbyNZakuWVzezhPCXu=LonCVAw_p13c=0YNBdPw@mail.gmail.com>
In-Reply-To: <CAPig+cQaqg7MbyNZakuWVzezhPCXu=LonCVAw_p13c=0YNBdPw@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Fri, 17 Jul 2020 18:35:09 -0700
Message-ID: <CAPx1GvduDZw5pmfZHACDGZsMR5YYDowLw6+az+oL6oWLvDyCFA@mail.gmail.com>
Subject: Re: [PATCH] git-mv: improve error message for conflicted file
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Chris Torek via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 17, 2020 at 4:47 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> Style: write `!ce` rather than `ce == NULL`:

OK, but I'll go with Junio's suggestion of getting `ce` once and
then checking `ce_staged` anyway.  (I'm used to a different
style guide that frowns on `if (ce)` and `if (!ce)`...)

> As for bikeshedding the message itself, perhaps:
>
>     _("conflicted");
>
> Though, perhaps that's too succinct.

Maybe.  Succinct is usually good though.

> > +       touch conflicted &&
>
> If the timestamp of the file is not relevant to the test -- as is the
> case here -- then we avoid using `touch`. Instead:
>
>     >conflicted &&

OK.

> ... use literal TABs and let the here-doc provide the newlines.

I personally hate depending on literal tabs, as they're really
hard to see.  If q_to_tab() is OK I'll use that.

> I realize that this test script is already filled with this sort of
> thing where actions are performed outside of tests, however, these
> days we frown upon that, and there really isn't a good reason to avoid
> taking care of this clean up via the modern idiom of using
> test_when_finished(), which you would call immediately after creating
> the file in the test. So:
>
>     ...
>     >conflicted &&
>     test_when_finished "rm -f conflicted" &&
>     ...

Indeed, that's where I copied it from.

Should I clean up other instances of separated-out `rm -f`s
in this file in a separate commit?

Chris
