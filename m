Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DBCC433E6
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 16:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A69F23A55
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 16:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbhAUQ1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 11:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387837AbhAUQ0a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 11:26:30 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C75C061786
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 08:25:45 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s15so1545192plr.9
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 08:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SP6Gsp1MyxwNvo61T6HBo9HCopGyj3NRgzJyFJYQVxs=;
        b=BmvCkVGRBJxWArj5Igq+JWK1X8wv18LTunOp0IZxSa15DuyA1YynHhYsu/CMQmlHuh
         jl/0qtDv8JuPtCKhihDOfdiAUiRABfhwsQ42WZbot8LXRUwGDyeIGBWkLuydOIm/KKdg
         BEGZ+++Yd06Se02E66cBNcZIhtGhjtX5z+bKVcNJPKWi96TXfqnSZ2D9AlUIrJPh+/t3
         +u+KADi4nF40c7jLaSaRiFUAa1usaIEigKh25jJ2ku8P8mgGlGijSn0Z6AGuNICFB2u1
         gPH7q3InAIjVceVewFXvluGr5GLmIrM+Gw/WR/8usCbv8SlTGjMRQUr8859Rx5MCu0Qy
         Y0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SP6Gsp1MyxwNvo61T6HBo9HCopGyj3NRgzJyFJYQVxs=;
        b=YhjsR8wHnGuDCLUNtfQ7WAe9ATPOGGQDhVas5ZMKGZOWwmqNV3FUDMIa763RQ5tm7B
         A6RdiQV2eRD6OBmTIrOFQVoJ37IqDQcoYEZeGxRbi4ZMFiisBxbf80joqWbnpdlUMEWg
         XZrandgWz8bKCfJCjliWeFNMuJ04I/PMDYWgsMOyqTjQy/dPn6SQTRl8sH/ce2J5bEBF
         miK0QFSa0V4GcTUR7j7pcGYkL9WXZVlUfYCCBAJi715geBDrrhiTg2oh+/DdRImSHqwF
         OR0CVBLtQjG3BIwl3E4Yc/3ssIZGxaWM/6YOcrVQ3hHNgKu5m9ifWdtUwnp5h7FTQ1Sy
         8czA==
X-Gm-Message-State: AOAM531++9p7jxvjIvndatp6WAbK7hhVzwnb7z/Ux2gKoldof5VhmoaV
        Aq4uM9IeEI+1a5P5g568tJwVrPqvT6eH+572JUc=
X-Google-Smtp-Source: ABdhPJzaJfwQJYe448ylqS8dUeLKVZJgu+4pZSxwq0JPwb7k2mHlTgIDo9fk56rGJIfdav9JCqK01iM5K4IXYZX3PGM=
X-Received: by 2002:a17:90a:380c:: with SMTP id w12mr157140pjb.117.1611246344714;
 Thu, 21 Jan 2021 08:25:44 -0800 (PST)
MIME-Version: 1.0
References: <xmqq8s8so84r.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8s8so84r.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Jan 2021 08:25:33 -0800
Message-ID: <CABPp-BGHpvmx-hdZ==MdODKEDVTr92m3rs4T2d_w9Aa0d0zanQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2021, #04; Sat, 16)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, Jan 16, 2021 at 2:02 PM Junio C Hamano <gitster@pobox.com> wrote:
> * en/merge-ort-perf (2021-01-15) 4 commits
>  - merge-ort: begin performance work; instrument with trace2_region_* cal=
ls
>  - Merge branch 'en/ort-directory-rename' into en/merge-ort-perf
>  - Merge branch 'en/ort-conflict-handling' into en/merge-ort-perf
>  - Merge branch 'en/diffcore-rename' into en/merge-ort-perf
>  (this branch uses en/diffcore-rename, en/merge-ort-3, en/ort-conflict-ha=
ndling and en/ort-directory-rename.)

Any chance we could merge this down to next now?  In terms of pre-requisite=
s:
  * you merged en/diffcore-rename and en/merge-ort-3 to next already
(and marked both as "Will merge to master")
  * you previously labelled en/ort-conflict-handling as "Will merge to
next" (and it was reviewed by Stolee[1])
  * en/ort-directory-rename has now been reviewed by Taylor[2]
Also, en/merge-ort-perf itself has also been reviewed by Taylor[3].


I have multiple series of patches for performance, starting with a
2-patch series, where for both commit messages and cover letters I
want to use paragraphs of the form:

"""
For the testcases mentioned in commit ??????????
("merge-ort: begin performance work; instrument with trace2_region_*
calls", 2020-10-28), the changes in just this series improves the
performance as follows:
                         Before Series           After Series
    no-renames:       12.975 s =C2=B1  0.037 s    12.878 s =C2=B1  0.050 s
    mega-renames:   5154.338 s =C2=B1 19.139 s  1673.551 s =C2=B1  4.586 s
    just-one-mega:   146.703 s =C2=B1  0.852 s    47.698 s =C2=B1  0.221 s
"""

But I'd like a stable commit identifier to place in the '??????????'
slot, and I think the current round of the series you pushed out last
night and using commit 36d1f87d05 seems like a good such label.
However, since I have so many paragraphs of this form and I don't want
the labels to go stale, it'd be nice if we could merge
en/merge-ort-perf down to at least next first.


[1] https://lore.kernel.org/git/5f6d5428-36ce-3e91-4916-8968ac1b8686@gmail.=
com/
[2] https://lore.kernel.org/git/YAdh1XTvDhRzGTiC@nand.local/
[3] https://lore.kernel.org/git/X%2FjHpZlSxwAxoUyq@nand.local/ (note
that the series only has one patch)
