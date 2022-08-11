Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90706C19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 17:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbiHKR60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 13:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKR6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 13:58:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AF8A220C
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 10:58:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y13so34746705ejp.13
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DE6DquMNJbXZeMCi82wdmiPsgCel0hMZKGdCjpS/78Q=;
        b=K7LwdJi4xje4NwfqUO4qrM4hl5kWe1O3prFvtvm1meo2IN1/+A++Mk74XnUGn3Wxqz
         HLk4n+w9puQiknr1JRZJ6b7DJ6nxrzRBnpkpVQnYZWOgXBtJV9J7o//LNtJFGUXEtnkK
         Q18zy6m8L8Qpux0joSc3Figum01tiEW1nD9vkABLAFHcrVrtO3Ni2OZimmYUKecLnSmo
         xsUmOxHD6ckg5sviKqob9PxzXix3bBicKKVkUGuDrnLDjfY7vISY1eHkBwBWOkdvVbtZ
         gpfSQCfbJBsl0K0krOFwENtxpvK3TtzwVfiBF4PGGHlL/Qw7bPH7l3itThiZTvfFc8lF
         +4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DE6DquMNJbXZeMCi82wdmiPsgCel0hMZKGdCjpS/78Q=;
        b=PdEA/KXhUrIqQg3kWLSjP3ytKv2np5sbM60hIVUE+6JMe5Dz6Vn8pz7tu5gSA+y2m0
         hg7ioaqDk/O1IMWn+od8YkAmyQbNLmz+Hr+mMxzUQQp0rpviRmAuTyGptZP28FQBxVcG
         lRh4oKBsC1qt50WJFVkn5ZfpDWD/6gxuAwP1VEOxs8UbYf3KLXZvc5R6Blc7AYpDX0xK
         kYIa6OoJN0OP9Kmcj/A+OIeYfWEtrM2q9zJWd2s+VI5qG2g0L38veSlpqtUddWaR5H1J
         4OmTQNxMDrkQlFYWntfLLFFgeWRTzRi7tV3sYR51r5AiEcONDTw25jI5QZliUAPfowS7
         6unA==
X-Gm-Message-State: ACgBeo1j3GuFmqLoccMPEeQCyUg59X954nc8fxCbH9jpfRRw855YUFME
        LkrQbo+iWRvqOnOYi7duYhzqcv1JFbS2QQ5qLUs=
X-Google-Smtp-Source: AA6agR4NKelPfcxf1vL+NWjlfORSsVOWkrjzNKRbIkq1VfwBlYlWRnmDF4ULN5BfrOGDu20qDYSEwOG5W3j4jodgdkI=
X-Received: by 2002:a17:906:c154:b0:733:197:a8c with SMTP id
 dp20-20020a170906c15400b0073301970a8cmr132275ejc.483.1660240703302; Thu, 11
 Aug 2022 10:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1317.git.1660067049965.gitgitgadget@gmail.com>
 <pull.1317.v2.git.1660233432.gitgitgadget@gmail.com> <7a071c9e6be68b58306582dbac5952a5b1bcbc6a.1660233432.git.gitgitgadget@gmail.com>
 <xmqqtu6ig1s5.fsf@gitster.g> <CAMxJVdEV=rSXtM-nagvtMPdArkvQgoNauaQb1sk0CL3sPSvKmw@mail.gmail.com>
 <xmqqpmh6fyzc.fsf@gitster.g>
In-Reply-To: <xmqqpmh6fyzc.fsf@gitster.g>
From:   Eric D <eric.decosta@gmail.com>
Date:   Thu, 11 Aug 2022 13:58:12 -0400
Message-ID: <CAMxJVdFgMXf1XM68W_j4XfAfNzxPNc9NbAUaemtg-teqgvJ5mw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fsmonitor.allowRemote now overrides default behavior
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Given that, in the end, the change is rather small and involves just
one file, having it be just one commit is fine. Perhaps my next lesson
to learn is to generate and send the patch sets myself, but that will
be for another time.

Thank you for all your patience, it makes a total noob like me feel welcome.

On Thu, Aug 11, 2022 at 1:53 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric D <eric.decosta@gmail.com> writes:
>
> > Well, needless to say I wasn't expecting GitGitGadget to do what it
> > did.I had squashed things down to just two commits and forced-pushed
> > the second commit thinking that just the relevant stuff from the
> > second commit would show up in the next patch. Obviously that didn't
> > happen. Sorry about that.
>
> Oh, sorry to hear that.  If your ideal "logical progression" needs
> two commits, then please do present the series that way.  What GGG
> sent out was apparently not that (i.e. the same one from v1 with
> full of fix-ups for it in 2/2).
>
