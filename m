Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D4AC6FA69
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 17:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiH2RFP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 13:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiH2REv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 13:04:51 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA899C50B
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 10:04:26 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 69so6589460pgb.13
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=FoqvgOU1EcVmvYjTOyJ3Ua9W9chB6g60WxotoaRkZQo=;
        b=SbhfUV/WnKLJOJhMV3l10scGsJHK1Ps/sAjBcfbA5LJxmCwcziuuE+6kdGLsNbi4vk
         6aboamRvCz7ijChbuxf6RyBbqK03J5hfKaBuiMmQf5ad1U5h1HHW52JsfJXUm/U7TKeP
         r7s2kSf6rBBv+9BP/XcOwsDadMYpd3Ht3i10NwrOn5tZaOJTZwLos9saDIQFs6yHE5r5
         JhGviAJBh26kR3hWsIqmPlA0RT/Wj6s3R+F37u5Fx/lG0PbJjp+CgKh3QUIji3CGPWFy
         8ia6EfYMIBSzClVQtuW98Leq6fXrTsFTL/urrYFoKx21kU9kqfwcNYj/s6Hml2Q7gTGD
         JyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=FoqvgOU1EcVmvYjTOyJ3Ua9W9chB6g60WxotoaRkZQo=;
        b=ueaEFkwjxh12LsTz3etwg+MmwV5PgR6rBHz9Ro9jVyuDFyq4kVMxQb6q19k2jNbNMu
         INwCssqEOgX6nmufAIfOmINUqplxcFAJ14adihCvfKKrahjpOvUJZJhj9yISeo9ThKrx
         8Z9jjAMt0MZvD3q5gJbSaHupIZvEYnZoxr/FAg9zXme0P3bw4Z7FOIdzzmiioCunJRBL
         oY1IGGcF5xeCk/s3x4STbVd3327heqVRoq+rfQ6BIaMAiZZcITgpjWmNwKdxSDYeT31d
         5tpOIQNaVCb9rYNykJviesdCSHB0h4DQyykiTEsJoDPFh02GrWtqqa7LSY2o/N86vY3n
         BihA==
X-Gm-Message-State: ACgBeo3G9g7Yc3ra6ez5KRsXyLle8wTkMDcM5a0fRIBnh+4z56GMqz5G
        tCyw2QuFNV0+qjAaCtkMm97sAfKyhAo=
X-Google-Smtp-Source: AA6agR4FLgx+lc2JGk82rpRIOGrPKuSjGbP/D7cxX/a1rUa2taGXthOfU9rEFych8xl4CHlCDRKFPQ==
X-Received: by 2002:aa7:8c44:0:b0:535:ed0c:f401 with SMTP id e4-20020aa78c44000000b00535ed0cf401mr6796376pfd.48.1661792664970;
        Mon, 29 Aug 2022 10:04:24 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m62-20020a625841000000b005379c1368e4sm7682954pfb.179.2022.08.29.10.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:04:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v5 05/16] bisect--helper: make `terms` an explicit
 singleton
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <92b3b116ef8f879192d9deb94d68b73e29d5dcd6.1661604264.git.gitgitgadget@gmail.com>
        <xmqqk06svoxp.fsf@gitster.g>
        <662758rn-942n-1n3s-25r9-o7qn071s0567@tzk.qr>
Date:   Mon, 29 Aug 2022 10:04:24 -0700
In-Reply-To: <662758rn-942n-1n3s-25r9-o7qn071s0567@tzk.qr> (Johannes
        Schindelin's message of "Mon, 29 Aug 2022 14:13:48 +0200 (CEST)")
Message-ID: <xmqqy1v7ouav.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I have no strong preference, but I do not think that it particularly
>> contributes to "clarifying that we are using global state" to make
>> direct accesses to the variable everywhere.  I dunno.
>
> I do have a strong preference to avoid mixing and matching global
> variables with functions that pretend not to use said global variables, as
> it is too easy to forget to pass through the corresponding parameter to a
> function at a lower layer when that function accesses the global variable
> anyway.

When you have a truly well "libified" API and a program that needs
to use global to communicate to other parts of the system, then the
approach I suggested would follow a much better design taste.  For
example, if your program takes an argument --option=string, and you
for whatever reason have to use a global variable to store the value
due to limitation of your option parsing API, you'd create a global
variable to store the string.  But well libified API functions (say,
the ones from the C library) do not have to care if you are using a
global or an on-stack variable.  I would not rewrite strlen(const
char *) to my_strlen(void) that only looks at the global variable
and use it instead.

But it is quite possible that bisect--helper may not have such a
clean interface, in which case it is pefectly OK for everybody to
look at the global directly.  My comment was mostly a reaction based
on the assumption that your earlier "libifyable state" comment meant
that these call graphs are nicely libified and pass everything they
need through via parameters, in which case, the ultimate callers of
these helper functions that take "struct bisect_terms *", like
free_terms(), may have the parameter they pass down to the callchain
on their stack, and now have to pass a pointer to a global, without
the callchain that is "as libified as possible" having to know.



