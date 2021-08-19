Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175D9C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 01:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64F2610A3
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 01:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhHSBkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 21:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbhHSBkU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 21:40:20 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7ADC061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 18:39:45 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i13so4280266ilm.11
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 18:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8BUtiISyIGJ+OdcUh3wF3nWrhYXncgtKF2dWCgDud3o=;
        b=vcnppEwNAMnoN7BKl1KA75HaE/eejCE+PFJckszx2vK7epzC98agT7nnvM+FI4St63
         4X29KNmi/hZyEqHy4g5V4RkdoIeWamOL7qZiijDDpSucZ01VESy2e4izHu/M9sklZs2e
         TOlCyGSVUFjDzgpASyFYmXCJnCbRGloGq8NbFud0fG+Khb8tEl+/yos4xKE7QWxQh+zP
         UZ31H+1n56kYhC0ikZahjq5M2sJb9X1Cejjum7dvMNvYXtMe2uoEzfhcU1u1vxTuAcg1
         VPKrc/Oh3KBCSXSkV6MSsaO4gSwONpowse0ljSeYQRZlPYXhLEncAiYMmjXSs8lr5SzQ
         BtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8BUtiISyIGJ+OdcUh3wF3nWrhYXncgtKF2dWCgDud3o=;
        b=fgn6Vy7Rqgl9XiilAhaBMIHA7eK1ODEAdt5l2pSyMJRsa7JEstbFOQ3RGaW9Q0719q
         Sp2d+a8S3ZxJ2nrQQ92to/G/hVOSxdG6xdmtP2VMr+2xUh+wEI+SiXYZjQO5eYKh1GWe
         sWoGGpUKFf2eEu0PLnfQwj6vFYcT4zAeoUN5dGaOvsn+OLzuyjw+202rzcDAJyl19Apo
         Sh3lKqoFmPqqLd1ulNabINcRu98L0fdF6cC9HxZaTxcBKddOMp6fPaco2yCI69lFP8xJ
         F2eTdRRwrdm05BqDdT9ZQdtg5djqoyUP3UWC2+dttLk5WeBkQTWYxLSLPNwdVN8Q63Wj
         Y26Q==
X-Gm-Message-State: AOAM533zKPIsDoMhnKdhdjpveDLYXPlciC/MDpEeR7VvG9aRlIi3sj6a
        gZUiX8nM28VDjxaVlwLHA0DcCBRXKX0mi6JoJ80=
X-Google-Smtp-Source: ABdhPJzvUme3f8oY5KJCevDIKaU6Pu53s49/CDUm3ZJvjG5qCEglIxeHpOTkcaxnIEKOmLnyFSs26VgTYP7K+twHrzk=
X-Received: by 2002:a92:440c:: with SMTP id r12mr7874359ila.174.1629337184981;
 Wed, 18 Aug 2021 18:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TJ_VBh8mreExXHdCFb1e6hB1-Exsn6OFdo2sZNkVFJkA@mail.gmail.com>
 <CAP8UFD0AvakWdpJKBDrEZstVvFOGdjVUkWsBXn7geiUdVzAZGQ@mail.gmail.com>
 <CAOLTT8TB0HUBnYc1U7o36wBp=qxKDOLA6D9K19niNt_y_W==ag@mail.gmail.com>
 <CAP8UFD15vZ4B3dxPamaxqySZgLwffHU1Rx21bHRLY9zndjvAew@mail.gmail.com>
 <CAOLTT8SjLPXT7ows-MZQLmDwzPN5pUrqj26+PHVbTevkBn3Tug@mail.gmail.com> <CAOLTT8RY213BMTq+wx8yS=0QjY55L1BnCgPHQph1uos2oX03gw@mail.gmail.com>
In-Reply-To: <CAOLTT8RY213BMTq+wx8yS=0QjY55L1BnCgPHQph1uos2oX03gw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 19 Aug 2021 09:39:33 +0800
Message-ID: <CAOLTT8Qx3=C=MwRmKbrp=G5T_rQVcaLbZfzzO60m7P-_k1qh8A@mail.gmail.com>
Subject: Re: [GSOC] [QUESTION] ref-filter: can %(raw) implement reuse oi.content?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Hariom verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Christian and Hariom,

