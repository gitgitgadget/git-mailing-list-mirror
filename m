Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4284C32793
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 11:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbiHXLem (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 07:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbiHXLel (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 07:34:41 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EFE8284F
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 04:34:37 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y3so6567727ejc.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 04:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5U8a1rZMStEgC/xmttkZDHOX599lR1jw5FFVw48kvwc=;
        b=P3L04wJZdm1yt9yYKagEDQbV63OYa1gEBN/PfZmoFqw0T1xJQRfhowe3vjrygTv458
         myHey3D1PpZSjuXVGt8MOFM2bcZCzT39j7wJf0//WUVM5hsyFORCsNF/odnZcrj5StDf
         lFX0GABo7MdUnDtPq7B6PE5e+mSZTcHaFu15Nn5REO05/nojtufUe2iWhM0T5mNHLZVL
         OQvOPDqnpKbP87tzmK7f36N97DpZGz3vjEdqW0M2WfjpPnS7lmZfSWqQcwn5ZLEg1KWE
         kRc6shGHMCyFWhlKFl/2u0VU8nTlVBqC5o9tPgp+OcPJo+9PctVhj0Huva+hdYagAJ0b
         SbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5U8a1rZMStEgC/xmttkZDHOX599lR1jw5FFVw48kvwc=;
        b=V6SxQX1AEMXd9LJaBSmP4KS7swSdCoejYN7nwf68AsGthkU5QkGmlNRypYMWPQLAjJ
         32arDh44fwOBXhi+Ht1ct5flRbXLNTSHfIhbMnUhx4nZ4fkvAbr7XpLLpBdkWFXn5XdK
         26N5agghGSg4E836FYzqamOicdTFhPl53voKDUBdSLcAFNcsK88tRzbKRpSn7EYVmYVb
         pr5O/gdJc1JYzem4uckTXWok5P7Q5fvN+b6hiQg3QfOVQowaGdx7wEtrJADXai2jWIAn
         i1BR+lmNeAserJ8lIm6qIIsxZptAnE7fVlkvU7TOfJsqvlUenI755+0YI6+ZZrFkzbls
         WT0w==
X-Gm-Message-State: ACgBeo3pRJJ+KUzVMVxc9o64hDxXkLybfX1890DXYqNaZmvuP4qTXXpF
        Mr1YQD0PwTh/Cm6L5FuSg5NjRZQEvEyBQ/knWec=
X-Google-Smtp-Source: AA6agR7TiplCfW8QY2j0G+nZot45QlLjdtn4tqTF2c7w6dpKNtbVuNGordGyoef/UJQDQw/xLNkAofL4ubIA0g11EBw=
X-Received: by 2002:a17:907:2da4:b0:731:2772:59d9 with SMTP id
 gt36-20020a1709072da400b00731277259d9mr2654480ejc.751.1661340876073; Wed, 24
 Aug 2022 04:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAA3Q-aYfn0om2tXjwH-9ayaX57Yj6xkKw1hpi2asthgHvWovsw@mail.gmail.com>
 <Yv3ZKcD0L0dSIavr@coredump.intra.peff.net> <xmqq35dtseht.fsf@gitster.g>
In-Reply-To: <xmqq35dtseht.fsf@gitster.g>
From:   Jinwook Jeong <vustthat@gmail.com>
Date:   Wed, 24 Aug 2022 20:34:19 +0900
Message-ID: <CAA3Q-aZmn+K2n3PnLixLfAmf78FkQqCneBkzyd+edXMXSoy2MA@mail.gmail.com>
Subject: Re: bugreport: "git config --global" fails if an invalid .git file present
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2022 at 3:16 PM Jeff King <peff@peff.net> wrote:

> I agree this isn't entirely friendly, but I think things are working as
> designed. Even though you're only asking to change global config, we do
> still speculatively check for a repository when running git-config at
> all, as various options could impact its behavior. So the backtrace
> looks like this:

I didn't know that a local repository could affect the result of "git
config --global".

Thank you for the detailed explanation!
