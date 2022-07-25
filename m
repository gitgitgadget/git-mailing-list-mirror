Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E51C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 16:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiGYQAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 12:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiGYQAp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 12:00:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6314D12745
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 09:00:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mf4so21463491ejc.3
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2+tnPmcqw5ke2WgIpcwGIAvLFRklg4B0SkPJdqNNBsI=;
        b=XXYS1OBWtaCLk06PZTCdQ+9dWjaWMBVIWVoRYUcu7AL0mGjyPdIR7fNy+cttjds6iF
         DK9w7za2KvMMRISidp2bEwabzVnqUN8hEqwzCEwSDu8OfNckWD82E3GsrJdtOc5Dww5m
         V6md1sCajSbJR60JD5Fe/Uy37z6HwhiUr7SG+R+euM03IyPukDAB0dNtLQjsnJjanfuR
         IJhR0xjrkNCkOBWJDCdscgtsBAd/XKB/9bE7jaZQ1MHAzdn7b1400W3cWcJX0rr/kfN6
         IVjZV/ogJqaqUIdAT0Q2sPDe7bPvLApSene1Lb1wyOcvDNrBjFNigl1WixyrCQOIyCle
         +Yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2+tnPmcqw5ke2WgIpcwGIAvLFRklg4B0SkPJdqNNBsI=;
        b=0TaYd3bRyAUxAFCkkzVFJ2sYUeO3nLgMc4kTS+rMx6cAVZzbs4kZePxsrSN0d3kqug
         r1NKadr2k8bguLWLD6LfhwslTGvR3+72QwIc2NDqjUig4bY67rRvQ7i7HvWQdA9uG4VD
         YDWa4Ykpo69ZEoi1KPfdrcN+0nA+A5WI7Q75oY4sdKoRW/1AcIloxogoV6RMnSYltIWN
         xFidrkIEIu6UqR3+yBxVSSbDasNkPDcwf2EcPnxfQ0obDDsb27+JOKfEiGrhBRJ1MMec
         i0/5CV9Exio99J+z9rwcD7fT33b0S326rmmEn4uyiSiPU11pC1ydCt05wmzzcMkaXRjf
         AU4A==
X-Gm-Message-State: AJIora8WXzzEOBmZ/j58wsHxV+4dEeGp+Xs0zo/fp8TqoTCDhoQV4mET
        vkCP0rdKa0XdDPWCRueFMoBXTzrIAHA=
X-Google-Smtp-Source: AGRyM1tHsKZTn6hsrC/m8IFz3MXva7ols/axB43f4W6Qxf6HtZ01+oigolQXKle7JhAf8Am9iGm5pg==
X-Received: by 2002:a17:907:a06f:b0:72b:564c:465b with SMTP id ia15-20020a170907a06f00b0072b564c465bmr10625891ejc.344.1658764842844;
        Mon, 25 Jul 2022 09:00:42 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id p3-20020a17090653c300b006fee526ed72sm5386269ejo.217.2022.07.25.09.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 09:00:42 -0700 (PDT)
Date:   Mon, 25 Jul 2022 18:00:40 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 00/20] parse-options: handle subcommands
Message-ID: <20220725160040.GA2543@szeder.dev>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <16acb1ce-92eb-d7ec-d5a2-3ef08cda9b69@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16acb1ce-92eb-d7ec-d5a2-3ef08cda9b69@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 25, 2022 at 09:15:45AM -0400, Derrick Stolee wrote:
> I focused on reading the changes to the builtins I have experience with
> (commit-graph, maintenance, multi-pack-index, sparse-checkout, worktree)
> and found the adaptation to the new model very clean.
> 
> The one common thing I saw was that you are updating a function pointer
> that you name "fn" but it could be more informative on first reading if
> it was named something like "subcommand_fn".

I felt that redundant, because most lines mentioning that 'fn'
have something clearly subcommand-specific next to it, i.e. the type
'parse_opt_subcommand_fn' at its declaration, or the OPT_SUBCOMMAND
macro.

