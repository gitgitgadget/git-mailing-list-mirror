Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3E2C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 21:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378985AbiFPVRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 17:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378629AbiFPVRs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 17:17:48 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAB5120A9
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 14:17:47 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 89so3985777qvc.0
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 14:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wcvaqJewYI+3/PEO8GSg/J1u9prGq4HCKGIRQedMVSY=;
        b=qI5hZ10gA6g8Eg55CtQ9tNf1PCgj1ci8wouMr5lqWetyCF5piHTwVri1O1fDctHFRu
         J971UDphvVRs6Y8/VAcl/+gNY5B5TakAvyzPHYwG8RZqHKAbb38qA0rqxhdcimLiIhCZ
         yknjor7EW2ygB+RbSppz2uZCh/MholQnynxHNh2ZdMGEoJ7hJBkbV+6qHuRRsiB4FCuK
         0gIxJBqooopSrUnEvq2oM6iZwE5N55vWicuVB6lHi7d19WvMCZhmtuvqhaicxDad0nfi
         n5OBty2IL41Yv0Rupk+0Zpl6eov+E1vy8YENiLg5xVof7vbBEqjOc0m6Sbtd0gY7gZQd
         WLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wcvaqJewYI+3/PEO8GSg/J1u9prGq4HCKGIRQedMVSY=;
        b=DvqlUUM5AaA9fs0ChMqwObzEd8TYdruwlqqPMZu3vkcweOy7dh7ZtG7NFGdmNJvspD
         Upvv1sTvDUmcG9iAhJshRYIyZ7C/3SSinCD6qs81WB5sc68uCdHxMn0smNRa2DFzQBuk
         3J710O0BxOaCTeS2bRQIS7Pk8aqIXBotqLCuVDEmM8Rm6ez70nwiB1moFPEYf9V5XwZ0
         DlEhNOt/DdXZi9A7bht0QU1kmtBawCOQJKDVC9qDidLXeEgA4I+h4m9vJSg8NJlkp7uK
         sPBoOhwuyJF0P4DLuPvGZbV1p+sXsvjQ3iNpluVMZuFyrg0y8RQBUfyYrqx491Y8Doce
         1U4A==
X-Gm-Message-State: AJIora9fXs6gLfxZSnGtoo/CeeeqypawztW+G1Yfm4Mt3luD8/dGGX/2
        DiXQGu5VK7p1vCnLy5Tbi2TxQg==
X-Google-Smtp-Source: AGRyM1trWjQ8zDkW0P0cb5VP/XDEFRrIwbGAEOtZpS3BFMeUEMv1KCOEPABnRth8aUBJX9aMN1DOXg==
X-Received: by 2002:a05:622a:353:b0:304:fdcd:b9b9 with SMTP id r19-20020a05622a035300b00304fdcdb9b9mr5801424qtw.276.1655414266304;
        Thu, 16 Jun 2022 14:17:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e15-20020ac85dcf000000b00304ec60f711sm2879670qtx.39.2022.06.16.14.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 14:17:45 -0700 (PDT)
Date:   Thu, 16 Jun 2022 17:17:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?a3lsZXpoYW8o6LW15p+v5a6HKQ==?= <kylezhao@tencent.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [Internet]Re: [PATCH v2] send-pack.c: add config push.useBitmaps
Message-ID: <Yqud+Y6LgkbmBOBj@nand.local>
References: <pull.1263.git.1655291320433.gitgitgadget@gmail.com>
 <pull.1263.v2.git.1655350617442.gitgitgadget@gmail.com>
 <220616.86fsk4ww69.gmgdl@evledraar.gmail.com>
 <be5afab25a5b44b3af797c0c8b75f5e6@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be5afab25a5b44b3af797c0c8b75f5e6@tencent.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 16, 2022 at 03:11:09PM +0000, kylezhao(赵柯宇) wrote:
> > At the time I didn't, because as noted in a follow-up I'd lost my test
> > case by the time I read that, but it seems you haven't, and have a
> > current test case.
>
> I tried to find a test case in open-source projects, and finally found one.
> $ git clone https://github.com/JetBrains/intellij-community.git --bare
> $ cd intellij-community.git
> $ git repack -adb
> $ GIT_TRACE=1 git push . master:test1

I wouldn't expect this to push any objects at all, since you're pushing
to a repository that already has all of the objects contained in
`master`.

A more representative test might be something like:

    $ git clone https://github.com/JetBrains/intellij-community.git --bare
    $ cd intellij-community.git
    $ git repack -adb
    $ git rev-parse HEAD >in
    $ time git pack-objects --revs --stdout <in >/dev/null
    # move the bitmap away so we don't use it
    $ mv objects/pack/pack-*.bitmap{,.bak}
    $ time git pack-objects --revs --stdout <in >/dev/null

Thanks,
Taylor
