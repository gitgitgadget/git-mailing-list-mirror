Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C678C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 09:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbiDYJtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 05:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiDYJtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 05:49:16 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FA71B7B2
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 02:46:09 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c23so25804839plo.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 02:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2ZOwvyHQXbaX58WJhT28V5ADM/5kMlCPS95sd2FnPOc=;
        b=MW+gzgIxa3efDWiPGrYbSorr58ZOFyBoIMLqw3qPOHbtckATw4WN0YrdKT2UZav2+3
         4k+qWLG1bg7KPVtE0YA34MmDS//m4PYMBEdP+gzU0dXuqeJkLWFh6tSTPOnl2NdlC8wv
         t3lJxdXrFozTmTwSHS/cCAdDEkczYr0cgQWprlBNu2c6TalBjrXK1Cr7ks014EIyCzlK
         r5P+szEOg8sm3aAc5z/j6DbhdRhnQpYRs798TWcbf+b6FV9AzwR0z6PUEkFsoJbvapZg
         y7ohUQrEYLTWG7PmYyp4bRYVbM9DxAHOythXWmAbfimsxpkwYmQh9GqerwLoqXY+xv0d
         HyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2ZOwvyHQXbaX58WJhT28V5ADM/5kMlCPS95sd2FnPOc=;
        b=A8zEuMK8FuQwjSW4G0+QzQHiRwwqwaqDfNRR+PEseUIoMLhU+yE6jPzYO9l1llxkAu
         GTNZ+FOygQF6yJwZgIV55Byx9XpuuevHEMG3XXyifbBKF4/llmgZNdLSzyEwUi3DUj99
         gkdMErRVdFILgGV/EwetezH3cIPydQvwxRYhrkodzNiyDQmli/vlB7DEoUIo4pB7TlmY
         2N2vfSAOiKxMMdhd09MK4rb3nVZwoJlb6npMmUNFGA7EFwjcMIzBgMDMorMJMyYagI7U
         2wN6w9Hvgba93eSnB81KctuCj/OanJLciO2+jS6IFZTR64Hpavi5YPsT1YSJouGRFHJn
         qyNA==
X-Gm-Message-State: AOAM533/X5SJRGcfBQTcGdk5W3ZGc8K7iCpLqoAGCcrBK3zPbtqds5EV
        PnN1wiPlG6BBcXD+rmPhQ5rGft1AWz+mYptcPVc=
X-Google-Smtp-Source: ABdhPJxU758RkBZ/O2QxTrPNj7psXvQCiiGr4jft1GqmdNYYQhO05MB+NmLN7+GVS+O1HU/qiu6IP+SG7ZAfWKhG0zc=
X-Received: by 2002:a17:90b:1d0c:b0:1d2:a91e:24dc with SMTP id
 on12-20020a17090b1d0c00b001d2a91e24dcmr20035298pjb.165.1650879968814; Mon, 25
 Apr 2022 02:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1220.git.1650331876.gitgitgadget@gmail.com>
 <5b90dfbf-b299-1388-f9b6-c610ce12bab7@gmail.com> <BYAPR06MB4517BCBBA837AA3004B2137DE6F29@BYAPR06MB4517.namprd06.prod.outlook.com>
In-Reply-To: <BYAPR06MB4517BCBBA837AA3004B2137DE6F29@BYAPR06MB4517.namprd06.prod.outlook.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 25 Apr 2022 11:45:57 +0200
Message-ID: <CAP8UFD1aAVCgEQvi4WjCiRUBWs6_u-7k-JWTz5b1N7xa=V8OdA@mail.gmail.com>
Subject: Re: [PATCH 0/3] [GSoC][Patch] area: t4202-log.sh, modernizing test script
To:     Jack McGuinness <jmcguinness2@ucmerced.edu>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jack McGuinness via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Apr 19, 2022 at 8:33 AM Jack McGuinness
<jmcguinness2@ucmerced.edu> wrote:
>
> Hi, thank you for the advice. I wanted it to be that way myself, however =
I was using gitgitgadget to email it, and my PR was composed of three diffe=
rent commits, which caused it to automatically be formatted that way. I tri=
ed finding a way to remove it, but I had no luck, If you know how I would l=
ove to know!

I don't use gitgitgadget, so I cannot help you much on this. The
approach I would take if I had to use it would be to find patches on
the mailing list that were sent using gitgitgadget by experienced
developers using it, then find and see how the corresponding PRs look
like on GitHub, and try to imitate those PRs.

Anyway, it would be nice if you could try again taking into account
Junio's suggestions in:

https://lore.kernel.org/git/xmqqmtggs2nv.fsf@gitster.g/

I also have some suggestions below.

> To: Jack McGuinness via GitGitGadget; git@vger.kernel.org
> Cc: Jack McGuinness
> Subject: Re: [PATCH 0/3] [GSoC][Patch] area: t4202-log.sh, modernizing te=
st script

This is your second attempt so it would be nice if it had a "v2"
marker in it like "[PATCH v2 0/3] [GSoC]" instead of "[PATCH 0/3]
[GSoC][Patch]". (Your next attempt should use "v3".)

> On 4/19/22 08:31, Jack McGuinness via GitGitGadget wrote:
> > Jack McGuinness (3):
> >   [GSoC][Patch] area: t4202-log.sh, modernizing test script
> >   [GSoC][Patch] area: t4202-log.sh, modernizing test script p2
> >   [GSoC][Patch] area: t4202-log.sh, modernizing test script p3

Junio already commented on the "area: t4202-log.sh" part of the
subject, so I won't repeat him.

About the "modernizing test script ..." part, it would be nice if the
different patches would be a bit more specific about what each one is
doing and "p2" or "p3" is redundant with the "2/3" or "3/3" added by
GitGitGadget. For example it could be replaced with "remove whitespace
after redirect" for the second patch.
