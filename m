Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D66C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1ED52076B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgD2Qbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:31:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32819 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgD2Qbq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 12:31:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id v8so5355500wma.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 09:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4HF2obJDAiB8nHcP/W0wMjjIsolEr6KuRIlKXeLjhM=;
        b=EK7QouGUZ0xg+Zz9VvG9qhPmlfFWJJ5MuFK4Xodf0oUfCxhueQUDU/daDOKjcnEq1b
         NLwrXnezVIONAlMmHFcopDlqQiEDf4OeOG4AstEA1Epz0WPATGStSBNGg46s+McGYngG
         uytB/i2fv9t5xhD268tCjCF54VkxZz7Sm6giHaMdlyYI1LA+u6msGaboK7YCW2747+Xo
         liH2Va0w9NOwJrDonkA41R/xO8HbSYRg4QmVZbH/0JKt2eLJF60wnTbnOp6QGtrUwanb
         5mNmTVO5MxH3eIkLURRPsiIkRFGKayVIQ+LstxhP/1/qeDASA6qYsc4oPcS7aJ1ksDTI
         fRwA==
X-Gm-Message-State: AGi0PuYHhlA0V+PrcGq1kfmo9nQkdDzrvVXJ3a+od7efAc0S3NdktQkB
        /HQpZ2BC7HNk6Ui4rspItqZQTMQoJXNxYS+DfL7dFQ==
X-Google-Smtp-Source: APiQypLqr9W6bm+bohq3HiYT8ccl3NEbVLKAHuQbEF0r2DKEbiVLGaa7B7HOeO9wQTynza+ebndA1DjQ8zjk1j8aDk0=
X-Received: by 2002:a1c:64c5:: with SMTP id y188mr4080226wmb.130.1588177904308;
 Wed, 29 Apr 2020 09:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <60af77100df823b4112c08e6c1b8533f.squirrel@socialwebmail.com>
 <0f7f9eefc056dd4d9b11dab737e00235b3243a2f.1588150804.git.liu.denton@gmail.com>
 <20200429160948.GB83442@syl.local>
In-Reply-To: <20200429160948.GB83442@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 29 Apr 2020 12:31:33 -0400
Message-ID: <CAPig+cS-f7JOkhW7yf_h4bXx75Y_=_0e7uPTCfkBCHvc8WSUBw@mail.gmail.com>
Subject: Re: [PATCH] switch: fix errors and comments related to -c and -C
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Robert Simpson <no-reply@mailscreen.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 12:10 PM Taylor Blau <me@ttaylorr.com> wrote:
> On Wed, Apr 29, 2020 at 05:00:19AM -0400, Denton Liu wrote:
> > In d787d311db (checkout: split part of it to new command 'switch',
> > 2019-03-29), the `git switch` command was created by extracting the
> > common functionality of cmd_checkout() in checkout_main(). However, in
> > b7b5fce270 (switch: better names for -b and -B, 2019-03-29), these
> > the branch creation and force creation options for 'switch' were changed

s/these the/the/

> > to -c and -C, respectively. As a result of this, error messages and
> > comments that previously referred to `-b` and `-B` became invalid for
> > `git switch`.
> >
> > For comments that refer to `-b` and `-B`, add `-c` and `-C` to the
> > comment.
>
> I had to read this sentence a couple of times more than I would have
> liked to in order to grok it fully. Would it be perhaps clearer as:
>
>   Update comments in 'cmd_checkout()' that mention `-b` or `-B` to
>   instead refer to `-c` or `-C` when invoked from 'git switch'.

I had no problem groking Denton's wording but had to re-read this
proposal several times before understanding it. I could try providing
yet another proposal, however, I think the entire sentence can simply
be dropped (after all, it's just stating the obvious).

> > +             die(variant == CMD_CHECKOUT ?
> > +                             _("-b, -B and --orphan are mutually exclusive") :
> > +                             _("-c, -C and --orphan are mutually exclusive"));
>
> Hmm. Do we need to generate an extra string for translation here? If the
> string was instead:
>
>   _("%s and --orphan are mutually exclusive")
>
> where the first format string is filled in something like:
>
>   die(_("%s and --orphan are mutually exclusive"),
>       variant == CMD_CHECKOUT ? "-b, -B" : "-c, -C");
>
> may save translators some work.

We don't know the grammatical or syntactic rules of each language, so
hard-coding untranslatable "-b, -B" is contraindicated. Since the
option letters ought not be translated (just as "--orphan" shouldn't
be), the letters themselves could be interpolated into the string.
However, that's probably less helpful for translators since it
eliminates contextual clues. Therefore, it seems like a good idea to
leave it as two separate translatable strings (as the patch already
does).
