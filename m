Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66D4C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 03:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242143AbhLVDcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 22:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbhLVDcK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:32:10 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ABEC061574;
        Tue, 21 Dec 2021 19:32:10 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f5so3004919edq.6;
        Tue, 21 Dec 2021 19:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=UnN5FpR6B16nL647aWR7O7c3lirMr4f+7u4JzW7tQiw=;
        b=g8FzUDwplh8FUfJMO9UpCApXdwVrKKNOp0M6zbPyOVNAUeqKrKfNEDU0rnuV8BjD9U
         V7RYiPDQEMK41ev0FexvTehVFfMl+xYDazoHjUulhjXOxfg3LH04DKjATRjbXBe/BzqF
         ZX0mSTQZ5uSEJepZvqN50YkPbfF+F9CCpWNfeo1nxNFR0jxXQEIJDz5z9MiOQ4GE/hrN
         /NmWTWmm2nFEChw0W66QhgWUKn5t5e/o2zcH0Q7OXGVfFiyZpvsIiyNibn9XkKM7ZuDX
         H47qjJfwSX4d905Xt/xCLWXJ/2o4UQr/KflqUJvS2wAZlBQShAcbNfPbscmg80r3XDaZ
         2J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=UnN5FpR6B16nL647aWR7O7c3lirMr4f+7u4JzW7tQiw=;
        b=ZK/ZZRZFeg/fRkKEvm58GjNQisLgcxcjWuuY5rPXAXAC/ZwfBWLvEb/1FSeAhocatg
         MhJZlzCMpIvmezU6g8J09bw+o6zBpqgGUlCyRQrFy0DiQ4UNcI46UaW+ngUAEBZA/XMa
         TZ0yAKVE83ysWu12JrR8LBLZDZ0GbCev0FRFGRzP+hIMegYJfhciJLuof76aT1BaEdBZ
         rndlYF3iu0cyfy2ISmgqSmk94chLOpUqVRl5bNr/b8tCfXste7DEWxYRaDmzdpR6QLS3
         vGipELqoXwESQnQRA5b8lWyzTpqg15LAXT78kzLmkr5FV6yATXLAzDfgGFqsaM16260C
         Pm8w==
X-Gm-Message-State: AOAM530Jq/H9gB/BbWZbjItjVTfnxDUzZk3DRha3kjwAC3gS+7Q7D433
        HO2qir2qFWDCMuoqqncoBSEB4/o1f7znEw==
X-Google-Smtp-Source: ABdhPJwFBt01OpXOKJ1xKExAk42HPqDmShR+tQrCyPuXzEJftSmfCXnYE6vG9+1cfqnYGdt7mpHp0w==
X-Received: by 2002:a17:907:171d:: with SMTP id le29mr979509ejc.626.1640143928544;
        Tue, 21 Dec 2021 19:32:08 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a14sm216308edt.95.2021.12.21.19.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:32:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzsMJ-0014ix-A8;
        Wed, 22 Dec 2021 04:32:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, jonathantanmy@google.com, steadmon@google.com,
        chooglen@google.com, calvinwan@google.com,
        workflows@vger.kernel.org
Subject: Re: Review process improvements
Date:   Wed, 22 Dec 2021 04:26:39 +0100
References: <YbvBvch8JcHED+A9@google.com>
 <20211217183942.npvkb3ajnx6p5cbp@meerkat.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211217183942.npvkb3ajnx6p5cbp@meerkat.local>
Message-ID: <211222.86ee65pb60.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 17 2021, Konstantin Ryabitsev wrote:

> [...]
>    - on the receiving end, the patches will be written to a dedicated
>      lore.kernel.org feed *as-is*, but also sent to the recipients after doing
>      the usual From/Reply-To substitution and moving the original From into
>      the in-body git headers (i.e. same as GGG does).

That GGG does this is one reason I haven't considered using it. It
breaks all sorts of E-Mail workflow assumptions from polluting the
address book for every person who uses it, to any "from:<addr>" search
needing special consideration etc.

Of course you'd need authentication etc, but is there a reason for why
such tooling can't work more like an SMTP relay and less like GGG which
(for some reason) insists on taking over the "From" header?

I think in its case it's because it wanted to mirror all the discussion
to GitHub. But presumably a ML-native tool won't have that problem (and
presumably GGG could do the same mirroring by following the ML after
submission).

