Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7219ECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 16:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIIQTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 12:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiIIQTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 12:19:16 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADD812D1A3
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 09:19:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so2070252pjh.3
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 09:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=RiTG30qWltxicOlRnplcXnAAoxsa/0uoVrTe57SOFBA=;
        b=cXWwPOAMSQkyallLg8G416zG61Vt5F2dhiWkd1NPlXLJURpxzp93OcGizdREuXhvsn
         1B9d2rhG5si8/2t+7A+L/EmoOjFXqWMjOmdo+2Jraa/JEQ8s8qr2bee9xLfRKG+t5Q7Y
         WtanQcC15MG/A1m904wVTGUUSFXSC4Q2YwzcYYUrd3Bai0vsZ5T85li/BzNLqT/nJQ0f
         RvRwy1peH/TLEp1tQS3eLJiji9gljsAdq94cSFV90ujGxTodvYlEVc6jQGwamVJSIb4t
         LOuaMA+mokGw161lQ0SiwX7DOC0tYm2xZgsxfdMUEUn0JVCDHm0icc6x1jWjg2K9zXa1
         M4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=RiTG30qWltxicOlRnplcXnAAoxsa/0uoVrTe57SOFBA=;
        b=UISZyXNnYpuSDv/acTv1wtZWFd4sm84Xs6iiBL+RLUrFEykxJN8F0SVKe7OIUuxluJ
         7PxFCEXF7pVu6CasWbNIgcEFnctTv4LSu0dB4xHk80uJwUSdx0VEzr+mG/ojBntmzGkZ
         su8Y1Xz79VuTvhEStgkgripSOIOWxVz0+cpPDzcuMpS7z2RnxHnJRBDMDXUUa4l0ywT9
         xsRM+haL65uT82FXC5lisUU30DUbscTANXmYPITo9Mm5zve7eo1A+Q2VM6lQq34Cu9+6
         fIFz8cIFYO4LWJHwqrUmnlYZR1wDlDzHaOfOp8SZlgLGWoMak2gPgfg9Kh6Wa1Ec7Djq
         fBFg==
X-Gm-Message-State: ACgBeo1Xi6xg8l7PnQ0cpyp8N2mEzmbLNdShIo1Xvc8xVJFrBRAe1bBy
        wtK9GZE6ZNEchDOXGxTl5G650sZ6/Fs=
X-Google-Smtp-Source: AA6agR48t4ui95arrauXv7HUPtFPqql8/k2XIkdH+Cv0g+eP7PmSWMTP7qaDrwUQFP5hz7XyYHa3lw==
X-Received: by 2002:a17:90b:3ec3:b0:1fa:a293:c511 with SMTP id rm3-20020a17090b3ec300b001faa293c511mr10559632pjb.156.1662740355512;
        Fri, 09 Sep 2022 09:19:15 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b0017541ecdcfesm643857pln.229.2022.09.09.09.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 09:19:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Glen Choo <chooglen@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 07/11] log: add default decoration filter
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
        <c249bface2a6dcd0355620f92579b42a6fa4ea58.1659722324.git.gitgitgadget@gmail.com>
        <kl6lr10l8t7y.fsf@chooglen-macbookpro.roam.corp.google.com>
        <42db9da3-3f69-1bf0-6d88-692e18eb74c1@github.com>
Date:   Fri, 09 Sep 2022 09:19:14 -0700
In-Reply-To: <42db9da3-3f69-1bf0-6d88-692e18eb74c1@github.com> (Derrick
        Stolee's message of "Fri, 9 Sep 2022 08:23:28 -0400")
Message-ID: <xmqqbkromsfx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> It was an intentional omission because the refs/bisect/* references
> are not part of the color.decorate.<slot> category.
>
> Looking into it further, the bisect refs look pretty ugly (especially
> the ones like "refs/bisect/good-<hash>").
>
> If you would like to include these in the default filter, then I
> would recommend also adding a color.decorate.<slot> category for them
> and possibly replace the "refs/bisect" with just "bisect". Alternatively,
> you could take a hint from replace objects and just use an indicator
> like "bisect good" or "bisect bad" instead of listing the full ref name.

I personally do not think bisect/bad and bisect/good-* need to be
part of the default set of refs to use for decoration.

I suspect that the suggestion to use them for decoration is based on
the gut feeling: "People during their bisect session would want to
know which points they already examined and what their states are."

But during bisection, there is a specific command to give them
exactly that information: "bisect visualize".  It is roughly
equilvalent to:

    git log refs/bisect/bad \
	$(git for-each-ref --format='^%(refname)' refs/bisect/good-\*

i.e. show the history surrounded by all the known-to-be-good commits
and the known-to-be-bad commit we currently are chasing.  Bad and good
commits are at the boundary you can tell them without decoration.

But if we still want to see bisect/bad and bisect/good-* in a larger
graph (i.e. showing descendants of bad and ancestors of good), then
I do not think good-<object name> being a long label is something we
should special case and shorten.  Especially because the user is not
using "bisect visualize", which is readable without decoration, they
may be seeking more information in the names, perhaps cutting and
pasting the object names to feed "git show" running on a separate
terminal, or something.
