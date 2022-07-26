Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB49C19F29
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 18:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbiGZSXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 14:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238968AbiGZSXI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 14:23:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48A226131
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 11:23:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ez10so27512156ejc.13
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 11:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/oEFxD2A4j3jBM67dbZJK4VTyPQZbuP4BbNHKA9N77I=;
        b=a05IP5mriCfXAK9Jm3ZXiNMJtepga7byR8mUtFnQSjxaIElcD2J3rP6ApTy81vx0pO
         fd1/gIVfnjv25LhydqoYYPGAZ2OP0RreFymBVvy5lt6EzdB8I+wulyvfbluPcriFx2iM
         MuQm9UmuQq4LSsbriUoMWsmKaxwLuxY448zYHrBF27QhZhGhSVn19i3j6Fd4DUZVvluP
         FOIJqtLLTLgkCF7sQ8lkSvpHtc7qzWNQQ4zzkf2vDwbMggmq1hISNBM+x8Si+x7i7HWv
         DAboITVbniceIV+EDdTtheudhFsCiBQv6ecZIwQuQshT1VKfWiuCn45HYS0iYG13PW/l
         taFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/oEFxD2A4j3jBM67dbZJK4VTyPQZbuP4BbNHKA9N77I=;
        b=4cHSJqw50PJE++MgUF5htIWEy/fFZ+KvcAgJ+UQOLQbRESNLq/1tiXAUQ7D8cdR0qe
         SbMGo1QAlVY4IvjxKGsEVbGmfZUAtkIhnmJbTvwrwpQCnazvNClZ8f0577qBW0CTs8RC
         l/IeqQq08LXTRzOUp/xrCWhjEDCN5Y7wS+tIeVDROqp8AWyfFy0Xc6G8issALrTKPoiO
         PG05Mmb0BpHbB4PPIRGOfII0gyXzIVlnw9R0xBClqzwme8C0QSm7uI8yG8gJIa+Ecoxz
         F3wfc558B/+So86D76iTZabz9xRr4YXfY9AaiSrQ0JikRnnLQmBG4tKuqPgIhz7bbj8D
         heUQ==
X-Gm-Message-State: AJIora8ya5SSA91lO6Yhq3IQw2S8pYiY1M0Da5S6RFkFKkEjaqySotan
        4u64a0DYZHFR1UIVdedLc9Pbmogq4jkPak+3ooo=
X-Google-Smtp-Source: AGRyM1uNfXDVEq6udsKv1XlN2uswgI6PPZsOjjYMnJkdEs8fKjXSRpSuZ8cFrZjGJzeN0A0pbBZB6XAi4694Y0fHLiY=
X-Received: by 2002:a17:906:8a79:b0:72b:871a:57b7 with SMTP id
 hy25-20020a1709068a7900b0072b871a57b7mr14649602ejc.602.1658859786219; Tue, 26
 Jul 2022 11:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <a913e6a2cb36d8ec7900b60820d8ab3c35f60164.1658342304.git.gitgitgadget@gmail.com>
 <Yt8650eWLfm5VlLe@nand.local>
In-Reply-To: <Yt8650eWLfm5VlLe@nand.local>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Tue, 26 Jul 2022 23:52:54 +0530
Message-ID: <CAPOJW5zYngCgab80yFsBrFg0ENiWcGMn71R=QH1k=kfZ+aPkaQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] pack-bitmap-write.c: write lookup table extension
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 26, 2022 at 6:22 AM Taylor Blau <me@ttaylorr.com> wrote:
> I wonder if it would make this patch a little more readable to construct
> and use the commit_positions array as a single preparatory step before
> this commit.
>
> What do you think?

Yeah, sure! I have no problem with that.
> > +
> > +     ALLOC_ARRAY(commit_positions, writer.selected_nr);
> > +     for (uint32_t i = 0; i < writer.selected_nr; ++i) {
>
> Nit; we don't typically write for-loop expressions with variable
> declarations inside of them. Make sure to declare i outside of the loop,
> and then this becomes:
>
>     for (i = 0; i < writer.selected_nr; i++)
>
> (also, we typically use the postfix ++ operator, that is "i++" instead
> of "++i" unless there is a reason to prefer the latter over the former).

Got it. Thanks :)
