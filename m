Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D97C05027
	for <git@archiver.kernel.org>; Sun, 29 Jan 2023 17:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbjA2RPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Jan 2023 12:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjA2RPE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2023 12:15:04 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AD51C316
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 09:15:03 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 78so6147162pgb.8
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imuKMuJg+eCioZrhGW26K0kZgR3nTY83/8MQj3UM/AM=;
        b=OZif21oGZVrYb1XE7jv89lqlMsGVEWbk9W0QKG84fM4qhUh7Q8/AN1Lo2r5ixW41ZL
         FoTfR7aDu36N/dxCjUevFiDVl2L6gHqIlFx1+K6Z5xJwZn1uWiD2GE+bDsPx+wAMuBzK
         PBccvMCOPJnBTx5CjvKhQlZ8BSdAb3Vba7VeIq7yLw4usrnbuggW0YhcoJYAG+dA3VQi
         ummLpVnHPRxaZLtaVjJeXYK2HNCdHGVwho7LYJGUxjZ9bS9jAmgJ0yf8P9f5sMjbWa0W
         O03Ae7P5IrJeZCQYd/hwK0ZHRnDAFyjmkv9D5HZrcoRVh/mNp1/ztt2o6jMjgJGNLnok
         0weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=imuKMuJg+eCioZrhGW26K0kZgR3nTY83/8MQj3UM/AM=;
        b=ZvNxu7BD+ziNeFqxQuTwIphoWSfinRyC1IPJffkLNbEzzOsq/3BTAZhlSvU/HKytOv
         ZbxLhGJU556Xj9sQewTQF7C4OnIz17fhTzboqu/8sCaP1c5qiN1TwtHA8Iixya7enVgO
         1gAdlj5byFJjt4m/2+cVLCoFLetcAeNljSFwiNSiM8Z1hAluBi1RJQyraTPA3LvS9gTm
         E93FsjmVVKr0pFbg/bgFyMWgLNr5q3/PaOuMkN7UQwyJrFd8J+jBBZyaNeksCCcaT9eu
         CAHCXXguhvSqQmErqdg2j5pmiTw61IYLY37KSOe+uIYFsLTDEhEmXTasrf8aOZWf/kR9
         GcZQ==
X-Gm-Message-State: AO0yUKXEfQH+RFhkx0MpFfCFGRupoRXuDiCss0gorlRnxGrzPqj9Z8ds
        /TSUy4stF09qOBIhcFE1PxGFvC6zsXM=
X-Google-Smtp-Source: AK7set/+f/Gaxov/U2YOhU2LWUbjlz3q7Zvz8X6cXgafYnLP6hiY0T55mSit1LPANdo5w1Gw8GSmHw==
X-Received: by 2002:aa7:8493:0:b0:593:b538:760a with SMTP id u19-20020aa78493000000b00593b538760amr1647839pfn.5.1675012502972;
        Sun, 29 Jan 2023 09:15:02 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id x73-20020a62864c000000b0058772c6b228sm5861053pfd.116.2023.01.29.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 09:15:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
References: <20221216121557.30714-1-minipli@grsecurity.net>
        <20230127154952.485913-1-minipli@grsecurity.net>
        <xmqqbkmk9bsn.fsf@gitster.g> <xmqq1qnfancf.fsf@gitster.g>
        <adb5a43a-5081-4f60-d1ea-2a6511f858c0@grsecurity.net>
Date:   Sun, 29 Jan 2023 09:15:02 -0800
In-Reply-To: <adb5a43a-5081-4f60-d1ea-2a6511f858c0@grsecurity.net> (Mathias
        Krause's message of "Sun, 29 Jan 2023 14:36:35 +0100")
Message-ID: <xmqqk0156z55.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Krause <minipli@grsecurity.net> writes:

> ... While we might be able to compile the pattern and run it in
> interpreter mode, it'll likely have a *much* higher runtime.
> ...
> So this grep run eat up ~9.5 *hours* of CPU time. Do we really want to
> fall back to something like this for the pathological cases? ...Yeah, I
> don't think so either.

You may not, but I do not agree with you at all.  The code should
not outsmart the user in such a case.

Even if the pattern the user came up with is impossible to grok for
a working JIT compiler, and it might be hard to grok for the
interpreter, what is the next step you recommend the user if you
refuse to fall back on the interprete?  "Rewrite it to please the
JIT compiler"?

If that is the best pattern the user can produce to solve the
problem at hand, being able to give the user an answer in 9 hours is
much better than not being able to give anything at all.  

Maybe after waiting for 5 minutes, the user gets bored and ^C, or
without killing it, open another terminal and try a different
patern, and in 9 hours, perhaps comes up with an equivalent (or
different but close enough) pattern that happens to run much faster,
at which time the user may kill the original one.  In any of these
cases, by refusing to run, the code is not doing any service to the
user.
