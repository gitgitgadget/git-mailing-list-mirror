Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1519C433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 16:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1E122AAC
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 16:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbhAYQzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 11:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbhAYQyt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 11:54:49 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775E4C06174A
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 08:54:08 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id f11so16098077ljm.8
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 08:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gy75O1kHZmL4sxPvDF1iP+kbghF6mvB15aRup3G4NcE=;
        b=WDmL/TOU/4C7pQnb7p38wHI6iYvW21bNCRLiVurA5ZgPVMA96Dr4+STMC4C+o7of6Z
         0zeZi/nntb2pMj9L9KPeM+e1rxBmxmGFRYhKrY+ndE4qZ6BGV2Wdi4XzomND8bhnu4Y7
         /vWdjcSSaJV6SYm62YkfCRf2Jr93BeV1DlaXxWdjYF6/kWJevJ4J8/UrtTOx7kkxwpRL
         Oid7cFSd38XjBoapTg8MLu7UE2ZmBHV66/3wF/VP1SuGIi+854MVf6bVLa+WLmOD3BYU
         T5mSj9D3g/SInXFFc73BEe1waZEXOFXFwaPxQG/ORw/omr0H7Xl8WIMaHVws0Hi87Rk4
         6lkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gy75O1kHZmL4sxPvDF1iP+kbghF6mvB15aRup3G4NcE=;
        b=JRO9/cJ4H5Os+7laRlivkMMbjtOIIdk6uuMoYdIBy1Cbc7ELEgnhjpMcvMyIozKx+6
         dIJ33eM9GdlDDcj96o3ukKzpnilEnYoT8KmNAksrCYf10WfCYt3kfRoZqC6RjiTCEmWb
         E1vvg8s2jDsemzFnPUVZfjTHJB9e1bKEgrp2MKLZaPluZAZ3d0eQAMvoG5jVifi4Y2VA
         G1B30oCZLjOrMsvhpTGj+UZbAOMxI2xkiwRM2PQQj1ugHZSue4js2rFYGTHx2WKgaVy9
         NYc/SqNMff+/feoiSaJchU0C3cn7T8AaigSXjSojvBQ8sZV5XLDy5PvU2md5whSWHE9n
         EQpw==
X-Gm-Message-State: AOAM530WA/JFpxkzX+cxW94AKzHZn/Lor9oPy4MZzItFSkdMP07X0W/W
        36Sl3bmTfT6i8SxBc0kJTnhliRvUcdCrjbCCMbDUf5bRuzUkzQ==
X-Google-Smtp-Source: ABdhPJwOrI+2yDf7HwwiWLylyVJPQA20g3zagHaRFc0ix6dA3Cu+PNeAOpyAAraW36lFHOG7gQPRlzma4JHOClGrNME=
X-Received: by 2002:a2e:990c:: with SMTP id v12mr645914lji.8.1611593646241;
 Mon, 25 Jan 2021 08:54:06 -0800 (PST)
MIME-Version: 1.0
References: <1327609829.20210125123816@yandex.ru>
In-Reply-To: <1327609829.20210125123816@yandex.ru>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 25 Jan 2021 13:53:55 -0300
Message-ID: <CAHd-oW6=CFNGyW30pDhjwgwMcDFeqFoad=J6DkHruaeA75SzCw@mail.gmail.com>
Subject: Re: Can not rebase to first commit
To:     Eugen Konkov <kes-kes@yandex.ru>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Eugen

On Mon, Jan 25, 2021 at 7:50 AM Eugen Konkov <kes-kes@yandex.ru> wrote:
>
> I can not rebase to first commit.
>
> This is how to reproduce:
>
> kes@work ~/work/projects/general/Auth $ git tree
> * 67857d5 (HEAD -> dev) asdf
> * 1e99034 (local/dev) Initial commit
> kes@work ~/work/projects/general/Auth $ git rebase -i --autostash --rebase-merges 1e99034^
> fatal: invalid upstream '1e99034^'

'1e99034^' means "the first parent of 1e99034". However, this is the
root commit of your branch, so it has no parent. That's why rebase
complained about  '1e99034^' being invalid. To rebase this commit you
can instead use the --root option.

Thanks,
Matheus
