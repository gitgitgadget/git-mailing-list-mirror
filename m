Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E72C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 16:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55DED61074
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 16:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbhJGQgi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 12:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhJGQgh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 12:36:37 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79FBC061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 09:34:43 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id h132so2979671vke.8
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 09:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jjU4txzAWC7H82FxvooA4Qv0zqfQ8+CtFTrdffYtdI0=;
        b=c1/kLaRvy4DB/NBxo9T/c2eH2chDGBhBL40+HShhJYKDk4U5LCHraBgGiWu4vPqJfh
         Dau/Ewccp/iu7X3MCiu/Le/W2MhMBRlgwMWmiqd4G4qpLeuO56MuXlCjl+hHx4juGjeM
         Xkb3sovJFUAWWnv9zYmLGgM8o+YiGddHxB83fir5u5nkWIZQXAYuJBuLQkV2NEJvMyyg
         oJkD4uij+tMTqs83gKkU3pAiS7lXCU+BCCWwgjUmbH3XAUY6EG13t17dagvSbwYuuCZ3
         Iky7fUcD7cdkOregOEf0XuzEYVDPpwnrDZeudd8m2ioT7SsawmfaxFjpLcLu9bSamcyV
         nirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jjU4txzAWC7H82FxvooA4Qv0zqfQ8+CtFTrdffYtdI0=;
        b=FRTaUiZSCYlhS2Z4bplW9R/5LxUXt88ojLfMARy73HSQdky2z9FDCy20P20WbomAPi
         RmOfSuol7UkXMCKlVnU+6oXlDLAGRG5q/ZIAFnd1YCpgPA2iDBHKjjmWEfJdImBdZrCp
         NLlAvsK85oyG2ZM0QchuoS5php0kFPoWf57sOoMMPoCe+ya3R+C0/8wMnUXjPTgb7n7O
         b5ypdbdwIzE6hR0W36TVBRbCW/DB/5PmfBRLYham52/JWcX9P7+MkxXOqARThlLm0DNy
         KNcQc5oGjraZO1SQujUOuij9HOaZVZEeTBBiPUxeyk2TkOsoEx9P3bwoMgovjh1dhvDS
         BiWg==
X-Gm-Message-State: AOAM530I9+ZfLbKgJDoVYovLEwrFllh66DYXIcDQh/rU9tB5hVcOcqfQ
        2EpH5HqXHMoSABZq9v0BBDCpB8fub6JqStcDrWnVKg==
X-Google-Smtp-Source: ABdhPJyh4nKtL9eo4C3X+VKNR3jP3lTzIfgmVQwXoj0iIJeqImiW5be7KGC8NPJwDuCLc7unSPzt5IB0JIdNiyFx2xE=
X-Received: by 2002:ac5:c922:: with SMTP id u2mr4528193vkl.9.1633624482806;
 Thu, 07 Oct 2021 09:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <04f2d74df5189f473bc7a6395b9e194a1929f623.1632841817.git.gitgitgadget@gmail.com>
 <20210930122352.26505-1-carenas@gmail.com>
In-Reply-To: <20210930122352.26505-1-carenas@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 7 Oct 2021 18:34:31 +0200
Message-ID: <CAFQ2z_PoRTOZDmZyWObeL3CC4Y5SvJhaVAMfkV-nT4NnMdL6zQ@mail.gmail.com>
Subject: Re: [PATCH] squash! reftable: reading/writing blocks
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 2:24 PM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
> Avoid a possible infinite loop in platforms where size_t > long
> by using instead the required type and checking for overflow
> before doubling.

Thanks for your attention to detail. Folded in.

I think the loop is rather hypothetical, though: the block size is
limited to 2=C2=B2=E2=81=B4, so I think you can=C2=B4t make blocks that lar=
ge.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
