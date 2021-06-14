Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6711AC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47786611AB
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhFNKMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhFNKMU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:12:20 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19FBC061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:10:17 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id h19so4050636vkh.9
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AuyuVVBcZH7XyLkvxlb5B8mmwnC9DwHiSWdFBYqAO20=;
        b=kTN92ddFHUkusnV9frecxyl0dzX3Dta73FyqJyRaVgiNIDmxly5ZUEzP347HqXcBX0
         +Sk4xPOB9xN+b5k1/TLNgaDjhNvUYI2LiUPy65V5qLE6MWl5sFcCSt9xb9VOT1ElgQlZ
         wKHNpfbBqaULlevCWN4KxPDPItHBdTN81RlZBhMH/kOXj/oCr0xN7dhAS/p3ovbCwyIt
         DR/UID7bbbHtsyz5v6JUQBy5nd608cpxLJwUo78Cngjn3QKoUw6T93PMsLO9css7vNeT
         SoxttlRCEaUAdtx0ETzPucVNgzio7BA0VZysA4IVwS+nM8ql9RLI7HFDAhjPs/ejAXco
         Y9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AuyuVVBcZH7XyLkvxlb5B8mmwnC9DwHiSWdFBYqAO20=;
        b=LroF82szM9afzBmAJ+iNHII/ndoaoZigm6KN0uNtVngNjVqkXH/raYDYBQ/lggLH3w
         7Fb388iX0/WFaAzZRZT1LdBf9yWcYaHaeLBuA2RmUH3YKKB+dIJb1YRkxRJbBEzrc3qV
         RjrVaQil5hff4nXt9Yx/j4vRjfnIBLnPIlKm/DNyaXTKoqNKN+7OGjmqbKhmeSUFBuN+
         Niy2m6pmp9znP4Vvq9fwgHSasyj3ovsmqFtQf562ww3yOQzRqgvZSgaSeLaOVZhkkCRK
         9QK44Uytf+3qiAz4Tr4VI7/wcMOyPQM/b6TzLsaoNAUG5Wmt/9L7rdo6xN/aIVspBXmj
         SEHw==
X-Gm-Message-State: AOAM530AsBFmogUqSn/3VC08tXAiMeRO2MwORZ6S+bREM9XQRd/13+yL
        ipzCghwOMWlOXbgxZ3pE5+imGrnJmSAbDT+KukkYBQ==
X-Google-Smtp-Source: ABdhPJwdJVn09gw4XbEZfmMgTEKajdGL9zIip5kdh/vvw9AVY2bDTY8f0ucgiFhN2M58BgEYw52W3Sa6c24vi1knW7U=
X-Received: by 2002:a1f:9950:: with SMTP id b77mr15531775vke.25.1623665416654;
 Mon, 14 Jun 2021 03:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com> <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 14 Jun 2021 12:10:05 +0200
Message-ID: <CAFQ2z_NgAvvPTL2khMjVBSfUyBBA__pWS9NABHvGxTOyc0KnTQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] refs: cleanup errno sideband ref related functions
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 2:57 PM Han-Wen Nienhuys via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> v4
>
>  * commit msg tweaks in response to Jun.

I forgot to update the cover letter, but this includes the updates in
response to review by Jonathan Tan.

I think this topic could graduate?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