I want to use this patch series as the temporary final version of GSOC proj=
ect:

https://github.com/adlternative/git/commits/cat-file-reuse-ref-filter-logic

Due to the branch ref-filter-opt-code-logic or branch
ref-filter-opt-perf patch series
temporarily unable to reflect its optimization to git cat-file
--batch. Therefore, using
branch cat-file-reuse-ref-filter-logic is the most effective now.

This is the final performance regression test result:
Test                                        upstream/master   this
tree
---------------------------------------------------------------------------=
---------
1006.2: cat-file --batch-check              0.06(0.06+0.00)
0.08(0.07+0.00) +33.3%
1006.3: cat-file --batch-check with atoms   0.06(0.04+0.01)
0.06(0.06+0.00) +0.0%
1006.4: cat-file --batch                    0.49(0.47+0.02)
0.48(0.47+0.01) -2.0%
1006.5: cat-file --batch with atoms         0.48(0.44+0.03)
0.47(0.46+0.01) -2.1%

git cat-file --batch has a performance improvement of about 2%.
git cat-file --batch-check still has a performance gap of 33.3%.

The performance degradation of git cat-file --batch-check is actually
not very big.

upstream/master (225bc32a98):

$ hyperfine --warmup=3D10  "~/git/bin-wrappers/git cat-file
--batch-check --batch-all-objects"
Benchmark #1: ~/git/bin-wrappers/git cat-file --batch-check --batch-all-obj=
ects
 Time (mean =C2=B1 =CF=83):     596.2 ms =C2=B1   5.7 ms    [User: 563.0 ms=
, System: 32.5 ms]
 Range (min =E2=80=A6 max):   586.9 ms =E2=80=A6 607.9 ms    10 runs

cat-file-reuse-ref-filter-logic (709a0c5c12):

$ hyperfine --warmup=3D10  "~/git/bin-wrappers/git cat-file
--batch-check --batch-all-objects"
Benchmark #1: ~/git/bin-wrappers/git cat-file --batch-check --batch-all-obj=
ects
 Time (mean =C2=B1 =CF=83):     601.3 ms =C2=B1   5.8 ms    [User: 566.9 ms=
, System: 33.9 ms]
 Range (min =E2=80=A6 max):   596.7 ms =E2=80=A6 613.3 ms    10 runs

The execution time of git cat-file --batch-check is only a few
milliseconds away.

But look at the execution time changes of git cat-file --batch:

upstream/master (225bc32a98):

$ time ~/git/bin-wrappers/git cat-file --batch --batch-all-objects
>/dev/null
/home/adl/git/bin-wrappers/git cat-file --batch --batch-all-objects >
 24.61s user 0.30s system 99% cpu 24.908 total

cat-file-reuse-ref-filter-logic (709a0c5c12):

$ time ~/git/bin-wrappers/git cat-file --batch --batch-all-objects >/dev/nu=
ll
cat-file --batch --batch-all-objects > /dev/null  25.10s user 0.30s
system 99% cpu 25.417 total

The execution time has been reduced by nearly 0.5 seconds. Intuition
tells me that the performance improvement of git cat-file --batch will be
more important.

In fact, git cat-file origin code directly adds the obtained object data
to the output buffer; But after using ref-filter logic, it needs to copy
the object data to the intermediate data (atom_value), and finally
to the output buffer. At present, we cannot easily eliminate intermediate
data, because git for-each-ref --sort has a lot of dependence on it,
but we can reduce the overhead of copying or allocating memory as
much as possible.

I had an idea that I didn't implement before: partial data delayed evaluati=
on.
Or to be more specific, waiting until the data is about to be added to
the output
buffer, form specific output content, this may be a way to bypass the
intermediate
data.

To be optimistic, I think this patch can be merged with the current
performance of
git cat-file --batch. Of course, this still needs more suggestions
from reviewers.

Thanks.
--
ZheNing Hu
