Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 362421F453
	for <e@80x24.org>; Thu,  1 Nov 2018 06:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeKAP7D (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 11:59:03 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36915 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeKAP7D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 11:59:03 -0400
Received: by mail-vs1-f67.google.com with SMTP id h18so1263056vsj.4
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 23:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qOCpZdJPBZm45vBywTzw5ct3g6ICoiavyxLl49RVeuo=;
        b=g/rGT9kEA+Dtgyby5PLuKIXYs0vQ/r0kAAxqkkz+TrDcxzotXKRTXny0TWYsUTKeb6
         iTQyTXDW8XFPjgIR2h3GD0g+Kn+h73UunXrwOus4F69NNF/Gwhy2Ljf0teZt9kQ/xr5W
         nhLexT/ghFUAVpsr8gWAuc9dhDr9gC0lS4xuW+RwISydgPwDT87YCJTGEdKLLF1/VxiS
         lHQEO/4dMMxGRu/gP8OzUvR9TBM0PPoTncbLoJN4QTTJAFVIQYu4s0iDmh6wKCgLFlRn
         qwbDKulnVBy1CTfMOtY9YjcTCTR0ZrdN+DRM7CzfHCLY3ddtoqhfOjutCvkEMWDERWlJ
         BESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qOCpZdJPBZm45vBywTzw5ct3g6ICoiavyxLl49RVeuo=;
        b=Wf76h+VHRvKBLOtcMwBebY+nNV7teAwwWMPeuIP99CaRYV0qgv7M5GWhZSVi7QfXB6
         RZO1K8FVXFcKdvpb18zaOmYHTSxXqMZ8GcmHoS5U67YKug3fZ23A5MoYtvJbhwTK93x7
         F4tnipmtFHjwo2aVLAy1sj2Di6PDr9cHG4XQ1RU9IGEA91SCmuqT7upi7R309kw4WTyv
         c5eHKJLSKeIEwdA3a5eRq+a0lmq4aAzGdKmONvA8xCDvnKBB0N551WDFv05kj7kN0gn5
         PPT1Tb8Bj5apYURSf3IDyk+g19UpvsVy23w2n6tC/Qba2SE/jSlQATEp2aaFLwO4kJgd
         rx8g==
X-Gm-Message-State: AGRZ1gIQ6Uae2SePpKOqBtxXaWnEpmLqXqPPqFkoD6dWsNhDHwamJlr/
        n4q6FTAAV2nqsoCk5sxZcGksybdfSsKDEHajbxQ=
X-Google-Smtp-Source: AJdET5dzvgqDp84NHFXlaAbpjWMnoReHA7dBrgOK3mXma212z0PofWjoNhzzf9H5N1bGfxwbL7IjYuwv/nYh+Iu+mNs=
X-Received: by 2002:a67:3e81:: with SMTP id a1mr2744360vsi.136.1541055441658;
 Wed, 31 Oct 2018 23:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181014020537.17991-1-newren@gmail.com> <20181019193111.12051-1-newren@gmail.com>
 <20181019193111.12051-3-newren@gmail.com> <b14a0c79-5dce-a1dd-cd26-16e061154c43@gmail.com>
In-Reply-To: <b14a0c79-5dce-a1dd-cd26-16e061154c43@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 31 Oct 2018 23:57:10 -0700
Message-ID: <CABPp-BGq1YDdzZ6CqzCp9QXPZy6XxV8sujyRxwBc-EnS+ygSrg@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] t6036, t6042: testcases for rename collision of
 already conflicting files
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 7:01 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 10/19/2018 3:31 PM, Elijah Newren wrote:
> > +test_expect_success "setup nested conflicts" '
>
> nit: should these test names be single-quoted? I see you using double-quotes
> in PATCH 1/8 as well, but that seems to be because there are variables in
> the test names.
>
>
> ...
> > +test_expect_failure "check nested conflicts" '
>
> Same here.
>
> > +test_expect_success "setup nested conflicts from rename/rename(2to1)" '
>
> > +test_expect_failure "check nested conflicts from rename/rename(2to1)" '

I'll fix them up; thanks.
