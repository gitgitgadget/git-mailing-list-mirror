Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B50C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4024E21734
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZli+7VV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767012AbgJYDv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731790AbgJYDv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:51:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1875C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:51:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n6so8302556wrm.13
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ovpeNklGlc5A2ovP47qMtGeQ9/GwWKcP1dx3bZyTziU=;
        b=fZli+7VVtQVtC0fvLjFedX0S67l/lmLb7XWjuZXYuB8Sx6x9vmUy2jKxQZvVfkIYJB
         4HNDMMLp2XCPRSKQdYM3LFV+TUCBKMP7KQR6gUgibeI2DPv7KLJzlFZ5d8tfEXe7wQrH
         gC5mCKMbUwQ3FhPP9/TwfbJNg2x+vdzfjNVXd1c+9zvXqZxV5U9skczfs4AxDqHZNmh7
         C/plnQAxexYNPYKSX8gXRyPRiu/qfIj2CrDzpEbsgwZ/TigO4vC47QIuhgL3+/nCgQPE
         uCE+wbdImn+mdjs7os4jIP8iOYcc56PPHzR4eu5j17URz9M1VZ8LawWRzzNJxIwtlm8M
         WuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ovpeNklGlc5A2ovP47qMtGeQ9/GwWKcP1dx3bZyTziU=;
        b=RViEZsq3993/sLPNPQgL6f6OG5pY4SAuMBJJOja9c1MptCqiXveg6HTtVlVgszE5xZ
         Oz/AQ6LAU06BpZvcWE6mQ78ZMB1erhBzSuH/Wb7Gpxrez56pNYIjZsH27N8VdvEQqxCS
         isZljf24amXXlOCkFhsKpi3VMbA6J27w2Uu4c3ejsGkzGcJGbAb93e0vtkkAi73ChG0Z
         5oS9SfPDDRIqSTGvgQlFdmdyE/fxAsCi+MzqaS06y9dzp2ei23DYwn2g9fDXfqcrMA+p
         42hrU85lJOJ4kyyixCFhPvIyMZxZ/tOnjj/9Ivg/VliJe4ZVyK/Z3dOTRD1sHmDpztli
         ZHUA==
X-Gm-Message-State: AOAM532aMjS6kOA4fpfD2yhWvItZNAV0s7xxI6OSnqoJHJskeOYUv5ko
        nkpeERe86U3FxBsWX79TixPjAuP9nekT5cPO6t4=
X-Google-Smtp-Source: ABdhPJwut+OZiaZHLdaO7BeV1An1iAVF3MiYrzebutmSFv6hvm3kEHBU/Flw4jc5B0CUsa6XBjQC49fRl1uvfTz8yLE=
X-Received: by 2002:adf:f2c9:: with SMTP id d9mr10540130wrp.319.1603597878446;
 Sat, 24 Oct 2020 20:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com> <20190703190639.GA20404@szeder.dev>
In-Reply-To: <20190703190639.GA20404@szeder.dev>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 24 Oct 2020 22:51:07 -0500
Message-ID: <CAMP44s11BtC8uf11PqDe9ZwVGNHhyjh4usWHBc6giC4ydj+xdg@mail.gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 3, 2019 at 2:06 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:

> As for the latter part of the series, I think the more hard-coded
> options we can get rid of the better we are off, and I would rather
> not see them making a comeback.  I don't really have an opinion about
> patches 8 and 9 (that old wrapper is probably just bitrotting away,
> but I just tried to source our bash completion script from Zsh, and
> apart from the deprecation warning it appeared to work).

I just added those patches to highlight the issue, which is very real,
and you can see by running the added tests.

I will maintain those patches separately in a branch named "hacks" in
my project git-completion. If anybody wants the latest completion with
an old version of Git they can use my project instead.

https://github.com/felipec/git-completion/commits/hacks

--=20
Felipe Contreras
