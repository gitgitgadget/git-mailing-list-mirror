Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F91C61DA4
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 21:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjCEVeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 16:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCEVeO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 16:34:14 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A9A46B9
        for <git@vger.kernel.org>; Sun,  5 Mar 2023 13:34:13 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1755e639b65so9475576fac.3
        for <git@vger.kernel.org>; Sun, 05 Mar 2023 13:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678052052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMhKYx7HoB3GkYmZ6I6NSrRKAmLxs6IV+TcVADUsbEU=;
        b=d9O2stBRm6cC+JiFw2JkOu8gyodDVCRn1Lu4DVlgR5IDSXFQHzKCHAKZElFjabTVS4
         C474bt43vivZIDIhlBMEAHcL2tp6TkC8A6J7CMcwhFbznZJintvR/oktmmODKW921gUj
         XRFZ3SxRUIiDFTq+b4ZScog4DaZADb99snBHIUAh25whVuCVCIRXSgiA3BBQIJJ5P2o8
         euHjQVzQ3SMrUaAXJ/7FKuTW6LvY4iEeF7P/1gu+mHY72xE+TnPrSlDWzfgjdLe9ssuE
         qZa6nzcdaN2+FsIiAjKjBXaioMulwwLx30jRxOVSnbo1usvx7IPMp6xgEYzUOvZn1ddf
         Io7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678052052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMhKYx7HoB3GkYmZ6I6NSrRKAmLxs6IV+TcVADUsbEU=;
        b=r9uprRRBNtfExMyaVr5kg3h8E2/GnBZU0PPDX4R7F5UAVWecbl7TRpF3Shq327/Y4u
         stKoZMXY1Vn+69uAuXkzydg95KJslgQvD8hOnbfEkopgYhKNyOowpDGokD5PkTp+xTBG
         7fxt14fAgl84uTEM4ZqnPhXZjlufy9RofvgrEXYxT8AeJVETyjd7Q1JqLEJZSD1MlRHn
         Lt3kJ5zJBNe5oUrKOQPAOvWScyDb5F0z8ZAfSruexzkEFrDnuh7AeVlqyb3wdheG3+hr
         4sBfJYe/3hkzIgbUEmy4tXKxoQdQ3QZjrYe/KopC21RAJzHKlwJijeFBzjZwgtfT5pPE
         xb3A==
X-Gm-Message-State: AO0yUKWKnzhDzn98tKyyW+JfpJZDRug12NZ5bsF80y9qesZHRIrLHN8f
        HXomQY8thqrgn/h2Ocpu8q92gCotltLgCOcibUU=
X-Google-Smtp-Source: AK7set9qKYfVtLm9OGVVKGBLQiW3SE//Pj9JM6u81X9D1OzxV52ZzoZNiAmnaF0+BfWQupHgD+Ewd6otv6bY36+CArA=
X-Received: by 2002:a05:6870:cd04:b0:176:be86:b659 with SMTP id
 qk4-20020a056870cd0400b00176be86b659mr883539oab.5.1678052052519; Sun, 05 Mar
 2023 13:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com> <87ilff2xsl.fsf@osv.gnss.ru>
In-Reply-To: <87ilff2xsl.fsf@osv.gnss.ru>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 5 Mar 2023 14:33:36 -0700
Message-ID: <CAMMLpeSowxoJgPOt84Dos8BVKU=y=M+Ph0xaGe6UTxwwE5zsXQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] rebase: document, clean up, and introduce a config
 option for --rebase-merges
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, chooglen@google.com,
        calvinwan@google.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 5, 2023 at 5:22=E2=80=AFAM Sergey Organov <sorganov@gmail.com> =
wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> [...]
>
> > - Rephrase the warning about --rebase-merges=3D"" to recommend
> >   --rebase-merges without an argument instead, and clarify that that
> >   will do the same thing
>
> Not a strong objection to the series as they are, but, provided options
> with optional arguments are considered to be a bad practice in general
> (unless something had recently changed), I'd like to vote for adding:
>
>   --rebase-merges=3Don (=E2=89=A1 --reabase-merges=3D"")
>
> and for suggesting to use that one instead of --rebase-merges=3D"" rather
> than naked --rebase-merges.
>
> It'd be best to actually fix --rebase-merges to always have an argument,
> the more so as we have '-r' shortcut, but as this is unlikely to fly due
> to backward compatibility considerations, this way we would at least
> avoid promoting bad practices further.
>
> If accepted, please consider to introduce
>
>   --rebase-merges=3Doff (=E2=89=A1 --no-rebase-merges)
>
> as well for completeness.
>
> BTW, that's how we settled upon in the implementation of --diff-merges,
> so these two will then be mutually consistent.

I am curious as to why you say that flags with optional arguments are
considered bad practice. I don't see an advantage to adding
--rebase-merges=3Don and then telling users that they ought to always
type the extra three characters, even if we were designing the feature
from scratch. As it is, we're certainly not going to drop support for
--no-rebase-merges or --rebase-merges without an argument, so it seems
fine to advertise them to users. And if we do want to add support for
passing a boolean value as an argument to --rebase-merges, that can be
done after the rebase.rebaseMerges config option is added; it's not a
prerequisite.

-Alex
