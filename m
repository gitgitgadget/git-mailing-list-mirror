Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC33C7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 12:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjCTML1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 08:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjCTMLX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 08:11:23 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCE51B55C
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 05:11:16 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id p1so3580703qkk.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 05:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679314275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/S7NIvbQVyu5YkEQkKOVTeoN2WBFgMPo8h1jOH6u0og=;
        b=qeHhXP4IVbKO/pbeICfyud5MYbgIjXH6s9aUWEuF7++bToQST1YSeTbIAkE+w55UVA
         73vWN3HNjh7M3O+JS2T1Mx/IAN20i3BmzYwbalbdXiGEVkdZJslrgiax570WqFToHCoG
         3fZen15+pqTiulFWrYvkmiNG5rE+VqrR0nvhUsBzHZjoQSVM+9tzoo99PXFMG0Azyp6x
         K0Y8FPilMuNw1/m73BExya+e6+OlSnWO+hqBmQ6OPnZZzcfNQms80ONKieeeCKRiNnR6
         acDBm6uQKUul40y982BgCjuxki8MD2iHxkIwodBRLr6pJhPvucAoPNAtNq9ASek1+/BZ
         XlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679314275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/S7NIvbQVyu5YkEQkKOVTeoN2WBFgMPo8h1jOH6u0og=;
        b=q6gDe6BwrudTFHFNxgcSpVTPppaDV+hDmMWmQoasaOcXpCShj5mxvBBQ0ajC/fxzb5
         PZpLgXR5MqUQ3C2Dww5PIR6Ullekm2hfG7SD355VFgCA7nhogO06omhChKjGcqpojrAm
         YbeE21e+6hdIkz9rCVWwZsFjo3U/OfQoXRBI0SJmA3rCsIFat6UiL8BSj9A9ZbjgJp4e
         2OSSa/JDhpChXaasUWrI9Bv1NEEkxOCHw5NbhKmlkpzhXSPWXxl74BN+Sg05UzIDxdP6
         Oz8hybATVkpn+aFT99uOBVUjXf7iuU9S62PUY5CXrMPHUYrYb7ixDVcuMnowDABvTgyR
         uuzg==
X-Gm-Message-State: AO0yUKWJOCzWhoD/zfcbtW8PZd9er2FKM8DPFko8HLpkl+DRV7eWI18H
        Eu6xmE/oj/3ah7b4Ql/Ci1VeGdabe0UW7Cy3PMDHjM0sguw=
X-Google-Smtp-Source: AK7set/JUtLge/Qiat8syO8vwCRw4lkl7YfdadcVCF8YTQ4OlGz7YtsVvT+azouG2gYzw01GKNjAa7oZL1pYmq5PNFU=
X-Received: by 2002:a05:620a:22ad:b0:746:7857:d28b with SMTP id
 p13-20020a05620a22ad00b007467857d28bmr1233646qkh.14.1679314275030; Mon, 20
 Mar 2023 05:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfTQZ8vFQXZKgbsedG2BOad-pv9fCVkNkX+kFAxhnhhXQ@mail.gmail.com>
 <CAHp75VcZJPysc2-NXTC53XvOwbx-UfPO9SbsBJFb72JGHFyO1A@mail.gmail.com>
In-Reply-To: <CAHp75VcZJPysc2-NXTC53XvOwbx-UfPO9SbsBJFb72JGHFyO1A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Mar 2023 14:10:38 +0200
Message-ID: <CAHp75Vc419vikJ184syJHN7rxyaspHzgtT9a_uFA=CT=cdqo-w@mail.gmail.com>
Subject: Re: git rebase issue
To:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2023 at 2:58=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Mar 13, 2023 at 2:35=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > Hi!
> >
> > Recently Debian has updated the Git to 2.39.2 and broke my user case
> > (I believe it's a problem in the Git itself and not Debian packaging
> > or so).
>
> Forgot to add that last week it was working nicely (I don't remember
> the version, but according to Debian changelog it looks like 2.38.4
> was working fine to me.
>
> > So, my use case is to run
> >
> >   git rebase --rebase-merges -X ours --onto "$newbase" "$oldbase" "$bra=
nch"
> >
> > in the repository that is made out of bare + a few worktrees.
> >
> > Previously everything was working (my bare repository points to one of
> > the existing branch:
> > In shell prompt: ...(BARE:netboot)]$
> >
> > With the new release I have got an error
> >
> >   fatal: 'netboot' is already checked out at ...
> >
> > To work around this I have to split the above to
> >
> >   git checkout --ignore-other-worktrees "$branch"
> >   git rebase --rebase-merges -X ours --onto "$newbase" "$oldbase"
> >
> > which makes all these too inconvenient.
> >
> > Any suggestions?

So, what should I do? Today I got again to help manually with my (used
to working) scripts.


--=20
With Best Regards,
Andy Shevchenko
