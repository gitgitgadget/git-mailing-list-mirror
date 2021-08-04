Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB860C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 17:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F40760E53
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 17:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbhHDRTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 13:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhHDRTB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 13:19:01 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D2EC0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 10:18:47 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id x15so3641043oic.9
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2YrzFvvS6qeziAqA1WyQJZqwZddB8EBBtG3r8dH8sE=;
        b=crhBRsY/enn9/+i1JRQr3wxD2/AcfI9lyr6DVkILZbIUKIkgmNGiX3k7ErnGkYSJT6
         fAs4QM/6LJH+uKfjN72YRGYlxBr+HIfl7iqT4NCAG+e5qRH/+EmydPVhPTeQPJ7F3igL
         Jrs+GVxMlMu6KfUXgYIhLLDR0cv/z1T2jH4l/vOmlPnsMitPLcu3cSQMLdh3HrQhjoXy
         GdJcH1p/dKgCUgwrGfV4mbx4flvklmG3gWjWSaYUXKupDq4OIgw0FR49nwjjys/F2cfi
         5sBhxaPUgwHgb79c4wTx22lCqlMiO7WgpjPIC1YXZp9QNKYBJE6rZRDJlZa8hBXqty5N
         6kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2YrzFvvS6qeziAqA1WyQJZqwZddB8EBBtG3r8dH8sE=;
        b=MwThA3pHWhzMQVqCkMoiyi3uQMsospQjCuaz1SLxT9bFXmTSw/56Iw2WQjs/uXxv0x
         P50ie2Mjz8AoXipKLYLBTaQqZUS6eYI7rDBuhBPbCsglDzjxWVlxPnSFQWPjxCmWw5cA
         rJsQ/OQKQ07KFFvdTnJdaVqwVuiemf+sphuoZ94m9Evl/w1ywSqtQBwBilKGXWACG+fe
         0Th4BMlVZ2T3H0kGIHPnjFp9O5OS5Q1OPFIrqXxG1gY8yRnGN9D7CW0IXfhkp2a95sPy
         Hwe9racHAL8+9zhZeClk95Ie4Uut0lfCntp0bR3Tzyc9rKSb9uBRbQnXUcvkOIIvVl9b
         sl+g==
X-Gm-Message-State: AOAM530hDU1eygNyQIg2HhqQO0vN0Wmtgt0B5nPrb60Hcb+WKwN/RiBt
        DpXg3v6plV6yJ8hCvR2EkDOLS3oTLG8tZ5rvVeA=
X-Google-Smtp-Source: ABdhPJwbiOLtPr4aZFRsT/ot48dhsLvg4NCFYW3ZIjqD//jKXeLgUgkbf6kJuE+yakrEjWfOhLdOUYUZPeca4g10Cng=
X-Received: by 2002:a54:4f8a:: with SMTP id g10mr6148823oiy.167.1628097526820;
 Wed, 04 Aug 2021 10:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
 <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com> <8978132397e95accee5676309d81832724aebba5.1628054936.git.gitgitgadget@gmail.com>
 <eff818fc-9f4d-35db-a4df-8b05408d7d6c@ramsayjones.plus.com>
In-Reply-To: <eff818fc-9f4d-35db-a4df-8b05408d7d6c@ramsayjones.plus.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 4 Aug 2021 11:18:36 -0600
Message-ID: <CABPp-BHgnSu+9ZxEQMDR1x+2Z0zCX2ysqxoH0t=W+a8yrL1L_w@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] git-rebase.txt: correct out-of-date and
 misleading text about renames
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 4, 2021 at 9:50 AM Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>
> Hi Elijah,
>
> On 04/08/2021 06:28, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Commit 58634dbff8 ("rebase: Allow merge strategies to be used when
> > rebasing", 2006-06-21) added the --merge option to git-rebase so that
> > renames could be detected (at least when using the `recursive` merge
> > backend).  However, git-am -3 gained that same ability in commit
> > 579c9bb198 ("Use merge-recursive in git-am -3.", 2006-12-28).  As such,
> > the comment about being able to detect renames is not particularly
> > noteworthy.  Remove it.  While tweaking this description, add a quick
> > comment about when --merge became the default.
>
> The last sentence of the commit message does not seem to apply to
> this patch (any more ...?).

Doh!  Yes, you're right, that last sentence should be removed.

> [Awesome work on 'merge -sort', by the way!]

Thanks!

> ATB,
> Ramsay Jones
