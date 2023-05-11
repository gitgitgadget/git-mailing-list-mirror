Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A38C7EE24
	for <git@archiver.kernel.org>; Thu, 11 May 2023 06:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbjEKGj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 02:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbjEKGj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 02:39:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17B71BE3
        for <git@vger.kernel.org>; Wed, 10 May 2023 23:39:23 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so9259552e87.3
        for <git@vger.kernel.org>; Wed, 10 May 2023 23:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683787162; x=1686379162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hkde+gnSRuekaSzlQtU17JUIE1PxOvqJsM/8O/sRdW4=;
        b=FuZGDpT33P8YgcoumfGJP30shVMJEiPmOwl0Kl9NbMyBnNVDb+wRqR99DoAkErryOw
         3xX9jkhS0QATRLKctByrWzFDtUFjcFjCbwMMs5GFm4CEU3JwkjScYjn+5eUUuT2UIntg
         O+aifpZ2od31x44P5uOAG1SZpYEcMdBqCcM6C58gtAgWObUQO6k9OejKaI7400AcOH/o
         PjxQJR5kdfvc9hT/j/F4XuWbHsTTbtPopOxbEdwzw1p382g+pieJtAvqFJfS9E8Xazo1
         q3I+DbJOXtBUmt4Bx+PNfUWrzhY3EK5kIJH22zcm61oX5HDnhuIV1HKso61wD8qyu0RT
         ZsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683787162; x=1686379162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hkde+gnSRuekaSzlQtU17JUIE1PxOvqJsM/8O/sRdW4=;
        b=lrffo0p7dL9rUM3mlpgKZEov3Ury6qOETVGskimoJ7RtBS+v2ueXTARvaZvgvzFbmG
         b66SRkN+F3ZBB7ihTqMGDQ0L4PHYY/iS6dfxO/Ve1P3Djl/XoP4Kaha7nfqX/enBcP7j
         lSwszqEKJGzb16aFhz5dpqe75L218MpGQWW+WU+4xZRPyiahA52qEe4ExeRF9wITCjmc
         aC9GkXqG1kMMGhdBr6x94zFAZv83vuKc5Qf5N7nV/CLrFjVLfG+oclyJtk/dhxW2L/EA
         whfaFUdShpdEQjo8OiAIw3tUxZqRtjFb/MhOtUYzZSdQBkC3NdN8AS++HwTHa6RuuU2L
         EbRQ==
X-Gm-Message-State: AC+VfDzr+58XSIN5wFnmPNAI5JrWj5DimINaekEZAC3EUyq7QgsxXvi/
        yjrQqiyWPWy8P//o8lFu9dAqj0UcWOdjHqdCZFJXGEuqHC0=
X-Google-Smtp-Source: ACHHUZ421TLVsuo8tKeI4hOgDk7kWc+LYUuS8WjCYZtnWJbc6nr0WEMDn5cNecm/S+ZNdovdCElblK3PA0Ik7GgLP+g=
X-Received: by 2002:ac2:4550:0:b0:4f2:4419:932a with SMTP id
 j16-20020ac24550000000b004f24419932amr2614184lfm.53.1683787162070; Wed, 10
 May 2023 23:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
 <xmqqsfc43si0.fsf@gitster.g> <ZFwm9ZZN57opWbra@nand.local>
In-Reply-To: <ZFwm9ZZN57opWbra@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 10 May 2023 23:39:10 -0700
Message-ID: <CABPp-BFvXnBWmuWb+ttLAoTUxL8Sw0HpyXcB7+tWEPX1xpz+cA@mail.gmail.com>
Subject: Re: [PATCH] merge-tree: load default git config
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, christian.couder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2023 at 4:21=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Wed, May 10, 2023 at 12:18:15PM -0700, Junio C Hamano wrote:
> > "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > >     This patch was reviewed on the Git security list, but the impact =
seemed
> > >     limited to Git forges using merge-ort to create merge commits. Th=
e
> > >     forges represented on the list have deployed versions of this pat=
ch and
> > >     thus are no longer vulnerable.
> >
> > Let's queue directly on 'next' (unlike 'master', where we want to
> > merge only commits that had exposure in 'next' for a week or so,
> > there is no formal requirement for topics to enter 'next' before
> > spending any time in 'seen') and fast-track to 'master', as I've
> > seen it already reviewed adequately over there.
>
> Agreed. I also participated in the earlier rounds of review and the
> resulting patch looks obviously correct to me. I would be happy to see
> it merged.
>
> I added Elijah to the CC list, since he is likely to be interested in
> this topic and may have thoughts to share.

Thanks.  I took a look and left some comments (it looks like the merge
machinery already parses _most_ relevant merge-related config
unconditionally, each time we set up a merge), but I had more
questions than answers.  :-)
