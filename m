Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C991C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 07:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiGVHUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 03:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiGVHUD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 03:20:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7495310B
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 00:20:02 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k16so3877890pls.8
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 00:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DxaECAExdW7tdhSV0Aw0pZtWJ6HPzRn3AVX3hp3/COs=;
        b=Ma4W/W+daslvDYYptWwtuHPUQ+g4A0GcL7OjqxZxJlR4i7+ZUCXwn/WbsPJLXTisFh
         sTJDxybcHTDWJz+f8PdLDvUNaLm5k/AsTxsVrP2vzI8YqWk1dkeZSbfwVC0BcbQaDLGW
         S20aw1qQRhBjkzL5jedgBgr2dgKOdVmDTOAxjlGFkE5o+h2UIPqXEJ0OEKlOEaoqtz1w
         aEtnu+PWcG/oYEgdq/8O/P4S7aZcAxrnjN1+L+seuy6zjVue0G8F18xwBycnZdgbSpcC
         6LpYgUORCSRRsbtRL6mSHAgu+bHH1GCbyuh7tb/3lA7G9ApEyyENKkwSUWAKh9cHD0kX
         m6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DxaECAExdW7tdhSV0Aw0pZtWJ6HPzRn3AVX3hp3/COs=;
        b=j2Pq1VTL0JjMFuEHnLUeaf9P8PXIL2KFm/gsYF6Cro7xEImDoibiyIJmfAZ19UXWKn
         WMnHSgeCRn1W79BHEE6mTYq27IR9mh7FryrLZBV7QazsqLUEz3PSj0Df4uZBdYjoSpV5
         Uh+1LGPgo3i7Fy2PA2dubR3EDzcZctxe+KemDU7+Zrscwh0faYYt9ZwAYKTbwfsJ+xiA
         ld0aBsGSggqxHfCfb9m5AmB8kzyztBbf6aspeFzjVQKvDTyPVO2VaUFUVC+LCfcLKtkH
         bR/iShLJ6SIDEwySEpTZwzUWIQcwd7kNyya0unY9H4yt6ReFBBjjhcbKBSj24Z73ApMd
         w2ww==
X-Gm-Message-State: AJIora+k1KkosMqb/NZ/ZeAREcGsY6GSbZ/DGpmlfXnjawls9pFGD2Eo
        HQA0a0mvAr7M3lvZCPnOpyqQiH25gc1aisLlDQSiTPmD8Dg=
X-Google-Smtp-Source: AGRyM1uUScGhaEnJ6R4/4N9NG/U+HrFb6mhaYIN3+JOq0jFeDGy6iODAP96/1C8UvMqu1lPmzBcHLlzGvsA/3MOxZqA=
X-Received: by 2002:a17:90a:887:b0:1f2:af6:4d20 with SMTP id
 v7-20020a17090a088700b001f20af64d20mr15853718pjc.190.1658474401886; Fri, 22
 Jul 2022 00:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqpmi04m1f.fsf@gitster.g> <b908b42b-2cd5-12b2-b47d-abecfb370429@web.de>
In-Reply-To: <b908b42b-2cd5-12b2-b47d-abecfb370429@web.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 22 Jul 2022 09:19:50 +0200
Message-ID: <CAN0heSrpXq0bKW5E70a421GhDXDFnvT+=txw=rPQJu47n65TSw@mail.gmail.com>
Subject: Re: rs/mergesort (was: What's cooking in git.git (Jul 2022, #06; Tue, 19))
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Jul 2022 at 00:14, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 20.07.2022 um 03:20 schrieb Junio C Hamano:
> > * rs/mergesort (2022-07-17) 10 commits

> A confirmation that performance improves or at least doesn't get worse
> on other platforms as well would be a good.  The numbers I gave in the
> commit messages were for macOS 12.4 on an M1.
>
> I managed to install the Git SDK on a Windows 11 laptop with a Ryzen
> 5800H, and it gives me mixed results:

FWIW, here are my measurements on a Core i7-8700T running Ubuntu 20.04:

On e72d93e88c (The fifth batch, 2022-07-19):
0071.12: llist_mergesort() unsorted    0.42(0.38+0.03)
0071.14: llist_mergesort() sorted      0.17(0.14+0.02)
0071.16: llist_mergesort() reversed    0.16(0.10+0.05)

Benchmark 1: t/helper/test-tool mergesort test
  Time (mean =C2=B1 =CF=83):     143.9 ms =C2=B1   0.4 ms    [User: 143.6 m=
s, System: 0.3 ms]
  Range (min =E2=80=A6 max):   143.1 ms =E2=80=A6 144.7 ms    20 runs

After patch 1 (mergesort: unify ranks loops):
0071.12: llist_mergesort() unsorted    0.41(0.36+0.05)
0071.14: llist_mergesort() sorted      0.17(0.12+0.05)
0071.16: llist_mergesort() reversed    0.16(0.12+0.04)

Benchmark 1: t/helper/test-tool mergesort test
  Time (mean =C2=B1 =CF=83):     141.5 ms =C2=B1   0.5 ms    [User: 141.1 m=
s, System: 0.5 ms]
  Range (min =E2=80=A6 max):   141.0 ms =E2=80=A6 142.9 ms    21 runs

After patch 2 (mergesort: tighten merge loop):
0071.12: llist_mergesort() unsorted    0.42(0.39+0.03)
0071.14: llist_mergesort() sorted      0.17(0.10+0.06)
0071.16: llist_mergesort() reversed    0.16(0.11+0.04)

Benchmark 1: t/helper/test-tool mergesort test
  Time (mean =C2=B1 =CF=83):     142.6 ms =C2=B1   0.9 ms    [User: 142.1 m=
s, System: 0.6 ms]
  Range (min =E2=80=A6 max):   141.9 ms =E2=80=A6 145.3 ms    21 runs

After patch 5 (test-mergesort: use DEFINE_LIST_SORT):
0071.12: DEFINE_LIST_SORT unsorted     0.40(0.35+0.04)
0071.14: DEFINE_LIST_SORT sorted       0.16(0.11+0.04)
0071.16: DEFINE_LIST_SORT reversed     0.16(0.11+0.05)

Benchmark 1: t/helper/test-tool mergesort test
  Time (mean =C2=B1 =CF=83):     123.3 ms =C2=B1   0.5 ms    [User: 123.0 m=
s, System: 0.4 ms]
  Range (min =E2=80=A6 max):   122.7 ms =E2=80=A6 125.2 ms    23 runs

Martin
