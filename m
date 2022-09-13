Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED50C6FA82
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 00:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiIMAV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 20:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIMAV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 20:21:28 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E00446DA9
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 17:21:28 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 78so9753127pgb.13
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 17:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=xxOhVZqm4n21CB2u6z8kZI8mpeLdvv2dPzNbegQoNE0=;
        b=Bqt4A2u1cc5IXq3nhSCguJxeYAGoVLwYiCtz1BINzcMboZ2oPLpv47xABq1wmspZZL
         WEZ3mCl07dkXnPMN3LSjLQ9d8y0QrBneIhyCRTfzSVBT1un5YgOzxi49S9AaZpykmeTG
         l9BfAaQ4c+iHPuNeZT6QQsBcJ7VE0ubrvw8uap4KGDEiJ33+EZBon6Q28rcfoi6xAv/d
         akTHW0aI0yM54ju/jtSnQbOIn4gg4lo41jvkceaAcva+kgoRHo67la8EApR+3FWBr7Hh
         wpRZQ64WzZbTHHJ4+BEibMXnVLRRaMpDo3c38IJFS/55znRP+zizxcWRd8LlzEEjNMB1
         ehOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=xxOhVZqm4n21CB2u6z8kZI8mpeLdvv2dPzNbegQoNE0=;
        b=pfVFZjnRUnQDu7gkBpbv236n6MYnuGv5gC02MR54GKviohgV3a5zFMD92S3bWEJwqI
         WYzMqbvnAjunbkye261RZJFL4ERMAqLaYAju7pJLRroOrKy4NC+Sm+2oqDGa7Wt0F4D7
         H/0LbK5bDUGT5EJ0FNfKihC2V+3zu1sIjWdNlV2O+nzCC7U3sfYjGu0xJL1f9uQt6ghW
         c9gnxD0337lP3RW6oU1tlECrB/FdRyZrvYbRK1JxkV8Srq8pnGkn6KdaKbSwVyoKeQRy
         1DfBW89AxtPtrLc/6Mr9F07RgEC1YCfwKeqmTNLgMjtZ37RVRU+DCOuSSaVzQsXEc66m
         tIow==
X-Gm-Message-State: ACgBeo0UoGcMBVSfaArIuZ4oD6skW+y2td7X0vIckwK64TWtH56N1v1P
        AaC8ElY9V0N06dxMM1gYBNw=
X-Google-Smtp-Source: AA6agR7FoKE5vBCrmli93/CBy36djG56BoZNdc/ZT0p/1Uo7NvAEqUUbWf4ioRDlhvNKEMMwUxls4A==
X-Received: by 2002:a05:6a00:1704:b0:53b:b450:a51d with SMTP id h4-20020a056a00170400b0053bb450a51dmr30191053pfc.79.1663028487340;
        Mon, 12 Sep 2022 17:21:27 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a348900b00200aff02e90sm5879039pjb.18.2022.09.12.17.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 17:21:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] chainlint: colorize problem annotations and test
 delimiters
References: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
        <xmqqsfkwb12i.fsf@gitster.g>
        <CAPig+cTq3j5M7cz3T14h9U6e+H5PAu8JJ_Svq87W3WviwS6_qA@mail.gmail.com>
Date:   Mon, 12 Sep 2022 17:21:26 -0700
In-Reply-To: <CAPig+cTq3j5M7cz3T14h9U6e+H5PAu8JJ_Svq87W3WviwS6_qA@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 12 Sep 2022 20:14:27 -0400")
Message-ID: <xmqqo7vkazuh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> (2) In practice, I found that even after coloring those annotations in
> red, it was still easy for the eye to glide right over them in the
> output without really noticing them. Switching it to bold red helped a
> bit, but my eye still glided over them sometimes. One possible reason
> that the eye was able to glide over them may be because the "?!FOO?!"
> annotations are very short bits of text buried in the much larger and
> textually noisy test body.

Maybe partly because I work with black-ink-on-white-paper terminal
setting, and maybe partly because my color perception is suboptimal,
I learned to use "[diff.color] old = red reverse", because non-bold
red letters do not stand out enough.  Perhaps you may want to try
reverse output to see how well it makes them stand out for you.

I do not think if configurability like "git diff" has is necessary;
it would be overkill.  I personally do not mind more noise "?!"
around the keyword, especially since these are only shown when there
are problems detected.
