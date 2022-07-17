Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA44C43334
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 16:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiGQQln (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jul 2022 12:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGQQlm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jul 2022 12:41:42 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31EC13D4A
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 09:41:41 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id n138so6368808iod.4
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=53f+0W/EFdqLQh3uq0QCzUer3TVjndjidzh16uSFQec=;
        b=atkHjgLG9CdYOEVhkdCULhkz7x6QUWQgpmLFz95ZoxFLjqKBpqhkyMW00VfTxBdBkE
         p1OvEobRTwcmzDueEtyYDqJBXZS8Bak0OBg/UB0jDCbOxURJB/dlAg2fdb2cuW2Xs4fr
         MHx7n6wZKQosXRvfCv5HQvDtMqiptkrNaPYD5vcavH3wkqhTvx8IaEqDbGel6dN9eM62
         Zev8CdibRrf16OBu/Hhp6LBqXMyn1FYKYksIHRhoUaIQX80Y1L4V22rD/YKq7q1LllOo
         V3fJPE6itJHfWQ9MH86wO4BDasnrBLlkvM7iwaWOgPvCkSJEA29dzRVdlmrlVPCuMppS
         Vt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=53f+0W/EFdqLQh3uq0QCzUer3TVjndjidzh16uSFQec=;
        b=kI1eCL1eEI0tRuqtTofWKmZLo8tZSiMXSytHwA+ZpZkBsIvfiCf1g97F0oebgY0x10
         iubYLdVxTyO1QVeYfsPDrMXMPYR93P4UWTxeKU4hX5/TzhVK/IrCQjeDmmN9pSfYvqTh
         8alMQzT7TEV2KhIfqI3TGWRI7h1OiQoQZq2dOrevTVeKeGd3KgTgd4IuAz2SSOpMLJte
         Y15QoyEj2QPUKAyUUSk2PlrDcCLOg9e7syilONakZdp9rA8nF2bP6IeQIs5YUTEvFFA/
         8Gu/j+HmrS2dBitanVpeMKsuWb/7QrnMdGXAHu4vEgR+LQuACnvFT8f7/QUyYVJYDjLm
         9z7g==
X-Gm-Message-State: AJIora+fVYAyyUyB2fqmCnBhiUS2xF4wo2hhEBwt/JFD0Bn7+6pFi4dc
        8QJkiU8Xs1LTiAT0ezxD/Uvyz9DSmL/xVxeIQT3oJWmUoo905Q==
X-Google-Smtp-Source: AGRyM1vBdgqNHL5vBf8c3Ah5lOIsCjKaNWDP0+1MppP+NXTzeyzHyP0az8hbQfdAW2Dgnf2tLm+L2H2T+k/lJ/5at20=
X-Received: by 2002:a05:6602:15c6:b0:67a:33d1:6c73 with SMTP id
 f6-20020a05660215c600b0067a33d16c73mr11714880iow.156.1658076101229; Sun, 17
 Jul 2022 09:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
 <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com> <a03075167c1f4410a1b4f415313f11a7e1c3a594.1655621424.git.gitgitgadget@gmail.com>
In-Reply-To: <a03075167c1f4410a1b4f415313f11a7e1c3a594.1655621424.git.gitgitgadget@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 18 Jul 2022 00:41:30 +0800
Message-ID: <CAOLTT8TCmDfbbakfXhAoFfx+4Zwn0brcdL0_hEM=u-eSAfjzMQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] merge: ensure we can actually restore pre-merge state
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2022=E5=B9=
=B46=E6=9C=8819=E6=97=A5=E5=91=A8=E6=97=A5 14:50=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Elijah Newren <newren@gmail.com>
>
> Merge strategies can fail -- not just have conflicts, but give up and
> say that they are unable to handle the current type of merge.  However,
> they can also make changes to the index and working tree before giving
> up; merge-octopus does this, for example.  Currently, we do not expect
> the individual strategies to clean up after themselves, but instead
> expect builtin/merge.c to do so.  For it to be able to, it needs to save
> the state before trying the merge strategy so it can have something to
> restore to.  Therefore, remove the shortcut bypassing the save_state()
> call.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/merge.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 2dc56fab70b..aaee8f6a553 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1663,12 +1663,10 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
>          * tree in the index -- this means that the index must be in
>          * sync with the head commit.  The strategies are responsible
>          * to ensure this.
> +        *
> +        * Stash away the local changes so that we can try more than one.
>          */
> -       if (use_strategies_nr =3D=3D 1 ||
> -           /*
> -            * Stash away the local changes so that we can try more than =
one.
> -            */
> -           save_state(&stash))
> +       if (save_state(&stash))
>                 oidclr(&stash);
>
>         for (i =3D 0; !merge_was_ok && i < use_strategies_nr; i++) {
> --
> gitgitgadget
>

So now we will not make "stash" empty even if we are using
only one merge strategy (e.g. octopus), so we can reset to
the original state correctly.

Good.

ZheNing Hu
