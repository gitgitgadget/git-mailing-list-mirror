Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1B8C433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 22:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349659AbiEPWZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 18:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiEPWZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 18:25:09 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2627B2B244
        for <git@vger.kernel.org>; Mon, 16 May 2022 15:25:08 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id a22so13377430qkl.5
        for <git@vger.kernel.org>; Mon, 16 May 2022 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qXzep1ott7XmExb4Alz2/uDsp7Ld6DqSGBu/4i57uSc=;
        b=UQLnZBuGIWtSehrlafNNigmBTwvzCX+FxkxDEiANkU0+0pKVzmLS44MaKqb1oyDHgb
         54keWVkYqZ/x+mcmEuON6avSNyc+xAFAXIa9rqbTxUcSp69Rc1+uFAQEn9bZLbvMrvBa
         LPf0LZQKrYU6WCDVrzp7nQK/5RpU63uhc4dk/bdYpR9PxDqrgbwERlBpQPdpeoBpqZVT
         bHwAwMFT+WrXEbJ27ac9e0NPxjvYlQ20ynwbGJ7n8xI5IkXI18BbR2KwWZVqc/IsBbsz
         Gg3TPrPPVapFa3Lf5LNEaQ0J6HGVX/8q0hOC3zqBpdrl7wx63+jPiK1xUz2RbghNbZel
         6hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qXzep1ott7XmExb4Alz2/uDsp7Ld6DqSGBu/4i57uSc=;
        b=kNMuX5aVSkszKs+vbh2qvkOhFWdowCJvZZvmsDQhxBJ+vsYCGeIbSdhCsYLOYHoEF7
         XTi8Vjw0Ipqzy6sbsCggJh5CQq5wi5pHDZ1QU47SZauF3Kqgnu6OwoZXGfb+mKWIQNPF
         2nRZ2Fwo2S6rzAn6lhrGc67rad3o0Ar5eov2UBPyxE9tWafFzDKDsiQbtnbGSkAilYpA
         A/Lp7A8HMUedsIWzaOXQp0ADxAf4J2O9FTHFSHDUz+x12O9m/vcSa50mq68coKBD0Ybt
         X1abiCFgBeS4pQTJGbC+mt68kzF4ML8LGZ+z61rF/2vfaaX6F9+AkC8rS5DQ0JHrcE12
         scNw==
X-Gm-Message-State: AOAM5317EzhYs31tr6CKdrt2Q/uIK7dNg/HxcDPCnIf1cpc/Y2A9KH5I
        LkE9mE7BlhWdiXeWquLs6Y3qKg==
X-Google-Smtp-Source: ABdhPJx9eUH5lb4VsIgq1D1/EKLdjPV5hKxpYUSTFeV+aEF+0wUrYyHkBv3MIY2bpK1pbAffJYZbag==
X-Received: by 2002:a05:620a:f03:b0:67e:1e38:3a90 with SMTP id v3-20020a05620a0f0300b0067e1e383a90mr14122797qkl.442.1652739907202;
        Mon, 16 May 2022 15:25:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w184-20020a3794c1000000b0069fc13ce1e2sm6732212qkd.19.2022.05.16.15.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:25:06 -0700 (PDT)
Date:   Mon, 16 May 2022 18:25:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2 1/2] setup.c: make bare repo discovery optional
Message-ID: <YoLPQVAnOOX0AZ2v@nand.local>
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
 <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
 <22b10bf9da8ccf4ae4da634aadfdaff5ee7a3508.1652485058.git.gitgitgadget@gmail.com>
 <e5139922-9b74-ebfa-756c-629918e0456b@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e5139922-9b74-ebfa-756c-629918e0456b@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 16, 2022 at 02:46:55PM -0400, Derrick Stolee wrote:
> On 5/13/2022 7:37 PM, Glen Choo via GitGitGadget wrote:
> > From: Glen Choo <chooglen@google.com>
> >
> > Add a config variable, `discovery.bare`, that tells Git whether or not
> > it should work with the bare repository it has discovered i.e. Git will
> > die() if it discovers a bare repository, but it is not allowed by
> > `discovery.bare`. This only affects repository discovery, thus it has no
> > effect if discovery was not done (e.g. `--git-dir` was passed).
>
> > This config is an enum of:
> >
> > - ["always"|(unset)]: always recognize bare repositories (like Git does
> >   today)
> > - "never": never recognize bare repositories
> >
> > More values are expected to be added later, and the default is expected
> > to change (i.e. to something other than "always").
>
> I think it is fine to include the "never" option for users to opt-in to
> this super-protected state, but I want to make it very clear that we
> should never move to it as a new default. This phrasing of 'something
> other than "always"' is key, but it might be good to point out that
> "never" is very unlikely to be that default.

I am confused, then.

What does a user who has some legitimate (non-embedded) bare
repositories do if they are skeptical of other bare repositories? I
suspect the best answer we would be able to provide with these patches
is "use `--git-dir`".

What happens to a user who has a combination of legitimate bare
repositories, embedded bare repositories that they trust, and other
embedded bare repositories that they don't?

As far as I can tell, our recommendation with these tools would be to:

  - run `git config --global discovery.bare never`, and
  - include `--git-dir=$(pwd)` in any git invocations in bare
    repositories that they do trust

This gets at my concerns from [1] and [2] (mostly [2], in this case)
that we're trying to close the embedded bare repos problem with an
overly broad solution, at the expense of usability.

I can't shake the feeling that something like I described towards the
bottom of [2] would give you all of the security guarantees you're after
without compromising on usability for non-embedded bare repositories.

I'm happy to explore this direction more myself if you don't want to. I
would just much rather see us adopt an approach that doesn't break more
use-cases than it has to if such a thing can be avoided.

I cannot endorse these patches as-is.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/Ylobp7sntKeWTLDX@nand.local/
[2]: https://lore.kernel.org/git/YnmKwLoQCorBnMe2@nand.local/
