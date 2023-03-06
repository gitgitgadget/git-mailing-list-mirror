Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B009C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 17:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjCFRiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 12:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCFRiO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 12:38:14 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1C36783A
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 09:37:41 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-176b48a9a05so4771279fac.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 09:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678124202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgD/vwRIHohft7BtRpntvLvPbE80RuUEZcLw2Is8JUw=;
        b=dlDIIq1cH5K4nAnZLV7sZOiMmk5SeuipkpGBTi2IOWnA1GwohyxPJVchUGwdcI8t6y
         8FlNSO1/OHlHogzcZ/p8BHS5HglIicEJjBcE7LmwxZ2h3jFQYZiA1ErBOj8FXGmSCz7g
         m4A9qN4PGYr74FMLETD7QdwlJ8HZ6/4PX2WdjUzuxONGRaFRqo1JfsQoZBvmETvX0Xaq
         ed6FCJPQTyYSbuHXyWU7srr/vXUqXvojb63QKqWw0raKXhBqKWSVRzfEFkzjS9tMDp5q
         M6tje5LU++i3zN1FaaPSfcPi48zp+cJ014gaNwsbZaOv9rlRSAUX7/IqNeeSalGPhqES
         zv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678124202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgD/vwRIHohft7BtRpntvLvPbE80RuUEZcLw2Is8JUw=;
        b=B7BF1883t88ONm66OOycey6ckEvCH08NoIZfpqHPyiK3sNcp39SDHVK/F+cmhl0x6U
         MOrQJecW3JRvCGhcvIH7F1gPGKLBskYokjlOlLSHofm7U2syIa5tw9o5qC3uyCPYAzvJ
         x4s/GhYtFYlk3XfU4F2w8tFTLZ5q1KHre4o4g3eXG/hp1om0ONJ15DZSl1g3fi8KOI0X
         ZlztZ+JP0dKTG7fBs0umscaWx8DATY3thOSad34hQWmgJ/90zWW8DmB0pw2IHd8BLvTW
         ENXUxUobSsMIKKnlnie+856G8KHkMfr+34GmkD+L7XsSDEx+8gLqRPJqREObMdEQuXjB
         Ix6g==
X-Gm-Message-State: AO0yUKVwi9KGZWtFCiRsDWz8aOr95S8AFpZSKbMkJpaxOcyQc/OzfRtx
        0ntdNOvAOZtL/nk23DBgAnoiNpuCARGgR4qcb1g=
X-Google-Smtp-Source: AK7set8Bo+9wNETLmXcafe+oHgDCKc31pRtlD35GqNjSlR/vKEPAXqR9Z6daZkNrK/2ZJCH/lU2Vb1xoUN6EOddMu0c=
X-Received: by 2002:a05:6871:6bb0:b0:176:2915:6451 with SMTP id
 zh48-20020a0568716bb000b0017629156451mr4017070oab.5.1678124201854; Mon, 06
 Mar 2023 09:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com> <4f313373-25c5-06d4-6d1b-89a0e595dfa1@dunelm.org.uk>
In-Reply-To: <4f313373-25c5-06d4-6d1b-89a0e595dfa1@dunelm.org.uk>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 6 Mar 2023 10:36:05 -0700
Message-ID: <CAMMLpeTPNoDK9r-e9KMwfYzdG+iyuVwxQGaWHUL-ngD+-r48FQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] rebase: document, clean up, and introduce a config
 option for --rebase-merges
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        chooglen@google.com, calvinwan@google.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 6, 2023 at 9:24=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:

> On 05/03/2023 05:07, Alex Henrie wrote:

> > Suggestions on v5 not incorporated in v6:
>
> Thanks for adding this, it is really helpful to see what did not change
> as well as what did change. It is also helpful to briefly explain why
> you disagree with the suggestions so others can understand why you
> decided not to make these changes.
>
> > - Make --rebase-merges without an argument clobber the mode specified i=
n
> >    rebase.rebaseMerges
>
> I'm still confused as to why we want the config value to change the
> behavior of --rebase-merges. Is it for "git pull --rebase=3Dmerges"? If
> that's the case then I think a better approach is for pull to parse
> rebase.merges and pass the appropriate argument to rebase. That way we
> don't break the expectation that command line arguments override config
> values.
>
> > - Remove the test for --rebase-merges=3Dno-rebase-cousins overriding
> >    rebase.rebaseMerges=3Drebase-cousins
> > - In the tests, check the graph itself instead of checking that the
> >    graph has not changed by checking that the commit hash has not chang=
ed
>
> I'm not sure what value the existing test has if it only checks that
> HEAD is unchanged after the rebase. It could be unchanged because the
> rebase fast-forwarded or because it did nothing.

Please have a look at the email I sent before sending v6:
https://lore.kernel.org/git/CAMMLpeRfD+81fsEtvKFvVepPpwYm0_-AD=3DQHMwhoc+Lt=
iXpavw@mail.gmail.com/

In that email I tried to explain why I didn't incorporate your three
suggestions on v5. Please let me know if it still isn't clear.

-Alex
