Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10ACC200B9
	for <e@80x24.org>; Tue, 22 May 2018 17:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeEVRti (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 13:49:38 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:40196 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeEVRth (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 13:49:37 -0400
Received: by mail-wm0-f41.google.com with SMTP id j5-v6so2056878wme.5
        for <git@vger.kernel.org>; Tue, 22 May 2018 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=hkEkl6IWTwvHPhfG87l6wVpigEnv1R2Bs80I0nsrh2M=;
        b=Uy9mvR8C+9ROfpm+t2i4YrpOFHmbXHsR5M9pV27n7S1zmOYwK0eDxOnKvRRr4DYHd9
         mCUuGXeqbIZJrrTrk/epZK+066WXLfbk0Yb6nQoAbdBJ15b5l+eKOW31owzPedG6QQi2
         Evlk43jxVHa6R4mMmUc691VcE3a1DTAIGtLFkWy2vykFyZxx83U6LqajmNFxtczzH4pw
         g178UpPuW3S8XufQ7ckXrm4AWF5fzpkgNP9EyiEEzibtnjB/fMOwmq+yj8T7QQ/QFBJa
         uLFxOYjDaeILi/jhCPBTTrNYAXZOpqaZt3NkxgC3RNZ0VYVnHYZT99IFgBmKgtSwdyRv
         HfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=hkEkl6IWTwvHPhfG87l6wVpigEnv1R2Bs80I0nsrh2M=;
        b=W7CI8VUAdFfYC7TvMHrDeW2qCOI5Fx13+HC1wwP7Eo5k4IbBKU5n8nt9AP9yRDjpSR
         bUUPRgDI6vWGnn5dt6/qV6gNJF3hXTo2FFbQMUsdbczAnPtJgcFk6cA0sZTClgVMIlal
         6MSbkCF6MQ3bHfq4g5tFG46UhpgeBD1+c/Z0yxTFSxJa0bT56Qimj4PSXzLQM8w4l14N
         zRAjDDJsjLR4MwpVhrGTpDwy5MS/RiKmwdAGxMnbF8KEpRHs2VVKScJSWY2Ya9EEQVA2
         V2ZZGrKd+Q2ZgI+aphst7cr5KgQb/Q75ds/+gmRWnzfcawykGemPmGpqfWJSJxizDjQW
         d02g==
X-Gm-Message-State: ALKqPwdB2cnJiS8AGyftDeqeWRJvy2lm46eBwj6uC8REEtHH2/pwfEQj
        Jxu3wtgDJxDGSFduqcfxcKI=
X-Google-Smtp-Source: AB8JxZqygRhcdGF/yisrTLxvXKN7BotPwmGjgaSATC7dLtK4rSEJZzKFwfTAiv088mkkoqG5qs3FvA==
X-Received: by 2002:a50:b485:: with SMTP id w5-v6mr3585371edd.100.1527011375911;
        Tue, 22 May 2018 10:49:35 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id v17-v6sm9100248edl.47.2018.05.22.10.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 10:49:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     pclouds@gmail.com, ao2@ao2.it, bmwill@google.com,
        git@vger.kernel.org, gitster@pobox.com
Subject: Why do we have both x*() and *_or_die() for "do or die"?
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
        <20180516222118.233868-1-sbeller@google.com>
        <20180516222118.233868-3-sbeller@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180516222118.233868-3-sbeller@google.com>
Date:   Tue, 22 May 2018 19:49:33 +0200
Message-ID: <874liz8tsi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 16 2018, Stefan Beller wrote:

> A common pattern with the repo_read_index function is to die if the return
> of repo_read_index is negative.  Move this pattern into a function.

Just a side-question unrelated to this patch per-se, why do we have both
x*() and *_or_die() functions in the codebase? I can't find any pattern
for one or the other, e.g. we have both xopen() and then write_or_die(),
so it's not a matter of x*() just being for syscalls and *_or_die()
being for our own functions (also as e.g. strbuf uses x*(), not
*_or_die()).

I'm not trying to litigate the difference and understand it could have
just emerged organically. I'm just wondering if that's the full story or
if one is preferred, or we prefer one or the other in some
circumstances.
