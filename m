Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945E1C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED25610A0
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhEaPF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 11:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhEaPDE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 11:03:04 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4482CC08C5CE
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:05:07 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id x22so6066201vsn.2
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rn3aYu6l6Kfc/gRbLtgwwUkTuowG4d2l0/LuJ2U/7Po=;
        b=EU55KfrNm1RnbaDhmZ6X1oQFQowCZD1qnEjyq8Dm5+AwxpfBpN56IJG2/yvVPesa+D
         M2xJ9bfoT64UtdZxO/6jluZPogEldzAObnds1Mt9gQvtwV10IiKXHv2Z+IHhrF8vAsLu
         uNpcxZJ0M1Ep9i2HePj362RQ6gkks60V2hXIcxFTwJZWqp2jnZmIHfMzILU0uWsJbV81
         ePfjefy0gCcb7nkuFWXhqYWtZQ+YWjV2mALZ+CO4D74CY+0BqG7izpBt7f1ObAkqChue
         RsyV781eIyZRZSBUhkNktjhzr/a9DTcbJRuArlXfNk8eE4bQwhpqfTCI++LMrBqBupHL
         w5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rn3aYu6l6Kfc/gRbLtgwwUkTuowG4d2l0/LuJ2U/7Po=;
        b=Dz6M3e92VLw30RmBFdobGNVAwNNarFl9UivkQpAAu9rlnu3T58M7LmvjzTK3aw6vpY
         Ha/ABzys+3a0m8uEEpBfNohSt/1phVFFjDXpEC1ZkaLUSyzKyqTUuH+xm2xz5htJSGwG
         QqdaXJ0Sz6U+CUHu0scfqvP+nyPE4ZckcGApJ2Jp7vyg+3zHVbRN8jDZKFq8R2OlOB1N
         qn/YYZHt/qj7Wouxgypbc4cytm/qETU2AsVwqIF6odUaNnVvk10TLXjRUx7uV39/b43F
         YZbwdI7xLp6J07lHa9Tzb2X+6lF2fLVQDFZrtPiY9Dlj13lS0ornoJuBNhZB08aRSF03
         0HUg==
X-Gm-Message-State: AOAM532CYmudpgT3UOAjbdWodHbG2XVVmv5vRVx6f+DdkHMHrZ1AE9jZ
        L6igY8zsJg1+s42IvTTwY/SvTaWSLYEES14J9xJnfg==
X-Google-Smtp-Source: ABdhPJySSrK/fNMTkDZY634IYBQfDjD0U/RNeKq9cPCtgy/iMNL8kowlvIpqk/CniFb0JprHkxU+vXpklfqYDa0roEo=
X-Received: by 2002:a67:ebd7:: with SMTP id y23mr13795052vso.54.1622469903429;
 Mon, 31 May 2021 07:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com> <d8e80d83b6f8ee929b187aaffd5f37c3c981b50b.1619519903.git.gitgitgadget@gmail.com>
 <87sg2hpgpk.fsf@evledraar.gmail.com>
In-Reply-To: <87sg2hpgpk.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 31 May 2021 16:04:52 +0200
Message-ID: <CAFQ2z_N1NOhWagyD0xpbAKimoWLdu1Uzi3QdsQz8kq5sy2TSsg@mail.gmail.com>
Subject: Re: [PATCH v2 12/21] t5304: use "reflog expire --all" to clear the reflog
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 5:28 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Apr 27 2021, Han-Wen Nienhuys via GitGitGadget wrote:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > This is more explicit, and reduces the depency between test functions. =
It also
> > is more amenable to use with reftable, which has no concept of (non)exi=
stence of
> > a reflog
>
> Sounds good in principle, but:
>
> > @@ -94,9 +94,7 @@ test_expect_success 'prune: prune unreachable heads' =
'
> >  test_expect_success 'prune: do not prune detached HEAD with no reflog'=
 '
> >       git checkout --detach --quiet &&
> >       git commit --allow-empty -m "detached commit" &&
> > -     # verify that there is no reflogs
> > -     # (should be removed and disabled by previous test)
> > -     test_path_is_missing .git/logs &&
> > +     git reflog expire --all &&
> >       git prune -n >prune_actual &&
> >       test_must_be_empty prune_actual
> >  '
>
> Isn't the point of the existing test to check that there isn't an
> existing reflog, not to just expire it if we find it, or does expire
> --all return non-zero if none was found ?

no. it's verifying that the cross-test behavior is working as
intended. The real objective is to make sure there is no reflog.
Clarified commit msg.

> > @@ -104,6 +102,7 @@ test_expect_success 'prune: do not prune detached H=
EAD with no reflog' '
> >  test_expect_success 'prune: prune former HEAD after checking out branc=
h' '
> >       head_oid=3D$(git rev-parse HEAD) &&
> >       git checkout --quiet main &&
> > +     git reflog expire --all &&
> >       git prune -v >prune_actual &&
> >       grep "$head_oid" prune_actual
> >  '
>
> Just skimming this I'm perplexed why this needs expiring now, as opposed
> to being s/file/command/ changes like the rest...

explained in the commit msg.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
