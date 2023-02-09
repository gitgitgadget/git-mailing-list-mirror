Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7068FC05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 08:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBII1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 03:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBII1B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 03:27:01 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33914126D1
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 00:26:59 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bi36so2141870lfb.8
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 00:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kJ5j7KmgHdtauIkDkSIR3xO8ODjOuoCyXxa5INP/Clk=;
        b=CHx6rE/kA34I/Smh8ZnjGJC2Q+nn1oNuYiYsccV/sRAF9dXMHQohsq3WgoRwmKwuV/
         /H516PQLqFAR1d2gNfE9yHubUFpvE1VK4NaWeJJiJRsJpDPp7wqqWAzAhsuWefzrKVY5
         fKvxrIKg5Z4ku8U+r/9lN5Uo9kR3YU3nhpymWa4Dg/rZ6hgamq8AP0SgQJmCXFLU1+Xf
         n2flgkie0ThLtIEpZQHwuv5VomGrMTnqVx6p2p6Frw60jej4txc34pGiJhTI1R8X0hXs
         zTz9EAgg8BEPnxywpT6QkzzeeKy6kzPLxC5RKeWZn4GSSQO5zKh2h6Hz/8ol9hHvo8w6
         D4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJ5j7KmgHdtauIkDkSIR3xO8ODjOuoCyXxa5INP/Clk=;
        b=G5bS75SoisZwEHZ2V0rp+LIDP6PIhyVWgLDvm9em6rigF6WofPTs18tYyrpggtxUvc
         4lKPyHw20fSrQOta09aG/6/0WOaIkn+F4ESrBoNJgBU1I73OgLU1CkK8X5LhEpE8fM2E
         CiPcygh/Vwb+J+ARs2HKB8dr4HV57WwH/DRCZctHFDf2XV4qEtgXBRtKmDSfEoAr9Im9
         hHimtjvK9D7jyHN7Rcf1YuF3gT6Ipuhp2gT04lS5H7JI00S47vM4YKcm6KWa3n3gh/lq
         oARNI30kJI2jqFeGH9JhmKf1wtXejGRfKy+G7JKfc4wl7nL2U5psJzR6DNPYwWlyeScq
         M1cA==
X-Gm-Message-State: AO0yUKWCZHECHV+34W+vLUFk5lADtEF+k34Lf5ksnX3/ToBtLeZwf77A
        ZavttVKJ2cTpPA9P71uF9iVdpDBtECGZSeOeCFfa3wCGIvI=
X-Google-Smtp-Source: AK7set9T8vqYcNsX7WNWRz5LR7IIabubxOMHty/KO9/iNeuDx1tEJLOeKH1xuMXk/07uFLox5UsN7f3iF67Q4RxfNd8=
X-Received: by 2002:ac2:519a:0:b0:4b5:3f7f:f9ed with SMTP id
 u26-20020ac2519a000000b004b53f7ff9edmr1933716lfi.177.1675931217277; Thu, 09
 Feb 2023 00:26:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <19f6b40b-d8e8-e86c-5a9a-b35f42909118@dunelm.org.uk> <7852AC7B-7A4E-4DD0-ADEA-CFFD5D16C595@gmail.com>
In-Reply-To: <7852AC7B-7A4E-4DD0-ADEA-CFFD5D16C595@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Feb 2023 00:26:44 -0800
Message-ID: <CABPp-BGhuTyq_hrpMc+Ky3yt1UgO7DcAsgcYH15FK--QLdCsQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
To:     John Cai <johncai86@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John,

On Mon, Feb 6, 2023 at 12:02 PM John Cai <johncai86@gmail.com> wrote:
>
> Hi Phillip,
>
> On 6 Feb 2023, at 11:27, Phillip Wood wrote:
>
> > Hi John
> >
> > On 05/02/2023 03:46, John Cai via GitGitGadget wrote:
> >> From: John Cai <johncai86@gmail.com>
> >>
> >> It can be useful to specify diff algorithms per file type. For example,
> >> one may want to use the minimal diff algorithm for .json files, another
> >> for .c files, etc.
> >
> > Have you got any examples of why this is useful? I find myself occasionally changing the algorithm when the default gives a sub-optimal diff but I've not really noticed any pattern with respect to file types.
>
> At $DAYJOB, there has been a discussion and request for a feature like this [1].
> One use case that came up was to be able to set a different diff algorithm for
> .json files.
>
> 1. https://gitlab.com/gitlab-org/gitaly/-/issues/2591

A couple points:

First, there seems to be a misunderstanding in that issue.  In
particular, the merge algorithm does call into the xdiff library to do
the three-way content merge of individual files, and when it does so,
it has to specify the diff algorithm (or take the default, currently
myers).  merge-recursive allows the diff algorithm to be specified by
the user (there are
-Xdiff-algorithm={histogram,minimal,patience,myers} flags to
merge/rebase for it), while merge-ort uses histogram (though it uses
the same parser as merge-recursive and thus gets the variables set
from the -Xdiff-algorithm flag, it just ignores those values and
hardcodes histogram).

Second, I also think the user request got converted to a particular
solution without looking at the wider problem space:  The idea seemed
to assume "myers" is default for a good reason, and thus asked for an
option to use something else.  I'm not sure the assumption is valid; I
think "myers" is default for historical reasons and histogram is
better not just for special Salesforce xml files, but code files too.
The output makes more sense to users.  So much so that even though my
simple testing suggested it had a 2% performance penalty compared to
myers, I forced ort to use it[1] even though I designed  everything
else in that algorithm around eking out maximum performance.  Others
who have tested the diff algorithms have also found histogram has very
similar performance to myers, and oftentimes even beats it[2][3].
Also, worries about invalidating rerere caches[4] was real, but we
already paid that price when we switched to ort.  And if performance
is still a worry, [3] gives me reason to believe we can make our
histogram implementation faster.  Finally, for the period of time when
Palantir was letting me make an internal git distribution (mostly for
testing ort), I also carried a patch that changed the default diff
algorithm to histogram (not just for ort, but for diff/log/etc. as
well).  Never had any complaints from the users from it.  Perhaps you
could do the same in your local version of git used by gitaly?

[1] See c8017176ac ("merge-ort: use histogram diff", 2020-12-13)
[2] From 85551232b5 ("perf: compare diff algorithms", 2012-03-06):
"This does indeed show that histogram diff slightly beats Myers, while
patience is much slower than the others."
[3] https://github.com/pascalkuthe/imara-diff
[4] https://lore.kernel.org/git/20120307114714.GA14990@sigill.intra.peff.net/
