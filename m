Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156ADC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 12:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348459AbiCKMCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 07:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348499AbiCKMCu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 07:02:50 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37641AA06A
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 04:01:46 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id p15so18618208ejc.7
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 04:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hZ7Qd3/DpqQtb1Qd34VB84Yw7Ior+HUx0V3r901PL2o=;
        b=oJ5g4qDWH/ObTKpD6nsBsN0PRVkK+ogvPXZ61FiefQeD7+BvBIfYlyMHyXrWM+Wgtd
         UE1QhHdtXkyMO5F6ebXpQm1QGHiCEI3Bwo4iHax/PnF5dUGkZwAvQUa0/RtMEueZ7PVD
         heogvs3QKIFd9rBLI6ld6xblNs4EsQk20YJx5ofk22tqg3RGhVxQ1/tf1UOrmIhakZGY
         hYY1/38ojFnNfbUTrNeiAqfx/UY4ayNPuPN6N0zcn2DVSdAMovSqOyMnEQirETseciJ/
         5k/kYRLRVmjzGtdxoThwDEodQSVHeT+pWZP00g6umwiqHsWpiNywIsxqi2vaG2q4HgDY
         w8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hZ7Qd3/DpqQtb1Qd34VB84Yw7Ior+HUx0V3r901PL2o=;
        b=W2aOR3j59/+ooCjcev1BEYxjZIOngbG78wkzE5gvaBIszm6gBdDQ2cnyLHnBJKZdX2
         q2kbqLHGr+SIYPouwmezOmVkksm+xPYcOe9F9wrQBfWz1powwy3k6SfZvL+TrSgkKlgg
         LnfsZUxFbEi6kpk1mlz83v8FonDGWFRzGmj+LjcciHlyGL0U9SHY69E5cWnqLokirMtZ
         skeza/xy+04CXXc3Gk4Zwa39hwpn8NbhHdZC6UgzVBpJrxxKVX2qNlaJTScpEQf0Fg53
         jae54Qu+PzbOzqCIWw/4ZhlSGPmX5LSW9wf3obQDOWlNIfsKQLg7fyPcujuqJRU6+Z/w
         mVUw==
X-Gm-Message-State: AOAM532MOKH5uiInD5f6lA3PKIOIK8OO+bU3QgOw9Ds0E7PnaWiuOPqW
        +3Ni/3tEYvS1RNYXGnAA8X9aY/jR6V02Lg==
X-Google-Smtp-Source: ABdhPJwwJkGsA2x3Q0+Q/BF/iHZGynYf+r8CsGUnZDgJHg9s6YyCkeFq/+5D7e+hUqvgC2PRnzGf6Q==
X-Received: by 2002:a17:907:3f17:b0:6da:68b6:7876 with SMTP id hq23-20020a1709073f1700b006da68b67876mr8267076ejc.740.1647000104652;
        Fri, 11 Mar 2022 04:01:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f3-20020a056402004300b004162aa024c0sm3168407edu.76.2022.03.11.04.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 04:01:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSdxm-000zqr-KR;
        Fri, 11 Mar 2022 13:01:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v6 01/11] t2501: add various tests for removing the
 current working directory
Date:   Fri, 11 Mar 2022 12:57:35 +0100
References: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
 <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
 <1fd76d4f8a8c98d3c78c94cc8f3d36c335bd3bfb.1639026515.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <1fd76d4f8a8c98d3c78c94cc8f3d36c335bd3bfb.1639026515.git.gitgitgadget@gmail.com>
Message-ID: <220311.86tuc4hf4p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 09 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> [...]
> +test_expect_success 'git version continues working from a deleted dir' '
> +	mkdir tmp &&
> +	(
> +		cd tmp &&
> +		rm -rf ../tmp &&
> +		git version
> +	)
> +'

There's a (minor) regression here in v2.35.0 on AIX (as of 8a0d52dfd87
(t2501: add various tests for removing the current working directory,
2021-12-09)). The tooling on that OS will also refuse to remove the cwd:
    
    + mkdir tmp
    + cd tmp
    + rm -rf ../tmp
    rm: Cannot remove the current directory ../tmp.
    error: last command exited with $?=2
    not ok 21 - git version continues working from a deleted dir
    #

Just splitting that into a prereq that checks if the first two lines of
the sub-shell works should be a solution in this case, but I only had
time for this quick bug report :)
