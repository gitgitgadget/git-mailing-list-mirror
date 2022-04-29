Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71536C433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 20:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380812AbiD2UfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 16:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380669AbiD2UfR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 16:35:17 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678C465402
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 13:31:58 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id a5so6180085qvx.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 13:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+VxP2AVM5ujXPkGJTdTg72o+unsMTKf/XK+WxH9a70I=;
        b=HgpG9chrrNSmT+umqJtbF5mNagRNLqZKWl207nxAo2JAzdYQyN71T7yZDUXH0Ku5o+
         vKZhwp4HvKC3/z7yjwL15l+jzP78Unz7PsmGxcrk+n+Q3jx2ySS+N4vf+OqSCZjK57SD
         Rh+q6G/kTsEU4/rxt+Bcr8KCpknhvoTgz24hmwUFVzdWC/ryU8Zp02GkQf00GZ3EB9jr
         5umREwUnwg9ZkIDaMvAurLKxn9RM+m6Sl62Oh8Xstdh3YJvHBzORiBASzCM8HXtd85Xd
         J6Tzy1x0vsjqG8BrMraHHFTRobQk4egiG1MSHandUKBrXqZgW6TLhzmhNWBn1xfdliYs
         T9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+VxP2AVM5ujXPkGJTdTg72o+unsMTKf/XK+WxH9a70I=;
        b=QqOtysnfk05q7vj8Yjj65BBsAKRKtTKDhrEeR75TzWx+ohAm9rNvjHeNQD4h7hraRO
         5wd3FZWSQI1vEhT/dwZuvSEbMUEKKqJfzOZCTzOPbxzeYfUG+Q60lJEGZiX7+kpgf/BA
         7+nx3H4FUtxWi7P83FzPhUzbiWjdkYYLY6T9aetzCeyIteFF+Y8roZJSXva3a3dBiqO2
         BZu6EjhU9g41ZBXYFeT1y2c8XjZ8JE+6NmDioGFsxcrAIszb6PTwcMCx2RLuezAhvAaB
         sY5Rj3gMrZO72rFll3XRSTyAakSUZ50XrrOFG6nGAI+LewOWyVVWWfCqLA+suMVsT0JM
         2Bbg==
X-Gm-Message-State: AOAM530sN8ZcBgtYSj/iinTFc98CnJ+EXEe5Zma7Eg7OAR4vQmBUagWI
        /60y1kQnEqUPM7rFDuS9CmjZrFaFjFo=
X-Google-Smtp-Source: ABdhPJyhhVPwJApW9rMeYDaPxrZ8ljwuReIDK3TdG4HxZ6mWiNpdJgHwsKITu/5gybREqxVNMswEQw==
X-Received: by 2002:a0c:e2cd:0:b0:456:568c:6697 with SMTP id t13-20020a0ce2cd000000b00456568c6697mr730909qvl.14.1651264317386;
        Fri, 29 Apr 2022 13:31:57 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id o26-20020a05620a111a00b0069fc13ce242sm110732qkk.115.2022.04.29.13.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 13:31:57 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:31:55 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jack Adrian Zappa <adrianh.bsc@gmail.com>
Cc:     git-mailing-list <git@vger.kernel.org>
Subject: Re: git not compiling under MSYS2
Message-ID: <20220429203155.ve5iemdgr6mualvp@carlos-mbp.lan>
References: <CAKepmajpJ0Nhr0SPNicg6djhH36f+dT_SHrb7pOEK7J0eXYuFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKepmajpJ0Nhr0SPNicg6djhH36f+dT_SHrb7pOEK7J0eXYuFA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2022 at 02:40:14PM -0400, Jack Adrian Zappa wrote:
> Anyone have any idea why it's not building?

because the codebase doesn't support that environment yet AFAIK.

I'd been successful building git in windows with MinGW64 gcc (both 64
and 32 bit), Visual Studio's cl and even the clang that comes as an option
in that last one (which uses the clang-cl interface)

If you want to build it in an MSYS2 like environment the best option is to
use the Git for Windows SDK[1] which AFAIK is based on one of the MSYS2
variants (most likely the one with gcc and the old crt)

Carlo

[1] https://github.com/git-for-windows/build-extra/releases/tag/git-sdk-1.0.8
