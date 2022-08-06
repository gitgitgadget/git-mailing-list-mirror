Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E81C19F2D
	for <git@archiver.kernel.org>; Sat,  6 Aug 2022 17:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiHFRxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 13:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiHFRxh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 13:53:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9122C11C19
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 10:53:36 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e13so6835700edj.12
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=hLSxKW1Iv6twYUOY9PLNkdzUk9qaqDKhpGQkrLNMGl4=;
        b=JnnfxvrLKHTfmiF2l26opYueBqpe4xX9t/ahtmtnb+VvwexxX71tpsqhfC8yNMQQnI
         kHM+7aDp0cOTyOkJe22f1YZ+UZ1Wo3Ko4pxocPrO6x98kElj5DkYMtAEYXbuNU2yewVg
         B0ipoky13k7IHMB2IUQVcQlauTPdJHbYJgbzCfESvZPhFUJW/qjZS60fP558/MSCCFFH
         g1fqfXYMGZqaF5N4M6AewiKMlULWkCUgWqWppsTYZdULzdYOoAynZ1JZ5qCC79qvDuSR
         SIBmLw3Cx77C8+F1Zg2PAsI0cGTRuRP6kjQPYD9FiP5P8fFZg6iV7b7sZ+ZQQPGIRlJA
         n/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hLSxKW1Iv6twYUOY9PLNkdzUk9qaqDKhpGQkrLNMGl4=;
        b=XHvznCl8aWZIbLDJ6ZcHidKdiuuE8NA9Fi/jLkmBT3ZvMGQF/eNNvLuwxP3UrCmWc6
         hwJSPIj4G5IvOa/C6wZg0V69K6D4HjMdDmYQG03SAetSpfy3dvll4Az+5KbVdepKDybj
         DasCjC0fr0gQeGRK+1ZBstjvk3saWoKXOrtWxRQ2thqf6jQzgGDZ+lBe3LE8gBnXkj0E
         Iujp8UNH6obXQqmZnkQ9iI2+4IEaZzFoTliWISta4FGO1P8oL7fmW56g6QGsmnZdeL2B
         EUAd8rAjLUi2tZ+01D0DvokSPIZa3BkzthdUNYMRPDfHrRqYWwmgs/5axKA1Pvm1yD4x
         EmsQ==
X-Gm-Message-State: ACgBeo3tN/znkUXYxWYxl4ZUxmAp3yP2HZH6958V6EHmP6wt4fpNJZpL
        LKAxLdxwR9Acjjq+Tn+Y/L5ii+bwd+D+WQ6Tpv/v9gEU
X-Google-Smtp-Source: AA6agR5lQBUf/85nCnEECF29Zw/WaonmtgzQXEfJEVf29dNCDi+KguFkNK6ZI1xqV3l1X1O6VSnayGl91+zadBSLGSw=
X-Received: by 2002:a05:6402:2792:b0:43f:6873:7497 with SMTP id
 b18-20020a056402279200b0043f68737497mr8901297ede.175.1659808415134; Sat, 06
 Aug 2022 10:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220802214134.681300-1-felipe.contreras@gmail.com> <Yu6V4cIajhoMhB3t@zacax395.localdomain>
In-Reply-To: <Yu6V4cIajhoMhB3t@zacax395.localdomain>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 6 Aug 2022 12:53:24 -0500
Message-ID: <CAMP44s1uPFGYVJ7dzf1pFXENnUjTTwxHye2iT_HPNiMcmPjD9A@mail.gmail.com>
Subject: Re: [PATCH 0/2] mergetools: vimdiff3: fix regression
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Sat, Aug 6, 2022 at 11:25 AM Fernando Ramos <greenfoo@u92.eu> wrote:
> On 22/08/02 04:41PM, Felipe Contreras wrote:

> > I wrote vimdiff3 to leverage both the power of git's diff3 and vim's
> > diff mode, but commit 0041797449 broke that.

> By default this option is *not* set, which means buffers are discarded when
> hidden (and that's why diff colors dissapear). By setting this option colors are
> back even with '-u NONE':
>
>     vim -u NONE -c "echo | set hidden | 4b | bufdo diffthis" -c "tabfirst" LOCAL BASE REMOTE MERGED
>                            ^^^^^^^^^^

Correct.

> Regarding (2) we can remove the "Press ENTER" message by adding "silent" to both
> "4b" and "bufdo", like this:
>
>     vim -u NONE -c "echo | set hidden | silent 4b | silent bufdo diffthis" -c "tabfirst" LOCAL BASE REMOTE MERGED
>                                         ^^^^^^      ^^^^^^

Correct.

> So... by making two changes to the current implementation (adding "set hidden"
> and "silent") we can make it work. The nice thing is that, this way, "vimdiff3"
> does not need to be treated as an exception and thus it will be (hopefully)
> easier to maintain.
>
> What do you think? :)

This could work. The result is not quite the same as with vimdiff, but
the difference is minimal.

Two observations though.

1. The "silent 4b" is ignored, since bufdo makes the last buffer the
current buffer, so if you want a different buffer you have to make the
switch *after* bufdo.

2. You probably want to do "set hidden" on all the modes.

I don't see the need for all this complexity for this simple mode, but
anything that actually works is fine by me.

Cheers.

-- 
Felipe Contreras
