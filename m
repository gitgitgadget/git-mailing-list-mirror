Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE944C76196
	for <git@archiver.kernel.org>; Sun,  2 Apr 2023 12:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDBM02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Apr 2023 08:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBM01 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2023 08:26:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1934F7D91
        for <git@vger.kernel.org>; Sun,  2 Apr 2023 05:26:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id ix20so25538966plb.3
        for <git@vger.kernel.org>; Sun, 02 Apr 2023 05:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680438385;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/3CdgPW6RCPU5pJtSBmpgBuXymIEpjJEEV4WEwwDnRw=;
        b=DhouBXcqgZGrgcK2DUp2779IjQzaCaHweEoEBlEcMvxo8KymuLInzT7YC/JnTLwBlJ
         o1zYgReX95gMGAKPZw1stlkcEfGixa0zv1l2J/B44ZISprh2z7qLNIYbCzzbt90Prp5N
         doHT+hfJsuZFx0cpQir+Iiuh9n0g7z7C1+zga6+xQ/N4upS2oh7ygmsXhorA10jehYK5
         sYqSCPtiUYHcmT/7rbHoIipRfR+7MTjOiCT/IMhwNqxeRTUaygDnXJhEOjwTa0H1Uf5B
         Y3u2ALQmNegIf84GRaS3ZaSO5F8KbbN+4ypz+KM1O0y4p2Gj36s6usU06dSStgt8YNnv
         phBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680438385;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3CdgPW6RCPU5pJtSBmpgBuXymIEpjJEEV4WEwwDnRw=;
        b=hJmUtPFApSYl/pWb3yBpPAWlh2cGx3pXbf3cQGZKRXYLZNrKw9b2uONCq9DSohpFNr
         c0ZBBDiErmvnv71D4wirAZqXvZq3IMuiVL2AckN7OGubu4pHhlXIPaS/GpVbwSUn9cSF
         CVlR/pUufzTDt6utoSodQ6+VEQgk3NUyRlGDoLtTvtHup4robs8yabuvFGkWtit7npzK
         EfXfqtBTDwhM02RHt39/3c1J8Eia77QeHUbFkXauJ6VKYizyEYJ8Efw8M2u0riq+rpw1
         JqiGiEoIWUs5YH3U5E4kKzRZRBfjpesEraP/hl3JqxUVTih2JRPV3GZ/PH3QeZcwTYRk
         MnHQ==
X-Gm-Message-State: AAQBX9cNo+mA1ZxhMOMtybkpUslpW4XZRXki2W6QONpZaYfdF+r14FU5
        Ba0dxOJGF+CJPgjGZ9NIwmLspV4svUk=
X-Google-Smtp-Source: AKy350aeWcMZTg0lpmdPoXkS/xo5Vdv8YhoRLY3P9PF3FU8pc44KjDnkPRkj+d7He9SjZQE3Je7I6A==
X-Received: by 2002:a17:90a:18e:b0:237:24eb:99d8 with SMTP id 14-20020a17090a018e00b0023724eb99d8mr36462544pjc.19.1680438385283;
        Sun, 02 Apr 2023 05:26:25 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id t16-20020a17090aba9000b00240d78b39c2sm4459153pjr.0.2023.04.02.05.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 05:26:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     ryicoh <ryicoh@gmail.com>
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com
Subject: Re: [PATCH] doc: add that '-' is the same as '@{-1}'
References: <xmqqlejchpct.fsf@gitster.g>
        <20230401155342.21230-1-ryicoh@gmail.com>
Date:   Sun, 02 Apr 2023 05:26:24 -0700
Message-ID: <xmqqsfdia2rz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ryicoh <ryicoh@gmail.com> writes:

>> for now we should
>> update its documentation to mention "- can also be used in place of
>> @{-1}".
>
> Finally, How should I update the documentation? How about following changes?
>
> - You may also specify `-` which is synonymous to `@{-1}`.
> + Only some commands (checkout, switch, etc,), you may also specify `-` which is synonymous to `@{-1}`.

I would not do the above, if I were following the "_for now_ we
should".  I'd instead go to Documentation/git-foo.txt and imitate
how git-checkout.txt next door describes @{-<N>} and mentions its
special casing of '-'.

When a user is learning the subcommand 'foo' with a feature that is
commonly used in the context of 'foo' and takes a branch (e.g.
"checkout" takes "which branch to check out"), they want to find how
the branch is spelled (e.g. "you can give a branch name, @{-<N>}, ah
by the way "-" is @{-1}") in the documentation for 'foo' where the
feature related to a branch is described.  It would make the feature
a lot harder to discover to bury a list of names of only a handful
subcommands that share the same feature, while saying the feature
would not generally be available, in another section whose primary
purpose is to explain how to name an arbitrary revision, not a name
of a branch, no?
