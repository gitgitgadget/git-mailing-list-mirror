Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24E4C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 18:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F6D760FEA
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 18:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhDZSDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 14:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbhDZSDh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:37 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB07EC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 11:02:55 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id x16so629583vsq.2
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 11:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5XftQbe5lbBeFYiW4Wm1lKsy1WZTKVEYX2d9a64oYkc=;
        b=uu4cNsm2iTIS1P4i1HkBXbYYVCUB0h6PdUyDIv1t2ZvE2JLvPLbP/gqYCRMuqGo1jN
         bqh4uh28oKa7NhSekhhg19TLA94E7U6gIAEmPVokSCrb+O4Q+hVf2S3f+zCiMIVQ6Ea9
         G8/5sC2YHWECnMeywQJGS+XX8Yl+XWGgvJTeURk5Wh9qljzWA8nFh5XjesFc+wx5YmgR
         Ntnx7BkA4UWQ7iKcho7YT3CX3EGa0eQodLdBO0Kt/DLKxyWkwAlHk5YwXC47TW4yohi7
         giMppmvSxkKp/EC0boIoY0OqgP4xR+vTJJEm+Eai0EBsq6IqzaAt7hwDx67zzPJbEKkT
         RLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5XftQbe5lbBeFYiW4Wm1lKsy1WZTKVEYX2d9a64oYkc=;
        b=MAj4hThwYFKFPalTA4+WXM4p/VUikXQ7EaK7FFytVf5zH8F7rhTkjeJCdCY7xCAs9L
         95wnPQ3u70atzd36mRfegNyS7/b0SWmol7rNWK56FvNcFAZOfSffFFeqojGbcflPv6rl
         99hVo7UHjAaXhT5T/yZv4wMfUFz9noSHpcbTejVo6dfY5213Cwkc04e1OtiHPDmdKhMw
         mEU1gDePa7RktgHCC9x4amHD3Qui7yvCsBeAjhyOMMbLadiDpoYUethHF0n0MyY9fQsI
         UEzfpqFJs6MjnKPmP5oTUeRrAlo8bZObEWpZpQ6BE8+if2P1HiRrFP9MDpF1x2WV97Fu
         7JxQ==
X-Gm-Message-State: AOAM533IYOZnNZggCgTyWA1hmLKbBdDTnAH+yCAgq9Rih+6AKTd+fqLB
        5+Cn97jI9Ox8DnEa0HtD2ZtVlLMBolBJeCOyIeJvwg==
X-Google-Smtp-Source: ABdhPJyP959cDy61UGMauGIuz6ubaLgmukDZU+mAZldD1DDQoGqkG2oKGnMSNZZzkzgt+3wDfm2PWdKNlZ64Hc/SqLc=
X-Received: by 2002:a67:eb45:: with SMTP id x5mr14375074vso.28.1619460174803;
 Mon, 26 Apr 2021 11:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <a2cce772d44f5939475a1dfddc1a55ab9bbb8ac5.1618829584.git.gitgitgadget@gmail.com>
 <87eef43yjq.fsf@evledraar.gmail.com>
In-Reply-To: <87eef43yjq.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 26 Apr 2021 20:02:43 +0200
Message-ID: <CAFQ2z_Ogj__y5-=Re+WOvE12rnMU4OmF9_9wfq+U20bL-xSWZg@mail.gmail.com>
Subject: Re: [PATCH 17/18] t4202: mark bogus head hash test with REFFILES
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 9:08 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > In reftable, hashes are correctly formed by design
>
> With the file backend this hits this in revision.c:
>
>         if (!refname || !(flags & REF_ISSYMREF) || (flags & REF_ISBROKEN)=
)
>                 die(_("your current branch appears to be broken"));
>
> There's a REF_ISBROKEN is the reftable code, so is hitting this codepath
> impossible under reftable and therefore we won't need this test at all?

I've removed the REF_ISBROKEN bit. It would only trigger in case of
unknown record_types, and I made it a BUG instead.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
