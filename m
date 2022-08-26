Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368D6ECAAA6
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 17:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344452AbiHZRLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 13:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbiHZRLP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 13:11:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68FB97D50
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 10:11:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p9-20020a17090a2d8900b001fb86ec43aaso2445565pjd.0
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 10:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=syoxYZBcyIKPUHnPzPBBHJUDcZn1BJ5XqA/T/3BamGc=;
        b=Zt2HZOy24NrbDfqlKvh8BS+I0am6qsEntIjl/J7gWzDNlzUz92/fZlUy00QpQjbxgd
         ZZajJaSNeDfzguD0SkLNNoWA5W2mxT9CockkcQzxvZsv3DQBLyuFgWU8xYkrRr9P1mPZ
         wfzYm74tdjmUtYNCajpNylu34QAxzNOHABurhoQaOcW3mziBifkEa5NNFGrvFAuYfomJ
         ABrEsR0r365g6WCQbVTaR0MyNq204aSWufCgBLjthLwVCjzhG2Dd5M5g+DJDGVDv2O/5
         PMPal9GSuQKytQsT/ycxo04XGYqqhuIrS5NRVRZEI7E4DAxOYaRPhVF+kbFfbeDgE0VA
         MSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=syoxYZBcyIKPUHnPzPBBHJUDcZn1BJ5XqA/T/3BamGc=;
        b=yNxIUehspkWmFcgHPaRPvr1lDtS08xgT/BeM797WV8qTi9rkQ+z4LoD6IChlaGXSYS
         hMDChad/SUQWjOrqHKKJKg862y9CzKYXGXITR1O9/TjIRo3Cmid5X4TUmNPUve8/aV0N
         F0WMYKdKqW25v8IosGI6w2cjCzWLrMTulH3vpdDoE/V/dljHRpwDpQTBl0w1p++W6XVI
         VYX3cGROC9uskDjgdmXbmWj5barYCeZyZpAvt4ZQVmoZu3xw1rADyVlZKFJYNQzbsWGF
         OE8qaYDDw6wosVT7I6wZ7sEPmRLAGcAYRohg5+OZmqeoyrey0iiP8UksgliNPOHF1gd5
         2zVg==
X-Gm-Message-State: ACgBeo3gFRjxISR7coOYoImEV9XA6EtV0QG28Epc8MKIh5Afg5FHFPSt
        7YIlqlhAsk2vvxb+9zpDFNk=
X-Google-Smtp-Source: AA6agR4cgIh/kRYvkAwAPs1vDO0qettEJrYsurbAcDBrhSPoekMnb/oOXDe4qVjPuMTJdbrTbjTj9w==
X-Received: by 2002:a17:90b:1e4a:b0:1f7:3769:ac18 with SMTP id pi10-20020a17090b1e4a00b001f73769ac18mr5253088pjb.228.1661533874149;
        Fri, 26 Aug 2022 10:11:14 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902cec500b0016d231e366fsm1864787plg.59.2022.08.26.10.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 10:11:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: forcing an in-body From header
References: <c403e526-7455-4f26-fcef-97c99f9af539@rasmusvillemoes.dk>
Date:   Fri, 26 Aug 2022 10:11:13 -0700
In-Reply-To: <c403e526-7455-4f26-fcef-97c99f9af539@rasmusvillemoes.dk> (Rasmus
        Villemoes's message of "Fri, 26 Aug 2022 15:17:34 +0200")
Message-ID: <xmqqtu5zx74e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

> I looked into the code, and while this is obviously just a hacky patch
> to see that I found the right spot, it doesn't seem to be too hard to
> implement properly.

I agree with you on all points in the above sentence ;-) I do not
think anybody minds if a command line option to "git format-patch"
added in builtin/log.c::cmd_format_patch() and a new configuration
variable taught to builtin/log.c::git_format_config() that gives
the default value for the new "force_in_body_from" member that will
be added to "struct rev_info" and relayed to "pretty_print_context"
when log-tree.c::fmt_output_commit() calls format_commit_messages().

Or something like that.
