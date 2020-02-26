Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B0BC4BA21
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BF321D7E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PryuQ7fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgBZUyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:54:17 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:35960 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgBZUyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 15:54:16 -0500
Received: by mail-pl1-f177.google.com with SMTP id a6so183243plm.3
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 12:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KGOBC6/Qi3mZZhUQx3ESN7cVZHwrraHdMKizmPxgN/Q=;
        b=PryuQ7fdK41OOuEGzQoWbBMpFTh1LyefRUzNXaUxmSBCa2ANPhYsil/J7pCNfn/nUU
         rWMOA6WrCAwuWcjxCVgiLL74wyP4eHS0FGfbutlaulUbPF9PDUhDV9HWlm3UK07Iwh6/
         0qn7MIVFM15i5ExrfO35+uaEla5nKCxpPKNswUuOOYdi9IJcW9oT54gfQwJcrP7gEA+m
         bgkqQe00ZKWjLE5GDitvH2VR6+l9NHOssknJ3gEFBxYJCq7FmwYM2hajPjGuOFrUPJXf
         u4fSWf/DAIxXkKty25zSGfDbsbtT/tITrQdsag9OOy9kOXYLOXv6tbUHMkxH/MpWDUr3
         YIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KGOBC6/Qi3mZZhUQx3ESN7cVZHwrraHdMKizmPxgN/Q=;
        b=XC649zxwFRk1x/2EzHgRhak7b/p148JAcg2V3C8V5sPihLyvzqezdxT57ry5aBsbVd
         FNs89kM+rVbGw14VyXRDXhlJTt9KfB9WMJJcDiHB6q9fvgUurzq9FZuXwceXMJXbO0Ra
         DJDMBdSsuo3Iu2qe7FFAzwkSCgeM12wrm6lFh4+SsWv7vzNu1WDY0PrBrx6CvLunrzOI
         pk+AiXicbhZPsNJdrqLYcnZNFRISS/PY95OcAr2YIZSYZfxs3Rjmg4Syx7xX3X4c+Z+S
         msmhGKFyKyv9p7wCbx5vFQ5AZK45P7NXejdm9YuC/rpLxSMXLxD3cVOYueeHHKgoG4bG
         UbZQ==
X-Gm-Message-State: APjAAAVlzQ+kQSqCiOW0Hw08NtudZ4goQq9ciEO0oX9syNrq1S0mgqhr
        L25MDxmtXGpTqszAVt5AG7Hs+ceObHLbE4XMDb0MVMza
X-Google-Smtp-Source: APXvYqyj2G9ylXX2fh9yyK7eKTxhRXV7bvszKQUNV/8HmPexhUu2WeZlbbTZs+KZ4IF9xX9T1k9qjPZfr1fbMJm4RdY=
X-Received: by 2002:a17:90a:1b42:: with SMTP id q60mr968225pjq.108.1582750455852;
 Wed, 26 Feb 2020 12:54:15 -0800 (PST)
MIME-Version: 1.0
References: <xmqqo8tml1lv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo8tml1lv.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 26 Feb 2020 21:54:04 +0100
Message-ID: <CAN0heSqfEsEZVBnFP0cSNoB-gK=EG1nuDL0EQHHc8MSH=TcPRw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2020, #05; Tue, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 25 Feb 2020 at 23:58, Junio C Hamano <gitster@pobox.com> wrote:
> * es/recursive-single-branch-clone (2020-02-25) 2 commits
>  - clone: pass --single-branch during --recurse-submodules
>  - submodule--helper: use C99 named initializer
>
>  "git clone --recurse-submodules --single-branch" now uses the same
>  simgle-branch option when cloning the submodules.

s/simgle/single/

> * jc/describe-misnamed-annotated-tag (2020-02-20) 1 commit
>  - describe: force long format for a name based on a mislocated tag
>
>  When "git describe C" finds an annotated tag with tagname A to be
>  the best name to explain commit C, and the tag is stored in a
>  "wrong" place in the refs/tags hierarchy, e.g. refs/tags/B, the
>  command gave a warning message but used A (not B) to describe C.
>  If C is exactly at the tag, the desribe output would be "A", but

s/desribe/describe/

>  "git rev-parse A^0" would not be equal as "git rev-parse C^0".  The
>  behaviour of the command has been changed to use the "long" form

("behavior" in American English.)

> * jk/object-filter-with-bitmap (2020-02-18) 16 commits
>   (merged to 'next' on 2020-02-19 at d38487e23d)

>  The object reachability bitmap machinery and the partial cloning
>  machinery were not prepared to work well together, because some
>  object-filtering criteria partial clones use inherently rely on

Perhaps inject "which" between "criteria" and "partial".

>  object traversal, but the bitmap machinery is an optimization to
>  bypass that object traversal.  There however are some cases that

s/that$/where/, I think.

>  they can work together, and they were taught about this case.

s/this case/them/ ? Fixes "some cases"/"this case" mismatch, and avoids
some duplication.

> * en/fill-directory-exponential (2020-01-31) 6 commits
>  - t7063: blindly accept diffs
>  - dir: replace exponential algorithm with a linear one
>  - dir: refactor treat_directory to clarify control flow
>  - dir: fix confusion based on variable tense
>  - dir: fix broken comment
>  - dir: consolidate treat_path() and treat_one_path()
>
>  The directory traversal code had redundant recursive calls which
>  made its performance characteristics exponential wrt the depth of

s/wrt/with respect to/, perhaps.

>  the tree, which was corrected.

Martin
