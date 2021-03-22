Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76001C433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 01:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4823661937
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 01:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCVBIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 21:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVBIk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 21:08:40 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72A1C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 18:08:39 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id y1so18977352ljm.10
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 18:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NP+Ri+oRDru6473xEDOSDrCzAyZHxDq2MO6gTKcKU40=;
        b=oAFJLJmqDxEPID7RTdazf3i4zMWYO5x1MEdX6zY/WnQmNVGuz5QPBvbbPmngs2mhQG
         vbwrpV9ji5gBhNcR7W19DZ5B85Y6wl3tmLnk3Hou128O/uCEWVgf/4P6GwX0zPDzLq4p
         umKDGTzyo5n7/zo5tIP2AA33625URSsmNqp3AZJJgzsQJO0f0VDk/nQ0XAs3JqN66pMz
         P+Af3GGwLtSizrXJ1FEtNxuiB75GA2KB7HdYxR7tum/LJs7b4tqC6xZ4Bwnt96jLTMQ5
         pGpBzUePSHuX8ik1z4noNOinwZHQVzOWWKdUxKl/G6KXHHXATGYPROGyGflH9too+czV
         Kh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NP+Ri+oRDru6473xEDOSDrCzAyZHxDq2MO6gTKcKU40=;
        b=WobkwLXYGfEpe0jMnnisTelrVRYPjnYWHf1YMB0J1elvg+qIM5GVkTWuw0tGrxIXuE
         +2YtFqJtKj2T9REULodRgiLFrq8juvTlh+KVMm6aPTplAPwMkM3LZPIWMHaGl/yXDKAQ
         jBnB71/XwM1900BF7U5sikdJ+bTiOCQ7vvxVJxFJytioTCLQZ+LX8czxPZXN8XG6ykOw
         WxVHfA7JbUzC6+QyqJ0chNsU+pv3/9g0uf3Yc5TNrDKsaRueFiJnbKn5TNPNv5HbGe7X
         U5Xt4zMGRaMi4ImvhMSHTM0eNvdi+pPj94AEMcBgvp4kSZn5tvqLeY4knJwWlawamF3u
         GmdA==
X-Gm-Message-State: AOAM530Z4Qj/ChF1Sw5ES/tD7C0FnTsFNowQ1YWRoe9ldkyYukr+3nor
        W+UI/vU9HjPjHEy4F4nww2TgeAjsJAyNfLpkk7Esyw==
X-Google-Smtp-Source: ABdhPJyoNpoemA9ta8Lmo33gTjpNvyn65cA7ySoTaf9d+D8Ki3y/xvBnYf/qaq8JK2I9fHJO4unrabl1APCFn84qhYk=
X-Received: by 2002:a2e:9047:: with SMTP id n7mr8070716ljg.291.1616375318372;
 Sun, 21 Mar 2021 18:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615588108.git.matheus.bernardino@usp.br>
 <d25ea10560b501d2ca77b567927a0bb9bc874a1e.1615588109.git.matheus.bernardino@usp.br>
 <87h7l4qfdn.fsf@evledraar.gmail.com>
In-Reply-To: <87h7l4qfdn.fsf@evledraar.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sun, 21 Mar 2021 22:08:27 -0300
Message-ID: <CAHd-oW7bycPCnAtme1+LnKxnBbUFdaoi11ff7J5OPgcfqExktw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] rm: honor sparse checkout patterns
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 21, 2021 at 8:03 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Mar 12 2021, Matheus Tavares wrote:
>
> > +     test_expect_success "rm${opt:+ $opt} does not remove sparse entri=
es" '
> > +             git sparse-checkout set a &&
> > +             test_must_fail git rm $opt b 2>stderr &&
> > +             test_i18ncmp b_error_and_hint stderr &&
> > +             git ls-files --error-unmatch b
> > +     '
> > +done
> > +
> > +test_expect_success 'recursive rm does not remove sparse entries' '
> > +     git reset --hard &&
> > +     git sparse-checkout set sub/dir &&
> > +     git rm -r sub &&
> > +     git status --porcelain -uno >actual &&
> > +     echo "D  sub/dir/e" >expected &&
> > +     test_cmp expected actual
> > +'
> > +
> > +test_expect_success 'rm obeys advice.updateSparsePath' '
> > +     git reset --hard &&
> > +     git sparse-checkout set a &&
> > +     test_must_fail git -c advice.updateSparsePath=3Dfalse rm b 2>stde=
rr &&
> > +     test_i18ncmp sparse_entry_b_error stderr
>
> Calls to the test_i18ncmp function should just be test_cmp now. See
> 1108cea7f8e (tests: remove most uses of test_i18ncmp, 2021-02-11).

Thanks for letting me know, I'll fix it for the next version.
