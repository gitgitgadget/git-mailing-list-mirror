Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8083C2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 09:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB99611C2
	for <git@archiver.kernel.org>; Wed, 26 May 2021 09:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhEZJZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 05:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbhEZJZI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 05:25:08 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176B4C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 02:23:36 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id n61so400306uan.2
        for <git@vger.kernel.org>; Wed, 26 May 2021 02:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0O0U6XGjthPOtm9oP6GrhtYCd0p/03xqWZGVbFHe3tI=;
        b=mny3ORkZ4N9Qkho/mi78XVazkCdlpiae8z0hrM4iSbn6HJqyLRzGDltWNSEARh8YCR
         2ED3qQ2Wg3Oj4W0MYedZZ8QavEHZmls94Taj5FYUbReDLpcqUuf99L4r0BoVHmD3orpW
         quRCzWK8Ke/Fbp0uD5s5xm85ZCAjab3Hsb6o+O29RvQ+KLxVpMTG6iy4Cjrv8QHgL9+d
         HZe79U7MIdhwDEsLA0b90uyWUOgO2sAPcntq7g96qqJs/XguttBk/ck6I/qiAW/UWHCa
         O6fpUNvk4eFf8fyd/So8mwMi6fzBHTYrBfmFxUycRi6nO0UpsvkG3Cb4K09yIpBPMkm7
         Q49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0O0U6XGjthPOtm9oP6GrhtYCd0p/03xqWZGVbFHe3tI=;
        b=oAnWrv6cSgHmd2JediJUxHNsVMt4Rz9t4+SX7QndhMboOrDJTklK90w4b/eFzecWqU
         uxvXH0dwKaMvp2klVLV8rZi7AbxS5zpVd6q0MtkdTh9pue9Hf4e4Co4sxMsPqbdRptJF
         NUuI724m8tuAyWnXl4LrwMlAzweAMESCGiGgtXkG46nF+qVTmaAMCu812UaFAai+ZpDx
         q9S0oz0QgNmLebUnYDRDxmpfXn/9498k83SmSlvlUj9bfstAyGpEmgldcM64++6hHVUN
         BMEkcvVbO26KAlA0SAIPN6lKVMN0cuCC9DfxjKjLywpu1tG4pcTN0FwvJB9MxrEr1OOp
         mVZA==
X-Gm-Message-State: AOAM531bD/eOK35Mz4csa9CEIuAj3Hm6Ef7Eh9YH6CNaXN7mAjUruPP3
        cCvCRBUVMEhIh7IIMZG9UeNR4BIiviQ0M1FJz7QtGQ==
X-Google-Smtp-Source: ABdhPJz6ZQo9vZCAblZUmGx09t6aZX1jsdiXpky5nqoVaXrHtyvv64WQO+XCX9j4Xb4fPO089wJVEIyQNWg2evj/VkE=
X-Received: by 2002:a1f:a681:: with SMTP id p123mr28415073vke.19.1622021014977;
 Wed, 26 May 2021 02:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com> <878s49pdmd.fsf@evledraar.gmail.com>
In-Reply-To: <878s49pdmd.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 26 May 2021 11:23:24 +0200
Message-ID: <CAFQ2z_NDKn4vTM_WBrDMumrcTkzS2nOT-cd-TQ=LpTHG+m8Fug@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Prepare tests for reftable backend
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 6:35 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

>
> I looked this all over and left some nits, suspect/probably/definite bug
> comments on specific patches, the ones with no comments from me LGTM.

Awesome. Thanks for reviewing. I'll try to go over your comments this week.

> I intentionally didn't review my own earlier feedback on v1 to look at
> this with fresh eyes, I'd forgetten what points I raised, aside from the
> general "let's not skip tests but test the new behavior" mantra I think
> I either mentioned there or in related discussions.


"test new behavior" is troublesome, because it requires merging the
reftable support first, which in itself is a tough job, and predicated
on getting reviews for that code. This is why I split this series off,
because it can be merged early without impacting coverage of the
existing loose/packed backend.

How about I document more clearly, for each test marked REFFILES, what
is going on, and what should be done for coverage with reftable? We
can go over it as part of the reftable series. "REFFILES" will be an
easy term to grep for.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
